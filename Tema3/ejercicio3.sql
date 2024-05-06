DROP DATABASE IF EXISTS ejercicio3;
CREATE DATABASE ejercicio3;
USE ejercicio3;


-- Forma 1
CREATE TABLE departamento (
    id INT,
    nombre VARCHAR(39),
    ubicacion VARCHAR(50)
);

ALTER TABLE departamento
ADD CONSTRAINT pk_iddep PRIMARY KEY (id);

CREATE TABLE empleado (
    id INT,
    dni CHAR(9),
    nombre VARCHAR(30),
    salario DECIMAL(5 , 2 ),
    telefono CHAR(9),
    id_dep INT
);

ALTER TABLE empleado
ADD CONSTRAINT pk_idem PRIMARY KEY (id),
ADD CONSTRAINT uq_emp UNIQUE (dni, nombre, salario, telefono),
ADD CONSTRAINT fk_iddep FOREIGN KEY (id_dep) REFERENCES departamento (id) ON DELETE CASCADE;

CREATE TABLE jefe (
    id INT,
    dni CHAR(9),
    nombre VARCHAR(30),
    salario DECIMAL(5 , 2 ),
    telefono CHAR(9),
    id_dep INT
);

ALTER TABLE jefe
ADD CONSTRAINT pk_idjefe PRIMARY KEY (id),
ADD CONSTRAINT uq_jefe UNIQUE (dni, nombre, salario, telefono),
ADD CONSTRAINT fk_iddep2 FOREIGN KEY (id_dep) REFERENCES departamento (id) ON DELETE CASCADE;


-- Forma 2
CREATE TABLE departamento (
    id INT,
    nombre VARCHAR(39),
    ubicacion VARCHAR(50),
    CONSTRAINT pk_iddep PRIMARY KEY (id)
);

CREATE TABLE empleado (
    id INT,
    dni CHAR(9),
    nombre VARCHAR(30),
    salario DECIMAL(5 , 2 ),
    telefono CHAR(9),
    id_dep INT,
    CONSTRAINT pk_idem PRIMARY KEY (id),
    CONSTRAINT uq_emp UNIQUE (dni , nombre , salario , telefono),
    CONSTRAINT fk_iddep FOREIGN KEY (id_dep)
        REFERENCES departamento (id)
        ON DELETE CASCADE
);

CREATE TABLE jefe (
    id INT,
    dni CHAR(9),
    nombre VARCHAR(30),
    salario DECIMAL(5 , 2 ),
    telefono CHAR(9),
    id_dep INT,
    CONSTRAINT pk_idjefe PRIMARY KEY (id),
    CONSTRAINT uq_jefe UNIQUE (dni , nombre , salario , telefono),
    CONSTRAINT fk_iddep2 FOREIGN KEY (id_dep)
        REFERENCES departamento (id)
        ON DELETE CASCADE
);


-- Forma 3
CREATE TABLE departamento (
    id INT PRIMARY KEY,
    nombre VARCHAR(39),
    ubicacion VARCHAR(50)
);

CREATE TABLE empleado (
    id INT PRIMARY KEY,
    dni CHAR(9) UNIQUE,
    nombre VARCHAR(30) UNIQUE,
    salario DECIMAL(5 , 2 ) UNIQUE,
    telefono CHAR(9) UNIQUE,
    id_dep INT REFERENCES departamento (id)
    ON DELETE CASCADE
);

CREATE TABLE jefe (
    id INT PRIMARY KEY,
    dni CHAR(9) UNIQUE,
    nombre VARCHAR(30) UNIQUE,
    salario DECIMAL(5 , 2 ) UNIQUE,
    telefono CHAR(9) UNIQUE,
    id_dep INT REFERENCES departamento (id)
    ON DELETE CASCADE
);