### Dataset 2 - Elisa
### Check column names and data types

DESCRIBE dataset2_elisa;

### Dataset 2 - Elisa
### Inspect first 10 rows

SELECT *
FROM dataset2_elisa
LIMIT 10;

### Dataset 2 - Elisa
### Check row count and NULL values

SELECT
    COUNT(*) AS total_rows,
    SUM(`group(1=CHM 2=non-CHM)` IS NULL) AS group_nulls,
    SUM(`BMP15(pg/ml)` IS NULL) AS bmp15_nulls,
    SUM(` LIF(pg/ml)` IS NULL) AS lif_nulls
FROM dataset2_elisa;

### Dataset 2 - Elisa
### Check duplicate rows

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT CONCAT_WS('|',
        `group(1=CHM 2=non-CHM)`,
        `BMP15(pg/ml)`,
        ` LIF(pg/ml)`
    )) AS unique_rows
FROM dataset2_elisa;

### Dataset 2 - Elisa
### Check categorical values and numeric ranges

SELECT
    `group(1=CHM 2=non-CHM)` AS group_value,
    COUNT(*) AS frequency
FROM dataset2_elisa
GROUP BY `group(1=CHM 2=non-CHM)`
ORDER BY `group(1=CHM 2=non-CHM)`;

SELECT
    MIN(`BMP15(pg/ml)`) AS min_bmp15,
    MAX(`BMP15(pg/ml)`) AS max_bmp15,
    MIN(` LIF(pg/ml)`) AS min_lif,
    MAX(` LIF(pg/ml)`) AS max_lif
FROM dataset2_elisa;

### Dataset 2 - Elisa
### Check group values

SELECT
    `group(1=CHM 2=non-CHM)` AS group_value,
    COUNT(*) AS frequency
FROM dataset2_elisa
GROUP BY `group(1=CHM 2=non-CHM)`
ORDER BY `group(1=CHM 2=non-CHM)`;

### Dataset 2 - Elisa
### Check negative values

SELECT
    SUM(`BMP15(pg/ml)` < 0) AS negative_bmp15,
    SUM(` LIF(pg/ml)` < 0) AS negative_lif
FROM dataset2_elisa;

### Dataset 2 - Elisa
### Check statistical outliers using mean ± 3 SD

SELECT
    'BMP15' AS field_name,
    COUNT(*) AS total_values,
    ROUND(AVG(`BMP15(pg/ml)`), 2) AS mean_value,
    ROUND(STDDEV(`BMP15(pg/ml)`), 2) AS stddev_value,
    SUM(
        `BMP15(pg/ml)` < avg_value - 3 * stddev_value
        OR `BMP15(pg/ml)` > avg_value + 3 * stddev_value
    ) AS outlier_count
FROM (
    SELECT
        `BMP15(pg/ml)`,
        (SELECT AVG(`BMP15(pg/ml)`) FROM dataset2_elisa) AS avg_value,
        (SELECT STDDEV(`BMP15(pg/ml)`) FROM dataset2_elisa) AS stddev_value
    FROM dataset2_elisa
) AS bmp

UNION ALL

SELECT
    'LIF' AS field_name,
    COUNT(*) AS total_values,
    ROUND(AVG(` LIF(pg/ml)`), 2) AS mean_value,
    ROUND(STDDEV(` LIF(pg/ml)`), 2) AS stddev_value,
    SUM(
        ` LIF(pg/ml)` < avg_value - 3 * stddev_value
        OR ` LIF(pg/ml)` > avg_value + 3 * stddev_value
    ) AS outlier_count
FROM (
    SELECT
        ` LIF(pg/ml)`,
        (SELECT AVG(` LIF(pg/ml)`) FROM dataset2_elisa) AS avg_value,
        (SELECT STDDEV(` LIF(pg/ml)`) FROM dataset2_elisa) AS stddev_value
    FROM dataset2_elisa
) AS lif;

### Dataset 2 - Elisa
### Identify BMP15 and LIF outlier values

SELECT
    'BMP15' AS field_name,
    `BMP15(pg/ml)` AS value
FROM dataset2_elisa
WHERE `BMP15(pg/ml)` < 17.7 - (3 * 9.8)
   OR `BMP15(pg/ml)` > 17.7 + (3 * 9.8)

UNION ALL

SELECT
    'LIF' AS field_name,
    ` LIF(pg/ml)` AS value
FROM dataset2_elisa
WHERE ` LIF(pg/ml)` < 1270.84 - (3 * 792.28)
   OR ` LIF(pg/ml)` > 1270.84 + (3 * 792.28);
   
### Dataset 2 - Elisa
### Check logical consistency of group values

SELECT
    COUNT(*) AS total_records,
    SUM(
        `group(1=CHM 2=non-CHM)` NOT IN (1, 2)
    ) AS invalid_group_records
FROM dataset2_elisa;
   
   
