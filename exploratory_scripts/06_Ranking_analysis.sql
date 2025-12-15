-- which 5 products generate the highest revenue
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) AS total_rev
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_rev DESC

-- which 5 products generate the highest revenue using window functions
SELECT TOP 5
*
FROM(
SELECT 
p.product_name,
SUM(f.sales_amount) AS total_revenue,
ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) AS rank
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
ON f.product_key = p.product_key
GROUP BY p.product_name
)t

-- what are the 5 worst performing products in terms of sales
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_sales

-- find the top 10 customers who have generated the highest revenue
SELECT TOP 10
*
FROM(
	SELECT 
	c.first_name,
	SUM(f.sales_amount) AS total_rev,
	ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) AS row_num
	FROM gold.fact_sales AS f
	LEFT JOIN gold.dim_customers AS c
	ON f.customer_key = c.customer_key
	GROUP BY c.customer_key,c.first_name
)t

-- the 3 customers with fewest orders placed
SELECT  TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT order_number) AS ord_cnt
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY ord_cnt
