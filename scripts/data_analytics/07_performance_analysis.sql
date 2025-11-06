/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
	- To measure the performance of products, customers, or regions over time.
	- For benchmarking and identifying high-performing entities.
	- To track yearly trends and growth.
===============================================================================
*/

/* Calculate the average yearly sales across all years and determine how each year performed 
compared to the overall average and the prior year. 
Classify whether each year was above or below the global average, and whether performance
improved or worsened compared to the previous year. */
WITH cte_performance AS (
SELECT 
	*,
	AVG(avg_sales_yearly) OVER () avg_sales_overall,
	LAG(avg_sales_yearly) OVER (ORDER BY date_year) previous_year_sales
FROM (
SELECT 
	YEAR(order_date) date_year,
	AVG(sales_amount) avg_sales_yearly
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
)t)
SELECT 
	*,
	CASE 
		WHEN avg_sales_yearly > avg_sales_overall THEN 'Above Average'
		WHEN avg_sales_yearly < avg_sales_overall THEN 'Below Average'
		WHEN avg_sales_yearly = avg_sales_overall THEN 'Average'
		ELSE 'Unknown'
	END compare_to_avg,
	CASE 
		WHEN avg_sales_yearly > previous_year_sales THEN 'Better Performance'
		WHEN avg_sales_yearly < previous_year_sales THEN 'Worse Performance'
		WHEN avg_sales_yearly < previous_year_sales THEN 'Same Performance'
		ELSE NULL
	END compare_to_last_year
FROM cte_performance;

/* Analyze yearly sales performance of each product by comparing yearly totals 
to both the product’s historical average and the previous year’s performance.
Classify whether each product’s yearly sales were above or below its average, 
and whether the product improved or declined year-over-year. */
WITH yearly_product_sales AS (
    SELECT
        YEAR(f.order_date) AS order_year,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY YEAR(f.order_date), p.product_name
)
SELECT
    order_year,
    product_name,
    current_sales,
    AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
    current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
    CASE 
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change,
    -- Year-over-Year Analysis
    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS prev_year_sales,
    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_prev_year,
    CASE 
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
		WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) = 0 THEN 'No Change'
        ELSE NULL
    END AS prev_year_change
FROM yearly_product_sales
ORDER BY product_name, order_year;


