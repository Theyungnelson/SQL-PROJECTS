select * from synthetic_fraud_dataset;

#Transaction-Level Analysis
#QUERY 1
-- Identify unusually high withdrawals
-- Method 1 — Fixed Threshold (Simple & Common)
-- If you have a known threshold (e.g any withdrawal above ₦500 is suspicious):
select
    Transaction_ID, 
    User_ID, 
    Transaction_Amount, 
    Timestamp
FROM synthetic_fraud_dataset
WHERE Transaction_Type = 'ATM Withdrawal'
  AND Transaction_Amount > 500
ORDER BY Transaction_Amount DESC;


-- Method 2 — Compare to User’s Own History
-- If you want to catch a user making a transaction that’s unusually large for them personally:
SELECT 
    s.Transaction_ID,
    s.User_ID,
    s.Transaction_Amount,
    s.Timestamp
FROM synthetic_fraud_dataset s
JOIN (
    SELECT 
        User_ID,
        AVG(Transaction_Amount) AS user_avg,
        STDDEV(Transaction_Amount) AS user_std
    FROM synthetic_fraud_dataset
    WHERE Transaction_Type = 'ATM Withdrawal'
    GROUP BY User_ID
) u_stats
ON s.User_ID = u_stats.User_ID
WHERE s.Transaction_Type = 'ATM Withdrawal'
  AND s.Transaction_Amount > u_stats.user_avg + 2 * u_stats.user_std
ORDER BY s.Transaction_Amount DESC;

#QUERY 2
-- Detect duplicate or repeated transactions
SELECT 
    s.User_ID,
    s.Transaction_Amount,
    s.Transaction_Type,
    s.Timestamp,
    COUNT(*) AS duplicate_count
FROM synthetic_fraud_dataset s
GROUP BY 
    s.User_ID,
    s.Transaction_Amount,
    s.Transaction_Type,
    s.Timestamp
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


#QUERY 3
-- Flag repeated failed login or payment attempts
-- Detect Repeated Failed Logins
SELECT 
    User_ID,
    COUNT(*) AS failed_login_attempts,
    MIN(Timestamp) AS first_attempt,
    MAX(Timestamp) AS last_attempt
FROM synthetic_fraud_dataset
WHERE Transaction_Type = 'Bank Transfer'
GROUP BY User_ID
HAVING COUNT(*) >= 3
ORDER BY failed_login_attempts DESC;


-- Detect Users with Multiple Failed Attempts
SELECT 
    User_ID,
    SUM(Failed_Transaction_Count_7d) AS total_failed_attempts,
    COUNT(Transaction_ID) AS total_transactions,
    AVG(Risk_Score) AS avg_risk_score,
    MAX(Timestamp) AS last_activity
FROM synthetic_fraud_dataset
GROUP BY User_ID
HAVING SUM(Failed_Transaction_Count_7d) >= 3
ORDER BY total_failed_attempts DESC;


-- Detect Devices or Locations with Repeated Failed Attempts
SELECT 
    Device_Type,
    Location,
    COUNT(DISTINCT User_ID) AS affected_users,
    SUM(Failed_Transaction_Count_7d) AS total_failed_attempts,
    AVG(Risk_Score) AS avg_risk_score
FROM synthetic_fraud_dataset
GROUP BY Device_Type, Location
HAVING SUM(Failed_Transaction_Count_7d) >= 5
ORDER BY total_failed_attempts DESC;

-- Detect High-Failure IP Addresses
SELECT 
    IP_Address_Flag,
    COUNT(DISTINCT User_ID) AS users_involved,
    SUM(Failed_Transaction_Count_7d) AS total_failed_attempts,
    MAX(Risk_Score) AS max_risk_score
FROM synthetic_fraud_dataset
GROUP BY IP_Address_Flag
HAVING SUM(Failed_Transaction_Count_7d) >= 5
ORDER BY total_failed_attempts DESC;


#QUERY 4
-- Detect sudden balance drops(Detect Sudden Balance Drops per User)
SELECT 
    a.User_ID,
    a.Transaction_ID,
    a.Timestamp,
    a.Account_Balance AS current_balance,
    (a.Account_Balance - b.Account_Balance) AS balance_drop,
    a.Transaction_Amount,
    a.Transaction_Type
FROM synthetic_fraud_dataset a
JOIN synthetic_fraud_dataset b
  ON a.User_ID = b.User_ID
  AND a.Timestamp > b.Timestamp
