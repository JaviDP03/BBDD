-- rental_rate no esté entre 1 y 3
SELECT * FROM film WHERE rental_rate NOT BETWEEN 1 AND 3;

-- Título no contenga 'ACE'
SELECT * FROM film WHERE title NOT LIKE '%ACE%';

-- Películas cuyo precio no sea 0.99 ni 1.5 ni 2 ni 2.5 ni 2.99 y la duración no sea superior a 120 min
SELECT * FROM film WHERE rental_rate NOT IN (0.99, 1.5, 2, 2.5, 2.99) AND length <= 120;

-- Películas con lenguaje original a nulo
SELECT * FROM film WHERE original_language_id IS NULL;

-- Películas con lenguaje relleno
SELECT * FROM film WHERE language_id IS NOT NULL;