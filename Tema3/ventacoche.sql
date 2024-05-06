DROP DATABASE IF EXISTS ventaCoche;
CREATE DATABASE ventaCoche;
USE ventaCoche;

CREATE TABLE cliente (
    codCliente CHAR(4) PRIMARY KEY,
    dni CHAR(9) UNIQUE,
    nombre VARCHAR(30) NOT NULL,
    direccion VARCHAR(50)
);

CREATE TABLE coche (
    matricula CHAR(8) PRIMARY KEY,
    marca VARCHAR(10),
    modelo VARCHAR(10),
    color VARCHAR(15),
    precioHora DECIMAL(3 , 2 )
);

CREATE TABLE reserva (
    numero INT PRIMARY KEY,
    fechaInicio DATE,
    fechaFin DATE,
    precioTotal INT,
    codCliente CHAR(4) REFERENCES cliente (codCliente)
);

CREATE TABLE avala (
    avalado CHAR(4) PRIMARY KEY REFERENCES cliente (codCliente),
    avalador CHAR(4) REFERENCES cliente (codCliente)
);

CREATE TABLE incluye (
    numero INT REFERENCES reserva (numero),
    matricula CHAR(8) REFERENCES coche (matricula),
    litrosGas INT,
    CONSTRAINT pk_incluye PRIMARY KEY (numero , matricula)
);