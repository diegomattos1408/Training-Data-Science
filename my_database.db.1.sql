-- 1. List Customers with their Favorite Product Category and Preferred Communication Channel:
SELECT cd.Customer_ID, cd.Favorite_Product_Category, cp.Preferred_Communication_Channel
FROM customer_data_formatted cd
JOIN customer_preferences cp
ON cd.Customer_ID = cp.Customer_ID;

-- 2. Find the Average Satisfaction Score by Employment Status:
SELECT AVG(cd.customer_satisfaction_score) AS Avarage_Satisfaction_Score, cp.employment_status
FROM customer_data_formatted cd
JOIN customer_preferences cp
ON cd.Customer_ID = cp.Customer_ID
GROUP by cp.Employment_Status;

-- 3. Identify Customers with a PhD who Have More Than 50 Purchases:
SELECT cd.Customer_ID, SUM(cd.Number_of_Purchases) AS Total_Purchases, cp.Education_Level
FROM customer_data_formatted cd
JOIN customer_preferences cp
ON cd.Customer_ID = cp.Customer_ID
WHERE cp.Education_Level = 'PhD'
GROUP BY cd.Customer_ID, cp.Education_Level
HAVING SUM(cd.Number_of_Purchases) > 50;

-- 4. Count the Number of Married Customers Who Prefer Social Media as a Communication Channel:
SELECT COUNT(Marital_Status) AS Count_Marital_Status, Preferred_Communication_Channel
FROM customer_preferences
WHERE Preferred_Communication_Channel = 'Social Media'
GROUP BY Preferred_Communication_Channel;

-- 5. Analyze the Relationship Between Marital Status and Subscription:
SELECT 
    Marital_Status,
    COUNT(CASE WHEN Subscription = True THEN 1 END) AS Subscribed_Customers,
    COUNT(CASE WHEN Subscription = False THEN 1 END) AS Non_Subscribed_Customers,
    COUNT(*) AS Total_Customers,
    (COUNT(CASE WHEN Subscription = True THEN 1 END) * 100.0 / COUNT(*)) AS Subscription_Percentage
FROM 
    customer_preferences cp
JOIN 
    customer_data_formatted cd 
ON 
    cp.Customer_ID = cd.Customer_ID
GROUP BY 
    Marital_Status;