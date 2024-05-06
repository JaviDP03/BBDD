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