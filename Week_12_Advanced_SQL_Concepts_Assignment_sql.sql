Use company_db;
-- Que 1 What is the syntax of a window function --

-- select column_name,
-- function_name() Over (
-- partition by column_name
-- order by column_name)
-- as alias_name
-- from table_name;

-- Que 2. What is the purpose of the FIRST_VALUE() and LAST_VALUE() functions--

-- First_value () Return the frist value of the window
-- Last_vaue () Return the last value of window

-- Que 3. Create a Table in SQL and then solve the following--
-- create table 1 --
create table employee(
employee_id int,
name varchar(50),
department varchar(50),
salary int,
hire_date date
);

insert into employee values
(1, 'Alice', 'HR', 55000, '2020-01-15'),
(2, 'Bob', 'HR', 80000, '2019-05-16'),
(3, 'Charlie', 'HR', 70000, '2018-07-30'),
(4, 'Dev', 'Finance', 48000, '2021-01-10'),
(5, 'Imran', 'IT', 68000, '2017-12-25'),
(6, 'Jack', 'Finance', 60000, '2019-11-05'),
(7, 'Jason', 'IT', 45000, '2018-03-15'),
(8, 'Kiara', 'IT', 70000, '2022-06-18'),
(9, 'Michael', 'IT', 42000, '2019-05-20'),
(10, 'Naina', 'Finance', 115000, '2021-08-24'),
(11, 'Nandani', 'Finance', 52000, '2017-03-25');

-- create table 2 --
create table department(
department_id int,
department_name varchar(50),
location varchar(50)
);
insert into department values
(1, 'HR','New York'),
(2, 'IT', 'San Francisco'),
(3, 'Finance', 'Chicago');

-- Que 3. Write an SQL query to assign a unique rank to each employee based on salary (highest first) using ROW_NUMBER() --

select name, salary,
row_number() OVER (order by salary desc) as rank_no
from employee;

-- Que 4.Write a query to find each employee's department and their department-wise rank based on salary.--
select name, department,salary,
rank() over (partition by department order by salary desc) as
dept_rank
from employee;

-- Que 5. What will happen if we use instead of Rank() --

-- Ans. No skip Rank
-- Example 1,2,2,3(no gap)

-- Que 6. Write a query to calculate a running total of salaries across all employees (ordered by hire_date).--
select name, hire_date, salary,
sum(salary) over (order by hire_date) as running_total
from employee;

-- Que 7.Write a query to show each employee’s salary and the difference from the highest salary in their department.--
select name, department, salary,
max(salary) over (partition by department) - salary as
diff_from_highest
from employee;

-- Que 8.Write a query to compute a 3-period moving average of salaries based on hire date.--
select name, hire_date, salary,
avg(salary) over (
order by hire_date
rows between 2 preceding and
current row
) as moving_avg
from employee;

-- Que 9. Write a query using to find the cumulative distribution of salaries.--
select name, salary,
cume_dist () over (order by salary)
as cumulative_dist
from employee;

-- Que 10. Write a query to retrieve the last hired employee in each department using.--
select name, department, hire_date,
last_value(name) over (
partition by department 
order by hire_date
rows between unbounded
preceding and unbounded following)
as last_hired
from employee;

-- Que 11.What happens when you use instead of in a window function? Provide an example query.--
-- Rows Count the physical rows
-- Range Gruop the same value of rows

-- Que 12.Write an SQL query to list employees whose salary is above their department’s average salary. Use a subquery
-- with a window function.--
select salary ,
sum(salary) over (
order by salary
range between unbounded
preceding and current row
) as total
from employee;

-- Write a query to join the and tables and calculate each employee’s rank within their
-- department based on salary. (Hint: Use Table 2 )

select e.name,
d.department_name,
e.salary,
rank () over (partition by
e. department order by e. salary desc) as
dept_rank
from employee e
join department d
on e. department = d.department_name;


