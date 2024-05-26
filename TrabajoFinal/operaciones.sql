USE tienda_musica;

-- Consultas
-- Por agrupación
-- 1. Consulta del artista junto con el número de canciones que ha escrito.
SELECT a.nombre, a.edad, a.seguidores, COUNT(c.id) AS canciones_escritas FROM artista a, escribe e, cancion c
WHERE a.id = e.id_artista AND c.id = e.id_cancion GROUP BY a.id;

-- 2. Consulta de la canción y el albúm al que pertenece.
SELECT c.titulo, c.genero, c.duracion, a.nombre AS nombre_album FROM cancion c, album a
WHERE a.id = c.id_album;

-- Subconsultas
-- 3. Consulta del álbum o álbumes con la cantidad de canciones escritas por artistas que tienen más de 50 años.
SELECT a.nombre, a.fecha_lanzamiento,
	(SELECT COUNT(*) FROM artista ar
	JOIN escribe e ON ar.id = e.id_artista JOIN cancion c ON e.id_cancion = c.id
    WHERE ar.edad > 50 AND c.id_album = a.id) AS numero_canciones
FROM album a;

-- 4. Consulta de los artistas y el número de discos que han vendido.
SELECT a.nombre,
	(SELECT COUNT(*) FROM disco d
    JOIN compra co ON d.numero = co.num_disco
    WHERE d.id_cancion IN
		(SELECT id_cancion FROM escribe e WHERE e.id_artista = a.id)) AS discos_vendidos
FROM artista a;

-- Left/Right Join
-- 5. Consulta del numero de disco y el dni del cliente incluyendo los que no han sido comprados.
SELECT d.numero, c.dni FROM disco d
LEFT JOIN compra co ON d.numero = co.num_disco 
LEFT JOIN cliente c ON co.id_cliente = c.id;

-- 6. Consulta del numero de disco, dni del cliente y precio de los discos que cuesten más de 10 € y mostrar sólo los comprados.
SELECT d.numero, c.dni FROM disco d
RIGHT JOIN compra co ON d.numero = co.num_disco 
RIGHT JOIN cliente c ON co.id_cliente = c.id
WHERE d.precio > 10;

-- Vistas
-- 1. Vista sobre las canciones, el artista y el álbum.
DROP VIEW IF EXISTS vista_canciones;

CREATE VIEW vista_canciones AS
SELECT c.titulo, c.genero, c.duracion, a.nombre AS nombre_artista, al.nombre AS nombre_album FROM cancion c
JOIN escribe e ON c.id = e.id_cancion
JOIN album al ON c.id_album = al.id
JOIN artista a ON e.id_artista = a.id;

SELECT * FROM vista_canciones;

-- 2. Vista sobre las compras y los clientes de cada una.
DROP VIEW IF EXISTS vista_compras;

CREATE VIEW vista_compras AS
SELECT co.fecha_compra, co.num_disco, c.nombre, c.apellidos, c.dni FROM compra co
JOIN cliente c ON co.id_cliente = c.id;

SELECT * FROM vista_compras;

-- 3. Vista que muestra únicamente los discos nuevos.
DROP VIEW IF EXISTS vista_discos_nuevos;

CREATE VIEW vista_discos_nuevos AS
SELECT d.numero, d.estado, d.precio, c.titulo AS titulo_cancion FROM disco d
JOIN cancion c ON d.id_cancion = c.id
WHERE d.estado = 'Nuevo';

SELECT * FROM vista_discos_nuevos;

-- Procedimientos
-- Parámetro IN
-- 1. Procedimiento que suma los precios de los discos hasta el id que se indique por parámetro.
DELIMITER $$
DROP PROCEDURE IF EXISTS sumar_precios_hasta_numero$$
CREATE PROCEDURE sumar_precios_hasta_numero(IN numero_disco INT)
	BEGIN
		DECLARE contador INT DEFAULT 1;
        DECLARE suma_precios FLOAT DEFAULT 0;
        DECLARE precio_disco FLOAT;
        
		WHILE contador <= numero_disco DO
			SELECT precio INTO precio_disco FROM disco WHERE numero = contador;
			SET suma_precios = suma_precios + precio_disco;
            SET contador = contador + 1;
		END WHILE;
        
        SELECT suma_precios;
    END$$
DELIMITER ;

CALL sumar_precios_hasta_numero(4);

