-- Consulta para ver cuantos distritos o ciudades hay por cada id de ciudad.
SELECT city_id, phone, count(*) AS cantidad FROM address WHERE length(phone) > 1 GROUP BY city_id;
SELECT city_id, phone, count(*) AS cantidad FROM address GROUP BY city_id HAVING length(phone) > 1;

-- Alumnos y su número de aprobados y su número de suspensos
SELECT idalumno, nombre, count(*) AS aprobados FROM alumno WHERE nota >= 5 GROUP BY idalumno;
SELECT idalumno, nombre, count(*) AS suspensos FROM alumno WHERE nota < 5 GROUP BY idalumno;
SELECT idalumno, nombre, count(*) AS aprobados FROM alumno WHERE nota >= 5 GROUP BY idalumno HAVING aprobados > 2;
SELECT idalumno, nombre FROM alumno GROUP BY idalumno HAVING count(asignatura) > 2;

-- Consultas con JOIN
SELECT concat(a.first_name, ' ' , a.last_name) AS nombre, f.title, fa.last_update FROM film_actor fa, film f, actor a
WHERE fa.film_id = f.film_id AND fa.actor_id = a.actor_id;

-- Obtener los datos de la tabla store, pero en lugar de address_id, el campo address.
SELECT s.store_id, s.manager_staff_id, a.address, s.last_update FROM store s, address a
WHERE s.address_id = a.address_id;

-- Para cada pelicula, su nombre y el nombre de la categoría que pertenece.
SELECT f.title, c.name FROM film f, film_category fc, category c
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id;