# Car-sales-Analysis-Bright-Motors-Car Data Sales Analysis
📌 Project Overview
This project analyzes vehicle sales data stored in Snowflake (CAR_DATA_SALES.PUBLIC.VEHICLE_SALES00). The goal is to transform raw sales records into actionable insights such as total revenue, profit margins, and aggregated views by make, model, year, and state. Outputs are designed for executive dashboards, reporting, and business intelligence tools like Power BI or Looker Studio.

📂 Dataset
Table: CAR_DATA_SALES.PUBLIC.VEHICLE_SALES00

Key Columns
make – Vehicle manufacturer

model – Vehicle model

year – Manufacturing year

state – Sales region/state

sellingprice_num – Selling price of the vehicle

mmr_num – Cost price (Manheim Market Report value)

units_sold – Number of units sold

🔄 Data Transformations
Add Calculated Columns

TOTAL_REVENUE = sellingprice_num × units_sold

PROFIT_MARGIN = ((sellingprice_num - mmr_num) ÷ sellingprice_num) × 100

Populate Metrics

SQL UPDATE statements calculate and store values for each row.

Aggregations

Grouped by:

Make & Model

Year

State

Combined (Make, Model, Year, State)

Outputs

SUM(total_revenue) → total revenue

AVG(profit_margin) → average margin

COUNT(*) → units sold

📊 Example Query
sql
SELECT make,
       model,
       year,
       state,
       SUM(total_revenue) AS total_revenue,
       AVG(profit_margin) AS avg_margin,
       COUNT(*) AS units_sold
FROM "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00"
GROUP BY GROUPING SETS (
    (make, model),
    (year),
    (state),
    (make, model, year, state)
)
ORDER BY total_revenue DESC;
🚀 Usage
Snowflake: Run SQL scripts to transform and aggregate sales data.

Power BI / Looker Studio: Connect directly to Snowflake or export results for visualization.

Excel: Export query results as CSV for pivot tables and slicers.

🎯 Business Value
This analysis enables:

Identifying top-performing makes and models.

Tracking sales trends by year.

Comparing regional performance by state.

Evaluating profit margins to optimize pricing strategies.

Providing executives with interactive dashboards for decision-making.

📌 Next Steps
Add filters/slicers for year, state, and make/model in BI tools.

Visualize revenue trends (line chart), regional sales (map), and profit margins (bar chart).

Extend analysis to include fuel type, dealer performance, and seasonal trends.