-- 2. Procedimiento que verifica si un álbum es nuevo de este año o no lo es.
DELIMITER $$
DROP PROCEDURE IF EXISTS album_novedoso$$
CREATE PROCEDURE album_novedoso(IN nombre_album VARCHAR(30))
	BEGIN
		DECLARE anno_album INT;
        DECLARE anno_actual INT;
        
        SET anno_actual = YEAR(CURDATE());
        SELECT YEAR(fecha_lanzamiento) INTO anno_album FROM album WHERE nombre = nombre_album;
        
        IF (anno_album = anno_actual) THEN
			SELECT 'Este álbum es nuevo' AS tiempo_album;
		ELSE
			SELECT 'Este álbum ya es viejo' AS tiempo_album;
		END IF;
    END$$
DELIMITER ;

CALL album_novedoso('Sonidos de la Tierra');

-- Parámetro OUT
-- 3. Procedimiento que devuelve el número más grande de seguidores y los duplica si supera 25000 seguidores.
DELIMITER $$
DROP PROCEDURE IF EXISTS duplicar_mayor_numero_seguidores$$
CREATE PROCEDURE duplicar_mayor_numero_seguidores(OUT numero_seguidores INT)
	BEGIN
		SELECT MAX(seguidores) INTO numero_seguidores FROM artista;
        
        IF (numero_seguidores > 25000) THEN
			SET numero_seguidores = numero_seguidores * 2;
		END IF;
    END$$
DELIMITER ;

CALL duplicar_mayor_numero_seguidores(@numero_seguidores);
SELECT @numero_seguidores;

-- 4. Procedimiento que sube el precio del primer disco, que ha aumentado su valor. Si es nuevo sube un 20%, si es usado un 15%.
DELIMITER $$
DROP PROCEDURE IF EXISTS subida_precios$$
CREATE PROCEDURE subida_precios(OUT nuevo_precio FLOAT)
	BEGIN
		DECLARE estado_disco VARCHAR(10);
        
		SELECT precio INTO nuevo_precio FROM disco WHERE numero = 1;
        SELECT estado INTO estado_disco FROM disco WHERE numero = 1;
        
        IF (estado_disco = 'Nuevo') THEN
			SET nuevo_precio = nuevo_precio * 1.20;
		ELSEIF (estado_disco = 'Usado') THEN
			SET nuevo_precio = nuevo_precio * 1.10;
		END IF;
    END$$
DELIMITER ;

CALL subida_precios(@nuevo_precio);
SELECT ROUND(@nuevo_precio, 2) AS nuevo_precio;

-- Parámetro INOUT
-- 5. Procedimiento para bajar seguidores de un artista por id. Si la cantidad recibida por parámetro es menor al 20% de sus seguidores, entonces se resta.
DELIMITER $$
DROP PROCEDURE IF EXISTS bajada_seguidores$$
CREATE PROCEDURE bajada_seguidores(IN id_artista INT, INOUT numero_seguidores INT)
	BEGIN
		DECLARE seguidores_artista INT;
        
        SELECT seguidores INTO seguidores_artista FROM artista WHERE id = id_artista;
        
        IF (numero_seguidores < seguidores_artista * 0.20) THEN
			SET numero_seguidores = seguidores_artista - numero_seguidores;
		END IF;
    END$$
DELIMITER ;

SET @numero_seguidores = 100;
CALL bajada_seguidores(4, @numero_seguidores);
SELECT @numero_seguidores;

-- 6. Procedimiento que recibe el nombre de una canción de género Pop y devuelve el nombre de su artista. Si no concuerda el género devuelve el género.
DELIMITER $$
DROP PROCEDURE IF EXISTS nombre_artista_por_cancion$$
CREATE PROCEDURE nombre_artista_por_cancion(INOUT texto_cancion VARCHAR(20))
	BEGIN
		DECLARE genero_cancion VARCHAR(10);
        
		SELECT genero INTO genero_cancion FROM cancion WHERE titulo = texto_cancion;
        
		IF (genero_cancion = 'Pop') THEN
			SELECT a.nombre INTO texto_cancion FROM artista a JOIN escribe e ON a.id = e.id_artista WHERE e.id_cancion = 
				(SELECT c.id FROM cancion c WHERE titulo = texto_cancion);
		ELSE
			SET texto_cancion = genero_cancion;
		END IF;
    END$$
DELIMITER ;

SET @texto_cancion = 'Sueños de Libertad';
CALL nombre_artista_por_cancion(@texto_cancion);
SELECT @texto_cancion;

