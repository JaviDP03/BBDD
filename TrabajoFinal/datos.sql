USE tienda_musica;

-- Datos tabla Artista
INSERT INTO artista (nombre, edad, seguidores) VALUES
	('Juan Pérez', 45, 12500),
	('María González', 32, 8800),
	('Pedro López', 51, 16200),
	('Ana Sánchez', 28, 7100),
	('David García', 60, 31500);

-- Datos tabla Album
INSERT INTO album (nombre, fecha_lanzamiento) VALUES
	('Melodías del Alma', '2023-10-04'),
	('Vibraciones Urbanas', '2022-05-12'),
	('Danzas del Sol', '2024-03-21'),
	('Sonidos de la Tierra', '2021-07-19'),
	('Voces del Viento', '2020-02-29');

-- Datos tabla Cancion
INSERT INTO cancion (titulo, genero, duracion, id_album) VALUES
	('Sueños de Libertad', 'Pop', '04:12', 1),
	('Vibra Urbana', 'Rock', '03:25', 2),
	('Danza del Viento', 'Electrónica', '05:08', 3),
	('Sonidos de la Naturaleza', 'Jazz', '04:37', 4),
	('Voces de la Tierra', 'Clásica', '02:45', 5),
	('Ritmo del Corazón', 'Pop', '03:53', 2),
	('Armonía del Alma', 'Rock', '04:21', 1),
	('Sinfonía del Amor', 'Electrónica', '05:42', 5),
	('Canto a la Vida', 'Jazz', '03:19', 3),
	('Historia de un Amor', 'Clásica', '02:58', 2);

-- Datos tabla escribe
INSERT INTO escribe (id_artista, id_cancion) VALUES
	(2, 1),
	(4, 5),
	(5, 2),
	(2, 6),
	(3, 3),
	(3, 7),
	(3, 4),
	(4, 8),
	(5, 9),
	(5, 10);

-- Datos tabla Disco
INSERT INTO disco (estado, precio, id_cancion) VALUES
	('Nuevo', 12.99, 3),
	('Nuevo', 14.50, 2),
	('Nuevo', 19.95, 1),
	('Nuevo', 15.75, 6),
	('Nuevo', 13.25, 4),
	('Usado', 10.50, 7),
	('Usado', 9.99, 5),
	('Usado', 11.75, 10),
	('Usado', 12.25, 9),
	('Usado', 14.99, 8),
	('Nuevo', 18.99, 4),
	('Nuevo', 15.50, 1),
	('Nuevo', 20.65, 10),
	('Nuevo', 17.89, 5),
	('Nuevo', 13.25, 4),
	('Usado', 10.50, 7),
	('Usado', 6.99, 1),
	('Usado', 12.75, 10),
	('Usado', 10.10, 3),
	('Usado', 8.99, 2);

-- Datos tabla Cliente
INSERT INTO cliente (nombre, apellidos, dni, fecha_nacimiento, direccion) VALUES
('Juan', 'Martínez López', '12345678A', '1985-01-02', 'Calle Mayor, 12'),
('María', 'Fernández Jiménez', '23456789B', '1990-03-04', 'Calle del Sol, 34'),
('Pedro', 'García Sánchez', '34567890C', '1995-05-06', 'Calle Sierpes, 15'),
('Ana', 'Rodríguez González', '45678901D', '2000-07-08', 'Calle Amapola, 20'),
('David', 'Pérez Martínez', '56789012E', '2005-09-10', 'Calle Estrella, 25');

-- Datos tabla compra
INSERT INTO compra (num_disco, id_cliente, fecha_compra) VALUES
	(1, 2, '2024-01-07'),
	(7, 4, '2024-03-11'),
	(2, 1, '2024-05-22'),
	(2, 4, '2024-04-13'),
	(4, 3, '2024-02-25'),
	(9, 2, '2023-01-29'),
	(16, 1, '2023-09-01'),
	(4, 2, '2023-05-07'),
	(11, 4, '2023-11-30'),
	(4, 5, '2023-12-21');