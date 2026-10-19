### Dataset 4
### Check table structure

DESCRIBE dataset4;

### Dataset 4
### Preview the dataset

SELECT *
FROM dataset4
LIMIT 10;

### Dataset 4
### Check row count and possible embedded header

SELECT COUNT(*) AS total_rows
FROM dataset4;

SELECT *
FROM dataset4
LIMIT 1;

### Dataset 4
### Check NULL values in all columns

SELECT
    COUNT(*) AS total_rows,
    SUM(col_1 IS NULL) AS col_1_nulls,
    SUM(col_2 IS NULL) AS col_2_nulls,
    SUM(col_3 IS NULL) AS col_3_nulls,
    SUM(col_4 IS NULL) AS col_4_nulls,
    SUM(col_5 IS NULL) AS col_5_nulls,
    SUM(col_6 IS NULL) AS col_6_nulls,
    SUM(col_7 IS NULL) AS col_7_nulls,
    SUM(col_8 IS NULL) AS col_8_nulls,
    SUM(col_9 IS NULL) AS col_9_nulls,
    SUM(col_10 IS NULL) AS col_10_nulls,
    SUM(col_11 IS NULL) AS col_11_nulls,
    SUM(col_12 IS NULL) AS col_12_nulls,
    SUM(col_13 IS NULL) AS col_13_nulls,
    SUM(col_14 IS NULL) AS col_14_nulls,
    SUM(col_15 IS NULL) AS col_15_nulls,
    SUM(col_16 IS NULL) AS col_16_nulls,
    SUM(col_17 IS NULL) AS col_17_nulls,
    SUM(col_18 IS NULL) AS col_18_nulls,
    SUM(col_19 IS NULL) AS col_19_nulls,
    SUM(col_20 IS NULL) AS col_20_nulls,
    SUM(col_21 IS NULL) AS col_21_nulls,
    SUM(col_22 IS NULL) AS col_22_nulls,
    SUM(col_23 IS NULL) AS col_23_nulls,
    SUM(col_24 IS NULL) AS col_24_nulls,
    SUM(col_25 IS NULL) AS col_25_nulls,
    SUM(col_26 IS NULL) AS col_26_nulls,
    SUM(col_27 IS NULL) AS col_27_nulls,
    SUM(col_28 IS NULL) AS col_28_nulls,
    SUM(col_29 IS NULL) AS col_29_nulls,
    SUM(col_30 IS NULL) AS col_30_nulls,
    SUM(col_31 IS NULL) AS col_31_nulls,
    SUM(col_32 IS NULL) AS col_32_nulls,
    SUM(col_33 IS NULL) AS col_33_nulls,
    SUM(col_34 IS NULL) AS col_34_nulls,
    SUM(col_35 IS NULL) AS col_35_nulls,
    SUM(col_36 IS NULL) AS col_36_nulls,
    SUM(col_37 IS NULL) AS col_37_nulls,
    SUM(col_38 IS NULL) AS col_38_nulls,
    SUM(col_39 IS NULL) AS col_39_nulls,
    SUM(col_40 IS NULL) AS col_40_nulls,
    SUM(col_41 IS NULL) AS col_41_nulls,
    SUM(col_42 IS NULL) AS col_42_nulls,
    SUM(col_43 IS NULL) AS col_43_nulls,
    SUM(col_44 IS NULL) AS col_44_nulls,
    SUM(col_45 IS NULL) AS col_45_nulls,
    SUM(col_46 IS NULL) AS col_46_nulls,
    SUM(col_47 IS NULL) AS col_47_nulls,
    SUM(col_48 IS NULL) AS col_48_nulls,
    SUM(col_49 IS NULL) AS col_49_nulls,
    SUM(col_50 IS NULL) AS col_50_nulls,
    SUM(col_51 IS NULL) AS col_51_nulls,
    SUM(col_52 IS NULL) AS col_52_nulls,
    SUM(col_53 IS NULL) AS col_53_nulls,
    SUM(col_54 IS NULL) AS col_54_nulls,
    SUM(col_55 IS NULL) AS col_55_nulls,
    SUM(col_56 IS NULL) AS col_56_nulls,
    SUM(col_57 IS NULL) AS col_57_nulls,
    SUM(col_58 IS NULL) AS col_58_nulls,
    SUM(col_59 IS NULL) AS col_59_nulls,
    SUM(col_60 IS NULL) AS col_60_nulls,
    SUM(col_61 IS NULL) AS col_61_nulls,
    SUM(col_62 IS NULL) AS col_62_nulls,
    SUM(col_63 IS NULL) AS col_63_nulls,
    SUM(col_64 IS NULL) AS col_64_nulls,
    SUM(col_65 IS NULL) AS col_65_nulls,
    SUM(col_66 IS NULL) AS col_66_nulls,
    SUM(col_67 IS NULL) AS col_67_nulls,
    SUM(col_68 IS NULL) AS col_68_nulls,
    SUM(col_69 IS NULL) AS col_69_nulls,
    SUM(col_70 IS NULL) AS col_70_nulls
