CREATE or Alter PROCEDURE silver.load_silver AS
BEGIN
	declare @Start_Time DATETIME, @End_Time DATETIME, @Batch_Start_Time DATETIME, @Batch_End_Time DATETIME;
	BEGIN TRY
	set @Batch_Start_Time = GETDATE();
	print '=======================================================================';
	print 'Loading Customer Details Table.';
	print '=======================================================================';

	SET @Start_Time = GETDATE();
	PRINT '>>> Truncating Customer Details Table.'
	TRUNCATE TABLE silver.customer_details;

	print '>>> Loading Data.'
	INSERT INTO silver.customer_details(
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
	)
	SELECT
		customer_id,
		LEFT(customer_name,CHARINDEX(' ',customer_name + ' ') - 1) AS customer_first_name,
		SUBSTRING(customer_name, CHARINDEX(' ', customer_name) + 1, LEN(customer_name)) AS customer_last_name,
		gender,
		age,
		age_group,
		dob,
		email,
		phone,
		city,
		CASE
			WHEN state = 'UP' THEN 'Uttar Pradesh'
			ELSE state
		END AS state,
		pinecode,
		registration_date,
		tier,
		total_orders,
		total_spent
	FROM bronze.customer_details
	SET @End_Time = GETDATE();
	print '>>>Load Duration: ' + cast(DATEDIFF(second,@Start_Time,@End_Time) as NVARCHAR) + ' Seconds';
	Print '+++++++++++++++++++++++++++++++++++++++';

	print '=======================================================================';
	print 'Loading Product Details Table.';
	print '=======================================================================';

	print '>>> Truncating Product Details Table.'
	TRUNCATE TABLE silver.product_details;

	print '>>> Loading Data.'
	INSERT INTO silver.product_details(
		product_id,
		product_name,
		category,
		brand,
		price,
		discount_percent,
		discount_amount,
		selling_amount,
		stock_quantity,
		weight_kg,
		avg_rating,
		total_reviews
	)
	SELECT 
		product_id,
		product_name,
		category,
		brand,
		price,
		discount_percent,
		discount_amount,
		selling_amount,
		stock_quantity,
		weight_kg,
		avg_rating,
		total_reviews
	FROM bronze.product_details
	SET @End_Time = GETDATE();
	print '>>>Load Duration: ' + cast(DATEDIFF(second,@Start_Time,@End_Time) as NVARCHAR) + ' Seconds';
	Print '+++++++++++++++++++++++++++++++++++++++';

	print '=======================================================================';
	print 'Loading Sales Details Table.';
	print '=======================================================================';

	SET @Start_Time = GETDATE();
	print '>>> Truncating Sales Deatails Table.'
	TRUNCATE TABLE silver.sales_details;

	print '>>> Loading Data.'
	INSERT INTO silver.sales_details(
		order_id,
		customer_id,
		product_id,
		order_date,
		order_time,
		delivery_date,
		quantity,
		unit_price,
		order_value,
		shipping_cost,
		coupon_code,
		coupon_discount,
		total_amount,
		payment_mode,
		order_status,
		rating,
		review_text,
		city,
		state,
		customer_age,
		customer_age_group
	)
	SELECT 
		order_id,
		customer_id,
		product_id,
		order_date,
		order_time,
		delivery_date,
		quantity,
		unit_price,
		order_value,
		shipping_cost,
		coupon_code,
		coupon_discount,
		total_amount,
		payment_mode,
		order_status,
		rating,
		review_text,
		city,
		CASE
			WHEN state = 'UP' THEN 'Uttar Pradesh'
			ELSE state
		END AS state,
		customer_age,
		customer_age_group
	FROM bronze.sales_details
	SET @End_Time = GETDATE();
	print '>>>Load Duration: ' + cast(DATEDIFF(second,@Start_Time,@End_Time) as NVARCHAR) + ' Seconds';
	Print '+++++++++++++++++++++++++++++++++++++++';

	SET @Batch_End_Time = GETDATE();
	print '============================================================';
	print 'Loading Silver layer is completed.';
	print '>>> Total Load Duration: ' + cast(DATEDIFF(second,@Batch_Start_Time,@Batch_End_Time) as NVARCHAR) + ' Seconds';
	print '============================================================';

	END TRY
		BEGIN CATCH
		print '============================================================';
		print 'Error while loading bronze layer.';
		print 'Error Message' + error_message();
		print 'Error Number' + cast(ERROR_NUMBER() AS NVARCHAR);
		print 'Error state' + cast(ERROR_STATE() AS NVARCHAR);
		print '============================================================';

	END CATCH
END