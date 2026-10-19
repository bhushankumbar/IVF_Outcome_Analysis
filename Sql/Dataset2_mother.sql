### Dataset 2 - Mother
### Check column names and data types

DESCRIBE dataset2_mother;

### Inspect Dataset 2 - Mother

SELECT *
FROM dataset2_mother
LIMIT 10;

### Check Dataset 2 - Mother row count

SELECT COUNT(*) AS total_rows
FROM dataset2_mother;

### Dataset 2 - Mother
### Check actual column names

DESCRIBE dataset2_mother;

### Dataset 2 - Mother
### Check NULL values in all columns

SELECT
    COUNT(*) AS total_rows,
    SUM(`Unnamed: 0` IS NULL) AS col1_nulls,
    SUM(`basic information of mother` IS NULL) AS col2_nulls,
    SUM(`Unnamed: 2` IS NULL) AS col3_nulls,
    SUM(`Unnamed: 3` IS NULL) AS col4_nulls,
    SUM(`Unnamed: 4` IS NULL) AS col5_nulls,
    SUM(`Unnamed: 5` IS NULL) AS col6_nulls,
    SUM(`Unnamed: 6` IS NULL) AS col7_nulls,
    SUM(`Unnamed: 7` IS NULL) AS col8_nulls,
    SUM(`COH and IVF` IS NULL) AS col9_nulls,
    SUM(`Unnamed: 9` IS NULL) AS col10_nulls,
    SUM(`Unnamed: 10` IS NULL) AS col11_nulls,
    SUM(`Unnamed: 11` IS NULL) AS col12_nulls,
    SUM(`Unnamed: 12` IS NULL) AS col13_nulls,
    SUM(`Unnamed: 13` IS NULL) AS col14_nulls,
    SUM(`pregnancy outcome` IS NULL) AS col15_nulls,
    SUM(`Unnamed: 15` IS NULL) AS col16_nulls,
    SUM(`Unnamed: 16` IS NULL) AS col17_nulls,
    SUM(`obstetric` IS NULL) AS col18_nulls,
    SUM(`Unnamed: 18` IS NULL) AS col19_nulls
FROM dataset2_mother;

### Dataset 2 - Mother
### Check blank and whitespace values

SELECT
    SUM(TRIM(`Unnamed: 0`) = '') AS col1_blank,
    SUM(TRIM(`basic information of mother`) = '') AS col2_blank,
    SUM(TRIM(`Unnamed: 2`) = '') AS col3_blank,
    SUM(TRIM(`Unnamed: 3`) = '') AS col4_blank,
    SUM(TRIM(`Unnamed: 4`) = '') AS col5_blank,
    SUM(TRIM(`Unnamed: 5`) = '') AS col6_blank,
    SUM(TRIM(`Unnamed: 6`) = '') AS col7_blank,
    SUM(TRIM(`Unnamed: 7`) = '') AS col8_blank,
    SUM(TRIM(`COH and IVF`) = '') AS col9_blank,
    SUM(TRIM(`Unnamed: 9`) = '') AS col10_blank,
    SUM(TRIM(`Unnamed: 10`) = '') AS col11_blank,
    SUM(TRIM(`Unnamed: 11`) = '') AS col12_blank,
    SUM(TRIM(`Unnamed: 12`) = '') AS col13_blank,
    SUM(TRIM(`Unnamed: 13`) = '') AS col14_blank,
    SUM(TRIM(`pregnancy outcome`) = '') AS col15_blank,
    SUM(TRIM(`Unnamed: 15`) = '') AS col16_blank,
    SUM(TRIM(`Unnamed: 16`) = '') AS col17_blank,
    SUM(TRIM(`obstetric`) = '') AS col18_blank,
    SUM(TRIM(`Unnamed: 18`) = '') AS col19_blank
FROM dataset2_mother;

### Dataset 2 - Mother
### Check for duplicate rows

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT CONCAT_WS('|',
        `Unnamed: 0`,
        `basic information of mother`,
        `Unnamed: 2`,
        `Unnamed: 3`,
        `Unnamed: 4`,
        `Unnamed: 5`,
        `Unnamed: 6`,
        `Unnamed: 7`,
        `COH and IVF`,
        `Unnamed: 9`,
        `Unnamed: 10`,
        `Unnamed: 11`,
        `Unnamed: 12`,
        `Unnamed: 13`,
        `pregnancy outcome`,
        `Unnamed: 15`,
        `Unnamed: 16`,
        `obstetric`,
        `Unnamed: 18`
    )) AS unique_rows
