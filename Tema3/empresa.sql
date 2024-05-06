DROP DATABASE IF EXISTS empresa;
CREATE DATABASE empresa;
USE empresa;

DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS localidad;
DROP TABLE IF EXISTS provincia;
DROP TABLE IF EXISTS region;


CREATE TABLE region (
    codRegion CHAR(5) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL
);

CREATE TABLE provincia (
    codProvincia CHAR(5) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    codRegion CHAR(5) REFERENCES region (codRegion)
);

CREATE TABLE localidad (
    codLocalidad CHAR(5) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    codProvincia CHAR(5) REFERENCES provincia (codProvincia)
);

CREATE TABLE empleado (
    id CHAR(5) PRIMARY KEY,
    dni CHAR(9) UNIQUE,
    nombre VARCHAR(30) NOT NULL,
    fechaNac DATE,
    telefono CHAR(9),
    salario DOUBLE,
    codLocalidad CHAR(5) REFERENCES localidad (codLocalidad)
);


INSERT INTO region VALUES (45678, 'Andalucía');
INSERT INTO region VALUES (12345, 'País Vasco');
INSERT INTO region VALUES (23456, 'Cataluña');
INSERT INTO region VALUES (34567, 'Castilla-Mancha');
INSERT INTO region VALUES (86454, 'Extremadura');
INSERT INTO region VALUES (24576, 'Castilla León');
INSERT INTO region VALUES (92456, 'Galicia');

INSERT INTO provincia VALUES (41000, 'Sevilla', 45678);
INSERT INTO provincia (codProvincia, nombre, codRegion) VALUES (31000, 'Córdoba', 45678);
INSERT INTO provincia VALUES (21000, 'Cádiz', 45678);
INSERT INTO provincia VALUES (55000, 'Lleida', 23456);
INSERT INTO provincia VALUES (65000, 'Barcelona', 23456);
INSERT INTO provincia VALUES (11000, 'Bilbao', 12345);
INSERT INTO provincia VALUES (12000, 'Álava', 12345);
INSERT INTO provincia VALUES (77000, 'Tarragona', 23456);
INSERT INTO provincia VALUES (44000, 'A Coruña', 92456);
INSERT INTO provincia VALUES (33000, 'Cáceres', 86454);

INSERT INTO provincia VALUES (21500, 'Jerez de la Frontera', 21000);
INSERT INTO provincia VALUES (41400, 'Écija', 41000);
INSERT INTO provincia VALUES (31700, 'Cabra', 31000);

INSERT INTO empleado VALUES (53421, '12345678B', 'Paco Sanz', '1999-01-30', 123456789, 1259.89, 21500);
INSERT INTO empleado VALUES (84643, '54676109J', 'Pepe Díaz', '2005-12-31', 743453467, 1890.12, 41400);
INSERT INTO empleado VALUES (23467, '23537657K', 'Roberta Rodríguez', '2001-05-01', 754345876, 2000.54, 31700);

SELECT provincia.nombre AS 'Provincia', region.nombre AS 'Región' FROM provincia, region WHERE provincia.codRegion = region.codRegion;
SELECT nombre FROM empleado WHERE salario < 2000;
SELECT dni, nombre FROM empleado WHERE codLocalidad = 41400;
SELECT fechaNac FROM empleado WHERE nombre LIKE 'P%';