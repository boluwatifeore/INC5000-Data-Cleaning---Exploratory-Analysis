-- INC5000 Exploratory Analysis

SELECT *
FROM inc_5000_alternate;


-- How many industries are in INC5000?

SELECT COUNT(DISTINCT industry) AS UniqueIndustryCount
FROM inc_5000_alternate;


-- What are the various unique industries in INC5000?

SELECT DISTINCT industry
FROM inc_5000_alternate
ORDER BY industry;


-- Which industries are most and least represented in the list?

SELECT industry,
	   COUNT(*) AS IndustryCount
FROM inc_5000_alternate
GROUP BY industry
ORDER BY IndustryCount DESC;


-- Which industries saw the largest average growth rate?

SELECT industry,
	   AVG(growth) AS AvgGrowth
FROM inc_5000_alternate
GROUP BY industry
ORDER BY AvgGrowth DESC;


-- What's the average revenue among companies on the list? Broken down by industry?

SELECT industry,
ROUND(AVG(revenue),2) AS AVGOfRevenue
FROM inc_5000_alternate
GROUP BY industry
ORDER BY AVGofRevenue DESC;


-- Are companies that were founded early making more revenue than those foundedmore recently?

SELECT
	CASE
		WHEN founded BETWEEN 1869 AND 1900 THEN 'Early Founded'
        WHEN founded BETWEEN 1901 AND 1950 THEN 'After Early Founded'
        WHEN founded BETWEEN 1951 AND 1980 THEN 'Mid Founded'
        WHEN founded BETWEEN 1981 AND 2000 THEN 'Recent Founded'
    ELSE 'Most Recent Founding'
    END AS YearFoundedRange,
	ROUND(AVG(revenue),2) AS AvgRevenue
    FROM inc_5000_alternate
GROUP BY YearFoundedRange
ORDER BY AvgRevenue DESC;


-- Is high number of workers a key factor to generating more revenue?

SELECT 
    CASE 
        WHEN workers = 0 THEN '0'
        WHEN workers <= 10000 THEN '1-10000'
        WHEN workers <= 20000 THEN '10001-20000'
        WHEN workers <= 30000 THEN '20001-30000'
        WHEN workers <= 40000 THEN '30001-40000'
        WHEN workers <= 50000 THEN '40001-50000'
        WHEN workers <= 60000 THEN '50001-60000'
        WHEN workers <= 70000 THEN '60001-70000'
        WHEN workers <= 80000 THEN '70001-80000'
        WHEN workers <= 90000 THEN '80001-90000'
        WHEN workers <= 100000 THEN '90001-10000'
        WHEN workers <= 120000 THEN '110001-120000'
        WHEN workers <= 130000 THEN '120001-130000'
        WHEN workers <= 140000 THEN '130001-140000'
        ELSE '140000+' 
    END AS WorkersRange,
    COUNT(*) AS CountofCompany,
    AVG(revenue) AS AvgofRevenue
FROM inc_5000_alternate
GROUP BY WorkersRange
ORDER BY AVGofRevenue DESC;


-- What is the top ten city with the most revenue and what companies are based in these cities?

SELECT city,
	state,
    name,
AVG(revenue) AS AVGofRevenue
FROM inc_5000_alternate
GROUP BY state, city, name
ORDER BY AVGofRevenue DESC
LIMIT 10;


-- What are the top 10 companies with the largest increase in staff/new hires?

SELECT name, 
	   workers, 
	   previous_workers, 
       (workers - previous_workers) AS IncreaseInStaff
FROM inc_5000_alternate
ORDER BY IncreaseInStaff DESC
LIMIT 10;


-- What is the average revenue per employee for each industry?

SELECT industry, 
	   SUM(revenue) / SUM(workers) AS AvgRevenuePerEmployee
FROM inc_5000_alternate
GROUP BY industry
ORDER BY AvgRevenuePerEmployee DESC;




