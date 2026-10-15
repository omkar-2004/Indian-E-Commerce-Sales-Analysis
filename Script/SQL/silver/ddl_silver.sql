USE Sales_DataWareHouse;
Go

CREATE or ALTER PROCEDURE silver.create_silver_tables AS
BEGIN
	DECLARE @Start_Time DATETIME, @End_Time DATETIME, @Batch_Start_Time DATETIME, @Batch_End_Time DATETIME;
	BEGIN TRY
		SET @Batch_Start_Time = GETDATE();
		print '=======================================================================';
		print 'Creating silver Layer Tables';
		print '=======================================================================';

		-- Creating customer details table in silver schema as silver.customer_details from csv.
		-- if table exists it drop the table and recreate the table
		SET @Start_Time = GETDATE();
		print '=======================================================================';
		print 'Creating Customer Details Table';
		print '=======================================================================';
		PRINT '>>> Droping Existing Table'
		IF OBJECT_ID('silver.customer_details','U') IS NOT NULL
			DROP TABLE silver.customer_details;
		CREATE TABLE silver.customer_details(
			customer_id VARCHAR(255) PRIMARY KEY,
			customer_first_name VARCHAR(255),
			customer_last_name VARCHAR(255),
			gender VARCHAR(255),
			age INT,
			age_group VARCHAR(255),
			dob DATE,
			email VARCHAR(255),
			phone VARCHAR(255),
			city VARCHAR(255),
			state VARCHAR(255),
			pinecode VARCHAR(255),
			registration_date DATE,
			tier VARCHAR(255),
			total_orders INT,
			total_spent FLOAT
		);
		SET @End_Time = GETDATE();
		print '>>>Create Duration: ' + cast(DATEDIFF(second,@Start_Time,@End_Time) as NVARCHAR) + ' Seconds';
		Print '+++++++++++++++++++++++++++++++++++++++';

		-- Creating customer details table in silver schema as silver.product_details from csv.
		-- if table exists it drop the table and recreate the table
		SET @Start_Time = GETDATE();
		print '=======================================================================';
		print 'Creating Product Details Table';
		print '=======================================================================';
		PRINT '>>> Droping Existing Table'
		IF OBJECT_ID('silver.product_details', 'U') IS NOT NULL
			DROP TABLE silver.product_details;
		CREATE TABLE silver.product_details(
			product_id VARCHAR(255) PRIMARY KEY,
			product_name VARCHAR(255),
			category VARCHAR(255),
			brand VARCHAR(255),
			price FLOAT,
			discount_percent FLOAT,
			discount_amount FLOAT,
			selling_amount FLOAT,
			stock_quantity INT,
			weight_kg FLOAT,
			avg_rating FLOAT,
			total_reviews INT
		);
		SET @End_Time = GETDATE();
		print '>>>Create Duration: ' + cast(DATEDIFF(second,@Start_Time,@End_Time) as NVARCHAR) + ' Seconds';
		Print '+++++++++++++++++++++++++++++++++++++++';

		-- Creating customer details table in silver schema as silver.sales_details from csv.
		-- if table exists it drop the table and recreate the table
		SET @Start_Time = GETDATE();
		print '=======================================================================';
		print 'Creating Sales Table';
		print '=======================================================================';
		PRINT '>>> Droping Existing Table'
		IF OBJECT_ID('silver.sales_details', 'U') IS NOT NULL
			DROP TABLE 
			silver.sales_details;
		CREATE TABLE silver.sales_details(
			order_id VARCHAR(255) PRIMARY KEY,
			customer_id VARCHAR(255),
			product_id VARCHAR(255),
			order_date DATE,
			order_time TIME,
			delivery_date DATE,
			quantity INT,
			unit_price FLOAT,
			order_value FLOAT,
			shipping_cost FLOAT,
			coupon_code VARCHAR(255),
			coupon_discount FLOAT,
			total_amount FLOAT,
			payment_mode VARCHAR(255),
			order_status VARCHAR(255),
			rating FLOAT,
			review_text VARCHAR(255),
			city VARCHAR(255),
			state VARCHAR(255),
			customer_age INT,
			customer_age_group VARCHAR(255)
		);
		SET @End_Time = GETDATE();
		print '>>> Create Duration: ' + cast(DATEDIFF(second,@Start_Time,@End_Time) as NVARCHAR) + ' Seconds';
		Print '+++++++++++++++++++++++++++++++++++++++';
	
		SET @Batch_End_Time = GETDATE();
		print '============================================================';
		print 'Creating silver layer is completed.';
		print '>>>Total Create Duration: ' + cast(DATEDIFF(second,@Batch_Start_Time,@Batch_End_Time) as NVARCHAR) + ' Seconds';
		print '============================================================';

	END TRY
	BEGIN CATCH
		print '============================================================';
		print 'Error while loading silver layer.';
		print 'Error Message' + error_message();
		print 'Error Number' + cast(ERROR_NUMBER() AS NVARCHAR);
		print 'Error state' + cast(ERROR_STATE() AS NVARCHAR);
		print '============================================================';

	END CATCH
END