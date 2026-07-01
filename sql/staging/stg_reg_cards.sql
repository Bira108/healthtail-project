-- ================================================
-- STAGING: stg_reg_cards
-- Purpose: Clean owner_name and standardize breed
-- Source: reg_cards_raw
-- ================================================

CREATE OR REPLACE TABLE `healthtail-project-bira.healthtail.stg_reg_cards` AS

SELECT
  patient_id,
  owner_id,

  -- Remove titles and suffixes from owner_name
  TRIM(
    REGEXP_REPLACE(
      REGEXP_REPLACE(
        owner_name,
        r'^(Mr\.|Mrs\.|Ms\.|Dr\.)\s*', ''  -- remove prefixes
      ),
      r'\s*(PhD|Jr\.|Sr\.)$', ''            -- remove suffixes
    )
  )                                         AS owner_name,

  pet_type,
  breed,

  -- Standardize missing breed values to 'Unknown'
  CASE
    WHEN breed IS NULL THEN 'Unknown'
    WHEN TRIM(breed) = '' THEN 'Unknown'
    WHEN LOWER(breed) = 'no breed' THEN 'Unknown'
    ELSE breed
  END                                       AS breed_clean,

  patient_name,
  gender,
  patient_age,
  date_registration,
  owner_phone

FROM `healthtail-project-bira.healthtail.reg_cards_raw` ;

