### Dataset 3
### Check column names and data types

DESCRIBE dataset3;

### Dataset 3
### Inspect first 10 rows

SELECT *
FROM dataset3
LIMIT 10;

### Dataset 3
### Check total rows and NULL values in all columns

SELECT
    COUNT(*) AS total_rows,
    SUM(`Fc no` IS NULL) AS fc_no_nulls,
    SUM(`Cycle no` IS NULL) AS cycle_no_nulls,
    SUM(`Age` IS NULL) AS age_nulls,
    SUM(`Duration of infertility` IS NULL) AS infertility_duration_nulls,
    SUM(`BMI` IS NULL) AS bmi_nulls,
    SUM(`Primary infertility` IS NULL) AS primary_infertility_nulls,
    SUM(`Male/female/combined` IS NULL) AS sex_nulls,
    SUM(`Cause` IS NULL) AS cause_nulls,
    SUM(`AFC` IS NULL) AS afc_nulls,
    SUM(`AMH ng/ml` IS NULL) AS amh_nulls,
    SUM(`Protocol` IS NULL) AS protocol_nulls,
    SUM(`Stimulation` IS NULL) AS stimulation_nulls,
    SUM(`LH from start` IS NULL) AS lh_nulls,
    SUM(`Days of stimulation` IS NULL) AS stimulation_days_nulls,
    SUM(`E2 on trigger day` IS NULL) AS e2_nulls,
    SUM(`P4 on trigger day` IS NULL) AS p4_nulls,
    SUM(`Trigger` IS NULL) AS trigger_nulls,
    SUM(`Large follicles` IS NULL) AS large_follicles_nulls,
    SUM(`Total oocytes` IS NULL) AS total_oocytes_nulls,
    SUM(`M2 oocytes` IS NULL) AS m2_oocytes_nulls,
    SUM(`Sperm` IS NULL) AS sperm_nulls,
    SUM(`SSR` IS NULL) AS ssr_nulls,
    SUM(`Donor` IS NULL) AS donor_nulls,
    SUM(`2PN no` IS NULL) AS two_pn_nulls,
    SUM(`SER` IS NULL) AS ser_nulls,
    SUM(`Embryos formed` IS NULL) AS embryos_formed_nulls,
    SUM(`No of embryos frozen` IS NULL) AS embryos_frozen_nulls,
    SUM(`sets` IS NULL) AS sets_nulls,
    SUM(`all freeze` IS NULL) AS all_freeze_nulls,
    SUM(`time from IVF months` IS NULL) AS time_from_ivf_nulls,
    SUM(`endo prep` IS NULL) AS endo_prep_nulls,
    SUM(`ET` IS NULL) AS et_nulls,
    SUM(`Zone` IS NULL) AS zone_nulls,
    SUM(`Morphology` IS NULL) AS morphology_nulls,
    SUM(`Day of embryo transfer` IS NULL) AS transfer_day_nulls,
    SUM(`transferred embryos` IS NULL) AS transferred_embryos_nulls,
    SUM(`Embryos` IS NULL) AS embryos_nulls,
    SUM(`Blast y/n` IS NULL) AS blast_nulls,
    SUM(`Good blast` IS NULL) AS good_blast_nulls,
    SUM(`Emb G/P` IS NULL) AS emb_gp_nulls,
    SUM(`Remain set` IS NULL) AS remain_set_nulls,
    SUM(`Difficult transfer` IS NULL) AS difficult_transfer_nulls,
    SUM(`Fundus distance mm` IS NULL) AS fundus_distance_nulls,
    SUM(`Result` IS NULL) AS result_nulls,
    SUM(`Biochemical` IS NULL) AS biochemical_nulls,
    SUM(`Ectopic` IS NULL) AS ectopic_nulls,
    SUM(`Clinical preg` IS NULL) AS clinical_preg_nulls,
    SUM(`Twin` IS NULL) AS twin_nulls,
    SUM(`Triplet` IS NULL) AS triplet_nulls,
    SUM(`Miscarriage` IS NULL) AS miscarriage_nulls,
    SUM(`Ongoing` IS NULL) AS ongoing_nulls,
    SUM(`Remark` IS NULL) AS remark_nulls
FROM dataset3;

### Dataset 3
### Check blank or empty text values

