-- Ejercicio 1
-- Creación base de datos
DROP DATABASE IF EXISTS BD_ejemploEx1;
CREATE DATABASE BD_ejemploEx1;
USE BD_ejemploEx1;

-- Creación de tablas
CREATE TABLE empleado (
	idEmpleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    sueldo INT,
    fec_incorporacion DATE,
    jefe INT,
    CONSTRAINT fk_empleado FOREIGN KEY (jefe) REFERENCES empleado (idEmpleado)
);

CREATE TABLE proyecto (
	idProyecto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20),
    fecInicio DATE,
    subvencion BOOLEAN
);

ALTER TABLE proyecto
	AUTO_INCREMENT = 1000;

CREATE TABLE emp_pro (
	idEmpleado INT,
    idProyecto INT,
    anno INT,
    porAsignacion VARCHAR(10),
    CONSTRAINT pk_emppro PRIMARY KEY (idEmpleado, idProyecto, anno),
    CONSTRAINT fk1_emppro FOREIGN KEY (idEmpleado) REFERENCES empleado (idEmpleado),
    CONSTRAINT fk2_emppro FOREIGN KEY (idProyecto) REFERENCES proyecto (idProyecto)
);


-- Ejercicio 2
ALTER TABLE empleado
	ADD productividad INT DEFAULT 0 NOT NULL;


-- Ejercicio 3
-- Tabla empleado
INSERT INTO empleado (nombre, apellido, sueldo, fec_incorporacion, jefe)
	VALUES ('Luis', 'Bonilla', 50000, '2020-10-10', null);
INSERT INTO empleado (nombre, apellido, sueldo, fec_incorporacion, jefe)
	VALUES ('Jose', 'Fernandez', 50000, '2020-10-10', null);
INSERT INTO empleado (nombre, apellido, sueldo, fec_incorporacion, jefe)
	VALUES ('Lola', 'Fuentes', 25000, '2020-10-10', 1);
INSERT INTO empleado (nombre, apellido, sueldo, fec_incorporacion, jefe)
	VALUES ('Sergio', 'Arroyo', 25000, '2021-01-01', 2);
INSERT INTO empleado (nombre, apellido, sueldo, fec_incorporacion, jefe)
	VALUES ('Ana', 'Ruiz', 30000, '2021-02-01', 2);
    
-- Tabla proyecto
INSERT INTO proyecto (nombre, fecInicio, subvencion)
	VALUES ('EciGarajes', '2020-10-10', true);
INSERT INTO proyecto (nombre, fecInicio, subvencion)
	VALUES ('AguasIberia', '2020-12-12', true);
INSERT INTO proyecto (nombre, fecInicio, subvencion)
	VALUES ('SideCar', '2021-01-01', false);
    
-- Tabla emp_pro
INSERT INTO emp_pro
	VALUES (1, 1000, 2020, '100%');
INSERT INTO emp_pro
	VALUES (2, 1001, 2020, '50%');
INSERT INTO emp_pro
	VALUES (2, 1002, 2021, '50%');
INSERT INTO emp_pro
	VALUES (3, 1000, 2020, '100%');
INSERT INTO emp_pro
	VALUES (4, 1001, 2021, '100%');
INSERT INTO emp_pro
	VALUES (5, 1002, 2021, '75%');
    
    
-- Ejercicio 4
UPDATE emp_pro
	SET porAsignacion = '50%' WHERE idEmpleado = 1;