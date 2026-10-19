-- ============================================================
-- NULL VALUE CHECK - DATASET 1
-- Checks missing values in every column
-- ============================================================

SELECT
    SUM(`PATIENT NAME AND SURNAME` IS NULL) AS patient_name_nulls,
    SUM(`age` IS NULL) AS age_nulls,
    SUM(`Spouse AGE` IS NULL) AS spouse_age_nulls,
    SUM(`Clinical pregnancy: 0:0, Chemical: 1:1 Positive` IS NULL) AS clinical_pregnancy_nulls,
    SUM(`Live Birth` IS NULL) AS live_birth_nulls,
    SUM(`WEEK OF BIRTH` IS NULL) AS week_of_birth_nulls,
    SUM(`Neonatal Death` IS NULL) AS neonatal_death_nulls,
    SUM(`ABORTION` IS NULL) AS abortion_nulls,
    SUM(`BHCG 12` IS NULL) AS bhcg_12_nulls,
    SUM(`BHCG 14` IS NULL) AS bhcg_14_nulls,
    SUM(`BHCG 12-14% increase` IS NULL) AS bhcg_increase_nulls,
    SUM(`twin` IS NULL) AS twin_nulls,
    SUM(`Indication` IS NULL) AS indication_nulls,
    SUM(`FSH` IS NULL) AS fsh_nulls,
    SUM(`E2` IS NULL) AS e2_nulls,
    SUM(`PROGESTERONE` IS NULL) AS progesterone_nulls,
    SUM(`NUMBER OF OOCYTES` IS NULL) AS number_of_oocytes_nulls,
    SUM(`Embryo Tranfer Day` IS NULL) AS embryo_transfer_day_nulls,
    SUM(`ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER` IS NULL) AS endometrial_thickness_nulls,
    SUM(`IND. NUMBER OF DAYS` IS NULL) AS ind_number_of_days_nulls,
    SUM(`Number of Embryos Transferred` IS NULL) AS embryos_transferred_nulls,
    SUM(`EU` IS NULL) AS eu_nulls,
    SUM(`AMH` IS NULL) AS amh_nulls
FROM dataset1;

SELECT *
FROM dataset1
WHERE `Spouse AGE` IS NULL
   OR `WEEK OF BIRTH` IS NULL
   OR `ABORTION` IS NULL
   OR `BHCG 12` IS NULL
   OR `BHCG 14` IS NULL
   OR `BHCG 12-14% increase` IS NULL
   OR `Indication` IS NULL
   OR `FSH` IS NULL
   OR `E2` IS NULL
   OR `PROGESTERONE` IS NULL
   OR `NUMBER OF OOCYTES` IS NULL
   OR `Embryo Tranfer Day` IS NULL
   OR `ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER` IS NULL
   OR `IND. NUMBER OF DAYS` IS NULL
   OR `Number of Embryos Transferred` IS NULL
   OR `AMH` IS NULL;
   
-- Check whether text columns contain empty strings in addition to NULLs

SELECT
    SUM(TRIM(`PATIENT NAME AND SURNAME`) = '') AS patient_name_empty,
    SUM(TRIM(`ABORTION`) = '') AS abortion_empty,
    SUM(TRIM(`E2`) = '') AS e2_empty,
    SUM(TRIM(`PROGESTERONE`) = '') AS progesterone_empty,
    SUM(TRIM(`NUMBER OF OOCYTES`) = '') AS oocytes_empty,
    SUM(TRIM(`ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER`) = '') AS endometrial_empty
FROM dataset1;

