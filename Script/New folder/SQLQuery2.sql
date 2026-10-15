/*
Nexus Global Retail Performance Audit

Background:

Nexus Global Retail has recently finalized the migration of its data warehouse
into a Medallion architecture. You are working with the clean, production-ready 
tables in the gold layer: gold.fact_sales, gold.dim_customers, and gold.dim_products.
While top-line revenue appears stable, the executive team suspects that margins are 
compressing in specific product categories and that fulfillment delays are impacting 
high-value customer retention. They need you to audit the data and uncover the root 
causes of these inefficiencies.

Objective:

Analyze sales profitability, evaluate customer purchasing patterns based on demographics,
and assess supply chain efficiency (order-to-shipping lag) to provide actionable 
recommendations to the executive board.
*/

/*
Profitability Analysis: 
The fact table contains sales_amount and quantity,while the product dimension
contains the unit cost. Write a query to calculate the total revenue, total 
cost, and gross profit margin percentage for each category and subcategory.
Rank them by the lowest profit margin to identify underperforming areas.
*/

