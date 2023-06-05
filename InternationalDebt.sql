Use [International_debt]

IF OBJECT_ID('international_debt', 'U') is not null
drop table international_debt

Create table international_debt (
       [country_name] varchar(100)
      ,[country_code] varchar(100)
      ,[indicator_name] varchar(500)
      ,[indicator_code] varchar(100)
      ,[debt] float
)

Insert into international_debt (
       [country_name]
      ,[country_code]
      ,[indicator_name]
      ,[indicator_code]
      ,[debt]
)
Select 
       [country_name]
      ,[country_code]
      ,[indicator_name]
      ,[indicator_code]
      ,[debt]
From dbo.Raw_International_debt

Select *
From international_debt;

-- Finding the number of distinct countries

Select
	Count(Distinct country_name) as total_distinct_countries
From international_debt;

-- Find out the distinct debt indicators

SELECT 
    DISTINCT indicator_code AS distinct_debt_indicators
FROM international_debt
ORDER BY distinct_debt_indicators;

-- Totaling the amount of debt owed by the countries

SELECT 
    ROUND(SUM(debt)/1000000, 2) AS total_debt
FROM international_debt; 

-- Country with the highest debt

Select Top 1
	country_name, 
	sum(debt) as total_debt
From international_debt
Group by country_name
Order by total_debt Desc;

-- Average amount of debt across indicators

SELECT Top 10
    indicator_code AS debt_indicator,
    indicator_name,
    AVG(debt) AS average_debt
FROM international_debt
GROUP BY indicator_code, indicator_name
ORDER BY average_debt DESC;

-- The highest amount of principal repayments

SELECT 
    country_name, 
    indicator_name
FROM international_debt
WHERE debt = (SELECT 
                  MAX(debt)
              FROM international_debt
              WHERE indicator_code='DT.AMT.DLXF.CD');

-- The most common debt indicator

Select
	indicator_code,
	count(indicator_code) as indicator_count
From international_debt
Group by indicator_code
Order by indicator_count Desc;

--  Find out the maximum amount of debt that each country has

SELECT Top 10 
    country_name, 
    MAX(debt) AS maximum_debt
FROM international_debt
GROUP BY country_name
ORDER BY maximum_debt DESC;
