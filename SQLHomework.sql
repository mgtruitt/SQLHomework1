USE sakila;

#1a
SELECT first_name, last_name FROM actor;

#1b
SELECT CONCAT(first_name, ' ' ,last_name) AS 'Actor Name' 
FROM actor;

#2a
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = "Joe";

#2b
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%GEN%';

#2c
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%LI%' ORDER BY last_name, first_name;

#2d
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a
ALTER TABLE actor ADD COLUMN middle_name CHAR(30) AFTER first_name;

#3b
ALTER TABLE actor MODIFY COLUMN middle_name BLOB;

#3c
ALTER TABLE actor DROP COLUMN middle_name;

#4a
SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name;

#4b
SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name
HAVING COUNT(*) >=2;

#4c
UPDATE actor SET first_name = 'HARPO' 
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

#4d
UPDATE actor SET first_name = 
CASE WHEN first_name = 'HARPO' AND last_name = 'WILLIAMS'
THEN 'GROUCHO' 
END;

#5a
DESCRIBE address;

#6a
SELECT first_name, last_name, address FROM staff
JOIN address
ON staff.address_id = address.address_id;

#6b
SELECT first_name, last_name, payment_date, SUM(amount) FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '2005-08%'
GROUP BY payment.payment_date;

#6c
SELECT COUNT(actor_id), title FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY title;

#6d
SELECT COUNT(inventory_id), title FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
WHERE title = 'Hunchback Impossible';

#6e
SELECT first_name, last_name, SUM(amount) FROM payment
JOIN customer on payment.customer_id = customer.customer_id
GROUP BY payment.customer_id
ORDER BY last_name, first_name;

#7a
SELECT title FROM film WHERE language_id IN
(SELECT language_id FROM language 
WHERE name = "English")
AND (title LIKE "K%") OR (title LIKE "Q%");

#7b
SELECT first_name, last_name FROM actor WHERE actor_id IN 
(SELECT actor_id FROM film_actor WHERE film_id IN 
(SELECT film_id FROM film WHERE title = "Alone Trip"));

#7c
SELECT email, country, first_name, last_name FROM customer
INNER JOIN address ON address.address_id = customer.address_id
INNER JOIN city ON city.city_id = address.city_id
INNER JOIN country ON country.country_id = city.country_id
WHERE country = 'Canada';

#7d
SELECT description, title FROM film WHERE film_id IN
(SELECT film_id FROM film_category WHERE category_id IN
(SELECT category_id FROM category WHERE name = "Family"));

#7e
SELECT COUNT(rental_id), title FROM rental
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
INNER JOIN film ON film.film_id = inventory.film_id
GROUP BY title
ORDER BY COUNT(rental_id) DESC;

#7f
SELECT SUM(amount), store_id FROM payment
INNER JOIN staff ON staff.staff_id = payment.staff_id
Group BY store_id;

#7g
SELECT store_id, city, country FROM store
JOIN address ON address.address_id = store.address_id
JOIN city ON city.city_id = address.city_id
JOIN country ON country.country_id = city.country_id
GROUP BY store_id;

#7h
SELECT SUM(amount), name FROM payment
JOIN rental ON rental.rental_id = payment.rental_id
JOIN inventory ON inventory.inventory_id = rental.inventory_id
JOIN film_category ON film_category.film_id = inventory.film_id
JOIN category ON category.category_id = film_category.category_id
GROUP BY name
ORDER BY SUM(amount) DESC
LIMIT 5;

#8a
CREATE VIEW Top_Gross_Genre AS
SELECT SUM(amount), name FROM payment
JOIN rental ON rental.rental_id = payment.rental_id
JOIN inventory ON inventory.inventory_id = rental.inventory_id
JOIN film_category ON film_category.film_id = inventory.film_id
JOIN category ON category.category_id = film_category.category_id
GROUP BY name
ORDER BY SUM(amount) DESC
LIMIT 5;

#8b
SELECT * FROM Top_Gross_Genre;

#8c
DROP VIEW Top_Gross_Genre;

