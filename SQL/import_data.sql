-- Import data from CSV file
.mode csv
.import /home/ubuntu/finance_dashboard_project/data/financial_loan.csv bank_loan_data
-- Skip the header row
DELETE FROM bank_loan_data WHERE id = 'id';

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
