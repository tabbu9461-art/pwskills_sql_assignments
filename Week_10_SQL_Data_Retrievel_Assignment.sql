-- 1.Practical Use of DISTINCT in SQL
-- Objective: To understand and apply the DISTINCT keyword in SQL queries. This focuses on eliminating--
-- duplicates and ensuring unique data.--
-- Scenario: You are working for an e-commerce platform. Your task is to help clean up the database for a
-- product analytics report. The database contains an "orders" table, which records every order placed on the
-- platform. Some customers have placed multiple orders for the same product, so you need to ensure that only
-- unique products are listed in your analysis.*/

CREATE DATABASE e_commers;
USE e_commers;

CREATE TABLE orders (
order_id INT,
customer_id INT,
product_name VARCHAR (50),
order_date Date
);
INSERT INTO Orders VALUES
(101, 200, 'Laptop', '2025-01-15'),
(102, 201, 'Phone', '2025-01-16'),
(103, 202, 'Laptop', '2025-01-17'),
(104, 200, 'Tablet', '2025-01-18'),
(105, 203, 'Phone', '2025-01-19'),
(106, 204, 'Laptop', '2025-01-20');

select * from orders;
/* QUESTION 1. Unique Products: Write a SQL query that will return a list of unique products ordered by customers (i.e.,
without duplicates) */

SELECT DISTINCT customer_id,
product_name
from orders
order by customer_id;

-- QUESTION 2. Unique Customers: Write a SQL query to find out how many unique products were ordered by each
-- customer. The result should show the customer’s ID and the number of distinct products they’ve ordered*/

select customer_id,
count(distinct product_name) as
unique_products
from orders
group by customer_id;

-- QUESTION 3. Distinct Product Count: Write a query to count the number of distinct products ordered on the platform. This
-- should return a single numberÐ*/

select count(distinct product_name) as 
total_distinct_products
from orders;

-- QUESTION 4. Sorting by Most Recent Orders: Write a SQL query that returns the most recent distinct products ordered,
-- sorted by the order date in descending order. Limit the result to the top 3 most recent products.*/

select product_name,
max(order_date) as
recent_order_date
from orders
group by product_name
order by recent_order_date desc
limit 3;

-- 2.Combining DISTINCT, LIMIT, and ORDER BY in SQL
-- Objective: To practice using DISTINCT, LIMIT, and ORDER BY together for filtering and sorting data.
-- Scenario: You are working with the same e-commerce platform, but now you are tasked with analyzing which
-- products are the most popular in terms of orders. You are required to focus on the top products ordered within
-- the last month.*/

use e_commers;
create table Orders(
order_id int primary key,
customer_id int,
product_name varchar(50),
order_date date
);
insert into  orders (order_id, customer_id, product_name, order_date)
values
(101, 200, 'Laptop', '2025-01-15'),
(102, 201, 'Phone', '2025-01-16'),
(103, 202, 'Laptop', '2025-01-17'),
(104, 200, 'Tablet', '2025-01-18'),
(105, 203, 'Phone', '2025-01-19'),
(106, 204, 'Laptop', '2025-01-20'),
(107, 205, 'Phone', '2025-01-01'),
(108, 206, 'Tablet', '2025-01-02');
select * from orders;

--  QUESTION 1.Top Products in the Last Month: Write a SQL query to return the top 2 most ordered distinct products from
-- the last month. Sort the results by order date in descending order and limit the output to the top 2*/

select product_name, count(*) as order_count,
max(order_date) as last_order_date
from orders
where order_date >= date_sub(
(select max(order_date) from orders),
interval 1 month
)
group by product_name
order by order_count desc,
last_order_date desc
limit 2;

--  QUESTION 2.Unique Products for Specific Customer: Write a SQL query to return the distinct products ordered by
-- customer 200, sorted by the order date in descending order. Limit the result to 3 products*/

select product_name
from orders
where customer_id = 200
group by product_name
order by max( order_date) desc
limit 3;

-- 3.Top N Products: Write a SQL query to retrieve the top 5 most ordered products based on the number of-- 
-- distinct orders, sorted by product name in ascending order. Limit the result to the top 5 --

select product_name,
count(distinct order_id) as
total_orders
from orders
group by product_name
order by total_orders desc, product_name
asc
limit 5;

-- QUESTION 4.Unique Orders for Each Product: Write a SQL query to count the distinct number of orders placed for each --
-- product. Sort the results by the number of distinct orders in descending order.--

select product_name,
count(distinct order_id) as
distinct_orders
from orders
group by product_name
order by distinct_orders desc;




