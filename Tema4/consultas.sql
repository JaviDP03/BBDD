-- Seleccionar todo
SELECT * FROM sakila.actor;

-- Seleccionar campos
SELECT first_name, last_name FROM sakila.actor;

-- Seleccionar registros
SELECT * FROM actor WHERE first_name = 'Penelope';

SELECT * FROM film WHERE rental_duration = 3;
SELECT * FROM film WHERE rental_rate > 3.5;
SELECT * FROM film WHERE rental_rate >= 3.99;
SELECT * FROM film WHERE rental_rate <= 4.99;
SELECT * FROM film WHERE rental_duration != 3;

-- Seleccionar sin repetidos
SELECT DISTINCT first_name FROM actor;

-- Contar
SELECT COUNT(first_name) FROM actor;

-- Cambiar nombre a columna
SELECT first_name AS nombreActor FROM actor;

SELECT COUNT(DISTINCT first_name) FROM actor;

-- Agrupar según un campo
SELECT first_name AS nombre, COUNT(actor_id) AS count FROM actor GROUP BY first_name;

-- Buscar por caracteres
SELECT * FROM film WHERE title LIKE 'A%';
SELECT * FROM film WHERE title LIKE '%R';
SELECT * FROM film WHERE title LIKE '%WAR%';
SELECT * FROM actor WHERE first_name LIKE 'A%';
SELECT * FROM actor WHERE first_name LIKE 'A%' AND last_name NOT LIKE 'G%';
SELECT * FROM actor WHERE first_name LIKE 'A%' OR first_name LIKE 'P%';

-- Buscar entre dos valores
SELECT * FROM film WHERE rental_rate BETWEEN 1 AND 3;