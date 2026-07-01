# HealthTail Analytics Project

## Overview
End-to-end BI analytics project built for HealthTail, a veterinary hospital seeking to automate their medication audit process and understand disease trends across their patient population.

**Role:** BI Analyst at Clinipet (analytics solutions provider)  
**Tools:** BigQuery · SQL · Looker Studio  
**Timeline:** 2024–2026 data  

---

## Business Problem
HealthTail came to us with two specific challenges:
1. **Medication Audit** — manually tracking annual medication spending was inefficient and error-prone
2. **Disease Trend Analysis** — identifying the most common diagnoses by pet type and breed to improve staffing and procurement planning

---

## Data Sources
Three CSV files provided by HealthTail:

| File | Description | Rows |
|---|---|---|
| `healthtail_reg_cards.csv` | Patient registration cards with owner information | 9,435 |
| `visits.csv` | Veterinary visit records with diagnoses and medications | 155,624 |
| `invoices.csv` | Supplier invoices for medication purchases | 1,462 |

---

## Pipeline Architecture

```
CSV Files → BigQuery Raw Tables → Staging Tables → Consolidated Tables → Looker Studio
```

### Layer Structure

```
healthtail (BigQuery Dataset)
├── RAW LAYER
│   ├── reg_cards_raw
│   ├── visits_raw
│   └── invoices_raw
│
├── STAGING LAYER (cleaned & standardized)
│   ├── stg_reg_cards
│   ├── stg_visits
│   └── stg_invoices
│
└── CONSOLIDATED LAYER (analysis-ready)
    ├── con_diagnoses (visits + patient info joined)
    └── con_invoices (structured for spending analysis)
```

---

## Data Quality Issues Found & Fixed

### reg_cards_raw
- **247 owner names** contained titles and suffixes (Mr., Mrs., Dr., PhD) → removed with REGEXP_REPLACE
- **2,454 patients** had missing breed information across three formats (NULL, "No Breed", "Unknown") → standardized to 'Unknown'

### visits_raw
- **4 diagnosis name inconsistencies** causing artificial split in disease counts:
  - Allergy / Allergies → standardized to 'Allergy' (combined: 8,651 visits)
  - Ear Infection / Ear Infections → standardized to 'Ear Infection' (combined: 8,236 visits)
  - Dental Disease / Dental Problems → standardized to 'Dental Disease' (combined: 6,801 visits)
  - Respiratory Infections / Respiratory Issues → standardized to 'Respiratory Infections' (combined: 4,983 visits)
- **Cross-table dependency bug** — medication names in `med_prescribed` were not standardized to match `med_name` in invoices, causing NULL results in the prescribed vs purchased analysis. Fixed by applying the same CASE WHEN standardization to both tables.

### invoices_raw
- **2 medication name duplicates** → standardized:
  - ArthriFlex / Arthroflex → 'ArthriFlex'
  - Clavamox (Amoxicillin/Clavulanic) / Clavamox (Amoxicillin + Clavulanic) → unified name
- `price` column stored as INTEGER → cast to FLOAT64

---

## Key Business Findings

### Disease & Diagnosis Trends
1. **Hypertrophic Cardiomyopathy is the #1 diagnosis** — 10,781 visits (6.93% of all visits), almost exclusively in cats
2. **Disease profiles are completely different by species** — cats show cardiac and neurological conditions, dogs show musculoskeletal problems, hamsters show a completely different profile with zero overlap
3. **Two doctors handle 49.9% of all visits** — Dr. Alice Johnson (25.07%) and Dr. Bob Smith (24.83%). Their patients average 4.5 return visits vs 1.6 for all other doctors. Requires investigation into whether this reflects ownership structure or operational risk.

### Medication & Spending
4. **Vetmedin (Pimobendan) accounts for 25.67% of total medication budget** — €1,035,780 out of €4,034,889 total. This cardiac medication directly reflects the #1 diagnosis finding.
5. **Supplier risk is well distributed** — 4 suppliers each carrying 60 of 62 medications, spending distributed between 19-30% per supplier
6. **Spending trend shows unusual ramp-up/ramp-down pattern** — steady increase through 2024, peak in December 2024, steady decline through 2025. Requires confirmation from HealthTail whether this reflects a real operational change or a data extraction artifact.

---

## SQL Files Structure

```
sql/
├── exploration/          # Data quality checks on raw tables
│   ├── explore_reg_cards.sql
│   ├── explore_visits_raw.sql
│   └── explore_invoices_raw.sql
│
├── staging/              # Cleaning and standardization
│   ├── stg_reg_cards.sql
│   ├── stg_visits.sql
│   └── stg_invoices.sql
│
├── consolidated/         # Analysis-ready joined tables
│   ├── con_diagnoses.sql
│   └── con_invoices.sql
│
└── analysis/             # Business question queries
    ├── analysis_q1_top_diagnoses.sql
    ├── analysis_q2_diagnoses_by_pet_type.sql
    ├── analysis_q3_breeds_per_diagnosis.sql
    ├── analysis_q4_doctor_workload.sql
    ├── analysis_q5_spending_per_medication.sql
    ├── analysis_q6_monthly_spending_trend.sql
    ├── analysis_q7_supplier_dependency.sql
    └── analysis_q8_prescribed_vs_purchased.sql
```

---

## Dashboard
Interactive Looker Studio report connected live to BigQuery.

**Page 1 — Disease & Diagnosis Trends**
- KPIs: Total Visits, Unique Patients, Unique Diagnoses
- Top 10 Diagnoses by Visit Volume
- Top 10 Diagnoses by Pet Type (species breakdown)
- Filter: Pet Type

**Page 2 — Medication & Spending**
- KPIs: Total Spending, Unique Medications, Unique Suppliers
- Top 10 Medications by Spending
- Monthly Spending Trend (2024–2026)
- Filter: Year

🔗 **[View Live Dashboard](https://datastudio.google.com/s/iDVt80s7u9A)** ← replace with your Looker Studio link

---

## Key Recommendations for HealthTail
1. **Negotiate Vetmedin procurement** — 25% of budget in one drug warrants volume discount negotiations and minimum stock level policy
2. **Investigate doctor workload concentration** — 50% of visits handled by 2 doctors is either intentional (ownership) or a serious operational risk
3. **Implement this pipeline as permanent audit system** — monthly data refresh replaces manual auditing process entirely

---

*Project completed as part of Data Analysis & BI training program | 2026*
