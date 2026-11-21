-- SQL Project: The Billionaire Wealth Investigation
-- Table: billionaires
-- Dataset: 200 records
-- Database platform: SQLite

-- DATA QUALITY CHECKS

-- 1. Check total number of records
SELECT COUNT(*) AS total_records
FROM billionaires;

-- 2. Check for duplicate serial numbers
SELECT serial_number, COUNT(*) AS occurrences
FROM billionaires
GROUP BY serial_number
HAVING COUNT(*) > 1;

-- 3. Check for missing values in all columns
SELECT
    COUNT(*) AS total_records,
    SUM(CASE WHEN serial_number IS NULL THEN 1 ELSE 0 END) AS missing_serial,
    SUM(CASE WHEN rank IS NULL THEN 1 ELSE 0 END) AS missing_rank,
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS missing_name,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS missing_age,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS missing_country,
    SUM(CASE WHEN networth_billion IS NULL THEN 1 ELSE 0 END) AS missing_networth,
    SUM(CASE WHEN industry IS NULL THEN 1 ELSE 0 END) AS missing_industry
FROM billionaires;

-- 4. Check for blank names, countries, or industries
SELECT *
FROM billionaires
WHERE TRIM(name) = ''
   OR TRIM(country) = ''
   OR TRIM(industry) = '';

-- 5. Check for zero or negative net worth
SELECT *
FROM billionaires
WHERE networth_billion <= 0;


-- ASSIGNMENT QUESTION 1
-- Retrieve the 20 richest billionaires
SELECT rank, name, age, country, networth_billion, industry
FROM billionaires
ORDER BY networth_billion DESC
LIMIT 20;


-- ASSIGNMENT QUESTION 2
-- Identify the five youngest billionaires
SELECT rank, name, age, country, networth_billion, industry
FROM billionaires
ORDER BY age ASC
LIMIT 5;


-- ASSIGNMENT QUESTION 3
-- Calculate the average age and average net worth
SELECT
    ROUND(AVG(age), 2) AS average_age,
    ROUND(AVG(networth_billion), 2) AS average_net_worth
FROM billionaires;


-- ASSIGNMENT QUESTION 4
-- Identify the five most represented countries
SELECT
    country,
    COUNT(*) AS billionaire_count
FROM billionaires
GROUP BY country
ORDER BY billionaire_count DESC
LIMIT 5;


-- ASSIGNMENT QUESTION 5
-- Calculate combined net worth by country
SELECT
    country,
    COUNT(*) AS billionaire_count,
    ROUND(SUM(networth_billion), 2) AS total_net_worth
FROM billionaires
GROUP BY country
ORDER BY total_net_worth DESC;


-- ASSIGNMENT QUESTION 6
-- Identify the five industries with the highest number of billionaires
SELECT
    industry,
    COUNT(*) AS billionaire_count
FROM billionaires
GROUP BY industry
ORDER BY billionaire_count DESC
LIMIT 5;


-- ASSIGNMENT QUESTION 7
-- Identify countries with at least five billionaires
SELECT
    country,
    COUNT(*) AS billionaire_count
FROM billionaires
GROUP BY country
HAVING COUNT(*) >= 5
ORDER BY billionaire_count DESC;


-- ASSIGNMENT QUESTION 8
-- Calculate total wealth of billionaires younger than 50
SELECT
    COUNT(*) AS billionaire_count,
    ROUND(SUM(networth_billion), 2) AS total_net_worth
FROM billionaires
WHERE age < 50;


-- ASSIGNMENT QUESTION 9
-- Identify billionaires whose net worth exceeds the overall average
SELECT
    name,
    age,
    country,
    networth_billion,
    industry
FROM billionaires
WHERE networth_billion > (
    SELECT AVG(networth_billion)
    FROM billionaires
)
ORDER BY networth_billion DESC;


-- ASSIGNMENT QUESTION 10
-- Identify the industry with the highest average net worth
SELECT
    industry,
    COUNT(*) AS billionaire_count,
    ROUND(AVG(networth_billion), 2) AS average_net_worth
FROM billionaires
GROUP BY industry
ORDER BY average_net_worth DESC
LIMIT 1;
