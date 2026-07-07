INSERT INTO dim_contract (contract_type, payment_method, paperless_billing)
SELECT DISTINCT Contract, PaymentMethod, PaperlessBilling
FROM customers;
 
#STEP 5: POPULATE dim_services 
INSERT INTO dim_services (internet_service, tech_support, online_security)
SELECT DISTINCT InternetService, TechSupport, OnlineSecurity
FROM customers;

#STEP 6: POPULATE fact_churn 
INSERT INTO fact_churn (customerID, contract_key, service_key, tenure, monthly_charges, total_charges, churn)
SELECT 
    c.customerID,
    dc.contract_key,
    ds.service_key,
    c.tenure,
    c.MonthlyCharges,
    c.TotalCharges,
    c.Churn
FROM customers c
JOIN dim_contract dc 
    ON c.Contract = dc.contract_type
    AND c.PaymentMethod = dc.payment_method
    AND c.PaperlessBilling = dc.paperless_billing
JOIN dim_services ds 
    ON c.InternetService = ds.internet_service
    AND c.TechSupport = ds.tech_support
    AND c.OnlineSecurity = ds.online_security;

VERIFY ROW COUNTS
-- fact_churn should show 7043
SELECT 'customers (original)' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'fact_churn',   COUNT(*) FROM fact_churn
UNION ALL
SELECT 'dim_contract', COUNT(*) FROM dim_contract
UNION ALL
SELECT 'dim_services', COUNT(*) FROM dim_services;
TRUNCATE TABLE fact_churn;
TRUNCATE TABLE dim_contract;
TRUNCATE TABLE dim_services;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM dim_contract;
DELETE FROM dim_services;
SET SQL_SAFE_UPDATES = 1;
SELECT * FROM fact_churn LIMIT 10;
