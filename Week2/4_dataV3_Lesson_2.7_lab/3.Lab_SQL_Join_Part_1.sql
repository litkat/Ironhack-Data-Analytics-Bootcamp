USE sakila;
-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT c.category_id, c.name,  COUNT(f.film_id) AS 'number of films'
FROM sakila.category c
INNER JOIN sakila.film_category f
ON c.category_id = f.category_id
GROUP BY c.category_id
ORDER BY c.category_id, 'number of films' DESC;


-- 2. Display the total amount rung up by each staff member in August of 2005.

SELECT s.staff_id, SUM(p.amount) AS 'total amount'
FROM sakila.staff s
INNER JOIN sakila.payment p
ON s.staff_id = p.staff_id
WHERE (YEAR(p.payment_date) = 2005 AND MONTH(p.payment_date) = 8)
GROUP BY s.staff_id;


-- 3. Which actor has appeared in the most films?

SELECT a.actor_id, a.first_name, a.last_name, COUNT(a.actor_id) AS total_number_of_films 
FROM sakila.film_actor fa
INNER JOIN sakila.actor a
ON fa.actor_id = a.actor_id
GROUP BY a.actor_id
ORDER BY total_number_of_films DESC
LIMIT 1;


-- 4. Most active customer (the customer that has rented the most number of films)

SELECT r.customer_id, c.first_name, c.last_name, COUNT(r.customer_id) AS total_number
FROM sakila.rental r
INNER JOIN sakila.customer c 
ON r.customer_id = c.customer_id
GROUP BY r.customer_id
ORDER BY total_number DESC
LIMIT 1;


-- 5. Display the first and last names, as well as the address, of each staff member.

SELECT s.first_name, s.last_name, a.address, a.district, c.city, co.country
FROM sakila.staff s
INNER JOIN sakila.address a 
ON s.address_id = a.address_id
INNER JOIN sakila.city c 
ON c.city_id = a.city_id
INNER JOIN sakila.country co 
ON co.country_id = c.country_id;


-- 6. List each film and the number of actors who are listed for that film.

SELECT fa.film_id, f.title, COUNT(fa.actor_id) AS number_of_actors
FROM sakila.film f
INNER JOIN sakila.film_actor fa 
ON fa.film_id = f.film_id
GROUP BY fa.film_id;

-- 7. Using the tables `payment` and `customer` and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.

SELECT c.first_name, c.last_name, SUM(p.amount) AS 'total paid by each customer'
FROM sakila.customer c
INNER JOIN sakila.payment p 
ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name;


-- 8. List number of films per `category`.

SELECT fc.category_id, c.name, COUNT(fc.film_id) AS number_of_films
FROM sakila.film_category fc
INNER JOIN sakila.category c 
ON fc.category_id = c.category_id
INNER JOIN sakila.film f 
ON fc.film_id = f.film_id
GROUP BY fc.category_id, c.name
ORDER BY number_of_films DESC;
