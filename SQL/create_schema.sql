-- Create bank loan database schema
CREATE TABLE IF NOT EXISTS bank_loan_data (
    id INTEGER PRIMARY KEY,
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
    member_id INTEGER,
    purpose TEXT,
    sub_grade TEXT,
    term TEXT,
    verification_status TEXT,
    annual_income REAL,
    dti REAL,
    installment REAL,
    int_rate REAL,
    loan_amount REAL,
    total_acc INTEGER,
    total_payment REAL
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_loan_status ON bank_loan_data(loan_status);
CREATE INDEX IF NOT EXISTS idx_issue_date ON bank_loan_data(issue_date);
CREATE INDEX IF NOT EXISTS idx_address_state ON bank_loan_data(address_state);
CREATE INDEX IF NOT EXISTS idx_purpose ON bank_loan_data(purpose);
CREATE INDEX IF NOT EXISTS idx_grade ON bank_loan_data(grade);
