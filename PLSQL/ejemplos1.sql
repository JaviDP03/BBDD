USE sakila;

-- Procedimiento para calcular el cubo
DROP PROCEDURE IF EXISTS cubo;
DELIMITER $$
CREATE PROCEDURE cubo(INOUT numero int)
	BEGIN
		SET numero = POWER(numero, 3);
	END $$
DELIMITER ;

SET @variable = 3;
CALL cubo(@variable);
SELECT @variable AS 'Cubo de @variable';

-- Procedimiento IN edad, OUT mensaje, INOUT sueldo +5%
DROP PROCEDURE IF EXISTS proc1;
DELIMITER $$
CREATE PROCEDURE proc1(IN edad INT, OUT mensaje VARCHAR(30), INOUT sueldo FLOAT)
	BEGIN
		DECLARE porcentajeIncremento INT;
        SET porcentajeIncremento = 5;
		SET mensaje = CONCAT('Tienes ', edad, ' años.');
        SET sueldo = sueldo + sueldo * porcentajeIncremento / 100;
	END $$

SET @sueldo = 1700;
CALL proc1(20, @mensaje, @sueldo);
SELECT @mensaje AS mensaje, CONCAT(@sueldo, '€') AS sueldo;