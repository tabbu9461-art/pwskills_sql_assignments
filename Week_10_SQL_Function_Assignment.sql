use world;
-- Question 1--
-- Write an SQL query to find the country with the maximum population in the table. --
select name, population
 from country
 order by population desc
 limit 1;
 
-- Question 2--
-- Write an SQL query to sum the populations of all cities per country.--
select countryCode, sum(population)as
total_population
from city 
group by countryCode;

-- Question 3
-- Find the top 3 countries with the highest population density.--
select name, SurfaceArea as
population_density
from country
where SurfaceArea > 0
order by population_density desc 
limit 3;

-- Solve the following questions using “Sakila” Database --
use sakila;
-- Question 4--
-- Write an SQL query to find the customer_id who has the highest number of rentals.--
select customer_id
from rental
group by customer_id
order by count(*) desc
limit 1;

-- Question 5--
-- Write an SQL query to identify the month with the most rentals.--
select MONTH(rental_date) as 
rental_month
from rental
group by MONTH (rental_date)
order by count(*) desc 
limit 1 ;
describe city;

-- Question 6--
-- Find the total revenue generated per day.--
select DATE(payment_date) as day,
sum(amount) AS total_revenue
from payment 
group by date(payment_date)
order by day;

-- Question 7--
-- Find the store that generated the highest total revenue.--
select r.store_id,
sum(p.amount) as total_revenue
from payment p
join rental r on p. rental_id =
r. rental_id 
group by r.store_id
order by r.store_id
order by total_revenue desc 
limit 1;

-- Question 8--
-- Find the customers who have made exactly 5 payments.--
select customer_id
from payment 
group by customer_id 
having count(payment_id) = 5;