-- ============================================================
-- Check duplicate records in Dataset 1
-- ============================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT CONCAT_WS('|',
        `PATIENT NAME AND SURNAME`,
        `age`,
        `Spouse AGE`,
        `Clinical pregnancy: 0:0, Chemical: 1:1 Positive`,
        `Live Birth`,
        `WEEK OF BIRTH`,
        `Neonatal Death`,
        `ABORTION`,
        `BHCG 12`,
        `BHCG 14`,
        `BHCG 12-14% increase`,
        `twin`,
        `Indication`,
        `FSH`,
        `E2`,
        `PROGESTERONE`,
        `NUMBER OF OOCYTES`,
        `Embryo Tranfer Day`,
        `ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER`,
        `IND. NUMBER OF DAYS`,
        `Number of Embryos Transferred`,
        `EU`,
        `AMH`
    )) AS unique_rows
FROM dataset1;
-- =====================================================================
-- Check distinct values in categorical columns for inconsistent entries
-- ======================================================================
SELECT 'Clinical Pregnancy' AS column_name,
       `Clinical pregnancy: 0:0, Chemical: 1:1 Positive` AS value,
       COUNT(*) AS frequency
FROM dataset1
GROUP BY `Clinical pregnancy: 0:0, Chemical: 1:1 Positive`
UNION ALL
SELECT 'Abortion',
       `ABORTION`,
       COUNT(*)
FROM dataset1
GROUP BY `ABORTION`
UNION ALL
SELECT 'Neonatal Death',
       CAST(`Neonatal Death` AS CHAR),
       COUNT(*)
FROM dataset1
GROUP BY `Neonatal Death`
UNION ALL
SELECT 'Twin',
       CAST(`twin` AS CHAR),
       COUNT(*)
FROM dataset1
GROUP BY `twin`
UNION ALL
SELECT 'Live Birth',
       CAST(`Live Birth` AS CHAR),
       COUNT(*)
FROM dataset1
GROUP BY `Live Birth`
ORDER BY column_name, frequency DESC;

-- ============================================================
-- Check minimum and maximum values of the main numeric columns
-- ============================================================
SELECT
    MIN(`age`) AS min_age,
    MAX(`age`) AS max_age,
    MIN(`Spouse AGE`) AS min_spouse_age,
    MAX(`Spouse AGE`) AS max_spouse_age,
    MIN(`WEEK OF BIRTH`) AS min_week_of_birth,
    MAX(`WEEK OF BIRTH`) AS max_week_of_birth,
    MIN(`BHCG 12`) AS min_bhcg_12,
    MAX(`BHCG 12`) AS max_bhcg_12,
    MIN(`BHCG 14`) AS min_bhcg_14,
    MAX(`BHCG 14`) AS max_bhcg_14,
    MIN(`FSH`) AS min_fsh,
    MAX(`FSH`) AS max_fsh,
    MIN(`AMH`) AS min_amh,
    MAX(`AMH`) AS max_amh,
    MIN(`Number of Embryos Transferred`) AS min_embryos,
    MAX(`Number of Embryos Transferred`) AS max_embryos
FROM dataset1;

-- =================================================================
-- Check the values stored in the other numeric-looking text columns
-- =================================================================

SELECT 'PROGESTERONE' AS column_name, `PROGESTERONE` AS value, COUNT(*) AS frequency
FROM dataset1
GROUP BY `PROGESTERONE`

UNION ALL

SELECT 'NUMBER OF OOCYTES', `NUMBER OF OOCYTES`, COUNT(*)
FROM dataset1
GROUP BY `NUMBER OF OOCYTES`

UNION ALL

SELECT 'ENDOMETRIAL THICKNESS', `ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER`, COUNT(*)
FROM dataset1
GROUP BY `ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER`

ORDER BY column_name, frequency DESC;

-- ===========================================
-- Checking unusually high number of oocytes
-- =========================================
SELECT
    `PATIENT NAME AND SURNAME`,
    `NUMBER OF OOCYTES`,
    `age`,
    `Clinical pregnancy: 0:0, Chemical: 1:1 Positive`,
    `Live Birth`,
    `Number of Embryos Transferred`
FROM dataset1
WHERE CAST(`NUMBER OF OOCYTES` AS DECIMAL(10,2)) > 50
ORDER BY CAST(`NUMBER OF OOCYTES` AS DECIMAL(10,2)) DESC;

