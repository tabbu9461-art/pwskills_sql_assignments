Use company;
create table employee_data(
id int,
gender varchar(10),
experience int,
position varchar (100),
salary int);
Select * from employee_data;
# Easy Level
-- Ques 1. Identify NULL Values in the and Column --

select * 
from employee_data
where position is null or salary is null;

-- Ques 2.Update the column, replacing values with 'Unknown' --

Update employee_data
set position = 'Unknown'
where position is null;

-- Ques 3. Replace salaries with the average salary of all employees.--

update employee_data
set salary = (
select avg_salary
from (
select avg(salary) as avg_salary 
from employee_data
) as temp
)
where salary is null;

# Intermediate Level
-- Ques 4. Ensure all values are stored in lowercase for consistency --

update employee_data
set position = lower(position);

-- Ques 5.Find duplicate records where and are identical --

select gender, experience, position,
salary, count(*)
from employee_data
group by gender, experience, position,
salary
having count(*) > 1;

-- Ques 6.b Delete duplicate records, keeping the lowest . --

delete e1
from employee_data e1
join employee_data e2
on e1.gender = e2.gender
and e1. experience = e2.experience
and e1. position = e2.position
and e1.salary = e2.salary
and e1. id> e2.id;

 # Advanced Level
-- Ques 7. Replace salaries with the average salary per experience level --

update employee_data e
join (
select experience, avg(salary) as
avg_salary
from employee_data
group by experience
) as temp
on e.experience = temp. experience
set e. salary = temp.avg_salary
where e.salary is null;

-- Ques 8. Identify and delete employees with negative or zero salaries --

delete from employee_data
where salary <= 0 ;

select* from employee_data;

-- Quse 9. Create a new column and Classify employees into salary bands:
-- Low (< 50,000)
 -- Medium (50,000 - 100,000)
-- High (> 100,000G)

alter table employee_data
add salary_brand varchar(50);
 
 update employee_data
 set salary_brand = case
 when salary < 50000 then 'Low'
 when salary between 50000 and 100000 then 'Medium'
 else 'High'
 end;
 
select* from employee_data;

-- Ques 10. Select employees who hold positions that do not contain 'Dev' in the position name --

select * from employee_data
where position not like '%dev%';

 -- Ques 11. Some employees have . Find and correct them --
 
 select * from
 employee_data
 where experience < 0;
 
 update employee_data
 set experience = ABS(experience)
 where experience < 0;
 
 select* from employee_data;
 
-- Ques 12. Find employees whose salary is below the 5th percentile or above the 95th percentile.--
select * 
from (
select *,
percent_rank() over (order by salary) as pr
from employee_data
) t
where pr <= 0.05 or pr >= 0.95;
 
 
 
 
 
 
