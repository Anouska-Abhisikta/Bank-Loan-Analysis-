# Power BI Dashboard Implementation Guide

This document provides step-by-step instructions for implementing the Bank Loan Analysis dashboard in Power BI Desktop.

## Prerequisites
- Power BI Desktop installed
- CSV files exported from the SQL database

## Implementation Steps

### 1. Data Import

1. Open Power BI Desktop
2. Click on "Get Data" > "Text/CSV"
3. Navigate to the exported CSV files and import each one:
   - kpi_summary.csv
   - loan_status.csv
   - monthly_trends.csv
   - regional_analysis.csv
   - loan_term.csv
   - purpose_analysis.csv
   - home_ownership.csv
   - grade_analysis.csv
   - employment_length.csv
   - income_range.csv
4. For each dataset, ensure proper data types are set:
   - Format date fields as dates
   - Format currency fields with appropriate currency symbol
   - Format percentage fields as percentages

### 2. Data Model

1. Create relationships between tables where applicable:
   - Most tables will be independent as they are pre-aggregated
   - If using the raw data, create relationships based on common fields (id, loan_status, etc.)

2. Create calculated measures:
   ```
   // Good Loan Percentage
   Good Loan % = 
   DIVIDE(
       CALCULATE(SUM(loan_status[Total_Loans]), loan_status[loan_status] IN {"Fully Paid", "Current"}),
       SUM(loan_status[Total_Loans])
   ) * 100
   
   // Bad Loan Percentage
   Bad Loan % = 
   DIVIDE(
       CALCULATE(SUM(loan_status[Total_Loans]), loan_status[loan_status] = "Charged Off"),
       SUM(loan_status[Total_Loans])
   ) * 100
   
   // Recovery Rate
   Recovery Rate = 
   DIVIDE(
       SUM(loan_status[Total_Amount_Received]),
       SUM(loan_status[Total_Funded_Amount])
   ) * 100
   ```

### 3. Summary Dashboard

1. Create a new page named "Summary"
2. Add KPI cards:
   - Total Loan Applications (from kpi_summary)
   - Total Funded Amount (from kpi_summary)
   - Total Amount Received (from kpi_summary)
   - Average Interest Rate (from kpi_summary)
   - Average DTI (from kpi_summary)
3. Add Loan Status donut chart:
   - Data: loan_status.csv
   - Values: Total_Loans
   - Legend: loan_status
4. Add Monthly Trends line charts:
   - Data: monthly_trends.csv
   - X-axis: Month
   - Y-axis: Total_Applications for one chart, Total_Funded_Amount for another
5. Add Loan Purpose bar chart:
   - Data: purpose_analysis.csv
   - Y-axis: purpose
   - X-axis: Total_Applications
   - Sort: Descending by Total_Applications

### 4. Loan Analysis Dashboard

1. Create a new page named "Loan Analysis"
2. Add Loan Term column chart:
   - Data: loan_term.csv
   - X-axis: term
   - Y-axis: Total_Applications
3. Add Grade Distribution column chart:
   - Data: grade_analysis.csv
   - X-axis: grade
   - Y-axis: Total_Applications
4. Add Grade Default Rate line chart:
   - Data: grade_analysis.csv
   - X-axis: grade
   - Y-axis: Default_Rate
5. Add Home Ownership treemap:
   - Data: home_ownership.csv
   - Group: home_ownership
   - Values: Total_Applications
6. Add Employment Length bar chart:
   - Data: employment_length.csv
   - Y-axis: emp_length
   - X-axis: Total_Applications
   - Sort: Custom (to maintain chronological order)
7. Add Income Range column chart:
   - Data: income_range.csv
   - X-axis: Income_Range
   - Y-axis: Total_Applications

### 5. Regional Analysis Dashboard

1. Create a new page named "Regional Analysis"
2. Add State map visual:
   - Data: regional_analysis.csv
   - Location: State
   - Bubble size: Total_Applications
   - Color saturation: Default_Rate
3. Add Top 10 States bar chart:
   - Data: regional_analysis.csv
   - Y-axis: State
   - X-axis: Total_Applications
   - Sort: Descending by Total_Applications
   - Top N filter: 10
4. Add State Metrics table:
   - Data: regional_analysis.csv
   - Columns: State, Total_Applications, Total_Funded_Amount, Total_Amount_Received, Avg_Interest_Rate, Default_Rate
   - Sort: Descending by Total_Applications

### 6. Add Interactivity

1. Add slicers to each page:
   - Loan Status slicer (horizontal, multi-select)
   - Purpose slicer (dropdown, multi-select)
2. Configure cross-filtering:
   - Enable bidirectional cross-filtering between visuals
3. Set up drill-through:
   - From Summary to Loan Analysis
   - From Regional Analysis to state-specific details

### 7. Formatting and Theme

1. Apply consistent formatting:
   - Title: Segoe UI, 18pt, Bold
   - Subtitle: Segoe UI, 14pt, Semibold
   - Body: Segoe UI, 10pt, Regular
2. Apply color scheme:
   - Primary: #0078D4 (Blue)
   - Secondary: #107C10 (Green)
   - Accent: #D83B01 (Orange)
   - Neutral: #505050 (Dark Gray)
3. Add titles, labels, and legends to all visuals
4. Add page navigation buttons

### 8. Publish and Share

1. Save the Power BI file (.pbix)
2. If using Power BI Service:
   - Publish to Power BI Service
   - Create a dashboard
   - Share with stakeholders
   - Set up scheduled refresh if needed

## Final Checks

- Ensure all visuals display correctly
- Test all filters and interactions
- Verify data accuracy
- Check for consistent formatting
- Test on different screen sizes
