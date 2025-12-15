/* 
==================================================================================
Stored Procedure: Load Bronze layer (source -> Bronze)
==================================================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following actions:
    - Truncate the bronze tables before loading data.
    - Uses 'BULK INSERT' to load data from CSV files to bronze tables.
Parameters:
  None.
  This stored procedure does not accepts any parameters or returns any values.
Usage:
  EXEC bronze.load_bronze;
==================================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '======================================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '======================================================================';

		PRINT '----------------------------------------------------------------------';
		PRINT 'Loading CRM tables'
		PRINT '----------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating the table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting data into the table: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\sql_project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>-----------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating the table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting data into the table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\sql_project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			 FIRSTROW = 2,
			 FIELDTERMINATOR = ',',
			 TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>-----------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating the table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting data into the table: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\sql_project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>-----------------------'

		PRINT '----------------------------------------------------------------------';
		PRINT 'Loading ERP tables'
		PRINT '----------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating the table: bronze.erp_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting data into the table: bronze.erp_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\sql_project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>-----------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating the table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting data into the table: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\sql_project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>-----------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating the table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting data into the table: bronze.bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\sql_project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>-----------------------'

		SET @batch_end_time = GETDATE();
		PRINT '======================================================================';
		PRINT 'Loading bronze layer is completed';
		PRINT 'Bronze load duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '======================================================================';
	END TRY
	BEGIN CATCH
		PRINT '================================================';
		PRINT 'Error occured during loading bronze layer';
		PRINT 'Error message: ' + ERROR_MESSAGE();
		PRINT 'Error number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT '================================================'
	END CATCH
END