FROM dataset4;

### Dataset 4
### Check duplicate rows

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT CONCAT_WS('|',
        col_1,col_2,col_3,col_4,col_5,col_6,col_7,col_8,col_9,col_10,
        col_11,col_12,col_13,col_14,col_15,col_16,col_17,col_18,col_19,col_20,
        col_21,col_22,col_23,col_24,col_25,col_26,col_27,col_28,col_29,col_30,
        col_31,col_32,col_33,col_34,col_35,col_36,col_37,col_38,col_39,col_40,
        col_41,col_42,col_43,col_44,col_45,col_46,col_47,col_48,col_49,col_50,
        col_51,col_52,col_53,col_54,col_55,col_56,col_57,col_58,col_59,col_60,
        col_61,col_62,col_63,col_64,col_65,col_66,col_67,col_68,col_69,col_70
    )) AS distinct_rows,
    COUNT(*) - COUNT(DISTINCT CONCAT_WS('|',
        col_1,col_2,col_3,col_4,col_5,col_6,col_7,col_8,col_9,col_10,
        col_11,col_12,col_13,col_14,col_15,col_16,col_17,col_18,col_19,col_20,
        col_21,col_22,col_23,col_24,col_25,col_26,col_27,col_28,col_29,col_30,
        col_31,col_32,col_33,col_34,col_35,col_36,col_37,col_38,col_39,col_40,
        col_41,col_42,col_43,col_44,col_45,col_46,col_47,col_48,col_49,col_50,
        col_51,col_52,col_53,col_54,col_55,col_56,col_57,col_58,col_59,col_60,
        col_61,col_62,col_63,col_64,col_65,col_66,col_67,col_68,col_69,col_70
    )) AS duplicate_rows
FROM dataset4;

### Dataset 4
### Check blank or whitespace-only values in text columns

SELECT
    SUM(TRIM(col_1) = '') AS col_1_blank,
    SUM(TRIM(col_2) = '') AS col_2_blank,
    SUM(TRIM(col_3) = '') AS col_3_blank,
    SUM(TRIM(col_5) = '') AS col_5_blank,
    SUM(TRIM(col_6) = '') AS col_6_blank,
    SUM(TRIM(col_8) = '') AS col_8_blank,
    SUM(TRIM(col_12) = '') AS col_12_blank,
    SUM(TRIM(col_24) = '') AS col_24_blank,
    SUM(TRIM(col_26) = '') AS col_26_blank,
    SUM(TRIM(col_28) = '') AS col_28_blank,
    SUM(TRIM(col_29) = '') AS col_29_blank,
    SUM(TRIM(col_30) = '') AS col_30_blank,
    SUM(TRIM(col_31) = '') AS col_31_blank,
    SUM(TRIM(col_32) = '') AS col_32_blank,
    SUM(TRIM(col_33) = '') AS col_33_blank,
    SUM(TRIM(col_35) = '') AS col_35_blank,
    SUM(TRIM(col_36) = '') AS col_36_blank,
    SUM(TRIM(col_37) = '') AS col_37_blank,
    SUM(TRIM(col_38) = '') AS col_38_blank,
    SUM(TRIM(col_39) = '') AS col_39_blank,
    SUM(TRIM(col_40) = '') AS col_40_blank,
    SUM(TRIM(col_42) = '') AS col_42_blank,
    SUM(TRIM(col_53) = '') AS col_53_blank,
    SUM(TRIM(col_54) = '') AS col_54_blank,
    SUM(TRIM(col_55) = '') AS col_55_blank,
    SUM(TRIM(col_56) = '') AS col_56_blank,
    SUM(TRIM(col_58) = '') AS col_58_blank,
    SUM(TRIM(col_59) = '') AS col_59_blank,
    SUM(TRIM(col_60) = '') AS col_60_blank,
    SUM(TRIM(col_61) = '') AS col_61_blank,
    SUM(TRIM(col_63) = '') AS col_63_blank,
    SUM(TRIM(col_64) = '') AS col_64_blank,
    SUM(TRIM(col_67) = '') AS col_67_blank
