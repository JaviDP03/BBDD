USE empleados;

-- 1. Devuelve un listado con todos los empleados que tiene el departamento de Sistemas. (Sin utilizar INNER JOIN).
SELECT * FROM empleado WHERE id_departamento = (SELECT id FROM departamento WHERE upper(nombre) = 'SISTEMAS');

-- 2. Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada.
SELECT nombre, presupuesto FROM departamento WHERE presupuesto = (SELECT max(presupuesto) FROM departamento);

-- 3. Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada.
SELECT nombre, presupuesto FROM departamento WHERE presupuesto = (SELECT min(presupuesto) FROM departamento);

-- 8. Devuelve los nombres de los departamentos que tienen empleados asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM departamento WHERE id IN (SELECT id_departamento FROM empleado);

-- 9. Devuelve los nombres de los departamentos que no tienen empleados asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM departamento WHERE id NOT IN (SELECT id_departamento FROM empleado);