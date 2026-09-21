CREATE DATABASE telco_churn_analytics;

USE telco_churn_analytics;

CREATE TABLE customer_churn (
    customer_id VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    senior_citizen TINYINT,
    partner VARCHAR(5),
    dependents VARCHAR(5),
    tenure INT,
    phone_service VARCHAR(20),
    multiple_lines VARCHAR(30),
    internet_service VARCHAR(20),
    online_security VARCHAR(30),
    online_backup VARCHAR(30),
    device_protection VARCHAR(30),
    tech_support VARCHAR(30),
    streaming_tv VARCHAR(30),
    streaming_movies VARCHAR(30),
    contract_type VARCHAR(30),
    paperless_billing VARCHAR(5),
    payment_method VARCHAR(50),
    monthly_charges DECIMAL(10,2),
    total_charges DECIMAL(12,2),
    churn VARCHAR(5),
    churn_flag TINYINT,
    tenure_band VARCHAR(20),
    monthly_charge_band VARCHAR(20),
    churn_probability DECIMAL(6,5),
    risk_band VARCHAR(20),
    monthly_revenue_at_risk DECIMAL(10,2),
    recommended_action VARCHAR(100)
);

select * from customer_churn;

USE telco_churn_analytics;

SELECT COUNT(*) AS total_customers
FROM customer_churn;

SELECT
    customer_id,
    gender,
    tenure,
    contract_type,
    monthly_charges,
    churn
FROM customer_churn
LIMIT 10;

-- 1. What is the overall churn rate? -- 
SELECT
    COUNT(*) AS total_customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(100 * AVG(churn_flag), 2) AS churn_rate_pct
FROM customer_churn;

-- 2. How much monthly revenue comes from customers who churned? --
SELECT
    ROUND(SUM(monthly_charges), 2) AS total_monthly_revenue,
    ROUND(SUM(CASE WHEN churn_flag = 1 THEN monthly_charges ELSE 0 END), 2)
        AS churned_customer_monthly_revenue
FROM customer_churn;

-- 3. Which contract type has the greatest churn rate? --
SELECT
    contract_type,
    COUNT(*) AS customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(100 * AVG(churn_flag), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY contract_type
ORDER BY churn_rate_pct DESC;

-- 4. Does churn decline as customer tenure increases? -- 
SELECT
    tenure_band,
    COUNT(*) AS customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(100 * AVG(churn_flag), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY tenure_band
ORDER BY churn_rate_pct DESC;

-- 5. Which early-tenure customers need immediate retention attention? --
SELECT
    customer_id,
    tenure,
    contract_type,
    payment_method,
    monthly_charges,
    churn_probability,
    risk_band
FROM customer_churn
WHERE tenure <= 6
  AND risk_band = 'High Risk'
ORDER BY churn_probability DESC;

-- 6. Which payment method is linked to the highest churn? --
SELECT
    payment_method,
    COUNT(*) AS customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(100 * AVG(churn_flag), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY payment_method
ORDER BY churn_rate_pct DESC;

-- 7. Does paperless billing correspond to higher churn? --
SELECT
    paperless_billing,
    COUNT(*) AS customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(100 * AVG(churn_flag), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY paperless_billing;

-- 8. Do Online Security and Tech Support reduce churn? --
SELECT
    online_security,
    tech_support,
    COUNT(*) AS customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(100 * AVG(churn_flag), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY online_security, tech_support
ORDER BY churn_rate_pct DESC;

-- 9. Which internet-service customers are most likely to churn? -- 
SELECT
    internet_service,
    COUNT(*) AS customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(100 * AVG(churn_flag), 2) AS churn_rate_pct,
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_charge
FROM customer_churn
GROUP BY internet_service
ORDER BY churn_rate_pct DESC;

-- 10. Which service bundle has the highest churn rate? --
SELECT
    internet_service,
    online_security,
    tech_support,
    online_backup,
    device_protection,
    COUNT(*) AS customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(100 * AVG(churn_flag), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY
    internet_service,
    online_security,
    tech_support,
    online_backup,
    device_protection
HAVING COUNT(*) >= 30
ORDER BY churn_rate_pct DESC;

-- 11. Which customer segments create the most revenue at risk? --
SELECT
    contract_type,
    internet_service,
    COUNT(*) AS customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(SUM(monthly_charges), 2) AS monthly_revenue,
    ROUND(SUM(monthly_revenue_at_risk), 2) AS revenue_at_risk
FROM customer_churn
GROUP BY contract_type, internet_service
ORDER BY revenue_at_risk DESC;

-- 12. Who are the highest-priority customers for the retention team? --
SELECT
    customer_id,
    tenure,
    contract_type,
    payment_method,
    internet_service,
    monthly_charges,
    churn_probability,
    monthly_revenue_at_risk,
    recommended_action
FROM customer_churn
WHERE risk_band = 'High Risk'
ORDER BY
    churn_probability DESC,
    monthly_charges DESC;

-- 13. Which retention action is needed most often? --
SELECT
    recommended_action,
    COUNT(*) AS high_risk_customers,
    ROUND(SUM(monthly_revenue_at_risk), 2) AS revenue_at_risk
FROM customer_churn
WHERE risk_band = 'High Risk'
GROUP BY recommended_action
ORDER BY revenue_at_risk DESC;

-- 14. Are senior citizens more likely to churn? --
SELECT
    senior_citizen,
    COUNT(*) AS customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(100 * AVG(churn_flag), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY senior_citizen;

-- 15. Do customers with partners or dependents churn less? --
SELECT
    partner,
    dependents,
    COUNT(*) AS customers,
    SUM(churn_flag) AS churned_customers,
    ROUND(100 * AVG(churn_flag), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY partner, dependents
ORDER BY churn_rate_pct DESC;