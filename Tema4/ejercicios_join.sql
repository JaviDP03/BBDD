/* 1. Devuelve un listado de todos los fabricantes que existen en la base de datos,
junto con los productos que tiene cada uno de ellos.
El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados. */
SELECT f.nombre, p.nombre FROM fabricante f LEFT JOIN producto p ON f.id = p.id_fabricante;

/* 2. Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan.
Este listado también debe incluir los empleados que no tienen ningún departamento asociado. */
SELECT e.*, d.* FROM empleado e LEFT JOIN departamento d ON e.id_departamento = d.id;

-- 3. Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.
SELECT e.* FROM empleado e LEFT JOIN departamento d ON e.id_departamento = d.id WHERE d.id IS NULL;

-- 4. Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.
SELECT d.* FROM empleado e RIGHT JOIN departamento d ON e.id_departamento = d.id WHERE e.id_departamento IS NULL;

/* 5. Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan.
El listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos que
no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento. */
SELECT * FROM empleado e LEFT JOIN departamento d ON e.id_departamento = d.id
UNION
SELECT * FROM empleado e RIGHT JOIN departamento d ON e.id_departamento = d.id;