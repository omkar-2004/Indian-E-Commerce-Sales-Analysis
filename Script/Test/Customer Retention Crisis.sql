/* 
Business Case Study: The High-Value Customer Retention Crisis

The Scenario:
The Chief Marketing Officer (CMO) has noticed that while overall sales seem steady, the marketing costs to acquire new customers are skyrocketing. She suspects that the company is losing its most valuable, long-term customers and replacing them with one-off buyers, which hurts long-term profitability. She wants you to analyze the data, identify who the most valuable customers are, understand their purchasing behaviors, and figure out if they are experiencing issues (like delayed deliveries or poor product quality) that might cause them to churn.
*/
USE Sales_DataWareHouse;
With Sales_data AS (
SELECT
    c.tier,
    o.rating,
    o.order_date,
    o.delivery_date
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_orders AS o
ON s.order_id = o.order_id
LEFT JOIN gold.dim_customer AS c
ON s.customer_id = c.customer_id
WHERE o.order_status = 'Delivered')
SELECT
    tier,
    AVG(DATEDIFF(DAY, order_date, delivery_date)) AS avg_delivery_time,
    avg(rating) AS avg_rating
FROM Sales_data
GROUP BY tier;

SELECT
    
    tier,
    AVG(DATEDIFF(DAY, order_date, delivery_date)) AS avg_delivery_time,
    avg(rating) AS avg_rating
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_orders AS o
ON s.order_id = o.order_id
LEFT JOIN gold.dim_customer AS c
ON s.customer_id = c.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY tier;