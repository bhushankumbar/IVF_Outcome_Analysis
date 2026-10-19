"""Shared Python-only cleaning, validation, and EDA functions for project scripts."""

from __future__ import annotations

import re
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd


MISSING_TEXT = {"", "na", "n/a", "null", "none", "nan"}
BOOLEAN_TOKENS = {"0", "1", "yes", "no", "y", "n", "true", "false"}
UNKNOWN_TOKENS = {"not stated", "unknown", "unspecified", "not applicable", "n/a", "na", "", "nan"}
EXCEL_ERRORS = {"#ref!", "#div/0!", "#value!", "#n/a", "#name?", "#num!", "#null!"}


def safe_name(value: object) -> str:
    """Return a filesystem-safe name."""
    name = re.sub(r"[^A-Za-z0-9_-]+", "_", str(value)).strip("_")
    return name[:72] or "unnamed"


def load_table(path: Path) -> pd.DataFrame:
    """Read a CSV or Excel sheet; account for the two-row headers in dataset 2."""
    if path.suffix.lower() == ".csv":
        header = 1 if path.name.lower() in {"dataset_2_mother.csv", "dataset_2_offspring.csv"} else 0
        frame = pd.read_csv(path, header=header, encoding="utf-8-sig", low_memory=False)
    elif path.suffix.lower() in {".xlsx", ".xls"}:
        frame = pd.read_excel(path)
    else:
        raise ValueError(f"Unsupported input type: {path.suffix}; use CSV or Excel.")
    frame.columns = [str(column).strip() for column in frame.columns]
    return frame


def clean_safely(frame: pd.DataFrame) -> tuple[pd.DataFrame, int, int, list[dict[str, object]]]:
    """Normalize whitespace, unify case-only labels, and infer numeric text conservatively."""
    cleaned = frame.copy()
    whitespace_fixes = 0
    actions: list[dict[str, object]] = []
    for column in cleaned.columns:
        series = cleaned[column]
        if pd.api.types.is_object_dtype(series) or pd.api.types.is_string_dtype(series):
            text = series.astype("string")
            stripped = text.str.strip()
            trimmed_count = int((series.notna() & (text != stripped)).sum())
            whitespace_fixes += trimmed_count
            normalized = stripped.mask(stripped.str.casefold().isin(MISSING_TEXT), pd.NA)
            case_map: dict[str, str] = {}
            for value in normalized.dropna().astype(str):
                case_map.setdefault(value.casefold(), value)
            variants_fixed = 0
            for key, canonical in case_map.items():
                variants_fixed += int((normalized.str.casefold() == key).sum() - (normalized == canonical).sum())
            normalized = normalized.map(lambda value: case_map.get(value.casefold(), value) if pd.notna(value) else pd.NA).astype("string")
            if trimmed_count:
                actions.append({"column": str(column), "action": "Trim leading/trailing whitespace", "cells_affected": trimmed_count, "reason": "Safe text normalization"})
            if variants_fixed:
                actions.append({"column": str(column), "action": "Standardize case-only category variants", "cells_affected": variants_fixed, "reason": "Labels differed only by capitalization; first-seen spelling retained"})

            numeric = pd.to_numeric(normalized, errors="coerce")
            non_null_count = int(normalized.notna().sum())
            numeric_count = int(numeric.notna().sum())
            if non_null_count and numeric_count == non_null_count:
                cleaned[column] = numeric
                if numeric_count:
                    actions.append({"column": str(column), "action": "Convert numeric-like text to numeric dtype", "cells_affected": numeric_count, "reason": "All non-missing values parse as numbers"})
            elif non_null_count and numeric_count / non_null_count >= 0.8:
                invalid_count = int((normalized.notna() & numeric.isna()).sum())
                actions.append({"column": str(column), "action": "Preserve mixed numeric/text values; analyze numeric subset and report text values", "cells_affected": invalid_count, "reason": f"{numeric_count}/{non_null_count} non-missing values parse as numbers; original mixed values retained"})
                cleaned[column] = normalized
            else:
                cleaned[column] = normalized
    empty_rows = int(cleaned.isna().all(axis=1).sum())
    if empty_rows:
        cleaned = cleaned.dropna(how="all").reset_index(drop=True)
        actions.append({"column": "<entire row>", "action": "Remove fully empty rows", "cells_affected": empty_rows, "reason": "No values in any column"})
    return cleaned, whitespace_fixes, empty_rows, actions


