-- ================================================
-- EXPLORATION: reg_cards_raw
-- Purpose: Check row count, duplicates and nulls
-- ================================================

-- [
SELECT
  -- Total number of rows in the table
  COUNT(*)                                    AS total_rows,

  -- How many unique patient IDs exist
  COUNT(DISTINCT patient_id)                  AS unique_patients,

  -- If total_rows > unique_patients, we have duplicates
  COUNT(*) - COUNT(DISTINCT patient_id)       AS duplicate_patient_ids,

  -- Null checks on critical columns
  COUNTIF(patient_id IS NULL)                 AS null_patient_id,
  COUNTIF(owner_id IS NULL)                   AS null_owner_id,
  COUNTIF(pet_type IS NULL)                   AS null_pet_type,
  COUNTIF(breed IS NULL)                      AS null_breed,
  COUNTIF(gender IS NULL)                     AS null_gender,
  COUNTIF(patient_age IS NULL)                AS null_patient_age,
  COUNTIF(date_registration IS NULL)          AS null_date_registration,
  COUNTIF(owner_phone IS NULL)                AS null_owner_phone

FROM `healthtail-project-bira.healthtail.reg_cards_raw` ;

]


-- ================================================
-- EXPLORATION: reg_cards_raw
-- Purpose: Check consistency of categorical fields
-- ================================================

-- [
-- Check distinct values in pet_type
SELECT 
  pet_type,
  COUNT(*) AS total
FROM `healthtail-project-bira.healthtail.reg_cards_raw`
GROUP BY pet_type
ORDER BY total DESC;

-- Check distinct values in gender
SELECT 
  gender,
  COUNT(*) AS total
FROM `healthtail-project-bira.healthtail.reg_cards_raw`
GROUP BY gender
ORDER BY total DESC;

]


-- ================================================
-- EXPLORATION: reg_cards_raw
-- Purpose: Check for titles and suffixes in owner_name
-- ================================================

 [
SELECT
  COUNT(*) AS total_with_titles
FROM `healthtail-project-bira.healthtail.reg_cards_raw`
WHERE
  owner_name LIKE 'Mr. %'
  OR owner_name LIKE 'Mrs. %'
  OR owner_name LIKE 'Ms. %'
  OR owner_name LIKE 'Dr. %'
  OR owner_name LIKE '% PhD'
  OR owner_name LIKE '% Jr.'
  OR owner_name LIKE '% Sr.';
  
]


