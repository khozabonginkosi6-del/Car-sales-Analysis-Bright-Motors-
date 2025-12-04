# 🚗 Car Sales Analysis — Bright Motors

## 📌 Summary of the Case Study
This case study analyzed vehicle sales data stored in **Snowflake** (`CAR_DATA_SALES.PUBLIC.VEHICLE_SALES00`). The objective was to transform raw sales records into **actionable insights** such as total revenue, profit margins, and aggregated views by **make, model, year, and state**. The outputs were designed to support **executive dashboards, reporting, and business intelligence tools** like Power BI and Looker Studio.

---

## 🔍 How the Case Study Was Done
1. **Dataset Exploration**
   - Table: `CAR_DATA_SALES.PUBLIC.VEHICLE_SALES00`
   - Key columns: `make`, `model`, `year`, `state`, `sellingprice_num`, `mmr_num`, `units_sold`.

2. **Data Transformations**
   - Added calculated columns:
     - `TOTAL_REVENUE = sellingprice_num × units_sold`
     - `PROFIT_MARGIN = ((sellingprice_num - mmr_num) ÷ sellingprice_num) × 100`
   - Populated metrics using SQL `UPDATE` statements.

3. **Aggregations**
   - Grouped data by:
     - Make & Model
     - Year
     - State
     - Combined (Make, Model, Year, State)
   - Outputs included:
     - `SUM(total_revenue)` → total revenue
     - `AVG(profit_margin)` → average margin
     - `COUNT(*)` → units sold

4. **SQL Query Example**
   ```sql
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
📊 Insights Found
Identified top-performing makes and models based on revenue and units sold.

Revealed sales trends by year, showing growth and decline patterns.

Compared regional performance by state, highlighting strong and weak markets.

Calculated profit margins, providing visibility into cost vs. selling price dynamics.

🎯 Summary of Findings
By transforming raw vehicle sales data into structured metrics, the project delivered:

Clear visibility into revenue drivers.

Insights into regional and yearly sales performance.

Profitability analysis across different makes and models.

This demonstrates how SQL-based transformations can power business intelligence for decision-making in sales strategy, inventory management, and regional targeting.

🛠️ Tools Used
Snowflake — for data storage and querying

SQL Server / T-SQL — for transformations, aggregations, and metric calculations

Power BI / Looker Studio — for dashboard visualization and storytelling

Excel — for pivot tables, slicers, and ad-hoc analysis

