/*
  DESC: Transformation of raw medical claims into a refined view.
        Engineering 'Risk Buckets' to enable actuarial segmentation 
        in Power BI based on demographic and lifestyle risk factors.
*/

CREATE OR REPLACE VIEW `insurance-claims-risk-dash.auto_insurance_claims.v_medical_refined` AS (
  SELECT 
    -- Demographic Risk Factors
    CAST(age AS INT64) AS member_age,
    sex AS member_gender,
    CAST(children AS INT64) AS dependent_count,
    region AS geographical_region,

    -- Health/Lifestyle Risk Factors
    bmi AS body_mass_index,
    smoker AS smoking_status_flag,

    -- Financial Metric (The 'Charges' in health insurance is the claim cost)
    CAST(charges AS FLOAT64) AS claim_amount_usd,

    -- Actuarial Feature Engineering: BMI Categorization
    CASE 
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Healthy'
        WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
        WHEN bmi >= 30 THEN 'Obese'
        ELSE 'Unknown'
    END AS bmi_risk_segment,

    -- Actuarial Feature Engineering: Age Brackets
    CASE 
        WHEN age < 25 THEN 'Youth'
        WHEN age BETWEEN 25 AND 50 THEN 'Adult'
        WHEN age > 50 THEN 'Senior'
    END AS demographic_segment

  FROM 
    `insurance-claims-risk-dash.auto_insurance_claims.raw_medical_claims`
);
