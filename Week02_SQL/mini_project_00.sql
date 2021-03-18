-- For the Mini project
-- word doc comming soon

USE Northwind;

-- Exercise 1.1 [x] Using Northwind

SELECT * FROM Customers;

SELECT c.CustomerID AS "Customer ID",
CONCAT(c.City, ', ', c.Address, ' ', c.PostalCode) AS "Address",
c.CompanyName AS "Company Name"
FROM Customers c
WHERE c.City = 'Paris' OR c.City = 'London'; 

-- 1.2 [x]
SELECT * FROM Products;

SELECT * 
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%';

-- 1.3 as above, but with supplier name + country [x]
SELECT p.ProductName AS "Product Name",
p.ProductID AS "Product ID",
s.ContactName AS "Supplier Name",
s.Country AS "Country" 
FROM Products p INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
WHERE QuantityPerUnit LIKE '%bottle%';

-- 1.4
-- Categories and Products [x]
-- Count the number of products in each category
SELECT c.CategoryName,
COUNT(c.CategoryName) AS "No. of Products in Category"
FROM Categories c INNER JOIN Products p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;


-- 1.5 [x]
SELECT e.TitleOfCourtesy + ' ' + e.FirstName + ' ' + e.LastName AS "Employee Name",
e.City
FROM Employees e
WHERE e.Country = 'UK';

-- 1.6 [] -  rows
-- Territories, EmployeeTerritories, Employees, Orders, [Order Details]
-- Sales total for all sales regions > 1,000,000 (round or format to present numbers)

SELECT t.RegionID,
COUNT(t.RegionID) AS "No. of Orders per Region"
FROM Territories t INNER JOIN EmployeeTerritories et
ON t.TerritoryID = et.TerritoryID INNER JOIN Employees e
ON et.EmployeeID = e.EmployeeID INNER JOIN Orders o
ON e.EmployeeID = o.EmployeeID INNER JOIN [Order Details] od
ON o.OrderID = od.OrderID
GROUP BY t.RegionID;

SELECT DISTINCT RegionID FROM Territories;

-- 1.7 [x]

SELECT COUNT(Freight) AS "No. Orders with freights > 100.00 from USA or UK"
FROM Orders
WHERE Freight > 100.00
AND (ShipCountry = 'USA' OR ShipCountry = 'UK');

-- 1.8 [x]

SELECT TOP 1 OrderId,
MAX(ROUND((UnitPrice * Quantity) * Discount, 2)) AS "Greatest Discounted"
FROM [Order Details]
GROUP BY OrderID
ORDER BY "Greatest Discounted" DESC;

-- []

CREATE DATABASE dunni_db;

USE dunni_db;

-- Execise 2.1 [x]
CREATE TABLE spartans_table
(
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    university_attended VARCHAR(30),
    course_taken VARCHAR(30),
    grade_achieved CHAR(3),
    training_stream VARCHAR(10)
)

-- Execise 2.2 [x]
INSERT INTO spartans_table
VALUES
('Dunni',
'A',
'A London Uni',
'Comupter Science',
'2:2',
'DevOps'),
('Kekkers',
'Peppers',
'A London Uni',
'Maths',
'2:1',
'DevOps')

SELECT * FROM spartans_table;

-- EX 3

USE Northwind;

-- 3.1 [x]

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS "Employee",
    CONCAT(m.FirstName, ' ', m.LastName) AS "Managers"
FROM Employees e LEFT JOIN Employees m
ON e.ReportsTo = m.EmployeeID;

-- 3.2 []


-- 3.3 []
