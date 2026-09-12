CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '======================================';
		PRINT 'Loading Bronze layer';
		PRINT '======================================';

		PRINT '--------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------------';
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Lenovo\Desktop\Certificates\Data Analytics Projects\03 - SQL Data Warehouse Project\Datasets\source_crm\cust_info.CSV'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);

		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Lenovo\Desktop\Certificates\Data Analytics Projects\03 - SQL Data Warehouse Project\Datasets\source_crm\prd_info.CSV'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);

		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Lenovo\Desktop\Certificates\Data Analytics Projects\03 - SQL Data Warehouse Project\Datasets\source_crm\sales_details.CSV'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);

		PRINT '--------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '--------------------------------------';
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Lenovo\Desktop\Certificates\Data Analytics Projects\03 - SQL Data Warehouse Project\Datasets\source_erp\LOC_A101.CSV'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);

		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Lenovo\Desktop\Certificates\Data Analytics Projects\03 - SQL Data Warehouse Project\Datasets\source_erp\CUST_AZ12.CSV'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);

		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Lenovo\Desktop\Certificates\Data Analytics Projects\03 - SQL Data Warehouse Project\Datasets\source_erp\PX_CAT_G1V2.CSV'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @batch_end_time = GETDATE();
		PRINT '================================================';
		PRINT 'LOADING BRONZE LAYER IS COMPLETED';
		PRINT 'TOTAL LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) ;
		PRINT '================================================';
	END TRY
	BEGIN CATCH
		PRINT '================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT '================================================';
	END CATCH
END;

-- EXEC bronze.load_bronze
