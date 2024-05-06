-- Examen Hospital		Javier Duarte Pérez
USE hospital_universitario;

-- Ejercicio 2
SELECT dni, nombre FROM paciente WHERE dni NOT IN
	(SELECT dni_paciente FROM ingreso);

-- Ejercicio 4
SELECT c.cod, concat(h.nombre, '-', c.nombre) AS 'hab-cama' FROM cama c, habitacion h, ingreso i WHERE c.cod_habitacion = h.cod AND c.cod = i.cod_cama AND c.cod IN
	(SELECT cod_cama FROM ingreso) AND fechaSalida IS NULL;

-- Ejercicio 5
SELECT count(c.cod) AS 'Camas Disp' FROM cama c, ingreso i WHERE c.cod = i.cod_cama AND (c.cod NOT IN
	(SELECT cod_cama FROM ingreso)
OR i.fechaSalida IS NOT NULL);

-- Ejercicio 6
SELECT p.nombre, i.fechaEntrada FROM paciente p, ingreso i WHERE p.dni = i.dni_paciente AND i.fechaEntrada = curdate();

-- Ejercicio 7
SELECT * FROM habitacion WHERE cod NOT IN
	(SELECT cod_habitacion FROM cama WHERE cod IN
		(SELECT cod_cama FROM ingreso));
        
-- Ejercicio 9
SELECT m.dni, concat(m.nombre, ' ', m.apellidos) AS médico, e.nombre AS especialidad FROM medico m, especialidad e WHERE m.cod_especialidad = e.cod;

-- Ejercicio 10
SELECT e.nombre AS especialidad, count(m.dni) AS médicos FROM especialidad e, medico m WHERE e.cod = m.cod_especialidad GROUP BY m.cod_especialidad;

-- Ejercicio 12
SELECT nombre AS habitacion,
	(SELECT count(*) FROM cama WHERE cod_habitacion NOT IN
		(SELECT cod FROM habitacion))
AS num_camas FROM habitacion WHERE cod NOT IN
	(SELECT cod_habitacion FROM cama);
    
-- Ejercicio 13
SELECT h.nombre AS habitacion, c.nombre AS cama, i.cod AS cod_ingreso, i.fechaEntrada, i.fechaSalida FROM habitacion h, cama c, ingreso i
WHERE h.cod = c.cod_habitacion AND c.cod = i.cod_cama AND fechaSalida IS NULL;

-- Ejercicio 14
SELECT h.nombre AS habitacion, c.nombre AS cama, i.cod AS cod_ingreso, i.fechaEntrada, i.fechaSalida FROM habitacion h, cama c, ingreso i
WHERE h.cod = c.cod_habitacion AND c.cod = i.cod_cama AND fechaSalida IS NOT NULL OR i.cod_cama NOT IN (SELECT cod FROM cama);

-- Ejercicio 16
SELECT h.nombre AS habitacion, c.nombre AS cama, count(i.dni_paciente) AS 'pacientes actuales' FROM habitacion h, cama c, ingreso i
WHERE h.cod = c.cod_habitacion AND c.cod = i.cod_cama AND i.fechaSalida IS NULL GROUP BY i.dni_paciente;

-- Ejercicio 20
SELECT concat(p.nombre, ' ', p.apellidos) AS paciente , i.fechaEntrada, year(curdate()) - year(p.fechaNacimiento) AS edad FROM paciente p, ingreso i
WHERE p.dni = i.dni_paciente AND i.fechaSalida IS NULL;

-- Ejercicio 22
SELECT count(dni) AS Dermatólogos FROM medico WHERE cod_especialidad IN
	(SELECT cod FROM especialidad WHERE nombre = 'Dermatologia');

-- Ejercicio 24
SELECT concat(p.nombre, ' ', p.apellidos) AS paciente, e.nombre, i.fechaEntrada, concat('Dr/a', ' ', m.nombre, ' ', m.apellidos) AS medico
FROM paciente p, ingreso i, medico m, especialidad e
WHERE p.dni = i.dni_paciente AND m.dni = i.dni_medico AND e.cod = m.cod_especialidad AND fechaSalida IS NULL;

-- Ejercicio 25
SELECT concat(p.nombre, ' ', p.apellidos) AS paciente, e.nombre AS especialidad, i.fechaEntrada, concat('Dr/a', ' ', m.nombre, ' ', m.apellidos) AS medico, h.nombre AS habitacion
FROM paciente p, ingreso i, medico m, especialidad e, cama c, habitacion h
WHERE p.dni = i.dni_paciente AND m.dni = i.dni_medico AND e.cod = m.cod_especialidad AND i.cod_cama = c.cod AND c.cod_habitacion = h.cod AND h.nombre NOT LIKE 'NE%'
AND cod_especialidad IN
	(SELECT cod FROM especialidad WHERE nombre = 'Neurologia');

-- Ejercicio 28
SELECT e.nombre, count(i.cod) AS 'pacientes actuales' FROM especialidad e, ingreso i, medico m
WHERE e.cod = m.cod_especialidad AND m.dni = i.dni_medico AND fechaSalida IS NULL GROUP BY e.cod;