FROM dataset2_mother;

### Dataset 2 - Mother
### Check categorical value consistency

SELECT
    `Unnamed: 0` AS group_value,
    COUNT(*) AS frequency
FROM dataset2_mother
GROUP BY `Unnamed: 0`
ORDER BY frequency DESC;

SELECT
    `Unnamed: 4` AS infertility_type,
    COUNT(*) AS frequency
FROM dataset2_mother
GROUP BY `Unnamed: 4`
ORDER BY frequency DESC;

SELECT
    `pregnancy outcome` AS pregnancy_outcome,
    COUNT(*) AS frequency
FROM dataset2_mother
GROUP BY `pregnancy outcome`
ORDER BY frequency DESC;

SELECT
    `Unnamed: 15` AS miscarriage,
    COUNT(*) AS frequency
FROM dataset2_mother
GROUP BY `Unnamed: 15`
ORDER BY frequency DESC;

SELECT
    `Unnamed: 16` AS live_birth,
    COUNT(*) AS frequency
FROM dataset2_mother
GROUP BY `Unnamed: 16`
ORDER BY frequency DESC;

SELECT
    `Unnamed: 18` AS delivery_type,
    COUNT(*) AS frequency
FROM dataset2_mother
GROUP BY `Unnamed: 18`
ORDER BY frequency DESC;

### Dataset 2 - Mother
### Locate the embedded header row

SELECT *
FROM dataset2_mother
WHERE `Unnamed: 0` = 'group(1=CHM 2=non-CHM)';

### Dataset 2 - Mother
### Recheck NULL values excluding the embedded header row

SELECT
    COUNT(*) AS data_rows,
    SUM(`Unnamed: 0` IS NULL) AS group_nulls,
    SUM(`basic information of mother` IS NULL) AS age_nulls,
    SUM(`Unnamed: 2` IS NULL) AS bmi_nulls,
    SUM(`Unnamed: 3` IS NULL) AS fertility_duration_nulls,
    SUM(`Unnamed: 4` IS NULL) AS infertility_type_nulls,
    SUM(`Unnamed: 5` IS NULL) AS lh_fsh_nulls,
    SUM(`Unnamed: 6` IS NULL) AS tt_nulls,
    SUM(`Unnamed: 7` IS NULL) AS e2_nulls,
    SUM(`COH and IVF` IS NULL) AS gn_dose_nulls,
    SUM(`Unnamed: 9` IS NULL) AS gn_duration_nulls,
    SUM(`Unnamed: 10` IS NULL) AS e2_hcg_day_nulls,
    SUM(`Unnamed: 11` IS NULL) AS retrieved_oocytes_nulls,
    SUM(`Unnamed: 12` IS NULL) AS fertilization_nulls,
    SUM(`Unnamed: 13` IS NULL) AS embryo_quality_nulls,
    SUM(`pregnancy outcome` IS NULL) AS clinical_pregnancy_nulls,
    SUM(`Unnamed: 15` IS NULL) AS miscarriage_nulls,
    SUM(`Unnamed: 16` IS NULL) AS live_birth_nulls,
    SUM(`obstetric` IS NULL) AS ga_nulls,
    SUM(`Unnamed: 18` IS NULL) AS delivery_nulls
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)';

### Dataset 2 - Mother
### Check numeric ranges

