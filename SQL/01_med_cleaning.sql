/* 
  Objective: Verify the three pillars of data integrity.
  Target: insurance-claims-risk-dash.auto_insurance_claims.raw_medical_claims
*/

WITH medical_audit AS (
  SELECT 
    *,
    -- 1. Validity Check: Flagging unrealistic ages (Actuarial outlier detection)
    CASE WHEN age < 18 OR age > 100 THEN 1 ELSE 0 END AS invalid_age_flag,
    
    -- 2. Completeness Check: Flagging zero or null claims (Financial leakage)
    CASE WHEN charges IS NULL OR charges <= 0 THEN 1 ELSE 0 END AS missing_financial_flag,

    -- 3. Uniqueness Check: Creating a row hash to detect exact duplicate entries
    -- Since medical data lacks a Policy_ID, we check if the entire row is a duplicate
    FARM_FINGERPRINT(CONCAT(CAST(age AS STRING), sex, CAST(bmi AS STRING), CAST(children AS STRING), smoker, region, CAST(charges AS STRING))) AS row_id
  FROM `insurance-claims-risk-dash.auto_insurance_claims.raw_medical_claims`
)

SELECT 
  -- Total Exposure (Total records)
  COUNT(*) AS total_records,

  -- PILLAR 1: COMPLETENESS
  SUM(missing_financial_flag) AS null_or_zero_claims,
  ROUND(SUM(missing_financial_flag) / COUNT(*) * 100, 2) AS completeness_error_rate_pct,

  -- PILLAR 2: VALIDITY
  MIN(age) AS min_age_found,
  MAX(age) AS max_age_found,
  SUM(invalid_age_flag) AS unrealistic_age_count,

  -- PILLAR 3: UNIQUENESS
  COUNT(DISTINCT row_id) AS unique_records,
  COUNT(*) - COUNT(DISTINCT row_id) AS duplicate_row_count

FROM medical_audit;
