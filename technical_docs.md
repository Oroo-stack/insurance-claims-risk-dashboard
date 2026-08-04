#  Technical Documentation: Pipeline & Logic

##  Data Architecture
The project follows a **Medallion Architecture** using Google BigQuery as the warehouse:
1. **Bronze:** Raw Kaggle CSV ingestion.
2. **Silver:** Individual LOB views with `NULLIF` remediation and actuarial bucketing.
3. **Gold:** A consolidated Semantic Bridge using `UNION ALL` and `CAST` for financial type-alignment.

##  Transformation Logic
### Deterministic Date Hashing
To enable stable time-series analysis without the volatility of `RAND()`, claim dates were generated using:
`DATE(TIMESTAMP_MICROS(CAST(1735689600000000 + (ABS(MOD(FARM_FINGERPRINT(key), 1000000)) / 1000000.0 * Range) AS INT64)))`
This ensures that the "January Loss Ratio" remains constant across every refresh.

### Actuarial Exposure Proxy
Identified **Selection Bias** in the source Motor data (Claims-only register). 
* **The Fix:** Implemented a **60x Multiplier** on Motor premiums within the `Total Premium Collected` measure. 
* **Logic:** Reconstructs the 98.4% "Safe Driver" population based on a standard 1.6% market frequency.

##  DAX Formula Factory
### 1. Institutional Loss Ratio
`DIVIDE([Total Claim Amount], [Total Premium Collected], 0)`
*Provides a real-time solvency signal; color-coded via SWITCH logic.*

### 2. Premium Yield Increment
`[Simulated Premium] - [Total Premium Collected]`
*Quantifies the marginal revenue gain from proposed price hikes.*

### 3. Projected Loss Ratio
`DIVIDE([Total Claim Amount], [Simulated Premium], 0)`
*The core engine for the Prescriptive "What-If" simulation on Page 3.*
