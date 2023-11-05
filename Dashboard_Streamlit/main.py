import streamlit as st
import pandas as pd
import plotly.express as px


st.set_page_config(
    page_title="Sales Data Dashboard",
    layout="wide",
    initial_sidebar_state="expanded"
)

#with open('Update style.css') as f:
#    st.markdown(f'<style>{f.read()}</style>', unsafe_allow_html=True)

st.markdown(
    f"""
    <style>
    .reportview-container {{
        background: #00008B;
    }}
    </style>
    """,
    unsafe_allow_html=True
)

df = pd.read_excel("Data.xlsx")

# Convert 'Order Date' column
df['Order Date'] = pd.to_datetime(df['Order Date'], format='%m/%d/%Y')

st.sidebar.title('Select the date range and data that interest you')
date_range = st.sidebar.date_input('Select Date Range', (df['Order Date'].min(), df['Order Date'].max()))

st.title('Sales Data Dashboard')


st.markdown(
    f"""
    <style>
    .reportview-container {{
        background: #f4f4f4;
    }}
    </style>
    """,
    unsafe_allow_html=True
)

# Filters on the sidebar
st.sidebar.title('Filters')
selected_segment = st.sidebar.multiselect('Select Segment', df['Segment'].unique())
selected_region = st.sidebar.multiselect('Select Region', df['Region'].unique())
selected_category = st.sidebar.multiselect('Select Category', df['Category'].unique())

# Apply filters
filtered_data = df[
    (df['Segment'].isin(selected_segment)) &
    (df['Region'].isin(selected_region)) &
    (df['Category'].isin(selected_category))
]

# Display filtered data
st.subheader('Filtered Data')
st.dataframe(filtered_data)

# Visualizations
st.subheader('Sales Data Visualizations')

# Sales vs. Profit
fig = px.scatter(filtered_data, x='Sales', y='Profit', color='Category', hover_data=['Product Name'])
fig.update_traces(marker=dict(size=8, line=dict(width=1, color='DarkSlateGrey')))
fig.update_layout(plot_bgcolor='white')
st.plotly_chart(fig, use_container_width=True)

# Total Sales by Ship Mode
sales_by_ship_mode = filtered_data.groupby('Ship Mode')['Sales'].sum().reset_index()
fig2 = px.bar(sales_by_ship_mode, x='Ship Mode', y='Sales', color='Ship Mode', labels={'Sales': 'Total Sales'})
fig2.update_traces(marker_line_color='black', marker_line_width=1.5, opacity=0.8)
fig2.update_layout(plot_bgcolor='white')
st.plotly_chart(fig2, use_container_width=True)

# Total Profit by Category
total_profit_by_category = filtered_data.groupby('Category')['Profit'].sum().reset_index()
fig3 = px.bar(total_profit_by_category, x='Category', y='Profit', color='Category', labels={'Profit': 'Total Profit'})
fig3.update_traces(marker_line_color='black', marker_line_width=1.5, opacity=0.8)
fig3.update_layout(plot_bgcolor='white')
st.plotly_chart(fig3, use_container_width=True)


st.markdown('---')
st.markdown('This is a sample dashboard. The data that is used in the project does not belong to any real people.')
