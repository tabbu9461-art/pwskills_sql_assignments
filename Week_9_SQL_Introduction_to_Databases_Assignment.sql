 -- 1 – Introduction to SQL and Basic Queries
-- Objective: Understand the basic concepts of SQL and perform basic queries.

-- Task 1: Setup a Database
-- Install MySQL or PostgreSQL.
 -- Create a database named company_db.
 
 -- Task 2: Create a Table
-- Create a table employees with the following columns:
-- id (INTEGER, Primary Key)
-- first_name (VARCHAR)
-- last_name (VARCHAR)
-- department (VARCHAR)
-- salary (INTEGER)

Create Table Employees(
Id Integer Primary Key,
Frist_name Varchar (50),
Last_name Varchar (50),
Department Varchar (50),
Salary Integer
);

-- Task 3: Insert Data
-- Insert at least 5 records into the Employees table.

Insert Into Employees
 Values
(1, 'Rahul', 'Sharma', 'Sales', 60000),
(2, 'Riya','Singh', 'HR', 45000),
(3, 'Anmol', 'Varma', 'IT', 70000),
(4, 'Neha','Gupta', 'Sales', 52000),
(5, 'Rohan', 'Mehta', 'Finance', 48000);

-- Task 4: Basic SELECT Query
-- Retrieve all data from the employees table.

Select * from Employees;

-- 2 – Filtering Data Using WHERE Clause
-- Objective: Learn how to filter data using the WHERE clause.

-- Task 1: Basic Filtering
-- Write a query to retrieve all Employees from the Sales department.

Select * from Employees
where department = 'Sales';

-- Task 2: Comparison Operators
-- Write a query to find Employees with a salary greater than 50000.

Select * from
Employees
Where Salary > 50000;

-- Task 3: Logical Operators (AND, OR)
-- Retrieve all Employees from the Sales department and whose salary is greater than 50000.

Select * from Employees
Where Department  = 'Sales'
And Salary > 50000;

-- Task 4: DISTINCT Keyword
-- Retrieve a list of unique departments from the employees table.

Select Distinct Department
from Employees;

-- 3 – Modifying Data (INSERT, UPDATE, DELETE)
-- Objective: Understand how to modify data.

-- Task 1: Inserting Multiple Rows
-- Insert 3 more Employees into the employees table using a single INSERT statement.

Insert Into Employees Values
(6, 'Rohit', 'Kumar', 'Sales', 55000),
(7, 'Anjali', 'Patel', 'IT', 65000),
(8, 'Suman', 'Das', 'HR', 40000);


-- Task 2: Updating Data
-- Update the salary of the Employee with id = 2 (Jane Smith) to 60000.

Update Employees
Set salary = 60000
Where Id = 2;

-- Task 3: Deleting Data
-- Delete the Employee with id = 1 (Rahul Sharma).

Delete from Employees
Where Id = 1;

-- Task 4: Verify Changes
-- Use SELECT * FROM employees; to verify the changes.

Select * from Employees;

-- 4 – Using Constraints (NOT NULL, UNIQUE, DEFAULT,
-- CHECK)
-- Objective: Learn about constraints for data integrity.

-- Task 1: Create a Table with Constraints
-- Create a new table Employees_v2 with NOT NULL, UNIQUE, and CHECK constraints.

Create Table Employees_v2
(Id Integer Primary Key,
First_name varchar(50) Not Null,
Last_name Varchar(50)Not Null,
Department Varchar(50) Default 
'General',
Salary Integer Check (Salary > 0),
Email Varchar(50) Unique
);

-- Task 2: Insert Data with Constraints
-- Try inserting data into employees_v2, including a duplicate email to observe the UNIQUE constraint
-- violation.

Insert Into Employees_v2
(Id, First_name, Last_name, Department, Salary, Email)
Values
(1, 'Aman', 'Khan', 'IT', 50000, 'aman@gmail.com');



