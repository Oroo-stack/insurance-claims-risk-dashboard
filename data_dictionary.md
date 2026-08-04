#  Data Dictionary: Insurance Risk Suite

##  1. Gold Layer (Executive Summary)
| Column Name | Data Type | Business Definition |
| :--- | :--- | :--- |
| `business_line` | STRING | Indicator for the division: 'Motor' (Auto) or 'Health' (Medical). |
| `policy_id` | STRING | A unique identifier for the risk. Uses `FARM_FINGERPRINT` for Medical hashing. |
| `claim_date` | DATE | Deterministic random date in 2025 used for time-series consistency. |
| `total_claim_cost` | FLOAT64 | The incurred financial loss (Indemnity Outgo). |
| `premium_collected` | FLOAT64 | The revenue received. Note: Motor uses 60x Exposure Proxy in DAX. |
| `detailed_risk_type`| STRING | Harmonized category: Accident Type (Motor) or Risk Segment (Health). |
| `high_risk_flag` | INTEGER | Boolean (1/0) indicating high-risk behavior (Fraud or Smoking). |

##  2. Silver Layer (Motor Refined)
| Column Name | Data Type | Business Definition |
| :--- | :--- | :--- |
| `incident_severity` | STRING | Technical classification of damage: Trivial to Total Loss. |
| `police_report_status`| STRING | Operational audit flag: 'Not Reported' vs 'Yes/No'. |
| `is_large_loss` | INTEGER | Flag for claims > $50,000 (Actuarial Tail Risk indicator). |

##  3. Silver Layer (Medical Refined)
| Column Name | Data Type | Business Definition |
| :--- | :--- | :--- |
| `bmi_risk_class` | STRING | Categorical grouping: Underweight, Healthy, Overweight, Obese. |
| `risk_segment` | STRING | Composite risk factor based on Smoking and BMI status. |
