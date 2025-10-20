select * from superstore;

#Find Top 10 customers by Revenue
select `Customer Name`, `Customer ID`, sum(`sales`)   as Total_Revenue from superstore
group by `Customer Name`,`Customer ID`
order by Total_Revenue desc
limit 10;

#Calculate monthly sales growth
WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(`Order Date`, '%Y-%m') AS month,
        SUM(`Sales`) AS total_sales
    FROM 
        superstore
    GROUP BY 
        DATE_FORMAT(`Order Date`, '%Y-%m')
    ORDER BY 
        month
)
SELECT 
    month,
    total_sales,
    ROUND(
        ((total_sales - LAG(total_sales) OVER (ORDER BY month)) / LAG(total_sales) OVER (ORDER BY month)) * 100,
        2
    ) AS monthly_growth_percent
FROM 
    monthly_sales;
    
    
#Identify best-selling products
select `Product Name`, sum(`sales`)   as Total_Revenue, sum(`Quantity`) AS total_quantity_sold from superstore
group by `Product Name`
order by Total_Revenue desc
limit 10;

#Detect declining sales regions
WITH regional_monthly_sales AS (
    SELECT 
        `Region`,
        DATE_FORMAT(`Order Date`, '%Y-%m') AS month,
        SUM(`Sales`) AS total_sales
    FROM 
        superstore
    GROUP BY 
        `Region`, DATE_FORMAT(`Order Date`, '%Y-%m')
)
SELECT * 
FROM regional_monthly_sales
ORDER BY Region, month;


#Detect declining sales regions( 2nd Option)
WITH regional_monthly_sales AS (
    SELECT 
        `Region`,
        DATE_FORMAT(`Order Date`, '%Y-%m') AS month,
        SUM(`Sales`) AS total_sales
    FROM 
        superstore
    GROUP BY 
        `Region`, DATE_FORMAT(`Order Date`, '%Y-%m')
),
regional_growth AS (
    SELECT 
        Region,
        month,
        total_sales,
        (total_sales - LAG(total_sales) OVER (PARTITION BY Region ORDER BY month)) AS diff
    FROM 
        regional_monthly_sales
)
SELECT 
    Region,
    SUM(CASE WHEN diff < 0 THEN 1 ELSE 0 END) AS decline_months,
    COUNT(*) - SUM(CASE WHEN diff < 0 THEN 1 ELSE 0 END) AS growth_months,
    CASE 
        WHEN SUM(CASE WHEN diff < 0 THEN 1 ELSE 0 END) > 
             (COUNT(*) - SUM(CASE WHEN diff < 0 THEN 1 ELSE 0 END)) 
        THEN 'Declining'
        ELSE 'Growing/Stable'
    END AS overall_trend
FROM 
    regional_growth
GROUP BY 
    Region
ORDER BY 
    decline_months DESC;