SELECT
    SUM(TRIM(`Fc no`) = '') AS fc_no_blank,
    SUM(TRIM(`Male/female/combined`) = '') AS sex_blank,
    SUM(TRIM(`Cause`) = '') AS cause_blank,
    SUM(TRIM(`Protocol`) = '') AS protocol_blank,
    SUM(TRIM(`Stimulation`) = '') AS stimulation_blank,
    SUM(TRIM(`Trigger`) = '') AS trigger_blank,
    SUM(TRIM(`Sperm`) = '') AS sperm_blank,
    SUM(TRIM(`2PN no`) = '') AS two_pn_blank,
    SUM(TRIM(`Embryos formed`) = '') AS embryos_formed_blank,
    SUM(TRIM(`No of embryos frozen`) = '') AS embryos_frozen_blank,
    SUM(TRIM(`endo prep`) = '') AS endo_prep_blank,
    SUM(TRIM(`Morphology`) = '') AS morphology_blank,
    SUM(TRIM(`Day of embryo transfer`) = '') AS transfer_day_blank,
    SUM(TRIM(`Embryos`) = '') AS embryos_blank,
    SUM(TRIM(`Emb G/P`) = '') AS emb_gp_blank,
    SUM(TRIM(`Remain set`) = '') AS remain_set_blank,
    SUM(TRIM(`Miscarriage`) = '') AS miscarriage_blank,
    SUM(TRIM(`Remark`) = '') AS remark_blank
FROM dataset3;

### Dataset 3
### Check duplicate rows

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT CONCAT_WS('|',
        `Fc no`,
        `Cycle no`,
        `Age`,
        `Duration of infertility`,
        `BMI`,
        `Primary infertility`,
        `Male/female/combined`,
        `Cause`,
        `AFC`,
        `AMH ng/ml`,
        `Protocol`,
        `Stimulation`,
        `LH from start`,
        `Days of stimulation`,
        `E2 on trigger day`,
        `P4 on trigger day`,
        `Trigger`,
        `Large follicles`,
        `Total oocytes`,
        `M2 oocytes`,
        `Sperm`,
        `SSR`,
        `Donor`,
        `2PN no`,
        `SER`,
        `Embryos formed`,
        `No of embryos frozen`,
        `sets`,
        `all freeze`,
        `time from IVF months`,
        `endo prep`,
        `ET`,
        `Zone`,
        `Morphology`,
        `Day of embryo transfer`,
        `transferred embryos`,
        `Embryos`,
        `Blast y/n`,
        `Good blast`,
        `Emb G/P`,
        `Remain set`,
        `Difficult transfer`,
        `Fundus distance mm`,
        `Result`,
        `Biochemical`,
        `Ectopic`,
        `Clinical preg`,
        `Twin`,
        `Triplet`,
        `Miscarriage`,
        `Ongoing`,
        `Remark`
    )) AS distinct_rows,
    COUNT(*) - COUNT(DISTINCT CONCAT_WS('|',
        `Fc no`,
        `Cycle no`,
        `Age`,
        `Duration of infertility`,
        `BMI`,
        `Primary infertility`,
        `Male/female/combined`,
        `Cause`,
        `AFC`,
        `AMH ng/ml`,
        `Protocol`,
        `Stimulation`,
        `LH from start`,
        `Days of stimulation`,
        `E2 on trigger day`,
        `P4 on trigger day`,
        `Trigger`,
        `Large follicles`,
        `Total oocytes`,
        `M2 oocytes`,
        `Sperm`,
        `SSR`,
        `Donor`,
        `2PN no`,
        `SER`,
        `Embryos formed`,
        `No of embryos frozen`,
        `sets`,
        `all freeze`,
        `time from IVF months`,
        `endo prep`,
        `ET`,
        `Zone`,
        `Morphology`,
        `Day of embryo transfer`,
        `transferred embryos`,
        `Embryos`,
        `Blast y/n`,
        `Good blast`,
        `Emb G/P`,
        `Remain set`,
        `Difficult transfer`,
        `Fundus distance mm`,
        `Result`,
        `Biochemical`,
        `Ectopic`,
        `Clinical preg`,
        `Twin`,
        `Triplet`,
        `Miscarriage`,
        `Ongoing`,
        `Remark`
    )) AS duplicate_rows
FROM dataset3;

### Dataset 3
### Check categorical values

SELECT 'Male/female/combined' AS column_name, `Male/female/combined` AS value, COUNT(*) AS count
FROM dataset3
GROUP BY `Male/female/combined`

