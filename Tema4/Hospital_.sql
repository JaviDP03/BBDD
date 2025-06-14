/*
Especialidad(cod, nombre)
Medico(dni, nombre, apellidos, cod_especialidad)
Ingreso(cod, fechaEntrada, fechaSalida, cod_cama, dni_paciente, dni_medico)
Paciente(dni, nombre, apellidos, FechaNacimiento, sexo)
Habitación(cod, nombre)
Cama(cod, nombre, cod_habitacion)

DROP TABLE ingreso;
DROP TABLE paciente;
DROP TABLE medico;
DROP TABLE cama;
DROP TABLE habitacion;
DROP TABLE especialidad;

*/

DROP DATABASE IF EXISTS hospital_universitario;
CREATE DATABASE hospital_universitario;
USE hospital_universitario;

CREATE TABLE Especialidad(
	cod INT PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL
);
INSERT INTO Especialidad VALUES (1,'Oftalmología');
INSERT INTO Especialidad VALUES (2,'Urología');
INSERT INTO Especialidad VALUES (3,'Traumatología');
INSERT INTO Especialidad VALUES (4,'Oncología');
INSERT INTO Especialidad VALUES (5,'Cardiología');
INSERT INTO Especialidad VALUES (6,'Neurología');
INSERT INTO Especialidad VALUES (7,'Dermatología');
INSERT INTO Especialidad VALUES (8,'Podología');

CREATE TABLE Medico( 
	dni INT(8) PRIMARY KEY,
	nombre VARCHAR(30),
	apellidos VARCHAR(50) NOT NULL,
	cod_especialidad INT NOT NULL,
	CONSTRAINT fk1 FOREIGN KEY Medico(cod_especialidad) REFERENCES Especialidad(cod)
);

INSERT INTO Medico VALUES (30999000, 'Juan José', 'Ochoa Sepúlveda', 6);
INSERT INTO Medico VALUES (30999001, 'Juan', 'Ochoa Amor', 6);
INSERT INTO Medico VALUES (30999002, 'Carmen', 'Alcántara', 7);
INSERT INTO Medico VALUES (30999003, 'Gloria', 'Garnacho', 7);
INSERT INTO Medico VALUES (30999004, 'Fernando','Vega', 3);
INSERT INTO Medico VALUES (30999005, 'Pablo','Navarro', 3);
INSERT INTO Medico VALUES (30999006, 'Leonardo','García', 1);
INSERT INTO Medico VALUES (30999007, 'María Teresa','Galvín', 2);
INSERT INTO Medico VALUES (30999008, 'María','García Moreno', 6);
INSERT INTO Medico VALUES (30999009, 'Carlos','Martínez Montero', 4);
INSERT INTO Medico VALUES (30999010, 'Herminia','Cándida Molero', 5);
INSERT INTO Medico VALUES (30999011, 'Juan','Aguilar Montero', 3);
INSERT INTO Medico VALUES (30999012, 'Antonia','Dolores Rot', 3);
INSERT INTO Medico VALUES (30999013, 'Patricia','Garrido García', 3);
INSERT INTO Medico VALUES (30999014, 'Fernando','Fernández Romero', 4);
INSERT INTO Medico VALUES (30999015, 'Aurelia','De Campos Monterrubio', 5);
INSERT INTO Medico VALUES (30999016, 'Patricia','Quintero Arévalo', 2);
INSERT INTO Medico VALUES (30999017, 'David','Rodríguez Pons', 2);
INSERT INTO Medico VALUES (30999018, 'Manuel','Angulo', 7);
INSERT INTO Medico VALUES (30999019, 'Eva','Luján Smith', 7);
INSERT INTO Medico VALUES (30999020, 'Pelagio','Juan Monesterio', 7);
INSERT INTO Medico VALUES (30999021, 'Natividad','Márquez Caraballo', 7);
INSERT INTO Medico VALUES (30999022, 'Ángela','Granados Pedregosa', 4);
INSERT INTO Medico VALUES (30999023, 'María de los Ángeles','Martínez Valseca', 4);
INSERT INTO Medico VALUES (30999024, 'Felipe','Campos Ferrera', 1);
INSERT INTO Medico VALUES (30999025, 'Francisca','Matos Hernán', 6);

