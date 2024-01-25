SELECT * FROM Customers
WHERE Country = 'Spain'
AND CustomerName LIKE 'R%' OR CustomerName LIKE 'B%';

--------------------------------
-- starts with R or B example --
--------------------------------


--------------------------------
-- Count of Customers by Country --
--------------------------------
SELECT Country, COUNT(*) as CustomerCount
FROM Customers
GROUP BY Country;


--------------------------------
-- Customers from Spain or Germany --
--------------------------------
SELECT * FROM Customers
WHERE Country IN ('Spain', 'Germany');


--------------------------------
-- Customers ordered by name --
--------------------------------
SELECT * FROM Customers
ORDER BY CustomerName;


--------------------------------
-- Join Customers and Orders tables --
--------------------------------
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


--------------------------------
-- Average quantity in Orders --
--------------------------------
SELECT AVG(Quantity) as AverageQuantity
FROM Orders;
