/*
This script explores the temporal aspects of the dataset to understand
the time range, customer age distribution, and data coverage.

Specifically, it:
- Identifies the first and last recorded order dates
- Measures the total time span of the dataset (years and months)
- Analyzes customer age distribution using birth dates
- Helps uncover trends, seasonality, and data completeness over time

This step is important in EDA as it:
- Establishes the timeframe of analysis
- Highlights potential gaps or anomalies in dates
- Supports time-based aggregations (monthly, yearly trends)
*/

--Finding the date of the first and last order

SELECT 
	MIN(order_date) as first_order_date,
	MAX(order_date) as first_order_date,
	DATEDIFF(YEAR,MIN(order_date),MAX(order_date)) AS order_range
FROM gold.fact_sales

--Finding the date of the first and last order(with a monthly timeframe difference)

SELECT 
	MIN(order_date) as first_order_date,
	MAX(order_date) as first_order_date,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS order_range_month
FROM gold.fact_sales

--Finding the youngest and the oldest customer

SELECT 
	MIN(birth_date) as youngest_birthdate,
	DATEDIFF(YEAR,MIN(birth_date), GETDATE())
				-CASE WHEN DATEADD(YEAR,DATEDIFF(YEAR,MIN(birth_date), GETDATE()),MIN(birth_date))>GETDATE()
				THEN 1 ELSE 0 END as oldest_customer,
	MAX(birth_date) as oldest_birthdate,
	DATEDIFF(YEAR,MAX(birth_date), GETDATE())
				-CASE WHEN DATEADD(YEAR,DATEDIFF(YEAR,MAX(birth_date), GETDATE()),MAX(birth_date))>GETDATE()
				THEN 1 ELSE 0 END as oldest_customer
FROM gold.dim_customers

--Orders distribution by year

SELECT 
    YEAR(order_date) AS order_year,
    COUNT(*) AS total_orders
FROM gold.fact_sales
GROUP BY YEAR(order_date)
ORDER BY order_year

--Orders distribution by month

SELECT 
    FORMAT(order_date, 'yyyy-MM') AS order_month,
    COUNT(*) AS total_orders
FROM gold.fact_sales
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY order_month

--Identify missing dates or gaps

SELECT 
    COUNT(*) AS total_orders,
    COUNT(order_date) AS non_null_order_dates
FROM gold.fact_sales
