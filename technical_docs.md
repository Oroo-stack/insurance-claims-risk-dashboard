#  Project Pipeline & Business Logic

##  Data Architecture
The data flows through three organized stages inside Google BigQuery:
* **Bronze (Raw):** Original messy data uploaded straight from Kaggle.
* **Silver (Cleaned):** Cleaned data views where missing values are fixed and organized into specific categories.
* **Gold (Reporting):** A final table combining all data into a standardized format ready for the dashboard.

##  Smart Transformation Logic

### Consistent Fake Dates
* **The Problem:** The raw dataset lacked dates, and using random functions causes data to change every time it refreshes.
* **The Solution:** Used a math function (`FARM_FINGERPRINT`) to generate fake dates based on unique IDs.
* **The Benefit:** Ensures dates remain completely stable and constant across every dashboard refresh.

### Fixing Missing Policy Data (Exposure Proxy)
* **The Problem:** The raw vehicle data only tracked drivers who made claims, completely missing safe drivers who paid premiums but never crashed.
* **The Solution:** Multiplied vehicle premiums by **60x**.
* **The Benefit:** Reconstructs the missing 98.4% safe driver population based on a standard 1.6% industry accident rate.

##  Power BI KPI Calculations

### 1. Total Loss Ratio
`DIVIDE([Total Claim Amount], [Total Premium Collected], 0)`
* **What it tracks:** Measures financial health by comparing total claims paid out against total premiums collected.

### 2. New Revenue Gain
`[Simulated Premium] - [Total Premium Collected]`
* **What it tracks:** Calculates the exact extra money earned if the company switches to the new proposed prices.

### 3. Projected Loss Ratio
`DIVIDE([Total Claim Amount], [Simulated Premium], 0)`
* **What it tracks:** Drives the interactive "What-If" slider simulator on Page 3 to predict future financial performance.
