CREATE TABLE dim_contract 
(
    contract_key   INT AUTO_INCREMENT PRIMARY KEY,
    contract_type   VARCHAR(30),
    payment_method   VARCHAR(40),
    paperless_billing VARCHAR(5)
);
#STEP 2: CREATING dim_services
 
CREATE TABLE dim_services
 (
    service_key INT AUTO_INCREMENT PRIMARY KEY,
    internet_service VARCHAR(20),
    tech_support VARCHAR(20),
    online_security VARCHAR(20)
);
#CREATING FACT TABLE -> STEP 3: CREATE fact_churn

 
CREATE TABLE fact_churn 
(
    fact_id INT AUTO_INCREMENT PRIMARY KEY,
    customerID VARCHAR(20),        -- business key for drill-through in Power BI
    contract_key INT,
    service_key INT,
    tenure INT,
    monthly_charges DECIMAL(10,2),
    total_charges DECIMAL(10,2),
    churn VARCHAR(5),
    FOREIGN KEY (contract_key) REFERENCES dim_contract(contract_key),
    FOREIGN KEY (service_key)  REFERENCES dim_services(service_key)
);