CREATE TABLE Habitacion (
	cod INT(4) PRIMARY KEY,
	nombre VARCHAR(6) UNIQUE NOT NULL
);

INSERT INTO Habitacion VALUES (1,'OF01');
INSERT INTO Habitacion VALUES (2,'OF02');
INSERT INTO Habitacion VALUES (3,'OF03');
INSERT INTO Habitacion VALUES (4,'OF04');
INSERT INTO Habitacion VALUES (5,'OF05');
INSERT INTO Habitacion VALUES (6,'UR01');
INSERT INTO Habitacion VALUES (7,'UR02');
INSERT INTO Habitacion VALUES (8,'UR03');
INSERT INTO Habitacion VALUES (9,'UR04');
INSERT INTO Habitacion VALUES (10,'UR05');
INSERT INTO Habitacion VALUES (11,'TR01');
INSERT INTO Habitacion VALUES (12,'TR02');
INSERT INTO Habitacion VALUES (13,'TR03');
INSERT INTO Habitacion VALUES (14,'TR04');
INSERT INTO Habitacion VALUES (15,'TR05');
INSERT INTO Habitacion VALUES (16,'ON01');
INSERT INTO Habitacion VALUES (17,'ON02');
INSERT INTO Habitacion VALUES (18,'ON03');
INSERT INTO Habitacion VALUES (19,'ON04');
INSERT INTO Habitacion VALUES (20,'ON05');
INSERT INTO Habitacion VALUES (21,'ON06');
INSERT INTO Habitacion VALUES (22,'ON07');
INSERT INTO Habitacion VALUES (23,'ON08');
INSERT INTO Habitacion VALUES (24,'ON09');
INSERT INTO Habitacion VALUES (25,'ON10');
INSERT INTO Habitacion VALUES (26,'CA01');
INSERT INTO Habitacion VALUES (27,'CA02');
INSERT INTO Habitacion VALUES (28,'CA03');
INSERT INTO Habitacion VALUES (29,'CA04');
INSERT INTO Habitacion VALUES (30,'CA05');
INSERT INTO Habitacion VALUES (31,'CA06');
INSERT INTO Habitacion VALUES (32,'CA07');
INSERT INTO Habitacion VALUES (33,'CA08');
INSERT INTO Habitacion VALUES (34,'CA09');
INSERT INTO Habitacion VALUES (35,'CA10');
INSERT INTO Habitacion VALUES (36,'NE01');
INSERT INTO Habitacion VALUES (37,'NE02');
INSERT INTO Habitacion VALUES (38,'NE03');
INSERT INTO Habitacion VALUES (39,'NE04');
INSERT INTO Habitacion VALUES (40,'NE05');
INSERT INTO Habitacion VALUES (41,'NE06');
INSERT INTO Habitacion VALUES (42,'NE07');
INSERT INTO Habitacion VALUES (43,'NE08');
INSERT INTO Habitacion VALUES (44,'NE09');
INSERT INTO Habitacion VALUES (45,'NE10');
INSERT INTO Habitacion VALUES (46,'DE01');
INSERT INTO Habitacion VALUES (47,'DE02');
INSERT INTO Habitacion VALUES (48,'DE03');
INSERT INTO Habitacion VALUES (49,'DE04');
INSERT INTO Habitacion VALUES (50,'DE05');
INSERT INTO Habitacion VALUES (51,'DE06');
INSERT INTO Habitacion VALUES (52,'DE07');
INSERT INTO Habitacion VALUES (53,'DE08');
INSERT INTO Habitacion VALUES (54,'PO01');
INSERT INTO Habitacion VALUES (55,'PO02');
INSERT INTO Habitacion VALUES (56,'PO03');
INSERT INTO Habitacion VALUES (57,'PO04');
INSERT INTO Habitacion VALUES (58,'PO05');
INSERT INTO Habitacion VALUES (59,'PO06');
INSERT INTO Habitacion VALUES (60,'PO07');
INSERT INTO Habitacion VALUES (61,'PO08');