-- ====================================================
-- Check invalid text values in numeric-looking columns
-- ====================================================

SELECT
    'E2' AS column_name,
    COUNT(*) AS invalid_values
FROM dataset1
WHERE `E2` IS NOT NULL
  AND TRIM(`E2`) <> ''
  AND `E2` NOT REGEXP '^[0-9]+(\\.[0-9]+)?$'

UNION ALL

SELECT
    'PROGESTERONE',
    COUNT(*)
FROM dataset1
WHERE `PROGESTERONE` IS NOT NULL
  AND TRIM(`PROGESTERONE`) <> ''
  AND `PROGESTERONE` NOT REGEXP '^[0-9]+([\\.,][0-9]+)?$'

UNION ALL

SELECT
    'NUMBER OF OOCYTES',
    COUNT(*)
FROM dataset1
WHERE `NUMBER OF OOCYTES` IS NOT NULL
  AND TRIM(`NUMBER OF OOCYTES`) <> ''
  AND `NUMBER OF OOCYTES` NOT REGEXP '^[0-9]+$'

UNION ALL

SELECT
    'ENDOMETRIAL THICKNESS',
    COUNT(*)
FROM dataset1
WHERE `ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER` IS NOT NULL
  AND TRIM(`ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER`) <> ''
  AND `ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER` NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';
 
-- =================================
-- Show the exact non-numeric values
-- =================================

SELECT 'E2' AS column_name, `E2` AS value
FROM dataset1
WHERE `E2` IS NOT NULL
  AND TRIM(`E2`) <> ''
  AND `E2` NOT REGEXP '^[0-9]+(\\.[0-9]+)?$'

UNION ALL

SELECT 'PROGESTERONE', `PROGESTERONE`
FROM dataset1
WHERE `PROGESTERONE` IS NOT NULL
  AND TRIM(`PROGESTERONE`) <> ''
  AND `PROGESTERONE` NOT REGEXP '^[0-9]+([\\.,][0-9]+)?$'

UNION ALL

SELECT 'ENDOMETRIAL THICKNESS',
       `ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER`
FROM dataset1
WHERE `ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER` IS NOT NULL
  AND TRIM(`ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER`) <> ''
  AND `ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER` NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';
  
## Check basic statistics for numeric columns

SELECT
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    AVG(age) AS avg_age,
    MIN(`Spouse AGE`) AS min_spouse_age,
    MAX(`Spouse AGE`) AS max_spouse_age,
    AVG(`Spouse AGE`) AS avg_spouse_age,
    MIN(`WEEK OF BIRTH`) AS min_week,
    MAX(`WEEK OF BIRTH`) AS max_week,
    AVG(`WEEK OF BIRTH`) AS avg_week,
    MIN(FSH) AS min_fsh,
    MAX(FSH) AS max_fsh,
    AVG(FSH) AS avg_fsh,
    MIN(AMH) AS min_amh,
    MAX(AMH) AS max_amh,
    AVG(AMH) AS avg_amh
FROM dataset1;

### Check basic statistics for remaining numeric columns

SELECT
    MIN(`BHCG 12`) AS min_bhcg12,
    MAX(`BHCG 12`) AS max_bhcg12,
    AVG(`BHCG 12`) AS avg_bhcg12,

    MIN(`BHCG 14`) AS min_bhcg14,
    MAX(`BHCG 14`) AS max_bhcg14,
    AVG(`BHCG 14`) AS avg_bhcg14,

    MIN(`BHCG 12-14% increase`) AS min_bhcg_increase,
    MAX(`BHCG 12-14% increase`) AS max_bhcg_increase,
    AVG(`BHCG 12-14% increase`) AS avg_bhcg_increase,

    MIN(Indication) AS min_indication,
    MAX(Indication) AS max_indication,
    AVG(Indication) AS avg_indication,

    MIN(`Embryo Tranfer Day`) AS min_transfer_day,
    MAX(`Embryo Tranfer Day`) AS max_transfer_day,
    AVG(`Embryo Tranfer Day`) AS avg_transfer_day,

    MIN(`Number of Embryos Transferred`) AS min_embryos,
    MAX(`Number of Embryos Transferred`) AS max_embryos,
    AVG(`Number of Embryos Transferred`) AS avg_embryos