UNION ALL

SELECT 'Cause', `Cause`, COUNT(*)
FROM dataset3
GROUP BY `Cause`

UNION ALL

SELECT 'Protocol', `Protocol`, COUNT(*)
FROM dataset3
GROUP BY `Protocol`

UNION ALL

SELECT 'Stimulation', `Stimulation`, COUNT(*)
FROM dataset3
GROUP BY `Stimulation`

UNION ALL

SELECT 'Trigger', `Trigger`, COUNT(*)
FROM dataset3
GROUP BY `Trigger`

UNION ALL

SELECT 'Sperm', `Sperm`, COUNT(*)
FROM dataset3
GROUP BY `Sperm`

UNION ALL

SELECT 'endo prep', `endo prep`, COUNT(*)
FROM dataset3
GROUP BY `endo prep`

UNION ALL

SELECT 'Morphology', `Morphology`, COUNT(*)
FROM dataset3
GROUP BY `Morphology`

UNION ALL

SELECT 'Day of embryo transfer', `Day of embryo transfer`, COUNT(*)
FROM dataset3
GROUP BY `Day of embryo transfer`

UNION ALL

SELECT 'Emb G/P', `Emb G/P`, COUNT(*)
FROM dataset3
GROUP BY `Emb G/P`

UNION ALL

SELECT 'Remain set', `Remain set`, COUNT(*)
FROM dataset3
GROUP BY `Remain set`

UNION ALL

SELECT 'Miscarriage', `Miscarriage`, COUNT(*)
FROM dataset3
GROUP BY `Miscarriage`;

### Dataset 3
### Investigate whitespace inconsistencies

SELECT
    'endo prep' AS column_name,
    CONCAT('[', `endo prep`, ']') AS actual_value,
    LENGTH(`endo prep`) AS value_length,
    COUNT(*) AS count
FROM dataset3
GROUP BY `endo prep`

UNION ALL

SELECT
    'Sperm',
    CONCAT('[', `Sperm`, ']'),
    LENGTH(`Sperm`),
    COUNT(*)
FROM dataset3
WHERE `Sperm` LIKE '%PESA%'
GROUP BY `Sperm`

UNION ALL

SELECT
    'Remain set',
    CONCAT('[', `Remain set`),
    LENGTH(`Remain set`),
    COUNT(*)
FROM dataset3
GROUP BY `Remain set`;

### Dataset 3
### Check minimum and maximum values of numeric columns

