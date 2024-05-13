-- Ejercicios Procedimientos Jose Juan Sanchez
-- Javier Duarte Pérez

USE jardineria;
-- 1.8.1
-- 1. Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida y que muestre el texto ¡Hola mundo!.
DELIMITER $$
DROP PROCEDURE IF EXISTS hola_mundo$$
CREATE PROCEDURE hola_mundo()
	BEGIN
		SELECT '¡Hola mundo!';
	END$$
DELIMITER ;
CALL hola_mundo();

-- 4. Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la nota de un alumno,
-- y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las siguientes condiciones:
-- [0,5) = Insuficiente
-- [5,6) = Aprobado
-- [6, 7) = Bien
-- [7, 9) = Notable
-- [9, 10] = Sobresaliente
-- En cualquier otro caso la nota no será válida.
DELIMITER $$
DROP PROCEDURE IF EXISTS tipo_nota_alumno$$
CREATE PROCEDURE tipo_nota_alumno(IN nota_alumno FLOAT)
	BEGIN
		IF (nota_alumno <= 10 AND nota_alumno >= 9)
			THEN SELECT 'Sobresaliente';
		ELSEIF (nota_alumno < 9 AND nota_alumno >= 7)
			THEN SELECT 'Notable';
		ELSEIF (nota_alumno < 7 AND nota_alumno >= 6)
			THEN SELECT 'Bien';
		ELSEIF (nota_alumno < 6 AND nota_alumno >= 5)
			THEN SELECT 'Suficiente';
		ELSEIF (nota_alumno < 5 AND nota_alumno >= 0)
			THEN SELECT 'Insuficiente';
		ELSE
			SELECT 'Nota no válida';
        END IF;
	END$$
DELIMITER ;
CALL tipo_nota_alumno(5.55);

-- 5. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada,
-- con el valor de la nota en formato numérico y un parámetro de salida, con una cadena de texto indicando la nota correspondiente.
DELIMITER $$
DROP PROCEDURE IF EXISTS tipo_nota_alumno2$$
CREATE PROCEDURE tipo_nota_alumno2(IN nota_alumno FLOAT, OUT tipo_nota VARCHAR(20))
	BEGIN
		IF (nota_alumno <= 10 AND nota_alumno >= 9)
			THEN SELECT 'Sobresaliente' INTO tipo_nota;
		ELSEIF (nota_alumno < 9 AND nota_alumno >= 7)
			THEN SELECT 'Notable' INTO tipo_nota;
		ELSEIF (nota_alumno < 7 AND nota_alumno >= 6)
			THEN SELECT 'Bien' INTO tipo_nota;
		ELSEIF (nota_alumno < 6 AND nota_alumno >= 5)
			THEN SELECT 'Suficiente' INTO tipo_nota;
		ELSEIF (nota_alumno < 5 AND nota_alumno >= 0)
			THEN SELECT 'Insuficiente' INTO tipo_nota;
		ELSE
			SELECT 'Nota no válida' INTO tipo_nota;
        END IF;
	END$$
DELIMITER ;
CALL tipo_nota_alumno2(5.55, @tipo_nota);
SELECT @tipo_nota;

-- 6. Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de la estructura de control CASE.
DELIMITER $$
DROP PROCEDURE IF EXISTS tipo_nota_alumno3$$
CREATE PROCEDURE tipo_nota_alumno3(IN nota_alumno FLOAT, OUT tipo_nota VARCHAR(20))
	BEGIN
		CASE
			WHEN (nota_alumno <= 10 AND nota_alumno >= 9)
				THEN SET tipo_nota = 'Sobresaliente';
			WHEN (nota_alumno < 9 AND nota_alumno >= 7)
				THEN SET tipo_nota = 'Notable';
			WHEN (nota_alumno < 7 AND nota_alumno >= 6)
				THEN SET tipo_nota = 'Bien';
			WHEN (nota_alumno < 6 AND nota_alumno >= 5)
				THEN SET tipo_nota = 'Suficiente';
			WHEN (nota_alumno < 5 AND nota_alumno >= 0)
				THEN SET tipo_nota = 'Insuficiente';
			ELSE
				SET tipo_nota = 'Nota no válida';
        END CASE;
	END$$
