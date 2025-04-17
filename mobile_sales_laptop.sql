CREATE DATABASE sales_db;
USE sales_db;
-- ================================
-- DROP existing sales table if exists
-- ================================
DROP TABLE IF EXISTS sales;


-- ================================
-- CREATE the sales table
-- ================================
CREATE TABLE sales (
    product VARCHAR(100),
    brand VARCHAR(100),
    product_code VARCHAR(50),
    product_specification TEXT,
    price DECIMAL(10,2),
    inward_date DATE,
    dispatch_date DATE,
    quantity_sold INT,
    customer_name VARCHAR(255),
    customer_location VARCHAR(255),
    region VARCHAR(100),
    core_specification VARCHAR(255),
    processor_specification VARCHAR(255),
    ram VARCHAR(50),
    rom VARCHAR(50),
    ssd VARCHAR(50)
);

-- ================================
-- LOAD the data from CSV into the table
-- (Ensure the CSV is placed in the secure-file-priv directory)
-- ================================
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mobile_sales_data.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ================================
-- VIEW the first 10 records as a check
-- ================================
SELECT * FROM sales
LIMIT 10;

-- ================================
-- 1️⃣ Total number of products sold by Product Type
-- ================================
SELECT 
    product, 
    COUNT(*) AS total_sales
FROM sales
GROUP BY product
ORDER BY total_sales DESC;

-- ================================
-- 2️⃣ Total number of products sold by Brand
-- ================================
SELECT 
    brand, 
    COUNT(*) AS total_sales
FROM sales
GROUP BY brand
ORDER BY total_sales DESC;

-- ================================
-- 3️⃣ Total number of products sold by Region
-- ================================
SELECT 
    region, 
    COUNT(*) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;

-- ================================
-- 4️⃣ Average Price by Product Type
-- ================================
SELECT 
    product, 
    AVG(price) AS average_price
FROM sales
GROUP BY product
ORDER BY average_price DESC;

-- ================================
-- 5️⃣ Average Price by Brand
-- ================================
SELECT 
    brand, 
    AVG(price) AS average_price
FROM sales
GROUP BY brand
ORDER BY average_price DESC;

-- ================================
-- ✅ BONUS: Total Sales Value by Region
-- (quantity_sold * price)
-- ================================
SELECT 
    region,
    SUM(quantity_sold * price) AS total_sales_value
FROM sales
GROUP BY region
ORDER BY total_sales_value DESC;

-- ================================
-- ✅ BONUS: Top 5 Best-Selling Brands (by quantity sold)
-- ================================
SELECT 
    brand,
    SUM(quantity_sold) AS total_quantity_sold
FROM sales
GROUP BY brand
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- ================================
-- ✅ BONUS: Monthly Sales Trend (Product-wise)
-- ================================
SELECT 
    MONTH(inward_date) AS month,
    product,
    SUM(quantity_sold) AS total_quantity_sold
FROM sales
GROUP BY month, product
ORDER BY month ASC, total_quantity_sold DESC;
