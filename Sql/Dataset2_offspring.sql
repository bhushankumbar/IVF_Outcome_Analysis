### Dataset 2 - Offspring
### Check column names and data types

DESCRIBE dataset2_offspring;

### Dataset 2 - Offspring
### Inspect first 10 rows

SELECT *
FROM dataset2_offspring
LIMIT 10;

### Dataset 2 - Offspring
### Check total rows and identify embedded header row

SELECT COUNT(*) AS total_rows
FROM dataset2_offspring;

SELECT *
FROM dataset2_offspring
WHERE `Unnamed: 0` = 'group(1=CHM 2=non-CHM)';

### Dataset 2 - Offspring
### Count total rows

SELECT COUNT(*) AS total_rows
FROM dataset2_offspring;

### Dataset 2 - Offspring
### Check NULL values in all columns

SELECT
    COUNT(*) AS data_rows,
    SUM(`Unnamed: 0` IS NULL) AS group_nulls,
    SUM(`offspring` IS NULL) AS weight_nulls,
    SUM(`Unnamed: 2` IS NULL) AS apgar_nulls,
    SUM(`Unnamed: 3` IS NULL) AS gender_nulls,
    SUM(`Unnamed: 4` IS NULL) AS note_nulls
FROM dataset2_offspring
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)';

### Dataset 2 - Offspring
### Check blank and whitespace values

SELECT
    SUM(TRIM(`Unnamed: 0`) = '') AS group_blank,
    SUM(TRIM(`offspring`) = '') AS weight_blank,
    SUM(TRIM(`Unnamed: 2`) = '') AS apgar_blank,
    SUM(TRIM(`Unnamed: 3`) = '') AS gender_blank,
    SUM(TRIM(`Unnamed: 4`) = '') AS note_blank
FROM dataset2_offspring
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)';

### Dataset 2 - Offspring
### Check duplicate rows

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT CONCAT_WS('|',
        `Unnamed: 0`,
        `offspring`,
        `Unnamed: 2`,
        `Unnamed: 3`,
        `Unnamed: 4`
    )) AS unique_rows
FROM dataset2_offspring;

### Dataset 2 - Offspring
### Identify repeated records

SELECT
    `Unnamed: 0` AS group_value,
    `offspring` AS weight,
    `Unnamed: 2` AS apgar,
    `Unnamed: 3` AS gender,
    `Unnamed: 4` AS note,
    COUNT(*) AS frequency
FROM dataset2_offspring
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
GROUP BY
    `Unnamed: 0`,
    `offspring`,
    `Unnamed: 2`,
    `Unnamed: 3`,
    `Unnamed: 4`
HAVING COUNT(*) > 1
ORDER BY frequency DESC;

### Dataset 2 - Offspring
### Check categorical values

SELECT
    `Unnamed: 0` AS group_value,
    COUNT(*) AS frequency
FROM dataset2_offspring
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
GROUP BY `Unnamed: 0`
ORDER BY `Unnamed: 0`;

SELECT
    `Unnamed: 3` AS gender,
    COUNT(*) AS frequency
FROM dataset2_offspring
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
GROUP BY `Unnamed: 3`
ORDER BY `Unnamed: 3`;

SELECT
    `Unnamed: 2` AS apgar,
    COUNT(*) AS frequency
FROM dataset2_offspring
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
GROUP BY `Unnamed: 2`
ORDER BY `Unnamed: 2`;

### Dataset 2 - Offspring
### Check group and gender values

SELECT
    'Group' AS field_name,
    `Unnamed: 0` AS value,
    COUNT(*) AS frequency
FROM dataset2_offspring
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
GROUP BY `Unnamed: 0`

UNION ALL

SELECT
    'Gender' AS field_name,
    `Unnamed: 3` AS value,
    COUNT(*) AS frequency
FROM dataset2_offspring
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
GROUP BY `Unnamed: 3`;

### Dataset 2 - Offspring
### Check numeric ranges and valid gender values

