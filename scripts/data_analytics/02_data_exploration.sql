/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
	- To explore the structure of dimension tables.
===============================================================================
*/
-- Explore all Countries our customers come from
SELECT DISTINCT 
	country
FROM gold.dim_customers;

-- Explore all Categories "The Major Divisions"
SELECT DISTINCT
	category,
	subcategory,
	product_name
FROM gold.dim_products
ORDER BY 1, 2, 3;

/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
	- To determine the temporal boundaries of key data points.
	- To understand the range of historical data.
===============================================================================
*/
-- Find the Date of the First & Last Order & Date Duration in months
SELECT 
	MIN(order_date) first_order_date,
	MAX(order_date) last_order_date,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) duration_months
	FROM gold.fact_sales;

-- Find the Youngest & Oldest Customer
SELECT 
	MAX(birthdate) youngest_customer,
	DATEDIFF(year, MAX(birthdate), GETDATE()) youngest_age,
	MIN(birthdate) oldest_customer,
	DATEDIFF(year, MIN(birthdate), GETDATE()) oldest_age
FROM gold.dim_customers;

/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
	- To calculate aggregated metrics (e.g., totals, averages) for quick insights.
	- To identify overall trends or spot anomalies.
===============================================================================
*/
-- Find the Total Sales
SELECT 
	SUM(sales_amount) total_sales
FROM gold.fact_sales;

-- Find how many items are sold
SELECT 
	SUM(quantity) total_sold_items
FROM gold.fact_sales;

-- Find the average selling price
SELECT 
	AVG(price) average_selling_price
FROM gold.fact_sales;

-- Find the Total number of Orders
SELECT COUNT(order_number) AS total_orders FROM gold.fact_sales;
SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales;

-- Find the total number of products
SELECT 
	COUNT(product_number) total_products
FROM gold.dim_products;

-- Find the total number of customers
SELECT 
	COUNT(customer_key) total_customers
FROM gold.dim_customers;

-- Find the total number of customers that has placed an order
SELECT 
	COUNT(DISTINCT customer_key) total_customers
FROM gold.fact_sales;

-- Find the total number of customers that hasn't placed an order
SELECT 
	COUNT(DISTINCT s.customer_key) total_customers
FROM gold.fact_sales s
JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
WHERE s.customer_key <> c.customer_key;

-- Generate a Report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Active Customers', COUNT(customer_key) FROM gold.dim_customers
UNION ALL
SELECT 'Inactive Customers', COUNT(DISTINCT s.customer_key) 
FROM gold.fact_sales s
JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
WHERE s.customer_key <> c.customer_key;

