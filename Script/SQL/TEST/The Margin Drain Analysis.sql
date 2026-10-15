-- The Margin Drain Analysis (Focus: Promotions & Revenue)
/*
The Business Scenario: 
The marketing team is heavily distributing coupons to drive 
sales, but the finance team suspects these aggressive discounts
are destroying actual profitability, especially in specific product lines.
*/

/* 
Write a query to identify the top 5 product category names where 
the total coupon_discount given across all orders exceeds 15% of 
the gross order_value for that category. Only include orders where 
the order_status is 'Delivered' (exclude canceled/returned orders so 
you don't count refunded discounts).
*/

-- Top 5 category

WITH sales_data AS (
SELECT
	s.order_value,
	s.coupon_discount,
	p.category
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_orders AS o
ON s.order_id = o.order_id
LEFT JOIN gold.dim_product AS p
ON s.product_id = p.product_id
WHERE o.order_status = 'Delivered'
)
SELECT TOP 5
	category,
	sum(coupon_discount) AS total_discount_amount,
	sum(order_value) AS total_order_value,
	sum(order_value) * 0.15 AS fifteen_percent_threshold,
	(SUM(coupon_discount) / SUM(order_value)) * 100 AS actual_discount_percentage
FROM sales_data
GROUP BY category
ORDER BY sum(coupon_discount) DESC


-- Top 5 Brand

WITH sales_data AS (
SELECT
	s.order_value,
	s.coupon_discount,
	p.brand
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_orders AS o
ON s.order_id = o.order_id
LEFT JOIN gold.dim_product AS p
ON s.product_id = p.product_id
WHERE o.order_status = 'Delivered'
)
SELECT 
	brand,
	sum(coupon_discount) AS total_discount_amount,
	sum(order_value) AS total_order_value,
	sum(order_value) * 0.15 AS fifteen_percent_threshold,
	(SUM(coupon_discount) / SUM(order_value)) * 100 AS actual_discount_percentage
FROM sales_data
GROUP BY brand
ORDER BY sum(coupon_discount) DESC

-- Top 5 product name 

WITH sales_data AS (
SELECT
	s.order_value,
	s.coupon_discount,
	p.product_name
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_orders AS o
ON s.order_id = o.order_id
LEFT JOIN gold.dim_product AS p
ON s.product_id = p.product_id
WHERE o.order_status = 'Delivered'
)
SELECT
	product_name,
	sum(coupon_discount) AS total_discount_amount,
	sum(order_value) AS total_order_value,
	sum(order_value) * 0.15 AS fifteen_percent_threshold,
	(SUM(coupon_discount) / SUM(order_value)) * 100 AS actual_discount_percentage
FROM sales_data
GROUP BY product_name
ORDER BY sum(coupon_discount) DESC
