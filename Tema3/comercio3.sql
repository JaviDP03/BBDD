CREATE DATABASE IF NOT EXISTS COMERCIO;
USE COMERCIO;

CREATE TABLE TIENDA (
    NIF VARCHAR(10) PRIMARY KEY,
    NOMBRE VARCHAR(20) CHECK (NOMBRE = UPPER(NOMBRE)) NOT NULL,
    DIRECCION VARCHAR(20),
    POBLACION VARCHAR(20),
    PROVINCIA VARCHAR(20),
    CODPOSTAL INT
);

CREATE TABLE FABRICANTE (
    COD_FABRICANTE INT(5) PRIMARY KEY,
    NOMBRE VARCHAR(15) CHECK (NOMBRE = UPPER(NOMBRE)),
    PAIS VARCHAR(15) CHECK (PAIS = UPPER(PAIS))
);

CREATE TABLE ARTICULO (
    ARTICULO VARCHAR(20),
    COD_FABRICANTE INT(5) REFERENCES FABRICANTE (COD_FABRICANTE)
    ON DELETE CASCADE,
    PESO INT(3) CHECK (PESO > 0),
    CATEGORIA VARCHAR(10),
    PRECIO_VENTA DECIMAL(6.2) CHECK (PRECIO_VENTA > 0),
    PRECIO_COSTO DECIMAL(6.2) CHECK (PRECIO_COSTO > 0),
    EXISTENCIAS INT(5),
    CONSTRAINT PK_CLAVEP PRIMARY KEY (ARTICULO , COD_FABRICANTE , PESO , CATEGORIA)
);

CREATE TABLE VENTA (
    NIF VARCHAR(10) REFERENCES TIENDA (NIF) ON DELETE CASCADE,
    ARTICULO VARCHAR(20) REFERENCES ARTICULO (ARTICULO) ON DELETE CASCADE,
    COD_FABRICANTE INT(5) REFERENCES ARTICULO (COD_FABRICANTE) ON DELETE CASCADE,
    PESO INT(3) REFERENCES ARTICULO (PESO) ON DELETE CASCADE,
    CATEGORIA VARCHAR(10) CHECK (CATEGORIA IN ('PRIMERA' , 'SEGUNDA', 'TERCERA')) REFERENCES ARTICULO (CATEGORIA) ON DELETE CASCADE,
    FECHA_VENTA DATE,
    UNIDADES_VENDIDAS INT(4) CHECK (UNIDADES_VENDIDAS > 0),
    CONSTRAINT PK_CLAVEPV PRIMARY KEY (NIF , ARTICULO , COD_FABRICANTE , PESO , CATEGORIA , FECHA_VENTA)
);

CREATE TABLE PEDIDO (
    NIF VARCHAR(10) REFERENCES TIENDA (NIF) ON DELETE CASCADE,
    ARTICULO VARCHAR(20) REFERENCES ARTICULO (ARTICULO) ON DELETE CASCADE,
    COD_FABRICANTE INT(5) REFERENCES ARTICULO (COD_FABRICANTE) ON DELETE CASCADE,
    PESO INT(3) REFERENCES ARTICULO (PESO) ON DELETE CASCADE,
    CATEGORIA VARCHAR(10) CHECK (CATEGORIA IN ('PRIMERA' , 'SEGUNDA', 'TERCERA')) REFERENCES ARTICULO (CATEGORIA) ON DELETE CASCADE,
    FECHA_PEDIDO DATE,
    UNIDADES_PEDIDAS INT(4),
    EXISTENCIAS INT(5),
    CONSTRAINT PK_CLAVEPP PRIMARY KEY (NIF , ARTICULO , COD_FABRICANTE , PESO , CATEGORIA , FECHA_PEDIDO)
);