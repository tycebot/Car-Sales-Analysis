## Data Analysis

## 1. What car sellers get the best margins relative to MMR?
SELECT 
    seller,
    COUNT(*) AS sales_count,
    ROUND(AVG(selling_price - mmr),2) AS avg_margin,
    ROUND(AVG((selling_price - mmr) / mmr * 100),2) AS avg_pct_margin,
    ROUND(STDDEV((selling_price - mmr) / mmr * 100),2) AS std_dev_pct_margin
FROM car_prices_cleaned
GROUP BY seller
HAVING COUNT(*) >= 1000
ORDER BY sales_count DESC,avg_pct_margin DESC;

##2. Do certain color interior combinations command premium prices within the same make/model
WITH base_prices AS (
    SELECT 
        make, 
        model, 
        AVG(selling_price) AS avg_model_price
    FROM car_prices_cleaned
    GROUP BY make, model
)

SELECT 
    c.make, 
    c.model, 
    c.color, 
    c.interior,
    COUNT(*) AS sales_count,
    b.avg_model_price AS base_price,
    AVG(c.selling_price) AS avg_combo_price,
    AVG(c.selling_price) - b.avg_model_price AS price_premium,
    (AVG(c.selling_price) - b.avg_model_price) / b.avg_model_price * 100 AS pct_premium
FROM car_prices_cleaned c
JOIN base_prices b ON c.make = b.make AND c.model = b.model
GROUP BY c.make, c.model, c.color, c.interior
HAVING COUNT(*) >= 500 AND
make!='unknown'
ORDER BY pct_premium DESC
LIMIT 100;

##2B Do rare colors sell for more
SELECT color,
    COUNT(*) AS total_sales,
    ROUND(AVG(selling_price), 2) AS avg_price,
    DENSE_RANK() OVER(ORDER BY COUNT(*) ASC) AS rarity_rank
FROM car_prices_cleaned
GROUP BY color
ORDER BY rarity_rank;

##3. What price ranges have the highest sales volume, and how does this vary by vehicle type
SELECT 
    body,
    CASE 
        WHEN selling_price < 20000 THEN 'Under $20K'
        WHEN selling_price < 30000 THEN '$20K-$30K'
        WHEN selling_price < 40000 THEN '$30K-$40K'
        WHEN selling_price < 50000 THEN '$40K-$50K'
        ELSE 'Over $50K'
    END AS price_range,
    COUNT(*) AS sales_count,
    SUM(selling_price) AS total_revenue
FROM car_prices_cleaned
GROUP BY body, price_range
HAVING COUNT(*) > 100
ORDER BY COUNT(*) DESC, total_revenue DESC;

##4. What make model combination have the best profit margins
SELECT 
    make, 
    model, 
    COUNT(*) AS sales_count,
    AVG(selling_price - mmr) AS avg_margin,
    SUM(selling_price)-SUM(mmr) AS total_margin
FROM car_prices_cleaned
GROUP BY make, model
HAVING COUNT(*) >= 100
ORDER BY AVG(selling_price - mmr) DESC;

##5. What percentage of cars are sold above or below their market value(segmented by state)
SELECT 
    ROUND(SUM(CASE WHEN selling_price > mmr THEN 1 ELSE 0 END) / COUNT(*) * 100.0, 2) AS above_market_percentage,
    ROUND(SUM(CASE WHEN selling_price < mmr THEN 1 ELSE 0 END) / COUNT(*) * 100.0, 2) AS below_market_percentage,
    ROUND(SUM(CASE WHEN selling_price = mmr THEN 1 ELSE 0 END) / COUNT(*) * 100.0, 2) AS market_percentage
FROM car_prices_cleaned;

SELECT state,
    ROUND(SUM(CASE WHEN selling_price > mmr THEN 1 ELSE 0 END) / COUNT(*) * 100.0, 2) AS above_market_percentage,
    ROUND(SUM(CASE WHEN selling_price < mmr THEN 1 ELSE 0 END) / COUNT(*) * 100.0, 2) AS below_market_percentage,
    ROUND(SUM(CASE WHEN selling_price = mmr THEN 1 ELSE 0 END) / COUNT(*) * 100.0, 2) AS market_percentage,
    COUNT(*) AS sales_count
FROM car_prices_cleaned
GROUP BY state
ORDER BY above_market_percentage DESC;

##7. What Month see the highest lowest sales
SELECT sale_month,COUNT(*) 
FROM car_prices_cleaned
GROUP BY sale_month;

##8 How does car condition affect  Selling price
SELECT car_condition,
    ROUND(AVG(selling_price - mmr), 2) AS avg_price_difference,
    ROUND(PERCENT_RANK() OVER (ORDER BY AVG(selling_price - mmr) DESC),2) AS condition_percentile
FROM car_prices_cleaned
GROUP BY car_condition
HAVING COUNT(*)>50
ORDER BY avg_price_difference DESC;

##9 Do newer cars consistently sell at higher prices compared to older ones
SELECT model_year, 
    ROUND(AVG(selling_price), 2) AS avg_price, 
    LAG(AVG(selling_price)) OVER(ORDER BY model_year) AS prev_year_avg, 
    ROUND(((AVG(selling_price) - LAG(AVG(selling_price)) OVER(ORDER BY model_year)) / LAG(AVG(selling_price)) OVER(ORDER BY model_year)) * 100, 2) AS price_change_percentage,
    COUNT(*) AS sale_count
FROM car_prices_cleaned
GROUP BY model_year
HAVING COUNT(*)>100
ORDER BY model_year;

###KPIs

##10 Price per mile
SELECT make,model,odometer,car_condition,
    ROUND((selling_price / odometer), 2) AS price_per_mile
FROM car_prices_cleaned;

##11 Market value variance
SELECT make,model,odometer,car_condition,
     selling_price - mmr AS mvv
FROM car_prices_cleaned;

##12 Market adjustment ratio
SELECT make,model,odometer,car_condition,
     ROUND(((selling_price - mmr)/mmr)*100,2) AS mar
FROM car_prices_cleaned;

##13 positive vs negative MAR
SELECT 
    SUM(CASE WHEN ((selling_price - mmr) / mmr) > 0 THEN 1 ELSE 0 END) AS positive_mar_count,
    SUM(CASE WHEN ((selling_price - mmr) / mmr) < 0 THEN 1 ELSE 0 END) AS negative_mar_count,
    ROUND(SUM(CASE WHEN ((selling_price - mmr) / mmr) > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS positive_mar_pct,
    ROUND(SUM(CASE WHEN ((selling_price - mmr) / mmr) < 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS negative_mar_pct
FROM car_prices_cleaned;