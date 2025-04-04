# Bank Loan Analysis Project - 

## Project Overview

This project provides a comprehensive analysis of bank loan data using SQL and Power BI. It demonstrates skills in database design, SQL query development, data analysis, and dashboard creation in the finance/banking sector.

## Project Structure

```
finance_dashboard_project/
├── data/                      # Data files
│   ├── financial_loan.csv     # Original dataset
│   ├── bank_loan.db           # SQLite database
│   ├── kpi_summary.csv        # Exported analysis results
│   ├── loan_status.csv
│   ├── monthly_trends.csv
│   └── ...                    # Other analysis exports
├── sql/                       # SQL files
│   ├── create_schema.sql      # Database schema creation
│   ├── import_data_fixed.sql  # Data import script
│   ├── analysis_queries.sql   # Analysis queries
│   └── export_data.sql        # Data export queries
├── powerbi/                   # Power BI files
│   ├── dashboard_design.txt   # Dashboard design documentation
│   ├── dashboard_implementation.md  # Implementation guide
│   └── dashboard_mockups.txt  # Visual mockups
└── docs/                      # Documentation
    ├── database_schema.md     # Database schema documentation
    ├── sql_queries.md         # SQL queries documentation
    └── dashboard_user_guide.md # Dashboard user guide
```

## Features

- **Data Analysis**: Comprehensive analysis of bank loan data including loan status, purpose, grade, geographical distribution, and more
- **SQL Development**: Well-structured SQL queries for data extraction and analysis
- **Power BI Dashboard**: Three-page dashboard with Summary, Loan Analysis, and Regional Analysis views
- **Documentation**: Detailed documentation of database schema, SQL queries, and dashboard usage

## Key Insights

The analysis provides insights into:

1. **Loan Performance**: Distribution of loans by status (Fully Paid, Current, Charged Off)
2. **Risk Factors**: Correlation between loan grade, income, employment length and default rates
3. **Geographical Patterns**: State-by-state analysis of loan applications and performance
4. **Loan Characteristics**: Analysis by purpose, term length, and home ownership status
5. **Temporal Trends**: Monthly trends in loan applications and funding

## Technical Implementation

### Database

- **Platform**: SQLite
- **Schema**: Single table design with appropriate indexes
- **Data Import**: Two-step process with temporary table for type conversion

### SQL Analysis

- **KPI Calculations**: Total applications, funded amount, amount received, interest rates
- **Segmentation**: Analysis by loan status, purpose, grade, state, and other dimensions
- **Export**: CSV exports for Power BI consumption

### Power BI Dashboard

- **Structure**: Three-page dashboard with different focus areas
- **Visualizations**: Cards, charts, maps, and tables for comprehensive analysis
- **Interactivity**: Slicers, filters, and drill-through capabilities

## Skills Demonstrated

- **SQL**: Database design, query optimization, data aggregation, complex filtering
- **Power BI**: Dashboard design, data visualization, interactive features
- **Data Analysis**: Financial metrics, risk assessment, geographical analysis
- **Documentation**: Technical documentation, user guides

## How to Use

1. **Database Setup**:
   - Use the SQL scripts in the `sql/` directory to create and populate the database

2. **Power BI Dashboard**:
   - Follow the implementation guide in `powerbi/dashboard_implementation.md`
   - Use the CSV files in the `data/` directory as data sources

3. **Documentation**:
   - Refer to the documentation in the `docs/` directory for detailed information

## Future Enhancements

Potential enhancements to this project could include:

1. **Predictive Analytics**: Machine learning models to predict loan defaults
2. **Real-time Dashboard**: Connection to live data sources
3. **Additional Dimensions**: More detailed analysis by additional factors
4. **Benchmarking**: Comparison with industry benchmarks or historical data

## Conclusion

This Bank Loan Analysis project demonstrates the ability to work with financial data, perform SQL analysis, and create insightful Power BI dashboards. It showcases skills that are directly applicable to financial analysis roles in the banking sector.
