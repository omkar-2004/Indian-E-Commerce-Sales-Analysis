USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Sales_DataWareHouse')
BEGIN
	Alter DATABASE Sales_DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Sales_DataWareHouse;
END;
GO

CREATE DATABASE Sales_DataWareHouse;
GO

USE Sales_DataWareHouse;
GO

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO