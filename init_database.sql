/* 
=============================
Create Database and Schemas
=============================
Script purpose:
	This script creates a new database 'DataWarehouse' after checking if it already exists.
	If it exists, it is dropped and recreated. Additionally the script craetes the three schemas
	'bronze', 'silver', 'gold' in 'DataWarehouse' database.
Warning:
	Running this script will drop the entire 'DataWarehouse' database if it exists.
	All data in it will be permanently deleted. Procced with caution and ensure you have a backup before running this script.
*/

USE master;
GO

-- drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

-- create database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- create schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
