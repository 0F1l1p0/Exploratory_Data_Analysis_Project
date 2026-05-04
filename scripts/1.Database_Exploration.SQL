/*
  This script explores the structure of the database by querying system metadata tables.
  It is designed to provide a high-level understanding of how the database is organized.
  
  Specifically, it:
  - Retrieves all available tables and views in the database
  - Inspects the columns within selected tables (e.g., dim_customers, dim_products)
  - Helps identify data types, column names, and table relationships
  
  This step is essential in Exploratory Data Analysis (EDA) as it:
  - Builds familiarity with the dataset
  - Assists in identifying relevant tables for analysis
  - Helps with data modeling and query design
*/

--Exploring The Objects Within the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES

--Explore All Columns in the Database itself
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dim_customers'

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dim_products'

-- Explore All Views in the Database
SELECT * FROM INFORMATION_SCHEMA.VIEWS



