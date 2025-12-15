/*====================================================================
Products Report
======================================================================
Purpose:
- The report consolidates key product metrics and behaviours
Highlights:
1. Gather essential fields such as product name, category, subcategory and cost
2. Segment customers by revenue to identify high-performers, mid-range, low-performers
3. Aggregations:
	- total orders
	- total sales
	- total quantity sold
	- total customers (unique)
	- lifespan (in months)
4. Calculations:
	- recency(months since last sale)
	- average order revenue
	- average monthly revenue
======================================================================*/
CREATE VIEW gold.report_products AS
WITH base_query AS(
/*---------------------------------------------------------------------
1: Base query: retrieves core column from fact_sales and dim_products
---------------------------------------------------------------------*/
SELECT 
	f.order_number,
	f.order_date,
	f.customer_key,
	f.sales_amount,
	f.quantity,
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.cost
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL
),
product_aggregations AS(
/*---------------------------------------------------------------------
2: Product aggregations: metrics at product level 
---------------------------------------------------------------------*/
SELECT 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) AS life_span,
	MAX(order_date) AS last_sale_date,
	COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	ROUND(AVG(CAST(sales_amount AS float) / NULLIF(quantity,0)),1) AS avg_selling_price
FROM base_query
GROUP BY 
	product_key,
	product_name,
	category,
	subcategory,
	cost
	)
/*---------------------------------------------------------------
3: Final query: combines all products results into one output
---------------------------------------------------------------*/
SELECT 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_sale_date,
	DATEDIFF(month, last_sale_date, GETDATE()) AS recency_in_months,
	CASE
		WHEN total_sales > 50000 THEN 'High-performer'
		WHEN total_sales >= 10000 THEN 'Mid-range'
		ELSE 'Low-performer'
	END AS product_segment,
	life_span,
	total_orders,
	total_customers,
	total_sales,
	total_quantity,
	avg_selling_price,
	CASE
		WHEN total_orders = 0 THEN 0
		ELSE total_sales / total_orders
	END AS avg_order_revenue,
	CASE
		WHEN life_span = 0 THEN total_sales
		ELSE total_sales / life_span
	END AS avg_monthly_revenue
FROM product_aggregations
