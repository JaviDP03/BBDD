DROP DATABASE IF EXISTS instituto;
CREATE DATABASE instituto;
USE instituto;

CREATE TABLE alumno (
    numMatricula INT PRIMARY KEY,
    nombre VARCHAR(30),
    fechaNacimiento DATE,
    telefono CHAR(9)
);

CREATE TABLE profesor (
    idProfesor INT PRIMARY KEY,
    nif_p CHAR(9) UNIQUE,
    nombre VARCHAR(30),
    especialidad VARCHAR(20),
    telefono CHAR(9)
);

CREATE TABLE asignatura (
    codAsignatura INT PRIMARY KEY,
    nombre VARCHAR(30),
    idProfesor INT,
    CONSTRAINT fk_idprof FOREIGN KEY (idProfesor)
        REFERENCES profesor (idProfesor)
);

CREATE TABLE recibe (
    numMatricula INT,
    codAsignatura INT,
    cursoEscolar CHAR(10),
    CONSTRAINT pk_recibe PRIMARY KEY (numMatricula , codAsignatura , cursoEscolar),
    CONSTRAINT fk1_recibe FOREIGN KEY (numMatricula)
        REFERENCES alumno (numMatricula),
    CONSTRAINT fk2_recibe FOREIGN KEY (codAsignatura)
        REFERENCES asignatura (codAsignatura)
);