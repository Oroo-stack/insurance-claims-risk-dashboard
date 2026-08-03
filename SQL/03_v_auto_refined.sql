/* 
  GOAL: Add accident severity labels and a sorting order for charts.
  TARGET VIEW: `insurance-claims-risk-dash.auto_insurance_claims.v_auto_refined`
*/

CREATE OR REPLACE VIEW `insurance-claims-risk-dash.auto_insurance_claims.v_auto_refined` AS (
  SELECT 
    policy_number,
    DATE(TIMESTAMP_MICROS(CAST(
      1735689600000000 + (
        ABS(MOD(FARM_FINGERPRINT(CAST(policy_number AS STRING)), 1000000)) / 1000000.0 * 
        (1767225599000000 - 1735689600000000)
      ) AS INT64
    ))) AS claim_date,
    age AS driver_age,
    insured_sex AS gender, 
    policy_state,
    policy_annual_premium,
    
    incident_severity,

    -- NEW: Numerical rank to make sure charts sort severity in the right order
    CASE 
      WHEN incident_severity = 'Trivial Damage' THEN 1
      WHEN incident_severity = 'Minor Damage' THEN 2
      WHEN incident_severity = 'Major Damage' THEN 3
      WHEN incident_severity = 'Total Loss' THEN 4
      ELSE 5
    END AS severity_sort_rank,
    
    COALESCE(NULLIF(TRIM(collision_type), '?'), 'Not Reported') AS accident_type,
    COALESCE(NULLIF(TRIM(police_report_available), '?'), 'Not Reported') AS police_report_status,
    
    total_claim_amount,
    1 AS claim_count,
 
    CASE WHEN total_claim_amount > 50000 THEN 1 ELSE 0 END AS is_large_loss,
    CASE WHEN fraud_reported IS TRUE THEN 1 ELSE 0 END AS is_fraud_flag

  FROM 
    `insurance-claims-risk-dash.auto_insurance_claims.raw_auto_claims`
);