-- Funciones
-- Actualizar
-- 1. Función que actualiza un artista y devuelve los nuevos datos.
DELIMITER $$
DROP FUNCTION IF EXISTS actualizar_artista$$
CREATE FUNCTION actualizar_artista(id_artista INT, nuevo_nombre VARCHAR(30), nueva_edad INT, nuevos_seguidores INT)
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	DECLARE mensaje_actualizado VARCHAR(100);

	UPDATE artista SET
		nombre = nuevo_nombre,
		edad = nueva_edad,
        seguidores = nuevos_seguidores
	WHERE id = id_artista;

	SET mensaje_actualizado = CONCAT('El artista ha sido actualizado con nombre ', nuevo_nombre, ', ', nueva_edad, ' años y ', nuevos_seguidores, ' seguidores' );

	RETURN mensaje_actualizado;
END$$
DELIMITER ;

SELECT actualizar_artista(2, 'Manolo Díaz', 33, 20500) AS artista_actualizado;

-- Insertar
-- 2. Función que inserta un cliente y devuelve los nuevos datos.
DELIMITER $$
DROP FUNCTION IF EXISTS insertar_cliente$$
CREATE FUNCTION insertar_cliente(nuevo_nombre VARCHAR(30), nuevos_apellidos VARCHAR(40), nuevo_dni CHAR(9), nueva_fecha_nacimiento DATE, nueva_direccion VARCHAR(50))
RETURNS VARCHAR(200) DETERMINISTIC
BEGIN
	DECLARE mensaje_actualizado VARCHAR(200);

	INSERT INTO cliente (nombre, apellidos, dni, fecha_nacimiento, direccion) VALUES
		(nuevo_nombre, nuevos_apellidos, nuevo_dni, nueva_fecha_nacimiento, nueva_direccion);

	SET mensaje_actualizado =
		CONCAT('El cliente ha sido añadido con nombre ', nuevo_nombre, ' ', nuevos_apellidos, ', DNI ', nuevo_dni, ', fecha de nacimiento ', nueva_fecha_nacimiento, ' y dirección ', nueva_direccion);

	RETURN mensaje_actualizado;
END$$
DELIMITER ;

SELECT insertar_cliente('Pepe', 'González López', '32543567V', '1999-08-12', 'Calle Nueva, 7') AS cliente_insertado;

-- Borrar
-- 3. Función que borra un disco.
DELIMITER $$
DROP FUNCTION IF EXISTS borrar_disco$$
CREATE FUNCTION borrar_disco(numero_disco INT)
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	DECLARE mensaje_actualizado VARCHAR(100);

	DELETE FROM disco WHERE numero = numero_disco;
    
	SET mensaje_actualizado =
		CONCAT('Disco número ', numero_disco, ' borrado con éxito');

	RETURN mensaje_actualizado;
END$$
DELIMITER ;

SELECT borrar_disco(1) AS disco_borrado;

-- Cursores
-- Procedimiento con cursor que cada año suma 1 a la edad del artista, sube 100 seguidores si tiene menos de 50 años.
-- Si sube de seguidores, sube el precio de sus discos 30 céntimos, de lo contrario, los baja.
DELIMITER $$
DROP PROCEDURE IF EXISTS sumar_anno$$
CREATE PROCEDURE sumar_anno()
BEGIN
	DECLARE done BOOLEAN DEFAULT FALSE;
	DECLARE artista_id INT;
	DECLARE artista_edad INT;
	DECLARE artista_seguidores INT;
    
	DECLARE artista_cursor CURSOR FOR
		SELECT id, edad, seguidores
		FROM artista;
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
	OPEN artista_cursor;
		ciclo_actualizar: LOOP
			FETCH artista_cursor INTO artista_id, artista_edad, artista_seguidores;

			IF (done = true) THEN
				LEAVE ciclo_actualizar;
			END IF;

			-- Actualizar la edad del artista
			SET artista_edad = artista_edad + 1;

			-- Actualizar los seguidores del artista
			IF artista_edad < 50 THEN
				SET artista_seguidores = artista_seguidores + 100;
			ELSE
				SET artista_seguidores = artista_seguidores - 100;
			END IF;
			
            UPDATE artista SET
				edad = artista_edad,
                seguidores = artista_seguidores
			WHERE id = artista_id;
            
		END LOOP;
	CLOSE artista_cursor;
END$$
DELIMITER ;

CALL sumar_anno();