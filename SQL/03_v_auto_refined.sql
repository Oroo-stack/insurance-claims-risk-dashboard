/* 
  GOAL: Clean up missing text values and add flags for Power BI charts.
  TARGET VIEW: `insurance-claims-risk-dash.auto_insurance_claims.v_auto_refined`
*/

CREATE OR REPLACE VIEW `insurance-claims-risk-dash.auto_insurance_claims.v_auto_refined` AS (
  SELECT 
    policy_number,
    age AS driver_age,
    policy_state,
    
    -- Fix '?' marks: turn missing values into clear text labels for dashboard filters
    COALESCE(NULLIF(TRIM(collision_type), '?'), 'Not Reported') AS accident_type,
    COALESCE(NULLIF(TRIM(police_report_available), '?'), 'Not Reported') AS police_report_status,
    
    total_claim_amount,
    
    -- NEW: Claim Counter (Always 1)
    -- This allows us to use SUM(claim_count) in Power BI to find Frequency.
    1 AS claim_count,

    -- NEW: Large Loss Flag 
    -- We flag claims over $50,000 (our audited average value) as a large loss
    CASE WHEN total_claim_amount > 50000 THEN 1 ELSE 0 END AS is_large_loss,

    -- Create a 1 or 0 flag for fraud
   -- RIGHT (Converts True to 1 and False to 0 perfectly)
CASE WHEN fraud_reported IS TRUE THEN 1 ELSE 0 END AS is_fraud_flag


  FROM 
    `insurance-claims-risk-dash.auto_insurance_claims.raw_auto_claims`
);

