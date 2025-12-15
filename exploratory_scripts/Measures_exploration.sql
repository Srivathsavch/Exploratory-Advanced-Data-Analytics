-- find the total sales
SELECT 
SUM(sales_amount) AS taotal_sales 
FROM gold.fact_sales

-- find how many items are sold
SELECT
COUNT(quantity) AS total_items 
FROM gold.fact_sales

-- find the average selling price
SELECT
AVG(price) AS avg_price 
FROM gold.fact_sales

-- find the total no.of orders
SELECT
COUNT(DISTINCT order_number) AS total_orders 
FROM gold.fact_sales

-- find total no.of products
SELECT 
COUNT(DISTINCT product_key) AS no_of_products 
FROM gold.dim_products

-- find total no.of customers
SELECT
COUNT(customer_key) AS total_cust 
FROM gold.dim_customers

-- find total no.of customers that has placed an order
SELECT 
COUNT(DISTINCT customer_key) AS total_cust_with_order 
FROM gold.fact_sales

-- generate a report that shows all key metrics of the business
SELECT 'Total sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total quantity' AS measure_name, COUNT(quantity) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Average price' AS measure_name, AVG(price) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total products' AS measure_name, COUNT(DISTINCT product_key) AS no_of_products FROM gold.dim_products
UNION ALL
SELECT 'Total customers' AS measure_name, COUNT(customer_key) AS total_cust FROM gold.dim_customers
UNION ALL
SELECT 'Total cust with orders' AS measure_name, COUNT(DISTINCT customer_key) AS total_cust_with_order FROM gold.fact_sales
