USE sakila;

DROP PROCEDURE IF EXISTS nombreProc;
DELIMITER $$
CREATE PROCEDURE nombreProc(INOUT p4 INT, OUT parametro3 VARCHAR(10),IN parametro1 INT, IN parametro2 varchar(30))
BEGIN
-- Declaración variables locales
DECLARE varLocal1 INT;
DECLARE varLocal2 VARCHAR(30);

-- Inicialización variables locales
SET varLocal1 = 6; -- Directamente introduciendo el valor

-- Cambiamos el valor al parametro 4 p4
SET p4 = 20;

SELECT count(actor_id) INTO varLocal1
FROM actor; -- o bien, cogiéndolo de una tabla...

SET varLocal2 = 'HELLO WORD 2!!';



-- Variable global
SET @global3 = 23.24;

-- Mostrar variables globlales y locales.
Select @global1, @global2, @global3;
Select varLocal1, varLocal2;

-- Mostrar parámetros
SET parametro1 = 10; -- Puedo modificar el valor de los parámetros también
Select parametro1, parametro2;

-- Ponemos valores a parametros de salida
Select 'Hellooouuu' INTO parametro3;
-- lo mismo que SET parametro3 = 'Hellooouuu';

END $$
DELIMITER ;

SET @g5 = 9;

-- Llamada al procedimiento
CALL nombreProc(@g5,@globalParametro, 7, 'Hello word 3!');
-- Muestro el valor de la variable global creada
-- para recoger el valor del parametro de salida
Select @globalParametro;
Select @g5;

-- Variable Global
SET @global1 = 5;
SET @global2 = 'Hello word!';

Select @global1, @global2;
select @global3;

-- Error
 -- Select varLocal1, varLocal2; -- Error no conoce las variables locales