SELECT
    'age' AS column_name,
    MIN(CAST(`basic information of mother` AS DECIMAL(10,2))) AS min_value,
    MAX(CAST(`basic information of mother` AS DECIMAL(10,2))) AS max_value
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'BMI',
    MIN(CAST(`Unnamed: 2` AS DECIMAL(10,2))),
    MAX(CAST(`Unnamed: 2` AS DECIMAL(10,2)))
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'duration of fertility',
    MIN(CAST(`Unnamed: 3` AS DECIMAL(10,2))),
    MAX(CAST(`Unnamed: 3` AS DECIMAL(10,2)))
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'LH/FSH',
    MIN(CAST(`Unnamed: 5` AS DECIMAL(10,2))),
    MAX(CAST(`Unnamed: 5` AS DECIMAL(10,2)))
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'TT',
    MIN(CAST(`Unnamed: 6` AS DECIMAL(10,2))),
    MAX(CAST(`Unnamed: 6` AS DECIMAL(10,2)))
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'E2',
    MIN(CAST(`Unnamed: 7` AS DECIMAL(10,2))),
    MAX(CAST(`Unnamed: 7` AS DECIMAL(10,2)))
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'Gn dose',
    MIN(CAST(`COH and IVF` AS DECIMAL(10,2))),
    MAX(CAST(`COH and IVF` AS DECIMAL(10,2)))
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'Gn duration',
    MIN(CAST(`Unnamed: 9` AS DECIMAL(10,2))),
    MAX(CAST(`Unnamed: 9` AS DECIMAL(10,2)))
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'E2 HCG day',
    MIN(CAST(`Unnamed: 10` AS DECIMAL(10,2))),
    MAX(CAST(`Unnamed: 10` AS DECIMAL(10,2)))
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'retrieved oocytes',
    MIN(CAST(`Unnamed: 11` AS DECIMAL(10,2))),
    MAX(CAST(`Unnamed: 11` AS DECIMAL(10,2)))
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'fertilization',
    MIN(CAST(`Unnamed: 12` AS DECIMAL(10,2))),
    MAX(CAST(`Unnamed: 12` AS DECIMAL(10,2)))
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'good-quality embryo',
    MIN(CAST(`Unnamed: 13` AS DECIMAL(10,2))),
    MAX(CAST(`Unnamed: 13` AS DECIMAL(10,2)))
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)';

### Dataset 2 - Mother
### Check categorical values excluding the embedded header row

SELECT
    'Group' AS column_name,
    `Unnamed: 0` AS value,
    COUNT(*) AS frequency
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
GROUP BY `Unnamed: 0`

UNION ALL

SELECT
    'Infertility type',
    `Unnamed: 4`,
    COUNT(*)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
GROUP BY `Unnamed: 4`

UNION ALL

SELECT
    'Clinical pregnancy',
    `pregnancy outcome`,
    COUNT(*)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
GROUP BY `pregnancy outcome`

UNION ALL

SELECT
    'Miscarriage',
    `Unnamed: 15`,
    COUNT(*)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
GROUP BY `Unnamed: 15`

UNION ALL

SELECT
    'Live birth',
    `Unnamed: 16`,
    COUNT(*)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
GROUP BY `Unnamed: 16`

UNION ALL

SELECT
    'Delivery',
    `Unnamed: 18`,
    COUNT(*)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
GROUP BY `Unnamed: 18`

ORDER BY column_name, value;

### Dataset 2 - Mother
### Calculate mean and standard deviation

SELECT
    'age' AS column_name,
    COUNT(*) AS total_values,
    ROUND(AVG(CAST(`basic information of mother` AS DECIMAL(10,2))), 2) AS mean_value,
    ROUND(STDDEV(CAST(`basic information of mother` AS DECIMAL(10,2))), 2) AS std_dev
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'BMI',
    COUNT(*),
    ROUND(AVG(CAST(`Unnamed: 2` AS DECIMAL(10,2))), 2),
    ROUND(STDDEV(CAST(`Unnamed: 2` AS DECIMAL(10,2))), 2)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'duration of fertility',
    COUNT(*),
    ROUND(AVG(CAST(`Unnamed: 3` AS DECIMAL(10,2))), 2),
    ROUND(STDDEV(CAST(`Unnamed: 3` AS DECIMAL(10,2))), 2)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'LH/FSH',
    COUNT(*),
    ROUND(AVG(CAST(`Unnamed: 5` AS DECIMAL(10,2))), 2),
    ROUND(STDDEV(CAST(`Unnamed: 5` AS DECIMAL(10,2))), 2)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'TT',
    COUNT(*),
    ROUND(AVG(CAST(`Unnamed: 6` AS DECIMAL(10,2))), 2),
    ROUND(STDDEV(CAST(`Unnamed: 6` AS DECIMAL(10,2))), 2)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'E2',
    COUNT(*),
    ROUND(AVG(CAST(`Unnamed: 7` AS DECIMAL(10,2))), 2),
    ROUND(STDDEV(CAST(`Unnamed: 7` AS DECIMAL(10,2))), 2)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'Gn dose',
    COUNT(*),
    ROUND(AVG(CAST(`COH and IVF` AS DECIMAL(10,2))), 2),
    ROUND(STDDEV(CAST(`COH and IVF` AS DECIMAL(10,2))), 2)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'Gn duration',
    COUNT(*),
    ROUND(AVG(CAST(`Unnamed: 9` AS DECIMAL(10,2))), 2),
    ROUND(STDDEV(CAST(`Unnamed: 9` AS DECIMAL(10,2))), 2)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'E2 HCG day',
    COUNT(*),
    ROUND(AVG(CAST(`Unnamed: 10` AS DECIMAL(10,2))), 2),
    ROUND(STDDEV(CAST(`Unnamed: 10` AS DECIMAL(10,2))), 2)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'retrieved oocytes',
    COUNT(*),
    ROUND(AVG(CAST(`Unnamed: 11` AS DECIMAL(10,2))), 2),
    ROUND(STDDEV(CAST(`Unnamed: 11` AS DECIMAL(10,2))), 2)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'fertilization',
    COUNT(*),
    ROUND(AVG(CAST(`Unnamed: 12` AS DECIMAL(10,2))), 2),
    ROUND(STDDEV(CAST(`Unnamed: 12` AS DECIMAL(10,2))), 2)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'good-quality embryo',
    COUNT(*),
    ROUND(AVG(CAST(`Unnamed: 13` AS DECIMAL(10,2))), 2),
    ROUND(STDDEV(CAST(`Unnamed: 13` AS DECIMAL(10,2))), 2)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)';