FROM dataset4;

### Dataset 4
### Check numeric ranges

SELECT 'col_4' AS column_name, MIN(col_4) AS min_value, MAX(col_4) AS max_value, AVG(col_4) AS avg_value FROM dataset4
UNION ALL
SELECT 'col_7', MIN(col_7), MAX(col_7), AVG(col_7) FROM dataset4
UNION ALL
SELECT 'col_9', MIN(col_9), MAX(col_9), AVG(col_9) FROM dataset4
UNION ALL
SELECT 'col_10', MIN(col_10), MAX(col_10), AVG(col_10) FROM dataset4
UNION ALL
SELECT 'col_11', MIN(col_11), MAX(col_11), AVG(col_11) FROM dataset4
UNION ALL
SELECT 'col_13', MIN(col_13), MAX(col_13), AVG(col_13) FROM dataset4
UNION ALL
SELECT 'col_14', MIN(col_14), MAX(col_14), AVG(col_14) FROM dataset4
UNION ALL
SELECT 'col_15', MIN(col_15), MAX(col_15), AVG(col_15) FROM dataset4
UNION ALL
SELECT 'col_16', MIN(col_16), MAX(col_16), AVG(col_16) FROM dataset4
UNION ALL
SELECT 'col_17', MIN(col_17), MAX(col_17), AVG(col_17) FROM dataset4
UNION ALL
SELECT 'col_18', MIN(col_18), MAX(col_18), AVG(col_18) FROM dataset4
UNION ALL
SELECT 'col_19', MIN(col_19), MAX(col_19), AVG(col_19) FROM dataset4
UNION ALL
SELECT 'col_20', MIN(col_20), MAX(col_20), AVG(col_20) FROM dataset4
UNION ALL
SELECT 'col_21', MIN(col_21), MAX(col_21), AVG(col_21) FROM dataset4
UNION ALL
SELECT 'col_22', MIN(col_22), MAX(col_22), AVG(col_22) FROM dataset4
UNION ALL
SELECT 'col_23', MIN(col_23), MAX(col_23), AVG(col_23) FROM dataset4
UNION ALL
SELECT 'col_25', MIN(col_25), MAX(col_25), AVG(col_25) FROM dataset4
UNION ALL
SELECT 'col_27', MIN(col_27), MAX(col_27), AVG(col_27) FROM dataset4
UNION ALL
SELECT 'col_34', MIN(col_34), MAX(col_34), AVG(col_34) FROM dataset4
UNION ALL
SELECT 'col_41', MIN(col_41), MAX(col_41), AVG(col_41) FROM dataset4
UNION ALL
SELECT 'col_43', MIN(col_43), MAX(col_43), AVG(col_43) FROM dataset4
UNION ALL
SELECT 'col_44', MIN(col_44), MAX(col_44), AVG(col_44) FROM dataset4
UNION ALL
SELECT 'col_45', MIN(col_45), MAX(col_45), AVG(col_45) FROM dataset4
UNION ALL
SELECT 'col_46', MIN(col_46), MAX(col_46), AVG(col_46) FROM dataset4
UNION ALL
SELECT 'col_47', MIN(col_47), MAX(col_47), AVG(col_47) FROM dataset4
UNION ALL
SELECT 'col_48', MIN(col_48), MAX(col_48), AVG(col_48) FROM dataset4
UNION ALL
SELECT 'col_49', MIN(col_49), MAX(col_49), AVG(col_49) FROM dataset4
UNION ALL
SELECT 'col_50', MIN(col_50), MAX(col_50), AVG(col_50) FROM dataset4
UNION ALL
SELECT 'col_51', MIN(col_51), MAX(col_51), AVG(col_51) FROM dataset4
UNION ALL
SELECT 'col_52', MIN(col_52), MAX(col_52), AVG(col_52) FROM dataset4
UNION ALL
SELECT 'col_57', MIN(col_57), MAX(col_57), AVG(col_57) FROM dataset4
UNION ALL
SELECT 'col_62', MIN(col_62), MAX(col_62), AVG(col_62) FROM dataset4
UNION ALL
SELECT 'col_65', MIN(col_65), MAX(col_65), AVG(col_65) FROM dataset4
UNION ALL
SELECT 'col_66', MIN(col_66), MAX(col_66), AVG(col_66) FROM dataset4
UNION ALL
SELECT 'col_68', MIN(col_68), MAX(col_68), AVG(col_68) FROM dataset4
UNION ALL
SELECT 'col_69', MIN(col_69), MAX(col_69), AVG(col_69) FROM dataset4
UNION ALL
SELECT 'col_70', MIN(col_70), MAX(col_70), AVG(col_70) FROM dataset4;

