--SELECT TOP 10 * FROM superstore;

-- 1. Total row count
SELECT COUNT(*) AS total_rows 
FROM superstore;

-- 2. Date range of the data
SELECT 
    MIN(Order_Date) AS earliest_order,
    MAX(Order_Date) AS latest_order
FROM superstore;

-- 3. Check NULLs in critical columns
SELECT
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END)     AS null_sales,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END)    AS null_profit,
    SUM(CASE WHEN Discount IS NULL THEN 1 ELSE 0 END)  AS null_discount,
    SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS null_customer_id
FROM superstore;

-- 4. Duplicate order + product combinations
SELECT 
    Order_ID, 
    Product_ID, 
    COUNT(*) AS duplicate_count
FROM superstore
GROUP BY Order_ID, Product_ID
HAVING COUNT(*) > 1;

-- 5. Discount range -- find extreme discounts
SELECT
    MIN(Discount)  AS min_discount,
    MAX(Discount)  AS max_discount,
    ROUND(AVG(Discount), 4) AS avg_discount,
    SUM(CASE WHEN Discount > 0.5 THEN 1 ELSE 0 END) AS orders_above_50pct_discount
FROM superstore;

-- 6. Scale of loss-making orders
SELECT
    COUNT(*)            AS loss_making_rows,
    ROUND(SUM(Profit), 2)  AS total_loss_amount,
    ROUND(MIN(Profit), 2)  AS single_worst_loss
FROM superstore
WHERE Profit < 0;

-- 7. Distinct values in key categorical columns
SELECT 'Segment'  AS col, Segment  AS val, COUNT(*) AS cnt FROM superstore GROUP BY Segment
UNION ALL
SELECT 'Region',   Region,   COUNT(*) FROM superstore GROUP BY Region
UNION ALL
SELECT 'Category', Category, COUNT(*) FROM superstore GROUP BY Category
UNION ALL
SELECT 'Ship_Mode', Ship_Mode, COUNT(*) FROM superstore GROUP BY Ship_Mode
ORDER BY col, cnt DESC;

-- ANALYSIS 1: Profit by Category and Sub-Category
SELECT 
    Category,
    Sub_Category,
    COUNT(*)                        AS total_orders,
    ROUND(SUM(Sales), 2)           AS total_sales,
    ROUND(SUM(Profit), 2)          AS total_profit,
    ROUND(AVG(Discount) * 100, 1)  AS avg_discount_pct,
    ROUND(SUM(Profit)/SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY Category, Sub_Category
ORDER BY total_profit ASC;

-- Discount bucket analysis -- proves discount destroys profit
SELECT 
    CASE 
        WHEN Discount = 0          THEN '0% - No Discount'
        WHEN Discount <= 0.10      THEN '1-10% Discount'
        WHEN Discount <= 0.20      THEN '11-20% Discount'
        WHEN Discount <= 0.30      THEN '21-30% Discount'
        WHEN Discount <= 0.50      THEN '31-50% Discount'
        ELSE                            '50%+ Discount'
    END AS discount_bucket,
    COUNT(*)                            AS total_orders,
    ROUND(SUM(Sales), 2)               AS total_sales,
    ROUND(SUM(Profit), 2)              AS total_profit,
    ROUND(AVG(Profit/NULLIF(Sales,0)) * 100, 2) AS avg_margin_pct
FROM superstore
GROUP BY 
    CASE 
        WHEN Discount = 0          THEN '0% - No Discount'
        WHEN Discount <= 0.10      THEN '1-10% Discount'
        WHEN Discount <= 0.20      THEN '11-20% Discount'
        WHEN Discount <= 0.30      THEN '21-30% Discount'
        WHEN Discount <= 0.50      THEN '31-50% Discount'
        ELSE                            '50%+ Discount'
    END
ORDER BY avg_margin_pct DESC;

-- Region profitability -- which geography is winning and losing
SELECT 
    Region,
    COUNT(*)                     AS total_orders,
    ROUND(SUM(Sales), 2)        AS total_sales,
    ROUND(SUM(Profit), 2)       AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales) * 100, 2) AS profit_margin_pct,
    ROUND(AVG(Discount) * 100, 1) AS avg_discount_pct
