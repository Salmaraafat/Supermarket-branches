WITH StoreMetrics AS (
  SELECT
    Store_ID,
    Store_Area,
    Items_Available,
    Daily_Customer_Count,
    Store_Sales,
    CAST(Store_Sales AS FLOAT) / Store_Area AS Sales_per_Area,
    CAST(Store_Sales AS FLOAT) / Daily_Customer_Count AS Sales_per_Customer,
    CAST(Store_Sales AS FLOAT) / Items_Available AS Sales_per_Item
  FROM Stores
)
SELECT *
FROM StoreMetrics;

/*1. What is the average sales value across all stores?*/

SELECT AVG(Store_Sales) AS Avg_Store_Sales
FROM Stores;


/*2. Which store recorded the highest total sales?*/
SELECT TOP 1 Store_ID, Store_Sales
FROM Stores
ORDER BY Store_Sales DESC;



/*3. Which store recorded the lowest total sales?*/
SELECT TOP 1 Store_ID, Store_Sales
FROM Stores
ORDER BY Store_Sales ASC;



/*4. How do store sales vary based on store area?*/
SELECT TOP 5 Store_ID, Store_Area, Store_Sales
FROM Stores
ORDER BY Store_Area;



/*5. Which stores have the highest sales per square meter?*/
SELECT TOP 5 
    Store_ID, 
    Store_Sales, 
    Store_Area,
    CAST(Store_Sales AS FLOAT) / Store_Area AS Sales_per_Sqm
FROM Stores
ORDER BY Sales_per_Sqm DESC;



/* 6. Highest sales per customer */
SELECT TOP 5
    Store_ID,
    Store_Sales,
    Daily_Customer_Count,
    CAST(Store_Sales AS FLOAT) / Daily_Customer_Count AS Sales_per_Customer
FROM Stores
ORDER BY Sales_per_Customer DESC;




/* 7. Highest sales per item */
SELECT TOP 5
    Store_ID,
    Store_Sales,
    Items_Available,
    CAST(Store_Sales AS FLOAT) / Items_Available AS Sales_per_Item
FROM Stores
ORDER BY Sales_per_Item DESC;


/* 8. High customer count but low sales */
SELECT TOP 5
    Store_ID,
    Daily_Customer_Count,
    Store_Sales
FROM Stores
WHERE Daily_Customer_Count > (SELECT AVG(Daily_Customer_Count) FROM Stores)
  AND Store_Sales < (SELECT AVG(Store_Sales) FROM Stores)
ORDER BY Daily_Customer_Count DESC;



/* 9. Low customer count but high sales */
SELECT TOP 5
    Store_ID,
    Daily_Customer_Count,
    Store_Sales
FROM Stores
WHERE Daily_Customer_Count < (SELECT AVG(Daily_Customer_Count) FROM Stores)
  AND Store_Sales > (SELECT AVG(Store_Sales) FROM Stores)
ORDER BY Store_Sales DESC;



/* 10. Group by item range */
SELECT TOP 5
  Items_Available,
  AVG(Store_Sales) AS Avg_Sales
FROM Stores
GROUP BY Items_Available
ORDER BY Items_Available;




/* 11. High sales with few items */
SELECT TOP 5
    Store_ID,
    Items_Available,
    Store_Sales
FROM Stores
WHERE Items_Available < (SELECT AVG(Items_Available) FROM Stores)
  AND Store_Sales > (SELECT AVG(Store_Sales) FROM Stores)
ORDER BY Store_Sales DESC;





/* 12. Top 5 by total sales */

SELECT TOP 5
    Store_ID,
    Store_Sales
FROM Stores
ORDER BY Store_Sales DESC;


/* 13. Most efficient by area, customer, item */

SELECT TOP 5
    Store_ID,
    CAST(Store_Sales AS FLOAT) / Store_Area AS Sales_per_Area,
    CAST(Store_Sales AS FLOAT) / Daily_Customer_Count AS Sales_per_Customer,
    CAST(Store_Sales AS FLOAT) / Items_Available AS Sales_per_Item
FROM Stores
ORDER BY Sales_per_Area DESC, Sales_per_Customer DESC, Sales_per_Item DESC;


/* 14. Big store, small sales */

SELECT TOP 5
    Store_ID,
    Store_Area,
    Store_Sales
FROM Stores
WHERE Store_Area > (SELECT AVG(Store_Area) FROM Stores)
  AND Store_Sales < (SELECT AVG(Store_Sales) FROM Stores)
ORDER BY Store_Area DESC;



/* 15. Possible outliers - highest and lowest sales */

SELECT TOP 5
    Store_ID,
    Store_Sales
FROM Stores
ORDER BY Store_Sales DESC;
-- To check lowest, run separately:
SELECT TOP 5
    Store_ID,
    Store_Sales
FROM Stores
ORDER BY Store_Sales ASC;

