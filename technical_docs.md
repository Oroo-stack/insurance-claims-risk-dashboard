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
