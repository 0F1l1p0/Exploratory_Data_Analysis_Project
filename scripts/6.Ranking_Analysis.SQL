/*
This script ranks key business entities (products, categories, customers)
based on performance metrics such as revenue and order volume.

Specifically, it:
- Identifies top and bottom performing products by revenue
- Ranks products using window functions for flexible analysis
- Highlights highest-value customers
- Detects low-engagement customers based on order activity
*/

--Top 5 products that generate the highest revenue

SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key=f.product_key
GROUP BY p.product_cost
ORDER BY SUM(f.sales_amount) DESC

--Top 5 products that generate the lowest revenue

SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key=f.product_key
GROUP BY p.product_cost
ORDER BY SUM(f.sales_amount) ASC

--Top 5 product subcategories that generate the highest revenue

SELECT * FROM
(
SELECT 
	p.product_name,
	SUM(f.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) AS product_rank
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key=f.product_key
GROUP BY p.product_name
) t
WHERE product_rank<=5

--Top 5 product subcategories that generate the lowest revenue

SELECT * FROM
(
SELECT 
	p.product_name,
	SUM(f.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) ASC) AS product_rank
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key=f.product_key
GROUP BY p.product_name
) t
WHERE product_rank<=5


--Top 20 customers with the highest revenue

SELECT TOP 20
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_id=f.customer_id
GROUP BY c.customer_key,c.first_name,c.last_name
ORDER BY SUM(f.sales_amount) DESC

--Top 10 customers with the least placed orders

SELECT TOP 10
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_id=f.customer_id
GROUP BY c.customer_key,c.first_name,c.last_name
ORDER BY COUNT(DISTINCT order_number) ASC