SELECT
    MIN(`Cycle no`) AS cycle_min,
    MAX(`Cycle no`) AS cycle_max,
    MIN(`Age`) AS age_min,
    MAX(`Age`) AS age_max,
    MIN(`Duration of infertility`) AS infertility_duration_min,
    MAX(`Duration of infertility`) AS infertility_duration_max,
    MIN(`BMI`) AS bmi_min,
    MAX(`BMI`) AS bmi_max,
    MIN(`Primary infertility`) AS primary_infertility_min,
    MAX(`Primary infertility`) AS primary_infertility_max,
    MIN(`AFC`) AS afc_min,
    MAX(`AFC`) AS afc_max,
    MIN(`AMH ng/ml`) AS amh_min,
    MAX(`AMH ng/ml`) AS amh_max,
    MIN(`LH from start`) AS lh_min,
    MAX(`LH from start`) AS lh_max,
    MIN(`Days of stimulation`) AS stimulation_days_min,
    MAX(`Days of stimulation`) AS stimulation_days_max,
    MIN(`E2 on trigger day`) AS e2_min,
    MAX(`E2 on trigger day`) AS e2_max,
    MIN(`P4 on trigger day`) AS p4_min,
    MAX(`P4 on trigger day`) AS p4_max,
    MIN(`Large follicles`) AS large_follicles_min,
    MAX(`Large follicles`) AS large_follicles_max,
    MIN(`Total oocytes`) AS total_oocytes_min,
    MAX(`Total oocytes`) AS total_oocytes_max,
    MIN(`M2 oocytes`) AS m2_oocytes_min,
    MAX(`M2 oocytes`) AS m2_oocytes_max,
    MIN(`SSR`) AS ssr_min,
    MAX(`SSR`) AS ssr_max,
    MIN(`Donor`) AS donor_min,
    MAX(`Donor`) AS donor_max,
    MIN(`SER`) AS ser_min,
    MAX(`SER`) AS ser_max,
    MIN(`sets`) AS sets_min,
    MAX(`sets`) AS sets_max,
    MIN(`all freeze`) AS all_freeze_min,
    MAX(`all freeze`) AS all_freeze_max,
    MIN(`time from IVF months`) AS ivf_months_min,
    MAX(`time from IVF months`) AS ivf_months_max,
    MIN(`ET`) AS et_min,
    MAX(`ET`) AS et_max,
    MIN(`Zone`) AS zone_min,
    MAX(`Zone`) AS zone_max,
    MIN(`transferred embryos`) AS transferred_embryos_min,
    MAX(`transferred embryos`) AS transferred_embryos_max,
    MIN(`Blast y/n`) AS blast_min,
    MAX(`Blast y/n`) AS blast_max,
    MIN(`Good blast`) AS good_blast_min,
    MAX(`Good blast`) AS good_blast_max,
    MIN(`Difficult transfer`) AS difficult_transfer_min,
    MAX(`Difficult transfer`) AS difficult_transfer_max,
    MIN(`Fundus distance mm`) AS fundus_distance_min,
    MAX(`Fundus distance mm`) AS fundus_distance_max,
    MIN(`Result`) AS result_min,
    MAX(`Result`) AS result_max,
    MIN(`Biochemical`) AS biochemical_min,
    MAX(`Biochemical`) AS biochemical_max,
    MIN(`Ectopic`) AS ectopic_min,
    MAX(`Ectopic`) AS ectopic_max,
    MIN(`Clinical preg`) AS clinical_preg_min,
    MAX(`Clinical preg`) AS clinical_preg_max,
    MIN(`Twin`) AS twin_min,
    MAX(`Twin`) AS twin_max,
    MIN(`Triplet`) AS triplet_min,
    MAX(`Triplet`) AS triplet_max,
    MIN(`Ongoing`) AS ongoing_min,
    MAX(`Ongoing`) AS ongoing_max
FROM dataset3;

### Dataset 3
### Check binary and categorical numeric fields

SELECT 'Primary infertility' AS column_name, `Primary infertility` AS value, COUNT(*) AS count
FROM dataset3
GROUP BY `Primary infertility`

UNION ALL

SELECT 'SSR', `SSR`, COUNT(*)
FROM dataset3
GROUP BY `SSR`

UNION ALL

SELECT 'Donor', `Donor`, COUNT(*)
FROM dataset3
GROUP BY `Donor`

UNION ALL

SELECT 'sets', `sets`, COUNT(*)
FROM dataset3
GROUP BY `sets`

UNION ALL

SELECT 'all freeze', `all freeze`, COUNT(*)
FROM dataset3
GROUP BY `all freeze`

UNION ALL

SELECT 'Zone', `Zone`, COUNT(*)
FROM dataset3
GROUP BY `Zone`

UNION ALL

SELECT 'Blast y/n', `Blast y/n`, COUNT(*)
FROM dataset3
GROUP BY `Blast y/n`

UNION ALL

SELECT 'Good blast', `Good blast`, COUNT(*)
FROM dataset3
GROUP BY `Good blast`

UNION ALL

SELECT 'Difficult transfer', `Difficult transfer`, COUNT(*)
FROM dataset3
GROUP BY `Difficult transfer`

UNION ALL

SELECT 'Result', `Result`, COUNT(*)
FROM dataset3
GROUP BY `Result`

UNION ALL

SELECT 'Biochemical', `Biochemical`, COUNT(*)
FROM dataset3
GROUP BY `Biochemical`

UNION ALL

SELECT 'Ectopic', `Ectopic`, COUNT(*)
FROM dataset3
GROUP BY `Ectopic`

UNION ALL

SELECT 'Clinical preg', `Clinical preg`, COUNT(*)
FROM dataset3
GROUP BY `Clinical preg`

UNION ALL

SELECT 'Twin', `Twin`, COUNT(*)
FROM dataset3
GROUP BY `Twin`

UNION ALL

SELECT 'Triplet', `Triplet`, COUNT(*)
FROM dataset3
GROUP BY `Triplet`

UNION ALL

SELECT 'Ongoing', `Ongoing`, COUNT(*)
FROM dataset3
GROUP BY `Ongoing`;

### Dataset 3
### Check logical consistency between related columns

