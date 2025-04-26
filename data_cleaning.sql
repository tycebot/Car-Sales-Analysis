### Data Cleaning
WITH NullCounts AS (
    SELECT  
        SUM(CASE WHEN model_year IS NULL OR model_year = '' THEN 1 ELSE 0 END) AS null_year_count,
        SUM(CASE WHEN make IS NULL OR make = '' THEN 1 ELSE 0 END) AS null_make_count,
        SUM(CASE WHEN model IS NULL OR model = '' THEN 1 ELSE 0 END) AS null_model_count,
        SUM(CASE WHEN trim IS NULL OR trim = '' THEN 1 ELSE 0 END) AS null_trim_count,
        SUM(CASE WHEN body IS NULL OR body = '' THEN 1 ELSE 0 END) AS null_body_count,
        SUM(CASE WHEN transmission IS NULL OR transmission = '' THEN 1 ELSE 0 END) AS null_transmission_count,
        SUM(CASE WHEN vin IS NULL OR vin = '' THEN 1 ELSE 0 END) AS null_vin_count,
        SUM(CASE WHEN state IS NULL OR state = '' THEN 1 ELSE 0 END) AS null_state_count,
        SUM(CASE WHEN car_condition IS NULL OR car_condition = '' THEN 1 ELSE 0 END) AS null_carcondition_count,
        SUM(CASE WHEN odometer IS NULL OR odometer = '' THEN 1 ELSE 0 END) AS null_odometer_count,
        SUM(CASE WHEN color IS NULL OR color = '' THEN 1 ELSE 0 END) AS null_color_count,
        SUM(CASE WHEN interior IS NULL OR interior = '' THEN 1 ELSE 0 END) AS null_interior_count,
        SUM(CASE WHEN seller IS NULL OR seller = '' THEN 1 ELSE 0 END) AS null_seller_count,
        SUM(CASE WHEN mmr IS NULL OR mmr = '' THEN 1 ELSE 0 END) AS null_mmr_count,
        SUM(CASE WHEN selling_price IS NULL OR selling_price = '' THEN 1 ELSE 0 END) AS null_sellingprice_count,
        SUM(CASE WHEN sale_date IS NULL OR sale_date = '' THEN 1 ELSE 0 END) AS null_saledate_count
    FROM car_prices
),
total_rows AS (
    SELECT COUNT(*) AS total_count FROM car_prices
)
SELECT
       CONCAT(null_year_count / total_rows.total_count * 100,'%') AS null_year_percentage,
       CONCAT(null_make_count / total_rows.total_count * 100,'%') AS null_make_percentage,
       CONCAT(null_model_count / total_rows.total_count * 100,'%') AS null_model_percentage,
       CONCAT(null_trim_count / total_rows.total_count * 100,'%') AS null_trim_percentage,
       CONCAT(null_body_count / total_rows.total_count * 100,'%') AS null_body_percentage,
       CONCAT(null_transmission_count / total_rows.total_count * 100,'%') AS null_transmission_percentage,
       CONCAT(null_vin_count / total_rows.total_count * 100,'%') AS null_vin_percentage,
       CONCAT(null_state_count / total_rows.total_count * 100,'%') AS null_state_percentage,
       CONCAT(null_carcondition_count / total_rows.total_count * 100,'%') AS null_carcondition_percentage,
       CONCAT(null_odometer_count / total_rows.total_count * 100,'%') AS null_odometer_percentage,
       CONCAT(null_color_count / total_rows.total_count * 100,'%') AS null_color_percentage,
       CONCAT(null_interior_count / total_rows.total_count * 100,'%') AS null_interior_percentage,
       CONCAT(null_seller_count / total_rows.total_count * 100,'%') AS null_seller_percentage,
       CONCAT(null_mmr_count / total_rows.total_count * 100,'%') AS null_mmr_percentage,
       CONCAT(null_sellingprice_count / total_rows.total_count * 100,'%') AS null_sellingprice_percentage,
       CONCAT(null_saledate_count / total_rows.total_count * 100,'%') AS null_saledate_percentage,
       CONCAT(
           (null_year_count + null_make_count + null_model_count + null_trim_count + null_body_count + 
           null_transmission_count + null_vin_count + null_state_count + null_carcondition_count + 
           null_odometer_count + null_color_count + null_interior_count + null_seller_count + 
           null_mmr_count + null_sellingprice_count + null_saledate_count) / total_rows.total_count * 100, '%'
       ) AS total_null_percentage
FROM NullCounts, total_rows;

## For the columns that are less than 1% null or contain strings we will discard the null values otherwise we will impute the value



## Counting Number of illogical values in the data column





