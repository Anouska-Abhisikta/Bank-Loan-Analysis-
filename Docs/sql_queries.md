# Bank Loan Analysis Project - SQL Queries Documentation

## Overview

This document provides detailed information about the SQL queries used in the Bank Loan Analysis project. These queries extract insights from the loan data to support the Power BI dashboard visualizations.

## Analysis Queries

### 1. Key Performance Indicators (KPIs)

#### Total Loan Applications
```sql
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data;
```
This query counts the total number of loan applications in the database.

#### Month-to-Date Loan Applications
```sql
SELECT COUNT(id) AS MTD_Total_Applications 
FROM bank_loan_data 
WHERE strftime('%Y-%m', issue_date) = (
    SELECT strftime('%Y-%m', MAX(issue_date)) FROM bank_loan_data
);
```
This query counts loan applications for the most recent month in the dataset.

#### Total Funded Amount
```sql
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data;
```
This query calculates the total amount of funds disbursed as loans.

#### Month-to-Date Funded Amount
```sql
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data 
WHERE strftime('%Y-%m', issue_date) = (
    SELECT strftime('%Y-%m', MAX(issue_date)) FROM bank_loan_data
);
```
This query calculates the total funded amount for the most recent month.

#### Total Amount Received
```sql
SELECT SUM(total_payment) AS Total_Amount_Received FROM bank_loan_data;
```
This query calculates the total amount received from borrowers.

#### Average Interest Rate
```sql
SELECT AVG(int_rate) * 100 AS Avg_Interest_Rate FROM bank_loan_data;
```
This query calculates the average interest rate across all loans.

#### Average Debt-to-Income Ratio
```sql
SELECT AVG(dti) * 100 AS Avg_DTI FROM bank_loan_data;
```
This query calculates the average debt-to-income ratio across all loans.

### 2. Loan Status Analysis

#### Loan Status Distribution
```sql
SELECT 
    loan_status, 
    COUNT(id) AS Total_Loans,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate,
    AVG(dti) * 100 AS Avg_DTI
FROM bank_loan_data
GROUP BY loan_status;
```
This query provides a breakdown of loans by status with key metrics for each status.

#### Good Loan Percentage
```sql
SELECT 
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
    COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data;
```
This query calculates the percentage of loans that are either fully paid or current.

#### Bad Loan Percentage
```sql
SELECT 
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
    COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data;
```
This query calculates the percentage of loans that have been charged off.

### 3. Monthly Trends Analysis

```sql
SELECT 
    strftime('%Y-%m', issue_date) AS Month,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data
GROUP BY strftime('%Y-%m', issue_date)
ORDER BY Month;
```
This query analyzes monthly trends in loan applications, funded amounts, and other metrics.

### 4. Regional Analysis

```sql
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
```
This query provides a state-by-state breakdown of loan metrics and default rates.

### 5. Loan Term Analysis

```sql
SELECT 
    term,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data
GROUP BY term
ORDER BY term;
```
This query analyzes loans by term length.

### 6. Purpose Analysis

```sql
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
```
This query breaks down loans by purpose with associated metrics.

### 7. Home Ownership Analysis

```sql
SELECT 
    home_ownership,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY Total_Applications DESC;
```
This query analyzes loans by home ownership status.

### 8. Grade Analysis

```sql
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
```
This query analyzes loans by grade with associated metrics.

### 9. Employment Length Analysis

```sql
SELECT 
    emp_length,
    COUNT(id) AS Total_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received,
    AVG(int_rate) * 100 AS Avg_Interest_Rate
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length;
```
This query analyzes loans by borrower employment length.

### 10. Income Range Analysis

```sql
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
```
This query segments loans by borrower income range and calculates metrics for each segment.

## Data Export Queries

The following queries are used to export data for the Power BI dashboard:

```sql
-- Export KPI data
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

-- Export Loan Status data
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

-- Additional export queries for other dimensions...
```

These queries export the analysis results to CSV files that can be imported into Power BI.

## Query Optimization

The following techniques were used to optimize query performance:

1. **Indexes**: Created indexes on frequently queried columns (loan_status, issue_date, address_state, purpose, grade)
2. **Efficient Aggregations**: Used appropriate aggregate functions (COUNT, SUM, AVG) for calculations
3. **Proper Filtering**: Applied WHERE clauses before GROUP BY to reduce the amount of data processed
4. **Optimized Date Handling**: Used strftime() for consistent date formatting and comparison
5. **Case Statements**: Used CASE statements for complex categorization instead of multiple queries

## Query Dependencies

Many of the analysis queries depend on:
- Proper data types in the bank_loan_data table
- Correct date formatting in the issue_date field
- Valid values in categorical fields (loan_status, grade, purpose, etc.)

## Future Query Enhancements

Potential enhancements to the queries could include:
- Time series forecasting for loan applications and funding
- More advanced risk analysis based on multiple factors
- Cohort analysis to track loan performance over time
- Segmentation analysis to identify high-value customer profiles
