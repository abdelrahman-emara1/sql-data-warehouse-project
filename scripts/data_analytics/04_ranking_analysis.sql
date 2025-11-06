/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
	- To rank items (e.g., products, customers) based on performance or other metrics.
	- To identify top performers or laggards.
===============================================================================
*/

-- Which 5 products Generate the Highest Revenue?
SELECT TOP 5
	p.product_name,
	SUM(s.sales_amount) AS total_revenue,
	RANK() OVER (ORDER BY SUM(s.sales_amount) DESC) AS products_rank
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
GROUP BY p.product_name;

-- Which 5 products Generate the Worst Revenue?
SELECT TOP 5
	p.product_name,
	SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
GROUP BY p.product_name
ORDER BY total_revenue;

-- Find the top 10 customers that generated the highest revenue
SELECT TOP 10
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(f.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) customers_rank
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
	c.customer_key,
	c.first_name,
	c.last_name;

-- The 10 customers with the fewest orders placed
SELECT TOP 10
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
	c.customer_key,
	c.first_name,
	c.last_name
ORDER BY total_orders;

