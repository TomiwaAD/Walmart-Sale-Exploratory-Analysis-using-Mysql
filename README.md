# Walmart-Sale-Explorative-Analysis-using-Mysql

# Walmart Sales Explorative Analysis Using MySQL

## Project Overview
This project performs an explorative analysis of Walmart sales data using MySQL. The goal is to investigate sales patterns, identify trends, and uncover insights that can inform business strategies. Through SQL-based data manipulation and querying, the project demonstrates how to efficiently explore large datasets to answer key business questions about sales performance across various timeframes and categories.

## Key Features
- **Data Integration**: Creating structured tables to store sales data from external CSV sources.
- **Explorative Data Analysis (EDA)**: Using SQL queries to perform descriptive analysis, uncover trends, and identify patterns.
- **Data Transformation**: Applying SQL functions to categorize and transform raw data for deeper insights.
- **Trend Analysis**: Extracting and visualizing trends based on sales by time of day, day of the week, and other critical factors.

## Technical Requirements
This project uses MySQL for executing SQL commands. Ensure the following tools and functionalities are set up:
- **MySQL Server**: To create and manage the database.
- **SQL Functions**: Including `CASE`, string manipulation, and date functions for effective data analysis.

## Dataset Description
The dataset (`walmartsalesdata.csv`) contains information on Walmart sales transactions, including:
- **Date and Time**: Timestamp for each sale.
- **Sales Amount**: Value of transactions.
- **Product Details**: Information about items sold, including categories and quantities.

## Steps Performed in the Analysis

### 1. Data Setup and Integration
- **Create Sales Table**: The project begins by creating a `sales` table in the MySQL database to store the imported data:
    ```sql
    CREATE TABLE sales LIKE walamart.`walmartsalesdata.csv`;
    INSERT INTO sales SELECT * FROM walamart.`walmartsalesdata.csv`;
    ```

### 2. Initial Exploration and Data Cleaning
- **View Raw Data**: Perform initial checks by viewing the data to understand its structure and quality.
- **Clean and Prepare Data**: Remove unnecessary columns, handle missing values, and standardize formats.

### 3. Categorization Based on Time
- **Time of Day Analysis**: Classify sales into morning, afternoon, and evening:
    ```sql
    SELECT `time`,
        CASE
            WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
            WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
            ELSE "Evening"
        END AS time_of_day
    FROM sales;
    ```

### 4. Adding Additional Attributes for Deeper Insights
- **Day of the Week**: Add a new column that extracts and displays the name of the day:
    ```sql
    ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
    UPDATE sales SET day_name = DAYNAME(`date`);
    ```

### 5. Analyzing Trends and Patterns
- **Sales by Day**: Identify which days see the highest and lowest sales activity:
    ```sql
    SELECT day_name, COUNT(*) AS sales_count FROM sales GROUP BY day_name ORDER BY sales_count DESC;
    ```
- **Peak Times Analysis**: Analyze peak sales periods to understand customer behavior patterns.


    *Verify and Explore**:
    - Use SQL commands like `SHOW TABLES;` and `DESCRIBE sales;` to verify the setup.
    - Execute the queries step by step to conduct the analysis.

## Key Insights
- **Time-Based Sales Trends**: Insights into when sales are most frequent (morning, afternoon, evening).
- **Weekly Sales Patterns**: Analysis reveals which days drive the highest volume of transactions.
- **Overall Performance**: Summary statistics highlight general trends and possible areas for business improvement.

