"In my latest Insurance Risk project, I encountered a classic Actuarial hurdle: Selection Bias.
The raw Motor data was a 'Claims Register'—it only showed people who crashed. This led to a misleading 4,000% Loss Ratio. To solve this for the 'Chief Underwriting Officer,' I architected a cloud-to-BI pipeline that:
Cleaned & Unified disparate Motor and Health streams in Google BigQuery.
Reconstructed Exposure using a DAX-based Actuarial Proxy, simulating a 1.6% frequency to reveal the 'True' institutional health.
Enabled Prescriptive Analytics via 'What-If' parameters for premium loading.
This project demonstrates how we use data engineering to turn 'Dirty Data' into a reliable Decision Support Tool."

Headline: I built a Multi-Line Insurance Risk Suite that outshines traditional Excel reporting. 🚀
The Story: When I started this project, the raw Motor data showed a 4,000% Loss Ratio. As an analyst, I didn't just accept the data—I diagnosed Selection Bias.
The Tech Stack:
🔹 Warehouse: Google BigQuery (SQL-based Medallion Architecture).
🔹 ETL: Deterministic hashing for stable time-series analysis and NULLIF remediation for data gaps.
🔹 BI: Power BI using Import Mode for high-speed DAX performance.
The Actuarial Edge:
By engineering a Context-Aware Exposure Proxy, I reconstructed the missing "Safe Driver" population to reveal a true institutional Loss Ratio of 72%. I then built a Prescriptive 'What-If' Engine that identifies exactly how a 5% rate hike can yield $4.88M in marginal revenue.
Check out the full pipeline and walkthrough on my GitHub!
[Link to Repo]
