DROP TABLE IF EXISTS car_prices;
CREATE TABLE car_prices (Year INT,Make TEXT,Model TEXT,
Trim TEXT,Body TEXT,Transmission TEXT,Vin TEXT,State TEXT, 
Carcondition INT,Odometer INT, Color TEXT,Interior TEXT,Seller TEXT, Mmr INT,
Sellingprice INT,saleDate text);

LOAD DATA INFILE 'C:/Users/Public/Downloads/car_prices2.csv'
INTO TABLE car_prices
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT * FROM car_prices;
SELECT COUNT(*) FROM car_prices