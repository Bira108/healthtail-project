-- ================================================
-- ANALYSIS Q4: Doctor workload analysis
-- Purpose: Understand visit distribution
--          across doctors and specializations
-- Table: con_diagnoses
-- ================================================

SELECT
  doctor,
  COUNT(*)                                    AS total_visits,
  COUNT(DISTINCT patient_id)                  AS unique_patients,
  COUNT(DISTINCT diagnosis)                   AS unique_diagnoses,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*))
    OVER (), 2)                               AS pct_of_total_visits,
  ROUND(COUNT(*) / COUNT(DISTINCT 
    patient_id), 1)                           AS avg_visits_per_patient

FROM `healthtail-project-bira.healthtail.con_diagnoses`
GROUP BY doctor
ORDER BY total_visits DESC   ;