FROM dataset1;

### Check extreme BHCG increase values

SELECT
    `BHCG 12`,
    `BHCG 14`,
    `BHCG 12-14% increase`,
    `Clinical pregnancy: 0:0, Chemical: 1:1 Positive`,
    `Live Birth`
FROM dataset1
WHERE `BHCG 12-14% increase` < 0
   OR `BHCG 12-14% increase` > 500
ORDER BY `BHCG 12-14% increase`;

### Check all categorical values for inconsistencies

SELECT
    `Clinical pregnancy: 0:0, Chemical: 1:1 Positive` AS clinical_pregnancy,
    COUNT(*) AS frequency
FROM dataset1
GROUP BY `Clinical pregnancy: 0:0, Chemical: 1:1 Positive`
ORDER BY frequency DESC;

### Check abortion values for inconsistencies

SELECT
    `ABORTION` AS abortion,
    COUNT(*) AS frequency
FROM dataset1
GROUP BY `ABORTION`
ORDER BY frequency DESC;

### Check Live Birth, Neonatal Death, and Twin values

SELECT
    'Live Birth' AS column_name,
    CAST(`Live Birth` AS CHAR) AS value,
    COUNT(*) AS frequency
FROM dataset1
GROUP BY `Live Birth`
UNION ALL
SELECT
    'Neonatal Death',
    CAST(`Neonatal Death` AS CHAR),
    COUNT(*)
FROM dataset1
GROUP BY `Neonatal Death`
UNION ALL
SELECT
    'Twin',
    CAST(`twin` AS CHAR),
    COUNT(*)
FROM dataset1
GROUP BY `twin`
ORDER BY column_name, frequency DESC;

### Check Indication values for inconsistencies

SELECT
    `Indication` AS indication,
    COUNT(*) AS frequency
FROM dataset1
GROUP BY `Indication`
ORDER BY frequency DESC;

### Check Week of Birth values

SELECT
    `WEEK OF BIRTH` AS week_of_birth,
    COUNT(*) AS frequency
FROM dataset1
GROUP BY `WEEK OF BIRTH`
ORDER BY `WEEK OF BIRTH`;

### Check for negative values in numeric columns

SELECT
    COUNT(*) AS invalid_negative_values
FROM dataset1
WHERE age < 0
   OR `Spouse AGE` < 0
   OR `WEEK OF BIRTH` < 0
   OR `BHCG 12` < 0
   OR `BHCG 14` < 0
   OR FSH < 0
   OR Indication < 0
   OR `Embryo Tranfer Day` < 0
   OR `Number of Embryos Transferred` < 0
   OR AMH < 0;
   
### Check age values for unusual records

SELECT
    age,
    COUNT(*) AS frequency
FROM dataset1
GROUP BY age
ORDER BY age;

### Calculate mean and standard deviation for numeric columns

SELECT
    'age' AS column_name,
    COUNT(age) AS total_values,
    ROUND(AVG(age), 2) AS mean_value,
    ROUND(STDDEV(age), 2) AS std_dev
FROM dataset1

UNION ALL

SELECT
    'Spouse AGE',
    COUNT(`Spouse AGE`),
    ROUND(AVG(`Spouse AGE`), 2),
    ROUND(STDDEV(`Spouse AGE`), 2)
FROM dataset1

UNION ALL

SELECT
    'WEEK OF BIRTH',
    COUNT(`WEEK OF BIRTH`),
    ROUND(AVG(`WEEK OF BIRTH`), 2),
    ROUND(STDDEV(`WEEK OF BIRTH`), 2)
