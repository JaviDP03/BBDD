-- Base de datos
DROP DATABASE IF EXISTS banco;
CREATE DATABASE banco;
USE banco;


-- Tablas
CREATE TABLE sucursal (
    codSucursal CHAR(4) PRIMARY KEY,
    nombre VARCHAR(20),
    direccion VARCHAR(50),
    localidad VARCHAR(20)
);

CREATE TABLE cliente (
    dni CHAR(9),
    nombre VARCHAR(20),
    direccion VARCHAR(50),
    fechaNacimiento DATE,
    sexo CHAR(1)
);

ALTER TABLE cliente
ADD CONSTRAINT pk_cliente PRIMARY KEY(dni),
ADD CONSTRAINT check_sexo CHECK (sexo IN ('H', 'M'));

CREATE TABLE cuenta (
    codSucursal CHAR(4),
    codCuenta CHAR(5)
);

ALTER TABLE cuenta
ADD CONSTRAINT pk_cuenta PRIMARY KEY (codSucursal , codCuenta),
ADD CONSTRAINT fk1_cuenta FOREIGN KEY (codSucursal) REFERENCES sucursal (codSucursal);

CREATE TABLE transaccion (
    codSucursal CHAR(4),
    codCuenta CHAR(5),
    numTransaccion CHAR(4),
    fecha DATE,
    tipo VARCHAR(10),
    cantidad DOUBLE
);

ALTER TABLE transaccion
ADD CONSTRAINT pk_trans PRIMARY KEY (codSucursal, codCuenta, numTransaccion),
ADD CONSTRAINT fk1_trans FOREIGN KEY (codSucursal, codCuenta) REFERENCES cuenta (codSucursal, codCuenta),
ADD CONSTRAINT check_tipo CHECK (tipo IN ('Bizum', 'Transfe', 'Donacion'));

CREATE TABLE clicuenta (
    codSucursal CHAR(4),
    codCuenta CHAR(5),
    dniCliente CHAR(9)
);

ALTER TABLE clicuenta
ADD CONSTRAINT pk_clicuenta PRIMARY KEY (codSucursal, codCuenta, dniCliente),
ADD CONSTRAINT fk1_clicuenta FOREIGN KEY (codSucursal, codCuenta) REFERENCES cuenta (codSucursal, codCuenta),
ADD CONSTRAINT fk2_clicuenta FOREIGN KEY (dniCliente) REFERENCES cliente (dni);


-- Datos
INSERT INTO sucursal VALUES (6543, 'Oficina 1', 'C/Diaz 4', 'Segovia');
INSERT INTO sucursal VALUES (7532, 'Oficina 2', 'C/Italia 2', 'Sevilla');
INSERT INTO sucursal VALUES (1245, 'Oficina 3', 'C/Pepe 23', 'Madrid');

INSERT INTO cliente VALUES ('12345678P', 'Pancracio', 'C/Falsa 123', '1999-12-21', 'H');
INSERT INTO cliente VALUES ('64574688V', 'Roberta', 'C/España 12', '2001-7-5', 'M');
INSERT INTO cliente VALUES ('84563235G', 'Eustaquio', 'C/Mar 1', '1988-1-1', 'H');

INSERT INTO cuenta VALUES (6543, 95674);
INSERT INTO cuenta VALUES (6543, 63234);
INSERT INTO cuenta VALUES (1245, 12345);

INSERT INTO transaccion VALUES (1245, 12345, 9852, '2024-1-13', 'Bizum', 20.45);
INSERT INTO transaccion VALUES (6543, 95674, 5432, '2024-1-1', 'Transfe', 200);
INSERT INTO transaccion VALUES (1245, 12345, 3465, '2024-1-6', 'Donacion', 5.99);

INSERT INTO clicuenta VALUES (6543, 95674, '12345678P');
INSERT INTO clicuenta VALUES (6543, 63234, '64574688V');
INSERT INTO clicuenta VALUES (1245, 12345, '84563235G');


-- Consultas
SELECT clicuenta.codCuenta, cliente.nombre FROM clicuenta, cliente
WHERE clicuenta.dniCliente = cliente.dni AND clicuenta.dniCliente = '12345678P';

SELECT transaccion.numTransaccion, transaccion.tipo, cliente.nombre
FROM transaccion, clicuenta, cliente
WHERE transaccion.codCuenta = clicuenta.codCuenta AND clicuenta.dniCliente = cliente.dni AND clicuenta.dniCliente = '84563235G';

SELECT cuenta.codCuenta, transaccion.numTransaccion, transaccion.cantidad
FROM transaccion, cuenta
WHERE transaccion.codCuenta = cuenta.codCuenta AND transaccion.codCuenta = 12345;