-- Examen Consultas MySQL	Javier Duarte Pérez

-- Ejercicio 1
SELECT * FROM empleados WHERE nombre LIKE '%Perez%' AND salario >= 60000;

-- Ejercicio 2
SELECT count(id_empleado) AS empleados_programadores FROM empleados WHERE trabajo = 'Programador';

-- Ejercicio 3
SELECT id_asignacion, count(id_empleado) AS num_empleados FROM asignaciones GROUP BY id_empleado HAVING num_empleados > 1;

-- Ejercicio 4
SELECT p.nombre_proyecto, count(a.id_empleado) AS num_empleados FROM proyectos p, asignaciones a
WHERE p.id_proyecto = a.id_proyecto GROUP BY p.id_proyecto;

-- Ejercicio 5
SELECT p.nombre_proyecto, sum(a.horas_asignadas) AS horas_totales FROM proyectos p, asignaciones a
WHERE p.id_proyecto = a.id_proyecto GROUP BY a.id_proyecto ORDER BY horas_totales ASC LIMIT 1;

-- Ejercicio 6
SELECT d.nombre, round(avg(e.salario), 2) AS salario_medio FROM empleados e, departamentos d
WHERE d.id_departamento = e.id_departamento GROUP BY e.id_departamento HAVING avg(e.salario) > 50000;

-- Ejercicio 7
SELECT id_departamento, max(salario) AS salario_maximo FROM empleados GROUP BY id_departamento HAVING count(id_departamento) >= 2;

-- Ejercicio 8
SELECT id_proyecto, count(id_asignacion) AS tareas_asignadas FROM asignaciones GROUP BY id_proyecto HAVING tareas_asignadas > 2;

-- Ejercicio 9
SELECT nombre FROM empleados WHERE salario IN
	(SELECT max(salario) FROM empleados GROUP BY id_departamento)
GROUP BY id_departamento;

-- Ejercicio 10
SELECT d.nombre FROM empleados e, departamentos d
WHERE e.id_departamento = d.id_departamento GROUP BY e.id_departamento HAVING avg(salario) >
	(SELECT max(salario) FROM empleados WHERE id_departamento =
		(SELECT id_departamento FROM departamentos WHERE nombre = 'Contabilidad'));

-- Ejercicio 11
SELECT id_proyecto, sum(horas_asignadas) AS total_horas FROM asignaciones GROUP BY id_proyecto;