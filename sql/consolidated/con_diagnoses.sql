-- ================================================
-- CONSOLIDATED: con_diagnoses
-- Purpose: Join visits with patient info for
--          diagnosis and disease trend analysis
-- ================================================

CREATE OR REPLACE TABLE `healthtail-project-bira.healthtail.con_diagnoses` AS

SELECT
  -- Visit information
  v.visit_id,
  v.visit_date,
  v.doctor,
  v.diagnosis,
  v.med_prescribed,
  v.med_dosage,
  v.med_cost,

  -- Patient information from reg_cards
  v.patient_id,
  r.owner_id,
  r.owner_name,
  r.pet_type,
  r.breed,
  r.breed_clean,
  r.patient_name,
  r.gender,
  r.patient_age,
  r.date_registration,
  r.owner_phone

FROM `healthtail-project-bira.healthtail.stg_visits` v
LEFT JOIN `healthtail-project-bira.healthtail.stg_reg_cards` r
  ON v.patient_id = r.patient_id  ;

  