DELIMITER ;
CALL tipo_nota_alumno3(5.55, @tipo_nota);
SELECT @tipo_nota;

-- 7. Escribe un procedimiento que reciba como parámetro de entrada un valor numérico que represente un día de la semana y
-- que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente.
-- Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes. Resuelva el procedimiento haciendo uso de la estructura de control IF.
DELIMITER $$
DROP PROCEDURE IF EXISTS nombre_dia_semana$$
CREATE PROCEDURE nombre_dia_semana(IN numero_dia FLOAT, OUT nombre_dia VARCHAR(20))
	BEGIN
		IF (numero_dia = 1)
			THEN SET nombre_dia = 'Lunes';
		ELSEIF (numero_dia = 2)
			THEN SET nombre_dia = 'Martes';
		ELSEIF (numero_dia = 3)
			THEN SET nombre_dia = 'Miercoles';
		ELSEIF (numero_dia = 4)
			THEN SET nombre_dia = 'Jueves';
		ELSEIF (numero_dia = 5)
			THEN SET nombre_dia = 'Viernes';
		ELSEIF (numero_dia = 6)
			THEN SET nombre_dia = 'Sábado';
		ELSEIF (numero_dia = 7)
			THEN SET nombre_dia = 'Domingo';
		ELSE
			SET nombre_dia = 'Día no válido';
        END IF;
	END$$
DELIMITER ;
CALL nombre_dia_semana(4, @nombre_dia);
SELECT @nombre_dia;

-- 8. Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de la estructura de control CASE.
DELIMITER $$
DROP PROCEDURE IF EXISTS nombre_dia_semana2$$
CREATE PROCEDURE nombre_dia_semana2(IN numero_dia FLOAT, OUT nombre_dia VARCHAR(20))
	BEGIN
		CASE
			WHEN (numero_dia = 1)
				THEN SET nombre_dia = 'Lunes';
			WHEN (numero_dia = 2)
				THEN SET nombre_dia = 'Martes';
			WHEN (numero_dia = 3)
				THEN SET nombre_dia = 'Miercoles';
			WHEN (numero_dia = 4)
				THEN SET nombre_dia = 'Jueves';
			WHEN (numero_dia = 5)
				THEN SET nombre_dia = 'Viernes';
			WHEN (numero_dia = 6)
				THEN SET nombre_dia = 'Sábado';
			WHEN (numero_dia = 7)
				THEN SET nombre_dia = 'Domingo';
			ELSE
				SET nombre_dia = 'Día no válido';
			END CASE;
	END$$
DELIMITER ;
CALL nombre_dia_semana2(4, @nombre_dia);
SELECT @nombre_dia;

-- 1.8.2
-- 1. Escribe un procedimiento que reciba el nombre de un país como parámetro de entrada y
-- realice una consulta sobre la tabla cliente para obtener todos los clientes que existen en la tabla de ese país.
DELIMITER $$
DROP PROCEDURE IF EXISTS clientes_del_pais$$
CREATE PROCEDURE clientes_del_pais(IN pais VARCHAR(30))
	BEGIN
		SELECT * FROM cliente c WHERE c.pais = pais;
	END$$
DELIMITER ;
CALL clientes_del_pais('Spain');

-- 2. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres
-- (Ejemplo: PayPal, Transferencia, etc). Y devuelva como salida el pago de máximo valor realizado para esa forma de pago.
-- Deberá hacer uso de la tabla pago de la base de datos jardineria.
DELIMITER $$
DROP PROCEDURE IF EXISTS pago_maximo_por_metodo_pago$$
CREATE PROCEDURE pago_maximo_por_metodo_pago(IN forma_pago VARCHAR(30), OUT pago_maximo FLOAT)
	BEGIN
		SELECT p.total INTO pago_maximo FROM pago p WHERE p.forma_pago = forma_pago ORDER BY total DESC LIMIT 1;
	END$$
