-- ================================================
-- STAGING: stg_visits
-- Purpose: Rename visit_datetime, standardize
--          diagnosis names
-- Source: visits_raw
-- ================================================

CREATE OR REPLACE TABLE `healthtail-project-bira.healthtail.stg_visits` AS

SELECT
  visit_id,
  patient_id,

  -- Rename to reflect actual data content
  visit_datetime                            AS visit_date,

  doctor,

  -- =========================================================
  -- Purpose: Standardize inconsistent diagnosis names
  -- =========================================================
  
  CASE
    WHEN diagnosis = 'Allergies'
      THEN 'Allergy'
    WHEN diagnosis = 'Ear Infections'
      THEN 'Ear Infection'
    WHEN diagnosis = 'Dental Problems'
      THEN 'Dental Disease'
    WHEN diagnosis = 'Respiratory Issues'
      THEN 'Respiratory Infections'
    ELSE diagnosis
  END                                       AS diagnosis,

  -- =======================================================================
  -- Purpose: Standardize med_prescribed to match med_name in stg_invoices
  -- =======================================================================
  
  CASE
    WHEN med_prescribed = 'Arthroflex'
      THEN 'ArthriFlex'
    WHEN med_prescribed = 'Clavamox (Amoxicillin/Clavulanic)'
      THEN 'Clavamox (Amoxicillin + Clavulanic)'
    ELSE med_prescribed
  END                                       AS med_prescribed,
  med_dosage,
  med_cost

FROM `healthtail-project-bira.healthtail.visits_raw` ;


