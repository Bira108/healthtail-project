-- ================================================
-- ANALYSIS Q8: Prescribed vs Purchased medication
-- Purpose: Compare consumption to procurement
--          to identify shortages or excess stock
-- Tables: con_diagnoses, con_invoices
-- ================================================

WITH prescribed AS (
  SELECT
    med_prescribed                            AS med_name,
    COUNT(*)                                  AS total_prescriptions,
    ROUND(SUM(med_dosage), 2)                 AS packages_consumed

  FROM `healthtail-project-bira.healthtail.con_diagnoses`
  GROUP BY med_prescribed
),

purchased AS (
  SELECT
    med_name,
    COUNT(*)                                  AS total_invoices,
    ROUND(SUM(packs), 2)                      AS packages_purchased

  FROM `healthtail-project-bira.healthtail.con_invoices`
  GROUP BY med_name
)

SELECT
  COALESCE(p.med_name, pu.med_name)           AS med_name,
  p.packages_consumed,
  pu.packages_purchased,
  ROUND(pu.packages_purchased - 
    p.packages_consumed, 2)                    AS packages_surplus,
  ROUND(pu.packages_purchased / 
    NULLIF(p.packages_consumed, 0), 2)         AS purchase_to_consume_ratio

FROM prescribed p
FULL OUTER JOIN purchased pu
  ON p.med_name = pu.med_name 
  
ORDER BY purchase_to_consume_ratio DESC   ;

