-- Base de datos
DROP DATABASE IF EXISTS tienda_musica;
CREATE DATABASE tienda_musica;
USE tienda_musica;

-- Tablas
-- Borrado de tablas
DROP TABLE IF EXISTS compra;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS disco;
DROP TABLE IF EXISTS escribe;
DROP TABLE IF EXISTS cancion;
DROP TABLE IF EXISTS album;
DROP TABLE IF EXISTS artista;

-- Tabla Artista
CREATE TABLE artista (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30),
    edad INT,
    seguidores INT
);

-- Tabla Album
CREATE TABLE album (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) UNIQUE,
    fecha_lanzamiento DATE
);

-- Tabla Cancion
CREATE TABLE cancion (
	id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(30) UNIQUE,
    genero VARCHAR(20),
    duracion VARCHAR(10),
    id_album INT,
    CONSTRAINT fk_cancion FOREIGN KEY (id_album) REFERENCES album (id)
);

-- Tabla escribe
CREATE TABLE escribe (
	id_artista INT,
    id_cancion INT,
    CONSTRAINT pk_escribe PRIMARY KEY (id_artista, id_cancion),
    CONSTRAINT fk_escribe FOREIGN KEY (id_artista) REFERENCES artista (id),
    CONSTRAINT fk_escribe2 FOREIGN KEY (id_cancion) REFERENCES cancion (id)
);

-- Tabla Disco
CREATE TABLE disco (
	numero INT PRIMARY KEY AUTO_INCREMENT,
    estado VARCHAR(10),
    precio FLOAT,
    id_cancion INT,
    CONSTRAINT fk_disco FOREIGN KEY (id_cancion) REFERENCES cancion (id),
    CONSTRAINT check_estado CHECK (estado IN ('Nuevo', 'Usado'))
);

-- Tabla Cliente
CREATE TABLE cliente (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30),
    apellidos VARCHAR(40),
    dni CHAR(9) UNIQUE,
    fecha_nacimiento DATE,
    direccion VARCHAR(50)
);

-- Tabla compra
CREATE TABLE compra (
	num_disco INT,
    id_cliente INT,
    fecha_compra DATE,
    CONSTRAINT pk_compra PRIMARY KEY (num_disco, id_cliente),
    CONSTRAINT fk_compra FOREIGN KEY (num_disco) REFERENCES disco (numero),
    CONSTRAINT fk_compra2 FOREIGN KEY (id_cliente) REFERENCES cliente (id)
);
