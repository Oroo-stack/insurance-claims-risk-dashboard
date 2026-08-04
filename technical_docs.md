#  Project Pipeline & Business Logic

##  Data Architecture
The data flows through three organized stages inside Google BigQuery:
* **Bronze (Raw):** Original messy data uploaded straight from Kaggle.
* **Silver (Cleaned):** Cleaned data views where missing values are fixed and organized into specific categories.
* **Gold (Reporting):** A final table combining all data into a standardized format ready for the dashboard.

##  Smart Transformation Logic

### Consistent Fake Dates
* **The Problem:** The raw medical dataset lacked dates, and using random functions causes data to change every time it refreshes.
* **The Solution:** Used a math function (`FARM_FINGERPRINT`) to generate fake dates based on unique IDs.
* **The Benefit:** Ensures dates remain completely stable and constant across every dashboard refresh.

### Fixing Missing Policy Data (Exposure Proxy)
* **The Problem:** The raw vehicle data only tracked drivers who made claims, completely missing safe drivers who paid premiums but never crashed.
* **The Solution:** Multiplied vehicle premiums by **60x**.
* **The Benefit:** Reconstructs the missing 98.4% safe driver population based on a standard 1.6% industry accident rate.

##  Power BI KPI Calculations

### 1. Total Loss Ratio
```dax
DIVIDE([Total Claim Amount], [Total Premium Collected], 0)
```
* **What it tracks:** Measures financial health by comparing total claims paid out against total premiums collected.

### 2. New Revenue Gain
```dax
[Simulated Premium] - [Total Premium Collected]
```
* **What it tracks:** Calculates the exact extra money earned if the company switches to the new proposed prices.

### 3. Projected Loss Ratio
```dax
DIVIDE([Total Claim Amount], [Simulated Premium], 0)
```
* **What it tracks:** Drives the interactive "What-If" slider simulator on Page 3 to predict future financial performance.

### 4. Institutional Loss Ratio
```dax
Institutional Loss Ratio = DIVIDE([Total Claim Amount], [Total Premium Collected], 0)
```
* **Purpose**: Tracks organizational solvency. It uses a dynamic `SWITCH` color-coding mechanism to flag high-risk ratios.

### 5. Premium Yield Increment
```dax
Premium Yield Increment = [Simulated Premium] - [Total Premium Collected]
```
* **Purpose**: Quantifies marginal revenue gains directly driven by the user-adjusted price increase parameters.

### 6. Projected Loss Ratio
```dax
Projected Loss Ratio = DIVIDE([Total Claim Amount], [Simulated Premium], 0)
```
* **Purpose**: Operates as the underlying logic engine powering the prescriptive "What-If" scenario simulation.

### 7. Policy Pricing Color
```dax
Policy Pricing Color = 
IF(
    [Average Claim Amount] > [Simulated Average Premium], 
    "#E81123", -- Eye-catching Red (Underpriced)
    "#0078D4"  -- Slate Blue (Standard)
)
```
* **Purpose**: Dynamically drives conditional marker formatting for individual data points on the scatter plot visualization ( The "Pure Premium" vs "Current Premium" ).