SELECT
    SUM(`M2 oocytes` > `Total oocytes`) AS m2_greater_than_total_oocytes,
    SUM(`transferred embryos` > `Embryos formed`) AS transferred_greater_than_formed,
    SUM(`Triplet` = 1 AND `Twin` = 1) AS twin_and_triplet_both_1,
    SUM(`Clinical preg` = 0 AND `Ongoing` = 1) AS ongoing_without_clinical_preg,
    SUM(`Clinical preg` = 0 AND `Twin` = 1) AS twin_without_clinical_preg,
    SUM(`Clinical preg` = 0 AND `Triplet` = 1) AS triplet_without_clinical_preg,
    SUM(`Result` = 0 AND `Clinical preg` = 1) AS clinical_preg_without_positive_result,
    SUM(`all freeze` = 1 AND `No of embryos frozen` IS NULL) AS freeze_without_frozen_embryo_value,
    SUM(`Blast y/n` = 0 AND `Good blast` > 0) AS good_blast_without_blast,
    SUM(`Blast y/n` = 1 AND `Good blast` = 0) AS blast_without_good_blast
FROM dataset3;

### Dataset 3
### Investigate Blast = 1 but Good blast = 0

SELECT
    `Fc no`,
    `Blast y/n`,
    `Good blast`,
    `Embryos formed`,
    `Embryos`,
    `Emb G/P`,
    `Remain set`,
    `Day of embryo transfer`,
    `transferred embryos`,
    `Result`,
    `Clinical preg`
FROM dataset3
WHERE `Blast y/n` = 1
  AND `Good blast` = 0;
  
### Dataset 3
### Check mean, standard deviation, minimum and maximum for continuous variables

SELECT
    'Age' AS column_name,
    AVG(`Age`) AS mean_value,
    STDDEV(`Age`) AS std_dev,
    MIN(`Age`) AS min_value,
    MAX(`Age`) AS max_value
FROM dataset3

UNION ALL

SELECT
    'Duration of infertility',
    AVG(`Duration of infertility`),
    STDDEV(`Duration of infertility`),
    MIN(`Duration of infertility`),
    MAX(`Duration of infertility`)
FROM dataset3

UNION ALL

SELECT
    'BMI',
    AVG(`BMI`),
    STDDEV(`BMI`),
    MIN(`BMI`),
    MAX(`BMI`)
FROM dataset3

UNION ALL

SELECT
    'AFC',
    AVG(`AFC`),
    STDDEV(`AFC`),
    MIN(`AFC`),
    MAX(`AFC`)
FROM dataset3

UNION ALL

SELECT
    'AMH ng/ml',
    AVG(`AMH ng/ml`),
    STDDEV(`AMH ng/ml`),
    MIN(`AMH ng/ml`),
    MAX(`AMH ng/ml`)
FROM dataset3

UNION ALL

SELECT
    'E2 on trigger day',
    AVG(`E2 on trigger day`),
    STDDEV(`E2 on trigger day`),
    MIN(`E2 on trigger day`),
    MAX(`E2 on trigger day`)
FROM dataset3

UNION ALL

SELECT
    'P4 on trigger day',
    AVG(`P4 on trigger day`),
    STDDEV(`P4 on trigger day`),
    MIN(`P4 on trigger day`),
    MAX(`P4 on trigger day`)
FROM dataset3

UNION ALL

SELECT
    'Large follicles',
    AVG(`Large follicles`),
    STDDEV(`Large follicles`),
    MIN(`Large follicles`),
    MAX(`Large follicles`)
FROM dataset3

UNION ALL

SELECT
    'Total oocytes',
    AVG(`Total oocytes`),
    STDDEV(`Total oocytes`),
    MIN(`Total oocytes`),
    MAX(`Total oocytes`)
FROM dataset3

UNION ALL

SELECT
    'M2 oocytes',
    AVG(`M2 oocytes`),
    STDDEV(`M2 oocytes`),
    MIN(`M2 oocytes`),
    MAX(`M2 oocytes`)
FROM dataset3

UNION ALL

SELECT
    'SER',
    AVG(`SER`),
    STDDEV(`SER`),
    MIN(`SER`),
    MAX(`SER`)
FROM dataset3

UNION ALL

SELECT
    'Fundus distance mm',
    AVG(`Fundus distance mm`),
    STDDEV(`Fundus distance mm`),
    MIN(`Fundus distance mm`),
    MAX(`Fundus distance mm`)
