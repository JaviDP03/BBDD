-- Datos para examenSubconsultas
-- Inserción de datos en la tabla de departamentos
INSERT INTO departamentos (id_departamento, nombre) VALUES
(1, 'Ventas'),
(2, 'Contabilidad'),
(3, 'Desarrollo'),
(4, 'Calidad');

-- Inserción de datos en la tabla de empleados
INSERT INTO empleados (id_empleado, nombre, salario, id_departamento, id_oficina, trabajo) VALUES
(101, 'Juan Perez', 60000, 1, 1, 'Vendedor'),
(102, 'Maria Rodriguez', 55000, 1, 1, 'Vendedor'),
(201, 'Carlos Gomez', 70000, 2, 2, 'Contador'),
(202, 'Ana Martinez', 65000, 2, 2, 'Contador'),
(301, 'Luis Ramirez', 80000, 3, 3, 'Programador'),
(302, 'Elena Lopez', 75000, 3, 3, 'Analista'),
(401, 'Angela Perez', 75000, 4, 4, 'Quality Manager');

-- Inserción de datos en la tabla de proyectos
INSERT INTO proyectos (id_proyecto, nombre_proyecto) VALUES
(1, 'Proyecto A'),
(2, 'Proyecto B'),
(3, 'Proyecto C');

-- Inserción de datos en la tabla de asignaciones
INSERT INTO asignaciones (id_asignacion, id_proyecto, id_empleado, horas_asignadas) VALUES
(1, 1, 101, 20),
(2, 1, 102, 25),
(3, 2, 201, 30),
(4, 2, 202, 35),
(5, 3, 301, 40),
(6, 3, 302, 45);
