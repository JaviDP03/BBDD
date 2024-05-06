DROP DATABASE IF EXISTS periodismo;
CREATE DATABASE periodismo;
USE periodismo;

CREATE TABLE sucursal (
    codigo CHAR(4) PRIMARY KEY,
    direccion VARCHAR(50),
    telefono CHAR(9)
);

CREATE TABLE periodista (
    dni CHAR(9) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    direccion VARCHAR(50),
    telefono CHAR(9),
    especialista VARCHAR(20)
);

CREATE TABLE empleado (
    dni CHAR(9) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    direccion VARCHAR(50),
    telefono CHAR(9),
    sucursal CHAR(4) REFERENCES sucursal (codigo)
);

CREATE TABLE revista (
    numReg CHAR(4),
    titulo VARCHAR(30) NOT NULL,
    periodicidad VARCHAR(20) DEFAULT 'MENSUAL',
    tipo VARCHAR(20),
    sucursal CHAR(4) REFERENCES sucursal (codigo),
    CHECK (periodicidad IN ('MENSUAL' , 'SEMANAL', 'TRIMESTRAL', 'ANUAL'))
);

CREATE TABLE escribe (
    numReg CHAR(4) REFERENCES revista (numReg),
    dni_per CHAR(9) REFERENCES periodista (dni),
    CONSTRAINT pk_escribe PRIMARY KEY (numReg , dni_per)
);

CREATE TABLE numRevista (
    numReg CHAR(4) REFERENCES revista (numReg),
    numero INT,
    numPaginas INT,
    fecha DATE,
    cantVendidas INT,
    CONSTRAINT pk_numrevista PRIMARY KEY (numReg , numero),
    CHECK (numPaginas > 0)
);