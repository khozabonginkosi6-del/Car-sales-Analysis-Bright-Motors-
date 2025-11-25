---# Show all columns and data in the table
SELECT *
FROM "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00";

---# Describe the table structure (lists all columns, types, etc.)
DESC TABLE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00";

---# Add new columns to store calculated metrics
ALTER TABLE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00" ADD COLUMN TOTAL_REVENUE NUMBER;
ALTER TABLE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00" ADD COLUMN PROFIT_MARGIN NUMBER;

---# Populate the new columns with calculated values
---TOTAL_REVENUE = Selling Price × Units Sold
---PROFIT_MARGIN = (Selling Price - Cost Price) ÷ Selling Price × 100
UPDATE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00"
SET TOTAL_REVENUE = sellingprice_num * COALESCE(units_sold, 1),
    PROFIT_MARGIN = IFF(sellingprice_num > 0,
                            ((sellingprice_num - mmr_num) / sellingprice_num) * 100,
                            NULL);


-- revenue by make/model
-- revenue by year
-- revenue by state
-- combined grouping

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
