-- which categories contribute the most to overall sales?
WITH cat_wise_sales AS(
SELECT
p.category,
SUM(f.sales_amount) AS total_sales_cat
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
ON f.product_key = p.product_key
GROUP BY p.category
)
SELECT
category,
total_sales_cat,
SUM(total_sales_cat) OVER() AS total_sales,
CAST(ROUND((CAST(total_sales_cat AS float) / SUM(total_sales_cat) OVER()) * 100, 2) AS VARCHAR) + '%' AS per_sales
FROM cat_wise_sales
ORDER BY total_sales_cat DESC
