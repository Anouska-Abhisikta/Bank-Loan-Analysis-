-- Export queries for Power BI dashboard
-- These queries will be used to create CSV files for Power BI import

-- 1. Export KPI data
.headers on
.mode csv
.output /home/ubuntu/finance_dashboard_project/data/kpi_summary.csv
SELECT 
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate,
    AVG(dti) * 100 AS Avg_DTI
FROM bank_loan_data;

-- 2. Export Loan Status data
.headers on
.mode csv
.output /home/ubuntu/finance_dashboard_project/data/loan_status.csv
SELECT 
    loan_status, 
    COUNT(id) AS Total_Loans,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate,
    AVG(dti) * 100 AS Avg_DTI
FROM bank_loan_data
GROUP BY loan_status;

-- 3. Export Monthly Trends data
.headers on
.mode csv
.output /home/ubuntu/finance_dashboard_project/data/monthly_trends.csv
SELECT 
    strftime('%Y-%m', issue_date) AS Month,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data
GROUP BY strftime('%Y-%m', issue_date)
ORDER BY Month;

-- 4. Export Regional Analysis data
.headers on
.mode csv
.output /home/ubuntu/finance_dashboard_project/data/regional_analysis.csv
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

-- 5. Export Loan Term data
.headers on
.mode csv
.output /home/ubuntu/finance_dashboard_project/data/loan_term.csv
SELECT 
    term,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data
GROUP BY term
ORDER BY term;

-- 6. Export Purpose Analysis data
.headers on
.mode csv
.output /home/ubuntu/finance_dashboard_project/data/purpose_analysis.csv
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

-- 7. Export Home Ownership data
.headers on
.mode csv
.output /home/ubuntu/finance_dashboard_project/data/home_ownership.csv
SELECT 
    home_ownership,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY Total_Applications DESC;

-- 8. Export Grade Analysis data
.headers on
.mode csv
.output /home/ubuntu/finance_dashboard_project/data/grade_analysis.csv
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

-- 9. Export Employment Length data
.headers on
.mode csv
.output /home/ubuntu/finance_dashboard_project/data/employment_length.csv
SELECT 
    emp_length,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;

-- 10. Export Income Range data
.headers on
.mode csv
.output /home/ubuntu/finance_dashboard_project/data/income_range.csv
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
