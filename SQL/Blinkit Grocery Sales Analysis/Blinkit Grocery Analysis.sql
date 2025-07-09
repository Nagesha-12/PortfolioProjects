use projects;

select * from blinkit_data; 
select count(*) from blinkit_data;

Alter table blinkit_data
Rename Column ï»¿Item_Fat_Content To Item_Fat_Content;
desc blinkit_data;

## Data Cleaning
## Update function used to make any changes with alredy existing data

Select distinct (Item_Fat_Content) From blinkit_data;

Update blinkit_data
SET Item_Fat_Content =
Case
When Item_Fat_Content IN ('LF','low fat') Then 'Low Fat'
When Item_Fat_Content = 'reg' Then 'Regular'
Else Item_Fat_Content
End;

## To check whether the row are afftected, we use distinct function
Select distinct (Item_Fat_Content) From blinkit_data;

## KPI's
##  Total Sales in Millions
SELECT CAST(SUM(Total_sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM blinkit_data;

## Average Sales
SELECT CAST(AVG(Total_Sales) AS DECIMAL (10,0)) AS Avg_Sales 
FROM blinkit_data;

## Total Number of Items
SELECT COUNT(*) AS No_of_Items
FROM blinkit_data;

## Average Rating
SELECT CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating
FROM blinkit_data;

## Granular Requirements
## Toatl Sales by Fat Content

SELECT Item_Fat_Content, 
	CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
    CAST(SUM(Total_Sales) AS DECIMAL (10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(rating) AS DECIMAL (10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC;

## Sales by Item Type

SELECT Item_Type, 
	CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
    CAST(SUM(Total_Sales) AS DECIMAL (10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(rating) AS DECIMAL (10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

## Fat Content by Outlet for Total Sales

SELECT 
  Outlet_Location_Type,
  ROUND(SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales ELSE 0 END), 2) AS Low_Fat,
  ROUND(SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Total_Sales ELSE 0 END), 2) AS Regular
FROM 
  blinkit_data
GROUP BY 
  Outlet_Location_Type
ORDER BY 
  Outlet_Location_Type;
  
## Total Sales by Outlet Establishment Year

SELECT Outlet_Establishment_Year,
	CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Total_Sales DESC;

## Percentage of sales by Outlet Size

SELECT
	Outlet_Size,
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL (10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

## Sales by Outlet Location

SELECT Outlet_Location_Type,
	CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL (10,2)) AS Sales_Percentage,
    CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

## Metrics by Outlet Type

SELECT Outlet_Type,
	CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL (10,2)) AS Sales_Percentage,
    CAST(AVG(Total_Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) Avg_Rating
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;


  




