-- ================================================
-- ANALYSIS Q7: Supplier dependency analysis
-- Purpose: Assess procurement risk concentration
-- Table: con_invoices
-- ================================================

SELECT
  supplier,
  COUNT(*)                                    AS total_invoices,
  COUNT(DISTINCT med_name)                    AS unique_medications_supplied,
  ROUND(SUM(total_price), 2)                  AS total_spending,
  ROUND(SUM(total_price) * 100.0 / SUM(SUM(total_price))
    OVER (), 2)                               AS pct_of_total_spending

FROM `healthtail-project-bira.healthtail.con_invoices`
GROUP BY supplier
ORDER BY total_spending DESC

;
