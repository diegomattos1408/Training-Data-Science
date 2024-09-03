-- How many customers are there in each country?
SELECT country, COUNT(customer_id) AS Customer_Count
FROM customer_data_formatted
GROUP BY country;

-- What is the average annual income of customers who have a subscription?
SELECt ROUND(AVG(Annual_Income),2) AS Annual_Income_Avarage
FROM customer_data_formatted
WHERE subscription = 1;

-- How many customers are in each favorite product category?
SELECT favorite_product_category, COUNT(customer_id) AS Customer_Count_Category
FROM customer_data_formatted
GROUP BY favorite_product_category;

-- Which country has the highest average customer satisfaction score?
SELECT Country, AVG(customer_satisfaction_score) AS Customer_Satisfaction_Highest_Avg
FROM customer_data_formatted
GROUP BY Country
ORDER BY Customer_Satisfaction_Highest_Avg DESC
LIMIT 1;

-- How many customers have made more than 50 purchases?
SELECT COUNT(customer_id) AS Customer_Count
FROM customer_data_formatted
WHERE number_of_purchases > 50;

-- What is the total number of purchases made by customers from the United States?
SELECT SUM(Number_of_Purchases) AS Total_Purchases
FROM customer_data_formatted
WHERE Country = 'United States';

-- What is the distribution of genders in the dataset?
SELECT Gender, COUNT(Customer_ID) AS Gender_Count
FROM customer_data_formatted
GROUP BY Gender;

-- Which customer has the highest annual income, and what is that income?
SELECT Customer_ID, Annual_Income
FROM customer_data_formatted
ORDER BY Annual_Income DESC
LIMIT 1;

-- How many customers are aged 30 or younger?
SELECT COUNT(Customer_ID) AS Young_Customers_Count
FROM customer_data_formatted
WHERE Age <= 30;

-- What is the average number of purchases for each gender?
SELECT Gender, AVG(Number_of_Purchases) AS Avg_Purchases
FROM customer_data_formatted
GROUP BY Gender;

-- Which product category has the highest average annual income among customers who favor it?
SELECT Favorite_Product_Category, AVG(Annual_Income) AS Avg_Income
FROM customer_data_formatted
GROUP BY Favorite_Product_Category
ORDER BY Avg_Income DESC
LIMIT 1;

-- How many customers have a satisfaction score above 7 and a subscription?
SELECT COUNT(Customer_ID) AS High_Satisfaction_With_Subscription
FROM customer_data_formatted
WHERE Customer_Satisfaction_Score > 7 AND Subscription = 1

-- Which age group (under 30, 30-50, over 50) has the most customers?
SELECT CASE 
           WHEN Age < 30 THEN 'Under 30'
           WHEN Age BETWEEN 30 AND 50 THEN '30-50'
           WHEN Age > 50 THEN 'Over 50'
        END AS Age_Group, 
        COUNT(Customer_ID) AS Count
FROM customer_data_formatted
GROUP BY Age_Group
ORDER BY Count DESC;

-- What is the average number of purchases made by customers from each country?
SELECT Country, AVG(Number_of_Purchases) AS Avg_Purchases
FROM customer_data_formatted
GROUP BY Country;

-- How many customers have missing data in the Annual_Income column?
SELECT COUNT(Customer_ID) AS Missing_Income_Count
FROM customer_data
WHERE Annual_Income IS NULL;

-- What percentage of customers with a subscription have a customer satisfaction score below 5?
SELECT (COUNT(Customer_ID) * 100.0 / (SELECT COUNT(Customer_ID) FROM customer_data WHERE Subscription = 1)) AS Percentage_Low_Satisfaction
FROM customer_data_formatted
WHERE Subscription = 1 AND Customer_Satisfaction_Score < 5;

-- Which country has the most customers with a satisfaction score of 9 or higher?
SELECT Country, COUNT(Customer_ID) AS High_Satisfaction_Count
FROM customer_data_formatted
WHERE Customer_Satisfaction_Score >= 9
GROUP BY Country
ORDER BY High_Satisfaction_Count DESC
LIMIT 1;

-- What is the distribution of customer satisfaction scores for each product category?
SELECT Favorite_Product_Category, Customer_Satisfaction_Score, COUNT(Customer_ID) AS Score_Count
FROM customer_data_formatted
GROUP BY Favorite_Product_Category, Customer_Satisfaction_Score
ORDER BY Favorite_Product_Category, Customer_Satisfaction_Score;

-- How many customers have made a purchase after January 1, 2022, and how many of them have a subscription?
SELECT 
      COUNT(Customer_ID) AS Total_Customers_After_2022,
      SUM(CASE WHEN Subscription = 1 THEN 1 ELSE 0 END) AS Subscribed_Customers
  FROM customer_data
  WHERE Purchase_Date > '2022-01-01';

-- What is the average customer satisfaction score for each age group (under 30, 30-50, over 50)? 
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 50 THEN '30-50'
        WHEN Age > 50 THEN 'Over 50'
    END AS Age_Group, 
    AVG(Customer_Satisfaction_Score) AS Avg_Satisfaction
FROM customer_data_formatted
WHERE Age IS NOT NULL
GROUP BY Age_Group;





