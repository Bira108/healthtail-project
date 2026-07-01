-- ================================================
-- EXPLORATION: visits_raw
-- Purpose: Check row count, duplicates and nulls
-- ================================================

SELECT
  -- Total number of rows
  COUNT(*)                              AS total_rows,

  -- Unique visit IDs
  COUNT(DISTINCT visit_id)              AS unique_visits,

  -- Duplicate check
  COUNT(*) - COUNT(DISTINCT visit_id)   AS duplicate_visit_ids,

  -- Unique patients who have visits
  COUNT(DISTINCT patient_id)            AS unique_patients,

  -- Null checks on all critical columns
  COUNTIF(visit_id IS NULL)             AS null_visit_id,
  COUNTIF(patient_id IS NULL)           AS null_patient_id,
  COUNTIF(visit_datetime IS NULL)       AS null_visit_datetime,
  COUNTIF(doctor IS NULL)               AS null_doctor,
  COUNTIF(diagnosis IS NULL)            AS null_diagnosis,
  COUNTIF(med_prescribed IS NULL)       AS null_med_prescribed,
  COUNTIF(med_dosage IS NULL)           AS null_med_dosage,
  COUNTIF(med_cost IS NULL)             AS null_med_cost

FROM `healthtail-project-bira.healthtail.visits_raw` ;


-- ================================================
-- Purpose: Check distinct values in doctor field
-- ================================================

SELECT
  doctor,
  COUNT(*) AS total_visits
FROM `healthtail-project-bira.healthtail.visits_raw`
GROUP BY doctor
ORDER BY total_visits DESC ;

-- Check distinct diagnoses and frequency
SELECT
  diagnosis,
  COUNT(*) AS total_visits
FROM `healthtail-project-bira.healthtail.visits_raw`
GROUP BY diagnosis
ORDER BY total_visits DESC ;

-- =====================================================
-- Purpose: Confirm all diagnosis name inconsistencies
-- =====================================================

SELECT
  diagnosis,
  COUNT(*) AS total_visits
FROM `healthtail-project-bira.healthtail.visits_raw`
WHERE
  diagnosis LIKE '%llerg%'
  OR diagnosis LIKE '%espiratory%'
  OR diagnosis LIKE '%ental%'
  OR diagnosis LIKE '%ar %'
  OR diagnosis LIKE '%ar I%'
GROUP BY diagnosis
ORDER BY diagnosis ;

