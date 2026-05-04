/*
This script explores key dimension tables to better understand the categorical
and descriptive attributes within the dataset.

Specifically, it:
- Identifies unique values such as countries, product categories, and subcategories
- Examines how data is grouped across business dimensions
- Helps uncover hierarchies (e.g., category → subcategory → product)
- Supports segmentation and filtering for deeper analysis

This step is important in EDA as it:
- Provides business context behind the data
- Helps detect inconsistencies or unexpected values
- Guides how metrics will be grouped and analyzed later

Additional queries are included to further explore distribution and segmentation.

*/

--Exploring the countries where the customers come from to better understand the geographical spread

SELECT DISTINCT country FROM gold.dim_customers

--Exploring the major product categories

SELECT DISTINCT category, subcategory,product_name FROM gold.dim_products
ORDER by category, subcategory,product_name

--Count of customers per country (distribution)
SELECT 
    country,
    COUNT(*) AS customer_count
FROM gold.dim_customers
GROUP BY country
ORDER BY customer_count DESC

--Count of products per category
SELECT 
    category,
    COUNT(*) AS product_count
FROM gold.dim_products
GROUP BY category
ORDER BY product_count DESC

--Count of products per subcategory
SELECT 
    category,
    subcategory,
    COUNT(*) AS product_count
FROM gold.dim_products
GROUP BY category, subcategory
ORDER BY category, product_count DESC
