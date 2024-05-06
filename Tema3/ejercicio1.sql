USE ejemplos;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS articulos;
DROP TABLE IF EXISTS fabricantes;
DROP TABLE IF EXISTS tiendas;

CREATE TABLE tiendas (
    nif VARCHAR(10),
    nombre VARCHAR(20),
    direccion VARCHAR(20),
    poblacion VARCHAR(20),
    provincia VARCHAR(20),
    codpostal INT
);
ALTER TABLE tiendas 
	ADD CONSTRAINT pk_nif PRIMARY KEY (nif),
	ADD CONSTRAINT mayuscu CHECK (provincia = UPPER (provincia)),
	MODIFY nombre VARCHAR(30) NOT NULL;

CREATE TABLE fabricantes (
    cod_fabricante INT,
    nombre VARCHAR(15),
    pais VARCHAR(15),
    CONSTRAINT codfab_pk PRIMARY KEY (cod_fabricante),
    CONSTRAINT nombre_mayuscula CHECK (nombre = UPPER(nombre)),
    CONSTRAINT pais_mayuscula CHECK (pais = UPPER(pais))
);

CREATE TABLE articulos (
    articulo VARCHAR(20),
    cod_fabricante INT,
    peso INT,
    categoria VARCHAR(10),
    precio_venta INT,
    precio_costo INT,
    existencias INT,
    CONSTRAINT fk_codfab FOREIGN KEY (cod_fabricante)
        REFERENCES fabricantes (cod_fabricante)
        ON DELETE CASCADE,
    CONSTRAINT pk_clavep PRIMARY KEY (articulo , cod_fabricante , peso , categoria),
    CONSTRAINT mayorque0 CHECK (precio_venta > 0 AND precio_costo > 0
        AND peso > 0),
    CONSTRAINT categori CHECK (categoria IN ('PRIMERA' , 'SEGUNDA', 'TERCERA'))
);

CREATE TABLE ventas (
    nif VARCHAR(10),
    articulo VARCHAR(20),
    cod_fabricante INT,
    peso INT,
    categoria VARCHAR(10),
    fecha_venta DATE,
    unidades_vendidas INT,
    CONSTRAINT pk_clavepv PRIMARY KEY (nif , articulo , cod_fabricante , peso , categoria , fecha_venta),
    CONSTRAINT vendidas_may0 CHECK (unidades_vendidas > 0),
    CONSTRAINT categoriav CHECK (categoria IN ('PRIMERA' , 'SEGUNDA', 'TERCERA')),
    CONSTRAINT fk_claveajev FOREIGN KEY (articulo , cod_fabricante , peso , categoria)
        REFERENCES articulos (articulo , cod_fabricante , peso , categoria)
        ON DELETE CASCADE,
    CONSTRAINT fk_nifv FOREIGN KEY (nif)
        REFERENCES tiendas (nif)
        ON DELETE CASCADE
);

CREATE TABLE pedidos (
    nif VARCHAR(10),
    articulo VARCHAR(20),
    cod_fabricante INT,
    peso INT,
    categoria VARCHAR(10),
    fecha_pedido DATE,
    unidades_pedidas INT,
    existencias INT,
    CONSTRAINT pk_clavepp PRIMARY KEY (nif , articulo , cod_fabricante , peso , categoria , fecha_pedido),
    CONSTRAINT fk_clavenifp FOREIGN KEY (nif)
        REFERENCES tiendas (nif)
        ON DELETE CASCADE,
    CONSTRAINT fk_claveajep FOREIGN KEY (articulo , cod_fabricante , peso , categoria)
        REFERENCES articulos (articulo , cod_fabricante , peso , categoria)
        ON DELETE CASCADE,
    CONSTRAINT categorip CHECK (categoria IN ('PRIMERA' , 'SEGUNDA', 'TERCERA'))
);