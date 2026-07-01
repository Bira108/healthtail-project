-- ================================================
-- ANALYSIS Q1: Most common diagnoses overall
-- Purpose: Identify top diseases by visit volume
-- Table: con_diagnoses
-- ================================================

SELECT
  diagnosis,
  COUNT(*)                                    AS total_visits,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) 
    OVER (), 2)                               AS pct_of_total

FROM `healthtail-project-bira.healthtail.con_diagnoses`
GROUP BY diagnosis
ORDER BY total_visits DESC  ;