CREATE TABLE Cama (
	cod INT PRIMARY KEY,
	nombre VARCHAR(3) NOT NULL,
	cod_habitacion INT(4) NOT NULL,
	CONSTRAINT fk2 FOREIGN KEY Cama(cod_habitacion) REFERENCES Habitacion(cod) ON DELETE CASCADE
);

INSERT INTO Cama VALUES(1,'E',18);
INSERT INTO Cama VALUES(2,'A',21);
INSERT INTO Cama VALUES(3,'D',45);
INSERT INTO Cama VALUES(4,'C',30);
INSERT INTO Cama VALUES(5,'C',28);
INSERT INTO Cama VALUES(6,'B',37);
INSERT INTO Cama VALUES(7,'A',7);
INSERT INTO Cama VALUES(8,'C',54);
INSERT INTO Cama VALUES(9,'F',1);
INSERT INTO Cama VALUES(10,'E',14);
INSERT INTO Cama VALUES(11,'A',39);
INSERT INTO Cama VALUES(12,'A',23);
INSERT INTO Cama VALUES(13,'A',54);
INSERT INTO Cama VALUES(14,'E',50);
INSERT INTO Cama VALUES(15,'F',34);
INSERT INTO Cama VALUES(16,'E',7);
INSERT INTO Cama VALUES(17,'A',52);
INSERT INTO Cama VALUES(18,'B',1);
INSERT INTO Cama VALUES(19,'E',21);
INSERT INTO Cama VALUES(20,'D',47);
INSERT INTO Cama VALUES(21,'C',23);
INSERT INTO Cama VALUES(22,'E',57);
INSERT INTO Cama VALUES(23,'B',52);
INSERT INTO Cama VALUES(24,'E',8);
INSERT INTO Cama VALUES(25,'E',3);
INSERT INTO Cama VALUES(26,'A',34);
INSERT INTO Cama VALUES(27,'D',33);
INSERT INTO Cama VALUES(28,'B',4);
INSERT INTO Cama VALUES(29,'C',55);
INSERT INTO Cama VALUES(30,'C',25);
INSERT INTO Cama VALUES(31,'B',15);
INSERT INTO Cama VALUES(32,'F',50);
INSERT INTO Cama VALUES(33,'B',51);
INSERT INTO Cama VALUES(34,'E',34);
INSERT INTO Cama VALUES(35,'A',14);
INSERT INTO Cama VALUES(36,'C',17);
INSERT INTO Cama VALUES(37,'F',15);
INSERT INTO Cama VALUES(38,'D',36);
INSERT INTO Cama VALUES(39,'B',23);
INSERT INTO Cama VALUES(40,'B',30);
INSERT INTO Cama VALUES(41,'C',42);
INSERT INTO Cama VALUES(43,'B',59);
INSERT INTO Cama VALUES(45,'A',42);
INSERT INTO Cama VALUES(46,'B',9);
INSERT INTO Cama VALUES(47,'B',38);
INSERT INTO Cama VALUES(48,'A',19);
INSERT INTO Cama VALUES(49,'A',31);
INSERT INTO Cama VALUES(50,'E',54);
INSERT INTO Cama VALUES(51,'F',51);
INSERT INTO Cama VALUES(52,'B',43);
INSERT INTO Cama VALUES(53,'D',48);
INSERT INTO Cama VALUES(54,'D',6);
INSERT INTO Cama VALUES(55,'E',37);
INSERT INTO Cama VALUES(57,'B',57);
INSERT INTO Cama VALUES(58,'F',18);
INSERT INTO Cama VALUES(59,'E',2);
INSERT INTO Cama VALUES(61,'D',12);
INSERT INTO Cama VALUES(62,'A',32);
INSERT INTO Cama VALUES(64,'E',60);
INSERT INTO Cama VALUES(65,'E',51);
INSERT INTO Cama VALUES(66,'C',8);
INSERT INTO Cama VALUES(67,'C',18);
INSERT INTO Cama VALUES(68,'B',19);
INSERT INTO Cama VALUES(70,'A',18);
INSERT INTO Cama VALUES(71,'D',22);
INSERT INTO Cama VALUES(72,'F',7);
INSERT INTO Cama VALUES(73,'C',21);
INSERT INTO Cama VALUES(75,'F',52);
INSERT INTO Cama VALUES(76,'C',3);
INSERT INTO Cama VALUES(77,'C',31);
INSERT INTO Cama VALUES(78,'F',27);
INSERT INTO Cama VALUES(79,'C',16);
INSERT INTO Cama VALUES(80,'E',19);
INSERT INTO Cama VALUES(81,'E',26);
INSERT INTO Cama VALUES(82,'F',32);
INSERT INTO Cama VALUES(83,'A',3);
INSERT INTO Cama VALUES(84,'D',49);
INSERT INTO Cama VALUES(85,'E',22);
INSERT INTO Cama VALUES(87,'B',55);
INSERT INTO Cama VALUES(88,'B',48);
INSERT INTO Cama VALUES(89,'F',14);
INSERT INTO Cama VALUES(90,'B',5);
INSERT INTO Cama VALUES(92,'A',1);
INSERT INTO Cama VALUES(93,'D',16);
INSERT INTO Cama VALUES(94,'E',17);
INSERT INTO Cama VALUES(97,'B',14);
INSERT INTO Cama VALUES(98,'F',35);
INSERT INTO Cama VALUES(99,'F',38);
INSERT INTO Cama VALUES(100,'F',25);
INSERT INTO Cama VALUES(101,'A',5);
INSERT INTO Cama VALUES(102,'A',13);
INSERT INTO Cama VALUES(103,'F',23);
INSERT INTO Cama VALUES(104,'A',57);
INSERT INTO Cama VALUES(106,'D',54);
INSERT INTO Cama VALUES(107,'F',43);
INSERT INTO Cama VALUES(108,'B',56);
INSERT INTO Cama VALUES(109,'D',24);
INSERT INTO Cama VALUES(110,'A',51);
INSERT INTO Cama VALUES(111,'A',53);
INSERT INTO Cama VALUES(112,'E',58);
INSERT INTO Cama VALUES(114,'F',19);
INSERT INTO Cama VALUES(115,'B',11);
INSERT INTO Cama VALUES(116,'A',60);
INSERT INTO Cama VALUES(117,'E',56);
INSERT INTO Cama VALUES(118,'F',9);
INSERT INTO Cama VALUES(119,'C',35);
INSERT INTO Cama VALUES(120,'C',41);
INSERT INTO Cama VALUES(122,'E',11);
INSERT INTO Cama VALUES(123,'C',40);
INSERT INTO Cama VALUES(124,'E',36);
INSERT INTO Cama VALUES(125,'C',2);
INSERT INTO Cama VALUES(127,'F',44);
INSERT INTO Cama VALUES(128,'C',46);
INSERT INTO Cama VALUES(129,'E',5);
INSERT INTO Cama VALUES(130,'C',56);
INSERT INTO Cama VALUES(131,'D',27);
INSERT INTO Cama VALUES(132,'A',27);
INSERT INTO Cama VALUES(134,'D',44);
INSERT INTO Cama VALUES(137,'E',39);
INSERT INTO Cama VALUES(138,'F',58);
INSERT INTO Cama VALUES(139,'D',42);
INSERT INTO Cama VALUES(143,'B',20);
INSERT INTO Cama VALUES(144,'B',17);
INSERT INTO Cama VALUES(145,'E',28);
INSERT INTO Cama VALUES(146,'B',45);
INSERT INTO Cama VALUES(148,'D',5);
INSERT INTO Cama VALUES(149,'F',55);
INSERT INTO Cama VALUES(150,'D',7);
INSERT INTO Cama VALUES(151,'D',25);
INSERT INTO Cama VALUES(153,'F',3);
INSERT INTO Cama VALUES(154,'E',32);
INSERT INTO Cama VALUES(155,'A',38);
INSERT INTO Cama VALUES(156,'D',10);
INSERT INTO Cama VALUES(157,'C',32);
INSERT INTO Cama VALUES(158,'D',39);
INSERT INTO Cama VALUES(159,'D',4);
INSERT INTO Cama VALUES(160,'C',5);
INSERT INTO Cama VALUES(162,'A',17);
INSERT INTO Cama VALUES(166,'C',38);
INSERT INTO Cama VALUES(167,'E',55);
INSERT INTO Cama VALUES(168,'C',53);
INSERT INTO Cama VALUES(172,'F',24);
INSERT INTO Cama VALUES(173,'B',54);
INSERT INTO Cama VALUES(175,'D',21);
INSERT INTO Cama VALUES(177,'D',35);
INSERT INTO Cama VALUES(178,'F',31);
INSERT INTO Cama VALUES(181,'C',45);
INSERT INTO Cama VALUES(184,'F',10);
INSERT INTO Cama VALUES(185,'D',46);
INSERT INTO Cama VALUES(186,'A',37);
INSERT INTO Cama VALUES(189,'F',29);
INSERT INTO Cama VALUES(192,'C',22);



