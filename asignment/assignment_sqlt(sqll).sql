#Name:-Yash solanki

#Reg email id:-yash87015@gmail.com

#Course name:-Data analytic

#Assignment name:- sql assignment

#Submission date:-9/1/2025

#Git link:-https://github.com/Yash87015/YASH (in git hub use assignment folder )

create database assinment;

#1. Create a table called employees with the following structure
# emp_id (integer, should not be NULL and should be a primary key)
# emp_name (text, should not be NULL)
# age (integer, should have a check constraint to ensure the age is at least 18)
# email (text, should be unique for each employee)
# salary (decimal, with a default value of 30,000).
# Write the SQL query to create the above table with all constraints.

use assinment;
create table employees
(emp_id int not null PRIMARY KEY,
emp_name char(40) not null,
age int check(age>=18),
email char(40) unique,
salary decimal default(30000));

DESC employees;

#drop table employees;

# 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.
# Ans:-How Constraints Help Maintain Data Integrity
#Accuracy: Constraints ensure that only valid data is entered into the database. For example, constraints can prevent entering a negative value for a product price.
#Consistency: They maintain the consistency of the data. For example, if a record references another table, foreign key constraints can ensure that the referenced record exists, preventing "orphaned" records.
#Uniqueness: Constraints ensure that no duplicate data is entered where uniqueness is required, like in the case of primary keys or unique constraints on fields like email addresses.
#Data Relationship Enforcement: They define relationships between tables and ensure that these relationships are preserved during inserts, updates, and deletes.
#Prevent Invalid Data Operations: They can prevent operations that might compromise the data's validity, such as deleting a record that's still referenced in another table.
#→Primary Key Constraint:-Ensures that each row in a table has a unique identifier and that no duplicate values are allowed in the primary key column(s).
#example :- emp_id in employees table has primary key means meaning each employee will have a unique ID that distinguishes them from others.
#→Foreign Key Constraint:- Enforces a relationship between two tables by ensuring that the value in a column in one table corresponds to a valid value in another table.
#example:-foreign key use to in two table with relation ship same data
#→Unique Constraint: Ensures that all values in a column (or a combination of columns) are unique across the table, preventing duplicate values.
#example:- An email column in a "employees" table can have a unique constraint to ensure no two users can have the same email address.
#Check Constraint:- Ensures that values in a column meet a specific condition or expression.
#example: A check constraint on an "age" column in an "employees" table could enforce that age must be greater than or equal to 18.
#Not Null Constraint:-Purpose: Ensures that a column cannot have a NULL value, meaning that every record in that column must have a valid value.
#Example: A "emp_name" column in an "employees" table may have a NOT NULL constraint to ensure that every employee has a first name.
#Default Constraint:- Specifies a default value for a column if no value is provided during insertion.
#example:-salary in employees table constain defult value 30000 if value is not provide then by defult it replace with 30000

# 3. Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.
# Ans :- The NOT NULL constraint is applied to a column in a database table to ensure that every row must have a valid (non-null) value for that column. It is used when the column’s data is essential for the integrity or complosary for record.
#No, a primary key cannot contain NULL values. The primary key is used to uniquely identify each row in a table, and for a value to uniquely identify a record, it must always be present.  
#In summary, while NOT NULL ensures that a column must always contain a value, the primary key inherently enforces both uniqueness and the non-null constraint because NULL cannot be used to identify a specific record in a way that guarantees uniqueness.

# 4.  4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.
# Ans→ add existing table to add constrain following below syntax.
#ALTER TABLE table_name
#ADD CONSTRAINT constraint_name constraint_type (column_name);
#exmple
alter table employees
ADD CONSTRAINT chk_salary CHECK (salary <= 100000);
#drop constarint from existing table follow below syntax
#ALTER TABLE table_name
#DROP CONSTRAINT constraint_name;
#example 
ALTER TABLE employees
DROP CONSTRAINT chk_salary;

# 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.
# Ans:- Consequences:-If you try to update a row in a way that violates a constraint (such as updating a column to a value that breaks a UNIQUE, or CHECK constraint), the update will fail.
#The database will generate an error message indicating the specific constraint violation.
#example:-lets insert value existing table
insert into employees
values (101,'dksolanki',19,'ndasoi@gmail.com',35000);#if all correct than excute perfectly
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (1, 'John Doe', 16, 'john.doe@example.com', 30000);#here age constraint violent thiats why error show 3819check constraint 'employees_chk_1' is violated
UPDATE employees
SET email = 'john.doe@example.com'
WHERE emp_id = 101;#here eror code 1062 duplicate entry 'john.doe@example.com' for key 'employees_email'

