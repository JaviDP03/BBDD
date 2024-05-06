DROP DATABASE IF EXISTS ejercicio7;
CREATE DATABASE ejercicio7;
USE ejercicio7;

CREATE TABLE director (
    nombre VARCHAR(30) PRIMARY KEY,
    nacionalidad VARCHAR(20)
);

CREATE TABLE pelicula (
    id CHAR(4) PRIMARY KEY,
    titulo VARCHAR(30) NOT NULL,
    productora VARCHAR(20),
    nacionalidad VARCHAR(20),
    fecha DATE,
    director VARCHAR(30) REFERENCES director (nombre)
);

CREATE TABLE ejemplar (
    id_peli CHAR(4) REFERENCES pelicula (id),
    numero INT,
    estado VARCHAR(10),
    CONSTRAINT pk_ejemplar PRIMARY KEY (id_peli , numero)
);

CREATE TABLE actores (
    nombre VARCHAR(30) PRIMARY KEY,
    nacionalidad VARCHAR(10),
    sexo VARCHAR(10),
    CHECK (sexo IN ('HOMBRE' , 'MUJER'))
);

CREATE TABLE socio (
    dni CHAR(9) PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    direccion VARCHAR(50),
    telefono CHAR(9),
    avalador CHAR(9) REFERENCES socio (dni)
);

CREATE TABLE actua (
    actor VARCHAR(30) REFERENCES actores (nombre),
    id_peli CHAR(4) REFERENCES pelicula (id),
    prota VARCHAR(5),
    CONSTRAINT pk_actua PRIMARY KEY (actor , id_peli),
    CHECK (id_peli IN ('SI' , 'NO'))
);

CREATE TABLE alquila (
    dni CHAR(9) REFERENCES socio (dni),
    id_peli CHAR(4),
    numero INT,
    fechaAlquiler DATE,
    fechaDevolucion DATE,
    CONSTRAINT pk_alquila PRIMARY KEY (dni , id_peli , numero , fechaAlquiler),
    CONSTRAINT fk_peli FOREIGN KEY (id_peli , numero)
        REFERENCES ejemplar (id_peli , numero)
);