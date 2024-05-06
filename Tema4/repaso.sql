-- Base de datos
DROP DATABASE IF EXISTS repaso;
CREATE DATABASE repaso;
USE repaso;

CREATE TABLE estudiantes (
	id_estudiante INT PRIMARY KEY,
    nombre VARCHAR(50),
    edad INT,
    promedio FLOAT,
    id_curso INT
);

INSERT INTO estudiantes VALUES
	(1,'Ana', 20, 85.5, 101),
    (2,'Juan', 22, 78.9, 102),
    (3,'María', 21, 92.3, 101),
    (4,'Carlos', 23, 75.8, 103),
    (5,'Luis', 20, 88.6, 102),
    (6,'Elena', 22, 94.2, 101),
    (7,'Pablo', 24, 79.5, 103),
    (8,'Sofía', 21, 90.1, 102);


-- Consultas
-- 1. Calcular el promedio de edad por curso.
SELECT id_curso, round(avg(edad), 2) AS promedio_edad FROM estudiantes GROUP BY id_curso;

-- 2. Calcular el promedio de edad por curso de los estudiantes mayores de 21.
SELECT id_curso, round(avg(edad), 2) AS promedio_edad FROM estudiantes WHERE edad > 21 GROUP BY id_curso;

-- 3. Calcular el promedio de edad por curso y mostrar solo aquellos cursos donde el promedio de edad sea mayor a 21.
SELECT id_curso, round(avg(edad), 2) AS promedio_edad FROM estudiantes GROUP BY id_curso HAVING promedio_edad > 21;

-- 4. Encontrar el curso con el promedio de calificaciones más alto, mostrando el curso y el promedio.
SELECT id_curso, max(promedio) AS max_promedio FROM estudiantes GROUP BY id_curso ORDER BY max_promedio DESC LIMIT 1;

-- 5. Contar la cantidad de estudiantes por curso y mostrar solo aquellos cursos con más de dos estudiantes.
SELECT id_curso, count(id_estudiante) AS cantidad_estudiantes FROM estudiantes GROUP BY id_curso HAVING cantidad_estudiantes > 2;

-- 6. Mostrar el nombre y la edad del estudiante más joven en cada curso.
SELECT id_curso, nombre, edad FROM estudiantes WHERE edad IN
	(SELECT min(edad) FROM estudiantes GROUP BY id_curso)
ORDER BY id_curso;

-- 7. Calcular el promedio de calificaciones por curso y mostrar solo aquellos cursos con un promedio superior a 80 y al menos 3 estudiantes.
SELECT id_curso, round(avg(promedio), 2) AS media_calificaciones FROM estudiantes GROUP BY id_curso
HAVING media_calificaciones > 80 AND count(id_estudiante) >= 3;