### Dataset 2 - Mother
### Check statistical outliers using Mean +/- 3 SD

SELECT
    'age' AS column_name,
    SUM(
        CAST(`basic information of mother` AS DECIMAL(10,2)) <
        (31.17 - 3 * 3.73)
        OR
        CAST(`basic information of mother` AS DECIMAL(10,2)) >
        (31.17 + 3 * 3.73)
    ) AS outlier_count
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'BMI',
    SUM(
        CAST(`Unnamed: 2` AS DECIMAL(10,2)) < (22.74 - 3 * 2.29)
        OR
        CAST(`Unnamed: 2` AS DECIMAL(10,2)) > (22.74 + 3 * 2.29)
    )
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'duration of fertility',
    SUM(
        CAST(`Unnamed: 3` AS DECIMAL(10,2)) < (3.88 - 3 * 1.89)
        OR
        CAST(`Unnamed: 3` AS DECIMAL(10,2)) > (3.88 + 3 * 1.89)
    )
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'LH/FSH',
    SUM(
        CAST(`Unnamed: 5` AS DECIMAL(10,2)) < (2.06 - 3 * 0.90)
        OR
        CAST(`Unnamed: 5` AS DECIMAL(10,2)) > (2.06 + 3 * 0.90)
    )
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'TT',
    SUM(
        CAST(`Unnamed: 6` AS DECIMAL(10,2)) < (2.30 - 3 * 1.15)
        OR
        CAST(`Unnamed: 6` AS DECIMAL(10,2)) > (2.30 + 3 * 1.15)
    )
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'E2',
    SUM(
        CAST(`Unnamed: 7` AS DECIMAL(10,2)) < (158.41 - 3 * 53.90)
        OR
        CAST(`Unnamed: 7` AS DECIMAL(10,2)) > (158.41 + 3 * 53.90)
    )
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'Gn dose',
    SUM(
        CAST(`COH and IVF` AS DECIMAL(10,2)) < (1726.87 - 3 * 553.73)
        OR
        CAST(`COH and IVF` AS DECIMAL(10,2)) > (1726.87 + 3 * 553.73)
    )
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'Gn duration',
    SUM(
        CAST(`Unnamed: 9` AS DECIMAL(10,2)) < (10.84 - 3 * 2.42)
        OR
        CAST(`Unnamed: 9` AS DECIMAL(10,2)) > (10.84 + 3 * 2.42)
    )
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'E2 HCG day',
    SUM(
        CAST(`Unnamed: 10` AS DECIMAL(10,2)) < (9299.90 - 3 * 3416.94)
        OR
        CAST(`Unnamed: 10` AS DECIMAL(10,2)) > (9299.90 + 3 * 3416.94)
    )
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'retrieved oocytes',
    SUM(
        CAST(`Unnamed: 11` AS DECIMAL(10,2)) < (14.44 - 3 * 4.79)
        OR
        CAST(`Unnamed: 11` AS DECIMAL(10,2)) > (14.44 + 3 * 4.79)
    )
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'fertilization',
    SUM(
        CAST(`Unnamed: 12` AS DECIMAL(10,2)) < (60.61 - 3 * 18.35)
        OR
        CAST(`Unnamed: 12` AS DECIMAL(10,2)) > (60.61 + 3 * 18.35)
    )
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'good-quality embryo',
    SUM(
        CAST(`Unnamed: 13` AS DECIMAL(10,2)) < (39.27 - 3 * 25.12)
        OR
        CAST(`Unnamed: 13` AS DECIMAL(10,2)) > (39.27 + 3 * 25.12)
    )
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)';

