# IVF Outcome Analysis

An end-to-end exploratory analysis of four IVF datasets, combining Python-based data cleaning and statistical analysis, SQL-based data validation and exploration, and a four-page Power BI dashboard.

## Dashboard Preview

![Page 1: IVF dashboard overview](Dashboard/Page%201.jpeg)

The other three dashboard page screenshots are kept in [`Dashboard/`](Dashboard/).

## Project Overview

The project examines how patient characteristics, treatment and hormone measures, embryo development, and pregnancy outcomes appear across the available datasets. Dataset 2 contains three related tables: mother, offspring, and Elisa measurements.

The goal was to assess data quality, explore patterns and distributions, and present the analysis in a visual dashboard. The work is exploratory and describes patterns in the supplied data; it does not establish clinical causation or provide medical advice.

## Analytical Approach

- **Data quality:** assessed missing and blank values, duplicate records, inconsistent categories, mixed numeric/text values, invalid formats, and values outside plausible ranges.
- **Conservative cleaning:** standardized whitespace and case-only category variants, converted values to numeric only when appropriate, and preserved questionable values for review rather than silently guessing corrections.
- **Exploratory analysis:** summarized numeric and categorical variables, reviewed distributions and potential outliers, compared groups, examined correlations, and explored time-based trends where suitable fields were available.
- **Statistical moments:** calculated count, mean, variance, skewness, and excess kurtosis, alongside measures such as median, mode, range, and standard deviation.
- **SQL checks:** explored completeness, duplicates, category consistency, ranges, logical relationships, descriptive statistics, and potential outliers using mean-plus-or-minus-three-standard-deviation checks.
- **Power BI:** brought selected findings together across four report pages focused on patient and treatment characteristics, hormones, embryo quality, and outcomes.

## Tools and Project Structure

- **Python:** pandas and NumPy for data handling and statistics; Matplotlib for distribution plots.
- **SQL:** dataset-specific exploratory and data-quality queries.
- **Power BI:** dashboard development and visual communication of findings.

The `python/` folder contains one analysis script per dataset and a shared module for common cleaning and EDA logic. The `Sql/` folder contains queries for each dataset or Dataset 2 table. The `Dashboard/` folder contains exported images of all four report pages.

## Data Privacy

The underlying health-related records and the data-populated Power BI report are not included in this public repository. The screenshots provide a visual reference; they are not an interactive report. Sensitive or identifiable records should not be published.

## License

This project is released under the MIT License. See [`LICENSE`](LICENSE).
