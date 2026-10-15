WITH order_data AS (
SELECT
	s.order_id,
	c.customer_id,
	c.customer_first_name,
	c.customer_last_name,
	c.gender,
	c.age,
	c.age_group,
	c.dob,
	c.email,
	c.city AS cust_city,
	c.state  AS cust_state,
	c.pinecode,
	c.registration_date,
	c.tier,
	s.product_id,
	p.product_name,
	p.category,
	p.brand,
	p.price,
	p.discount_percent,
	p.discount_amount,
	p.selling_amount,
	p.stock_quantity,
	o.order_date,
	o.order_time,
	o.delivery_date,
	o.payment_mode,
	o.order_status,
	o.rating,
	o.review_text,
	o.city,
	o.state,
	s.quantity,
	s.unit_price,
	s.order_value,
	s.shipping_cost,
	s.coupon_code,
	s.coupon_discount,
	s.total_amount
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_orders AS o
ON s.order_id = o.order_id
LEFT JOIN gold.dim_customer AS c
ON s.customer_id = c.customer_id
LEFT JOIN gold.dim_product AS p
ON s.product_id = p.product_id
)
SELECT 
*
FROM order_data