# 6. You created a products table without constraints as follows:
 CREATE TABLE products (
 product_id INT,
 product_name VARCHAR(50),
 price DECIMAL(10, 0));

desc products;

#7.  You have two tables: students and classes write a  query to fetch the student_name and class_name for each student using an INNER JOIN.
create table students (
student_id int primary key,
student_name varchar(50) not null,
class_id int unique);

insert into students value
(2,'Bob',102);

select *from students;
create table classes (
class_id int primary key,
class_name varchar(50) not null);

insert into classes value
(103,'History');

select *from classes;

# write a  query to fetch the student_name and class_name for each student using an INNER JOIN.
select students.student_name as student_name , classes.class_name as class_name
from students
inner join  classes on  students.class_id = classes.class_id;

# 8. Consider the following three tables: Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are listed even if they are not associated with an order
# Ans
CREATE TABLE orders (
    order_id INT PRIMARY KEY,        
    order_date DATE,                 
    customer_id INT                 
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,     
    customer_name VARCHAR(100) NOT NULL 
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,      
    product_name VARCHAR(100) NOT NULL, 
    order_id INT,                    
    FOREIGN KEY (order_id) REFERENCES orders(order_id)  
);

# Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are listed even if they are not associated with an order
SELECT orders.order_id, customers.customer_name, products.product_name
FROM products
LEFT JOIN orders ON products.order_id = orders.order_id
LEFT JOIN customers ON orders.customer_id = customers.customer_id;

# 9. Given the following tables:
create table sales (
sale_id int,
product_id int,
amount int );

insert into sales values (3,101,700);

CREATE TABLE products (
    product_id INT ,      
    product_name VARCHAR(100) NOT NULL);
    
insert into products values (102,'phone');
#Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function
SELECT products.product_name, 
       SUM(sales.amount) AS total_sales
FROM sales
INNER JOIN products ON sales.product_id = products.product_id
GROUP BY products.product_name;

# 10. You are given three tables:
select *from orders;
select *from customers;
CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT);

insert into order_details values (2,101,3);
# Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables
SELECT orders.order_id, 
       customers.customer_name, 
       order_details.quantity
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id
INNER JOIN order_details ON orders.order_id = order_details.order_id;
use mavenmovies;
## SQL Commands
#Q1.-Identify the primary keys and foreign keys in maven movies db. Discuss the differences?
SHOW KEYS FROM film_text WHERE Key_name = 'PRIMARY';
SELECT 
    t.table_name AS 'Table Name',
    k.column_name AS 'Column Name',
    k.constraint_name AS 'Constraint Name',
    k.referenced_table_name AS 'Referenced Table',
    k.referenced_column_name AS 'Referenced Column'
FROM 
    information_schema.key_column_usage k
JOIN 
    information_schema.tables t ON k.table_name = t.table_name
WHERE 
    t.table_schema = 'mavenmovies'
    AND (k.constraint_name = 'PRIMARY' OR k.constraint_name = 'FOREIGN')
ORDER BY 
    t.table_name, k.column_name;
#→ ans all table cointain primary key is id and respective table name and with respective primary key foreign key was thei respective table name id thats why both have cooncted to other tables

#  Q2- List all details of actors
select *from actor;
SELECT actor.first_name, actor.last_name, actor_award.awards
FROM actor
left JOIN actor_award ON actor.actor_id = actor_award.actor_id;

#  Q3 -List all customer information from DB.
select *from address;
select *from customer;
select customer.first_name,customer.last_name,customer.email,address.address,address.phone from address 
left join customer on address.address_id =customer.customer_id;

#  Q4 -List different countries.
select country from country;
select *from city;

# Q5 -Display all active customers.
select concat(first_name,'-',last_name) as full_name 
from customer
where active=1;

# Q6 -List of all rental IDs for customer with ID 1.
select *from customer;
select *from rental;
SELECT rental_id
FROM rental
WHERE customer_id = 1;

# Q7 - Display all the films whose rental duration is greater than 5 .
select title,rental_duration
from film
where rental_duration > 5;

# Q8 - List the total number of films whose replacement cost is greater than $15 and less than $20.
select title,replacement_cost
from film
where replacement_cost between 15 and 20;

