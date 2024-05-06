-- Base de datos
DROP DATABASE IF EXISTS empresa;
CREATE DATABASE empresa;
USE empresa;


-- Creación de tablas
CREATE TABLE cliente (
    numCliente INT PRIMARY KEY,
    saldo DOUBLE,
    limCredito INT,
    descuento INT
);

CREATE TABLE direccion (
    codDireccion CHAR(4) PRIMARY KEY,
    via VARCHAR(10),
    nombreVia VARCHAR(20),
    numero INT,
    piso INT,
    portal CHAR(1),
    codPostal CHAR(5),
    CONSTRAINT check_via CHECK (via IN ('Calle' , 'Avenida', 'Carrera'))
);

CREATE TABLE articulo (
    numArticulo INT PRIMARY KEY,
    descripcion VARCHAR(30)
);

CREATE TABLE fabrica (
    numFabrica INT PRIMARY KEY,
    telefono CHAR(9)
);

CREATE TABLE posee (
    numCliente INT REFERENCES cliente (numCliente),
    codDireccion CHAR(4) REFERENCES direccion (codDireccion),
    CONSTRAINT pk_posee PRIMARY KEY (numCliente , codDireccion)
);

CREATE TABLE pedido (
    numPedido INT PRIMARY KEY,
    fecha DATE,
    numCliente INT REFERENCES cliente (numCliente),
    codDireccion CHAR(4) REFERENCES direccion (codDireccion)
);

CREATE TABLE incluye (
    numPedido INT,
    numArticulo INT,
    cantidad INT
);

CREATE TABLE distribuye (
    numArticulo INT,
    numFabrica INT,
    cantSuministro INT,
    existencias INT
);


-- Modificación de tablas
ALTER TABLE incluye
ADD CONSTRAINT pk_incluye PRIMARY KEY (numPedido, numArticulo),
ADD CONSTRAINT fk1_incluye FOREIGN KEY (numPedido) REFERENCES pedido (numPedido),
ADD CONSTRAINT fk2_incluye FOREIGN KEY (numArticulo) REFERENCES articulo (numArticulo);

ALTER TABLE distribuye
ADD CONSTRAINT pk_distribuye PRIMARY KEY (numArticulo, numFabrica),
ADD CONSTRAINT fk1_distribuye FOREIGN KEY (numArticulo) REFERENCES articulo (numArticulo),
ADD CONSTRAINT fk2_distribuye FOREIGN KEY (numFabrica) REFERENCES fabrica (numFabrica);


-- Entrada de datos
INSERT INTO fabrica VALUES
(1, '123456789'),
(2, '987654321'),
(3, '555555555');

INSERT INTO articulo VALUES
(101, 'Producto A'),
(102, 'Producto B'),
(103, 'Producto C');

INSERT INTO cliente VALUES
(1001, 1000.00, 5000, 5),
(1002, 2000.00, 8000, 10),
(1003, 1500.00, 6000, 7);

INSERT INTO direccion VALUES
('D001', 'Calle', 'Principal', 123, 1, 'A', '12345'),
('D002', 'Avenida', 'Central', 456, 2, 'B', '54321'),
('D003', 'Carrera', 'Secundaria', 789, 3, 'C', '67890');

INSERT INTO pedido VALUES
(5001, '2024-01-01', 1001, 'D001'),
(5002, '2024-02-01', 1002, 'D002'),
(5003, '2024-03-01', 1003, 'D003');

INSERT INTO posee VALUES
(1001, 'D001'),
(1002, 'D002'),
(1003, 'D003');

INSERT INTO incluye VALUES
(5001, 101, 10),
(5002, 102, 5),
(5003, 103, 8);

INSERT INTO distribuye VALUES
(101, 1, 100, 50),
(102, 2, 80, 30),
(103, 3, 120, 70);