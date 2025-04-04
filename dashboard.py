import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from dash import Dash, html, dcc, callback, Output, Input
import dash_bootstrap_components as dbc

# Load the data
loan_status = pd.read_csv('data/loan_status.csv')
monthly_trends = pd.read_csv('data/monthly_trends.csv')
regional_analysis = pd.read_csv('data/regional_analysis.csv')
purpose_analysis = pd.read_csv('data/purpose_analysis.csv')
loan_term = pd.read_csv('data/loan_term.csv')
grade_analysis = pd.read_csv('data/grade_analysis.csv')
home_ownership = pd.read_csv('data/home_ownership.csv')
employment_length = pd.read_csv('data/employment_length.csv')
income_range = pd.read_csv('data/income_range.csv')
kpi_summary = pd.read_csv('data/kpi_summary.csv')

# Initialize the Dash app
app = Dash(__name__, external_stylesheets=[dbc.themes.BOOTSTRAP])

# Define colors
colors = {
    'primary': '#0078D4',
    'secondary': '#107C10',
    'accent': '#D83B01',
    'neutral': '#505050',
    'background': '#F5F5F5',
    'text': '#333333'
}

# Create KPI cards
def create_kpi_card(title, value, prefix="", suffix=""):
    return dbc.Card(
        dbc.CardBody([
            html.H6(title, className="card-title", style={'textAlign': 'center', 'color': colors['neutral']}),
            html.H4(f"{prefix}{value}{suffix}", className="card-text", style={'textAlign': 'center', 'color': colors['primary'], 'fontWeight': 'bold'})
        ]),
        className="mb-4",
        style={'boxShadow': '0 4px 8px 0 rgba(0,0,0,0.2)'}
    )

# Create figures
# Loan Status Donut Chart
loan_status_fig = px.pie(
    loan_status, 
    values='Total_Loans', 
    names='loan_status',
    hole=0.5,
    color_discrete_sequence=px.colors.qualitative.Set2
)
loan_status_fig.update_layout(
    title_text='Loan Status Distribution',
    showlegend=True,
    legend=dict(orientation="h", yanchor="bottom", y=-0.3, xanchor="center", x=0.5)
)

# Monthly Trends Line Chart
monthly_trends_fig = px.line(
    monthly_trends, 
    x='Month', 
    y=['Total_Applications', 'Total_Funded_Amount'],
    title='Monthly Trends',
    color_discrete_sequence=[colors['primary'], colors['secondary']]
)
monthly_trends_fig.update_layout(
    xaxis_title='Month',
    yaxis_title='Value',
    legend_title='Metric'
)

# Regional Analysis Map
regional_map_fig = px.choropleth(
    regional_analysis,
    locations='State',
    locationmode='USA-states',
    color='Total_Applications',
    scope='usa',
    color_continuous_scale='Blues',
    title='Loan Applications by State'
)
regional_map_fig.update_layout(
    geo=dict(
        showlakes=True,
        lakecolor='rgb(255, 255, 255)'
    )
)

# Purpose Analysis Bar Chart
purpose_fig = px.bar(
    purpose_analysis.sort_values('Total_Applications', ascending=False).head(10),
    y='purpose',
    x='Total_Applications',
    title='Top 10 Loan Purposes',
    orientation='h',
    color='Total_Applications',
    color_continuous_scale='Viridis'
)
purpose_fig.update_layout(
    yaxis_title='Purpose',
    xaxis_title='Number of Applications'
)

# Loan Term Donut Chart
loan_term_fig = px.pie(
    loan_term,
    values='Total_Applications',
    names='term',
    title='Loan Term Distribution',
    hole=0.5,
    color_discrete_sequence=px.colors.qualitative.Pastel
)

# Grade Analysis Bar Chart
grade_fig = px.bar(
    grade_analysis,
    x='grade',
    y='Total_Applications',
    title='Loan Grade Distribution',
    color='Default_Rate',
    color_continuous_scale='RdYlGn_r'
)
grade_fig.update_layout(
    xaxis_title='Grade',
    yaxis_title='Number of Applications'
)

# Home Ownership Treemap
home_ownership_fig = px.treemap(
    home_ownership,
    path=['home_ownership'],
    values='Total_Applications',
    title='Home Ownership Distribution',
    color='Total_Applications',
    color_continuous_scale='Blues'
)