# Q9 - Display the count of unique first names of actors.
select count(distinct first_name)as unique_first_name_of_actor from actor;

# Q10- Display the first 10 records from the customer table .
select * from customer 
limit 10;

# Q11  Display the first 3 records from the customer table whose first name starts with ‘b’
select * from customer
where first_name like 'b%'
order by first_name asc
limit 3;

# Q12 -Display the names of the first 5 movies which are rated as ‘G’.
select *from film
where rating = 'G'
ORDER BY film_id ASC
limit 5;

# Q13-Find all customers whose first name starts with "a".
select *from customer 
where first_name like 'a%';

# Q14- Find all customers whose first name ends with "a".
select *from customer 
where first_name like '%a';

#  Q15- Display the list of first 4 cities which start and end with ‘a’ .
select *from city
where city like 'a%' and city like '%a'
limit 4;

# Q16- Find all customers whose first name have "NI" in any position.
select *from customer 
where first_name like '%NI%';

#Q17- Find all customers whose first name have "r" in the second position .
select *from customer 
where first_name like '_r%';

# Q18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
select *from customer 
where first_name like 'a_____';

#Q19- Find all customers whose first name starts with "a" and ends with "o".
select *from customer 
where first_name like 'a%' and first_name like '%o';

#Q20 - Get the films with pg and pg-13 rating using IN operator.
select *from film
where rating in('pg','pg-13');

# Q21 - Get the films with length between 50 to 100 using between operator.
select *from film
where length between 50 and 100;

# Q22 - Get the top 50 actors using limit operator.
select *from  actor
ORDER BY last_name ASC
limit 50;

# Q23 - Get the distinct film ids from inventory table.
select distinct film_id from inventory;

#Functions
# Basic Aggregate Functions:
# Question 1:Retrieve the total number of rentals made in the Sakila database.
# Hint: Use the COUNT() function
use sakila;
select *from rental;
SELECT COUNT(*) AS total_rentals
FROM rental;

# Question 2: Find the average rental duration (in days) of movies rented from the Sakila database.
# Hint: Utilize the AVG() function.

select avg(rental_duration) as avge_rental_duration from film;

# String Functions:
# Question 3:Display the first name and last name of customers in uppercase.
# Hint: Use the UPPER () function.

select *from customer ;
select upper(first_name) as first_name , upper(last_name) as last_name from customer;


#Question 4: Extract the month from the rental date and display it alongside the rental ID.
# Hint: Employ the MONTH() function.
select *from rental;
select rental_id, month(rental_date) as month_name from rental; 

# GROUP BY
# Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
# Hint: Use COUNT () in conjunction with GROUP BY.
select customer_id,count(rental_id) as rentals
from rental
group by customer_id;

# Question 6:Find the total revenue generated by each store.
#Hint: Combine SUM() and GROUP BY.
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id;

#  Question 7:Determine the total number of rentals for each category of movies.
# Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.

SELECT fc.category_id, COUNT(r.rental_id) AS number_of_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
GROUP BY fc.category_id;

 #Question 8:Find the average rental rate of movies in each language.
# Hint: JOIN film and language tables, then use AVG () and GROUP BY.
SELECT l.name AS language_name, 
       l.language_id, 
       AVG(f.rental_rate) AS avg_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.language_id, l.name;

#Joins
# Questions 9 - Display the title of the movie, customers first name, and last name who rented it.
# Hint: Use JOIN between the film, inventory, rental, and customer tables.
select *from customer;
select *from inventory;
select *from film;
select *from rental;

select c.first_name,c.last_name,f.title from film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN customer c ON c.customer_id = r.customer_id;

# Question 10:Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
# Hint: Use JOIN between the film actor, film, and actor tables.
select *from film;
select *from film_actor;
select *from actor;
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film f ON f.film_id = fa.film_id
WHERE f.title = 'Gone with the Wind';

# Question 11: Retrieve the customer names along with the total amount they've spent on rentals.
# Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
select *from customer;
select *from payment;
select *from rental;
select c.first_name,c.last_name,sum(p.amount) each_customer_total_paid from payment p
join customer c on c.customer_id = p.customer_id
join rental r on r.rental_id = p.rental_id
group by c.customer_id;

#  Question 12: List the titles of movies rented by each customer in a particular city (e.g., 'London').
# Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
select *from customer;
select *from address;
select *from city;
select *from rental;
select *from inventory;
select *from film;
SELECT f.title, c.first_name, c.last_name, ci.city
FROM customer c
JOIN address a ON a.address_id = c.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
GROUP BY f.title, c.first_name, c.last_name, ci.city;

