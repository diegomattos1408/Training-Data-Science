SELECT * FROM customer_data

/* Distincts */
SELECT DISTINCT Gender FROM customer_data
SELECT DISTINCT Country FROM customer_data
SELECT DISTINCT Favorite_Product_Category FROM customer_data

/* Create a view replacing the wrong values */
/* Format to the correct words the columns abobe */
CREATE VIEW customer_data_formatted AS
WITH medians AS (
    SELECT 
        (SELECT Age FROM synthetic_customer_data 
         WHERE Age IS NOT NULL 
         ORDER BY Age 
         LIMIT 1 
         OFFSET (SELECT COUNT(*) FROM synthetic_customer_data WHERE Age IS NOT NULL) / 2) AS Age_Median,
        (SELECT Annual_Income FROM synthetic_customer_data 
         WHERE Annual_Income IS NOT NULL 
         ORDER BY Annual_Income LIMIT 1 
         OFFSET (SELECT COUNT(*) FROM synthetic_customer_data WHERE Annual_Income IS NOT NULL) / 2) AS Annual_Income_Median,
        (SELECT Customer_Satisfaction_Score FROM synthetic_customer_data 
         WHERE Customer_Satisfaction_Score IS NOT NULL 
         ORDER BY Customer_Satisfaction_Score LIMIT 1 
         OFFSET (SELECT COUNT(*) FROM synthetic_customer_data WHERE Customer_Satisfaction_Score IS NOT NULL) / 2) AS Customer_Satisfaction_Score_Median
)
SELECT 
       customer_id,
       number_of_purchases,
       
       COALESCE(Age, (SELECT Age_Median FROM medians)) AS age,
       
       CASE
           WHEN Gender = 'M' THEN 'Male'
           WHEN Gender = 'F' THEN 'Female'
           ELSE Gender
       END AS gender,

       CASE
           WHEN Country = 'US' THEN 'United States'
           WHEN Country = 'USA' THEN 'United States'
           WHEN Country = 'UK' THEN 'United Kingdom'
           WHEN Country = 'GER' THEN 'Germany'
           WHEN Country = 'CAN' THEN 'Canada'
           ELSE Country
       END AS country,

       ROUND(COALESCE(Annual_Income, (SELECT Annual_Income_Median FROM medians)), 2) AS annual_income, 

       CASE
           WHEN Favorite_Product_Category = 'Automtoive' THEN 'Automotive'
           WHEN Favorite_Product_Category = 'Boks' THEN 'Books'
           WHEN Favorite_Product_Category = 'Clthng' THEN 'Clothing'
           WHEN Favorite_Product_Category = 'Electonics' THEN 'Electronics'
           WHEN Favorite_Product_Category = 'Toyz' THEN 'Toys'
           ELSE Favorite_Product_Category
       END AS favorite_product_category,
       
       Purchase_Date, 

       COALESCE(Customer_Satisfaction_Score, (SELECT Customer_Satisfaction_Score_Median FROM medians)) AS Customer_Satisfaction_Score, 
       
       CASE
           WHEN Subscription = 1 THEN TRUE
           WHEN Subscription = 0 THEN FALSE
           ELSE NULL  -- In case of any unexpected values
       END AS subscription
       
FROM synthetic_customer_data
WHERE Purchase_Date is not NULL;

SELECT * FROM customer_preferences_view

CREATE VIEW customer_preferences_view AS
SELECT 
    Customer_ID,
    Marital_Status,
    Employment_Status,
    Education_Level,
    Preferred_Communication_Channel
FROM 
    customer_preferences;
    
DROP VIEW IF EXISTS customer_data_formatted;