DELIMITER ;
CALL pago_maximo_por_metodo_pago('PayPal', @pago_maximo);
SELECT @pago_maximo;

-- 3. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres
-- (Ejemplo: PayPal, Transferencia, etc).
-- Y devuelva como salida los siguientes valores teniendo en cuenta la forma de pago seleccionada como parámetro de entrada:
-- el pago de máximo valor,
-- el pago de mínimo valor,
-- el valor medio de los pagos realizados,
-- la suma de todos los pagos,
-- el número de pagos realizados para esa forma de pago.
DELIMITER $$
DROP PROCEDURE IF EXISTS datos_por_metodo_pago$$
CREATE PROCEDURE datos_por_metodo_pago
(IN forma_pago VARCHAR(30), OUT pago_maximo FLOAT, OUT pago_minimo FLOAT, OUT media_pagos FLOAT, OUT suma_pagos FLOAT, OUT numero_pagos INT)
	BEGIN
		SELECT p.total INTO pago_maximo FROM pago p WHERE p.forma_pago = forma_pago ORDER BY total DESC LIMIT 1;
        SELECT p.total INTO pago_minimo FROM pago p WHERE p.forma_pago = forma_pago ORDER BY total LIMIT 1;
        SELECT SUM(p.total) INTO suma_pagos FROM pago p WHERE p.forma_pago = forma_pago;
        SELECT COUNT(*) INTO numero_pagos FROM pago p WHERE p.forma_pago = forma_pago;
        SET media_pagos = suma_pagos / numero_pagos;
	END$$
DELIMITER ;
CALL datos_por_metodo_pago('PayPal', @pago_maximo, @pago_minimo, @media_pagos, @suma_pagos, @numero_pagos);
SELECT @pago_maximo, @pago_minimo, @media_pagos, @suma_pagos, @numero_pagos;

-- 4. Crea una base de datos llamada procedimientos que contenga una tabla llamada cuadrados.
-- La tabla cuadrados debe tener dos columnas de tipo INT UNSIGNED, una columna llamada número y otra columna llamada cuadrado.
-- Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_cuadrados con las siguientes características.
-- El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y calculará el valor de los cuadrados de
-- los primeros números naturales hasta el valor introducido como parámetro. El valor del números y de sus cuadrados deberán
-- ser almacenados en la tabla cuadrados que hemos creado previamente.
-- Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de insertar los nuevos valores de los cuadrados que va a calcular.
-- Utilice un bucle WHILE para resolver el procedimiento.
DROP DATABASE IF EXISTS procedimientos;
CREATE DATABASE procedimientos;
USE procedimientos;
CREATE TABLE cuadrados (
	numero INT UNSIGNED PRIMARY KEY,
    cuadrado INT UNSIGNED
);
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_cuadrados$$
CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
	BEGIN
		DECLARE contador_numeros INT DEFAULT 1;
		DELETE FROM cuadrados;
        WHILE contador_numeros <= tope DO
			INSERT INTO cuadrados VALUES (contador_numeros, POWER(contador_numeros, 2));
            SET contador_numeros = contador_numeros + 1;
		END WHILE;
    END$$
DELIMITER ;
CALL calcular_cuadrados(5);
SELECT * FROM cuadrados;

-- 6. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
DROP DATABASE IF EXISTS procedimientos;
CREATE DATABASE procedimientos;
USE procedimientos;
CREATE TABLE cuadrados (
	numero INT UNSIGNED PRIMARY KEY,
    cuadrado INT UNSIGNED
);
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_cuadrados2$$
CREATE PROCEDURE calcular_cuadrados2(IN tope INT UNSIGNED)
	BEGIN
		DECLARE contador_numeros INT DEFAULT 1;
		DELETE FROM cuadrados;
        bucle_numeros: LOOP
			INSERT INTO cuadrados VALUES (contador_numeros, POWER(contador_numeros, 2));
            IF contador_numeros = tope THEN
				LEAVE bucle_numeros;
			END IF;
            SET contador_numeros = contador_numeros + 1;
		END LOOP bucle_numeros;
    END$$
