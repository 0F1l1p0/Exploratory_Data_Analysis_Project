/*
This script explores the core numerical measures (KPIs) within the dataset
to understand overall business performance.

Specifically, it:
- Calculates total sales, quantity, and average price
- Identifies total counts of orders, products, and customers
- Provides a consolidated report of key business metrics

This step establishes baseline performance indicators and supports further analysis such as trends, segmentation and comparisons
*/

-- Find the Total Sales Amount

SELECT SUM(sales_amount) as total_sales FROM gold.fact_sales

-- Find how many items have been sold

SELECT SUM(quantity) as total_quantity FROM gold.fact_sales

-- Find the average selling price of the items

SELECT AVG(sls_price) as avg_price FROM gold.fact_sales

-- Find the Total number of Orders

SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales --Putting distinct to eliminate duplicate orders

-- Find the total number of products 

SELECT COUNT(DISTINCT product_key) as total_products FROM gold.dim_products

-- Find the total number of customers

SELECT COUNT(DISTINCT customer_key) as total_customers FROM gold.dim_customers

-- Find the total number of customers that has placed an order at least once

SELECT COUNT(DISTINCT customer_id) AS total_custoemrs FROM gold.fact_sales

--A report that shows all the important metrics of the business

SELECT 'Total Sales' as measurement,SUM(sales_amount) as value FROM gold.fact_sales 
UNION ALL
SELECT 'Total Quantity' as measurement,SUM(quantity) as value FROM gold.fact_sales 
UNION ALL
SELECT 'Average Price' as measurement,AVG(sls_price) as value FROM gold.fact_sales
UNION ALL 
SELECT 'Total N. of Orders' as measurement,COUNT(DISTINCT order_number) as value FROM gold.fact_sales
UNION ALL
SELECT 'Total N. of Products' as measurement,COUNT(DISTINCT product_key) as value FROM gold.dim_products
UNION
SELECT 'Total N. of Customers' as measurement,COUNT(DISTINCT customer_id) AS value FROM gold.fact_sales
