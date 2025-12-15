-- segment products into cost ranges and count how many products fall into each segment
WITH cost_seg AS(
SELECT 
product_key,
product_name,
cost,
CASE
	WHEN cost < 100 THEN 'Below 100'
	WHEN cost BETWEEN 100 AND 500 THEN '100-500'
	WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
	ELSE 'Above 1000'
END cost_range
FROM gold.dim_products
)
SELECT 
cost_range,
COUNT(product_key) AS seg_wise_cnt
FROM cost_seg
GROUP BY cost_range
ORDER BY seg_wise_cnt

/* group customers into three segments based on the their spending behaviour:
	VIP:  customer with at least 12 months of history and spending more than 5000
	Regular: customer with at least 12 months of history but spending 5000 or less
	New: customer with a lifespan less than 12 months
and find total no.of customers by each group
*/
WITH cust_spending AS(
SELECT 
c.customer_key,
SUM(f.sales_amount) AS total_spent,
MIN(order_date) AS first_order,
MAX(order_date) AS last_order,
DATEDIFF(month,MIN(order_date),MAX(order_date)) AS life_span
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key
)
SELECT
cust_seg,
COUNT(customer_key) AS seg_wise_cust_cnt
FROM(
	SELECT 
	customer_key,
	total_spent
	life_span,
	CASE
		WHEN life_span >= 12 AND total_spent > 5000 THEN 'VIP'
		WHEN life_span >= 12 AND total_spent <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS cust_seg
	FROM cust_spending
	)t GROUP BY cust_seg
