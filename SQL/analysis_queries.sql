-- Bank Loan Analysis SQL Queries
-- These queries analyze various aspects of bank loans to provide valuable insights for decision-making

-- 1. Key Performance Indicators (KPIs)

-- Total Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data;

-- Total Loan Applications - Month to Date (assuming current month is the latest in the dataset)
SELECT COUNT(id) AS MTD_Total_Applications 
FROM bank_loan_data 
WHERE strftime('%Y-%m', issue_date) = (
    SELECT strftime('%Y-%m', MAX(issue_date)) FROM bank_loan_data
);

-- Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data;

-- Total Funded Amount - Month to Date
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data 
WHERE strftime('%Y-%m', issue_date) = (
    SELECT strftime('%Y-%m', MAX(issue_date)) FROM bank_loan_data
);

-- Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Received FROM bank_loan_data;

-- Total Amount Received - Month to Date
SELECT SUM(total_payment) AS MTD_Total_Amount_Received 
FROM bank_loan_data 
WHERE strftime('%Y-%m', issue_date) = (
    SELECT strftime('%Y-%m', MAX(issue_date)) FROM bank_loan_data
);

-- Average Interest Rate
SELECT AVG(int_rate) * 100 AS Avg_Interest_Rate FROM bank_loan_data;

-- Average Interest Rate - Month to Date
SELECT AVG(int_rate) * 100 AS MTD_Avg_Interest_Rate 
FROM bank_loan_data 
WHERE strftime('%Y-%m', issue_date) = (
    SELECT strftime('%Y-%m', MAX(issue_date)) FROM bank_loan_data
);

-- Average Debt-to-Income Ratio (DTI)
SELECT AVG(dti) * 100 AS Avg_DTI FROM bank_loan_data;

-- Average DTI - Month to Date
SELECT AVG(dti) * 100 AS MTD_Avg_DTI 
FROM bank_loan_data 
WHERE strftime('%Y-%m', issue_date) = (
    SELECT strftime('%Y-%m', MAX(issue_date)) FROM bank_loan_data
);

-- 2. Loan Status Analysis

-- Loan Status Distribution
SELECT 
    loan_status, 
    COUNT(id) AS Total_Loans,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate,
    AVG(dti) * 100 AS Avg_DTI
FROM bank_loan_data
GROUP BY loan_status;

-- Good Loan Percentage (Fully Paid or Current)
SELECT 
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
    COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;

-- Bad Loan Percentage (Charged Off)
SELECT 
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
    COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;

-- 3. Monthly Trends

-- Monthly Loan Applications and Amounts
SELECT 
    strftime('%Y-%m', issue_date) AS Month,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data
GROUP BY strftime('%Y-%m', issue_date)
ORDER BY Month;

-- 4. Regional Analysis

-- State-wise Loan Distribution
SELECT 
    address_state AS State,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate,
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
    COUNT(id) AS Default_Rate
FROM bank_loan_data
GROUP BY address_state
ORDER BY Total_Applications DESC;

-- 5. Loan Term Analysis

-- Loan Term Distribution
SELECT 
    term,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data
GROUP BY term
ORDER BY term;

-- 6. Purpose Analysis

-- Loan Purpose Distribution
SELECT 
    purpose,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate,
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
    COUNT(id) AS Default_Rate
FROM bank_loan_data
GROUP BY purpose
ORDER BY Total_Applications DESC;

-- 7. Home Ownership Analysis

-- Home Ownership Distribution
SELECT 
    home_ownership,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY Total_Applications DESC;

-- 8. Grade Analysis

-- Grade Distribution
SELECT 
    grade,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate,
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
    COUNT(id) AS Default_Rate
FROM bank_loan_data
GROUP BY grade
ORDER BY grade;

-- 9. Employment Length Analysis

-- Employment Length Distribution
SELECT 
    emp_length,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

-- 10. Income Range Analysis

-- Income Range Distribution
SELECT 
    CASE
        WHEN annual_income < 30000 THEN 'Less than 30K'
        WHEN annual_income BETWEEN 30000 AND 50000 THEN '30K-50K'
        WHEN annual_income BETWEEN 50001 AND 70000 THEN '50K-70K'
        WHEN annual_income BETWEEN 70001 AND 100000 THEN '70K-100K'
        WHEN annual_income BETWEEN 100001 AND 150000 THEN '100K-150K'
        ELSE 'More than 150K'
    END AS Income_Range,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    AVG(int_rate) * 100 AS Avg_Interest_Rate,
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
    COUNT(id) AS Default_Rate
FROM bank_loan_data
GROUP BY Income_Range
ORDER BY 
    CASE Income_Range
        WHEN 'Less than 30K' THEN 1
        WHEN '30K-50K' THEN 2
        WHEN '50K-70K' THEN 3
        WHEN '70K-100K' THEN 4
        WHEN '100K-150K' THEN 5
        ELSE 6
    END;
