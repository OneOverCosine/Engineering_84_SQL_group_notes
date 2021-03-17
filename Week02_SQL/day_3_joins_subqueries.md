JOIN is an SQL keyword that allows you to combine matched row from two or more tables.

It lets you create a list of combined rows of matching data from different tables

**INNER JOIN**

- 

```sql
SELECT student.name, course
FROM student
INNER JOIN course
ON student.course = course.id;
-- would have been better to use aliasing

-- Another example
SELECT * FROM student s INNER JOIN course c
ON s.course_id = c.c_id;

-- Multiple joins
SELECT o.CustomerID, o.EmployeeID FROM Orders o INNER JOIN [Order Details] od
ON o.OrderID = od.OrderID INNER JOIN Products p
ON od.ProductID = p.ProductID INNER JOIN Categories c
ON p.CategoryID = c.CategoryID;
```

**LEFT JOIN**

- Everything from the left + matches from the right table.

- Any left rows with no matching data from the right will be *Null*

```sql
SELECT * FROM students s LEFT JOIN course c
ON s.course_id = c.c_id;
```

**RIGHT JOIN**

- As above, but from the right instead

```sql
SELECT * FROM students s RIGHT JOIN course c
ON s.course_id = c.c_id;
```

**FULL JOIN**

- Everything from the left *and* right.

- anything from the left with no right matches returns *Null*
- anything from the right with no left matches returns *Null*

```sql
SELECT * FROM student s FULL JOIN course c
ON s.course_id = c.c_id;
```

**EXAMPLE -** Answer to a question we worked on

```sql
SELECT p.SupplierID AS "Supplier ID", s.CompanyName AS "Company Name",
AVG(p.UnitsOnOrder) AS "Avg Units on Order"
FROM Products p INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
GROUP BY p.SupplierID, s.CompanyName; -- grouping works on similar data
```

**OUTER JOIN**

LEFT and RIGHT are types of OUTER JOINs

**Chaining JOINs**

- You can chain multiple tables together

```sql
-- Join all columns from Orders, OrderDetails, Products, and Categories
-- orderID --> productID --> categoryID

SELECT o.CustomerID, o.EmployeeID FROM Orders o INNER JOIN [Order Details] od
ON o.OrderID = od.OrderID INNER JOIN Products p
ON od.ProductID = p.ProductID INNER JOIN Categories c
ON p.CategoryID = c.CategoryID;
```

## Subqueries

- Simply a query within another query

- A nested query inside another SELECT statement

- The inner query runs before the outer query does!

```sql
SELECT CompanyName AS "Customer"
FROM Customers
WHERE CustomerID NOT IN
	(SELECT CustomerID FROM Orders);

-- as above, but with JOINS
SELECT c.CompanyName AS "Customer"
FROM Customers c FULL JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;
```

Example using a row/column

```sql
SELECT OrderID, ProductID, UnitPrice, Quantity, Discount,
(SELECT MAX(UnitPrice) FROM [Order Details] od) AS "Max Price"
FROM [Order Details];
```

Subquery as a table

```sql
SELECT od.ProductID, sq1.totalamt AS "Total Sold for this Product",
UnitPrice, UnitPrice/totalamt*100 AS "% of Total"
	FROM [Order Details] od
	INNER JOIN
			(SELECT ProductID, SUM(UnitPrice * Quantity) AS totalamt
			FROM [Order Details]
			GROUP BY ProductID) sq1
	ON sq1.ProductID = od.ProductID; 
```

A contrived example to show how one could list all Employee IDS in the same column as Supplier IDs

```sql
SELECT EmployeeID AS "Employee/Supplier"
FROM Employees
UNION ALL
SELECT SupplierID
FROM Suppliers;
```

UNION ALL returns 38 rows while UNION removes duplicates and returns 29 rows

Both SELECT statements must have the same number of columns in the SELECT clause (and be of the same type)

Only the column alias in the first SELECT will be applied

ORDER BY 1 may be appropriate be used if the column names differ
