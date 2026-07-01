-- ================================================
-- ANALYSIS Q5: Total spending per medication
-- Purpose: Identify highest cost medications
--          for procurement audit
-- Table: con_invoices
-- ================================================

SELECT
  med_name,
  COUNT(*)                                    AS total_invoices,
  SUM(packs)                                  AS total_packs_purchased,
  ROUND(SUM(total_price), 2)                  AS total_spending,
  ROUND(AVG(price), 2)                        AS avg_unit_price,
  ROUND(SUM(total_price) * 100.0 / SUM(SUM(total_price))
    OVER (), 2)                               AS pct_of_total_spending

FROM `healthtail-project-bira.healthtail.con_invoices`
GROUP BY med_name
ORDER BY total_spending DESC  ;

