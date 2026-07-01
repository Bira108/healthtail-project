-- ================================================
-- ANALYSIS Q6: Monthly spending trend
-- Purpose: Identify seasonality and growth
--          patterns in medication spending
-- Table: con_invoices
-- ================================================

SELECT
  invoice_year,
  invoice_month,
  COUNT(*)                                    AS total_invoices,
  ROUND(SUM(total_price), 2)                  AS monthly_spending

FROM `healthtail-project-bira.healthtail.con_invoices`
GROUP BY invoice_year, invoice_month
ORDER BY invoice_year, invoice_month   ;
