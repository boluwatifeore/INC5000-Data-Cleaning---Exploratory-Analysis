-- inc_5000 Data Cleaning and Standardization


CREATE DATABASE IF NOT EXISTS inc_5000_companies;

CREATE TABLE IF NOT EXISTS inc_5000(
	rank_id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    state CHAR(3) NOT NULL,
    revenue NCHAR(30) NOT NULL,
    growth INT NOT NULL,
    industry VARCHAR(50) NOT NULL,
    workers INT NOT NULL,
    previous_workers INT NOT NULL,
    founded INT NOT NULL,
    years_on_list INT NOT NULL,
    metro VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL
);

SELECT *
FROM inc_5000;

-- inc_5000 Data Cleaning and Standardization

-- 1. Check for and Remove all Duplicates
-- 2. Check for and Fix every Null Values and Blank Fields
-- 3. Standardize the whole Data



-- I want to create an alternative table that will be used for the whole data cleaning 
-- This is to ensure that the raw data is kept intact in case unforeseen situations


SELECT *
FROM inc_5000;

CREATE TABLE inc_5000_alternate
LIKE inc_5000;

SELECT *
FROM inc_5000_alternate;

INSERT inc_5000_alternate
SELECT *
FROM inc_5000;


-- 1. Check and Remove all Duplicates

-- I want to check if there are any duplicates in the data and if so, we remove duplicates

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY rank_id, name, state, revenue, growth, industry, 
workers, previous_workers, founded, years_on_list, metro, city) AS RowNumber
FROM inc_5000_alternate;

SELECT *
FROM (
	SELECT  rank_id, name, state, revenue, growth, industry, 
workers, previous_workers, founded, years_on_list, metro, city,
		ROW_NUMBER() OVER (
			PARTITION BY  rank_id, name, state, revenue, growth, industry, 
workers, previous_workers, founded, years_on_list, metro, city
			) AS RowNumber
	FROM 
		inc_5000_alternate
) duplicates
WHERE 
	RowNumber > 1;
    
-- After checking, there are no duplicates in the data so we move to the next step of data cleaning


-- 2. Check for and Fix every Null Values and Blank Fields

SELECT *
FROM inc_5000_alternate
WHERE rank_id IS NULL
OR name IS NULL
OR state IS NULL
OR revenue IS NULL
OR growth IS NULL
OR industry IS NULL
OR workers IS NULL
OR previous_workers IS NULL
OR founded IS NULL
OR years_on_list IS NULL
OR metro IS NULL
OR city IS NULL;

-- After checking, there are no null values in the data so we move to the next step of checking for blank fields


SELECT *
FROM inc_5000_alternate
WHERE rank_id = ''
OR name = ''
OR state = ''	
OR revenue = ''
OR growth = ''
OR industry = ''
OR workers = ''
OR previous_workers = ''
OR founded = ''
OR years_on_list = ''
OR metro = ''
OR city = '';


-- After checking, I found a good amount of blank field in the metro column only
-- Metro refers to metropolitan area which is used in context of the location (town) of the company
-- I have the state and city of the company already in the dataset which we may say serves the same purpose
-- I will drop the column in the table for that reason

ALTER TABLE inc_5000_alternate
DROP COLUMN metro;

SELECT *
FROM inc_5000_alternate;

-- The metro column has been dropped and is no longer included in the dataset

SELECT *
FROM inc_5000_alternate
WHERE rank_id = ''
OR name = ''
OR state = ''	
OR revenue = ''
OR growth = ''
OR industry = ''
OR workers = ''
OR previous_workers = ''
OR founded = ''
OR years_on_list = ''
OR city = '';

-- Checking further for blank field in the remaining columns
-- There are values like 0 in some columns like 'workers' but they don't count as blank fields but true values in the context of the data


-- However, after re checking, I found that there was a value for the year a company was founded as 0 which is not possible

SELECT *
FROM inc_5000_alternate
WHERE founded = 0;

-- The company is Nassau National Cable
-- I will make personal research and fix accordingly

UPDATE inc_5000_alternate
SET founded = 1950
WHERE founded = 0;

SELECT *
FROM inc_5000_alternate
WHERE founded = 0;

-- Date researched and fixed


-- 3. Standardize the whole Data


-- The revenue column has values written in numbers and words which would not work for calculations
-- This is a very important column to gain insight from in the dataset so it will be fixed

UPDATE inc_5000_alternate
SET revenue = 
	CASE
		WHEN revenue LIKE '%millio%' THEN
 CAST(SUBSTRING(revenue, 1,LENGTH(revenue) -
 LENGTH('million')) AS DECIMAL) * 1000000
	ELSE 0
    END;

SELECT *
FROM inc_5000_alternate;

UPDATE inc_5000_alternate AS alt
JOIN inc_5000 AS main
ON alt.rank_id = main.rank_id
SET alt.revenue = main.revenue;

-- An error that messed up with the revenue column in my alternative table happened
-- Good thing I have the raw data which was helpful to get the column back into my alternative table


UPDATE inc_5000_alternate
SET revenue = 
	CASE
		WHEN revenue LIKE '%million%' THEN
 CAST(SUBSTRING(revenue, 1,LENGTH(revenue) -
 LENGTH('million')) AS DECIMAL) * 1000000
		WHEN revenue LIKE '%billion%' THEN
 CAST(SUBSTRING(revenue, 1,LENGTH(revenue) -
 LENGTH('billion')) AS DECIMAL) * 1000000000
	ELSE 0
    END;
    
UPDATE inc_5000_alternate
SET revenue = FORMAT(revenue, 2);
    
SELECT *
FROM inc_5000_alternate;

-- Revenue column has been successfully fixed into a numerical decimal format which will be helpful for insightful calculations

-- Data looks good, standardized and ready for exploratory analysis



