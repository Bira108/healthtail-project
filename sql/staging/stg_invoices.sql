-- ================================================
-- STAGING: stg_invoices
-- Purpose: Fix med_name duplicates, 
--          cast price to FLOAT
-- Source: invoices_raw
-- ================================================

CREATE OR REPLACE TABLE `healthtail-project-bira.healthtail.stg_invoices` AS

SELECT
  month_invoice,
  invoice_id,
  supplier,

  -- ====================================================
  -- Purpose: Standardize duplicate medication names
  -- ====================================================

  CASE
    WHEN med_name = 'Arthroflex'
      THEN 'ArthriFlex'
    WHEN med_name = 'Clavamox (Amoxicillin/Clavulanic)'
      THEN 'Clavamox (Amoxicillin + Clavulanic)'
    ELSE med_name
  END                                       AS med_name,

  packs,

  -- Cast price from INTEGER to FLOAT
  CAST(price AS FLOAT64)                    AS price,

  total_price

FROM `healthtail-project-bira.healthtail.invoices_raw` ;


