-- =============================================================
-- Create Dimention: gold.dim_customer
-- =============================================================

IF OBJECT_ID('gold.dim_customer','V') IS NOT NULL
	DROP VIEW gold.dim_customer;

GO

CREATE VIEW gold.dim_customer AS (
SELECT
	customer_id,
	customer_first_name,
	customer_last_name,
	gender,
	age,
	age_group,
	dob,
	email,
	phone,
	city,
	state,
	pinecode,
	registration_date,
	tier,
	total_orders,
	total_spent
FROM silver.customer_details)
GO

-- =============================================================
-- Create Dimention: gold.dim_product
-- =============================================================

IF OBJECT_ID('gold.dim_product','V') IS NOT NULL
	DROP VIEW gold.dim_product;
GO
CREATE VIEW gold.dim_product AS(
SELECT 
	product_id,
	product_name,
	category,
	brand,
	price,
	discount_percent / 100 AS discount_percent,
	discount_amount,
	selling_amount,
	stock_quantity,
	weight_kg,
	avg_rating,
	total_reviews
FROM silver.product_details)
GO

-- =============================================================
-- Create Dimention: gold.dim_orders
-- =============================================================

IF OBJECT_ID('gold.dim_orders','V') IS NOT NULL
	DROP VIEW gold.dim_orders;
GO
CREATE VIEW gold.dim_orders AS (
SELECT
	order_id,
	order_date,
	order_time,
	delivery_date,
	payment_mode,
	order_status,
	rating,
	review_text,
	city,
	state
FROM silver.sales_details)
GO

-- =============================================================
-- Create Fact: gold.fact_sales
-- =============================================================

IF OBJECT_ID('gold.fact_sales','V') IS NOT NULL
	DROP VIEW gold.fact_sales;
GO
CREATE VIEW gold.fact_sales AS(
SELECT
	order_id,
	customer_id,
	product_id,
	quantity,
	unit_price,
	order_value,
	shipping_cost,
	coupon_code,
	coupon_discount,
	total_amount
FROM silver.sales_details)
GO