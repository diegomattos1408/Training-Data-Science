-- 1. Retrieve all customers who are subscribed
SELECT customer_id 
FROM customer_data_formatted
WHERe subscription = TRUE;

-- 2. Find the total number of purchases made by customers from the US 
SELECT country, SUM(number_of_purchases) AS Total_Purchases
FROM customer_data_formatted
GROUP by country 

-- 3. List all unique product categories
SELECT DISTINCT(favorite_product_category) AS Categories
FROM customer_data_formatted

-- 4. Calculate the average annual income by country
SELECT country, AVG(annual_income) AS Avarage_Annual_Income
FROM customer_data_formatted
GROUP BY country

-- 5. Find customers with more than 50 purchases
SELECT customer_id, number_of_purchases
FROM customer_data_formatted
WHERE number_of_purchases > 50

-- 6. Get the top 3 most common product categories
SELECt favorite_product_category, SUM(number_of_purchases) AS Total_Purchases
FROm customer_data_formatted
GROUP BY favorite_product_category
ORDER BY Total_Purchases DESC
LIMIT 3;

-- 7. How many customers are there in each country?
SELECT country, COUNT(customer_id) AS Total_Customers
FROM customer_data_formatted
GROUP BY country;

-- 8. What is the average annual income of customers who have a subscription?
SELECT subscription, AVG(annual_income) AS Avarage_Income
FROM customer_data_formatted
WHERE subscription = TRUE;

-- 9. How many customers are in each favorite product category?
SELECT favorite_product_category, COUNT(customer_id) AS Total_Customers_Products_Category
FROM customer_data_formatted
GROUP BY favorite_product_category;

-- 10. Which country has the highest average customer satisfaction score?
SELECT country, AVG(customer_satisfaction_score) AS Avarage_customer_satisfaction
FROM customer_data_formatted
GROUP BY country
ORder BY Avarage_customer_satisfaction DESC
LIMIT 1;

-- 11. How many customers have made more than 50 purchases?
SELECT customer_id, number_of_purchases AS total_purchases_customers
FROM customer_data_formatted
WHERE total_purchases_customers > 50;

-- 12. What is the total number of purchases made by customers from the United States?
SELECT SUM(Number_of_Purchases) AS Total_Purchases
FROM customer_data_formatted
WHERE Country = 'United States';

-- 13. What is the distribution of genders in the dataset?
SELECT gender, COUNT(Gender) As Gender_Count
FROM customer_data_formatted
GROUP BY Gender;

-- 14. Which customer has the highest annual income, and what is that income?
SELECT customer_id, annual_income
FROM customer_data_formatted
ORder BY annual_income DESC
LIMIT 1;

-- 15. How many customers are aged 30 or younger?
SELECT COUNT(Age) AS Age_30
FROM customer_data_formatted
WHERE Age <= 30;

-- 16. What is the average number of purchases for each gender?
SELECT gender, AVG(number_of_purchases) AS Avarage_Purchases_Gender
FROM customer_data_formatted
GROUP BY gender

-- 17. Which product category has the highest average annual income among customers who favor it?
SELECT favorite_product_category, AVG(annual_income) AS Avarage_Annual_Income
FROM customer_data_formatted
GROUP BY favorite_product_category
ORDER BY AVG(annual_income) DESC
Limit 1;

-- 18. How many customers have a satisfaction score above 7 and a subscription?
SELECT COUNT(customer_satisfaction_score) AS Number_of_Customers
FROM customer_data_formatted
WHERE customer_satisfaction_score > 7 and subscription = TRUE

-- 19. Which age group (under 30, 30-50, over 50) has the most customers?
SELECT CASE 
           WHEN Age < 30 THEN 'Under 30'
           WHEN Age BETWEEN 30 AND 50 THEN '30-50'
           WHEN Age > 50 THEN 'Over 50'
        END AS Age_Group, 
        COUNT(Customer_ID) AS Count
FROM customer_data_formatted
GROUP BY Age_Group
ORDER BY Count DESC;

-- 20. What is the average number of purchases made by customers from each country?
SELECT country, AVG(number_of_purchases) AS Avarage_Purchases
FROM customer_data_formatted
GROUP BY country

-- 21. How many customers have missing data in the Annual_Income column?
SELECT COUNT(Customer_ID) AS Missing_Income_Count
FROM customer_data_formatted
WHERE Annual_Income IS NULL;

-- 22. What percentage of customers with a subscription have a customer satisfaction score below 5?
SELECT (COUNT(Customer_ID) * 100.0 / (SELECT COUNT(Customer_ID) FROM customer_data WHERE Subscription = 1)) AS Percentage_Low_Satisfaction
FROM customer_data_formatted
WHERE Subscription = 1 AND Customer_Satisfaction_Score < 5;

-- 23. Which country has the most customers with a satisfaction score of 9 or higher?
SELECT Country, COUNT(Customer_ID) AS High_Satisfaction_Count
FROM customer_data_formatted
WHERE Customer_Satisfaction_Score >= 9
GROUP BY Country
ORDER BY High_Satisfaction_Count DESC
LIMIT 1;

-- 24 .What is the distribution of customer satisfaction scores for each product category?
SELECT favorite_product_category, COUNT(customer_satisfaction_score) AS Number_of_Scores, AVG(customer_satisfaction_score) AS Avarage_Score
FROM customer_data_formatted
GROUP BY favorite_product_category

-- 25. How many customers have made a purchase after January 1, 2022, and how many of them have a subscription?
SELECT 
      COUNT(Customer_ID) AS Total_Customers_After_2022,
      SUM(CASE WHEN Subscription = 1 THEN 1 ELSE 0 END) AS Subscribed_Customers
  FROM customer_data
  WHERE Purchase_Date > '2022-01-01';