WHERE (a.Account_Balance - b.Account_Balance) < -5000
ORDER BY a.User_ID, a.Timestamp;


-- Detect Sudden Drop + High-Risk Score
SELECT 
    User_ID,
    AVG(Account_Balance) AS avg_balance,
    MIN(Account_Balance) AS min_balance,
    (AVG(Account_Balance) - MIN(Account_Balance)) AS drop_amount,
    AVG(Risk_Score) AS avg_risk
FROM synthetic_fraud_dataset
GROUP BY User_ID
HAVING (AVG(Account_Balance) - MIN(Account_Balance)) > 10000 
   AND AVG(Risk_Score) > 0.7
ORDER BY drop_amount DESC;


#QUERY 5
-- User Behavior Analysis ---- (Detect Sudden Change in Location)
SELECT 
    a.User_ID,
    a.Transaction_ID,
    a.Location AS current_location,
    b.Location AS previous_location
FROM synthetic_fraud_dataset a
JOIN synthetic_fraud_dataset b
  ON a.User_ID = b.User_ID
  AND a.Timestamp > b.Timestamp
WHERE a.User_ID < 1000
LIMIT 200;


-- Flagged transactions from new or untrusted devices
SELECT 
    Transaction_ID,
    User_ID,
    Device_Type,
    Location,
    IP_Address_Flag,
    CASE 
        WHEN IP_Address_Flag = 'Untrusted'
          OR Device_Type NOT IN (
                SELECT DISTINCT Device_Type 
                FROM synthetic_fraud_dataset 
                WHERE Previous_Fraudulent_Activity = 'No'
            )
        THEN 'Flagged'
        ELSE 'Safe'
    END AS Device_Trust_Status
FROM synthetic_fraud_dataset;


-- To check for unusual transaction timing
SELECT 
    t.Transaction_ID,
    t.User_ID,
    t.Timestamp,
    HOUR(t.Timestamp) AS Transaction_Hour,
    CASE 
        WHEN HOUR(t.Timestamp) NOT BETWEEN (
            (SELECT AVG(HOUR(sub.Timestamp)) - 3 
             FROM synthetic_fraud_dataset AS sub 
             WHERE sub.User_ID = t.User_ID)
        ) 
        AND (
            (SELECT AVG(HOUR(sub.Timestamp)) + 3 
             FROM synthetic_fraud_dataset AS sub 
             WHERE sub.User_ID = t.User_ID)
        )
        THEN 'Flagged - Unusual Time'
        ELSE 'Normal'
    END AS Time_Anomaly_Status
FROM synthetic_fraud_dataset t;


#Query 6
-- Card & Account Risk Analysis
-- Flagged transactions using old or expired cards
SELECT
  Transaction_ID,
  User_ID,
  Card_Type,
  Card_Age,
  CASE
    WHEN Card_Age IS NULL OR Card_Age <= 0 THEN 'Flagged - Missing/Expired'
    WHEN Card_Age > 60 THEN 'Flagged - Old Card'    -- >60 months = older than 5 years
    ELSE 'Safe' 
  END AS Card_Status
FROM synthetic_fraud_dataset;


#Query 7
--  Risk segments in the dataset
SELECT 
    Transaction_ID,
    User_ID,
    Risk_Score,
    CASE 
        WHEN Risk_Score >= 80 THEN 'High Risk'
        WHEN Risk_Score BETWEEN 50 AND 79 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Risk_Segment
FROM synthetic_fraud_dataset;


-- fraud rate by category
SELECT 
    Merchant_Category,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN Fraud_Label = 1 THEN 1 ELSE 0 END) AS Fraud_Transactions,
    ROUND(
        SUM(CASE WHEN Fraud_Label = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2
    ) AS Fraud_Rate_Percent
FROM synthetic_fraud_dataset
GROUP BY Merchant_Category
ORDER BY Fraud_Rate_Percent DESC;


-- Fraud summary dashboard (SQL view)
CREATE VIEW fraud_summary AS
SELECT
  COUNT(*) AS Total_Transactions,
  SUM(CASE WHEN Fraud_Label = 1 THEN 1 ELSE 0 END) AS Fraud_Transactions,
  ROUND(SUM(Fraud_Label)/COUNT(*)*100, 2) AS Fraud_Rate,
  CURRENT_DATE() AS Report_Date
FROM synthetic_fraud_dataset;