DELIMITER ;
CALL calcular_cuadrados2(10);
SELECT * FROM cuadrados;

-- 7. Crea una base de datos llamada procedimientos que contenga una tabla llamada ejercicio.
-- La tabla debe tener una única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.
-- Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_números con las siguientes características.
-- El procedimiento recibe un parámetro de entrada llamado valor_inicial de tipo INT UNSIGNED y deberá almacenar en la tabla ejercicio
-- toda la secuencia de números desde el valor inicial pasado como entrada hasta el 1.
-- Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.
-- Utilice un bucle WHILE para resolver el procedimiento.
DROP DATABASE IF EXISTS procedimientos;
CREATE DATABASE procedimientos;
USE procedimientos;
CREATE TABLE ejercicio (
	numero INT UNSIGNED PRIMARY KEY
);
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_numeros$$
CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
	BEGIN
		DECLARE contador_numeros INT;
        SET contador_numeros = valor_inicial;
		DELETE FROM ejercicio;
        WHILE contador_numeros >= 1 DO
			INSERT INTO ejercicio VALUES (contador_numeros);
            SET contador_numeros = contador_numeros - 1;
		END WHILE;
    END$$
DELIMITER ;
CALL calcular_numeros(8);
SELECT * FROM ejercicio;

-- 9. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
DROP DATABASE IF EXISTS procedimientos;
CREATE DATABASE procedimientos;
USE procedimientos;
CREATE TABLE ejercicio (
	numero INT UNSIGNED PRIMARY KEY
);
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_numeros2$$
CREATE PROCEDURE calcular_numeros2(IN valor_inicial INT UNSIGNED)
	BEGIN
		DECLARE contador_numeros INT;
        SET contador_numeros = valor_inicial;
		DELETE FROM ejercicio;
		bucle_numeros: LOOP
			INSERT INTO ejercicio VALUES (contador_numeros);
            IF contador_numeros = 1 THEN
				LEAVE bucle_numeros;
			END IF;
            SET contador_numeros = contador_numeros - 1;
		END LOOP bucle_numeros;
    END$$
DELIMITER ;
CALL calcular_numeros2(8);
SELECT * FROM ejercicio;

-- 10. Crea una base de datos llamada procedimientos que contenga una tabla llamada pares y otra tabla llamada impares.
-- Las dos tablas deben tener única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.
-- Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado calcular_pares_impares con las siguientes características.
-- El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y deberá almacenar en la tabla pares aquellos números pares
-- que existan entre el número 1 el valor introducido como parámetro. Habrá que realizar la misma operación para almacenar los números impares en la tabla impares.
-- Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.
-- Utilice un bucle WHILE para resolver el procedimiento.
DROP DATABASE IF EXISTS procedimientos;
CREATE DATABASE procedimientos;
USE procedimientos;
CREATE TABLE pares (
	numero INT UNSIGNED PRIMARY KEY
);
CREATE TABLE impares (
	numero INT UNSIGNED PRIMARY KEY
);
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_pares_impares$$
CREATE PROCEDURE calcular_pares_impares(IN tope INT UNSIGNED)
	BEGIN
		DECLARE contador_numeros INT DEFAULT 1;
		DELETE FROM pares;
        DELETE FROM impares;
        WHILE contador_numeros <= tope DO
			IF (contador_numeros % 2 = 0) THEN
				INSERT INTO pares VALUES (contador_numeros);
			ELSE
				INSERT INTO impares VALUES (contador_numeros);
			END IF;
            SET contador_numeros = contador_numeros + 1;
		END WHILE;
    END$$
DELIMITER ;
CALL calcular_pares_impares(15);
SELECT * FROM pares;
SELECT * FROM impares;

