DROP DATABASE IF EXISTS examenDML_JavierDuarte;
-- Examen BBDD	Javier Duarte Pérez
-- Ejercicio 1
CREATE DATABASE IF NOT EXISTS examenDML_JavierDuarte;

-- Ejercicio 2
-- Usar base de datos
USE examenDML_JavierDuarte;

-- Crear tablas
CREATE TABLE productos (
	idProducto INT PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL,
    ean13 CHAR(13) UNIQUE,
    precio DOUBLE,
    modelo VARCHAR(5),
    CONSTRAINT precio_producto_ck CHECK (precio >= 0)
);

CREATE TABLE clientes (
	dni CHAR(9) PRIMARY KEY,
    nombre VARCHAR(25) NOT NULL,
    apellidos VARCHAR(50),
    tipoCliente VARCHAR(10),
    fechaAlta DATETIME DEFAULT CURRENT_TIMESTAMP,
    edad INT DEFAULT 18,
    CONSTRAINT valores_tipoCliente_ck CHECK (tipoCliente IN ('NUEVO', 'NORMAL', 'VIP'))
);

CREATE TABLE pedidos (
	idPedido INT PRIMARY KEY AUTO_INCREMENT,
    dniCliente CHAR(9),
    fechaPedido DATETIME,
    CONSTRAINT fk_dniCliente FOREIGN KEY (dniCliente) REFERENCES clientes (dni),
    CONSTRAINT fechaPedido_ck CHECK (TIME(fechaPedido) BETWEEN '08:00:00' AND '20:00:00')
    /* Este constraint lo he intentado de varias formas, creo que con el guión bajo es lo más cercano,
    pero al introducir datos me dice que no cumplo la restricción */
);

ALTER TABLE pedidos
	AUTO_INCREMENT = 10000;

CREATE TABLE detallepedido (
	idPedido INT,
    idProducto INT,
    cantidad INT,
    CONSTRAINT pk_detallepedido PRIMARY KEY (idPedido, idProducto),
    CONSTRAINT fk_idPedido FOREIGN KEY (idPedido) REFERENCES pedidos (idPedido),
    CONSTRAINT fk_idProducto FOREIGN KEY (idProducto) REFERENCES productos (idProducto)
);

-- Ejercicio 3
ALTER TABLE clientes
	DROP edad,
    ADD fechaNac DATE,
    ADD CONSTRAINT fechaNac_ck CHECK (fechaNac < '1995-06-01');

-- Ejercicio 4
-- Tabla productos
INSERT INTO productos
	VALUES (10000, 'Lavadora', '123456ABCDEFG', 1340.64, 'WRT12');

-- Este insert verifica que el check de precio no negativo no se cumple
INSERT INTO productos
	VALUES (10001, 'Coche', '234567BCDEFGH', -3560.89, 'WRT12');

-- Tabla clientes
INSERT INTO clientes (dni, nombre, apellidos, tipoCliente, fechaNac)
	VALUES ('12345678A', 'Maximiliano', 'Díaz López', 'VIP', '1990-11-20');

-- Este insert verifica que el check de tipoCliente con ciertos valores no se cumple
INSERT INTO clientes (dni, nombre, apellidos, tipoCliente, fechaNac)
	VALUES ('2345678B', 'Manolo', 'Rodríguez Muñoz', 'ESPECIAL', '1992-01-12');

-- Este insert verifica que el check de fechaNac anterior al valor no se cumple
INSERT INTO clientes (dni, nombre, apellidos, tipoCliente, fechaNac)
	VALUES ('3456789C', 'María', 'Pérez Castillo', 'NORMAL', '2000-07-09');

-- Tabla pedidos
INSERT INTO pedidos (dniCliente, fechaPedido)
	VALUES ('12345678A', '2024-02-01 15:01:45');

-- Este insert verifica que el check de fechaPedido entre dos valores no se cumple
-- Si el constraint de fechaPedido funciona, este insert da fallo
INSERT INTO pedidos (dniCliente, fechaPedido)
	VALUES ('12345678A', '2024-02-09 07:33:02');

-- Tabla detallepedido
INSERT INTO detallepedido
	VALUES (10000, 10000, 3);
    
-- Ejercicio 6
-- Cambiar el constraint de clave foránea
ALTER TABLE detallepedido
	DROP FOREIGN KEY fk_idProducto;

ALTER TABLE detallepedido
	ADD CONSTRAINT fk_idProducto FOREIGN KEY (idProducto) REFERENCES productos (idProducto) ON UPDATE CASCADE;

-- Comprobación
UPDATE productos
	SET idProducto = '10003' WHERE idProducto = '10000';