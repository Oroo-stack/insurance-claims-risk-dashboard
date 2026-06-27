/* 
  Objective: Verify Completeness, Validity, Uniqueness, and Financial Consistency.
  Target: insurance-claims-risk-dash.auto_insurance_claims.raw_auto_claims
*/

SELECT 
  -- Total Exposure
  COUNT(*) AS total_records,

  -- PILLAR 1: COMPLETENESS 
  COUNTIF(collision_type = '?') AS missing_collision_data,
  COUNTIF(police_report_available = '?') AS missing_police_reports,
  COUNTIF(total_claim_amount = 0) AS zero_claim_records,

  -- PILLAR 2: VALIDITY (Age of Driver)
  MIN(age) AS min_driver_age,
  MAX(age) AS max_driver_age,
  COUNTIF(age < 18) AS underage_drivers,

  -- PILLAR 3: UNIQUENESS (Policy IDs)
  COUNT(DISTINCT policy_number) AS unique_policies,
  COUNT(*) - COUNT(DISTINCT policy_number) AS duplicate_policy_count,

  -- PILLAR 4: FINANCIAL CONSISTENCY (Sum of parts must = Total)
  -- This checks if the data entry in the system is mathematically sound
  COUNTIF(total_claim_amount != (injury_claim + property_claim + vehicle_claim)) AS accounting_mismatch_count

FROM `insurance-claims-risk-dash.auto_insurance_claims.raw_auto_claims`;
