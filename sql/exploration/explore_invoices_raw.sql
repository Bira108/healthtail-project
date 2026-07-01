-- ================================================
-- EXPLORATION: invoices_raw
-- Purpose: Check row count, duplicates and nulls
-- ================================================

SELECT
  -- Total number of rows
  COUNT(*)                                AS total_rows,

  -- Unique invoice IDs
  COUNT(DISTINCT invoice_id)              AS unique_invoices,

  -- Duplicate check
  COUNT(*) - COUNT(DISTINCT invoice_id)   AS duplicate_invoice_ids,

  -- Unique medications purchased
  COUNT(DISTINCT med_name)                AS unique_medications,

  -- Unique suppliers
  COUNT(DISTINCT supplier)                AS unique_suppliers,

  -- Null checks
  COUNTIF(invoice_id IS NULL)             AS null_invoice_id,
  COUNTIF(supplier IS NULL)               AS null_supplier,
  COUNTIF(med_name IS NULL)               AS null_med_name,
  COUNTIF(packs IS NULL)                  AS null_packs,
  COUNTIF(price IS NULL)                  AS null_price,
  COUNTIF(total_price IS NULL)            AS null_total_price,
  COUNTIF(month_invoice IS NULL)          AS null_month_invoice

FROM `healthtail-project-bira.healthtail.invoices_raw` ;

-- ================================================
-- Purpose: Check medication name consistency
-- ================================================

SELECT
  med_name,
  COUNT(*) AS total_invoices
FROM `healthtail-project-bira.healthtail.invoices_raw`
GROUP BY med_name
ORDER BY med_name ASC ;