FROM superstore
GROUP BY Region
ORDER BY total_profit DESC;

-- Segment profitability
SELECT 
    Segment,
    COUNT(*)                     AS total_orders,
    ROUND(SUM(Sales), 2)        AS total_sales,
    ROUND(SUM(Profit), 2)       AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales) * 100, 2) AS profit_margin_pct,
    ROUND(AVG(Discount) * 100, 1) AS avg_discount_pct
FROM superstore
GROUP BY Segment
ORDER BY total_profit DESC;

-- Shipping delay analysis by ship mode
SELECT 
    Ship_Mode,
    COUNT(*) AS total_orders,
    ROUND(AVG(DATEDIFF(day, Order_Date, Ship_Date)), 1) AS avg_shipping_days,
    MIN(DATEDIFF(day, Order_Date, Ship_Date)) AS min_days,
    MAX(DATEDIFF(day, Order_Date, Ship_Date)) AS max_days
FROM superstore
GROUP BY Ship_Mode
ORDER BY avg_shipping_days;

-- Top 10 most profitable customers
SELECT TOP 10
    Customer_Name,
    Segment,
    Region,
    COUNT(DISTINCT Order_ID)        AS total_orders,
    ROUND(SUM(Sales), 2)           AS total_sales,
    ROUND(SUM(Profit), 2)          AS total_profit
FROM superstore
GROUP BY Customer_Name, Segment, Region
ORDER BY total_profit DESC;

-- Top 10 most loss-making customers
SELECT TOP 10
    Customer_Name,
    Segment,
    Region,
    COUNT(DISTINCT Order_ID)        AS total_orders,
    ROUND(SUM(Sales), 2)           AS total_sales,
    ROUND(SUM(Profit), 2)          AS total_profit,
    ROUND(AVG(Discount) * 100, 1)  AS avg_discount_pct
FROM superstore
GROUP BY Customer_Name, Segment, Region
ORDER BY total_profit ASC;

-- Yearly profit trend
SELECT 
    YEAR(Order_Date)                AS order_year,
    COUNT(*)                        AS total_orders,
    ROUND(SUM(Sales), 2)           AS total_sales,
    ROUND(SUM(Profit), 2)          AS total_profit,
    ROUND(SUM(Profit)/SUM(Sales) * 100, 2) AS profit_margin_pct
FROM superstore
GROUP BY YEAR(Order_Date)
ORDER BY order_year;

-- Final clean export query
SELECT 
    Row_ID,
    Order_ID,
    Order_Date,
    Ship_Date,
    DATEDIFF(day, Order_Date, Ship_Date) AS Shipping_Days,
    Ship_Mode,
    Customer_ID,
    Customer_Name,
    Segment,
    City,
    State,
    Region,
    Category,
    Sub_Category,
    Product_Name,
    ROUND(Sales, 2)     AS Sales,
    Quantity,
    Discount,
    ROUND(Profit, 2)    AS Profit,
    ROUND(Profit/NULLIF(Sales,0) * 100, 2) AS Profit_Margin_Pct,
    YEAR(Order_Date)    AS Order_Year,
    MONTH(Order_Date)   AS Order_Month,
    CASE 
        WHEN Discount = 0     THEN 'No Discount'
        WHEN Discount <= 0.10 THEN 'Low 1-10pct'
        WHEN Discount <= 0.20 THEN 'Medium 11-20pct'
        WHEN Discount <= 0.30 THEN 'High 21-30pct'
        WHEN Discount <= 0.50 THEN 'Very High 31-50pct'
        ELSE                       'Extreme 50pct+'
    END AS Discount_Bucket,
    CASE
        WHEN Profit > 0 THEN 'Profitable'
        ELSE                 'Loss Making'
    END AS Profit_Status
FROM superstore
ORDER BY Order_Date;


