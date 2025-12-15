-- find the date of the first and the last order
SELECT 
	MIN(order_date) AS first_order,
	MAX(order_date) AS last_order,
	DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS order_range_years
FROM gold.fact_sales

-- find the youngest and oldest customers
SELECT 
	MIN(birthdate) AS youngest_cust,
	DATEDIFF(year, MIN(birthdate), GETDATE()) AS min_birthdate_age,
	MAX(birthdate) AS oldest_cust,
	DATEDIFF(year, MAX(birthdate), GETDATE()) AS max_birthdate_age,
	DATEDIFF(year, MIN(birthdate), MAX(birthdate)) AS range_year_diff
FROM gold.dim_customers
