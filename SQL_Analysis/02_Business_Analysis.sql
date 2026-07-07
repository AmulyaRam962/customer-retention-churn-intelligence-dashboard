#OVERALL CHURN RATE
SELECT COUNT(*) AS total_customers, 
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers, 
ROUND( (SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2 ) AS churn_rate 
FROM customers;


#CHURN BY CONTACT 
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        (SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 
        2
    ) AS churn_rate
FROM customers
GROUP BY Contract
ORDER BY churn_rate DESC;

#CHURN BY TENURE GROUP
SELECT 
  CASE 
    WHEN tenure <= 12 THEN 'New Customers'
    WHEN tenure <= 24 THEN 'Early Users'
    WHEN tenure <= 48 THEN 'Mid-Term Customers'
    ELSE 'Loyal Customers'
  END AS tenure_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
    2
  ) AS churn_rate
FROM customers
GROUP BY tenure_group
ORDER BY churn_rate DESC;

#Churn by Payment Method
SELECT 
  PaymentMethod,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
    2
  ) AS churn_rate
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

#Churn by Tech Support
SELECT 
  TechSupport,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
    2
  ) AS churn_rate
FROM customers
GROUP BY TechSupport
ORDER BY churn_rate DESC;


#Churn by Internet Service
SELECT 
  InternetService,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
    2
  ) AS churn_rate
FROM customers
GROUP BY InternetService
ORDER BY churn_rate DESC;

# High risk customer segment
SELECT COUNT(*) AS high_risk_customers
FROM customers
WHERE Contract = 'Month-to-month'
  AND tenure <= 12
  AND PaymentMethod = 'Electronic check'
  AND TechSupport = 'No'
  AND Churn = 'Yes';

 # Revenue lost to churn
  SELECT 
  ROUND(SUM(MonthlyCharges), 2) AS monthly_revenue_lost,
  ROUND(AVG(MonthlyCharges), 2) AS avg_charges_churned
FROM customers
WHERE Churn = 'Yes';

