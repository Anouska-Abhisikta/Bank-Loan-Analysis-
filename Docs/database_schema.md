# Bank Loan Analysis Project - Database Schema Documentation

## Overview

This document provides detailed information about the database schema used in the Bank Loan Analysis project. The database is implemented in SQLite and contains a single table that stores all loan data.

## Database: bank_loan.db

### Table: bank_loan_data

This table stores all information about bank loans, including loan details, borrower information, and payment status.

#### Columns

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| id | INTEGER | Primary key, unique identifier for each loan |
| address_state | TEXT | State where the borrower resides |
| application_type | TEXT | Type of application (e.g., INDIVIDUAL) |
| emp_length | TEXT | Length of employment (e.g., < 1 year, 5 years) |
| emp_title | TEXT | Job title of the borrower |
| grade | TEXT | Loan grade (A through G) indicating quality |
| home_ownership | TEXT | Home ownership status (e.g., RENT, MORTGAGE, OWN) |
| issue_date | TEXT | Date when the loan was issued (YYYY-MM-DD) |
| last_credit_pull_date | TEXT | Date of the last credit pull |
| last_payment_date | TEXT | Date of the last payment received |
| loan_status | TEXT | Current status of the loan (e.g., Fully Paid, Charged Off) |
| next_payment_date | TEXT | Date when the next payment is due |
| member_id | INTEGER | Unique identifier for the borrower |
| purpose | TEXT | Purpose of the loan (e.g., car, home, education) |
| sub_grade | TEXT | Loan sub-grade (e.g., A1, B2) for more granular classification |
| term | TEXT | Loan term period (e.g., 36 months, 60 months) |
| verification_status | TEXT | Status of income/employment verification |
| annual_income | REAL | Annual income of the borrower |
| dti | REAL | Debt-to-Income ratio |
| installment | REAL | Monthly payment amount |
| int_rate | REAL | Interest rate of the loan (decimal format) |
| loan_amount | REAL | Total amount of the loan |
| total_acc | INTEGER | Total number of credit accounts |
| total_payment | REAL | Total amount paid by the borrower |

#### Indexes

The following indexes have been created to improve query performance:

| Index Name | Columns | Purpose |
|------------|---------|---------|
| idx_loan_status | loan_status | Optimize filtering and grouping by loan status |
| idx_issue_date | issue_date | Optimize date-based queries and time series analysis |
| idx_address_state | address_state | Optimize geographical analysis |
| idx_purpose | purpose | Optimize filtering and grouping by loan purpose |
| idx_grade | grade | Optimize filtering and grouping by loan grade |

## Data Relationships

While this database uses a single table design, there are several logical relationships within the data:

- Loans are associated with borrowers through the member_id field
- Loans are classified by grade and sub_grade
- Loans are categorized by purpose and term
- Geographical distribution is tracked through address_state

## Data Types and Constraints

- Numeric fields (annual_income, loan_amount, etc.) use REAL data type to support decimal values
- Date fields are stored as TEXT in YYYY-MM-DD format for compatibility
- The id field is the primary key with a UNIQUE constraint
- No foreign key constraints are implemented as this is a single-table design

## Data Import Process

The data is imported from a CSV file using a two-step process:

1. Data is first loaded into a temporary table with all TEXT columns
2. Data is then inserted into the main table with appropriate type conversions
3. Date fields are reformatted for better analysis

This approach ensures proper handling of data type conversions and prevents import errors.

## Schema Evolution

The current schema is designed for the specific bank loan dataset used in this project. If additional data sources or fields are added in the future, the schema may need to be extended with:

- Additional columns for new data points
- Additional tables for more complex relationships
- Additional indexes for new query patterns

## Schema Diagram

```
+-------------------+
| bank_loan_data    |
+-------------------+
| id (PK)           |
| address_state     |
| application_type  |
| emp_length        |
| emp_title         |
| grade             |
| home_ownership    |
| issue_date        |
| last_credit_pull_date |
| last_payment_date |
| loan_status       |
| next_payment_date |
| member_id         |
| purpose           |
| sub_grade         |
| term              |
| verification_status |
| annual_income     |
| dti               |
| installment       |
| int_rate          |
| loan_amount       |
| total_acc         |
| total_payment     |
+-------------------+
```
