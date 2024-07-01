 --SALES ANALYSIS
 SELECT DISTINCT sales_agent AS [Total sales_agents]
 FROM salesteams
 SELECT DISTINCT sales_agent AS [Active sales_agents]
 FROM salespipeline
--TOTAL REVENUE
SELECT SUM(close_value)
FROM [salespipeline]
--SALES AGENT WITH THE HIGHEST CLOSE VALUE
SELECT sales_agent
	  ,SUM(close_value)
FROM [salespipeline]
WHERE deal_stage = 'Won'
GROUP BY sales_agent
ORDER BY 2 ASC
--Total Net Profit
SELECT (SUM(sp.close_value)*1.0 - SUM(pr.sales_price)*1.0 ) / SUM(close_value)
FROM salespipeline sp
JOIN products pr
ON sp.product = pr.product
WHERE deal_stage = 'Won'
--No of Sales Agent by Region
SELECT st.regional_office	
	  ,Regional_Count = COUNT(st.sales_agent)
FROM salesteams st
GROUP BY regional_office
--TOTAL NUMBER OF SALES AGENTS
SELECT DISTINCT sales_agent
FROM salesteams

/*1. Performance of Sales Agents based on Count of Deals*/
SELECT  TOP 10 sales_agent 
		     , COUNT(*) AS [Deal Count]
			 , COUNT(CASE WHEN deal_stage = 'Won' THEN 1
			 END) AS [Won Deals]
	FROM salespipeline 
	GROUP BY sales_agent
	ORDER BY 2 DESC

/*2. Revenue accrued by Sales Agents per region and the net profit made*/
SELECT  sp.sales_agent
	   ,st.regional_office
	   ,pr.product
	   ,Deal_Revenue =SUM(sp.close_value)
	   ,Expected_Revenue =SUM(pr.sales_price)
	   ,[Avg_Revenue] = AVG(sp.close_value)
	   ,Net_Profit = ROUND(((SUM(sp.close_value))-(SUM(pr.sales_price))*1.0)/(SUM(sp.close_value)),4)
	   
FROM salespipeline sp
JOIN salesteams st
ON sp.sales_agent = st.sales_agent
JOIN products pr
ON sp.product = pr.product
WHERE sp.deal_stage = 'Won'
GROUP BY pr.product,sp.sales_agent,st.regional_office
ORDER BY Deal_Revenue DESC

SELECT Net_Profit = ROUND(((SUM(sp.close_value))-(SUM(pr.sales_price))*1.0),2)
FROM salespipeline sp
JOIN products pr
ON sp.product = pr.product
WHERE deal_stage = 'Won'
/*3. Top 10 Sales Agents By Revenue*/
SELECT TOP 10 
			sp.sales_agent
		   ,Deal_Revenue =SUM(close_value)
		   ,Net_profit = SUM(close_value) - SUM(pr.sales_price)
FROM salespipeline sp
JOIN products pr
ON sp.product = pr.product
GROUP BY sales_agent
ORDER BY 2 DESC

/*4. Conversion Rate and Win Rate for Sales Agents
To get the best and least performance based on both criteria*/
SELECT		   sales_agent
		     , COUNT(*) AS [Deal Count]
			 , COUNT(CASE WHEN deal_stage = 'Won' THEN 1
			 END) AS [Won Deals]
			 ,COUNT(CASE WHEN deal_stage = 'Engaging' THEN 1
			 END) AS [Ongoing Deals]
			 ,Conversion_Rate = CAST (ROUND(((COUNT(CASE WHEN deal_stage = 'Engaging' THEN 1
			 END)*1.0)/COUNT(*)),2)AS FLOAT)
			 ,Win_Rate = CAST (ROUND(((COUNT(CASE WHEN deal_stage = 'Won' THEN 1
			 END)*1.0)/COUNT(*)),2) AS FLOAT)
			 ,Loss_Rate =CAST (ROUND(((COUNT(CASE WHEN deal_stage = 'Lost' THEN 1
			 END)*1.0)/COUNT(*)),2) AS FLOAT)
			 
	FROM salespipeline 
	GROUP BY sales_agent
	ORDER BY Conversion_Rate DESC

/*5.Avg Sales by Sales Agents per month*/
SELECT  sales_agent
	   ,Deal_Revenue =SUM(close_value)
	   ,[Avg_Revenue] = AVG(close_value)
	   ,[Month]= MONTH(close_date)
	   ,[Year]= YEAR(close_date)
	   
FROM salespipeline sp
WHERE deal_stage = 'Won'
GROUP BY sales_agent,close_date
ORDER BY Deal_Revenue DESC

SELECT  sales_agent
	   ,Deal_Revenue =SUM(close_value)
	   ,[Avg_Revenue] = AVG(close_value)
	   ,close_date
	   
FROM salespipeline sp
WHERE deal_stage = 'Won'
GROUP BY sales_agent,close_date
ORDER BY Deal_Revenue DESC


/*6. Leaderboard for Sales Agents*/
SELECT sales_agent
	  ,COUNT(*) AS Total_Deal_Count
	  ,COUNT(CASE WHEN deal_stage = 'Prospecting' THEN 1
			 END) AS [Deals_In_View]
	  ,COUNT(CASE WHEN deal_stage = 'Engaging' THEN 1
			 END) AS [Ongoing Deals]
	  ,COUNT(CASE WHEN deal_stage = 'Won' THEN 1
			 END) AS [Won Deals]
	  ,COUNT(CASE WHEN deal_stage = 'Lost' THEN 1
			 END) AS [Lost Deals]
	  ,[Conversion_Rate%] = CAST (ROUND(((COUNT(CASE WHEN deal_stage = 'Engaging' THEN 1
			 END)*1.0)/COUNT(*)),2)AS FLOAT)*100
	  ,[Win_Rate%] = CAST (ROUND(((COUNT(CASE WHEN deal_stage = 'Won' THEN 1
			 END)*1.0)/COUNT(*)),2) AS FLOAT)*100
	  ,Deal_Revenue =SUM(close_value)
	   ,[Avg_Revenue] = AVG(close_value)
FROM salespipeline
GROUP BY sales_agent
ORDER BY 2 DESC