FROM dataset3;

### Dataset 3
### Check ±3 standard deviation outliers for continuous variables

SELECT 'Age' AS column_name, COUNT(*) AS outlier_count
FROM dataset3
WHERE `Age` < (SELECT AVG(`Age`) - 3 * STDDEV(`Age`) FROM dataset3)
   OR `Age` > (SELECT AVG(`Age`) + 3 * STDDEV(`Age`) FROM dataset3)

UNION ALL

SELECT 'Duration of infertility', COUNT(*)
FROM dataset3
WHERE `Duration of infertility` < (SELECT AVG(`Duration of infertility`) - 3 * STDDEV(`Duration of infertility`) FROM dataset3)
   OR `Duration of infertility` > (SELECT AVG(`Duration of infertility`) + 3 * STDDEV(`Duration of infertility`) FROM dataset3)

UNION ALL

SELECT 'BMI', COUNT(*)
FROM dataset3
WHERE `BMI` < (SELECT AVG(`BMI`) - 3 * STDDEV(`BMI`) FROM dataset3)
   OR `BMI` > (SELECT AVG(`BMI`) + 3 * STDDEV(`BMI`) FROM dataset3)

UNION ALL

SELECT 'AFC', COUNT(*)
FROM dataset3
WHERE `AFC` < (SELECT AVG(`AFC`) - 3 * STDDEV(`AFC`) FROM dataset3)
   OR `AFC` > (SELECT AVG(`AFC`) + 3 * STDDEV(`AFC`) FROM dataset3)

UNION ALL

SELECT 'AMH ng/ml', COUNT(*)
FROM dataset3
WHERE `AMH ng/ml` < (SELECT AVG(`AMH ng/ml`) - 3 * STDDEV(`AMH ng/ml`) FROM dataset3)
   OR `AMH ng/ml` > (SELECT AVG(`AMH ng/ml`) + 3 * STDDEV(`AMH ng/ml`) FROM dataset3)

UNION ALL

SELECT 'E2 on trigger day', COUNT(*)
FROM dataset3
WHERE `E2 on trigger day` < (SELECT AVG(`E2 on trigger day`) - 3 * STDDEV(`E2 on trigger day`) FROM dataset3)
   OR `E2 on trigger day` > (SELECT AVG(`E2 on trigger day`) + 3 * STDDEV(`E2 on trigger day`) FROM dataset3)

UNION ALL

SELECT 'P4 on trigger day', COUNT(*)
FROM dataset3
WHERE `P4 on trigger day` < (SELECT AVG(`P4 on trigger day`) - 3 * STDDEV(`P4 on trigger day`) FROM dataset3)
   OR `P4 on trigger day` > (SELECT AVG(`P4 on trigger day`) + 3 * STDDEV(`P4 on trigger day`) FROM dataset3)

UNION ALL

SELECT 'Large follicles', COUNT(*)
FROM dataset3
WHERE `Large follicles` < (SELECT AVG(`Large follicles`) - 3 * STDDEV(`Large follicles`) FROM dataset3)
   OR `Large follicles` > (SELECT AVG(`Large follicles`) + 3 * STDDEV(`Large follicles`) FROM dataset3)

UNION ALL

SELECT 'Total oocytes', COUNT(*)
FROM dataset3
WHERE `Total oocytes` < (SELECT AVG(`Total oocytes`) - 3 * STDDEV(`Total oocytes`) FROM dataset3)
   OR `Total oocytes` > (SELECT AVG(`Total oocytes`) + 3 * STDDEV(`Total oocytes`) FROM dataset3)

UNION ALL

SELECT 'M2 oocytes', COUNT(*)
FROM dataset3
WHERE `M2 oocytes` < (SELECT AVG(`M2 oocytes`) - 3 * STDDEV(`M2 oocytes`) FROM dataset3)
   OR `M2 oocytes` > (SELECT AVG(`M2 oocytes`) + 3 * STDDEV(`M2 oocytes`) FROM dataset3)

UNION ALL

SELECT 'SER', COUNT(*)
FROM dataset3
WHERE `SER` < (SELECT AVG(`SER`) - 3 * STDDEV(`SER`) FROM dataset3)
   OR `SER` > (SELECT AVG(`SER`) + 3 * STDDEV(`SER`) FROM dataset3)