SELECT f.title, c.first_name, c.last_name, ci.city
FROM customer c
JOIN address a ON a.address_id = c.address_id
JOIN city ci ON ci.city_id = a.city_id
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE ci.city = 'London'
GROUP BY f.title, c.first_name, c.last_name, ci.city;

# Advanced Joins and GROUP BY:
# Question 13:Display the top 5 rented movies along with the number of times they've been rented.
# Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
select *from rental;
select *from inventory;
select *from film;
select f.title,count(r.rental_id) number_of_time_each_rented_movies from film f
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
group by f.title
order by number_of_time_each_rented_movies desc
limit 5;

# Question 14:
# Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
# Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
select *from customer;
select *from rental;
select *from inventory;
SELECT DISTINCT c.first_name, c.last_name
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;

#Windows Function:
# 1. Rank the customers based on the total amount they've spent on rentals
SELECT 
    first_name, 
    last_name, 
    total_spent, 
    RANK() OVER (ORDER BY total_spent DESC) AS rank_
FROM (
    SELECT 
        c.first_name, 
        c.last_name, 
        SUM(p.amount) AS total_spent
    FROM 
        customer c
    JOIN 
        rental r ON c.customer_id = r.customer_id
    JOIN 
        payment p ON p.rental_id = r.rental_id
    GROUP BY 
        c.customer_id
) AS total_spent_per_customer
ORDER BY 
    rank_;

# 2. Calculate the cumulative revenue generated by each film over time.
SELECT 
    f.title, 
    r.rental_date, 
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS cumulative_revenue
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
JOIN 
    payment p ON r.rental_id = p.rental_id
ORDER BY 
    f.title, r.rental_date;

#  3. Determine the average rental duration for each film, considering films with similar lengths.
select *from film
where length = 46;
select avg(rental_duration) average_rantal_duration,length,group_concat(title) film_title from film
group by length
order by length;

# 4. Identify the top 3 films in each category based on their rental counts.

WITH RankedFilms AS (
    select 
        f.title, 
        COUNT(r.rental_id) AS rental_counts,
        c.name AS category_name,
        ROW_NUMBER() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rank1
    from 
        category c
    join film_category fc ON fc.category_id = c.category_id
    join film f ON f.film_id = fc.film_id
    join inventory i ON i.film_id = f.film_id
    join rental r ON r.inventory_id = i.inventory_id
    group by
        f.title, c.name
)
select 
    title, 
    rental_counts, 
    category_name
from 
    RankedFilms
where 
    rank1 <= 3
order by 
    category_name, rental_counts DESC
limit 3;

# 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.

SELECT c.first_name,c.last_name,r.customer_id,COUNT(r.rental_id) AS total_rentals,avg_rentals.average_rentals,(COUNT(r.rental_id) - avg_rentals.average_rentals) AS difference_in_rentals
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN (SELECT 
        AVG(customer_rentals.total_rentals) AS average_rentals
    FROM (
        SELECT COUNT(rental_id) AS total_rentals
        FROM rental
        GROUP BY customer_id
    ) AS customer_rentals
) AS avg_rentals
GROUP BY 
    r.customer_id, c.first_name, c.last_name, avg_rentals.average_rentals
ORDER BY 
    r.customer_id;

# 6. Find the monthly revenue trend for the entire rental store over time.
SELECT 
    YEAR(r.rental_date) AS rental_year,
    MONTH(r.rental_date) AS rental_month,
    SUM(f.rental_rate) AS monthly_revenue
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON f.film_id = i.film_id
GROUP BY 
    rental_year, rental_month
ORDER BY 
    rental_year, rental_month;

# 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
WITH total_spending_per_customer AS 
    (SELECT customer_id, SUM(amount) AS total_spending
    FROM payment
    GROUP BY customer_id)
,
ranked_customers AS (
    SELECT customer_id, total_spending,
           PERCENT_RANK() OVER (ORDER BY total_spending DESC) AS spending_rank
    FROM total_spending_per_customer
)
SELECT c.customer_id, c.first_name, c.last_name, r.total_spending
FROM ranked_customers r
JOIN customer c ON r.customer_id = c.customer_id
WHERE r.spending_rank >= 0.8;

