# SQL COMMANDS

This is a work in progress - Basically copying what I've got in Notion into here

## DML COMMANDS

### SELECT

Anything I want to display goes in this clause

```sql
SELECT [options] FROM table_name
...

-- ====================

SELECT [options] AS [display_name] FROM table_name
...
```

- **KEYWORDS**

    **TOP**

    **AND**

### INSERT

```sql
INSERT INTO table_name
(col_name, col_name...)
VALUES
(col1_val, col2_val...),
...
(col1_val, col2_val);
```

### UPDATE

```sql
UPDATE table_name
SET col1 = val1, col2 = val2, ...
WHERE condition; -- if this isn't added, ALL records will be updated
```

### DELETE

```sql
DELETE FROM table_name
	WHERE item=value
```

## DDL COMMANDS

### CREATE

### ALTER

### DROP

### TRUNCATE

## DCL COMMANDS

### GRANT

### REVOKE

## TCL COMMANDS

### COMMIT

### ROLLBACK

### SAVEPOINT

## Others

### BETWEEN

- Selects values within a given range

```sql
SELECT *
FROM EmployeeTerritories
WHERE TerritoryID BETWEEN val1 AND val2;
```

### GROUP BY

- Rather than grouping all the results together, we can display the reults by a specific attribute

```sql
SELECT COUNT(*) AS "Orders from employees No. 5 and 7" FROM Orders
WHERE EmployeeID IN (5, 7)
GROUP BY EmployeeID
```

### WHERE

- Used to filter data

```sql
SELECT * FROM table_name
	WHERE column=data
```

### Aliasing

```sql

-- This is table aliasing
SELECT * FROM film_table
    WHERE f.film_type='Animation'
-- ========================================
-- This is column aliasing
SELECT COUNT(*) AS "No. of Employees staying in London" FROM Employees e
    WHERE e.city='London'
```

### COUNT()

## WILDCARDS

Wildcards can be used as a substitute for any other character in a string when using the **LIKE** operator. You can't use the '=' sign. (NO error was thrown, but nothing was returned)

- % - A substitute for 0 or more characters
- _ - A substitute for a single character. The following matches any regions ending in 'A' (this isn't case sensitive)

    ```sql
    SELECT *
    FROM Customers WHERE Region LIKE '_A'
    ```

[charlist] - Sets and ranges of characters to macth, i.e. **LIKE** [ABC]% | This will return anything starting with any of those characters

[^charlist] - Sets and ranges of characters that don't match, i.e. **LIKE** | This will return anythin that *doesn't* start eith any of those characters

### CONCAT() - Concatenation

```sql
-- using double quotes for the name of something
SELECT CompanyName AS "Company Name",
    City + ', ' + Country AS "City"
FROM Customers

-- another method
SELECT CONCAT(firstName, lastName) AS "Employee Name" FROM Employees

-- same as above
SELECT FirstName + ' ' + LastName AS "Employee Name" FROM Employees
```

### ========== Not Required Yet ==========

### UNSIGNED

### UNIQUE

### CHECK

### INDEX
