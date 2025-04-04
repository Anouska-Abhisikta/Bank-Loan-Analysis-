# Bank Loan Analysis Dashboard - User Guide

## Overview

This user guide provides instructions for using the Bank Loan Analysis Power BI dashboard. The dashboard offers comprehensive insights into bank loan data, helping you analyze loan performance, borrower characteristics, and geographical distribution.

## Dashboard Structure

The dashboard consists of three main pages:

1. **Summary Dashboard** - Key metrics and high-level overview
2. **Loan Analysis Dashboard** - Detailed analysis by various dimensions
3. **Regional Analysis Dashboard** - Geographical distribution and state-level metrics

## Getting Started

### Opening the Dashboard

1. Open Power BI Desktop
2. Click on "File" > "Open" and navigate to the Bank Loan Analysis.pbix file
3. The dashboard will load with all visualizations and data

### Navigating Between Pages

- Use the navigation tabs at the bottom of the screen to switch between dashboard pages
- Each page focuses on different aspects of the loan data analysis

## Summary Dashboard

The Summary Dashboard provides a high-level overview of key loan metrics.

### Key Performance Indicators (KPIs)

At the top of the dashboard, you'll find cards displaying:
- **Total Loan Applications**: The total number of loans in the dataset
- **Total Funded Amount**: The total amount of money disbursed as loans
- **Total Amount Received**: The total amount received from borrowers
- **Average Interest Rate**: The average interest rate across all loans
- **Average DTI**: The average debt-to-income ratio across all loans

### Loan Status Overview

The donut chart shows the distribution of loans by status:
- **Fully Paid**: Loans that have been completely repaid
- **Current**: Loans that are active and in good standing
- **Charged Off**: Loans that have been written off as losses

### Monthly Trends

The line charts display:
- **Monthly Loan Applications**: The number of loans issued each month
- **Monthly Funded Amount**: The total amount funded each month

### Loan Purpose Distribution

The horizontal bar chart shows:
- The distribution of loans by purpose (e.g., car, home, education)
- The number of applications for each purpose

## Loan Analysis Dashboard

The Loan Analysis Dashboard provides detailed breakdowns of loans by various dimensions.

### Loan Term Analysis

The column chart shows:
- The distribution of loans by term length (e.g., 36 months, 60 months)
- The number of applications for each term

### Grade Analysis

The visualizations show:
- **Grade Distribution**: The number of loans in each grade (A through G)
- **Grade Default Rate**: The percentage of loans charged off in each grade

### Home Ownership Analysis

The treemap shows:
- The distribution of loans by home ownership status (e.g., RENT, MORTGAGE, OWN)
- The relative size indicates the number of applications in each category

### Employment Length Analysis

The bar chart shows:
- The distribution of loans by borrower employment length
- The number of applications for each employment length category

### Income Range Analysis

The visualizations show:
- **Income Range Distribution**: The number of loans in each income bracket
- **Income Range Default Rate**: The percentage of loans charged off in each income bracket

## Regional Analysis Dashboard

The Regional Analysis Dashboard focuses on geographical distribution of loans.

### State Loan Distribution

The map visual shows:
- The distribution of loans across different states
- Bubble size indicates the number of applications
- Color saturation indicates the default rate

### Top States

The bar chart shows:
- The top 10 states by number of loan applications
- The total applications for each state

### State Metrics Table

The table provides detailed metrics for each state:
- State name
- Total applications
- Total funded amount
- Total amount received
- Average interest rate
- Default rate

## Using Filters and Interactivity

### Slicers

The dashboard includes several slicers that allow you to filter the data:
- **Loan Status**: Filter by loan status (Fully Paid, Current, Charged Off)
- **Purpose**: Filter by loan purpose
- **Grade**: Filter by loan grade
- **Date Range**: Filter by issue date

To use a slicer:
1. Click on the slicer dropdown
2. Select one or more values to filter the data
3. To clear a filter, click the clear filter icon or select "Select All"

### Cross-Filtering

The dashboard supports cross-filtering between visualizations:
1. Click on any element in a visualization (e.g., a specific loan purpose in the bar chart)
2. All other visualizations on the page will filter to show data related to your selection
3. Click the same element again or click in an empty area to clear the filter

### Drill-Through

Some visualizations support drill-through to more detailed information:
1. Right-click on an element in a visualization
2. Select "Drill through" from the context menu
3. Choose the target page to see more detailed information

## Tips for Effective Analysis

1. **Start with the Summary Dashboard** to get a high-level overview
2. **Use filters** to focus on specific segments of interest
3. **Compare metrics across dimensions** to identify patterns and trends
4. **Look for correlations** between different factors (e.g., grade and default rate)
5. **Export specific views** for further analysis or reporting

## Troubleshooting

### Dashboard Not Loading Properly

1. Ensure you have the latest version of Power BI Desktop installed
2. Check that all data files are in the correct location
3. Refresh the data by clicking "Refresh" in the Home tab

### Filters Not Working as Expected

1. Clear all filters and try again
2. Check if there are any conflicting filters applied
3. Restart Power BI Desktop

## Additional Resources

- For more information about the database schema, refer to the database_schema.md document
- For details about the SQL queries used, refer to the sql_queries.md document
- For technical implementation details, refer to the dashboard_implementation.md document