#  8. Calculate the running total of rentals per category, ordered by rental count.
select *from film;
select *from category;
Select *from rental;
WITH rental_counts AS (
    SELECT 
        c.name AS category,
        COUNT(r.rental_id) AS rental_count
    FROM 
        rental r
    JOIN 
        inventory i ON r.inventory_id = i.inventory_id
    JOIN 
        film f ON i.film_id = f.film_id
    JOIN 
        film_category fc ON f.film_id = fc.film_id
    JOIN 
        category c ON fc.category_id = c.category_id
    GROUP BY 
        c.category_id, c.name
)
SELECT 
    category,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM 
    rental_counts
ORDER BY 
    rental_count DESC;

#9. Find the films that have been rented less than the average rental count for their respective categories.
select *from film;
select *from rental;
select *from category;
with rental_count as (
   select count(rental_id) rental_count,f.film_id,c.category_id,c.name  from rental r
   join inventory i on i.inventory_id = r.inventory_id
   join film_category fc on fc.film_id = i.film_id
   join film f on f.film_id = fc.film_id
   join category c on c.category_id = fc.category_id
   group by c.category_id,f.film_id
   )
   ,
   avrage_rental_count as (
   select  category_id,avg(rental_count) as avg_rental_count  from rental_count 
   group by category_id)
   
   select f.title,c.name,rc.rental_count,arc.avg_rental_count from  rental_count rc
   join film f on f.film_id = rc.film_id
   join category c on rc.category_id = c.category_id
   join avrage_rental_count arc on arc.category_id = rc.category_id
   where rc.rental_count < arc.avg_rental_count
   order by c.name, rc.rental_count;
   
# Q10  Identify the top 5 months with the highest revenue and display the revenue generated in each month?

Select 
    Year(r.rental_date) AS rental_year,
    month(r.rental_date) AS rental_month,
    SUM(f.rental_rate * DATEDIFF(r.return_date, r.rental_date)) AS total_revenue
from rental r
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
Where r.return_date is not null
group by rental_year, rental_month
order by total_revenue desc
LIMIT 5;

# Normalisation & CTE
#Q1.First Normal Form (1NF):a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF
# Ans :-First Normal Form (1NF) is the property of a relational database table where:
#1.Each column contains atomic (indivisible) values.
#2.Each column contains values of a single type (e.g., only integers, dates, or strings).
#3.Each row is unique and can be uniquely identified by a primary key.
#4. There are no repeating groups or arrays in any column.

#A table violates 1NF if:
#Any column contains multiple values or lists (i.e., repeating groups or arrays).
#There are duplicate rows (which can be handled with a primary key).
#Non-atomic values are stored in any column.

#In the Sakila database, most of the tables are already normalized to at least First Normal Form (1NF), meaning that each column contains atomic (indivisible) values and each row is unique. However, there are some scenarios where a table could potentially violate 1NF if it wasn't designed properly. Let's walk through some potential cases where a table might violate 1NF, and the reasoning behind this.

#Steps to Normalize:Identify the column(s) with multiple values (e.g., a column storing multiple actor names in one row).
#Split the data into individual rows where each row contains a single, atomic value (e.g., one actor per row).
#Ensure that each row can be uniquely identified by a combination of the primary key (e.g., film_id and actor_id).

#Q2. Second Normal Form (2NF):a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it
## Ans :-In simple terms:Partial Dependency: Occurs when a non-prime attribute (a column that is not part of the primary key) depends on only part of the primary key, rather than the entire primary key.
# This typically happens when the primary key is composite (made up of more than one column).
select *from film_category;
select *from category;
desc film_category;
#, the film_category table has a composite key, which consists of two columns: film_id and category_id.
# Does the film_category Table Violate 2NF?To determine if a table violates 2NF, it must:Be in 1NF: This means there should be no repeating groups or arrays, and all attributes should have atomic values. The film_category table is already in 1NF because each attribute (column) holds atomic values.
#Have no partial dependencies: A table is in 2NF if all non-prime attributes are fully dependent on the entire primary key (in the case of composite keys, non-prime attributes must depend on all parts of the key).
#In the film_category table, we have no non-key attributes that are independent of the composite key. 
#To fix this violation and bring the table into 2NF, we need to remove the partial dependency.there is no partially dependancy on sakill database and no any violent 2NF 


