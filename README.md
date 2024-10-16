# INC5000-Data-Cleaning---Exploratory-Analysis

## About

This project aims to uncover insights about the fastest-growing private companies in the United States by understanding what drives success among these companies. The dataset was obtained from the [Maven Analytics Data Playground](https://mavenanalytics.io/data-playground).

"Dataset containing information about each company on the INC 5000 list in 2019. Fields include the company name, industry, founding year, website, and location, as well as 2019 revenue, % growth, number of workers (year-over-year), and the number of years on the list." [source](https://mavenanalytics.io/data-playground)


## Purposes Of The Project

The major aim of this project is to identify trends and insights about the growth, revenue, and workforce of the fastest-growing private companies in the United States. 


## Approach Used

1. **Data Cleaning:** 

- Check for and Remove all Duplicates
- Check for and Fix every Null Values and Blank Fields
- Standardize the whole Data

2. **Exploratory Data Analysis (EDA):** Exploratory data analysis is done to answer the listed questions and aims of this project.

1. How many industries are in INC5000?
2. What are the various unique industries in INC5000?
3. Which industries are most and least represented in the list?
4. Which industries saw the largest average growth rate?
5. What's the average revenue among companies on the list? Broken down by industry?
6. Are companies that were founded early making more revenue than those founded more recently?
7. Is high number of workers a key factor to generating more revenue?
8. What is the top ten city with the most revenue and what companies are based in these cities?
9. What are the top 10 companies with the largest increase in staff/new hires?
10. What is the average revenue per employee for each industry?

## Findings

I discovered the following insights based on the questions asked;

- The most represented industry is Business Products & Services with 491 companies, while Computer Hardware is the least represented with only 32 companies.

- Logistics & Transportation leads with an average growth rate of 717.55%, while IT Services has the lowest at 70.58%.
  
- Security companies have the highest average revenue at $126.7 million, closely followed by Health with $107.6 million while Advertising & Marketing and Media with the lowest average revenue of $18.9 million and $16.7 million respectively.
  
- Companies founded recently have the lowest average revenue ($32.6 million), while older companies (e.g., After Early Founded and Early Founded) with the average revenue of $170.8 million and $167.8 million respectively.
  
- Majority of the companies(4984 of 5000) have workers between 1 and 10,000, with an average revenue of $43.5 million. However, the only one company with the highest revenue of $6 billion has the highest number of workers too of over 140,000 workers.
  
- The city of Eagan, MN tops with $21 billion from Prime Therapeutics, followed by San Francisco, CA with $11 billion from Uber Technologies, and other companies in cities of Santa Ana, CA, Tampa, FL, Reston, VA, Dania Beach, Cincinnati, OH, Eighty Four, PA, McKinney, TX, Raleigh, NC.
  
- Allied Universal had the largest staff increase, going from 36,469 to 155,000, adding 118,531 employees.
  
- Computer Hardware industry has the highest average revenue per employee at $615,385, while the Security industry has the lowest at $50,839.


## Recommendations

I have the following recommendations based on my findings;

- Companies in the Logistics & Transportation and Consumer Products & Services sectors showed the largest average growth rates. Organizations should consider investing in these industries for potential growth opportunities.

- Industries like Computer Hardware and Security, despite having high revenue per employee, show room for improvement in workforce efficiency. Companies could explore training and development programs to promote productivity among employees in industries as such.

- The cities with the highest revenues, such as Eagan, MN, and San Francisco, CA, offer lucrative markets. Companies should consider strategic location decisions and market expansions to capitalize on these areas with high revenue.

- Companies with significant increases in staffing, like Allied Universal, illustrate the benefits of expanding workforce capabilities. Organizations should invest in hiring and training programs to support growth and improve service offerings.


## Code

For the rest of the code, check the [Data Cleaning & Standardization]([https://github.com/Princekrampah/WalmartSalesAnalysis/blob/master/SQL_queries.sql](https://github.com/boluwatifeore/INC5000-Data-Cleaning---Exploratory-Analysis/blob/main/Data%20Cleaning%20%26%20Standardization%20INC_5000.sql)) file

```sql
-- Create Database
CREATE DATABASE IF NOT EXISTS inc_5000_companies;

-- Create Table
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
```
