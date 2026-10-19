# IVF Outcome Analysis

An exploratory analysis project examining IVF treatment data with Python and SQL, with a four-page Power BI dashboard covering patient characteristics, treatment measures, embryo quality, and outcomes.

## Dashboard Preview

![Page 1: IVF dashboard overview](Dashboard/Page%201.jpeg)

The remaining dashboard page screenshots are in [`Dashboard/`](Dashboard/). The Power BI report file is not included in this public repository.

## Project Contents

- `python/`: four dataset-specific analysis scripts and the shared cleaning and EDA module.
- `Sql/`: SQL data-quality and exploratory-analysis queries for the four datasets (Dataset 2 has separate mother, offspring, and Elisa tables).
- `Dashboard/`: four exported dashboard page screenshots.

The analyses cover missing and blank values, duplicate records, categorical-value consistency, numeric ranges, potential outliers, and relationships between variables. The Python workflow also exports cleaned copies, data-quality and review tables, descriptive summaries including the four moments, correlations, group summaries, date trends where available, and numeric distribution plots.

## Python Setup

Tested with Python 3.12.3. From a terminal, move into the `python` directory and install the required packages:

```bash
cd python
python -m pip install pandas numpy matplotlib openpyxl
```

Place the input CSV files in `python/datasets/` using these exact names:

| Script | Required input file(s) |
| --- | --- |
| `dataset1.py` | `Dataset_1.csv` |
| `dataset2.py` | `Dataset_2_offspring.csv`, `Dataset_2_mother.csv`, `Dataset_2_elisa.csv` |
| `dataset3.py` | `Dataset_3.csv` |
| `dataset4.py` | `Dataset_4.csv` |

Run an analysis from the `python` directory, for example:

```bash
python dataset1.py
```

Run `dataset2.py`, `dataset3.py`, or `dataset4.py` in the same way. Results are written under `python/eda_results/`. Input datasets are not included in this repository.

## SQL Analysis

The SQL files contain queries, not data-loading scripts. Load the corresponding data into a MySQL-compatible database first, then run the relevant file against tables named `dataset1`, `dataset2_elisa`, `dataset2_mother`, `dataset2_offspring`, `dataset3`, and `dataset4`.

The queries use MySQL-style syntax, including backtick-quoted identifiers, `DESCRIBE`, `REGEXP`, and `STDDEV`.

## Data Privacy

This project concerns sensitive health-related data. Raw datasets and the data-filled Power BI report are intentionally omitted from this public repository. Do not publish identifiable or otherwise sensitive records. The dashboard screenshots are included as visual examples only; they are not interactive reports.

## License

This project is released under the MIT License. See [`LICENSE`](LICENSE).