### Dataset 4
### Check categorical values

SELECT 'col_5' AS column_name, col_5 AS value, COUNT(*) AS count
FROM dataset4
GROUP BY col_5

UNION ALL
SELECT 'col_6', col_6, COUNT(*)
FROM dataset4
GROUP BY col_6

UNION ALL
SELECT 'col_8', col_8, COUNT(*)
FROM dataset4
GROUP BY col_8

UNION ALL
SELECT 'col_12', col_12, COUNT(*)
FROM dataset4
GROUP BY col_12

UNION ALL
SELECT 'col_24', col_24, COUNT(*)
FROM dataset4
GROUP BY col_24

UNION ALL
SELECT 'col_29', col_29, COUNT(*)
FROM dataset4
GROUP BY col_29

UNION ALL
SELECT 'col_31', col_31, COUNT(*)
FROM dataset4
GROUP BY col_31

UNION ALL
SELECT 'col_35', col_35, COUNT(*)
FROM dataset4
GROUP BY col_35

UNION ALL
SELECT 'col_38', col_38, COUNT(*)
FROM dataset4
GROUP BY col_38

UNION ALL
SELECT 'col_53', col_53, COUNT(*)
FROM dataset4
GROUP BY col_53

UNION ALL
SELECT 'col_67', col_67, COUNT(*)
FROM dataset4
GROUP BY col_67;

### Dataset 4
### Check binary indicator columns for invalid values

SELECT 'col_13' AS column_name, col_13 AS value, COUNT(*) AS count
FROM dataset4
GROUP BY col_13

UNION ALL
SELECT 'col_14', col_14, COUNT(*) FROM dataset4 GROUP BY col_14
UNION ALL
SELECT 'col_15', col_15, COUNT(*) FROM dataset4 GROUP BY col_15
UNION ALL
SELECT 'col_16', col_16, COUNT(*) FROM dataset4 GROUP BY col_16
UNION ALL
SELECT 'col_17', col_17, COUNT(*) FROM dataset4 GROUP BY col_17
UNION ALL
SELECT 'col_18', col_18, COUNT(*) FROM dataset4 GROUP BY col_18
UNION ALL
SELECT 'col_19', col_19, COUNT(*) FROM dataset4 GROUP BY col_19
UNION ALL
SELECT 'col_43', col_43, COUNT(*) FROM dataset4 GROUP BY col_43
UNION ALL
SELECT 'col_44', col_44, COUNT(*) FROM dataset4 GROUP BY col_44
UNION ALL
SELECT 'col_45', col_45, COUNT(*) FROM dataset4 GROUP BY col_45
UNION ALL
SELECT 'col_46', col_46, COUNT(*) FROM dataset4 GROUP BY col_46
UNION ALL
SELECT 'col_47', col_47, COUNT(*) FROM dataset4 GROUP BY col_47
UNION ALL
SELECT 'col_48', col_48, COUNT(*) FROM dataset4 GROUP BY col_48
UNION ALL
SELECT 'col_49', col_49, COUNT(*) FROM dataset4 GROUP BY col_49
UNION ALL
SELECT 'col_50', col_50, COUNT(*) FROM dataset4 GROUP BY col_50
UNION ALL
SELECT 'col_51', col_51, COUNT(*) FROM dataset4 GROUP BY col_51
UNION ALL
SELECT 'col_52', col_52, COUNT(*) FROM dataset4 GROUP BY col_52;