-- 12. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
DROP DATABASE IF EXISTS procedimientos;
CREATE DATABASE procedimientos;
USE procedimientos;
CREATE TABLE pares (
	numero INT UNSIGNED PRIMARY KEY
);
CREATE TABLE impares (
	numero INT UNSIGNED PRIMARY KEY
);
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_pares_impares2$$
CREATE PROCEDURE calcular_pares_impares2(IN tope INT UNSIGNED)
	BEGIN
		DECLARE contador_numeros INT DEFAULT 1;
		DELETE FROM pares;
        DELETE FROM impares;
        bucle_numeros: LOOP
			IF (contador_numeros % 2 = 0) THEN
				INSERT INTO pares VALUES (contador_numeros);
			ELSE
				INSERT INTO impares VALUES (contador_numeros);
			END IF;
            IF contador_numeros = tope THEN
				LEAVE bucle_numeros;
			END IF;
            SET contador_numeros = contador_numeros + 1;
		END LOOP bucle_numeros;
    END$$
DELIMITER ;
CALL calcular_pares_impares2(13);
SELECT * FROM pares;
SELECT * FROM impares;

-- 1.8.3
-- 2. Escribe un procedimiento que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus lados.
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_hipotenusa$$
CREATE PROCEDURE calcular_hipotenusa(IN cateto1 INT, IN cateto2 INT, OUT hipotenusa INT)
	BEGIN
		SET hipotenusa = SQRT(POWER(cateto1, 2) + POWER(cateto2, 2));
	END$$
DELIMITER ;
CALL calcular_hipotenusa(10, 14, @hipotenusa);
SELECT @hipotenusa;

-- 4. Escribe un procedimiento que reciba tres números reales como parámetros de entrada y devuelva el mayor de los tres.
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_mayor$$
CREATE PROCEDURE calcular_mayor(IN numero1 FLOAT, IN numero2 FLOAT, IN numero3 FLOAT, OUT numero_mayor FLOAT)
	BEGIN
        IF (numero1 > numero2 AND numero1 > numero3)
			THEN SET numero_mayor = numero1;
		ELSEIF (numero2 > numero1 AND numero2 > numero3)
			THEN SET numero_mayor = numero2;
		ELSE
			SET numero_mayor = numero3;
        END IF;
        -- Otra manera
        -- SET numero_mayor = GREATEST(numero1, numero2, numero3);
	END$$
DELIMITER ;
CALL calcular_mayor(5.25, 2.99, 7.67, @numero_mayor);
SELECT ROUND(@numero_mayor, 2);

-- 5. Escribe un procedimiento que devuelva el valor del área de un círculo a partir del valor del radio que se recibirá como parámetro de entrada.
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_area_circulo$$
CREATE PROCEDURE calcular_area_circulo(IN radio INT, OUT area_circulo INT)
	BEGIN
		SET area_circulo = PI() * POWER(radio, 2);
	END$$
DELIMITER ;
CALL calcular_area_circulo(8, @area_circulo);
SELECT @area_circulo;

-- 6. Escribe un procedimiento que devuelva como salida el número de años que han transcurrido entre dos fechas que se reciben como parámetros de entrada.
-- Por ejemplo, si pasamos como parámetros de entrada las fechas 2018-01-01 y 2008-01-01 la función tiene que devolver que han pasado 10 años.
DELIMITER $$
DROP PROCEDURE IF EXISTS calcular_diferencia_annos$$
CREATE PROCEDURE calcular_diferencia_annos(IN fecha1 DATE, IN fecha2 DATE, OUT diferencia_annos INT)
	BEGIN
		SET diferencia_annos = ABS(DATEDIFF(fecha1, fecha2) / 365);
	END$$
DELIMITER ;
CALL calcular_diferencia_annos('2018-01-01', '2008-01-01', @diferencia_annos);
SELECT @diferencia_annos;