FROM dataset1

UNION ALL

SELECT
    'BHCG 12',
    COUNT(`BHCG 12`),
    ROUND(AVG(`BHCG 12`), 2),
    ROUND(STDDEV(`BHCG 12`), 2)
FROM dataset1

UNION ALL

SELECT
    'BHCG 14',
    COUNT(`BHCG 14`),
    ROUND(AVG(`BHCG 14`), 2),
    ROUND(STDDEV(`BHCG 14`), 2)
FROM dataset1

UNION ALL

SELECT
    'FSH',
    COUNT(FSH),
    ROUND(AVG(FSH), 2),
    ROUND(STDDEV(FSH), 2)
FROM dataset1

UNION ALL

SELECT
    'AMH',
    COUNT(AMH),
    ROUND(AVG(AMH), 2),
    ROUND(STDDEV(AMH), 2)
FROM dataset1;

### Calculate mean and standard deviation for remaining numeric columns

SELECT
    'BHCG 12-14% increase' AS column_name,
    COUNT(`BHCG 12-14% increase`) AS total_values,
    ROUND(AVG(`BHCG 12-14% increase`), 2) AS mean_value,
    ROUND(STDDEV(`BHCG 12-14% increase`), 2) AS std_dev
FROM dataset1

UNION ALL

SELECT
    'Indication',
    COUNT(Indication),
    ROUND(AVG(Indication), 2),
    ROUND(STDDEV(Indication), 2)
FROM dataset1

UNION ALL

SELECT
    'Embryo Tranfer Day',
    COUNT(`Embryo Tranfer Day`),
    ROUND(AVG(`Embryo Tranfer Day`), 2),
    ROUND(STDDEV(`Embryo Tranfer Day`), 2)
FROM dataset1

UNION ALL

SELECT
    'Number of Embryos Transferred',
    COUNT(`Number of Embryos Transferred`),
    ROUND(AVG(`Number of Embryos Transferred`), 2),
    ROUND(STDDEV(`Number of Embryos Transferred`), 2)
FROM dataset1;

### Identify potential statistical outliers using mean ± 3 standard deviations

SELECT
    'age' AS column_name,
    COUNT(*) AS potential_outliers
FROM dataset1
WHERE age < (SELECT AVG(age) - 3 * STDDEV(age) FROM dataset1)
   OR age > (SELECT AVG(age) + 3 * STDDEV(age) FROM dataset1)

UNION ALL

SELECT
    'Spouse AGE',
    COUNT(*)
FROM dataset1
WHERE `Spouse AGE` < (SELECT AVG(`Spouse AGE`) - 3 * STDDEV(`Spouse AGE`) FROM dataset1)
   OR `Spouse AGE` > (SELECT AVG(`Spouse AGE`) + 3 * STDDEV(`Spouse AGE`) FROM dataset1)

UNION ALL

SELECT
    'WEEK OF BIRTH',
    COUNT(*)
FROM dataset1
WHERE `WEEK OF BIRTH` < (SELECT AVG(`WEEK OF BIRTH`) - 3 * STDDEV(`WEEK OF BIRTH`) FROM dataset1)
   OR `WEEK OF BIRTH` > (SELECT AVG(`WEEK OF BIRTH`) + 3 * STDDEV(`WEEK OF BIRTH`) FROM dataset1)

UNION ALL

SELECT
    'BHCG 12',
    COUNT(*)
FROM dataset1
WHERE `BHCG 12` < (SELECT AVG(`BHCG 12`) - 3 * STDDEV(`BHCG 12`) FROM dataset1)
   OR `BHCG 12` > (SELECT AVG(`BHCG 12`) + 3 * STDDEV(`BHCG 12`) FROM dataset1)

UNION ALL

SELECT
    'BHCG 14',
    COUNT(*)
