DROP TABLE IF EXISTS car_prices;
CREATE TABLE car_prices (model_year INT,make TEXT,model TEXT,
trim TEXT,body TEXT,transmission TEXT,vin TEXT,state TEXT, 
car_condition INT,odometer INT, color TEXT,interior TEXT,seller TEXT, mmr INT,
selling_price INT,sale_date text);

# CHANGE to wherever you have dataset stored
LOAD DATA INFILE 'C:/Users/Public/Downloads/car_prices2.csv'
INTO TABLE car_prices
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM car_prices;