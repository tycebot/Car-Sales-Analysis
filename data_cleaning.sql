### Data Cleaning

#Disable safe updates to enable edits
SET SQL_SAFE_UPDATES=0;

# Create table for data transformations
DROP TABLE IF EXISTS car_prices_cleaned;
CREATE TABLE car_prices_cleaned AS 
SELECT * FROM car_prices;

# Standardizing empty fields in text columns
UPDATE car_prices_cleaned
SET make=NULL
WHERE make='';

UPDATE car_prices_cleaned
SET model=NULL
WHERE model='';

UPDATE car_prices_cleaned
SET trim=NULL
WHERE trim='';

UPDATE car_prices_cleaned
SET body=NULL
WHERE body='';

UPDATE car_prices_cleaned
SET transmission=NULL
WHERE transmission='';

UPDATE car_prices_cleaned
SET color=NULL
WHERE color='';

UPDATE car_prices_cleaned
SET interior=NULL
WHERE interior='';

UPDATE car_prices_cleaned
SET vin=NULL
WHERE vin='';

#Verify empty values have been replaced with Null
SELECT COUNT(*) FROM car_prices_cleaned
WHERE make='' OR
model='' OR
trim='' OR
body='' OR
transmission='' OR
color='' OR
interior='' OR
vin='' OR
state='' OR
car_condition='' OR 
odometer='' OR
seller='' OR
mmr='' OR 
selling_price='';


 
## Dealing with Null Values
WITH NullCounts AS (
    SELECT  
        SUM(CASE WHEN model_year IS NULL THEN 1 ELSE 0 END) AS null_year_count,
        SUM(CASE WHEN make IS NULL THEN 1 ELSE 0 END) AS null_make_count,
        SUM(CASE WHEN model IS NULL THEN 1 ELSE 0 END) AS null_model_count,
        SUM(CASE WHEN trim IS NULL THEN 1 ELSE 0 END) AS null_trim_count,
        SUM(CASE WHEN body IS NULL THEN 1 ELSE 0 END) AS null_body_count,
        SUM(CASE WHEN transmission IS NULL THEN 1 ELSE 0 END) AS null_transmission_count,
        SUM(CASE WHEN vin IS NULL THEN 1 ELSE 0 END) AS null_vin_count,
        SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) AS null_state_count,
        SUM(CASE WHEN car_condition IS NULL THEN 1 ELSE 0 END) AS null_carcondition_count,
        SUM(CASE WHEN odometer IS NULL THEN 1 ELSE 0 END) AS null_odometer_count,
        SUM(CASE WHEN color IS NULL THEN 1 ELSE 0 END) AS null_color_count,
        SUM(CASE WHEN interior IS NULL THEN 1 ELSE 0 END) AS null_interior_count,
        SUM(CASE WHEN seller IS NULL THEN 1 ELSE 0 END) AS null_seller_count,
        SUM(CASE WHEN mmr IS NULL THEN 1 ELSE 0 END) AS null_mmr_count,
        SUM(CASE WHEN selling_price IS NULL THEN 1 ELSE 0 END) AS null_sellingprice_count,
        SUM(CASE WHEN sale_date IS NULL THEN 1 ELSE 0 END) AS null_saledate_count
    FROM car_prices_cleaned
),
total_rows AS (
    SELECT COUNT(*) AS total_count FROM car_prices_cleaned
)
SELECT *,
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

## Discarding rows with null values in colums that are less than 1% null
DELETE FROM car_prices_cleaned 
WHERE vin IS NULL OR 
odometer IS NULL OR 
color IS NULL OR 
interior IS NULL OR 
mmr IS NULL OR 
selling_price IS NULL;

## Replacing values in text columns that are at least 1% null with unknown
UPDATE car_prices_cleaned
SET make='unknown'
WHERE make IS NULL ;

UPDATE car_prices_cleaned
SET model='unknown'
WHERE model IS NULL ;

UPDATE car_prices_cleaned
SET trim='unknown'
WHERE trim IS NULL ;

UPDATE car_prices_cleaned
SET body='unknown'
WHERE body IS NULL ;

UPDATE car_prices_cleaned
SET transmission='unknown'
WHERE transmission IS NULL ;

## For columns at least 1% null that are integers we will impute the value using the avg for the make,model,mileage, and price
UPDATE car_prices_cleaned c1
JOIN (
    SELECT make, model, AVG(car_condition) AS avg_condition
    FROM car_prices_cleaned
    WHERE car_condition IS NOT NULL
    GROUP BY make, model
) c2 
ON c1.make = c2.make AND c1.model = c2.model
SET c1.car_condition = c2.avg_condition
WHERE c1.car_condition IS NULL;

## For the 22 rows remaining that dont have a valid car_condition assoicated with the make and model we will drop
DELETE FROM car_prices_cleaned
WHERE car_condition IS NULL;


## Converting sale dates to pst then creating a new column from the day of the week and converting original column to datetime
SELECT COUNT(*) FROM car_prices_cleaned
WHERE car_condition IS NULL;
#Remove values from odometer greater than 800000 as it seems to have been used as artifical cap  for dataset
SELECT DISTINCT(car_condition) FROM car_prices_cleaned

WHERE odometer>500000;


#Renable safe updates to enable edits
SET SQL_SAFE_UPDATES=1;