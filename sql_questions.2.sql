CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Country VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers (CustomerID, CustomerName, Country)
VALUES 
(1, 'Alice', 'USA'),
(2, 'Bob', 'Canada'),
(3, 'Charlie', 'UK'),
(4, 'David', 'Australia'),
(5, 'Eva', 'USA');

INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount)
VALUES 
(101, 1, '2024-08-01', 250.00),
(102, 3, '2024-08-03', 450.00),
(103, 1, '2024-08-04', 120.00),
(104, 4, '2024-08-06', 800.00),
(105, 5, '2024-08-07', 150.00),
(106, 6, '2024-08-08', 300.00);

-- 1. Inner Join: Retrieve the list of customers who have placed an order. What are their names, order IDs, and order amounts?
SELECT c.CustomerName, o.OrderID, o.Amount
FROM Customers c 
INNER JOIN Orders o

-- 2. Left Join: Get a list of all customers, including those who have not placed any orders. Show their names, order dates, and amounts if available.
select c.CustomerName, o.OrderDate, o.Amount 
FROM Customers c 
LEFt JOIN Orders o 

-- 3. Right Join: Get a list of all orders, including those placed by customers not listed in the Customers table. Display the customer name and order amount.
select c.CustomerName, o.Amount 
FROM Customers c 
RIGHT JOIN Orders o 

-- 4. Full Outer Join: Retrieve all customers and all orders, regardless of whether the customer has placed an order or the order has a matching customer in the Customers table.
SELECT c.CustomerName, o.OrderID
FROM Customers c
FULL OUTER JOIN Orders o 
ON c.CustomerID = o.CustomerID;

-- 5. Self Join: Using the Customers table, find pairs of customers from the same country. What are the customer names?
SELECT c1.CustomerName AS Customer1, c2.CustomerName AS Customer2, c1.Country
FROM Customers c1
JOIN Customers c2
ON c1.Country = c2.Country
AND c1.CustomerID < c2.CustomerID;

-- 6. Cross Join: How many unique combinations of customers and orders can be created by joining these two tables without any condition?
SELECT COUNT(*) AS TotalCombinations
FROM Customers c
CROSS JOIN Orders o;

-- 7. Group By with Join: Find the total amount of orders placed by each customer. What is the total amount for each customer name?
SELECT c.Country, SUM(o.Amount) as Total_Orders
FROM Customers c 
JOIN Orders o 
GROUP BY country

-- 8. Join with Condition: Retrieve orders placed by customers from the USA only. What are the order IDs and amounts?
SELECT c.Country, o.OrderID, o.Amount
FROM Customers c 
JOIN Orders o 
ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'

-- 9. Join and Filter: Find all orders placed in August 2024 along with the customer names. Which orders were placed?
SELECT c.CustomerName, o.OrderID, o.OrderDate, o.Amount
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderDate BETWEEN '2024-08-01' AND '2024-08-31'

-- 10. Join with Aggregation: Get the average order amount for customers from each country. What is the average order amount for customers from the USA?
SELECT c.Country, AVG(o.Amount) AS AverageOrderAmount
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.Country
HAVING c.Country = 'USA';

-- 11. Retrieve the total number of orders placed by customers from each country. What is the total number of orders for customers from Canada?
SELECT SUM(o.Amount), c.Country
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.Country
HAVING c.Country = 'Canada'

-- 12. Find the maximum order amount placed by any customer from each country. What is the maximum order amount from customers in the UK?
SELECT MAX(o.Amount) AS MaxAmount, c.Country
FROM Customers c 
JOIN Orders o 
GROUP BY c.Country 
HAVING c.Country = 'UK'

-- 13. Identify the customers who have placed more than one order. What are their names and how many orders have they placed?
SELECT c.CustomerName, COUNT(o.OrderID) AS OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
HAVING COUNT(o.OrderID) > 1;

-- 14. Calculate the total revenue generated from orders by customers from each country. What is the total revenue from customers in Australia?
SELECT c.Country, SUM(o.Amount) AS TotalRevenue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Country
HAVING c.Country = 'Australia';

-- 15. Get the total order amount for each customer from each country. How much has each customer from the USA spent?
SELECT c.Country, c.CustomerName, SUM(o.Amount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.Country, c.CustomerName
HAVING c.Country = 'USA';

-- 16. List Customers with their Favorite Product Category and Preferred Communication Channel:
SELECT cd.Customer_ID, cd.Favorite_Product_Category, cp.Preferred_Communication_Channel
FROM customer_data_formatted cd
JOIN customer_preferences cp
ON cd.Customer_ID = cp.Customer_ID;

-- 17. Find the Average Satisfaction Score by Employment Status:
SELECT AVG(cd.customer_satisfaction_score) AS Avarage_Satisfaction_Score, cp.employment_status
FROM customer_data_formatted cd
JOIN customer_preferences cp
ON cd.Customer_ID = cp.Customer_ID
GROUP by cp.Employment_Status;

-- 18. Identify Customers with a PhD who Have More Than 50 Purchases:
SELECT cd.Customer_ID, SUM(cd.Number_of_Purchases) AS Total_Purchases, cp.Education_Level
FROM customer_data_formatted cd
JOIN customer_preferences cp
ON cd.Customer_ID = cp.Customer_ID
WHERE cp.Education_Level = 'PhD'
GROUP BY cd.Customer_ID, cp.Education_Level
HAVING SUM(cd.Number_of_Purchases) > 50;

-- 19. Count the Number of Married Customers Who Prefer Social Media as a Communication Channel:
SELECT COUNT(Marital_Status) AS Count_Marital_Status, Preferred_Communication_Channel
FROM customer_preferences
WHERE Preferred_Communication_Channel = 'Social Media'
GROUP BY Preferred_Communication_Channel;

-- 20. Analyze the Relationship Between Marital Status and Subscription:
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
