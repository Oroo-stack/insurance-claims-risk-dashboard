#  Data Dictionary: Insurance Risk Suite

## 1. Gold Layer (v_executive_summary)
*The unified reporting layer: Motor and Health divisions.*

| Column Name | Data Type | Business Definition |
| :--- | :--- | :--- |
| `business_line` | STRING | Source division: 'Motor' or 'Health'. Used for high-level slicing. |
| `policy_id` | STRING | Unique risk identifier. (Motor: policy_number \| Health: Hash ID). |
| `claim_date` | DATE | Event timestamp. Deterministic 2025 dates used for trend stability. |
| `region` | STRING | Geographic location (Motor: States \| Health: US Regions). |
| `gender` | STRING | Demographic rating factor: 'MALE' or 'FEMALE'. |
| `age_bracket` | STRING | Standardized age bins (18-29, 30-50, 51-64) for risk profiling. |
| `total_claim_cost` | FLOAT64 | Harmonized indemnity outgo (The 'Charges' or 'Total Claim Amount'). |
| `premium_collected` | FLOAT64 | Revenue per risk. Note: Motor uses a 60x Exposure Proxy in DAX. |
| `claim_count` | INTEGER | Hardcoded '1' per record to enable frequency aggregation. |
| `detailed_risk_type`| STRING | Sub-category: Accident Type (Motor) or Risk Segment (Health). |
| `high_risk_indicator`| INTEGER | Boolean (1/0) for behavioral risk (Fraud flag or Smoking status). |

## 2. Silver Layer (v_auto_refined)
*Refined Motor claims with fixed strings and ranked accident severity.*

| Column Name | Data Type | Business Definition |
| :--- | :--- | :--- |
| `policy_number` | INTEGER | Original unique identifier from the raw motor source. |
| `accident_type` | STRING | Type of collision. '?' values remediated to 'Not Reported'. |
| `police_report_status`| STRING | Documentation audit flag. '?' remediated to 'Not Reported'. |
| `incident_severity` | STRING | Damage classification: Trivial, Minor, Major, Total Loss. |
| `severity_sort_rank` | INTEGER | Hidden numerical key used to force logical sorting in Waterfall charts. |
| `is_large_loss` | INTEGER | Actuarial flag for claims > $50,000 (Catastrophic Tail Risk). |
| `is_fraud_flag` | INTEGER | Remediated boolean (1/0) based on 'fraud_reported' source field. |

## 3. Silver Layer (v_medical_refined)
*Deduplicated Health claims with engineered risk tiers.*

| Column Name | Data Type | Business Definition |
| :--- | :--- | :--- |
| `policy_id` | STRING | Primary key generated via `FARM_FINGERPRINT` to ensure uniqueness. |
| `body_mass_index` | FLOAT64 | Raw BMI score used for morbidity analysis. |
| `is_smoker` | BOOLEAN | Primary health risk flag (True/False). |
| `bmi_risk_class` | STRING | Actuarial buckets: Underweight, Healthy, Overweight, Obese. |
| `risk_segment` | STRING | Composite risk factor: Combines Smoker and Obese status. |
| `claim_amount` | FLOAT64 | The raw medical cost per member. |
| `premium_collected` | FLOAT64 | Engineered technical price calculated as `claim_amount * 1.25`. |
