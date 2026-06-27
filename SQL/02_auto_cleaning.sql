/* 
  Objective: High-rigor financial validation & rating factor audit.
  Target: `insurance-claims-risk-dash.auto_insurance_claims.raw_auto_claims`
*/

WITH auto_validation_staged AS (
  SELECT 
    *,
    -- 1. COMPLETENESS: Handling dirty string layouts via TRIM
    CASE WHEN NULLIF(TRIM(collision_type), '?') IS NULL THEN 1 ELSE 0 END AS missing_collision_data_flag,
    CASE WHEN NULLIF(TRIM(police_report_available), '?') IS NULL THEN 1 ELSE 0 END AS missing_police_report_flag,
    
    -- 2. VALIDITY: Boundary analysis
    CASE WHEN age < 18 OR age > 100 THEN 1 ELSE 0 END AS invalid_driver_age_flag,
    CASE WHEN policy_annual_premium <= 0 OR policy_annual_premium IS NULL THEN 1 ELSE 0 END AS defective_premium_flag,
    
    -- 3. FINANCIAL CONSISTENCY: Absolute margin prevents float point mismatches
    CASE 
        WHEN ABS(total_claim_amount - (injury_claim + property_claim + vehicle_claim)) > 0.01 THEN 1 
        ELSE 0 
    END AS financial_mismatch_flag
  FROM `insurance-claims-risk-dash.auto_insurance_claims.raw_auto_claims`
)

SELECT 
  -- Metadata: Total Exposure (Policies)
  COUNT(1) AS total_policy_records,

  -- PILLAR 1: COMPLETENESS
  SUM(missing_collision_data_flag) AS count_missing_collision_type,
  SUM(missing_police_report_flag) AS count_missing_police_reports,
  ROUND(SUM(missing_police_report_flag) / COUNT(1) * 100, 2) AS documentation_gap_pct,

  -- PILLAR 2: VALIDITY
  MIN(age) AS driver_min_age,
  MAX(age) AS driver_max_age,
  SUM(invalid_driver_age_flag) AS count_invalid_age,
  SUM(defective_premium_flag) AS policies_with_zero_premium,

  -- PILLAR 3: UNIQUENESS (Direct Aggregation)
  COUNT(DISTINCT policy_number) AS distinct_policies,
  COUNT(1) - COUNT(DISTINCT policy_number) AS duplicate_policy_rows,

  -- PILLAR 4: FINANCIAL CONSISTENCY
  SUM(financial_mismatch_flag) AS count_accounting_errors,
  
  -- PILLAR 5: SEVERITY PROFILING
  ROUND(AVG(total_claim_amount), 2) AS avg_claim_severity,
  MAX(total_claim_amount) AS peak_claim_impact,
  ROUND(STDDEV(total_claim_amount), 2) AS claim_volatility_index

FROM auto_validation_staged;
