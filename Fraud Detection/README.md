# 🧠 Fraud Detection Via SQL  

> **Detecting anomalies, unusual transactions, and fraudulent behavior using pure SQL.**  
> This project leverages analytical SQL techniques to explore, flag, and summarize potential fraud risks within a synthetic banking transaction dataset.

---

### 1️⃣ Project Title & Description  
**Project Title:** Fraud Detection Via SQL Queries  

This project demonstrates how SQL alone can be used for **fraud analytics** — identifying suspicious behaviors, segmenting risk levels, and analyzing transaction patterns from raw financial data.  
It provides ready-to-run queries that replicate the kind of logic used by financial institutions for fraud monitoring and reporting.

---

### 2️⃣ Problem Statement  
Banks and financial organizations face an increasing challenge in detecting fraudulent activities that often appear normal on the surface.  
Fraudsters exploit multiple devices, fake IPs, and timing anomalies to manipulate transaction systems.  

The goal of this project is to:  
- **Identify patterns** associated with fraud.  
- **Flag anomalies** in transaction behavior.  
- **Provide a basis for fraud risk scoring and segmentation.**

---

### 3️⃣ Problem Solved / Outcome  
✅ Established a **rule-based fraud detection framework** using SQL.  
✅ Detected **unusual transactions** based on user behavior, device, and timing.  
✅ Segmented transactions into **Low, Medium, and High Risk** tiers.  
✅ Produced a **fraud summary dashboard view** for real-time monitoring.  

---

### 4️⃣ Objective  
- Build SQL queries that **detect suspicious behavior** in financial data.  
- Create risk segmentation logic and visualize fraud trends.  
- Demonstrate how **data analysts** can implement **fraud monitoring pipelines** with SQL alone.

---

### 5️⃣ Database Structure (Tables & Fields)

**Main Table:** `synthetic_fraud_dataset`  

| Column | Description |
|--------|--------------|
| `Transaction_ID` | Unique identifier for each transaction |
| `User_ID` | User performing the transaction |
| `Transaction_Amount` | Monetary value of the transaction |
| `Transaction_Type` | Deposit, Withdrawal, Transfer, etc. |
| `Timestamp` | Date and time of the transaction |
| `Account_Balance` | User’s account balance after transaction |
| `Device_Type` | Type of device used |
| `Location` | Transaction location |
| `Merchant_Category` | Type of merchant involved |
| `IP_Address_Flag` | Marks trusted or untrusted IPs |
| `Previous_Fraudulent_Activity` | Indicates if user had past fraud |
| `Daily_Transaction_Count` | Transactions made by user per day |
| `Avg_Transaction_Amount_7d` | 7-day rolling average amount |
| `Failed_Transaction_Count_7d` | Failed attempts over the last 7 days |
| `Card_Type` | Type of card used |
| `Card_Age` | Age of card in months |
| `Transaction_Distance` | Distance from user’s usual transaction point |
| `Authentication_Method` | Login or verification method used |
| `Risk_Score` | Calculated transaction risk score |
| `Is_Weekend` | Boolean for weekend activity |
| `Fraud_Label` | 1 = Fraudulent, 0 = Normal transaction |

---

### 6️⃣ Entity Relationship Diagram (ERD)
You can generate and view the ERD using:  
🖱️ [SQLFlow Online ERD Generator](https://sqlflow.gudusoft.com) → Paste the SQL schema from `synthetic_fraud.sql`.

📄 **SQL Schema File:** [`synthetic_fraud.sql`](./synthetic_fraud.sql)  
📊 **CSV Dataset:** [`synthetic_fraud_dataset.csv`](./synthetic_fraud_dataset.csv)

---

### 7️⃣ SQL Techniques Used  
This project demonstrates real-world SQL analytics techniques including:

| Technique | Description |
|------------|--------------|
| **Conditional Logic (CASE WHEN)** | Used to flag transactions based on thresholds or conditions |
| **Joins & Subqueries** | Compare user behavior across time and context |
| **Aggregation Functions** | COUNT, AVG, SUM, MAX, STDDEV for pattern analysis |
| **Window Functions (LAG, OVER)** | Compare current vs. previous device or location |
| **Data Segmentation** | Classify users or transactions into risk categories |
| **Views** | Create summary tables for dashboard reporting |

---

### 8️⃣ Key Insights & Findings  

📌 **Unusual Withdrawals:**  
Large ATM withdrawals often correlated with higher `Risk_Score` and untrusted IPs.  

📌 **Failed Attempts:**  
Users with multiple failed transactions in a 7-day window showed higher likelihood of fraud.  

📌 **Device & Location Change:**  
New or unfamiliar devices and sudden location shifts triggered more flagged transactions.  

📌 **Risk Segmentation:**  
Most transactions fall into *Medium Risk* range (scores between 50–79).  
High-Risk transactions often showed old cards or weekend activity.

---

### 9️⃣ Sample Queries  

#### 🕵️ Flag Transactions from Untrusted Devices
```sql
SELECT 
    Transaction_ID,
    User_ID,
    Device_Type,
    IP_Address_Flag,
    CASE 
        WHEN IP_Address_Flag = 'Untrusted' THEN 'Flagged'
        ELSE 'Safe'
    END AS Device_Status
FROM synthetic_fraud_dataset;

-- Detect Unusual Transaction Timing
SELECT 
    Transaction_ID,
    User_ID,
    HOUR(Timestamp) AS Hour,
    CASE 
        WHEN HOUR(Timestamp) NOT BETWEEN 6 AND 22 THEN 'Flagged - Unusual Time'
        ELSE 'Normal'
    END AS Time_Status
FROM synthetic_fraud_dataset;

-- Flag Old or Expired Cards
SELECT
  Transaction_ID,
  User_ID,
  Card_Type,
  Card_Age,
  CASE
    WHEN Card_Age > 60 THEN 'Flagged - Old Card'
    ELSE 'Safe'
  END AS Card_Status
FROM synthetic_fraud_dataset;
```
---

### 🔟 Conclusion & Recommendations

✅ **Conclusion:**
SQL alone can efficiently identify key fraud indicators such as unusual timing, repeated failures, device changes, and risk score spikes — forming a strong foundation for machine learning or BI-driven fraud systems.

💡 **Recommendations:**
- Integrate these SQL checks into daily ETL or fraud monitoring pipelines.
- Visualize fraud rates and anomalies in Power BI or Tableau dashboards.
- nExtend this dataset with customer behavior or demographic data for deeper insights.

---

## 📂 Files

| File | Description |
|------|-------------|
| [`synthetic_fraud.sql`](./synthetic_fraud.sql) | SQL file containing fraud detection queries and schema |
| [`synthetic_fraud_dataset.csv`](./synthetic_fraud_dataset.csv) | CSV version of the dataset |
| [`Fraud_Detection_Erd.png`](./Fraud_Detection_Erd.png) | Erd screenshot |

---

## 💬 Author

**Uche Nelson**  
📧 [uchenelson9010@gmail.com](mailto:uchenelson9010@gmail.com)  
🔗 [LinkedIn](https://www.linkedin.com/in/uche-chukwuemeka-nelson/)  
🌐 [Portfolio](https://datascienceportfol.io/UcheNelson)
