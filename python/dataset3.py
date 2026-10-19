"""Python-only cleaning checks and exploratory analysis for dataset 3."""

from pathlib import Path
import re
import sys

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from eda_common import run_eda


BASE_DIR = Path(__file__).resolve().parent
DEFAULT_FILES = [BASE_DIR / "datasets" / "Dataset_3.csv"]
OUTPUT_DIR = BASE_DIR / "eda_results" / "dataset3"


def safe_name(value: object) -> str:
	"""Make a short filesystem-safe name."""
	name = re.sub(r"[^A-Za-z0-9_-]+", "_", str(value)).strip("_")
	return name[:70] or "unnamed"


def analyze_sheet(frame: pd.DataFrame, workbook: Path, sheet_name: str) -> None:
	"""Inspect one worksheet and save its quality and EDA outputs."""
	label = f"{workbook.stem}__{sheet_name}"
	output = OUTPUT_DIR / safe_name(label)
	output.mkdir(parents=True, exist_ok=True)
	df = frame.copy()

	print(f"\n{'=' * 78}\n{label}: {len(df):,} rows x {len(df.columns):,} columns")
	print("Column types:\n", df.dtypes.to_string())

	quality_rows = []
	nulls = df.isna().sum()
	for column in df.columns:
		series = df[column]
		row = {
			"column": str(column),
			"dtype": str(series.dtype),
			"null_count": int(nulls[column]),
			"null_percent": float(nulls[column] / len(df) * 100) if len(df) else 0.0,
			"distinct_values": int(series.nunique(dropna=True)),
			"leading_trailing_whitespace": 0,
			"case_or_whitespace_variants": 0,
			"mixed_python_types": 0,
			"mixed_numeric_text_values": 0,
			"date_parse_failures": 0,
			"excel_error_values": 0,
		}
		if pd.api.types.is_object_dtype(series) or pd.api.types.is_string_dtype(series):
			text = series.dropna().astype(str)
			row["leading_trailing_whitespace"] = int((text != text.str.strip()).sum())
			normalized = text.str.strip().str.casefold()
			row["case_or_whitespace_variants"] = int(
				text.groupby(normalized).nunique().gt(1).sum()
			)
			row["mixed_python_types"] = int(series.dropna().map(type).nunique() > 1)
			row["excel_error_values"] = int(
				text.str.match(r"^#(REF!|DIV/0!|VALUE!|N/A|NAME\?|NUM!|NULL!)$", case=False).sum()
			)
			numeric = pd.to_numeric(series, errors="coerce")
			row["mixed_numeric_text_values"] = int(
				numeric.notna().any() and numeric.isna().any() and series.notna().any()
			)
		name_suggests_date = bool(re.search(r"date|time|year|month", str(column), re.I))
		if name_suggests_date and not pd.api.types.is_datetime64_any_dtype(series):
			parsed = pd.to_datetime(series, errors="coerce")
			row["date_parse_failures"] = int((series.notna() & parsed.isna()).sum())
		quality_rows.append(row)

	quality = pd.DataFrame(quality_rows)
	quality.to_csv(output / "quality_checks.csv", index=False)
	duplicates = df[df.duplicated(keep=False)]
	duplicates.to_csv(output / "duplicate_records.csv", index=False)
	print(f"Exact duplicate rows: {int(df.duplicated().sum()):,}")
	print("Missing values by column:\n", nulls.to_string())
	print("Quality checks saved to:", output)

	numeric = df.select_dtypes(include="number")
	if not numeric.empty:
		moments = numeric.describe().T.rename(columns={"50%": "median"})
		moments["variance"] = numeric.var()
		moments["skewness"] = numeric.skew()
		moments["excess_kurtosis"] = numeric.kurtosis()
		moments["sum"] = numeric.sum(min_count=1)
		moments.to_csv(output / "numeric_moments.csv")
		numeric.corr(method="pearson").to_csv(output / "numeric_correlations.csv")
		print("Numeric summary (count, mean, std, min/max, skew, excess kurtosis):\n", moments.to_string())

		plot_columns = list(numeric.columns[:12])
		axes = numeric[plot_columns].hist(figsize=(12, max(3, 2.7 * len(plot_columns))), bins=25)
		plt.suptitle(f"{label} — numeric distributions")
		plt.tight_layout()
		plt.savefig(output / "numeric_distributions.png", dpi=150)
		plt.close("all")

	categorical = df.select_dtypes(exclude="number")
	for column in categorical.columns:
		counts = df[column].value_counts(dropna=False).rename_axis("value").reset_index(name="count")
		counts.to_csv(output / f"values_{safe_name(column)}.csv", index=False)

	date_columns = []
	for column in df.columns:
		if pd.api.types.is_datetime64_any_dtype(df[column]):
			date_columns.append(column)
		elif re.search(r"date|time|year|month", str(column), re.I):
			parsed = pd.to_datetime(df[column], errors="coerce")
			if parsed.notna().sum() >= max(2, int(df[column].notna().sum() * 0.8)):
				df[f"__parsed_date_{safe_name(column)}"] = parsed
				date_columns.append(f"__parsed_date_{safe_name(column)}")
	if date_columns:
		date_column = date_columns[0]
		dates = pd.to_datetime(df[date_column], errors="coerce")
		trend_data = df.loc[dates.notna()].copy()
		trend_data["period"] = dates[dates.notna()].dt.to_period("M").astype(str).to_numpy()
		measures = list(numeric.columns)
		if measures:
			trend_data.groupby("period")[measures].mean().to_csv(output / "monthly_numeric_trends.csv")
		trend_data.groupby("period").size().rename("row_count").to_csv(output / "monthly_record_counts.csv")


def main() -> None:
	files = [Path(arg) for arg in sys.argv[1:]] if len(sys.argv) > 1 else DEFAULT_FILES
	resolved_files = [path if path.is_absolute() else BASE_DIR / path for path in files]
	run_eda(resolved_files, OUTPUT_DIR)


if __name__ == "__main__":
	main()
