USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.

SELECT s.store_id, c.city, co.country
FROM sakila.store s
INNER JOIN sakila.address a 
ON s.address_id = a.address_id
INNER JOIN sakila.city c 
ON a.city_id = c.city_id
INNER JOIN sakila.country co 
ON c.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT sto.store_id, ROUND(SUM(amount), 2) as total_amount
FROM sakila.payment p
INNER JOIN sakila.staff s
USING (staff_id)
-- ON p.staff_id = s.staff_id
INNER JOIN sakila.store sto
USING (store_id)
-- ON s.store_id = sto.store_id
GROUP BY sto.store_id;

-- 3. Which film categories are longest?

SELECT c.name, ROUND(AVG(f.length), 1) AS duration
FROM sakila.film f
JOIN sakila.film_category  fc 
USING (film_id)
JOIN sakila.category c 
USING (category_id)
GROUP BY c.name
ORDER BY duration DESC
LIMIT 1;

-- 4. Display the most frequently rented movies in descending order.

SELECT f.title, COUNT(f.film_id) AS total_count
FROM sakila.rental r
JOIN sakila.inventory i 
USING (inventory_id)
JOIN sakila.film as f 
USING (film_id)
GROUP BY f.film_id
ORDER BY total_count DESC;

-- 5. List the top five genres in gross revenue in descending order.

SELECT c.name, SUM(p.amount) AS gross_revenue
FROM category c
JOIN film_category fc
USING(category_id)
JOIN inventory i
USING(film_id)
JOIN rental r
USING(inventory_id)
JOIN payment p
USING(rental_id)
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1?

SELECT i.store_id, f.title, COUNT(i.store_id) AS number_of_films_in_store
FROM sakila.film f
JOIN sakila.inventory i 
USING (film_id)
JOIN sakila.store s
USING(store_id)
JOIN sakila.rental r
USING(inventory_id)
WHERE r.return_date IS NOT NULL AND f.title = 'Academy Dinosaur' and i.store_id = 1;

-- 7. Get all pairs of actors that worked together.

SELECT f1.film_id, f1.actor_id AS actor_1, f2.actor_id AS actor_2
FROM sakila.film_actor f1
JOIN sakila.film_actor f2 
ON (f1.film_id = f2.film_id)
AND (f1.actor_id <> f2.actor_id)
ORDER BY f1.film_id;



-- 8. Get all pairs of customers that have rented the same film more than 3 times.
SELECT r1.customer_id AS Customer_1, r2.customer_id AS Customer_2, COUNT(DISTINCT r1.inventory_id) AS number_of_times
FROM sakila.rental r1 
JOIN sakila.rental r2
ON r1.inventory_id = r2.inventory_id AND r1.customer_id < r2.customer_id
GROUP BY r1.customer_id, r2.customer_id
HAVING Number_of_Times > 3
ORDER BY Number_of_Times DESC;

-- 9. For each film, list actor that has acted in more films.