### Dataset 2 - Mother
### Show potential outlier values

SELECT
    'duration of fertility' AS column_name,
    `Unnamed: 3` AS value
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
  AND (
      CAST(`Unnamed: 3` AS DECIMAL(10,2)) < (3.88 - 3 * 1.89)
      OR
      CAST(`Unnamed: 3` AS DECIMAL(10,2)) > (3.88 + 3 * 1.89)
  )

UNION ALL

SELECT
    'Gn dose',
    `COH and IVF`
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
  AND (
      CAST(`COH and IVF` AS DECIMAL(10,2)) < (1726.87 - 3 * 553.73)
      OR
      CAST(`COH and IVF` AS DECIMAL(10,2)) > (1726.87 + 3 * 553.73)
  )

UNION ALL

SELECT
    'Gn duration',
    `Unnamed: 9`
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
  AND (
      CAST(`Unnamed: 9` AS DECIMAL(10,2)) < (10.84 - 3 * 2.42)
      OR
      CAST(`Unnamed: 9` AS DECIMAL(10,2)) > (10.84 + 3 * 2.42)
  )

UNION ALL

SELECT
    'E2 HCG day',
    `Unnamed: 10`
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
  AND (
      CAST(`Unnamed: 10` AS DECIMAL(10,2)) < (9299.90 - 3 * 3416.94)
      OR
      CAST(`Unnamed: 10` AS DECIMAL(10,2)) > (9299.90 + 3 * 3416.94)
  )

UNION ALL

SELECT
    'good-quality embryo',
    `Unnamed: 13`
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
  AND (
      CAST(`Unnamed: 13` AS DECIMAL(10,2)) < (39.27 - 3 * 25.12)
      OR
      CAST(`Unnamed: 13` AS DECIMAL(10,2)) > (39.27 + 3 * 25.12)
  );
  
### Dataset 2 - Mother
### Check percentage ranges and logically invalid values

SELECT
    'fertilization' AS column_name,
    MIN(CAST(`Unnamed: 12` AS DECIMAL(10,2))) AS min_value,
    MAX(CAST(`Unnamed: 12` AS DECIMAL(10,2))) AS max_value,
    SUM(
        CAST(`Unnamed: 12` AS DECIMAL(10,2)) < 0
        OR CAST(`Unnamed: 12` AS DECIMAL(10,2)) > 100
    ) AS invalid_count
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'good-quality embryo',
    MIN(CAST(`Unnamed: 13` AS DECIMAL(10,2))),
    MAX(CAST(`Unnamed: 13` AS DECIMAL(10,2))),
    SUM(
        CAST(`Unnamed: 13` AS DECIMAL(10,2)) < 0
        OR CAST(`Unnamed: 13` AS DECIMAL(10,2)) > 100
    )
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)';

### Show the invalid good-quality embryo value

SELECT
    `Unnamed: 13` AS invalid_value
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
  AND (
      CAST(`Unnamed: 13` AS DECIMAL(10,2)) < 0
      OR CAST(`Unnamed: 13` AS DECIMAL(10,2)) > 100
  );
  
### Dataset 2 - Mother
### Check for negative values in numeric columns

