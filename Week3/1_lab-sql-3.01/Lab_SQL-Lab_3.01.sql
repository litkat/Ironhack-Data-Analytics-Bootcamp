USE sakila;
-- Activity 1
-- 1. Drop column picture from staff.
ALTER TABLE sakila.staff
DROP COLUMN picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

-- SELECT * FROM staff;

INSERT INTO sakila.staff(staff_id, first_name, last_name, address_id, email, store_id, active, username)
VALUES 
(3, 'Tammy', 'Sanders', 5, 'Tammy.Sanders@sakilastaff.com', 2, 1, 'Tammy');

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.
-- SELECT * FROM rental;

-- select customer_id from sakila.customer
-- where first_name = 'CHARLOTTE' and last_name = 'HUNTER'; -- 130 

-- SELECT inventory_id 
-- FROM sakila.inventory
-- JOIN sakila.film 
-- USING (film_id)
-- WHERE title = "Academy Dinosaur"; -- between 1 and 8

-- SELECT staff_id
-- FROM sakila.staff
-- WHERE first_name = "Mike" AND last_name	= "Hillyer"; -- 1

INSERT INTO sakila.rental(rental_date, inventory_id, customer_id, staff_id)
VALUES 
(CURRENT_TIMESTAMP(), 1, 130, 1);



