/* 
  GOAL: Update Health View with STABLE, deterministic 2025 random dates.
*/
CREATE OR REPLACE VIEW `insurance-claims-risk-dash.auto_insurance_claims.v_medical_refined` AS (
  SELECT DISTINCT
    FARM_FINGERPRINT(CONCAT(CAST(age AS STRING), bmi, region, CAST(charges AS STRING))) AS policy_id,
    
    DATE(TIMESTAMP_MICROS(CAST(
      1735689600000000 + (
        ABS(MOD(FARM_FINGERPRINT(CONCAT(CAST(age AS STRING), bmi, region, CAST(charges AS STRING))), 1000000)) / 1000000.0 * 
        (1767225599000000 - 1735689600000000)
      ) AS INT64
    ))) AS claim_date,
    
    age AS member_age,
    sex AS gender,
    bmi,
    smoker AS is_smoker,
    region,
    charges AS claim_amount,
    TRUNC(charges * 1.25, 3) AS premium_collected,
    1 AS claim_count,
    
    CASE 
      WHEN age < 30 THEN '18-29' 
      WHEN age BETWEEN 30 AND 50 THEN '30-50' 
      ELSE '51-64' 
    END AS age_bracket,

    CASE 
      WHEN smoker IS TRUE AND bmi >= 30.0 THEN 'High Risk'
      WHEN smoker IS TRUE OR bmi >= 30.0 THEN 'Medium Risk'
      ELSE 'Standard Risk'
    END AS risk_segment

  FROM `insurance-claims-risk-dash.auto_insurance_claims.raw_medical_claims`
);
