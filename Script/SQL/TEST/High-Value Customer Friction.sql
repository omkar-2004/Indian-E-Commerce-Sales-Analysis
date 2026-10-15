-- High-Value Customer Friction (Focus: Logistics & Retention)

/*
The Business Scenario: 
Customer support is overwhelmed by negative reviews, and leadership
wants to know if poor logistics are alienating your most valuable shoppers.
*/


/*
The SQL Task: 
Write a query to calculate the average delivery time 
(the difference in days between delivery_date and order_date) 
grouped by customer tier and order_state. 
Filter the results to only show states where the average 
delivery time for your highest tier (e.g., 'Gold' or 'Platinum') 
is greater than the overall average delivery time for lower tiers.
*/
WITH DeliveryStats AS(
SELECT
	c.tier,
	o.state AS order_state,
	AVG(CAST(DATEDIFF(day, o.order_date, o.delivery_date) AS FLOAT))AS avg_delivery_time
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_orders AS o
ON s.order_id = o.order_id
LEFT JOIN gold.dim_customer AS c
ON s.customer_id = c.customer_id
GROUP BY c.tier, o.state),
LowTierDeliveryTime AS(
SELECT
	AVG(CAST(DATEDIFF(day, o.order_date, o.delivery_date) AS FLOAT))AS Overall_avg
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_orders AS o
ON s.order_id = o.order_id
LEFT JOIN gold.dim_customer AS c
ON s.customer_id = c.customer_id
WHERE c.tier IN ('Gold','Silver')
),
QualifyingStates AS (
    SELECT ds.order_state
    FROM DeliveryStats ds
    CROSS JOIN LowTierDeliveryTime ola
    WHERE ds.tier = 'Platinum' 
      AND ds.avg_delivery_time > ola.overall_avg
)
SELECT 
    ds.tier,
    ds.order_state,
    ds.avg_delivery_time
FROM DeliveryStats ds
INNER JOIN QualifyingStates qs 
    ON ds.order_state = qs.order_state
ORDER BY ds.order_state, ds.tier;