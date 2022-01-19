USE sakila
-- 1. Select all the actors with the first name ‘Scarlett’

SELECT * FROM sakila.actor
WHERE first_name = 'Scarlett';

-- 2. How many films (movies) are available for rent and how many films have been rented?
SELECT count(*) FROM sakila.film;

SELECT count(*) FROM sakila.rental;

-- 3. What are the shortest and longest movie duration? Name the values `max_duration` and `min_duration`.
SELECT MAX(rental_duration) AS max_duration, MIN(rental_duration) AS min_duration
FROM sakila.film;

-- 4. What's the average movie duration expressed in format (hours, minutes)?
SELECT *
FROM sakila.film;

-- SELECT FLOOR(AVG(length) / 60) AS hours, ROUND(AVG(length) % 60) AS minutes
-- FROM sakila.film;

SELECT FLOOR(AVG(length) / 60) AS hours, FLOOR(MOD(AVG(length), 60)) AS minutes
FROM sakila.film;

-- 5. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name)
FROM sakila.actor;

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM sakila.rental;

-- 7.Show rental info with additional columns month and weekday. Get 20 results.
-- SELECT * FROM sakila.rental;

SELECT *, DATE_FORMAT(rental_date, '%M') AS 'month',  DATE_FORMAT(rental_date, '%W') AS 'weekday'
from sakila.rental
limit 20;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *, DATE_FORMAT(rental_date, '%M') AS 'month',  DATE_FORMAT(rental_date, '%W') AS 'weekday',
CASE
WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') then 'weekend'
WHEN DATE_FORMAT(rental_date, '%W') IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') then 'workday'
ELSE 'INCORRECT DATE'
END AS 'day_type'
FROM sakila.rental;

-- 9. Get release years.
SELECT DISTINCT(release_year) 
FROM sakila.film;

-- 10. Get all films with ARMAGEDDON in the title.
SELECT * 
FROM sakila.film
WHERE title LIKE '%ARMAGEDDON%';

-- 11.Get all films which title ends with APOLLO. 
SELECT * 
FROM sakila.film
WHERE title LIKE '%APOLLO';

-- 12. Get 10 the longest films.
SELECT * 
FROM sakila.film
ORDER BY length DESC
LIMIT 10;

-- 13. How many films include **Behind the Scenes** content?
-- WHERE description LIKE '%Behind the Scenes%';

SELECT count(film_id) 
FROM sakila.film
WHERE special_features LIKE '%Behind the Scenes%';