#Q3. Third Normal Form (3NF):a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF
## Ans identify table thats violates 3NF in sakila database
desc actor;
# The table is in 3NF since all non-key attributes (first_name, last_name) depend only on the primary key (actor_id).
desc address;
#The primary key is address_id, and all other columns are dependent on address_id.
#The foreign key city_id refers to the city table, but this does not create a transitive dependency because city_id is directly related to the primary key.
#There are no transitive dependencies between the non-key attributes.
desc category;
#The category table is in 1NF and 2NF because:The primary key is category_id.The name and last_update columns are dependent on the category_id.
#There are no transitive dependencies.
desc city;
#The city table is in 1NF and 2NF because:The primary key is city_id.The city and last_update columns are dependent on city_id, and country_id is a foreign key.
#There is a transitive dependency: city_id → country_id → country_name (the country_name is in the country table).This violates 3NF because country_name is not directly related to city_id.
#Normalization to 3NF:We should remove the transitive dependency by ensuring that the country_name is only in the country table and not in the city table.
desc country;
#The country table is in 1NF and 2NF because:The primary key is country_id.The country and last_update columns depend on the primary key country_id.
#There are no transitive dependencies.
desc customer;
#The customer table is in 1NF and 2NF because:The primary key is customer_id.All non-key attributes are dependent on customer_id.
#The foreign keys (store_id and address_id) are properly set up.
#There is no transitive dependency because address_id is not dependent on any non-key attribute.
desc film;
#The film table is in 1NF and 2NF because:The primary key is film_id.All non-key attributes depend on film_id.The foreign key language_id references the language table.
#There are no transitive dependencies.
desc film_actor;
#The film_actor table is in 1NF because all attributes contain atomic values, and there are no repeating groups.
# The film_actor table is in 2NF because:It has a composite primary key (film_id, actor_id), and all non-key attributes (last_update) are fully dependent on the whole composite key, not just a part of it.
#The film_actor table is in 3NF because:There are no transitive dependencies. The only non-key attribute, last_update, depends directly on the primary key (the combination of film_id and actor_id), and not on any other non-key attribute.
desc film_category;
#film_category table is in 1NF AND 2NF 
#The film_category table is in 3NF because:There are no transitive dependencies. The only non-key attribute, last_update, depends directly on the composite primary key (film_id and category_id), and not on any other non-key attribute.
desc film_text;
#film_text table in 1NF,2NF and 3NF also 
#There are no transitive dependencies. The only non-key attribute, description and title, depends directly on the composite primary key (film_id), and not on any other non-key attribute.
desc inventory;
#The inventory table is in 1NF and 2NF because:The primary key is inventory_id.The film_id and store_id are foreign keys and are dependent on the primary key.
#There are no transitive dependencies. mean its in 3NF
desc language;
#The language table is in 3NF because There are no transitive dependencies. The non-key attributes (name and last_update) are directly dependent on the primary key (language_id), and not on any other non-key attribute.
#means its in 3NF and also in 1NF and 2NF
desc payment;
#There are transitive dependencies in the payment table, because:
#customer_id is a foreign key to the customer table. Information about the customer (like their name, email) can be found in the customer table. Storing the customer’s information directly in the payment table would violate 3NF.
#staff_id is a foreign key to the staff table. Staff-related information (such as name or position) is stored in the staff table.
#rental_id is a foreign key to the rental table. Information about the rental (such as the rental date and film details) can be found in the rental table.
#To bring the payment table into #3NF, we need to eliminate the transitive dependencies. The table currently stores information about the customer, staff, and rental in the form of foreign keys, but it should not store additional attributes related to these entities. Here's the approach to normalize the table:

#Remove the transitive dependencies:
#The payment table should only store information directly related to the payment itself (e.g., payment_id, amount, payment_date, last_update).
#Information about the customer, staff, and rental should not be stored in the payment table but should remain in their respective tables (i.e., customer, staff, and rental).
# Normalization: The foreign keys (customer_id, staff_id, rental_id) will remain in the payment table as they represent the relationships between payment and other entities. However, only the necessary attributes related to the payment itself should remain in this table;#


desc rental;
#The rental table is in 1NF and 2NF because:
#The primary key is rental_id.
#All non-key attributes depend on rental_id.
#There is no transitive dependency.
desc staff;
#The staff table is in 1NF and 2NF because:
#The primary key is staff_id.
#All non-key attributes depend on staff_id.
#The foreign keys address_id and store_id are properly set up.
#There are no transitive dependencies.
desc store;
#he store table is in 1NF and 2NF because:
#The primary key is store_id.
#All non-key attributes depend on store_id.
#The foreign keys manager_staff_id and address_id are properly set up.
#There are no transitive dependencies.