CREATE TABLE Paciente (
	dni INT(8) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellidos VARCHAR(100) NOT NULL,
	fechaNacimiento DATE NOT NULL,
	sexo CHAR(1) NOT NULL,
	CONSTRAINT hombre_mujer CHECK(sexo IN('H','M'))
);

INSERT INTO Paciente VALUES(40000000,'ESTEFANIA','AROCAS PASADAS','1964-03-20','M');
INSERT INTO Paciente VALUES(40000005,'JOSEP','ANGUERA VILAFRANCA','1958-11-16','H');
INSERT INTO Paciente VALUES(40000007,'LAURA','VALLÉS GIRVENT','1966-09-17','M');
INSERT INTO Paciente VALUES(40000008,'RAQUEL','RAYA GARCIA','1967-10-10','M');
INSERT INTO Paciente VALUES(40000009,'JOAN','ANDREU CRUZ','1960-05-29','H');
INSERT INTO Paciente VALUES(40000011,'ADRIÀ','BERENGUERAS CULLERÉS','1964-09-23','H');
INSERT INTO Paciente VALUES(40000012,'GERARD','LÓPEZ DE PABLO GARCIA UCEDA','1966-01-13','H');
INSERT INTO Paciente VALUES(40000016,'LAURA','BIDAULT CULLERÉS','1967-04-02','M');
INSERT INTO Paciente VALUES(40000021,'RAMON','MORALES GESE','1958-01-26','H');
INSERT INTO Paciente VALUES(40000023,'ARAN','ALVAREZ FERNÁNDEZ','1964-09-27','H');
INSERT INTO Paciente VALUES(40000027,'XAVIER','BENITEZ JOSE','1966-05-17','H');
INSERT INTO Paciente VALUES(40000029,'JESUS','AYALA TORNÉ','1959-01-04','H');
INSERT INTO Paciente VALUES(40000033,'MARIA','MOLINER GARRIDO','1966-11-21','M');
INSERT INTO Paciente VALUES(40000040,'ALEJANDRO','ALOY COMPTE','1958-08-23','H');
INSERT INTO Paciente VALUES(40000042,'INGRID','BIDAULT PÉREZ','1967-03-20','M');
INSERT INTO Paciente VALUES(40000047,'JORDINA','AGUILAR RODRIGUEZ','1962-08-17','M');
INSERT INTO Paciente VALUES(40000048,'MARIA JOSÉ','BARRIGA SOTO','1961-07-16','M');
INSERT INTO Paciente VALUES(40000049,'RAQUEL','AVILA MASJUAN','1964-01-23','M');
INSERT INTO Paciente VALUES(40000054,'CRISTINA','ALINS GONZÁLEZ','1960-03-27','M');
INSERT INTO Paciente VALUES(40000057,'CRISTIAN','BADIA CASTILLO','1960-02-23','H');
INSERT INTO Paciente VALUES(40000064,'GEMMA','PORTELLA GISPETS','1966-09-06','M');
INSERT INTO Paciente VALUES(40000066,'JUAN','RODRIGUEZ GARCÍA','1962-07-20','H');
INSERT INTO Paciente VALUES(40000068,'NATÀLIA','BARRIGA TARDÀ','1959-11-18','M');
INSERT INTO Paciente VALUES(40000071,'JOAN','ALEU PRAT','1969-02-02','H');
INSERT INTO Paciente VALUES(40000075,'JOSÉ ANTONIO','BARALDÉS PARDO','1966-11-30','H');
INSERT INTO Paciente VALUES(40000078,'INGRID','ALOY FARRANDO','1959-04-14','M');
INSERT INTO Paciente VALUES(40000080,'AGUSTÍ','RIDÓ GÓMEZ','1966-05-24','H');
INSERT INTO Paciente VALUES(40000083,'MÒNICA','ARTIGAS MATURANO','1959-10-03','M');
INSERT INTO Paciente VALUES(40000086,'MARIA','TORRESCASANA GARCIA','1957-10-29','M');
INSERT INTO Paciente VALUES(40000092,'DAVID','ALONSO RODRIGUEZ','1958-03-23','H');
INSERT INTO Paciente VALUES(40000094,'MARTA','ALCAIDE MOLINA','1967-07-17','M');
INSERT INTO Paciente VALUES(40000098,'ALBA','AVILA MASJUAN','1957-09-22','M');
INSERT INTO Paciente VALUES(40000105,'ANA INÉS','BASTARDAS FRANCH','1962-01-03','M');
INSERT INTO Paciente VALUES(40000106,'IVET','ABADIAS MASANA','1959-05-22','M');
INSERT INTO Paciente VALUES(40000107,'JÚLIA','AREVALO SANCHEZ','1968-09-17','M');
INSERT INTO Paciente VALUES(40000113,'CRISTINA','BARALDÉS MARTORELL','1963-10-30','M');
INSERT INTO Paciente VALUES(40000114,'DAVID','AROCA GÓMEZ','1957-10-23','H');
INSERT INTO Paciente VALUES(40000116,'LUCIA','ALVAREZ DOMENECH','1968-11-13','M');
INSERT INTO Paciente VALUES(40000117,'CARLA','BOIX GONZÁLEZ','1963-05-29','M');
INSERT INTO Paciente VALUES(40000118,'ADRIÀ','BARALDÉS MONRÓS','1968-01-12','H');
INSERT INTO Paciente VALUES(40000120,'MARC','BAREA DHAENE','1958-05-07','H');
INSERT INTO Paciente VALUES(40000121,'ALEX','BARROSO DHAENE','1961-09-13','H');

