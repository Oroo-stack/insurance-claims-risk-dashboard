DAX MEASURES

# Total Claim Cost: Sum of consolidated claim amounts from the Gold Layer.
Total Claim Cost = SUM('v_executive_summary'[total_claim_cost])

# Average Claim Severity: Ratio of total cost to total events; used to monitor indemnity inflation.
Average Claim Severity = 
DIVIDE(
    [Total Claim Cost], 
    [Total Claims Frequency], 
    0
)

Data Modeling: Implemented a Star Schema utilizing Conformed Dimensions for Geography and Gender.
Relationship Logic: Established One-to-Many bidirectional-ready relationships to ensure seamless cross-filtering between Motor and Health divisions.

DAX Addition: Institutional Loss Ratio - Measures the ratio of total indemnity outgo against an estimated premium baseline (1.25x loading).
Visual Logic: Page 1 utilizes a "Executive Pulse" layout to monitor solvency and regional concentration risk.

DAX Evolution: Refined Institutional Loss Ratio to dynamic context-switching between Motor (Actual) and Health (Proxy) premiums.
Governance: Implemented Dim_Geography and Dim_Gender as conformed dimensions for institutional cross-filtering.
