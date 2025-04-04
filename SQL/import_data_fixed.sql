-- Modified import approach to handle data type issues
.mode csv
.headers on
.separator ,

-- First create a temporary table with all text columns to safely import the data
CREATE TABLE IF NOT EXISTS temp_bank_loan_data (
    id TEXT,
    address_state TEXT,
    application_type TEXT,
    emp_length TEXT,
    emp_title TEXT,
    grade TEXT,
    home_ownership TEXT,
    issue_date TEXT,
    last_credit_pull_date TEXT,
    last_payment_date TEXT,
    loan_status TEXT,
    next_payment_date TEXT,
    member_id TEXT,
    purpose TEXT,
    sub_grade TEXT,
    term TEXT,
    verification_status TEXT,
    annual_income TEXT,
    dti TEXT,
    installment TEXT,
    int_rate TEXT,
    loan_amount TEXT,
    total_acc TEXT,
    total_payment TEXT
);

-- Import data into the temporary table
.import '/home/ubuntu/finance_dashboard_project/data/financial_loan.csv' temp_bank_loan_data

-- Remove header row
DELETE FROM temp_bank_loan_data WHERE id = 'id';

-- Now insert data from temporary table to the main table with proper type conversion
INSERT INTO bank_loan_data
SELECT 
    CAST(id AS INTEGER),
    address_state,
    application_type,
    emp_length,
    emp_title,
    grade,
    home_ownership,
    issue_date,
    last_credit_pull_date,
    last_payment_date,
    loan_status,
    next_payment_date,
    CAST(member_id AS INTEGER),
    purpose,
    sub_grade,
    term,
    verification_status,
    CAST(annual_income AS REAL),
    CAST(dti AS REAL),
    CAST(installment AS REAL),
    CAST(int_rate AS REAL),
    CAST(loan_amount AS REAL),
    CAST(total_acc AS INTEGER),
    CAST(total_payment AS REAL)
FROM temp_bank_loan_data;

-- Convert text date fields to proper date format for better analysis
UPDATE bank_loan_data
SET issue_date = substr(issue_date, 7, 4) || '-' || 
    CASE 
        WHEN substr(issue_date, 4, 2) = '01' THEN '01'
        WHEN substr(issue_date, 4, 2) = '02' THEN '02'
        WHEN substr(issue_date, 4, 2) = '03' THEN '03'
        WHEN substr(issue_date, 4, 2) = '04' THEN '04'
        WHEN substr(issue_date, 4, 2) = '05' THEN '05'
        WHEN substr(issue_date, 4, 2) = '06' THEN '06'
        WHEN substr(issue_date, 4, 2) = '07' THEN '07'
        WHEN substr(issue_date, 4, 2) = '08' THEN '08'
        WHEN substr(issue_date, 4, 2) = '09' THEN '09'
        WHEN substr(issue_date, 4, 2) = '10' THEN '10'
        WHEN substr(issue_date, 4, 2) = '11' THEN '11'
        WHEN substr(issue_date, 4, 2) = '12' THEN '12'
    END || '-' || 
    substr(issue_date, 1, 2);

-- Drop the temporary table
DROP TABLE temp_bank_loan_data;
