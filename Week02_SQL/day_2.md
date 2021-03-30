# Unedited notes for day 2
There are a few empty tables and missing definitions

### Null and Default

**Null** does not equate to nothing - it doesn't equal zero and isn't even equal to an empty string. Null is just an undefined value. Nothing is equal to it. (Not even Null == Null, as it is *literally an **undefined value***)

By using NOT NULL one can force a table not to accept empty fields for that column:

```sql
CREATE TABLE film_table(
film_name VARCHAR(10) NOT NULL,
film_type VARCHAR(6) NOT NULL);
```

Since you can't equate to *Null* you have to filter using IS *NULL* or IS NOT *NULL* 

```sql
SELECT CompanyName AS 'Company Name', City + ', ' + Country AS 'City'
FROM Customers
WHERE Region IS NULL
```

### Database Considersations

- Data Security - How do we keep confidential data confidential?
- Data Recovery - How do we recover data when something goes wrong?
- Data Integrity - How do we make sure the data is as it should be?
- Normal Form - Normalisation. (Upto the 3rd normal form) These are the design rules

---

**Normal Form**

*Normalisation -* This is a database design technique that reduces data redundancy and undesirable characteristics like Insertion, Update and Deletion anomalies. Normal form is meant to eliminate redundancy and allow for a logical way of storing data.

### First Normal Form

A database is in First Normal Form when the following conditions are met:

- Make everything atomic. That is, each cell should contain a single item
- No repeating groups (no 'colour_1, colour_2')

[Example]

[product_table - Not in 1NF](https://www.notion.so/1b85ffe0b9e44c188d8e8962c721965b)

### Second Normal Form

A database is in Second Normal For when the following conditions are met:

- It is in 1NF
- There needs to be a single column primary key (no composite key)

[Example]

[table_purchase_detail - Not in 2NF](https://www.notion.so/cb160411d4d64cc098d6b83af0f05860)

### Third Normal Form

A database is in Third Normal Form when the following conditions are met:

- It is in 2NF
- There is no transitive functional dependencies. That is, no changes in a non-key colmun should cause any other non-key columns to change

[Example]

[table_book_detail - Not in 3NF](https://www.notion.so/a1799f31e81d4fda8ffb459ebaab1001)

### Why do I need to know SQL?

Disaster recovery, [more examples...]

## QUERYING AN SQL DATABASE

Apostrophes —> ' are a reserved character in SQL. I need to use them in the correct places

```sql
-- this doesn't work
-- '7 King's Way'

-- do this instead
'7 King''s Way'
```

" - Referring to the name of something

' - Contaning text

### Operators

<> or != - Not equal to

>

<

<=

>=

SELECT **DISTINCT**

- If you want to remove duplicates from your data

- The more columns you select, the less likely you are to need DISTINCT

BETWEEN

- For finding data *between* a range

### Arithmetic Operators

+ Add (can be used on DATETIME columns)

- Subtract (as above)

* Multiply

/ Divide  

% Modulo

```sql
SELECT UnitPrice, Quantity, Discount,
	UnitPrice * Quantity AS "Gross Total"
FROM [Order Details]
-- Square brackets for tables with spaces in the name. Spaces really aren't a good idea
-- Another, different example

SELECT UnitPrice, Quantity, Discount,
    UnitPrice * Quantity AS "Gross Total",
	(UnitPrice * Quantity) * (1 - Discount) AS "Net Total"
FROM [Order Details]
```

### Sorting

ORDER BY - Ascending (ASC) by default

Need to add DESC to make it descending

```sql
SELECT UnitPrice, Quantity, Discount,
UnitPrice * Quantity AS "Gross Total" -- newline for readability
FROM [Order Details]
ORDER BY "Gross Total" DESC

-- another example
SELECT TOP 2 UnitPrice, Quantity, Discount, UnitPrice * Quantity AS "Gross Total",
 (UnitPrice * Quantity) * (1 - Discount) AS "Total Price"
FROM [Order Details]
ORDER BY 5 DESC
```

### String Functions

The following can be used to manipulate text in the SELECT clause:

SUBSTRING(col, start, len) - 

CHARINDEX(char, col) - Returns the index of the first occurence of the string.  

LEFT/RIGHT(col, start) - 

RTRIM/LTRIM(col) - 

TRIM(col) -

LEN(col) -

UPPER/LOWER(col) -

REPLACE(col, original_string, replacement) -

In SQL, indexing starts from 1!

```sql
SELECT PostalCode "Post Code",
LEFT (PostalCode, CHARINDEX(' ', PostalCode) - 1) AS "Postal Cose Region",
	CHARINDEX(' ', PostalCode) As "Space Found", Country
FROM Customers
WHERE Country='UK'
```

```sql
-- These do the same thing
SELECT ProductName FROM Products
WHERE ProductName LIKE '%''%' -- the first ' is an escape character

-- got stuck here
SELECT ProductName FROM Products
WHERE CHARINDEX('''', ProductName) != 0; -- 
```

### Processing Order

- This is different to the **Logical** order in which the clauses are written.

**FROM**

**WHERE**

**GROUP BY**

**HAVING**

**SELECT** - Can only use column aliasing from here

**DISTINCT**

**ORDER BY**

### Date Functions

GETDATE -

SYSTEMDATETIME - 

DATEADD([tag], [value], [column]) - Adds [value] to either the day, month, or year, depending on the tag

DATEDIFF([tag], [column_1], [column_2]) - Calculates the difference between dates

YEAR([column]) - Extracts the year from the date

MONTH([column]) - Extracts the month from the date

DAY([column]) - Extracts the day from the date

CASE STEATMENTS

```sql
SELECT CASE
WHEN DATEDIFF(d, OrderDate, ShippedDate) < 10 THEN 'On Time'
ELSE 'Overdue' -- column data gets single quotes
END AS "Status" -- column names get double quotes
FROM Orders;

SELECT CASE
WHEN DATEDIFF(yy, BirthDate, GETDATE()) > 65 THEN 'Retired'
WHEN DATEDIFF(yy, BirthDate, GETDATE()) > 60 THEN 'Retirement Due'
ELSE 'More than 5 years to go'
END AS "Retirement"
FROM Employees;
```

WHEN is like 'if' in other languages - You need to use it if you have conditions
