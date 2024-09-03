-- Identify the top 3 countries with the highest average annual income.
SELECT country, AVG(annual_income) AS Avarage_Income
FROM customer_data_formatted
GROUP BY country
ORDER BY Avarage_Income DESC
LIMIT 3;

-- Find the average number of purchases made by customers who have a subscription, grouped by their favorite product category.
SELECT favorite_product_category, AVG(number_of_purchases) AS Avarage_Number_Purchases, COUNT(subscription ) AS Number_Subscriptions
FROM customer_data_formatted
WHERE subscription = TRUE
GROUP BY favorite_product_category;

-- Determine the customers who have spent above the average annual income within their country.
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

-- List the customers who have made more purchases than the average number of purchases made by customers in the same country.
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

-- Find the most popular product category among customers whose satisfaction score is above the average score for all customers.
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

-- Calculate the percentage of customers from each country who have a subscription.
SELECT Country, COUNT(CASE WHEN Subscription = True THEN 1 END) * 100.0 / COUNT(*) AS Subscription_Percentage
FROM customer_data_formatted
GROUP BY Country
ORDER BY Subscription_Percentage DESC;

-- List the customers who have a satisfaction score higher than the average score within their favorite product category.
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
    
-- Identify the top 5 customers with the highest number of purchases in each country.
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
    
-- Find the average satisfaction score of customers who have an annual income above the average for their country and have a subscription.
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
    
-- List the product categories that have a higher average number of purchases compared to the overall average number of purchases across all categories.
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