-- 26. What is the average customer satisfaction score for each age group (under 30, 30-50, over 50)? 
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

-- 27. Identify the top 3 countries with the highest average annual income.
SELECT country, AVG(annual_income) AS Avarage_Income
FROM customer_data_formatted
GROUP BY country
ORDER BY Avarage_Income DESC
LIMIT 3;

-- 28. Find the average number of purchases made by customers who have a subscription, grouped by their favorite product category.
SELECT favorite_product_category, AVG(number_of_purchases) AS Avarage_Number_Purchases, COUNT(subscription ) AS Number_Subscriptions
FROM customer_data_formatted
WHERE subscription = TRUE
GROUP BY favorite_product_category;

-- 29. Determine the customers who have spent above the average annual income within their country.
WITH CountryAverageIncome AS (
    SELECT Country, AVG(Annual_Income) AS Average_Annual_Income
    FROM customer_data_formatted
    GROUP BY Country
)
SELECT c.Customer_ID, c.Country, c.Annual_Income
FROM customer_data_formatted c
JOIN CountryAverageIncome ca
ON c.Country = ca.Country
WHERE c.Annual_Income > ca.Average_Annual_Income;

-- 30. List the customers who have made more purchases than the average number of purchases made by customers in the same country.
WITH CountryAveragePurchases AS (
    SELECT Country, AVG(number_of_purchases) AS Average_Purchases
    FROM customer_data_formatted
    GROUP BY Country
)
SELECT c.Customer_ID, c.Country, c.Number_of_Purchases
FROM customer_data_formatted c
JOIN CountryAveragePurchases ca
ON c.Country = ca.Country
WHERE c.Number_of_Purchases > ca.Average_Purchases;

-- 31. Find the most popular product category among customers whose satisfaction score is above the average score for all customers.
WITH CustomerAverageScore AS (
    SELECT favorite_product_category, AVG(customer_satisfaction_score) AS Average_Score
    FROM customer_data_formatted
	GROUP BY favorite_product_category
)
SELECT c.favorite_product_category, SUM(c.customer_satisfaction_score) AS Sum_scores
FROM customer_data_formatted c
JOIN CustomerAverageScore ca
ON c.favorite_product_category = ca.favorite_product_category
WHERE c.customer_satisfaction_score > ca.Average_Score
GROUP BY c.favorite_product_category
ORDER BY Sum_scores DESC
Limit 1;

-- 32. Calculate the percentage of customers from each country who have a subscription.
SELECT Country, COUNT(CASE WHEN Subscription = True THEN 1 END) * 100.0 / COUNT(*) AS Subscription_Percentage
FROM customer_data_formatted
GROUP BY Country
ORDER BY Subscription_Percentage DESC;

-- 33. List the customers who have a satisfaction score higher than the average score within their favorite product category.
WITH AvgCategoryScore AS (
    SELECT 
        Favorite_Product_Category,
        AVG(Customer_Satisfaction_Score) AS Avg_Score
    FROM 
        customer_data_formatted
    GROUP BY 
        Favorite_Product_Category
)
SELECT 
    c.Customer_ID,
    c.Favorite_Product_Category,
    c.Customer_Satisfaction_Score
FROM 
    customer_data_formatted c
JOIN 
    AvgCategoryScore ac
ON 
    c.Favorite_Product_Category = ac.Favorite_Product_Category
WHERE 
    c.Customer_Satisfaction_Score > ac.Avg_Score
ORDER BY 
    c.Favorite_Product_Category, 
    c.Customer_Satisfaction_Score DESC;
    
-- 34. Identify the top 5 customers with the highest number of purchases in each country.
WITH RankedPurchases AS (
    SELECT 
        Customer_ID,
        Country,
        Number_of_Purchases,
        RANK() OVER (PARTITION BY Country ORDER BY Number_of_Purchases DESC) AS Purchase_Rank
    FROM 
        customer_data_formatted
)
SELECT 
    Customer_ID,
    Country,
    Number_of_Purchases
FROM 
    RankedPurchases
WHERE 
    Purchase_Rank <= 5
ORDER BY 
    Country, 
    Number_of_Purchases DESC;
    
-- 35. Find the average satisfaction score of customers who have an annual income above the average for their country and have a subscription.
WITH AvgIncomeByCountry AS (
    SELECT 
        Country,
        AVG(Annual_Income) AS Avg_Income
    FROM 
        customer_data_formatted
    GROUP BY 
        Country
)
SELECT 
    AVG(c.Customer_Satisfaction_Score) AS Avg_Satisfaction_Score
FROM 
    customer_data_formatted c
JOIN 
    AvgIncomeByCountry aic
ON 
    c.Country = aic.Country
WHERE 
    c.Annual_Income > aic.Avg_Income
    AND c.Subscription = True;
    
-- 36. List the product categories that have a higher average number of purchases compared to the overall average number of purchases across all categories.
WITH OverallAvgPurchases AS (
    SELECT 
        AVG(Number_of_Purchases) AS Overall_Avg_Purchases
    FROM 
        customer_data_formatted
),
CategoryAvgPurchases AS (
    SELECT 
        Favorite_Product_Category,
        AVG(Number_of_Purchases) AS Avg_Purchases
    FROM 
        customer_data_formatted
    GROUP BY 
        Favorite_Product_Category
)
SELECT 
    Favorite_Product_Category,
    Avg_Purchases
FROM 
    CategoryAvgPurchases
WHERE 
    Avg_Purchases > (SELECT Overall_Avg_Purchases FROM OverallAvgPurchases)
ORDER BY 
    Avg_Purchases DESC;
