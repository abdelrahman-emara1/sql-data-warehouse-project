/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency, 
    and accuracy of the Gold Layer. These checks ensure:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model for analytical purposes.

Usage Notes:
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/


-- ====================================================================
-- Checking 'gold.dim_customers'
-- ====================================================================
-- Checking the Uniqueness of the customer key
SELECT cst_key, COUNT(*)
FROM (
	SELECT 
		ci.cst_id,
		ci.cst_key,
		ci.cst_firstname,
		ci.cst_lastname,
		ci.cst_marital_status,
		ci.cst_gndr,
		ci.cst_create_date,
		ca.bdate,
		ca.gen,
		la.cntry
	FROM silver.crm_cust_info ci   -- Master Table for Customers
	LEFT JOIN silver.erp_cust_az12 ca
	ON ci.cst_key = ca.cid
	LEFT JOIN silver.erp_loc_a101 la
	ON ci.cst_key = la.cid)t
GROUP BY cst_key
HAVING COUNT(*) > 1;

-- Checking Inconsistency in the Gender Information
SELECT 
	ci.cst_gndr,
	ca.gen
FROM silver.crm_cust_info ci 
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid
WHERE ci.cst_gndr <> ca.gen;-- we have to decide which source is more reliable (CRM or ERP) 

SELECT 
	ci.cst_gndr,
	ca.gen,
	CASE 
		WHEN ci.cst_gndr <> 'N/A' THEN ci.cst_gndr  -- CRM is the Master for Gender Information
		ELSE COALESCE(ca.gen, 'N/A') 
	END new_gendr
FROM silver.crm_cust_info ci 
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid
WHERE ci.cst_gndr <> ca.gen;

  
-- ====================================================================
-- Checking 'gold.product_key'
-- ====================================================================
-- Checking the Uniqueness of the product key
SELECT prd_key, COUNT(*)
FROM (
	SELECT 
		pn.prd_id,
		pn.cat_id,
		pn.prd_key,
		pn.prd_nm,
		pn.prd_cost,
		pn.prd_line,
		pn.prd_start_dt,
		pc.cat,
		pc.subcat,
		pc.maintenance
	FROM silver.crm_prd_info pn
	LEFT JOIN silver.erp_px_cat_g1v2 pc
	ON pn.cat_id = pc.id
	WHERE pn.prd_end_dt IS NULL)t
GROUP BY prd_key
HAVING COUNT(*) > 1;


-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Checking the data model connectivity between fact and dimensions (foreign key integrity)
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL; 
