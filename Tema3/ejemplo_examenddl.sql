-- Creación base de datos
DROP DATABASE IF EXISTS examenddl;
CREATE DATABASE examenddl;
USE examenddl;


-- Creación de tablas
CREATE TABLE alumno (
    codAlumno INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido1 VARCHAR(30) NOT NULL,
    apellido2 VARCHAR(30) NOT NULL,
    dni CHAR(9) UNIQUE,
    telefono CHAR(9)
);

CREATE TABLE modulo (
    codModulo INT PRIMARY KEY,
    nomModulo VARCHAR(30),
    numCreditos INT
);

CREATE TABLE matricula (
    codMatricula VARCHAR(10) PRIMARY KEY,
    ciclo VARCHAR(10) NOT NULL
);

CREATE TABLE alumnoMatricula (
    codAlumno INT,
    codMatricula VARCHAR(10),
    CONSTRAINT pk_alumnoMatricula PRIMARY KEY (codAlumno , codMatricula),
    CONSTRAINT fk1_alumnoMatricula FOREIGN KEY (codAlumno)
        REFERENCES alumno (codAlumno)
        ON UPDATE CASCADE,
    CONSTRAINT fk2_alumnoMatricula FOREIGN KEY (codMatricula)
        REFERENCES matricula (codMatricula)
        ON UPDATE CASCADE
);

CREATE TABLE matriculaModelo (
    codMatricula VARCHAR(10),
    codModulo INT,
    CONSTRAINT pk_alumnoMatricula PRIMARY KEY (codMatricula , codModulo),
    CONSTRAINT fk1_matriculaModelo FOREIGN KEY (codMatricula)
        REFERENCES matricula (codMatricula)
        ON UPDATE CASCADE,
    CONSTRAINT fk2_matriculaModelo FOREIGN KEY (codModulo)
        REFERENCES modulo (codModulo)
        ON UPDATE CASCADE
);


-- Insertar datos
INSERT INTO alumno VALUES (1, 'Juan', 'Fernández', 'Martín', '12345678H', '666666666');
INSERT INTO alumno VALUES (2, 'Ángela', 'Rider', 'Jiménez', '23456789P', '888888888');
INSERT INTO alumno VALUES (3, 'Pepe', 'P', 'P', '11111111P', '000000000');

INSERT INTO modulo VALUES (1, 'LLMM', 135);
INSERT INTO modulo VALUES (2, 'BBDD', 180);
INSERT INTO modulo VALUES (3, 'Prog', 300);

INSERT INTO matricula VALUES ('12345', 'DAW');
INSERT INTO matricula VALUES ('abcde', 'DAW');
INSERT INTO matricula VALUES ('matriPepe', 'ASIR');

INSERT INTO matriculaModelo VALUES ('12345', 1);
INSERT INTO matriculaModelo VALUES ('12345', 2);
INSERT INTO matriculaModelo VALUES ('12345', 3);
INSERT INTO matriculaModelo VALUES ('abcde', 2);
INSERT INTO matriculaModelo VALUES ('matriPepe', 1);
INSERT INTO matriculaModelo VALUES ('matriPepe', 2);

INSERT INTO alumnoMatricula VALUES (1, 12345);
INSERT INTO alumnoMatricula VALUES (2, 'abcde');
INSERT INTO alumnoMatricula VALUES (3, 'matriPepe');


-- Actualizar datos
UPDATE matricula
SET codMatricula = '0000m' WHERE codMatricula = 'matriPepe';