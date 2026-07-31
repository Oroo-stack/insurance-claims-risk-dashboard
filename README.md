## Actuarial Metrics

Burning Cost: Implemented via DAX to calculate the pure risk premium per exposure unit, enabling institutional profitability monitoring.
Severity Frontier: Utilized Scatter Plot distributions to identify "Tail Risk" and catastrophic loss outliers in the medical portfolio.

Dynamic Alerting: Implemented conditional color formatting for the Institutional Loss Ratio gauge, utilizing hex-code logic to provide immediate visual solvency signals based on actuarial break-even thresholds.

## Data Governance
"Identified a critical Selection Bias in the source Motor dataset (Claims-only register). To ensure the dashboard provides a realistic Institutional Loss Ratio, I engineered a Context-Aware Exposure Proxy in DAX. I applied a 60x multiplier to Motor premiums to simulate a standard 1.6% market frequency, reconstructing the missing 'Safe Driver' exposure without altering the raw claim integrity."
