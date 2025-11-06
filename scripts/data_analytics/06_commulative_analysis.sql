/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
	- To calculate running totals or moving averages for key metrics.
	- To track performance over time cumulatively.
	- Useful for growth analysis or identifying long-term trends.
===============================================================================
*/

-- Calculate the Running Total of sales over time 
-- Calculate the Running Average of price over time 
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	avg_price,
	AVG(avg_price) OVER (ORDER BY order_date) AS running_average_price
FROM
(
    SELECT 
        DATETRUNC(year, order_date) AS order_date,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
)t

-- Calculate the Rolling Total of sales over time 
-- Calculate the Rolling Average of price over time 
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_total_sales,
	avg_price,
	AVG(avg_price) OVER (ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS rolling_average_price
FROM
(
    SELECT 
        DATETRUNC(year, order_date) AS order_date,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
)t
