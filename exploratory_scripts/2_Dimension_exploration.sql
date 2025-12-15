-- dimensions of gold.dim_customers
SELECT DISTINCT
country
FROM gold.dim_customers;

SELECT DISTINCT
marital_status
FROM gold.dim_customers

SELECT DISTINCT 
gender
FROM gold.dim_customers

-- dimensions of gold.dim_products
-- explore all categories
SELECT DISTINCT
category
FROM gold.dim_products;

SELECT DISTINCT
category, subcategory
FROM gold.dim_products;

SELECT DISTINCT
category, 
subcategory, 
product_name 
FROM gold.dim_products
ORDER BY 1,2,3;