# Employment Length Bar Chart
emp_length_order = ['< 1 year', '1 year', '2 years', '3 years', '4 years', '5 years', 
                    '6 years', '7 years', '8 years', '9 years', '10+ years']
employment_length['emp_length_order'] = pd.Categorical(
    employment_length['emp_length'], 
    categories=emp_length_order, 
    ordered=True
)
employment_length = employment_length.sort_values('emp_length_order')

emp_length_fig = px.bar(
    employment_length,
    x='emp_length',
    y='Total_Applications',
    title='Employment Length Distribution',
    color='Total_Applications',
    color_continuous_scale='Viridis'
)
emp_length_fig.update_layout(
    xaxis_title='Employment Length',
    yaxis_title='Number of Applications'
)

# Define the app layout with tabs
app.layout = dbc.Container([
    html.H1("Bank Loan Analysis Dashboard", className="mt-4 mb-4", style={'color': colors['primary'], 'textAlign': 'center'}),
    
    dbc.Tabs([
        # Summary Dashboard Tab
        dbc.Tab(label="Summary Dashboard", children=[
            html.Div([
                html.H3("Key Performance Indicators", className="mt-4 mb-3", style={'color': colors['secondary']}),
                dbc.Row([
                    dbc.Col(create_kpi_card("Total Applications", f"{int(kpi_summary['Total_Applications'].iloc[0]):,}"), width=3),
                    dbc.Col(create_kpi_card("Total Funded Amount", f"${int(kpi_summary['Total_Funded_Amount'].iloc[0]):,}"), width=3),
                    dbc.Col(create_kpi_card("Total Amount Received", f"${int(kpi_summary['Total_Amount_Received'].iloc[0]):,}"), width=3),
                    dbc.Col(create_kpi_card("Avg Interest Rate", f"{kpi_summary['Avg_Interest_Rate'].iloc[0]:.2f}", suffix="%"), width=3),
                ]),
                
                dbc.Row([
                    dbc.Col(dcc.Graph(figure=loan_status_fig), width=6),
                    dbc.Col(dcc.Graph(figure=monthly_trends_fig), width=6),
                ], className="mt-4"),
                
                dbc.Row([
                    dbc.Col(dcc.Graph(figure=purpose_fig), width=12),
                ], className="mt-4"),
            ])
        ]),
        
        # Loan Analysis Dashboard Tab
        dbc.Tab(label="Loan Analysis Dashboard", children=[
            html.Div([
                dbc.Row([
                    dbc.Col(dcc.Graph(figure=loan_term_fig), width=6),
                    dbc.Col(dcc.Graph(figure=grade_fig), width=6),
                ], className="mt-4"),
                
                dbc.Row([
                    dbc.Col(dcc.Graph(figure=home_ownership_fig), width=6),
                    dbc.Col(dcc.Graph(figure=emp_length_fig), width=6),
                ], className="mt-4"),
            ])
        ]),
        
        # Regional Analysis Dashboard Tab
        dbc.Tab(label="Regional Analysis Dashboard", children=[
            html.Div([
                dbc.Row([
                    dbc.Col(dcc.Graph(figure=regional_map_fig), width=12),
                ], className="mt-4"),
                
                dbc.Row([
                    dbc.Col(
                        dcc.Graph(
                            figure=px.bar(
                                regional_analysis.sort_values('Total_Applications', ascending=False).head(10),
                                y='State',
                                x='Total_Applications',
                                title='Top 10 States by Loan Applications',
                                orientation='h',
                                color='Default_Rate',
                                color_continuous_scale='RdYlGn_r'
                            )
                        ), 
                        width=12
                    ),
                ], className="mt-4"),
            ])
        ]),
    ]),
    
    html.Footer(
        html.P("Bank Loan Analysis Dashboard - Created with Plotly Dash", 
               style={'textAlign': 'center', 'marginTop': '30px', 'color': colors['neutral']}
        )
    )
], fluid=True, style={'backgroundColor': colors['background'], 'padding': '20px'})

# Run the app
if __name__ == '__main__':
    app.run_server(host='0.0.0.0', port=8050, debug=True)
