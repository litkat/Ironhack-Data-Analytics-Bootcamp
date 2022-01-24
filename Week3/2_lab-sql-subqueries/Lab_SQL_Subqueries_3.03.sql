
USE sakila;
-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT f.title, COUNT(i.inventory_id) AS number_of_copy
FROM inventory i
JOIN film f 
USING (film_id)
-- ON f.film_id = i.film_id
WHERE f.title IN ('Hunchback Impossible');

-- OR with subquery:
 
SELECT COUNT(i.inventory_id) AS number_of_copy
FROM sakila.inventory i
WHERE film_id = (
	SELECT film_id 
	FROM sakila.film 
	WHERE title = 'Hunchback Impossible');
    
-- 2. List all films whose length is longer than the average of all the films.
   
SELECT f.title, f.length 
FROM film f
WHERE length > (
	SELECT AVG(f.length) 
    FROM film f)
ORDER BY f.length DESC;

-- 3. Use subqueries to display all actors who appear in the film _Alone Trip_.

SELECT first_name, last_name 
FROM sakila.actor 
WHERE actor_id IN (
	SELECT actor_id 
    FROM sakila.film_actor 
	WHERE film_id IN
		(SELECT film_id 
        FROM sakila.film 
        WHERE title = 'Alone Trip'
		)
	)
ORDER BY first_name;

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.

SELECT title 
FROM sakila.film 
WHERE film_id IN
	(SELECT film_id 
    FROM sakila.film_category
	WHERE category_id IN
		(SELECT category_id 
        FROM sakila.category 
        WHERE name = 'Family')
	)
ORDER BY title;

-- 5. Get name and email from customers from Canada using subqueries. Do the same with joins. 
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

SELECT first_name, last_name, email  
FROM sakila.customer
WHERE address_id IN 
	(SELECT address_id FROM sakila.address
	WHERE city_id IN 
		(SELECT city_id FROM sakila.city
		WHERE country_id IN 
			(SELECT country_id FROM sakila.country WHERE country = 'Canada')
		)
	)
ORDER BY first_name;

-- JOIN:

SELECT c.first_name, c.last_name, c.email  
FROM sakila.customer c
JOIN sakila.address a 
USING (address_id)
-- ON c.address_id = a.address_id 
JOIN sakila.city ci 
USING (city_id)
-- ON a.city_id = ci.city_id
JOIN sakila.country co 
USING (country_id)
-- ON ci.country_id = co.country_id
WHERE country = 'Canada';

-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

-- 6.1 Find the most prolific actor
CREATE TEMPORARY TABLE most_films_actor AS(
SELECT actor_id, COUNT(film_id) 
FROM sakila.film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1);

SELECT * FROM most_films_actor;

-- 6.2 Which are films starred by the most prolific actor?
SELECT a.first_name, a.last_name, f.title
FROM sakila.actor a
JOIN sakila.film_actor fa
USING (actor_id)
JOIN film f
USING (film_id)
WHERE actor_id = 
	(SELECT actor_id FROM most_films_actor)
ORDER BY f.title;

-- 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer 
-- ie the customer that has made the largest sum of payments.

-- 7.1 most profitable customer
-- DROP TABLE IF EXISTS most_profitable_customer;

CREATE TEMPORARY TABLE most_profitable_customer AS(
SELECT c.customer_id, c.first_name, c.last_name
FROM sakila.customer c
JOIN sakila.payment p
USING (customer_id)
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1);

-- 7.2 Films rented by most profitable customer
SELECT f.title, r.customer_id
FROM sakila.rental r
JOIN sakila.inventory i
USING(inventory_id)
JOIN sakila.film f
USING(film_id)
WHERE r.customer_id = 
	(SELECT customer_id 
    FROM most_profitable_customer)
ORDER BY f.title;

-- 8. Customers who spent more than the average payments.

SELECT c.first_name, c.last_name, c.customer_id, SUM(p.amount) AS total_amount_payments 
FROM sakila.customer c
JOIN sakila.payment p
USING (customer_id)
GROUP BY customer_id
HAVING SUM(amount) > 
	(SELECT AVG(total_payment) 
    FROM 
		(SELECT customer_id, SUM(amount) AS total_payment 
        FROM sakila.payment
		GROUP BY customer_id) sub1
	)
ORDER BY total_amount_payments DESC;



