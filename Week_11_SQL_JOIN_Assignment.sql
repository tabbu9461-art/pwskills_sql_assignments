Create Database Assignment;
use Assignment;
-- Problem Statement:
-- A retail company operating across major Indian cities wants to analyze its customer transactions, order
-- activities, and payment records. The business maintains multiple tables such as Customers, Orders,
-- Payments, and Employees. However, the data is spread across different tables, and the management wants a
-- consolidated view to answer important business questions.
-- As a data analyst, your task is to use SQL JOIN operations to combine these tables and extract meaningful
-- insights.
-- The company wants to understand:
-- Which customers are actively placing orders
-- Which customers are inactive
-- Which orders have no valid customer records
-- Which customers made payments without purchasing
-- Overall customer behaviour based on orders & payments
-- Manager–employee reporting structure
-- You must analyze the dataset using INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN (if supported), SELF JOIN,
-- and CROSS JOIN, and provide meaningful outputs.--

-- Customers Table --
Create Table Customers(
Customer_id int Primary Key,
Customer_name Varchar(50),
City Varchar(50)
);
Insert Into Customers
Values
(1,'Arjun Mehta', 'Mumbai'),
(2,'Priya Sharma', 'Delhi'),
(3,'Sonam Mishra', 'Bengluru'),
(4,'Sneha Kapoor', 'Pune'),
(5,'Karan Singh', 'Jaipur');

select * from Customers;

-- Orders Table --
Create Table Orders(
Order_id Int Primary Key,
Customer_Id Int,
Order_Date Date,
Amount Int);

Insert Into Orders Values
(101 ,1, '2024-09-01', 4500),
(102 ,2, '2024-09-05', 5200),
(103 ,1, '2024-09-07', 2100),
(104 ,3, '2024-09-10', 8400),
(105 ,7, '2024-09-12', 7600);

select * from Orders;

-- Payment Table --
Create Table Payments(
Payment_Id Varchar(10) Primary Key,
Customer_Id Int,
Payment_Date Date,
Amount int
);
Insert Into Payments Values
('P001', 1, '2024-09-02', 4500),
('P002', 2, '2024-09-06', 5200),
('P003', 3, '2024-09-11', 8400),
('P004', 4, '2024-09-15', 3000);

select * from Payments;

-- Employee Table --
Create Table Employees(
Emp_Id Int Primary Key,
Employee_Name Varchar (50),
Manager_Id Int
);

Insert Into Employees Values
(1, 'Amit Khanna',Null),
(2, 'Neha Joshi',1),
(3, 'Vivek Rao',1),
(4, 'Rahul Das',2),
(5, 'Isha Kulkarni',2);

select * from Employees;

-- Question 1. Retrieve all customers who have placed at least one order.( Inner Join) --
Select Distinct c.Customer_Name
From Customers c
Inner join Orders o
 On c. Customer_Id = o. Customer_Id;
 
-- Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.(Left Join)--
Select c. Customer_Name, o.Order_Id
From Customers c 
Left Join Orders o
On c.Customer_Id = o.Customer_Id;
 
 -- Question 3.Retrieve all orders and their corresponding customers, including orders placed by unknown customers.(Right Join) --
 Select o.Order_Id, c.Customer_Name
 From Customers c 
 Right Join Orders o
 On c.Customer_Id = o.Customer_Id;

 -- Question 4.Display all customers and orders, whether matched or not.(Full Join Logic) --
 Select c.Customer_Name, o.Order_Id
 From Customers c
 Left Join Orders o
 On c.Customer_Id =  o.Customer_Id
 union
 Select c.Customer_Name, o.Order_Id
 From Customers c
 Right Join Orders o 
 On c. Customer_id = o.Customer_Id;

-- Question 5.Find customers who have not placed any orders.--
Select c.Customer_Name
From Customers c
Left Join Orders o
On c.Customer_Id = o.Customer_Id
Where o.Order_Id is Null;

-- Question 6.Retrieve customers who made payments but did not place any orders.--
Select c.Customer_Name
From Customers c
Inner Join Payments p 
On c.Customer_Id = p.Customer_Id
Left Join Orders o
On c.Customer_Id = o.Customer_Id
Where o.Order_Id is null;

-- Question 7.Generate a list of all possible combinations between Customers and Orders.--
Select c.Customer_Name, o.Order_Id
From Customers c
Cross Join Orders o;

 -- Question 8. Show all customers along with order and payment amounts in one table.--
 Select c.Customer_Name, o.Amount as
 Order_Amount, p.Amount as Payment_Amount
 From Customers c
 Left Join Orders o
 on c. Customer_Id = o.Customer_Id
 Left Join Payments p
 On c.Customer_Id = p. Customer_Id;
 
--  Question 9.Retrieve all customers who have both placed orders and made payments.(Inner Join)--
Select Distinct c.Customer_Name
From Customers c
Inner Join Orders o
on c.Customer_Id = o.Customer_Id
Inner Join Payments p
on c.Customer_Id = p. Customer_Id;


 








