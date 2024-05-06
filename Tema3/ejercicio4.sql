DROP DATABASE IF EXISTS ejercicio4;
CREATE DATABASE ejercicio4;
USE ejercicio4;


-- Forma 1
CREATE TABLE cliente (
    nif CHAR(9),
    nombre VARCHAR(30),
    direccion VARCHAR(50),
    telefono CHAR(9)
);

ALTER TABLE cliente
ADD CONSTRAINT pk_nif PRIMARY KEY (nif);

CREATE TABLE modeloDormitorio (
    codigo INT
);

ALTER TABLE modeloDormitorio
ADD CONSTRAINT pk_codigo PRIMARY KEY (codigo);

CREATE TABLE montador (
    nif CHAR(9),
    nombre VARCHAR(30),
    direccion VARCHAR(50),
    telefono CHAR(9)
);

ALTER TABLE montador
ADD CONSTRAINT pk_nifmonta PRIMARY KEY (nif);

CREATE TABLE compra (
    nif_c CHAR(9),
    modelo INT,
    fechaCompra DATE
);

ALTER TABLE compra
ADD CONSTRAINT pk_compra PRIMARY KEY (nif_c, modelo, fechaCompra),
ADD CONSTRAINT fk_nifc FOREIGN KEY (nif_c) REFERENCES cliente (nif) ON DELETE CASCADE,
ADD CONSTRAINT fk_modelo FOREIGN KEY (modelo) REFERENCES modeloDormitorio (codigo) ON DELETE CASCADE;

CREATE TABLE monta (
    modelo INT,
    nif_monta CHAR(9),
    fechaMontaje DATE
);

ALTER TABLE monta
ADD CONSTRAINT pk_monta PRIMARY KEY (modelo, nif_monta, fechaMontaje),
ADD CONSTRAINT fk_modelo2 FOREIGN KEY (modelo) REFERENCES modeloDormitorio (codigo) ON DELETE CASCADE,
ADD CONSTRAINT fk_nifmonta FOREIGN KEY (nif_monta) REFERENCES montador (nif) ON DELETE CASCADE;


-- Forma 2
CREATE TABLE cliente (
    nif CHAR(9),
    nombre VARCHAR(30),
    direccion VARCHAR(50),
    telefono CHAR(9),
    CONSTRAINT pk_nif PRIMARY KEY (nif)
);

CREATE TABLE modeloDormitorio (
    codigo INT,
    CONSTRAINT pk_codigo PRIMARY KEY (codigo)
);

CREATE TABLE montador (
    nif CHAR(9),
    nombre VARCHAR(30),
    direccion VARCHAR(50),
    telefono CHAR(9),
    CONSTRAINT pk_nifmonta PRIMARY KEY (nif)
);

CREATE TABLE compra (
    nif_c CHAR(9),
    modelo INT,
    fechaCompra DATE,
    CONSTRAINT pk_compra PRIMARY KEY (nif_c , modelo , fechaCompra),
    CONSTRAINT fk_nifc FOREIGN KEY (nif_c)
        REFERENCES cliente (nif)
        ON DELETE CASCADE,
    CONSTRAINT fk_modelo FOREIGN KEY (modelo)
        REFERENCES modeloDormitorio (codigo)
        ON DELETE CASCADE
);

CREATE TABLE monta (
    modelo INT,
    nif_monta CHAR(9),
    fechaMontaje DATE,
    CONSTRAINT pk_monta PRIMARY KEY (modelo , nif_monta , fechaMontaje),
    CONSTRAINT fk_modelo2 FOREIGN KEY (modelo)
        REFERENCES modeloDormitorio (codigo)
        ON DELETE CASCADE,
    CONSTRAINT fk_nifmonta FOREIGN KEY (nif_monta)
        REFERENCES montador (nif)
        ON DELETE CASCADE
);


-- Forma 3
CREATE TABLE cliente (
    nif CHAR(9) PRIMARY KEY,
    nombre VARCHAR(30),
    direccion VARCHAR(50),
    telefono CHAR(9)
);

CREATE TABLE modeloDormitorio (
    codigo INT PRIMARY KEY
);

CREATE TABLE montador (
    nif CHAR(9) PRIMARY KEY,
    nombre VARCHAR(30),
    direccion VARCHAR(50),
    telefono CHAR(9)
);

CREATE TABLE compra (
    nif_c CHAR(9) REFERENCES cliente (nif)
    ON DELETE CASCADE,
    modelo INT REFERENCES modeloDormitorio (codigo)
    ON DELETE CASCADE,
    fechaCompra DATE,
    CONSTRAINT pk_compra PRIMARY KEY (nif_c , modelo , fechaCompra)
);

CREATE TABLE monta (
    modelo INT REFERENCES modeloDormitorio (codigo)
    ON DELETE CASCADE,
    nif_monta CHAR(9) REFERENCES montador (nif)
    ON DELETE CASCADE,
    fechaMontaje DATE,
    CONSTRAINT pk_monta PRIMARY KEY (modelo , nif_monta , fechaMontaje)
);