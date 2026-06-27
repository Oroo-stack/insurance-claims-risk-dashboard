/* 
  GOAL: Clean up the Medical data and group people by risk.
  TARGET VIEW: `insurance-claims-risk-dash.auto_insurance_claims.v_medical_refined`
*/

CREATE OR REPLACE VIEW `insurance-claims-risk-dash.auto_insurance_claims.v_medical_refined` AS (
  SELECT DISTINCT -- We use DISTINCT to remove the 1 exact duplicate record found in the audit.
    age AS member_age,
    sex AS gender,
    bmi AS body_mass_index,
    smoker AS is_smoker,
    region,
    charges AS claim_amount,

    -- STEP 1: Add a 'Claim Counter' (Always 1)
    -- This helps us count how many claims happened in Power BI.
    1 AS claim_count,

    -- STEP 2: Group people by Age. 
    -- Actuaries use these groups to see which age bracket costs the most.
    CASE 
      WHEN age < 30 THEN '18-29'
      WHEN age BETWEEN 30 AND 50 THEN '30-50'
      ELSE '51-64'
    END AS age_bracket,

    -- STEP 3: Identify High-Risk members.
    -- Changed smoker checks to 'IS TRUE' because the column is stored as a Boolean data type.
    CASE 
      WHEN smoker IS TRUE AND bmi >= 30.0 THEN 'High Risk'
      WHEN smoker IS TRUE OR bmi >= 30.0 THEN 'Medium Risk'
      ELSE 'Standard Risk'
    END AS risk_segment

  FROM 
    `insurance-claims-risk-dash.auto_insurance_claims.raw_medical_claims`
);