-- 7. Escribe un procedimiento que reciba una cadena de entrada y devuelva la misma cadena pero sin acentos.
-- La función tendrá que reemplazar todas las vocales que tengan acento por la misma vocal pero sin acento.
-- Por ejemplo, si la función recibe como parámetro de entrada la cadena María la función debe devolver la cadena Maria.
DELIMITER $$
DROP PROCEDURE IF EXISTS transformar_sin_acentos$$
CREATE PROCEDURE transformar_sin_acentos(INOUT texto VARCHAR(50))
	BEGIN
		SET texto = LOWER(texto);
        SET texto = REPLACE(texto, 'á', 'a');
        SET texto = REPLACE(texto, 'é', 'e');
        SET texto = REPLACE(texto, 'í', 'i');
        SET texto = REPLACE(texto, 'ó', 'o');
        SET texto = REPLACE(texto, 'ú', 'u');
        SET texto = CONCAT(UPPER(SUBSTRING(texto, 1, 1)), SUBSTRING(texto, 2, LENGTH(texto)));
	END$$
DELIMITER ;
SET @texto = 'Lucía';
CALL transformar_sin_acentos(@texto);
SELECT @texto;

USE tienda;
-- 1.8.4
-- 1. Escribe un procedimiento para la base de datos tienda que devuelva el número total de productos que hay en la tabla productos.
DELIMITER $$
DROP PROCEDURE IF EXISTS get_numero_total_productos$$
CREATE PROCEDURE get_numero_total_productos(OUT numero_total_productos INT)
	BEGIN
		SELECT COUNT(p.id) INTO numero_total_productos FROM producto p;
	END$$
DELIMITER ;
CALL get_numero_total_productos(@numero_total_productos);
SELECT @numero_total_productos;

-- 2. Escribe un procedimiento para la base de datos tienda que devuelva el valor medio del precio de los productos de un determinado fabricante
-- que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.
DELIMITER $$
DROP PROCEDURE IF EXISTS get_precio_medio_por_fabricante$$
CREATE PROCEDURE get_precio_medio_por_fabricante(IN fabricante VARCHAR(50), OUT media_precio FLOAT)
	BEGIN
		SELECT AVG(p.precio) INTO media_precio FROM producto p WHERE id_fabricante =
			(SELECT f.id FROM fabricante f WHERE nombre = fabricante);
	END$$
DELIMITER ;
CALL get_precio_medio_por_fabricante('Samsung', @media_precio);
SELECT ROUND(@media_precio, 2);

-- 3. Escribe un procedimiento para la base de datos tienda que devuelva el valor máximo del precio de los productos de un determinado fabricante
-- que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.
DELIMITER $$
DROP PROCEDURE IF EXISTS get_precio_maximo_por_fabricante$$
CREATE PROCEDURE get_precio_maximo_por_fabricante(IN fabricante VARCHAR(50), OUT precio_maximo FLOAT)
	BEGIN
		SELECT MAX(p.precio) INTO precio_maximo FROM producto p WHERE id_fabricante =
			(SELECT f.id FROM fabricante f WHERE nombre = fabricante);
	END$$
DELIMITER ;
CALL get_precio_maximo_por_fabricante('Lenovo', @precio_maximo);
SELECT @precio_maximo;

-- 4. Escribe un procedimiento para la base de datos tienda que devuelva el valor mínimo del precio de los productos de un determinado fabricante
-- que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.
DELIMITER $$
DROP PROCEDURE IF EXISTS get_precio_minimo_por_fabricante$$
CREATE PROCEDURE get_precio_minimo_por_fabricante(IN fabricante VARCHAR(50), OUT precio_minimo FLOAT)
	BEGIN
		SELECT MIN(p.precio) INTO precio_minimo FROM producto p WHERE id_fabricante =
			(SELECT f.id FROM fabricante f WHERE nombre = fabricante);
	END$$
DELIMITER ;
CALL get_precio_minimo_por_fabricante('Asus', @precio_minimo);
SELECT @precio_minimo;