def _date_parse(series: pd.Series) -> pd.Series:
    """Parse dates without assuming ambiguous day/month ordering unless needed."""
    try:
        return pd.to_datetime(series, errors="coerce", format="mixed", dayfirst=True)
    except (TypeError, ValueError):
        return pd.to_datetime(series, errors="coerce", dayfirst=True)


def _plausible_range(column: object) -> tuple[float | None, float | None]:
    """Return conservative plausibility bounds for fields whose units are explicit."""
    name = str(column).casefold()
    if "apgar" in name:
        return 0, 10
    if re.search(r"\bage\b|age[_ (]", name):
        return 10, 80
    if "bmi" in name or "body_mass_index" in name:
        return 10, 80
    if "week" in name and ("birth" in name or "ga" in name):
        return 20, 45
    if "gestational age" in name or "ga(weeks" in name:
        return 20, 45
    if ("fertilization(%)" in name or "good-quality embryo(%)" in name
            or "percent" in name or "percentage" in name):
        return 0, 100
    return None, None


def _quality_report(original: pd.DataFrame, cleaned: pd.DataFrame) -> pd.DataFrame:
    rows: list[dict[str, object]] = []
    for column in cleaned.columns:
        series = cleaned[column]
        raw = original[column] if column in original.columns else series
        text_values = series.dropna().astype(str)
        norm = text_values.str.strip().str.casefold()
        source_text = raw.dropna().astype(str)
        source_norm = source_text.str.strip().str.casefold()
        normalized_variants = source_text.groupby(source_norm).nunique()
        category_variant_count = int(normalized_variants.gt(1).sum())
        whitespace_count = int((source_text != source_text.str.strip()).sum())
        numeric_candidate = pd.to_numeric(raw, errors="coerce")
        mixed_numeric_text = bool(
            series.notna().any()
            and numeric_candidate.notna().any()
            and numeric_candidate.isna().any()
            and (pd.api.types.is_object_dtype(raw) or pd.api.types.is_string_dtype(raw))
        )
        name = str(column)
        date_like = bool(re.search(r"date|time", name, re.I))
        parsed_dates = _date_parse(series) if date_like else pd.Series(pd.NaT, index=series.index)
        date_failures = int((series.notna() & parsed_dates.isna()).sum()) if date_like else 0
        expected_binary = bool(re.search(r"(^is_|^was_|live birth|neonatal death|abortion|twin|triplet|miscarriage|clinical pregnancy|biochemical|ectopic|ongoing|screening|scratching|activation|hyaluronic|regular|all freeze|blast y/n)", name, re.I))
        normalized_values = set(norm.unique())
        binary_invalid = []
        if expected_binary:
            for value in normalized_values - BOOLEAN_TOKENS - UNKNOWN_TOKENS:
                numeric_value = pd.to_numeric(value, errors="coerce")
                if pd.isna(numeric_value) or numeric_value not in (0, 1):
                    binary_invalid.append(value)
            binary_invalid.sort()
        errors = sorted({value.casefold() for value in text_values if value.casefold() in EXCEL_ERRORS})
        numeric_values = numeric_candidate.dropna()
        lower_bound, upper_bound = _plausible_range(column)
        range_invalid_count = 0
        if lower_bound is not None:
            range_invalid_count += int((numeric_values < lower_bound).sum())
        if upper_bound is not None:
            range_invalid_count += int((numeric_values > upper_bound).sum())
        outlier_count = 0
        if numeric_values.size >= 4:
            q1, q3 = numeric_values.quantile([0.25, 0.75])
            iqr = q3 - q1
            if iqr > 0:
                outlier_count = int(((numeric_values < q1 - 1.5 * iqr) | (numeric_values > q3 + 1.5 * iqr)).sum())
        rows.append({
            "column": name,
            "source_dtype": str(raw.dtype),
            "cleaned_dtype": str(series.dtype),
            "non_null_count": int(series.notna().sum()),
            "null_count": int(series.isna().sum()),
            "null_percent": round(float(series.isna().mean() * 100), 3) if len(series) else 0.0,
            "distinct_values": int(series.nunique(dropna=True)),
            "numeric_text_mixture_flag": mixed_numeric_text,
            "source_whitespace_value_count": whitespace_count,
            "unparseable_date_count": date_failures,
            "binary_value_domain_flags": len(binary_invalid),
            "unexpected_binary_values": " | ".join(binary_invalid),
            "category_case_whitespace_variant_groups": category_variant_count,
            "excel_error_value_count": len(errors),
            "negative_numeric_count": int((numeric_values < 0).sum()),
            "plausibility_range_min": lower_bound,
            "plausibility_range_max": upper_bound,
            "implausible_range_count": range_invalid_count,
            "iqr_potential_outlier_count": outlier_count,
        })
    return pd.DataFrame(rows)


