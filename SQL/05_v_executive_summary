/* 
  GOAL: Combine Auto and Medical clean data into one table for high-level summaries.
  TARGET VIEW: `insurance-claims-risk-dash.auto_insurance_claims.v_executive_summary`
*/

CREATE OR REPLACE VIEW `insurance-claims-risk-dash.auto_insurance_claims.v_executive_summary` AS (

  -- STEP 1: Pull from the Auto Division
  SELECT 
    'Motor' AS business_line,
    policy_state AS region,
    -- Cast to FLOAT64 matches the Float data type in the Medical table below
    CAST(total_claim_amount AS FLOAT64) AS total_claim_cost,
    claim_count,
    -- We use the fraud flag as the risk indicator for Motor
    is_fraud_flag AS high_risk_flag
  FROM `insurance-claims-risk-dash.auto_insurance_claims.v_auto_refined`

  UNION ALL

  -- STEP 2: Pull from the Medical Division
  SELECT 
    'Health' AS business_line,
    region,
    claim_amount AS total_claim_cost,
    claim_count,
    -- In Health, being a smoker is the primary high-risk indicator
    CASE WHEN is_smoker IS TRUE THEN 1 ELSE 0 END AS high_risk_flag
  FROM `insurance-claims-risk-dash.auto_insurance_claims.v_medical_refined`

);
