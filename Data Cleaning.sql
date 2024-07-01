--Accounts Table 
--Step 1: Create a duplicate table
CREATE TABLE accounts_2
(account nvarchar(50),
sector nvarchar (50),
year_established smallint,
revenue float,
employees int,
office_location nvarchar(50),
subsidiary_of nvarchar(50)
)
INSERT INTO accounts_2
SELECT * FROM accounts

SELECT * FROM accounts_2

/*Step 2: Create a column for row number*/
SELECT *,
ROW_NUMBER() OVER(PARTITION BY account ORDER BY account) AS row_num
FROM accounts_2

/*Step 3: Find out if there's a duplicate*/
WITH CTE_Duplicate AS (SELECT *,
ROW_NUMBER() OVER(PARTITION BY account ORDER BY account) AS row_num
FROM accounts)

SELECT * FROM CTE_Duplicate
WHERE row_num > 1
/*Step 4: Create a new table and add the row_num column so as to retrieve the rows which have duplicates*/
CREATE TABLE [dbo].[accounts_final](
	[account] [nvarchar](50) NULL,
	[sector] [nvarchar](50) NULL,
	[year_established] [smallint] NULL,
	[revenue] [float] NULL,
	[employees] [int] NULL,
	[office_location] [nvarchar](50) NULL,
	[subsidiary_of] [nvarchar](50) NULL,
	[row_num] INT
)
INSERT INTO accounts_final
SELECT *,
ROW_NUMBER() OVER(PARTITION BY account ORDER BY account) AS row_num
FROM accounts_2
SELECT * FROM accounts_final WHERE row_num>1 
DROP TABLE accounts_2
DROP TABLE accounts_final

--PRODUCTS Table
CREATE TABLE products_1
(product nvarchar(50),
series nvarchar(50),
sales_price smallint
)
INSERT INTO products_1
SELECT * FROM products

SELECT *,
ROW_NUMBER() OVER(PARTITION BY product ORDER BY product) AS row_num
FROM products

DROP TABLE products_1

--Sales_teams table
CREATE TABLE Sales
(sales_agent nvarchar(50),
manager nvarchar(50),
regional_office nvarchar(50)
)
INSERT INTO Sales
SELECT * FROM salesteams

SELECT *,
ROW_NUMBER() OVER(PARTITION BY sales_agent ORDER BY sales_agent) AS row_num
FROM salesteams

WITH duplicate_CTE AS
(SELECT *,
ROW_NUMBER() OVER(PARTITION BY sales_agent ORDER BY sales_agent) AS row_num
FROM salesteams)
SELECT * FROM duplicate_CTE
WHERE row_num >1

DROP TABLE Sales

--SALESPIPELINE TABLE

CREATE TABLE [dbo].[pipeline](
	[opportunity_id] [nvarchar](50) NOT NULL,
	[sales_agent] [nvarchar](50) NOT NULL,
	[product] [nvarchar](50) NOT NULL,
	[account] [nvarchar](50) NULL,
	[deal_stage] [nvarchar](50) NOT NULL,
	[engage_date] [date] NULL,
	[close_date] [date] NULL,
	[close_value] [smallint] NULL
) 
INSERT INTO pipeline
SELECT * FROM salespipeline

SELECT *,
ROW_NUMBER() OVER(PARTITION BY [opportunity_id] ORDER BY [opportunity_id]) AS row_num
FROM pipeline

WITH duplicate_CTE AS 
(SELECT *,
ROW_NUMBER() OVER(PARTITION BY [opportunity_id] ORDER BY [opportunity_id]) AS row_num
FROM pipeline)
SELECT * FROM duplicate_CTE WHERE row_num >1

CREATE TABLE [dbo].[pipeline2](
	[opportunity_id] [nvarchar](50) NOT NULL,
	[sales_agent] [nvarchar](50) NOT NULL,
	[product] [nvarchar](50) NOT NULL,
	[account] [nvarchar](50) NULL,
	[deal_stage] [nvarchar](50) NOT NULL,
	[engage_date] [date] NULL,
	[close_date] [date] NULL,
	[close_value] [smallint] NULL,
	row_num int
) 
INSERT INTO pipeline2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY [opportunity_id] ORDER BY [opportunity_id]) AS row_num
FROM pipeline
DROP TABLE pipeline
DROP TABLE pipeline2

SELECT DISTINCT sector
FROM accounts



