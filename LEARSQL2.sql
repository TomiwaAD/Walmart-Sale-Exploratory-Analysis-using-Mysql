SELECT * FROM walamart.`walmartsalesdata.csv`;

 CREATE TABLE sales
LIKE walamart.`walmartsalesdata.csv`;
SELECT *
FROM sales;
INSERT INTO sales
SELECT * FROM walamart.`walmartsalesdata.csv`;

#---TIME_OF _DAY
SELECT `time`,
    (CASE
    WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
    WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
    ELSE "Evening"
END 
    ) AS time_of_day
FROM sales;

ALTER TABLE sales
ADD COLUMN day_name VARCHAR(10);

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y') AS Date
FROM sales;

UPDATE  sales
SET day_name = DAYNAME(Date);

SELECT *
FROM sales;

#UPDATE sales
SET time_of_day = (
CASE
    WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
    WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
    ELSE "Evening"
END $$
);


###-----#day_name-----
SELECT 
	Date,
	DAYNAME(Date) AS day_name
FROM sales;

-- month_name
SELECT
	Date,
    MONTHNAME(Date)
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(Date);

#----HOW MANY UNIQUE CITIES DOES THE DATA HAVE 
 
 SELECT DISTINCT city
 FROM sales;
 
 #----IN WHICH CITY IS EACH BRANCH
 
  SELECT DISTINCT city, Branch
 FROM sales;
  
  #---------------------------------------------------------PRODUCT LINE---------------------------------------------------------------
SELECT `Product line`
FROM sales;

#-----THE MOST COMMON Payment method
SELECT payment, COUNT(payment) AS cpm
FROM sales
GROUP BY payment
ORDER BY cpm DESC;
SELECT * FROM  sales;
#-----MOST SELLING PRODUCT LINE-----------
SELECT `Product line`, SUM(Total) AS Stotal
FROM sales
GROUP BY `Product line`
ORDER BY Stotal DESC
;

#--------------total revenue by month-----------
SELECT DISTINCT(month_name)
FROM sales;


SELECT SUM(Total) AS Total_revenue, month_name
FROM sales
GROUP BY month_name
ORDER BY Total_revenue DESC;

#------------------------------------month with the highest cogs------------------------------------------------------
SELECT month_name, sum(cogs) AS Mcogs
FROM sales
GROUP BY month_name
ORDER BY Mcogs DESC;

#------CITY WITH THE LARGEST Revenue-----
SELECT city, SUM(Total) AS Crevnue
FROM sales
GROUP BY city
ORDER BY Crevnue DESC;

#-----------------PRODUCT LINE WITH THE LARGEST VAT--------------------------------
SELECT `Product line`, SUM(`Tax 5%`)AS vat
FROM sales
GROUP BY `Product line`
ORDER BY vat DESC;

#---------------------PRODCTLINE GREATER THAT AVG SALES-----------
SELECT AVG(Total) AS atot
FROM sales;
WITH avg_sales AS (
    SELECT AVG(Total) AS atot
    FROM sales
)
SELECT Total,
       (CASE
            WHEN Total < avg_sales.atot THEN "Bad"
            WHEN Total >= avg_sales.atot THEN "Good"
            ELSE NULL
        END) AS Performance
FROM sales, avg_sales;

ALTER TABLE sales ADD COLUMN performance VARCHAR(20);

WITH avg_sales AS (
    SELECT AVG(Total) AS atot
    FROM sales
)
UPDATE sales
JOIN(
	SELECT Total,
       (CASE
            WHEN Total < avg_sales.atot THEN "Bad"
            WHEN Total >= avg_sales.atot THEN "Good"
            ELSE NULL
        END) AS Performance
FROM sales, avg_sales
)
AS temp ON sales.Total = temp.Total
SET sales.performance = temp.Performance; 




####-----------------AVR RATING OF PRODUCT LINE---------------------------

SELECT Product_line, AVG(Rating) AS Arating
FROM sales
GROUP BY Product_line
ORDER BY Arating DESC;
#---------------------
#MOST BRANCH
SELECT  
	Branch,
	SUM(Quantity) AS QQ
FROM sales
GROUP BY Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM sales);

#-------
SELECT 
	time_of_day,
    COUNT(*) AS total_time_sales
    FROM sales
    WHERE day_name = "Friday"
    GROUP BY time_of_day
    ORDER BY total_time_sales DESC;


#----------BY GENDER

SELECT Gender,
	Product_line,
    COUNT(Gender) AS total_cnt
    FROM sales
    GROUP BY Gender, Product_line
    ORDER BY total_cnt;
    
####customer type with the most reveue

SELECT `Customer type`, SUM(Total) AS scus
FROM sales
GROUP BY `Customer type`
ORDER BY scus DESC;

###CITY WITH THE HIGHEST VAT-----

SELECT city, AVG(`Tax 5%`) AS vat
FROM sales
GROUP BY city
ORDER BY vat DESC;

####customer type with the most VAT
SELECT `Customer type`, AVG(`Tax 5%`) AS vat
FROM sales
GROUP BY `Customer type`
ORDER BY vat DESC;

#-------------------------------------------------------CUSTOMER3---------------------------------------------------------------------------
###----------------How many Unique customer types does the data have?

SELECT DISTINCT `customer type`
FROM sales;
###-----------------How many Unique customer types does the data have--------------------------------
SELECT DISTINCT Payment
FROM sales;

#------------------------------------------modt common customer typer----------------------------------
SELECT  DISTINCT `customer type`, COUNT(`customer type`)
FROM sales
GROUP BY `customer type`;

##------------------------------CUSTOMER TYPE THAT BUYS THE MOST--------------------------------------
SELECT SUM(Quantity) FROM sales;
SELECT `customer type`, SUM(Quantity) AS SQ
FROM sales
GROUP BY `customer type`;

SELECT `customer type`, COUNT(*) AS SQ
FROM sales
GROUP BY `customer type`;


###---------------------gender distribution per branch-----------------------------
	SELECT Branch, Gender, COUNT(Gender)
	FROM sales
	GROUP BY Gender, Branch;

###time of the day with the most ratinG----------------------------

SELECT  time_of_day, SUM(Rating)
FROM sales
GROUP BY time_of_day
ORDER BY SUM(Rating) DESC;
-#----------------------time of the day with the most ratinG PER BRANCH=----------
SELECT  time_of_day, Branch, SUM(Rating)
FROM sales
GROUP BY time_of_day, Branch
ORDER BY SUM(Rating) DESC;
#-----------------------------DAY OF THE WEEK WITH THE BEST AVG RATING------------------------------
SELECT  time_of_day, AVG(Rating)
FROM sales
GROUP BY time_of_day
ORDER BY AVG(Rating) DESC;
#-----------------------------DAY OF THE WEEK WITH THE BEST AVG RATING per Branch------------------------------
SELECT  time_of_day, Branch, AVG(Rating)
FROM sales
GROUP BY time_of_day,Branch
ORDER BY AVG(Rating) DESC;