/*
===============================================================================
Time-Series Analysis
===============================================================================
Purpose:
	- To track trends, growth, and changes in key metrics over time.
	- For time-series analysis and identifying seasonality.
	- To measure growth or decline over specific periods.
===============================================================================
*/

-- Discovering Seasonality
SELECT
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY total_sales DESC;  -- December is most valuable month in all aspects

-- Analyse sales performance over time
SELECT
    FORMAT(order_date, 'yyyy-MMM') AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM');
