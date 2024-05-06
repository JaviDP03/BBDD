-- Scrip creación de base de datos
-- Creación de la tabla de departamentos

CREATE DATABASE examenSubconsultas;
USE examenSubconsultas; 


CREATE TABLE departamentos (
    id_departamento INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Creación de la tabla de empleados
CREATE TABLE empleados (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    id_departamento INT,
    id_oficina INT,
    trabajo VARCHAR(50),
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
    -- ,FOREIGN KEY (id_oficina) REFERENCES oficinas(id_oficina)
);

-- Creación de la tabla de proyectos
CREATE TABLE proyectos (
    id_proyecto INT PRIMARY KEY,
    nombre_proyecto VARCHAR(100) NOT NULL
);

-- Creación de la tabla de asignaciones
CREATE TABLE asignaciones (
    id_asignacion INT PRIMARY KEY,
    id_proyecto INT,
    id_empleado INT,
    horas_asignadas INT,
    FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);
