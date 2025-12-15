-- analyse sales performance over time
SELECT 
YEAR(order_date) order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_cust
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)
