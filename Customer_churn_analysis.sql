#Move the cleaned data to SQL
#Create the SQL database/table

CREATE TABLE customer_churn (
    customer_id VARCHAR2(20),
    gender VARCHAR2(10),
    age NUMBER,
    tenure_months NUMBER,
    contract_type VARCHAR2(30),
    payment_method VARCHAR2(30),
    customer_segment VARCHAR2(20),
    monthly_charges NUMBER(10,2),
    total_charges NUMBER(10,2),
    churn VARCHAR2(5),
    tenure_group VARCHAR2(30),
    churn_flag NUMBER
);

#Importing the cleaned Excel data
#After importing, checking

SELECT COUNT(*)
FROM customer_churn;

#Check for NULL values

SELECT COUNT(*) AS total_records,COUNT(customer_id) AS customer_ids,COUNT(payment_method) AS payment_methods,COUNT(monthly_charges) AS monthly_charges FROM customer_churn;

#SQL Analysis 1: Total customers
SELECT COUNT(*) AS total_customers FROM customer_churn;

#SQL Analysis 2: Churned customers
SELECT COUNT(*) AS churned_customers FROM customer_churn WHERE churn = 'Yes';

#SQL Analysis 3: Retained customers
SELECT COUNT(*) AS retained_customers FROM customer_churn WHERE churn = 'No';

#SQL Analysis 4: Overall churn rate
SELECT ROUND(
        SUM(churn_flag) * 100 / COUNT(*),
        2
    ) AS churn_rate
FROM customer_churn;

#SQL Analysis 5: Churn distribution
SELECT churn,COUNT(*) AS customer_count FROM customer_churn GROUP BY churn;

#SQL Analysis 6: Churn by Contract Type
SELECT contract_type,COUNT(*) AS total_customers,SUM(churn_flag) AS churned_customers
FROM customer_churn GROUP BY contract_type ORDER BY churned_customers DESC;

#SQL Analysis 7: Churn by Payment Method
SELECT
    payment_method,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(
        SUM(churn_flag) * 100 / COUNT(*),
        2
    ) AS churn_rate
FROM customer_churn
GROUP BY payment_method
ORDER BY churn_rate DESC;

#SQL Analysis 8: Churn by Customer Segment
SELECT
    customer_segment,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(
        SUM(churn_flag) * 100 / COUNT(*),
        2
    ) AS churn_rate
FROM customer_churn
GROUP BY customer_segment
ORDER BY churn_rate DESC;

#SQL Analysis 9: Churn by Tenure Group
SELECT
    tenure_group,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(
        SUM(churn_flag) * 100 / COUNT(*),
        2
    ) AS churn_rate
FROM customer_churn
GROUP BY tenure_group
ORDER BY churn_rate DESC;

SQL Analysis 10: Churned customers and monthly charges
SELECT
    churn,
    COUNT(*) AS customers,
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_charges
FROM customer_churn
GROUP BY churn;

#SQL Analysis 11: Total revenue
SELECT
    ROUND(SUM(total_charges), 2) AS total_revenue
FROM customer_churn;

#SQL Analysis 12: Revenue from churned customers
SELECT
    ROUND(SUM(total_charges), 2) AS churned_customer_revenue
FROM customer_churn
WHERE churn = 'Yes';

#SQL Analysis 13: Find high-risk combinations
SELECT
    contract_type,
    customer_segment,
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(
        SUM(churn_flag) * 100 / COUNT(*),
        2
    ) AS churn_rate
FROM customer_churn
GROUP BY
    contract_type,
    customer_segment
ORDER BY churn_rate DESC;

#Save your SQL queries