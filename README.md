# Car Sales Analysis Project

## Overview
This project analyzes a car sales dataset to extract actionable business insights using SQL and Tableau. The analysis focuses on pricing strategies, market trends, and seller performance to support data-driven decision making in the automotive sales business.

## Dataset
The dataset contains detailed information about vehicle sales including:

- Vehicle details: year, make, model, trim, body type, transmission, VIN
- Sale information: condition, odometer reading, colors, seller, pricing (MMR & selling price)
- Temporal data: sale date, weekday, year, month

Sample record:
```
'2014', 'Audi', 'SQ5', '3.0T Premium Plus quattro', 'SUV', 'automatic', 'wa1cgafp4ea030312', 'ca', '42', '9606', 'white', 'black', 'audi of downtown l a', '48600', '47500', '2015-01-29 04:00:00', 'Thursday', '2015', '1'
```

## Business Questions Addressed

### Pricing and Value Analysis
1. Identification of makes/models selling consistently above/below MMR value
2. Analysis of profit margins by make/model and vehicle condition
3. Price premiums for specific color and interior combinations

### Inventory Optimization
4. Average time in inventory by make/model
5. Vehicle configurations with highest turnover rates
6. Seasonal sales patterns and trends

### Market Analysis
7. Correlation between vehicle condition and price differentials
8. Transmission popularity trends over time
9. Sales volume analysis by price range and vehicle type

### Seller Performance
10. Seller performance in achieving margins relative to MMR
11. Seller specialization and success rates in different market segments

## Technical Implementation

### SQL Analysis
Each business question is addressed through carefully crafted SQL queries that:
- Group and aggregate data appropriately
- Calculate relevant metrics (margins, percentages, etc.)
- Use window functions for comparative analysis

### Tableau Visualizations
The SQL results are visualized in Tableau using:
- Comparative bar charts and heat maps for pricing analysis
- Time series charts for temporal patterns
- Scatter plots for correlation analysis
- Interactive dashboards with filters for multidimensional exploration


## Key Insights
- TBD

## Future Enhancements
- Predictive modeling for optimal pricing
- Geospatial analysis of regional price variations

## Usage
1. Clone this repository
2. Import the SQL scripts into your database environment
3. Open the Tableau workbooks to explore the visualizations
4. Review the business insights report for actionable recommendations



