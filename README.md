
## 📊 Dashboard Preview

### 1. Institutional Overview
*High-level solvency and regional risk concentration.*
![Executive Overview](dashboard/screenshots/01_executive_overview.png)

### 2. Claims Deep-Dive
*Operational leakage and fraud detection audit.*
![Claims Deep-Dive](dashboard/screenshots/02_claims_deepdive.png)

### 3. Premium Intelligence
*Prescriptive "What-If" simulations for rate adequacy.*
![Premium Intelligence](dashboard/screenshots/03_premium_intelligence.png)

### 4. Risk Lifecycle
*Root-cause analysis via AI-driven Decomposition Trees.*
![Risk Lifecycle](dashboard/screenshots/04_risk_lifecycle.png)

## 🎥 Video Walkthrough
[Click here to watch the 3-minute technical walkthrough](dashboard/demo/dashboard_walkthrough.mp4)


## Actuarial Metrics

Burning Cost: Implemented via DAX to calculate the pure risk premium per exposure unit, enabling institutional profitability monitoring.
Severity Frontier: Utilized Scatter Plot distributions to identify "Tail Risk" and catastrophic loss outliers in the medical portfolio.

Dynamic Alerting: Implemented conditional color formatting for the Institutional Loss Ratio gauge, utilizing hex-code logic to provide immediate visual solvency signals based on actuarial break-even thresholds.

## Data Governance
"Identified a critical Selection Bias in the source Motor dataset (Claims-only register). To ensure the dashboard provides a realistic Institutional Loss Ratio, I engineered a Context-Aware Exposure Proxy in DAX. I applied a 60x multiplier to Motor premiums to simulate a standard 1.6% market frequency, reconstructing the missing 'Safe Driver' exposure without altering the raw claim integrity."

Claims Deep-Dive: Focused on operational risk and indemnity leakage. Features a Waterfall severity analysis and a prioritized "High-Risk Audit List" for claims with missing police documentation.

Prescriptive Layer: Developed a Yield Impact model to quantify the financial gain of proposed rate interventions.
Segmented Benchmarking: Integrated regional loss-ratio tracking to identify underpriced cohorts for targeted technical price adjustments.

Yield Simulation: Demonstrated that a 5% institutional rate hike produces a $4.88M revenue increment, optimizing the Combined Ratio to 69%.
Surgical Pricing: Identified specific regional variances (e.g., Northwest) where loss ratios exceed technical targets, necessitating segmented underwriting intervention.
