-- ================================================
-- ANALYSIS Q2: Top diagnoses by pet type
-- Purpose: Identify disease patterns per species
-- Table: con_diagnoses
-- ================================================

WITH ranked_diagnoses AS (
  SELECT
    pet_type,
    diagnosis,
    COUNT(*)                                  AS total_visits,

    -- Rank diagnoses within each pet type
    ROW_NUMBER() OVER (
      PARTITION BY pet_type
      ORDER BY COUNT(*) DESC
    )                                         AS rank_within_pet

  FROM `healthtail-project-bira.healthtail.con_diagnoses`
  GROUP BY pet_type, diagnosis
)

SELECT
  pet_type,
  rank_within_pet,
  diagnosis,
  total_visits

FROM ranked_diagnoses
WHERE rank_within_pet <= 5
ORDER BY pet_type, rank_within_pet  ;



  