SELECT
    MIN(CAST(`offspring` AS DECIMAL(10,2))) AS min_weight,
    MAX(CAST(`offspring` AS DECIMAL(10,2))) AS max_weight,
    MIN(CAST(`Unnamed: 2` AS DECIMAL(10,2))) AS min_apgar,
    MAX(CAST(`Unnamed: 2` AS DECIMAL(10,2))) AS max_apgar,
    SUM(
        `Unnamed: 3` IS NOT NULL
        AND `Unnamed: 3` NOT IN ('0','1')
    ) AS invalid_gender_values
FROM dataset2_offspring
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
  AND `offspring` <> ''
  AND `Unnamed: 2` <> '';
  
### Dataset 2 - Offspring
### Check negative values and invalid numeric formats

SELECT
    SUM(
        CAST(`offspring` AS DECIMAL(10,2)) < 0
    ) AS negative_weight,
    SUM(
        CAST(`Unnamed: 2` AS DECIMAL(10,2)) < 0
    ) AS negative_apgar
FROM dataset2_offspring
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
  AND `offspring` <> ''
  AND `Unnamed: 2` <> '';

SELECT
    SUM(
        `offspring` NOT REGEXP '^[0-9]+(\\.[0-9]+)?$'
        AND `offspring` <> ''
    ) AS invalid_weight_format,
    SUM(
        `Unnamed: 2` NOT REGEXP '^[0-9]+(\\.[0-9]+)?$'
        AND `Unnamed: 2` <> ''
    ) AS invalid_apgar_format
FROM dataset2_offspring
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)';

### Dataset 2 - Offspring
### Check Weight outliers using mean ± 3 SD

SELECT
    COUNT(*) AS total_values,
    ROUND(AVG(weight), 2) AS mean_weight,
    ROUND(STDDEV(weight), 2) AS stddev_weight,
    SUM(
        weight < avg_weight - 3 * stddev_weight
        OR weight > avg_weight + 3 * stddev_weight
    ) AS outlier_count
FROM (
    SELECT
        CAST(`offspring` AS DECIMAL(10,2)) AS weight,
        (SELECT AVG(CAST(`offspring` AS DECIMAL(10,2)))
         FROM dataset2_offspring
         WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
           AND `offspring` <> '') AS avg_weight,
        (SELECT STDDEV(CAST(`offspring` AS DECIMAL(10,2)))
         FROM dataset2_offspring
         WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
           AND `offspring` <> '') AS stddev_weight
    FROM dataset2_offspring
    WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
      AND `offspring` <> ''
) AS x;

### Dataset 2 - Offspring
### Check APGAR outliers using mean ± 3 SD

SELECT
    COUNT(*) AS total_values,
    ROUND(AVG(apgar), 2) AS mean_apgar,
    ROUND(STDDEV(apgar), 2) AS stddev_apgar,
    SUM(
        apgar < avg_apgar - 3 * stddev_apgar
        OR apgar > avg_apgar + 3 * stddev_apgar
    ) AS outlier_count
FROM (
    SELECT
        CAST(`Unnamed: 2` AS DECIMAL(10,2)) AS apgar,
        (SELECT AVG(CAST(`Unnamed: 2` AS DECIMAL(10,2)))
         FROM dataset2_offspring
         WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
           AND `Unnamed: 2` <> '') AS avg_apgar,
        (SELECT STDDEV(CAST(`Unnamed: 2` AS DECIMAL(10,2)))
         FROM dataset2_offspring
         WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
           AND `Unnamed: 2` <> '') AS stddev_apgar
    FROM dataset2_offspring
    WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
      AND `Unnamed: 2` <> ''
) AS x;

### Dataset 2 - Offspring
### Identify APGAR outlier values

SELECT
    `Unnamed: 2` AS apgar,
    COUNT(*) AS frequency
FROM dataset2_offspring
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
  AND `Unnamed: 2` <> ''
GROUP BY `Unnamed: 2`
ORDER BY CAST(`Unnamed: 2` AS DECIMAL(10,2));

### Dataset 2 - Offspring
### Check logical consistency of offspring records

SELECT
    COUNT(*) AS offspring_records,
    SUM(`offspring` <> '') AS records_with_weight,
    SUM(`Unnamed: 2` <> '') AS records_with_apgar,
    SUM(`Unnamed: 3` <> '') AS records_with_gender
FROM dataset2_offspring
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)';

