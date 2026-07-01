-- ================================================
-- CONSOLIDATED: con_invoices
-- Purpose: Medication spending analysis
--          by supplier, medication and month
-- ================================================

CREATE OR REPLACE TABLE `healthtail-project-bira.healthtail.con_invoices` AS

SELECT
  month_invoice,
  invoice_id,
  supplier,
  med_name,
  packs,
  price,
  total_price,

  -- Extract year and month for easier filtering
  EXTRACT(YEAR FROM month_invoice)          AS invoice_year,
  EXTRACT(MONTH FROM month_invoice)         AS invoice_month

FROM `healthtail-project-bira.healthtail.stg_invoices`  ;