FROM dataset1
WHERE `BHCG 14` < (SELECT AVG(`BHCG 14`) - 3 * STDDEV(`BHCG 14`) FROM dataset1)
   OR `BHCG 14` > (SELECT AVG(`BHCG 14`) + 3 * STDDEV(`BHCG 14`) FROM dataset1)

UNION ALL

SELECT
    'FSH',
    COUNT(*)
FROM dataset1
WHERE FSH < (SELECT AVG(FSH) - 3 * STDDEV(FSH) FROM dataset1)
   OR FSH > (SELECT AVG(FSH) + 3 * STDDEV(FSH) FROM dataset1)

UNION ALL

SELECT
    'AMH',
    COUNT(*)
FROM dataset1
WHERE AMH < (SELECT AVG(AMH) - 3 * STDDEV(AMH) FROM dataset1)
   OR AMH > (SELECT AVG(AMH) + 3 * STDDEV(AMH) FROM dataset1)

UNION ALL

SELECT
    'BHCG 12-14% increase',
    COUNT(*)
FROM dataset1
WHERE `BHCG 12-14% increase` < (SELECT AVG(`BHCG 12-14% increase`) - 3 * STDDEV(`BHCG 12-14% increase`) FROM dataset1)
   OR `BHCG 12-14% increase` > (SELECT AVG(`BHCG 12-14% increase`) + 3 * STDDEV(`BHCG 12-14% increase`) FROM dataset1)

UNION ALL

SELECT
    'Indication',
    COUNT(*)
FROM dataset1
WHERE Indication < (SELECT AVG(Indication) - 3 * STDDEV(Indication) FROM dataset1)
   OR Indication > (SELECT AVG(Indication) + 3 * STDDEV(Indication) FROM dataset1)

UNION ALL

SELECT
    'Embryo Tranfer Day',
    COUNT(*)
FROM dataset1
WHERE `Embryo Tranfer Day` < (SELECT AVG(`Embryo Tranfer Day`) - 3 * STDDEV(`Embryo Tranfer Day`) FROM dataset1)
   OR `Embryo Tranfer Day` > (SELECT AVG(`Embryo Tranfer Day`) + 3 * STDDEV(`Embryo Tranfer Day`) FROM dataset1)

UNION ALL

SELECT
    'Number of Embryos Transferred',
    COUNT(*)
FROM dataset1
WHERE `Number of Embryos Transferred` < (SELECT AVG(`Number of Embryos Transferred`) - 3 * STDDEV(`Number of Embryos Transferred`) FROM dataset1)
   OR `Number of Embryos Transferred` > (SELECT AVG(`Number of Embryos Transferred`) + 3 * STDDEV(`Number of Embryos Transferred`) FROM dataset1);
   
   
### Check numeric-format consistency in text columns

SELECT
    'E2' AS column_name,
    COUNT(*) AS invalid_values
FROM dataset1
WHERE `E2` IS NOT NULL
  AND TRIM(`E2`) <> ''
  AND `E2` NOT REGEXP '^[0-9]+(\\.[0-9]+)?$'

UNION ALL

SELECT
    'PROGESTERONE',
    COUNT(*)
FROM dataset1
WHERE `PROGESTERONE` IS NOT NULL
  AND TRIM(`PROGESTERONE`) <> ''
  AND `PROGESTERONE` NOT REGEXP '^[0-9]+(\\.[0-9]+)?$'

UNION ALL

SELECT
    'NUMBER OF OOCYTES',
    COUNT(*)
FROM dataset1
WHERE `NUMBER OF OOCYTES` IS NOT NULL
  AND TRIM(`NUMBER OF OOCYTES`) <> ''
  AND `NUMBER OF OOCYTES` NOT REGEXP '^[0-9]+(\\.[0-9]+)?$'

UNION ALL

SELECT
    'ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER',
    COUNT(*)
FROM dataset1
WHERE `ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER` IS NOT NULL
  AND TRIM(`ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER`) <> ''
  AND `ENDOMETRIAL THICKNESS ON THE DAY OF TRANSFER` NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';