-- 3.Optimizing Queries with DISTINCT and Indexing --
-- Objective: To learn how query optimization impacts performance when working with large datasets and using --
-- DISTINCT.
-- Scenario: You are now dealing with a much larger dataset that includes millions of orders in the "orders" table.--
-- Your goal is to optimize SQL queries using DISTINCT and indexing to improve performance.--
-- Table: Orders (Assume the table is now much larger with millions of rows.)--


--  QUESTION 1.Optimizing Query with DISTINCT: Given a large dataset, write a SQL query to retrieve the distinct products--
-- ordered in the last month. Suggest an optimization strategy using indexes. What columns would you index--
-- to make this query faster?--

select distinct product_name
from orders
where order_date >= date_sub(curdate(),
interval 1 month);
create index idx_orders_date_product
on orders (order_date, product_name);

-- QUESTION 2.Efficient Query Writing: Write a SQL query that retrieves only the top 3 distinct products ordered by--
-- customer 200. Use LIMIT and ORDER BY efficiently, and explain why the query is optimized for performance.--

select distinct product_name
from orders 
where customer_id  = 200
order by order_date desc
limit 3;
create index idx_customer_date_product
on orders (customer_id, order_date, product_name);

--  4. Query Optimization and Analysis with DISTINCT,
-- LIMIT, and ORDER BY--

 -- 4. Real-World Scenario and Complex Query Creation
-- Submit the SQL queries along with explanations of how the performance is optimized in your queries.

-- Objective: To practice query optimization strategies by analyzing execution plans and ensuring efficient
-- queries.
-- Scenario: You are tasked with improving the performance of SQL queries for a high-traffic e-commerce
-- platform. Your job is to use query optimization techniques for analyzing and retrieving top-selling products.--

-- QUESTION 1.Execution Plan Analysis: Write a SQL query that returns the most popular products ordered in the last 30 s.
-- Use DISTINCT, LIMIT, and ORDER BY to fetch the top 10 products. Use the EXPLAIN keyword to analyze the
-- execution plan and identify potential performance issues --

Explain
select Product_name,
count(distinct order_id) as orders
from orders
where Order_date >= curdate() - interval 30 day
group by Product_name
order by orders desc
limit 10;
-- Explanatio in sort --
-- indexes on order_date and product_id will help performence--

-- QUESTION 2. Optimizing Sorting and Filtering: If the database grows even further, which column(s) would you
-- recommend indexing to improve the speed of queries involving ORDER BY, DISTINCT, and LIMIT--

select product_name,count(distinct order_id) as orders
from orders
where orders_date >= curdate()-
interval 30 day
group by product_name
order by orders desc limit 10;

-- orders_date and for filtering(where)
-- product_name and for grouping (group by)
-- Best: composite index(order_date, product_name) for faster order by, distinct, and limit--

--  QUESTION 3. Alternative Query Approaches: Write an optimized version of a query that retrieves the top 5 most ordered
-- products in the last 30 s. Discuss why your query is more efficient than using DISTINCT without optimization.--

select product_name,count(*) as orders
from orders
where order_date >= curdate()- interval 30 day
group by product_name
order by orders desc
limit 10;

-- Why this is more efficient --
-- Avoids distinct (no extra sorting/hash).
-- Fewer computations and faster on large data.--
-- Works best with index on (order_date,product_name_).--

 -- 5.Real-World Scenario and Complex Query Creation --
-- Objective: To combine knowledge of DISTINCT, LIMIT, ORDER BY, and optimization for solving a real-world
-- problem with SQL.
-- Scenario: Imagine you are working for a large online retailer, and you need to create a query that provides a
-- list of distinct products ordered by the customers who made purchases over the last month. The result should
-- be ordered by the date of the last order. You are asked to display only the top 10 most recent distinct products,
-- avoiding duplicates and ensuring that the query runs efficiently.--

-- QUESTION 1. Complex Query Creation: Write a SQL query that retrieves the top 10 most recent distinct products ordered,
-- sorted by the order date in descending order. Make sure to limit the result to 10 products--

select product_name
from ( SELECT product_name, max(order_date) as 
last_order
from orders
group BY product_name ) t
order by last_order desc 
limit 10 ;

-- OUESTION 2. Query Optimization: Discuss how you would optimize the query if the orders table had millions of rows.
-- What indexing strategies would you apply to ensure efficient query execution]--

Create index
idx_oreders_orderdate_product
on orders(order_date, product_name);

-- QUESTION 3. Additional Enhancements: Imagine that the query needs to be enhanced to show the customer who made
-- the most recent purchase for each product. How would you modify your query to include this information?--

select product_name, customer_id, order_date
from orders o1
where order_date = (
select max(order_date)
from orders o2
where o2. product_name = o1. product_name
)
order by order_date desc limit 10;











