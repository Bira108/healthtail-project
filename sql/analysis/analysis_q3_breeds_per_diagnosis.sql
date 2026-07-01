-- ================================================
-- ANALYSIS Q3: Top breeds per diagnosis
-- Purpose: Identify breed predispositions
--          for each disease
-- Table: con_diagnoses
-- ================================================

WITH ranked_breeds AS (
  SELECT
    diagnosis,
    breed_clean,
    pet_type,
    COUNT(*)                                  AS total_visits,

    -- Rank breeds within each diagnosis
    ROW_NUMBER() OVER (
      PARTITION BY diagnosis
      ORDER BY COUNT(*) DESC
    )                                         AS rank_within_diagnosis

  FROM `healthtail-project-bira.healthtail.con_diagnoses`
  WHERE breed_clean != 'Unknown'
  GROUP BY diagnosis, breed_clean, pet_type
)

SELECT
  diagnosis,
  rank_within_diagnosis,
  breed_clean,
  pet_type,
  total_visits

FROM ranked_breeds
WHERE rank_within_diagnosis <= 3
ORDER BY diagnosis, rank_within_diagnosis  ;


