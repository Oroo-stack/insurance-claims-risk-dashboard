/* 
  GOAL: Restore 'policy_id' to Gold Layer to fix broken Power BI measures.
  TARGET VIEW: `insurance-claims-risk-dash.auto_insurance_claims.v_executive_summary`
*/

CREATE OR REPLACE VIEW `insurance-claims-risk-dash.auto_insurance_claims.v_executive_summary` AS (

  -- STEP 1: Motor Division
  SELECT 
    'Motor' AS business_line,
    CAST(policy_number AS STRING) AS policy_id, 
    claim_date,
    policy_state AS region,
    gender,
    CASE WHEN driver_age < 30 THEN '18-29' WHEN driver_age BETWEEN 30 AND 50 THEN '30-50' ELSE '51-64' END AS age_bracket,
    CAST(total_claim_amount AS FLOAT64) AS total_claim_cost,
    CAST(policy_annual_premium AS FLOAT64) AS premium_collected,
    claim_count,
    accident_type AS detailed_risk_type, 
    is_fraud_flag AS high_risk_flag
  FROM `insurance-claims-risk-dash.auto_insurance_claims.v_auto_refined`

  UNION ALL

  -- STEP 2: Health Division
  SELECT 
    'Health' AS business_line,
    CAST(policy_id AS STRING) AS policy_id, 
    claim_date,
    region,
    gender,
    age_bracket,
    claim_amount AS total_claim_cost,
    premium_collected,
    claim_count,
    risk_segment AS detailed_risk_type, 
    CASE WHEN is_smoker IS TRUE THEN 1 ELSE 0 END AS high_risk_flag
  FROM `insurance-claims-risk-dash.auto_insurance_claims.v_medical_refined`

);
