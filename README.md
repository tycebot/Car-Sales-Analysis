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
## Dashboard Links
https://public.tableau.com/app/profile/terrell.enoru/viz/USAutomotiveSales2014-2015/Dashboard2
https://public.tableau.com/app/profile/terrell.enoru/viz/CarSalesDashboard2_17463493438490/Dashboard1

## Business Questions Addressed

###Pricing and Value Analysis
1. What car sellers get the best margins relative to MMR?
2. Do certain color-interior combinations command premium prices within the same make/model?
3. Do rare colors sell for more?
Inventory & Market Analysis
4. What price ranges have the highest sales volume, and how does this vary by vehicle type?
5. What make-model combinations have the best profit margins?
6. What percentage of cars are sold above or below their market value, segmented by state?
7. What months see the highest and lowest sales?
8. How does car condition affect selling price?
9. Do newer cars consistently sell at higher prices compared to older ones?
Key Performance Indicators (KPIs)
10. Price per mile
11. Market Value Variance
12. Market adjustment ratio

## Technical Implementation

### SQL Analysis
Each business question is addressed through carefully crafted SQL queries that:
- Group and aggregate data appropriately
- Calculate relevant metrics (margins, percentages, etc.)
- Use window functions for comparative analysis

### Tableau Visualizations
The SQL results are visualized in Tableau using:
- Comparative bar charts for pricing analysis
- Geospatial maps for geographic sales distribution
- Interactive dashboards with filters for multidimensional exploration


## Key Insights
- Market Value Trends: Vehicles tend to sell below their MMR more frequently than they sell above it, with a negative variance occurring approximately 4% more often than a positive one. This suggests that market pressures and seller strategies often lead to pricing concessions.
- Budget Sedan Dominance: Low-cost sedans (under $20K) significantly outperform other body styles and price ranges. In fact, sales volume and total revenue in this category are twice as high as any other segment, reinforcing their appeal among cost-conscious buyers.
- Color & Pricing Paradox: Despite the common assumption that rare colors command a premium, the data does not support this theory. On the contrary, black—one of the most prevalent colors—has the second highest average selling price. Furthermore, among the top four highest-priced colors, two are also among the most commonly sold, indicating buyer preference trends that defy rarity-based pricing strategies.
- Regional Pricing Variation: Washington state stands out, with over 60% of vehicles selling above their market value—the highest percentage across all regions analyzed. This suggests stronger pricing power in the state, possibly influenced by local demand, inventory shortages, or dealership strategies

## Future Enhancements
- Predictive modeling for optimal pricing
- Geospatial analysis of regional price variations

## Usage
1. Clone this repository
2. Import the SQL scripts into your database environment
3. Open the Tableau workbooks to explore the visualizations
4. Review the business insights report for actionable recommendations



