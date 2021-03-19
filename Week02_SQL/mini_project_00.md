## Exercise 1 – Northwind Queries

### 1.1 Write a query that lists all Customers in either Paris or London. Include Customer ID, Company Name and all address fields.

```SQL
USE Northwind;

-- Exercise 1.1 [x] Using Northwind

SELECT * FROM Customers;

SELECT c.CustomerID AS "Customer ID",
CONCAT(c.City, ', ', c.Address, ' ', c.PostalCode) AS "Address",
c.CompanyName AS "Company Name"
FROM Customers c
WHERE c.City = 'Paris' OR c.City = 'London';
``` 

### 1.2 List all products stored in bottles.

``` SQL
-- 1.2 [x]
SELECT * FROM Products;

SELECT * 
FROM Products
WHERE QuantityPerUnit LIKE '%bottle%';
```

### 1.3 Repeat question above, but add in the Supplier Name and Country.

``` SQL
-- 1.3 as above, but with supplier name + country [x]
SELECT p.ProductName AS "Product Name",
p.ProductID AS "Product ID",
s.ContactName AS "Supplier Name",
s.Country AS "Country" 
FROM Products p INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
WHERE QuantityPerUnit LIKE '%bottle%';
```

### 1.4 Write an SQL Statement that shows how many products there are in each category. Include Category Name in result set and list the highest number first.

``` SQL
-- 1.4
-- Categories and Products [x]
-- Count the number of products in each category
SELECT c.CategoryName,
COUNT(c.CategoryName) AS "No. of Products in Category"
FROM Categories c INNER JOIN Products p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;
```

### 1.5 List all UK employees using concatenation to join their title of courtesy, first name and last name together. Also include their city of residence.

``` SQL
-- 1.5 [x]
SELECT e.TitleOfCourtesy + ' ' + e.FirstName + ' ' + e.LastName AS "Employee Name",
e.City
FROM Employees e
WHERE e.Country = 'UK';
```

### 1.6 List Sales Totals for all Sales Regions (via the Territories table using 4 joins) with a Sales Total greater than 1,000,000. Use rounding or FORMAT to present the numbers.

``` SQL
-- 1.6 [x] -  rows
-- Territories, EmployeeTerritories, Employees, Orders, [Order Details]
-- Sales total for all sales regions > 1,000,000 (round or format to present numbers)

SELECT r.RegionID, ROUND(SUM((od.Quantity * od.UnitPrice) * (1 - od.Discount)), 2) AS "Total Price"
FROM [Order Details] od INNER JOIN Orders o
ON od.OrderID = o.OrderID INNER JOIN Employees e
ON o.EmployeeID = e.EmployeeID INNER JOIN EmployeeTerritories et
ON e.EmployeeID = et.EmployeeID INNER JOIN Territories t
ON et.TerritoryID = t.TerritoryID INNER JOIN Region r
ON t.RegionID = r.RegionID
GROUP BY r.RegionID
HAVING ROUND(SUM((od.Quantity * od.UnitPrice) * (1 - od.Discount)), 2) > 1000000;
```


### 1.7 Count how many Orders have a Freight amount greater than 100.00 and either USA or UK as Ship Country.

``` SQL
-- 1.7 [x]

SELECT COUNT(Freight) AS "No. Orders with freights > 100.00 from USA or UK"
FROM Orders
WHERE Freight > 100.00
AND (ShipCountry = 'USA' OR ShipCountry = 'UK');
```

### 1.8 Write an SQL Statement to identify the Order Number of the Order with the highest amount(value) of discount applied to that order.

``` SQL
-- 1.8 [x]

SELECT TOP 1 OrderId,
MAX(ROUND((UnitPrice * Quantity) * Discount, 2)) AS "Greatest Discount"
FROM [Order Details]
GROUP BY OrderID
ORDER BY "Greatest Discount" DESC;
```

## Exercise 2 – Create Spartans Table

### 2.1 Write the correct SQL statement to create the following table:  
Spartans Table – include details about all the Spartans on this course. Separate Title, First Name and Last Name into separate columns, and include University attended, course taken and mark achieved. Add any other columns you feel would be appropriate. 

``` SQL
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
);
```

### 2.2 Write SQL statements to add the details of the Spartans in your course to the table you have created.

``` SQL
-- Execise 2.2 [x]
INSERT INTO spartans_table
VALUES
('Dunni',
'Adebusuyi',
'Goldsmiths',
'Comupter Science',
'2:2',
'DevOps'),
('Kekkers',
'Peppers',
'A London Uni',
'Maths',
'2:1',
'DevOps');
```



## Exercise 3 – Northwind Data Analysis linked to Excel

### 3.1 List all Employees from the Employees table and who they report to. No Excel required. Please mention the Employee Names and the ReportTo names. 

``` SQL
-- EX 3

USE Northwind;

-- 3.1 [x]

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS "Employee",
    CONCAT(m.FirstName, ' ', m.LastName) AS "Managers"
FROM Employees e LEFT JOIN Employees m
ON e.ReportsTo = m.EmployeeID;
```

### 3.2 List all Suppliers with total sales over $10,000 in the Order Details table. Include the Company Name from the Suppliers Table and present as a bar chart as below. (Worksheet had a bar chart pictured)

``` SQL
-- 3.2 [x]

-- ALL sales for each Supplier
-- Supplier --> Products --> Order Details
SELECT s.CompanyName AS "Suppliers",
    ROUND(SUM((od.Quantity * od.UnitPrice) * (1 - od.Discount)), 2) AS "Total Sales"
FROM Suppliers s INNER JOIN Products p
ON s.SupplierID = p.SupplierID INNER JOIN [Order Details] od
ON p.ProductID = od.ProductID
GROUP BY s.CompanyName
HAVING ROUND(SUM((od.Quantity * od.UnitPrice) * (1 - od.Discount)), 2) > 10000;
```

### 3.3 List the Top 10 Customers YTD for the latest year in the Orders file. Based on total value of orders shipped. No Excel required.

### 3.4 Plot the Average Ship Time by month for all data in the Orders Table using a line chart as below. (Worksheet had a line chart pictured)

I did not fully complete 3.2, 3.3, or 3.4 in time

``` SQL
-- 3.3 [], YTD - Year to date?
-- Order Details --> Orders --> Customers

-- 3.4 []
```
