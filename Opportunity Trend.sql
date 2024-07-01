--NEW OPPORTUNITIES TREND
--TOTAL NUMBER OF OPPORTUNITES
SELECT COUNT(deal_stage)
FROM salespipeline
--Each deal stage count
SELECT deal_stage
	  ,COUNT(*)
FROM salespipeline
GROUP BY deal_stage

/*1. Number of opportunities Monthly*/
SELECT Opportunity_Count = COUNT(*)
	  ,[Month] = MONTH(engage_date)
	  ,[Year] = YEAR(engage_date)
FROM salespipeline

GROUP BY engage_date
ORDER BY 2 ASC

/*2. Number of Engaging deals Monthly*/
SELECT Opportunity_Count = COUNT(*)
	  ,[Month] = MONTH(engage_date)
	  ,[Year] = YEAR(engage_date)
FROM salespipeline
WHERE deal_stage = 'Engaging'
GROUP BY engage_date
ORDER BY 2 ASC

/*3. Number of Closed deals Monthly*/
SELECT Opportunity_Count = COUNT(*)
	  ,[Month] = MONTH(engage_date)
	  ,[Year] = YEAR(engage_date)
FROM salespipeline
WHERE deal_stage = 'Won'
GROUP BY engage_date
ORDER BY 2 ASC

/*4. Number of Deals Lost Monthly*/
SELECT Opportunity_Count = COUNT(*)
	  ,[Month] = MONTH(engage_date)
	  ,[Year] = YEAR(engage_date)
FROM salespipeline
WHERE deal_stage = 'Lost'
GROUP BY engage_date
ORDER BY 2 ASC

/*5. Average Sales Cycle*/
--To get the Average time interval
SELECT [Avg Total Days] = AVG(DATEDIFF(DAY,engage_date,close_date))
FROM salespipeline
--To Win deals
SELECT [Avg Total Days] = AVG(DATEDIFF(DAY,engage_date,close_date))
FROM salespipeline
WHERE deal_stage = 'Won'
--To lose deals
SELECT [Avg Total Days] = AVG(DATEDIFF(DAY,engage_date,close_date))
FROM salespipeline
WHERE deal_stage = 'Lost'

/*6. Revenue generated from Won deals Monthly or annually*/
SELECT Revenue = SUM(close_value)
	  ,[Month] = MONTH(engage_date)
	  ,[Year] = YEAR(engage_date)
FROM  salespipeline
WHERE deal_stage = 'Won'
GROUP BY engage_date