UNION ALL

SELECT 'Fundus distance mm', COUNT(*)
FROM dataset3
WHERE `Fundus distance mm` < (SELECT AVG(`Fundus distance mm`) - 3 * STDDEV(`Fundus distance mm`) FROM dataset3)
   OR `Fundus distance mm` > (SELECT AVG(`Fundus distance mm`) + 3 * STDDEV(`Fundus distance mm`) FROM dataset3);
   
### Dataset 3
### Check mean, standard deviation, minimum and maximum for remaining numeric variables

SELECT
    'LH from start' AS column_name,
    AVG(`LH from start`) AS mean_value,
    STDDEV(`LH from start`) AS std_dev,
    MIN(`LH from start`) AS min_value,
    MAX(`LH from start`) AS max_value
FROM dataset3

UNION ALL

SELECT
    'Days of stimulation',
    AVG(`Days of stimulation`),
    STDDEV(`Days of stimulation`),
    MIN(`Days of stimulation`),
    MAX(`Days of stimulation`)
FROM dataset3

UNION ALL

SELECT
    'sets',
    AVG(`sets`),
    STDDEV(`sets`),
    MIN(`sets`),
    MAX(`sets`)
FROM dataset3

UNION ALL

SELECT
    'time from IVF months',
    AVG(`time from IVF months`),
    STDDEV(`time from IVF months`),
    MIN(`time from IVF months`),
    MAX(`time from IVF months`)
FROM dataset3

UNION ALL

SELECT
    'ET',
    AVG(`ET`),
    STDDEV(`ET`),
    MIN(`ET`),
    MAX(`ET`)
FROM dataset3

UNION ALL

SELECT
    'Zone',
    AVG(`Zone`),
    STDDEV(`Zone`),
    MIN(`Zone`),
    MAX(`Zone`)
FROM dataset3

UNION ALL

SELECT
    'transferred embryos',
    AVG(`transferred embryos`),
    STDDEV(`transferred embryos`),
    MIN(`transferred embryos`),
    MAX(`transferred embryos`)
FROM dataset3

UNION ALL

SELECT
    'Good blast',
    AVG(`Good blast`),
    STDDEV(`Good blast`),
    MIN(`Good blast`),
    MAX(`Good blast`)
FROM dataset3

UNION ALL

SELECT
    'Fundus distance mm',
    AVG(`Fundus distance mm`),
    STDDEV(`Fundus distance mm`),
    MIN(`Fundus distance mm`),
    MAX(`Fundus distance mm`)
FROM dataset3;

### Dataset 3
### Check ±3 standard deviation outliers for remaining numeric variables

SELECT 'LH from start' AS column_name, COUNT(*) AS outlier_count
FROM dataset3
WHERE `LH from start` < (SELECT AVG(`LH from start`) - 3 * STDDEV(`LH from start`) FROM dataset3)
   OR `LH from start` > (SELECT AVG(`LH from start`) + 3 * STDDEV(`LH from start`) FROM dataset3)

UNION ALL

SELECT 'Days of stimulation', COUNT(*)
FROM dataset3
WHERE `Days of stimulation` < (SELECT AVG(`Days of stimulation`) - 3 * STDDEV(`Days of stimulation`) FROM dataset3)
   OR `Days of stimulation` > (SELECT AVG(`Days of stimulation`) + 3 * STDDEV(`Days of stimulation`) FROM dataset3)

UNION ALL

SELECT 'sets', COUNT(*)
FROM dataset3
WHERE `sets` < (SELECT AVG(`sets`) - 3 * STDDEV(`sets`) FROM dataset3)
   OR `sets` > (SELECT AVG(`sets`) + 3 * STDDEV(`sets`) FROM dataset3)

UNION ALL

SELECT 'time from IVF months', COUNT(*)
FROM dataset3
WHERE `time from IVF months` < (SELECT AVG(`time from IVF months`) - 3 * STDDEV(`time from IVF months`) FROM dataset3)
   OR `time from IVF months` > (SELECT AVG(`time from IVF months`) + 3 * STDDEV(`time from IVF months`) FROM dataset3)

UNION ALL

SELECT 'ET', COUNT(*)
FROM dataset3
WHERE `ET` < (SELECT AVG(`ET`) - 3 * STDDEV(`ET`) FROM dataset3)
   OR `ET` > (SELECT AVG(`ET`) + 3 * STDDEV(`ET`) FROM dataset3)

