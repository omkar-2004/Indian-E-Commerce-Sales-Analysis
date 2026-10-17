/*
The Scenario: Uncovering Margin Leakage in High-Value Segments
The marketing team is preparing to launch a new VIP loyalty program. They want to target the most valuable customers, but the finance team is concerned that high revenue doesn't always mean high profit. They suspect that some top spenders are heavily relying on coupon codes or predominantly buying products that incur high shipping costs.

Your Analytical Tasks:
1. Segment the VIPs: Using the sales and customer datasets, identify the top 5% of customers based on their overall lifetime value (using the calculated total_amount of successful, delivered orders).
2. Analyze Margin Leakage: For this top 5% cohort, integrate the product data to determine which product categories they purchase most frequently. Calculate the ratio of coupon_discount to the base order_value for these categories. Are there specific categories where your VIPs are disproportionately using coupons, effectively shrinking the margins?
3. Evaluate the Delivery Experience: Finally, incorporate the order data to analyze the fulfillment experience of these VIPs. Calculate the delivery lead time (the difference between order_date and delivery_date). Does a longer delivery time correlate with a noticeably lower rating for these top-tier customers?
*/
USE Sales_DataWareHouse;
SELECT
    s.order_id,
    s.customer_id,
    s.product_id,
    CONCAT(c.customer_first_name, ' ', c.customer_last_name) AS customer_name,
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
    p.total_reviews,
    o.payment_mode,
    o.order_status,
    o.rating,
    o.city AS order_city,
    o.state As order_state,
    o.order_date,
    o.order_time,
    o.delivery_date,
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
WHERE o.order_status = 'Delivered';