## Q4 . Normalization Process:
           #    a. Take a specific table in Sakila and guide through the process of normalizing it from the initial  
           # unnormalized form up to at least 2NF.
### Ans 
CREATE TABLE payment_unnormalized (
    payment_id INT,
    customer_id INT,
    customer_name VARCHAR(255),
    customer_email VARCHAR(255),
    staff_id INT,
    staff_name VARCHAR(255),
    rental_id INT,
    rental_date DATETIME,
    amount DECIMAL(5,2),
    payment_date DATETIME,
    last_update DATETIME
);
#  First Normal Form (1NF)
#To move from UNF to 1NF, we need to eliminate repeating groups and ensure that all attributes contain atomic values (i.e., no arrays, lists, or sets).
#In this case, we need to remove repeating groups (e.g., customer_name, customer_email, staff_name, rental_date), and ensure that all attributes are atomic.

CREATE TABLE payment_1nf (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    staff_id INT,
    rental_id INT ,
    amount DECIMAL(5,2),
    payment_date DATETIME,
    last_update DATETIME
);
# Second Normal Form (2NF)
#To move from 1NF to 2NF, we need to ensure that:The table is in 1NF.
#There are no partial dependencies, meaning that all non-key attributes must be fully functionally dependent on the entire primary key.
#In the case of the payment table, we have a single primary key (payment_id), but there are partial dependencies on non-key attributes. For example:

#customer_name, customer_email depend on customer_id, not on the full primary key (payment_id).staff_name depends on staff_id.rental_date depends on rental_id.
#These non-key attributes are partially dependent on the primary key (payment_id) and not fully dependent on it. Therefore, the table violates 2NF.

#To bring the table into 2NF, we need to remove partial dependencies by separating the data into different tables based on the attributes that are fully functionally dependent on the primary key.

#Step 3.1: Decompose the payment TableWe can decompose the original payment table into several tables:

#payment table: This will store payment-related information that is directly dependent on the payment_id.
#customer table: This will store customer-related information.
#staff table: This will store staff-related information.
#rental table: This will store rental-related information.

use assinment;
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    customer_email VARCHAR(255)
);
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(255)
);
CREATE TABLE rental (
    rental_id INT PRIMARY KEY,
    rental_date DATETIME
);
CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    staff_id INT,
    rental_id INT,
    amount DECIMAL(5,2),
    payment_date DATETIME,
    last_update DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id));
    ## Now, we have decomposed the payment table into smaller, logically related tables:

#The payment table stores only information that is directly related to the payment itself (i.e., payment_id, amount, payment_date, last_update).
#The customer table stores information related to customers, and it is linked to the payment table via the customer_id foreign key.
#The staff table stores staff details, and it is linked to the payment table via the staff_id foreign key.
#The rental table stores rental details, and it is linked to the payment table via the rental_id foreign key.
#With this structure, there are no partial dependencies left because each non-key attribute is now fully functionally dependent on the primary key in its respective table.

##Conclusion:The table is now in 2NF because all non-key attributes are fully dependent on the primary key.We have removed the partial dependencies by splitting the data into multiple related tables.
##Summary of the Steps:
#UNF to 1NF: Removed repeating groups and ensured all attributes are atomic.
#1NF to 2NF: Removed partial dependencies by decomposing the payment table into smaller tables that store related information (i.e., payment, customer, staff, rental).

#  5. CTE Basics:
              #  a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 
               # have acted in from the actor and film_actor tables.
use sakila;
select*from film;
select *from actor;
select *from film_actor;

with count_number_of_film_by_actor as (select
concat(a.first_name,' ',a.last_name) as full_name,
count(fa.film_id) as num_of_films,a.actor_id from actor a
join film_actor fa on fa.actor_id = a.actor_id
join film f on f.film_id = fa.film_id
group by a.actor_id)
select actor_id,full_name,num_of_films from count_number_of_film_by_actor cnofba;

##  Q6. CTE with Joins:
             #   a. Create a CTE that combines information from the film and language tables to display the film title, 
             #    language name, and rental rate.
### Ans 
select *from film;
select *from language;
with information as (
select l.language_id,l.name,f.title,f.rental_rate from film f 
join language l on l.language_id = f.language_id
 )
select language_id,name,title,rental_rate from information;

##Q7 CTE for Aggregation:
           #    a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
           #     from the customer and payment tables
