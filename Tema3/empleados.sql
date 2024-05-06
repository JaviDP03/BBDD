DROP DATABASE IF EXISTS empleados;
CREATE DATABASE empleados;
USE empleados;

CREATE TABLE region (
    codRegion INT PRIMARY KEY,
    nombre VARCHAR(30)
);

CREATE TABLE provincia (
    codProvincia INT PRIMARY KEY,
    nombre VARCHAR(30),
    codRegion INT REFERENCES region (codRegion)
);

CREATE TABLE localidad (
    codLocalidad INT PRIMARY KEY,
    nombre VARCHAR(30),
    codProvincia INT REFERENCES provincia (codProvincia)
);

CREATE TABLE empleado (
    id INT PRIMARY KEY,
    dni CHAR(9) UNIQUE,
    nombre VARCHAR(30),
    fechaNac DATE,
    telefono CHAR(9),
    salario DECIMAL(5, 2),
    codLocalidad INT REFERENCES localidad (codLocalidad)
);