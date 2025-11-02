/*
# NOTE: This script is used only for testing and identifying data issues.
# It is not related to the production or main project code.

In this script we try to find issues with the data in the Bronze Layer and replicate what is found to the proc_load_silver script,
in order to perfectly clean and transform the data before migrating to the Silver Layer.
*/ 

-------------------------------------------------------------------------------------------------
-- Cleaning & Transformation for bronze.crm_cust_info & Quality Checks for silver.crm_cust_info
-------------------------------------------------------------------------------------------------
-- Check for Nulls or Duplicates in the Primary Key
SELECT 
	cst_id,
	COUNT(*) number_of_duplicates
FROM bronze.crm_cust_info 
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;


-- Check for unwanted Spaces
SELECT cst_firstname
FROM bronze.crm_cust_info 
WHERE cst_firstname != TRIM(cst_firstname);

SELECT cst_lastname
FROM bronze.crm_cust_info 
WHERE cst_lastname != TRIM(cst_lastname);

-- Data Standardization & Consistency
SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info;

SELECT DISTINCT cst_marital_status
FROM bronze.crm_cust_info;


-------------------------------------------------------------------------------------------------
-- Cleaning & Transformation for bronze.crm_prd_info & Quality Checks for silver.crm_prd_info
-------------------------------------------------------------------------------------------------
-- Check for Nulls or Duplicates in the Primary Key
SELECT 
	prd_id,
	COUNT(*) number_of_duplicates
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted Spaces
SELECT prd_key
FROM bronze.crm_prd_info 
WHERE prd_key != TRIM(prd_key);

SELECT prd_nm
FROM bronze.crm_prd_info 
WHERE prd_nm != TRIM(prd_nm);

SELECT prd_line
FROM bronze.crm_prd_info 
WHERE prd_line != TRIM(prd_line);

-- Check for Nulls or Negative Numbers
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info;

-- Check for Invalid Date Orders
SELECT *
FROM bronze.crm_prd_info
WHERE prd_start_dt > prd_end_dt
ORDER BY prd_key, prd_nm, prd_line;  
	-- switching start date with end date will show time overlapping for the same products (Not Possible)
	-- ignoring end date column and remaking it as: End Date = Start Date of the next record for the same product (Possible)
	-- Note: Must discuss with the Source System before any actions of that kind.


-------------------------------------------------------------------------------------------------
-- Cleaning & Transformation for bronze.crm_sales_details & Quality Checks for silver.crm_sales_details
------------------------------------------------------------------------------------------------- 
-- Check for unwanted Spaces
SELECT sls_ord_num
FROM bronze.crm_sales_details 
WHERE sls_ord_num != TRIM(sls_ord_num);

SELECT sls_prd_key
FROM bronze.crm_sales_details 
WHERE sls_prd_key != TRIM(sls_prd_key);

-- Check for Invalid Dates
SELECT sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0 
OR LEN(sls_order_dt) <> 8
OR sls_order_dt < 19000101
OR sls_order_dt > 20500101;     -- Invalid Dates must be converted to NULLs

SELECT sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt <= 0 
OR LEN(sls_ship_dt) <> 8
OR sls_ship_dt < 19000101
OR sls_ship_dt > 20500101; 

SELECT sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
OR LEN(sls_due_dt) <> 8
OR sls_due_dt < 19000101
OR sls_due_dt > 20500101; 

-- Check for Invalid Date Orders
SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

SELECT *
FROM bronze.crm_sales_details
WHERE sls_ship_dt > sls_due_dt;

-- Check for Invalid Price / Quantity / Sales values
SELECT
	sls_sales AS old_sls_sales,
	sls_quantity AS old_sls_quantity,
	sls_price AS old_sls_price,
	CASE 
		WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != ABS(sls_price) * sls_quantity THEN sls_price * sls_quantity
		ELSE sls_sales 
	END sls_sales,
	sls_quantity, 
	CASE 
		WHEN sls_price IS NULL OR sls_price <= 0 THEN sls_sales / NULLIF(sls_quantity, 0)
		ELSE sls_price 
	END sls_price
FROM bronze.crm_sales_details
WHERE sls_sales <> sls_price * sls_quantity
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
ORDER BY sls_sales, sls_quantity, sls_price;


-------------------------------------------------------------------------------------------------
-- Cleaning & Transformation for bronze.erp_cust_az12 & Quality Checks for silver.erp_cust_az12
------------------------------------------------------------------------------------------------- 
-- Check incosistency in the Primary Key
SELECT *
FROM bronze.erp_cust_az12
WHERE cid NOT IN (
	SELECT DISTINCT cst_key FROM bronze.crm_cust_info); -- We have 'NAS' at the beginning to take care of

-- Identify out of reach Dates-of-Birth of Customers
SELECT bdate
FROM bronze.erp_cust_az12
WHERE bdate < '1925-01-01' OR bdate > GETDATE();  -- Given 100 years range (Depends on Company's Policy)

-- Data Standardization & Inconsistency
SELECT DISTINCT gen
FROM bronze.erp_cust_az12

-------------------------------------------------------------------------------------------------
-- Cleaning & Transformation for bronze.erp_loc_a101 & Quality Checks for silver.erp_loc_a101
------------------------------------------------------------------------------------------------- 
-- Check inconsistency in the Primary Key
SELECT 
cid
FROM bronze.erp_loc_a101
WHERE cid IN (
	SELECT cst_key FROM bronze.crm_cust_info)  -- Unnecessary '-' in the cid Column

-- Data Standardization & Inconsistency
SELECT DISTINCT 
	cntry AS old_cntry,
	CASE 
		WHEN TRIM(cntry) IS NULL OR TRIM(cntry) = '' THEN 'N/A'
		WHEN TRIM(cntry) = 'DE' THEN 'Germany'
		WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
		ELSE TRIM(cntry)
	END cntry
FROM bronze.erp_loc_a101
ORDER BY cntry

-------------------------------------------------------------------------------------------------
-- Cleaning & Transformation for bronze.erp_loc_a101 & Quality Checks for silver.erp_loc_a101
------------------------------------------------------------------------------------------------- 
-- Check inconsistency in the Primary Key
SELECT 
	id
FROM bronze.erp_px_cat_g1v2
WHERE id  IN (
	SELECT cat_id FROM silver.crm_prd_info)

-- Check for Unwanted Spaces
SELECT *
FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance)

-- Data Standardization & Inconsistency
SELECT DISTINCT cat
FROM bronze.erp_px_cat_g1v2

SELECT DISTINCT subcat
FROM bronze.erp_px_cat_g1v2
ORDER BY subcat

SELECT DISTINCT maintenance
FROM bronze.erp_px_cat_g1v2