def _numeric_summary(frame: pd.DataFrame) -> pd.DataFrame:
    numeric = _numeric_analysis_frame(frame)
    if numeric.empty:
        return pd.DataFrame(columns=["column", "count", "sum", "mean", "median", "mode", "min", "max", "variance", "std", "skewness", "excess_kurtosis"])
    result = pd.DataFrame({
        "count": numeric.count(),
        "sum": numeric.sum(min_count=1),
        "mean": numeric.mean(),
        "median": numeric.median(),
        "mode": numeric.mode(dropna=True).iloc[0] if not numeric.mode(dropna=True).empty else np.nan,
        "min": numeric.min(),
        "max": numeric.max(),
        "variance": numeric.var(),
        "std": numeric.std(),
        "skewness": numeric.skew(),
        "excess_kurtosis": numeric.kurtosis(),
    })
    result.index.name = "column"
    return result.reset_index()


def _numeric_analysis_frame(frame: pd.DataFrame) -> pd.DataFrame:
    """Build numeric measures without altering mixed source values in cleaned data."""
    numeric = frame.select_dtypes(include="number").copy()
    for column in frame.columns:
        if pd.api.types.is_numeric_dtype(frame[column]):
            continue
        converted = pd.to_numeric(frame[column], errors="coerce")
        non_missing = int(frame[column].notna().sum())
        if non_missing and int(converted.notna().sum()) / non_missing >= 0.8:
            numeric[column] = converted
    return numeric