### ans
select *from payment;
select *from customer;
with RGBEC as (
select full_name ,c.customer_id,sum(p.amount) as revenue from customer c 
join payment p on p.customer_id = c.customer_id 
group by customer_id)
select full_name,revenue,customer_id from RGBEC;
#above cod i wriiten and privisly i practice that why i already concate first_name and last_name already as full_name
WITH RGBEC AS (
 
    SELECT 
        CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
        c.customer_id,  -- Customer ID
        SUM(p.amount) AS total_revenue 
    FROM 
        customer c
    JOIN 
        payment p ON p.customer_id = c.customer_id 
    GROUP BY 
        c.customer_id 
)
-- Select the result from the CTE
SELECT 
    full_name,     
    total_revenue,  
    customer_id     
FROM 
    RGBEC;         


## Q8 CTE with Window Functions:
            #   a. Utilize a CTE with a window function to rank films based on their rental duration from the film table
### Ans
select *from film;
with ranked_films as (
select f.title,f.rental_duration,rank() over(order by rental_duration desc) as rental_rank from film f )
select title,rental_duration,rental_rank from ranked_films;


## Q9 CTE and Filtering:
          #     a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 
         #   customer table to retrieve additional customer details
         
### Ans
select *from customer;
select *from rental;
select *from payment;
WITH customers_rentals AS (
select c.customer_id,CONCAT(c.first_name, ' ', c.last_name) AS full_name, COUNT(p.payment_id) AS rental_count  
from customer c
join payment p on p.customer_id = c.customer_id  
GROUP BY c.customer_id, c.first_name, c.last_name    
HAVING COUNT(p.payment_id) > 2  
)
select cr.customer_id, cr.full_name,c.email,c.address_id,cr.rental_count     
FROM customers_rentals cr     
join customer c on c.customer_id = cr.customer_id  
order by cr.rental_count DESC;    


## Q10. CTE for Date Calculations:
 #a. Write a query using a CTE to find the total number of rentals made each month, considering the 
 # rental_date from the rental table
 ### Ans
 select *from rental;
 WITH monthly_rentals AS (
    
    SELECT 
        YEAR(r.rental_date) AS rental_year,   
        MONTH(r.rental_date) AS rental_month,  
        COUNT(r.rental_id) AS total_rentals    
    FROM 
        rental r                              
    GROUP BY 
        YEAR(r.rental_date), MONTH(r.rental_date)  
)

SELECT 
    rental_year,          
    rental_month,         
    total_rentals        
FROM 
    monthly_rentals      
ORDER BY 
    rental_year, rental_month; 
    
## Q11. CTE and Self-Join:
 #a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table
### Ans 
select *from film_actor;
WITH actor_pairs AS (
    -- CTE to find actor pairs that appeared in the same film
    SELECT 
        fa1.actor_id AS actor_id_1,  -- Actor 1's ID
        fa2.actor_id AS actor_id_2,  
        fa1.film_id                  
    FROM 
        film_actor fa1               
    JOIN 
        film_actor fa2 ON fa1.film_id = fa2.film_id  
    WHERE 
        fa1.actor_id < fa2.actor_id
)
-- Select the result to display actor pairs
SELECT 
    a1.actor_id AS actor_id_1, 
    a2.actor_id AS actor_id_2, 
    f.title AS film_title         
FROM 
    actor_pairs ap               
JOIN 
    actor a1 ON a1.actor_id = ap.actor_id_1 
JOIN 
    actor a2 ON a2.actor_id = ap.actor_id_2  
JOIN 
    film f ON f.film_id = ap.film_id           -- Join the film table to get the film title
ORDER BY 
    film_title, actor_id_1, actor_id_2;       -- Optional: order by film title and actor IDs

#.Q12. CTE for Recursive Search:
 #a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column
 ### Ans 
 select *from staff;
 select *from store;
WITH RECURSIVE EmployeeHierarchy AS (
    -- Base case: Select the specific manager
    SELECT staff_id, first_name, last_name, reports_to
    FROM staff
    WHERE staff_id = <specific_manager_id>  -- Replace with the specific manager's staff_id

    UNION ALL

    -- Recursive case: Select employees who report to the employees selected in the base case
    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s
    INNER JOIN EmployeeHierarchy eh
        ON s.reports_to = eh.staff_id  -- Join with the previous level to get direct reports
)
-- Final select statement to fetch all employees in the hierarchy
SELECT staff_id, first_name, last_name
FROM EmployeeHierarchy;




