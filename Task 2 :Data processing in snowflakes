-- Set context
USE DATABASE CAR_DATA_SALES;
USE SCHEMA PUBLIC;

---#1. Add new columns for numeric prices and derived metrics

ALTER TABLE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00" ADD COLUMN sellingprice_num NUMBER;
ALTER TABLE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00" ADD COLUMN mmr_num NUMBER;
ALTER TABLE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00" ADD COLUMN total_revenue NUMBER;
ALTER TABLE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00" ADD COLUMN profit_margin NUMBER;
ALTER TABLE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00" ADD COLUMN performance_tier STRING;
ALTER TABLE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00" ADD COLUMN sale_quarter STRING;
ALTER TABLE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00" ADD COLUMN sale_year NUMBER;
ALTER TABLE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00" ADD COLUMN sale_month DATE;
ALTER TABLE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00" ADD COLUMN sale_quarter STRING;
ALTER TABLE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00" ADD COLUMN sale_year NUMBER;


---2. Convert text-based prices to numeric
UPDATE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00"
SET sellingprice_num = TRY_TO_NUMBER(REPLACE(sellingprice, ',', '')),
    mmr_num           = TRY_TO_NUMBER(REPLACE(mmr, ',', '')),
    sale_month        = DATE_TRUNC('month', TRY_TO_DATE(saledate)),
    sale_quarter      = TO_VARCHAR(TRY_TO_DATE(saledate), 'YYYY-"Q"Q'),
    sale_year         = YEAR(TRY_TO_DATE(saledate));


---#3. Calculate total revenue, profit margin, and performance tier

UPDATE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00"
SET total_revenue = sellingprice_num,  -- assuming 1 unit per row
    profit_margin = sellingprice_num - mmr_num,
    performance_tier = CASE
        WHEN (sellingprice_num - mmr_num) >= 10000 THEN 'High Margin'
        WHEN (sellingprice_num - mmr_num) BETWEEN 5000 AND 9999 THEN 'Medium Margin'
        WHEN (sellingprice_num - mmr_num) < 5000 THEN 'Low Margin'
        ELSE 'Unknown'
    END;

---#4. Group transactions by time periods
UPDATE "CAR_DATA_SALES"."PUBLIC"."VEHICLE_SALES00"
SET sale_month   = DATE_TRUNC('month', TRY_TO_DATE(saledate)),
    sale_quarter = TO_VARCHAR(TRY_TO_DATE(saledate), 'YYYY-"Q"Q'),
    sale_year    = YEAR(TRY_TO_DATE(saledate));
