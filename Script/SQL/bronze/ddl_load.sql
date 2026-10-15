USE Sales_DataWareHouse;
GO

CREATE or Alter PROCEDURE bronze.load_bronze AS
BEGIN
	declare @Start_Time DATETIME, @End_Time DATETIME, @Batch_Start_Time DATETIME, @Batch_End_Time DATETIME;
	BEGIN TRY
		set @Batch_Start_Time = GETDATE();
		print '=======================================================================';
		print 'Loading Bronze Layer';
		print '=======================================================================';

		SET @Start_Time = GETDATE();
		PRINT '>>> Truncating Bronze Table: bronze.customer_details Table.'
		TRUNCATE TABLE bronze.customer_details;


		PRINT '>>> Inserting Data in bronze.customer_details Table.'
		BULK INSERT bronze.customer_details
		FROM 'D:\Project\Indian E-Commerce Sales Analysis\Dataset\customers.csv'
		with(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n', 
			TABLOCK
		);
		SET @End_Time = GETDATE();
		print '>>>Load Duration: ' + cast(DATEDIFF(second,@Start_Time,@End_Time) as NVARCHAR) + ' Seconds';
		Print '+++++++++++++++++++++++++++++++++++++++';

		SET @Start_Time = GETDATE();
		PRINT '>>> Truncating Bronze Table: bronze.product_details Table.'
		TRUNCATE TABLE bronze.product_details;

		PRINT '>>> Inserting Data in bronze.product_details Table.'
		BULK INSERT bronze.product_details
		FROM 'D:\Project\Indian E-Commerce Sales Analysis\Dataset\products.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @End_Time = GETDATE();
		print '>>>Load Duration: ' + cast(DATEDIFF(second,@Start_Time,@End_Time) as NVARCHAR) + ' Seconds';
		Print '+++++++++++++++++++++++++++++++++++++++';

		SET @Start_Time = GETDATE();
		PRINT '>>> Truncating Bronze Table: bronze.sales_details Table.'
		TRUNCATE TABLE bronze.sales_details;

		PRINT'>>> Inserting Data in bronze.sales_details Table.'
		BULK INSERT bronze.sales_details
		FROM 'D:\Project\Indian E-Commerce Sales Analysis\Dataset\sales.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			TABLOCK
		);
		SET @End_Time = GETDATE();
		print '>>>Load Duration: ' + cast(DATEDIFF(second,@Start_Time,@End_Time) as NVARCHAR) + ' Seconds';
		Print '+++++++++++++++++++++++++++++++++++++++';
	
		SET @Batch_End_Time = GETDATE();
		print '============================================================';
		print 'Loading Bronze layer is completed.';
		print '>>>Total Load Duration: ' + cast(DATEDIFF(second,@Batch_Start_Time,@Batch_End_Time) as NVARCHAR) + ' Seconds';
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