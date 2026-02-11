Create Database Company_db;
Use Company_db;

-- Employee Table --
Create Table employees(
Emp_id int Primary key,
Emp_name Varchar(50),
Department_id int,
Salary int
);

-- Department Table --
Create Table Departments (
Department_id  int  primary key,
Department_name Varchar(50)
);

-- Sales Table --
Create Table Sales(
sale_id int primary key,
emp_id int,
sale_amount int,
sale_date date
);

/* Departments Table Data */

Insert Into departments values
(1, 'IT'),
(2, 'HR'),
(3, 'Sales');

select * from departments;

-/*Employees Table Data*/

Insert Into Employees Values
(101, 'Abhishek' ,1, 60000),
(102, 'Shubham' ,2, 50000),
(103, 'Adyut' ,1, 70000),
(104, 'Shashank',3, 55000),
(105, 'Neeraj' ,2, 72000),
(106, 'Sakshi' ,3, 48000),
(107, 'Kusum' ,1, 41000),
(108, 'Sajal' ,2, 56000),
(109, 'Bhomika' ,1, 69000),
(110, 'Vikas' ,1, 71000),
(111, 'Vikram' ,3, 59000),
(112, 'Anku' ,2, 54000),
(113, 'Jimmy' ,1, 64000),
(114, 'Hritik' ,3, 52000),
(115, 'Swapnil' ,2, 54000);

select* from Employees;

 /* Sales Data */

Insert Into sales Values
(4, 104, 4500, '2024-01-10'),
(5, 105, 4200, '2024-01-11'),
(6, 106, 2500, '2024-01-12'),
(7, 107, 3000, '2024-01-15'),
(8, 108, 3200, '2024-01-16'),
(9, 109, 4100, '2024-01-18'),
(10, 110, 3100, '2024-01-20'),
(11, 111, 4300, '2024-01-22'),
(12, 112, 2800, '2024-01-25'),
(13, 113, 5200, '2024-01-27'),
(14, 114, 5100, '2024-01-28'),
(15, 115, 3900, '2024-01-30');

Select * from sales;

-- 15 Daily Practice Problems (DPP) on Subqueries --
-- Basic Leve--
-- Que 1. Retrieve the names of employees who earn more than the average salary of all employees --

Select emp_name 
from Employees
where salary > (select avg(salary) from Employees);

 -- Que 2. Find the employees who belong to the department with the highest average salary--
 Select emp_name
 from Employees
 Where department_id =(
 select department_id
 from Employees
 group by department_id
 order by avg(salary)desc
 limit 1
 );
-- Que 3. List all employees who have made at least one sale--

select distinct emp_name
from Employees
where emp_id in (select emp_id from sales);

-- Que 4. Find the employee with the highest sale amount--

select emp_name
from employees
Where emp_id = (
select emp_id 
from sales
order by sale_amount desc 
limit 1
);

-- Que 5. Retrieve the names of employees whose salaries are higher than Shubham's salary. --
select  emp_name
from Employees
where salary > (
 select salary from employees
where emp_name = 'Shubham'
);

-- Intermediate Level--
-- Que 6. Find employees who work in the same department as Abhishek --
Select emp_name
from Employees
where department_id = (
select department_id
from Employees
where emp_name = 'Abhishek'
);

-- Que 7. List departments that have at least one employee earning more than $60,000 --
select department_name
from departments
where department_id in (
select department_id 
from employees
where salary > 60000
);

-- Que 8. Find the department name of the employee who made the highest sale,--
select department_name
from departments
where department_id = (
select department_id
from Employees
where emp_id = (
select emp_id
from sales
order by sale_amount desc
limit 1
)
);

-- Que 9. Retrieve employees who have made sales greater than the average sale amount, --
Select avg(sale_amount) 
from sales;
 select distinct emp_name
 from employees
 where emp_id in (
 select emp_id
 from sales
 where sale_amount > (select 
 avg(sale_amount) from sales)
 );

-- Que 10. Find the total sales made by employees who earn more than the average salary.--
 
 select sum(sale_amount)
 from sales
 where emp_id in (
 select emp_id
 from employees
 where salary > (select avg(salary)
 from employees)
 );

-- Advanced Level --
-- Que 11 Find employees who have not made any sales --
select emp_name
from employees
where emp_id not in (select emp_id from sales);

-- Que 12. List employees who work in departments where the average salary is above $55,000 --
select emp_name
from employees 
where department_id in (
select department_id
from employees
group by department_id
having avg(salary) > 55000
);

-- Que 13. Retrieve department names where the total sales exceed $10,000 --
select department_name
from departments
where department_id in (
select department_id
from Employees
where emp_id in(
select emp_id
from sales
group by emp_id
having sum(sale_amount) > 10000
)
);

-- Que 14.Find the employee who has made the second-highest sale --
select emp_name
from employees
where emp_id = (
select emp_id
from sales
order by sale_amount desc
limit 1 offset 1
);

-- Que 15.Retrieve the names of employees who have a salary greater than the highest sales amount recorded.--
select emp_name
from Employees
where salary > (select max(sale_amount)
from sales);





