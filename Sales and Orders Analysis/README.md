# 🧾 Sales and Orders Analysis (MySQL Project)

## 📚 Table of Contents
- [📌 Project Title & Description](#-project-title--description)
- [🎯 Objective](#-objective)
- [🗂 Database Structure (tables and fields)](#-database-structure-tables-and-fields)
- [🧠 SQL Techniques Used (JOINs, CTEs, subqueries, window functions)](#-sql-techniques-used-joins-ctes-subqueries-window-functions)
- [📊 Key Insights & Findings](#-key-insights--findings)
- [💬 Sample Queries](#-sample-queries)
- [👤 Author](#-author)

---

## 📌 Project Title & Description
**Project:** *Sales and Orders Analysis using MySQL*

This project explores a single-table dataset named **`superstore`** to uncover key sales and order performance insights.  
The analysis focuses on identifying **top customers**, **best-selling products**, **monthly sales trends**, and **declining regions**, providing a strong base for business decision-making.

---

## 🎯 Objective
The primary objectives of this SQL analysis are to:
- Identify **top-performing customers and products**
- Measure **monthly sales growth**
- Detect **declining regional performance**
- Showcase SQL data analysis techniques using real-world sales data

---

## 🗂 Database Structure (tables and fields)

**Table Name:** `superstore`

| Field Name | Description |
|-------------|--------------|
| `Order ID` | Unique identifier for each order |
| `Order Date` | Date when the order was placed |
| `Customer ID` | Unique customer identifier |
| `Customer Name` | Customer’s full name |
| `Region` | Region of sale (East, West, Central, South) |
| `Product Name` | Name of the product sold |
| `Quantity` | Quantity of items sold |
| `Sales` | Total sales amount for the order |

---

## 🧠 SQL Techniques Used (JOINs, CTEs, subqueries, window functions)

| Technique | Description |
|------------|-------------|
| **CTEs (`WITH` clauses)** | Used to organize multi-step queries for clarity |
| **Window Functions (`LAG()`, `OVER()`)** | Used to calculate growth and trends over time |
| **Aggregations (`SUM`, `COUNT`, `GROUP BY`)** | Used to summarize revenue and quantities |
| **Conditional Logic (`CASE WHEN`)** | Used to classify trends (e.g., Declining vs Stable) |
| **Ordering and Limiting (`ORDER BY`, `LIMIT`)** | Used to rank top performers |

---

## 📊 Key Insights & Findings
1. **Top 10 Customers** generate a significant portion of total sales — emphasizing key client relationships.  
2. **Monthly Sales Growth** identifies consistent performance and seasonal trends.  
3. **Top-Selling Products** highlight high-demand and high-value items.  
4. **Regional Trends** help detect declining sales regions for strategic attention.

---

## 💬 Sample Queries

### 🔹 1. Find Top 10 Customers by Revenue
```sql
SELECT 
    `Customer Name`, 
    `Customer ID`, 
    SUM(`Sales`) AS Total_Revenue
FROM superstore
GROUP BY `Customer Name`, `Customer ID`
ORDER BY Total_Revenue DESC
LIMIT 10;


WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(`Order Date`, '%Y-%m') AS month,
        SUM(`Sales`) AS total_sales
    FROM superstore
    GROUP BY DATE_FORMAT(`Order Date`, '%Y-%m')
)
SELECT 
    month,
    total_sales,
    ROUND(
        ((total_sales - LAG(total_sales) OVER (ORDER BY month)) / 
         LAG(total_sales) OVER (ORDER BY month)) * 100, 2
    ) AS monthly_growth_percent
FROM monthly_sales
ORDER BY month;
```

---

## 📂 Files

| File | Description |
|------|-------------|
| [`Sales_and_Orders_Analysis.sql`](./Sales_and_Orders_Analysis.sql) | Complete Solved Queries file |
| [`Superstore_Data.csv`](./Superstore_Data.csv) | Complete Dataset |


---

## 👤 Author & Contact

**Uche Nelson**  
📧 **Email:** [uchenelson9010@gmail.com](mailto:uchenelson9010@gmail.com)  
🔗 **LinkedIn:** [linkedin.com/in/uche-chukwuemeka-nelson](https://www.linkedin.com/in/uche-chukwuemeka-nelson/)   
🌐 **Portfolio:** [datascienceportfol.io/UcheNelson](https://datascienceportfol.io/UcheNelson)  
💬 **GitHub:** [github.com/theyungnelson](https://github.com/theyungnelson)  

---