UNION ALL

SELECT 'Zone', COUNT(*)
FROM dataset3
WHERE `Zone` < (SELECT AVG(`Zone`) - 3 * STDDEV(`Zone`) FROM dataset3)
   OR `Zone` > (SELECT AVG(`Zone`) + 3 * STDDEV(`Zone`) FROM dataset3)

UNION ALL

SELECT 'transferred embryos', COUNT(*)
FROM dataset3
WHERE `transferred embryos` < (SELECT AVG(`transferred embryos`) - 3 * STDDEV(`transferred embryos`) FROM dataset3)
   OR `transferred embryos` > (SELECT AVG(`transferred embryos`) + 3 * STDDEV(`transferred embryos`) FROM dataset3)

UNION ALL

SELECT 'Good blast', COUNT(*)
FROM dataset3
WHERE `Good blast` < (SELECT AVG(`Good blast`) - 3 * STDDEV(`Good blast`) FROM dataset3)
   OR `Good blast` > (SELECT AVG(`Good blast`) + 3 * STDDEV(`Good blast`) FROM dataset3)

UNION ALL

SELECT 'Fundus distance mm', COUNT(*)
FROM dataset3
WHERE `Fundus distance mm` < (SELECT AVG(`Fundus distance mm`) - 3 * STDDEV(`Fundus distance mm`) FROM dataset3)
   OR `Fundus distance mm` > (SELECT AVG(`Fundus distance mm`) + 3 * STDDEV(`Fundus distance mm`) FROM dataset3);
   
### Dataset 3
### Inspect statistical outliers

SELECT
    `Fc no`,
    `time from IVF months`,
    `ET`,
    `Fundus distance mm`,
    `Age`,
    `BMI`,
    `AFC`,
    `AMH ng/ml`,
    `Total oocytes`,
    `M2 oocytes`,
    `Result`,
    `Clinical preg`
FROM dataset3
WHERE `time from IVF months` < (
          SELECT AVG(`time from IVF months`) - 3 * STDDEV(`time from IVF months`)
          FROM dataset3
      )
   OR `time from IVF months` > (
          SELECT AVG(`time from IVF months`) + 3 * STDDEV(`time from IVF months`)
          FROM dataset3
      )
   OR `ET` < (
          SELECT AVG(`ET`) - 3 * STDDEV(`ET`)
          FROM dataset3
      )
   OR `ET` > (
          SELECT AVG(`ET`) + 3 * STDDEV(`ET`)
          FROM dataset3
      )
   OR `Fundus distance mm` < (
          SELECT AVG(`Fundus distance mm`) - 3 * STDDEV(`Fundus distance mm`)
          FROM dataset3
      )
   OR `Fundus distance mm` > (
          SELECT AVG(`Fundus distance mm`) + 3 * STDDEV(`Fundus distance mm`)
          FROM dataset3
      );
      
### Dataset 3
### Check values stored as text in numeric-looking columns

SELECT
    '2PN no' AS column_name,
    `2PN no` AS value,
    COUNT(*) AS count
FROM dataset3
GROUP BY `2PN no`

UNION ALL

SELECT
    'Embryos formed',
    `Embryos formed`,
    COUNT(*)
FROM dataset3
GROUP BY `Embryos formed`

UNION ALL

SELECT
    'No of embryos frozen',
    `No of embryos frozen`,
    COUNT(*)
FROM dataset3
GROUP BY `No of embryos frozen`;

### Dataset 3
### Check mixed-format and unusual values in Remain set and Miscarriage

SELECT
    'Remain set' AS column_name,
    `Remain set` AS value,
    COUNT(*) AS count
FROM dataset3
GROUP BY `Remain set`

UNION ALL

SELECT
    'Miscarriage',
    `Miscarriage`,
    COUNT(*)
FROM dataset3
GROUP BY `Miscarriage`;

### Dataset 3
### Investigate blank Remain set value

SELECT
    `Fc no`,
    `Remain set`,
    LENGTH(`Remain set`) AS value_length,
    HEX(`Remain set`) AS hex_value,
    `Embryos formed`,
    `No of embryos frozen`,
    `sets`,
    `all freeze`,
    `Embryos`,
    `Result`
FROM dataset3
WHERE TRIM(`Remain set`) = ''
   OR `Remain set` IS NULL;
   