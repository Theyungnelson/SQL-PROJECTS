# 🧾 Sales and Orders Analysis (MySQL Project)

## 📚 Table of Contents
- [📌 Project Title & Description](#-project-title--description)
- [🎯 Problem Statement](#-Problem-statement)
- [🎯 Objective](#-objective)
- [🎯 Problem Solved](#-Problem-solved)
- [📦 Data Source](#-Data-Source)
- [🗂 Database Structure (tables and fields)](#-database-structure-tables-and-fields)
- [🧠 SQL Techniques Used (JOINs, CTEs, subqueries, window functions)](#-sql-techniques-used-joins-ctes-subqueries-window-functions)
- [📊 Key Insights & Findings](#-key-insights--findings)
- [💬 Sample Queries](#-sample-queries)
- [🎯 Conclusion & Recommendation](#-Conclusion-&-recommendation)
- [👤 Author](#-author)

---

## 📌 Project Title & Description
**Project:** *Sales and Orders Analysis using MySQL*

This project explores a single-table dataset named **`superstore`** to uncover key sales and order performance insights.  
The analysis focuses on identifying **top customers**, **best-selling products**, **monthly sales trends**, and **declining regions**, providing a strong base for business decision-making.

---

## 🎯 Problem Statement
Modern businesses generate vast amounts of transactional data, yet many struggle to convert this raw information into actionable insights. Sales teams often lack clarity on which customers drive the most revenue, which products perform best, and where regional performance is slipping. Without data-driven answers to these questions, strategic decisions become guesswork.
This project tackles the challenge of uncovering meaningful patterns in sales and order data using SQL. By analyzing the Superstore dataset, it aims to bridge the gap between data and decision-making—empowering organizations to optimize customer targeting, product strategy, and regional operations.

---

## 🎯 Objective
The primary objectives of this SQL analysis are to:
- Identify **top-performing customers and products**
- Measure **monthly sales growth**
- Detect **declining regional performance**
- Showcase SQL data analysis techniques using real-world sales data

---

## 🧩 Problem Solved
This project demonstrates how SQL can be leveraged to transform raw sales data into strategic business insights. Using the Superstore dataset, I addressed key analytical challenges that hiring managers often face:
- Customer Prioritization: Identified top revenue-generating customers to support targeted retention and upselling strategies.
- Product Performance: Highlighted best-selling items to inform inventory and marketing decisions.
- Sales Trend Analysis: Measured monthly growth to uncover seasonal patterns and forecast performance.
- Regional Risk Detection: Flagged declining regions to guide resource allocation and regional strategy.

By applying techniques like CTEs, window functions, and conditional logic, this project showcases my ability to solve real-world business problems with SQL—skills directly transferable to data-driven decision-making in your organization.

---

## 📦 Data Source
The dataset used in this project — **`Superstore_Data`** — is a **Sales dataset** created for educational and analytical purposes.  
It does **not contain any real customer data** and is intended solely to demonstrate SQL-based sales analysis strategy.

**Source / Inspiration:**
- Sales data generated based on typical sales analysis structures.
- Reference logic inspired by open datasets and sales research resources such as:
  - [Kaggle: Superstore Dataset](https://www.kaggle.com/)
- All SQL logic, transformations, and analysis were implemented manually by **[Uche Nelson](https://github.com/uche-nelson)**.

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

## 🎯 Conclusion & Recommendation
This analysis demonstrates how SQL can unlock valuable insights from transactional sales data. By identifying top customers, best-selling products, sales trends, and underperforming regions, the project showcases a practical approach to data-driven decision-making.

**Recommendation:**
Businesses should integrate SQL-based analytics into their operations to enhance strategic planning. Regularly analyzing sales data can improve customer targeting, optimize inventory, and guide regional investments—ultimately driving growth and efficiency.

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