def analyze_file(path: Path, output_root: Path) -> dict[str, object]:
    """Clean one input conservatively, analyze it, and save auditable outputs."""
    source = load_table(path)
    clean, whitespace_fixes, empty_rows, cleaning_actions = clean_safely(source)
    output = output_root / safe_name(path.stem)
    output.mkdir(parents=True, exist_ok=True)

    duplicate_mask = clean.duplicated(keep=False)
    duplicate_rows = clean.loc[duplicate_mask].copy()
    duplicate_rows.to_csv(output / "possible_duplicate_records.csv", index=False, encoding="utf-8-sig")
    invalid_range_rows: list[pd.DataFrame] = []
    for column in clean.columns:
        lower_bound, upper_bound = _plausible_range(column)
        if lower_bound is None and upper_bound is None:
            continue
        values = pd.to_numeric(clean[column], errors="coerce")
        outside = values.notna() & ((values < lower_bound) if lower_bound is not None else False)
        if upper_bound is not None:
            outside |= values.notna() & (values > upper_bound)
        if outside.any():
            indexes = values.index[outside]
            invalid_range_rows.append(pd.DataFrame({"source_record_number": indexes.to_numpy() + 1, "column": str(column), "issue": f"Outside conservative plausibility bounds [{lower_bound}, {upper_bound}]; excluded from cleaned analysis as missing", "original_value": source.loc[indexes, column].astype(str).to_numpy()}))
            clean.loc[indexes, column] = np.nan
            cleaning_actions.append({"column": str(column), "action": "Set implausible value to missing in cleaned copy", "cells_affected": len(indexes), "reason": f"Outside conservative field bounds [{lower_bound}, {upper_bound}]; source value retained in values_requiring_review.csv"})
    clean.to_csv(output / "cleaned_data.csv", index=False, encoding="utf-8-sig")

    quality = _quality_report(source, clean)
    quality.to_csv(output / "quality_checks.csv", index=False, encoding="utf-8-sig")
    pd.DataFrame(cleaning_actions, columns=["column", "action", "cells_affected", "reason"]).to_csv(
        output / "cleaning_actions.csv", index=False, encoding="utf-8-sig"
    )
    anomaly_frames: list[pd.DataFrame] = []
    outlier_frames: list[pd.DataFrame] = []
    for column in clean.columns:
        raw = source[column]
        cleaned_values = clean[column]
        candidate = pd.to_numeric(raw, errors="coerce")
        if (pd.api.types.is_numeric_dtype(cleaned_values)
                or (candidate.notna().any() and candidate.notna().sum() / max(1, cleaned_values.notna().sum()) >= 0.8)):
            original_nonblank = raw.notna() & raw.astype("string").str.strip().ne("")
            failed_numeric = original_nonblank & pd.to_numeric(raw, errors="coerce").isna()
            if failed_numeric.any():
                anomaly = pd.DataFrame({"source_record_number": np.flatnonzero(failed_numeric.to_numpy()) + 1, "column": str(column), "issue": "Non-numeric value in predominantly numeric column", "original_value": raw.loc[failed_numeric].astype(str).to_numpy()})
                anomaly_frames.append(anomaly)
            values = candidate.dropna()
            if len(values) >= 4:
                q1, q3 = values.quantile([0.25, 0.75])
                iqr = q3 - q1
                if iqr > 0:
                    outlier_mask = (candidate < q1 - 1.5 * iqr) | (candidate > q3 + 1.5 * iqr)
                    outlier_mask &= candidate.notna()
                    if outlier_mask.any():
                        indexes = candidate.index[outlier_mask]
                        outlier_frames.append(pd.DataFrame({"source_record_number": indexes.to_numpy() + 1, "column": str(column), "value": candidate.loc[indexes].to_numpy(), "lower_iqr_fence": q1 - 1.5 * iqr, "upper_iqr_fence": q3 + 1.5 * iqr}))
        name = str(column)
        if re.search(r"(^is_|^was_|live birth|neonatal death|abortion|twin|triplet|miscarriage|clinical pregnancy|biochemical|ectopic|ongoing|screening|scratching|activation|hyaluronic|regular|all freeze|blast y/n)", name, re.I):
            tokens = cleaned_values.dropna().astype(str).str.strip().str.casefold()
            numeric_tokens = pd.to_numeric(tokens, errors="coerce")
            valid_binary = tokens.isin(BOOLEAN_TOKENS | UNKNOWN_TOKENS) | numeric_tokens.isin([0, 1])
            invalid = ~valid_binary
            if invalid.any():
                bad_index = tokens.index[invalid]
                anomaly_frames.append(pd.DataFrame({"source_record_number": bad_index.to_numpy() + 1, "column": name, "issue": "Unexpected value for binary-like field; needs domain review", "original_value": raw.loc[bad_index].astype(str).to_numpy()}))
    anomaly_frames.extend(invalid_range_rows)
    if anomaly_frames:
        pd.concat(anomaly_frames, ignore_index=True).to_csv(output / "values_requiring_review.csv", index=False, encoding="utf-8-sig")
    else:
        pd.DataFrame(columns=["source_record_number", "column", "issue", "original_value"]).to_csv(output / "values_requiring_review.csv", index=False, encoding="utf-8-sig")
    if outlier_frames:
        pd.concat(outlier_frames, ignore_index=True).to_csv(output / "potential_outlier_records.csv", index=False, encoding="utf-8-sig")
    else:
        pd.DataFrame(columns=["source_record_number", "column", "value", "lower_iqr_fence", "upper_iqr_fence"]).to_csv(output / "potential_outlier_records.csv", index=False, encoding="utf-8-sig")
    numeric_summary = _numeric_summary(clean)
    numeric_summary.to_csv(output / "numeric_summary_and_four_moments.csv", index=False, encoding="utf-8-sig")

    numeric = _numeric_analysis_frame(clean)
    if numeric.shape[1] >= 2:
        numeric.corr(method="pearson", min_periods=3).to_csv(output / "numeric_correlations.csv", encoding="utf-8-sig")
        numeric.corr(method="spearman", min_periods=3).to_csv(output / "numeric_rank_correlations.csv", encoding="utf-8-sig")

    categorical_rows: list[pd.DataFrame] = []
    categorical_columns = [column for column in clean.columns if not pd.api.types.is_numeric_dtype(clean[column])]
    for column in numeric.columns:
        values = numeric[column].dropna()
        if values.nunique() <= 20 and np.isclose(values, np.round(values)).all():
            if column not in categorical_columns:
                categorical_columns.append(column)
    for column in categorical_columns:
        counts = clean[column].astype("string").fillna("<MISSING>").value_counts(dropna=False)
        categorical_rows.append(pd.DataFrame({"column": str(column), "value": counts.index.astype(str), "count": counts.values}))
    if categorical_rows:
        pd.concat(categorical_rows, ignore_index=True).to_csv(output / "categorical_value_counts.csv", index=False, encoding="utf-8-sig")
    else:
        pd.DataFrame(columns=["column", "value", "count"]).to_csv(output / "categorical_value_counts.csv", index=False, encoding="utf-8-sig")

    group_frames: list[pd.DataFrame] = []
    for category in categorical_columns:
        if clean[category].nunique(dropna=True) > 12:
            continue
        for measure in numeric.columns:
            grouped = numeric[measure].groupby(clean[category], dropna=False).agg(["count", "mean", "median", "std", "min", "max", "sum"]).reset_index()
            grouped.insert(0, "measure", str(measure))
            grouped.insert(0, "group_column", str(category))
            group_frames.append(grouped.rename(columns={category: "group_value"}))
    if group_frames:
        pd.concat(group_frames, ignore_index=True).to_csv(output / "group_relationships.csv", index=False, encoding="utf-8-sig")

    date_columns = [column for column in clean.columns if re.search(r"date|time", str(column), re.I)]
    for date_column in date_columns:
        parsed = _date_parse(clean[date_column])
        valid = parsed.notna()
        if valid.sum() < 2 or valid.mean() < 0.8:
            continue
        trend = numeric.loc[valid].copy() if len(numeric.columns) else pd.DataFrame(index=clean.index[valid])
        trend["period"] = parsed.loc[valid].dt.to_period("M").astype(str).to_numpy()
        trend.groupby("period").size().rename("row_count").to_csv(output / f"monthly_record_trend_{safe_name(date_column)}.csv", encoding="utf-8-sig")
        if len(numeric.columns):
            trend.groupby("period")[list(numeric.columns)].mean().to_csv(output / f"monthly_numeric_trends_{safe_name(date_column)}.csv", encoding="utf-8-sig")

    if not numeric.empty:
        columns_to_plot = list(numeric.columns[:12])
        numeric[columns_to_plot].hist(figsize=(12, max(4, 2.7 * len(columns_to_plot))), bins=25)
        plt.suptitle(f"{path.stem}: numeric distributions")
        plt.tight_layout()
        plt.savefig(output / "numeric_distributions.png", dpi=140)
        plt.close("all")

    summary = {
        "file": path.name,
        "rows_original": len(source),
        "rows_after_empty_row_removal": len(clean),
        "columns": len(clean.columns),
        "exact_duplicate_rows_flagged": int(clean.duplicated().sum()),
        "duplicate_record_rows_listed": len(duplicate_rows),
        "whitespace_cells_trimmed": whitespace_fixes,
        "cleaning_actions_recorded": len(cleaning_actions),
        "fully_empty_rows_removed": empty_rows,
        "missing_cells_after_cleaning": int(clean.isna().sum().sum()),
        "numeric_columns": int(numeric.shape[1]),
        "categorical_columns": int(len(categorical_columns)),
        "outlier_cells_iqr_flagged": int(quality["iqr_potential_outlier_count"].sum()),
        "implausible_range_values_flagged": int(quality["implausible_range_count"].sum()),
        "binary_domain_flags": int(quality["binary_value_domain_flags"].sum()),
        "quality_output_folder": str(output),
    }
    return summary


def run_eda(files: list[Path], output_root: Path) -> None:
    """Run EDA for each dataset file and write a project-level summary."""
    missing = [path for path in files if not path.exists()]
    if missing:
        raise FileNotFoundError("Input files not found: " + ", ".join(str(path) for path in missing))
    output_root.mkdir(parents=True, exist_ok=True)
    summaries = [analyze_file(path, output_root) for path in files]
    pd.DataFrame(summaries).to_csv(output_root / "run_summary.csv", index=False, encoding="utf-8-sig")
    for row in summaries:
        print(
            f"{row['file']}: {row['rows_original']} rows, {row['columns']} columns; "
            f"{row['missing_cells_after_cleaning']} missing cells, "
            f"{row['exact_duplicate_rows_flagged']} duplicate rows flagged."
        )
    print(f"EDA reports saved under: {output_root}")
