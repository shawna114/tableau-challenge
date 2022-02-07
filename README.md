# Citi Bike Analysis

## Analysis Steps
Data from the range of 1/1/2019-12/31/2020 from [Citi Bike](https://s3.amazonaws.com/tripdata/index.html) was used for final analysis. RStudio was used to summarize and to prepare 24 files (more than 20,000,000 rows) for visualization in Tableau. Because data is captured as routes (by start and stop locations), data was aggregated to show overall volume (start and stop volume at each location).

## Link to Tableau Workbook
[Citi Bike Workbook](https://public.tableau.com/app/profile/shawna.truitt4252)

## Analysis

### Volume and Customer Demographic Findings

1. The Burrough with the highest combined volume in NYC is Manhattan. Comparison between the 2019 and 2020 station maps, demonstrates notable expansion in Northern Manhattan and Southern Bronx in 2020.

![2019 Citi Bike Map](https://github.com/shawna114/tableau-challenge/blob/main/Images/2019%20Citi%20Bike%20Map.png)

![20120 Citi Bike Map](https://github.com/shawna114/tableau-challenge/blob/main/Images/2020%20Citi%20Bike%20Map.png)

2. The Citi Bike station with the highest volume in 2019 was Pershing Square North. In 2020, West St & Chambers St. had the highest volume.

![2019 Volume](https://github.com/shawna114/tableau-challenge/blob/main/Images/2019%20Volume.png)

![2020 Volume](https://github.com/shawna114/tableau-challenge/blob/main/Images/2020%20Volume.png)

3. Citi Bike volume decreased by 5% from 2019 to 2020.

![2019-2020 Change](https://github.com/shawna114/tableau-challenge/blob/main/Images/2019_2020%20Volume.png)

### Notable Trends

1. September is the highest volume month across all Citi Bike locations for years 2019-2020.

![Seasonal Trends](https://github.com/shawna114/tableau-challenge/blob/main/Images/Seasonal%20Trends_2019_2020.png)

2. Average age across all Citi Bike sites ranges between 22 to 51 years old. The average Citi Bike user across all sites is 38 years old.

![Average Age by Station](https://github.com/shawna114/tableau-challenge/blob/main/Images/Average%20Age%20by%20Station%20Volume.png)

3. More males utilize Citi Bike than females. Percent of female customers increased minimally in 2020.

![Customer Gender](https://github.com/shawna114/tableau-challenge/blob/main/Images/2019_2020%20Gender.png)

4. Weekly membership shows change in daily usage from 2019 to 2020. Busiest days of the week changed from weekdays to weekends.

![Weekly Trends](https://github.com/shawna114/tableau-challenge/blob/main/Images/Weekly%20Trends.png)

5. Daily volume is highest at 5:00pm for both 2019 and 2020. There is less of a contrast between afternoon hours and peak hours in 2020 when compared to 2019.

![Daily Trends](https://github.com/shawna114/tableau-challenge/blob/main/Images/Daily%20Trends.png)
