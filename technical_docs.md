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

```
Total Premium Collected = 
-- 1. Calculate the real sum for each division separately
VAR MotorPremiumCalculated = SUM('v_auto_refined'[policy_annual_premium]) * 60
VAR HealthPremiumCalculated = SUM('v_medical_refined'[premium_collected])

-- 2. Detect which business line the user has selected in the slicer
VAR SelectedLine = SELECTEDVALUE('v_executive_summary'[business_line])

-- 3. The Switch Logic: Apply the multiplier ONLY to Motor
RETURN 
IF(
    ISFILTERED('v_executive_summary'[business_line]),
    -- If a specific line is selected:
    IF(SelectedLine = "Motor", MotorPremiumCalculated, HealthPremiumCalculated),
    -- If no line is selected (The "Total" View), sum both:
    MotorPremiumCalculated + HealthPremiumCalculated
)
```
Uses Branching Logic to handle disparate data sources. Motor uses an Exposure Proxy (60x) to correct for claimant-only reporting, while Health utilizes the SQL-engineered Technical Premium.


Feature: Prescriptive Simulation Engine.
Logic: Implemented dynamic DAX measures for Projected Loss Ratio tied to a 0-100% premium adjustment parameter. This allows Underwriters to perform real-time sensitivity analysis on portfolio profitability.