SELECT
    'age' AS column_name,
    SUM(CAST(`basic information of mother` AS DECIMAL(10,2)) < 0) AS negative_count
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'BMI',
    SUM(CAST(`Unnamed: 2` AS DECIMAL(10,2)) < 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'duration of fertility',
    SUM(CAST(`Unnamed: 3` AS DECIMAL(10,2)) < 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'LH/FSH',
    SUM(CAST(`Unnamed: 5` AS DECIMAL(10,2)) < 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'TT',
    SUM(CAST(`Unnamed: 6` AS DECIMAL(10,2)) < 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'E2',
    SUM(CAST(`Unnamed: 7` AS DECIMAL(10,2)) < 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'Gn dose',
    SUM(CAST(`COH and IVF` AS DECIMAL(10,2)) < 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'Gn duration',
    SUM(CAST(`Unnamed: 9` AS DECIMAL(10,2)) < 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'E2 HCG day',
    SUM(CAST(`Unnamed: 10` AS DECIMAL(10,2)) < 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'retrieved oocytes',
    SUM(CAST(`Unnamed: 11` AS DECIMAL(10,2)) < 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'fertilization',
    SUM(CAST(`Unnamed: 12` AS DECIMAL(10,2)) < 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'good-quality embryo',
    SUM(CAST(`Unnamed: 13` AS DECIMAL(10,2)) < 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)';

### Dataset 2 - Mother
### Check numeric columns for invalid text values

SELECT
    'age' AS column_name,
    SUM(`basic information of mother` NOT REGEXP '^[0-9]+([.][0-9]+)?$') AS invalid_count
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'BMI',
    SUM(`Unnamed: 2` NOT REGEXP '^[0-9]+([.][0-9]+)?$')
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'duration of fertility',
    SUM(`Unnamed: 3` NOT REGEXP '^[0-9]+([.][0-9]+)?$')
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'LH/FSH',
    SUM(`Unnamed: 5` NOT REGEXP '^[0-9]+([.][0-9]+)?$')
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'TT',
    SUM(`Unnamed: 6` NOT REGEXP '^[0-9]+([.][0-9]+)?$')
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'E2',
    SUM(`Unnamed: 7` NOT REGEXP '^[0-9]+([.][0-9]+)?$')
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'Gn dose',
    SUM(`COH and IVF` NOT REGEXP '^[0-9]+([.][0-9]+)?$')
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'Gn duration',
    SUM(`Unnamed: 9` NOT REGEXP '^[0-9]+([.][0-9]+)?$')
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'E2 HCG day',
    SUM(`Unnamed: 10` NOT REGEXP '^[0-9]+([.][0-9]+)?$')
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'retrieved oocytes',
    SUM(`Unnamed: 11` NOT REGEXP '^[0-9]+([.][0-9]+)?$')
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'fertilization',
    SUM(`Unnamed: 12` NOT REGEXP '^[0-9]+([.][0-9]+)?$')
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'good-quality embryo',
    SUM(`Unnamed: 13` NOT REGEXP '^[0-9]+([.][0-9]+)?$')
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)';

### Dataset 2 - Mother
### Show invalid TT values

SELECT
    `Unnamed: 6` AS invalid_tt_value,
    COUNT(*) AS frequency
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
  AND `Unnamed: 6` NOT REGEXP '^[0-9]+([.][0-9]+)?$'
GROUP BY `Unnamed: 6`;

### Dataset 2 - Mother
### Check zero values in numeric columns

SELECT
    'age' AS column_name,
    SUM(CAST(`basic information of mother` AS DECIMAL(10,2)) = 0) AS zero_count
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'BMI',
    SUM(CAST(`Unnamed: 2` AS DECIMAL(10,2)) = 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'duration of fertility',
    SUM(CAST(`Unnamed: 3` AS DECIMAL(10,2)) = 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'LH/FSH',
    SUM(CAST(`Unnamed: 5` AS DECIMAL(10,2)) = 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'TT',
    SUM(CAST(`Unnamed: 6` AS DECIMAL(10,2)) = 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'E2',
    SUM(CAST(`Unnamed: 7` AS DECIMAL(10,2)) = 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'Gn dose',
    SUM(CAST(`COH and IVF` AS DECIMAL(10,2)) = 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'Gn duration',
    SUM(CAST(`Unnamed: 9` AS DECIMAL(10,2)) = 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'E2 HCG day',
    SUM(CAST(`Unnamed: 10` AS DECIMAL(10,2)) = 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'retrieved oocytes',
    SUM(CAST(`Unnamed: 11` AS DECIMAL(10,2)) = 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'fertilization',
    SUM(CAST(`Unnamed: 12` AS DECIMAL(10,2)) = 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'

UNION ALL

SELECT
    'good-quality embryo',
    SUM(CAST(`Unnamed: 13` AS DECIMAL(10,2)) = 0)
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)';

### Dataset 2 - Mother
### Check logical consistency of pregnancy outcomes

SELECT
    COUNT(*) AS inconsistent_records
FROM dataset2_mother
WHERE `Unnamed: 0` <> 'group(1=CHM 2=non-CHM)'
  AND (
      (`pregnancy outcome` = '0' AND
       (`Unnamed: 15` = '1' OR `Unnamed: 16` = '1'))
      
      OR
      
      (`Unnamed: 15` = '1' AND `pregnancy outcome` <> '1')
      
      OR
      
      (`Unnamed: 16` = '1' AND `pregnancy outcome` <> '1')
  );