### Dataset 4
### Check statistical outliers using mean ± 3 standard deviations

SELECT
    'col_4' AS column_name,
    COUNT(*) AS outlier_count
FROM dataset4
WHERE col_4 IS NOT NULL
  AND (col_4 < (SELECT AVG(col_4) - 3 * STDDEV(col_4) FROM dataset4)
       OR col_4 > (SELECT AVG(col_4) + 3 * STDDEV(col_4) FROM dataset4))

UNION ALL

SELECT 'col_9', COUNT(*)
FROM dataset4
WHERE col_9 IS NOT NULL
  AND (col_9 < (SELECT AVG(col_9) - 3 * STDDEV(col_9) FROM dataset4)
       OR col_9 > (SELECT AVG(col_9) + 3 * STDDEV(col_9) FROM dataset4))

UNION ALL

SELECT 'col_11', COUNT(*)
FROM dataset4
WHERE col_11 IS NOT NULL
  AND (col_11 < (SELECT AVG(col_11) - 3 * STDDEV(col_11) FROM dataset4)
       OR col_11 > (SELECT AVG(col_11) + 3 * STDDEV(col_11) FROM dataset4))

UNION ALL

SELECT 'col_20', COUNT(*)
FROM dataset4
WHERE col_20 IS NOT NULL
  AND (col_20 < (SELECT AVG(col_20) - 3 * STDDEV(col_20) FROM dataset4)
       OR col_20 > (SELECT AVG(col_20) + 3 * STDDEV(col_20) FROM dataset4))

UNION ALL

SELECT 'col_21', COUNT(*)
FROM dataset4
WHERE col_21 IS NOT NULL
  AND (col_21 < (SELECT AVG(col_21) - 3 * STDDEV(col_21) FROM dataset4)
       OR col_21 > (SELECT AVG(col_21) + 3 * STDDEV(col_21) FROM dataset4))

UNION ALL

SELECT 'col_22', COUNT(*)
FROM dataset4
WHERE col_22 IS NOT NULL
  AND (col_22 < (SELECT AVG(col_22) - 3 * STDDEV(col_22) FROM dataset4)
       OR col_22 > (SELECT AVG(col_22) + 3 * STDDEV(col_22) FROM dataset4))

UNION ALL

SELECT 'col_23', COUNT(*)
FROM dataset4
WHERE col_23 IS NOT NULL
  AND (col_23 < (SELECT AVG(col_23) - 3 * STDDEV(col_23) FROM dataset4)
       OR col_23 > (SELECT AVG(col_23) + 3 * STDDEV(col_23) FROM dataset4))

UNION ALL

SELECT 'col_25', COUNT(*)
FROM dataset4
WHERE col_25 IS NOT NULL
  AND (col_25 < (SELECT AVG(col_25) - 3 * STDDEV(col_25) FROM dataset4)
       OR col_25 > (SELECT AVG(col_25) + 3 * STDDEV(col_25) FROM dataset4))

UNION ALL

SELECT 'col_27', COUNT(*)
FROM dataset4
WHERE col_27 IS NOT NULL
  AND (col_27 < (SELECT AVG(col_27) - 3 * STDDEV(col_27) FROM dataset4)
       OR col_27 > (SELECT AVG(col_27) + 3 * STDDEV(col_27) FROM dataset4))

UNION ALL

SELECT 'col_34', COUNT(*)
FROM dataset4
WHERE col_34 IS NOT NULL
  AND (col_34 < (SELECT AVG(col_34) - 3 * STDDEV(col_34) FROM dataset4)
       OR col_34 > (SELECT AVG(col_34) + 3 * STDDEV(col_34) FROM dataset4))

UNION ALL

SELECT 'col_41', COUNT(*)
FROM dataset4
WHERE col_41 IS NOT NULL
  AND (col_41 < (SELECT AVG(col_41) - 3 * STDDEV(col_41) FROM dataset4)
       OR col_41 > (SELECT AVG(col_41) + 3 * STDDEV(col_41) FROM dataset4));
       
