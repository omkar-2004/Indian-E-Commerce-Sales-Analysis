CREATE VIEW gold.Salesdata AS( 
SELECT
	s.order_id,
	s.customer_id,
	s.product_id,
	s.quantity,
	s.unit_price,
	s.order_value,
	s.shipping_cost,
	s.coupon_discount,
	s.total_amount,
	o.order_date,
	o.delivery_date,
	o.payment_mode,
	o.order_status,
	o.rating,
	o.review_text,
	o.city AS order_city,
	o.state AS order_state,
	CONCAT(c.customer_first_name,' ' ,c.customer_last_name) AS customer_name,
	c.gender,
	c.age,
	c.age_group,
	c.dob,
	c.city AS customer_city,
	c.state AS customer_state,
	c.pinecode,
	c.registration_date,
	c.tier,
	c.total_orders,
	c.total_spent,
	p.product_name,
	p.category,
	p.brand,
	p.price,
	p.discount_percent,
	p.discount_amount,
	p.selling_amount,
	p.stock_quantity,
	p.avg_rating,
	p.total_reviews
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_orders AS o
ON s.order_id = o.order_id
LEFT JOIN gold.dim_customer AS c
ON s.customer_id = c.customer_id
LEFT JOIN gold.dim_product AS p
ON s.product_id = p.product_id)