-- calculate the total sales per month and the running total sales over time
SELECT
*,
SUM(total_sales_month) OVER(PARTITION BY DATETRUNC(year,order_date) ORDER BY order_date) AS running_total
FROM(
SELECT 
DATETRUNC(month,order_date) AS order_date,
SUM(sales_amount) AS total_sales_month
FROM gold.fact_sales
WHERE MONTH(order_date) IS NOT NULL
GROUP BY DATETRUNC(month,order_date)
)t

-- calculate the avg price per month and the moving avg sales over time
SELECT
*,
AVG(avg_sales_month) OVER(PARTITION BY DATETRUNC(year,order_date) ORDER BY DATETRUNC(month, order_date) ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS moving_avg_sales
FROM(
SELECT
DATETRUNC(month, order_date) AS order_date,
AVG(sales_amount) AS avg_sales_month
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
)t
