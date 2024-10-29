

# Walmart Sales Exploratory Analysis Using MySQL

## Introduction
This project is a structured explorative analysis of Walmart sales data using MySQL. It demonstrates how SQL can be applied to investigate and transform raw sales data into actionable insights. By analyzing sales across different times of the day and days of the week, this analysis uncovers valuable trends to optimize inventory management, staffing, and promotional strategies.

## Problem Statement
Walmart’s sales data holds vast potential for identifying customer purchase behaviors and peak sales periods. However, without effective analysis, these patterns remain hidden, limiting data-driven decision-making. This project addresses the following questions:
- When are peak sales hours?
- Which days of the week see the highest and lowest sales activity?
- How can sales data be structured for optimal analysis and visualization?

## Skills Demonstrated
This project utilizes various SQL skills and techniques, including:
- **Database Management**: Creating tables, importing data, and managing data integrity.
- **Data Transformation**: Using SQL queries and functions to transform and categorize data.
- **Conditional Logic**: Applying `CASE` statements for categorizing data based on time and date.
- **Data Analysis and Aggregation**: Using SQL to derive insights from aggregated data, such as peak hours and sales trends.
- **Optimization for Visualization**: Structuring data for clear, meaningful visual outputs in BI tools.

## Data Transformation

### Data Transformation
1. **Creating and Populating Tables**:
   - A new `sales` table was created and populated with Walmart sales data.
     ```sql
     CREATE TABLE sales LIKE walamart.`walmartsalesdata.csv`;
     INSERT INTO sales SELECT * FROM walamart.`walmartsalesdata.csv`;
     ```

2. **Time-Based Categorization**:
   - Sales transactions were categorized into `Morning`, `Afternoon`, and `Evening` timeframes:
     ```sql
     SELECT `time`,
         CASE
             WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
             WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
             ELSE "Evening"
         END AS time_of_day
     FROM sales;
     ```

3. **Day of the Week Extraction**:
   - The day of the week was extracted to analyze weekly sales patterns, adding an additional `day_name` attribute:
     ```sql
     ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
     UPDATE sales SET day_name = DAYNAME(`date`);
     ```

## Conclusion
This analysis provides Walmart with valuable insights into customer buying behavior. By identifying peak sales times and days, Walmart can make more informed decisions to enhance operational efficiency and customer satisfaction. Additionally, this project demonstrates the effectiveness of SQL in transforming raw data into structured, analyzable formats, ready for visualization in tools like Power BI or Tableau. 
