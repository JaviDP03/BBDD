-- Boletín 1 Consultas		Javier Duarte Pérez
USE sakila;

-- Actores que tengan una 'x' en el nombre o en el apellido (tabla actor)
SELECT * FROM actor WHERE first_name LIKE '%x%' OR last_name LIKE '%x%';

-- Direcciones (district) de 'california' que tengan ‘274’ en el número de teléfono (tabla address)
SELECT * FROM address WHERE district = 'california' AND phone LIKE '%274%';

-- Películas ‘Épicas’ (Epic) o ‘Brillantes’ (brilliant) que duren (length) más de 180 minutos (tabla film)
SELECT * FROM film WHERE (description LIKE '%epic%' OR description LIKE '%brilliant%') AND length > 180;

-- Películas que duren (length) entre 100 y 120 minutos o entre 50 y 70 minutos (tabla film)
SELECT * FROM film WHERE length BETWEEN 100 AND 120 OR length BETWEEN 50 AND 70;

-- Películas que cuesten 0.99, 2.99 y tengan un rating ‘g’ o ‘r’ y que hablen de cocodrilos (en la descripción aparezca cocodrile) (tabla film)
SELECT * FROM film WHERE rental_rate IN (0.99, 2.99) AND rating IN ('G', 'R') AND description LIKE '%crocodile%';

-- Direcciones (district) de ontario o de punjab o que su código postal acabe en 5 o que su teléfono acabe en 5 (tabla address)
SELECT * FROM address WHERE district IN ('ontario', 'punjab') OR postal_code LIKE '%5' OR phone LIKE '%5';