CREATE TABLE Ingreso (
	cod INT PRIMARY KEY,
	fechaEntrada DATE NOT NULL,
	fechaSalida DATE DEFAULT NULL,
	cod_cama INT NOT NULL,
	dni_medico INT(8) NOT NULL,
	dni_paciente INT(8) NOT NULL,
	CONSTRAINT fk4 FOREIGN KEY Ingreso(cod_cama) REFERENCES Cama(cod),
	CONSTRAINT fk5 FOREIGN KEY Ingreso(dni_medico) REFERENCES Medico(dni),
	CONSTRAINT fk6 FOREIGN KEY Ingreso(dni_paciente) REFERENCES Paciente(dni)
);
INSERT INTO Ingreso VALUES(49,'2022-09-03','2022-11-07',1,30999009,40000118);
INSERT INTO Ingreso VALUES(50,'2024-02-20',null,35,30999013,40000080);
INSERT INTO Ingreso VALUES(27,'2021-04-29','2021-07-02',19,30999023,40000120);
INSERT INTO Ingreso VALUES(7,'2024-02-11',null,25,30999024,40000066);
INSERT INTO Ingreso VALUES(24,'2023-11-21','2024-02-10',17,30999002,40000117);
INSERT INTO Ingreso VALUES(30,'2021-07-19','2021-09-23',21,30999014,40000083);
INSERT INTO Ingreso VALUES(4,'2023-07-08','2023-08-23',62,30999015,40000066);
INSERT INTO Ingreso VALUES(40,'2021-01-28','2021-03-23',79,30999014,40000009);
INSERT INTO Ingreso VALUES(23,'2022-06-04','2022-08-22',118,30999016,40000016);
INSERT INTO Ingreso VALUES(9,'2021-05-16','2021-08-16',122,30999012,40000106);
INSERT INTO Ingreso VALUES(21,'2023-02-02','2023-02-04',39,30999022,40000064);
INSERT INTO Ingreso VALUES(3,'2023-02-05','2023-03-09',107,30999000,40000000);
INSERT INTO Ingreso VALUES(39,'2024-01-30',null,37,30999012,40000106);
INSERT INTO Ingreso VALUES(1,'2022-12-31','2023-02-07',54,30999007,40000042);
INSERT INTO Ingreso VALUES(35,'2022-04-14','2022-06-02',54,30999016,40000118);
INSERT INTO Ingreso VALUES(42,'2022-08-15','2022-10-20',28,30999024,40000057);
INSERT INTO Ingreso VALUES(37,'2023-12-31',null,34,30999015,40000012);
INSERT INTO Ingreso VALUES(6,'2021-03-07','2021-04-01',116,30999008,40000105);
INSERT INTO Ingreso VALUES(45,'2024-03-01',null,59,30999006,40000120);
INSERT INTO Ingreso VALUES(10,'2024-03-06',null,53,30999018,40000023);
INSERT INTO Ingreso VALUES(32,'2023-12-21','2024-02-24',51,30999021,40000121);
INSERT INTO Ingreso VALUES(20,'2022-08-16','2022-10-26',41,30999008,40000011);
INSERT INTO Ingreso VALUES(18,'2024-02-28',null,49,30999015,40000007);
INSERT INTO Ingreso VALUES(46,'2023-07-31','2023-08-28',49,30999015,40000033);
INSERT INTO Ingreso VALUES(16,'2024-01-20','2024-01-31',68,30999023,40000075);
INSERT INTO Ingreso VALUES(44,'2022-03-19','2022-05-22',89,30999004,40000000);
INSERT INTO Ingreso VALUES(19,'2024-01-16',null,89,30999011,40000071);
INSERT INTO Ingreso VALUES(38,'2024-03-4',null,89,30999004,40000049);
INSERT INTO Ingreso VALUES(41,'2023-04-24','2023-06-22',65,30999020,40000040);
INSERT INTO Ingreso VALUES(14,'2023-05-25','2023-08-07',150,30999007,40000049);
INSERT INTO Ingreso VALUES(2,'2024-02-10',null,185,30999018,40000068);
INSERT INTO Ingreso VALUES(47,'2023-01-26','2023-04-09',97,30999004,40000094);
INSERT INTO Ingreso VALUES(11,'2022-12-03','2023-02-20',185,30999002,40000027);
INSERT INTO Ingreso VALUES(28,'2024-01-04',null,115,30999013,40000033);
INSERT INTO Ingreso VALUES(17,'2023-10-04','2023-11-10',115,30999005,40000047);
INSERT INTO Ingreso VALUES(36,'2021-12-28','2022-01-22',166,30999001,40000021);
INSERT INTO Ingreso VALUES(33,'2024-02-27',null,10,30999012,40000054);
INSERT INTO Ingreso VALUES(13,'2023-11-02','2023-12-20',10,30999013,40000008);
INSERT INTO Ingreso VALUES(25,'2022-08-11','2022-11-14',23,30999003,40000049);
INSERT INTO Ingreso VALUES(34,'2022-03-01','2022-06-01',23,30999021,40000092);
INSERT INTO Ingreso VALUES(8,'2022-05-01','2022-05-30',36,30999014,40000048);
INSERT INTO Ingreso VALUES(12,'2022-06-20','2022-07-06',128,30999018,40000083);
INSERT INTO Ingreso VALUES(22,'2023-01-22','2023-03-10',30,30999009,40000033);
INSERT INTO Ingreso VALUES(43,'2022-01-18','2022-04-04',120,30999000,40000078);
INSERT INTO Ingreso VALUES(31,'2023-05-02','2023-07-14',33,30999018,40000113);
INSERT INTO Ingreso VALUES(48,'2023-05-01','2023-05-29',97,30999011,40000029);
INSERT INTO Ingreso VALUES(26,'2024-02-28',null,40,30999015,40000098);
INSERT INTO Ingreso VALUES(29,'2022-06-02','2022-09-08',168,30999003,40000005);
INSERT INTO Ingreso VALUES(15,'2021-06-13','2021-08-12',61,30999013,40000116);
INSERT INTO Ingreso VALUES(5,'2024-02-01',null,61,30999005,40000086);



