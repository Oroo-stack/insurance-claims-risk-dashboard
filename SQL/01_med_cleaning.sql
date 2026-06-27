/* 
  Objective: Verify the pillars of data integrity.
  Target: insurance-claims-risk-dash.auto_insurance_claims.raw_medical_claims
*/

WITH medical_audit AS (
  SELECT 
    age,
    charges,
    -- 1. Validity Check: Target industry bounds (adult auto insurance policyholders)
    CASE WHEN age < 18 OR age > 100 THEN 1 ELSE 0 END AS invalid_age_flag,
    
    -- 2. Completeness Check: Capture sub-dollar leakages and NULL records
    CASE WHEN charges IS NULL OR charges < 1.00 THEN 1 ELSE 0 END AS financial_leakage_flag,

    -- 3. Uniqueness Check: Delimited string composition prevents string collision bugs
    FARM_FINGERPRINT(
      CONCAT(
        COALESCE(CAST(age AS STRING), ''), '|',
        COALESCE(sex, ''), '|',
        COALESCE(CAST(bmi AS STRING), ''), '|',
        COALESCE(CAST(children AS STRING), ''), '|',
        -- RIGHT (Fixes the type conflict)
COALESCE(CAST(smoker AS STRING), ''), '|',

        COALESCE(region, ''), '|',
        COALESCE(CAST(charges AS STRING), '')
      )
    ) AS row_id
  FROM `insurance-claims-risk-dash.auto_insurance_claims.raw_medical_claims`
)

SELECT 
  -- Metadata
  COUNT(1) AS total_records,

  -- PILLAR 1: COMPLETENESS
  SUM(financial_leakage_flag) AS defective_financial_records,
  ROUND(SUM(financial_leakage_flag) / COUNT(1) * 100, 2) AS completeness_error_pct,

  -- PILLAR 2: VALIDITY
  MIN(age) AS structural_min_age,
  MAX(age) AS structural_max_age,
  SUM(invalid_age_flag) AS out_of_bounds_age_count,
  ROUND(SUM(invalid_age_flag) / COUNT(1) * 100, 2) AS validity_error_pct,

  -- PILLAR 3: UNIQUENESS
  COUNT(DISTINCT row_id) AS distinct_entities,
  COUNT(1) - COUNT(DISTINCT row_id) AS exact_duplicate_rows,
  ROUND((COUNT(1) - COUNT(DISTINCT row_id)) / COUNT(1) * 100, 2) AS duplication_rate_pct

FROM medical_audit;
