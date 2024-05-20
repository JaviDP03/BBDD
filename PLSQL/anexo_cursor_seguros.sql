DELIMITER $$
DROP PROCEDURE IF EXISTS calculo_seguros$$
CREATE PROCEDURE calculo_seguros()
	BEGIN
		DECLARE done BOOLEAN DEFAULT FALSE;
		DECLARE cliente_id INT;
        DECLARE annoNac, edad INT;
        DECLARE sexo, coche, hogar, salud CHAR(1);
        DECLARE numeroSeguros INT DEFAULT 0;
        DECLARE precio FLOAT;
        DECLARE cursor1 CURSOR FOR
			SELECT * FROM seguros;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
        
        OPEN cursor1;
			bucle1: LOOP
				FETCH cursor1 INTO cliente_id, annoNac, sexo, coche, hogar, salud, precio;
                IF (done = TRUE) THEN
					LEAVE bucle1;
                END IF;
                SET edad = 2024 - annoNac;
                -- Calculo nuevo precio
                IF (edad < 5) THEN
					SET precio = precio * 1.15;
				ELSEIF ((edad BETWEEN 18 AND 35) AND sexo = 'F') THEN
					SET precio = precio * 1.20;
				ELSEIF (edad > 35 AND sexo = 'M') THEN
					SET precio = precio * 1.20;
                END IF;
                -- Condicionales seguros
                IF (coche = 'S') THEN
					SET numeroSeguros = numeroSeguros + 1;
				END IF;
				IF (hogar = 'S') THEN
					SET numeroSeguros = numeroSeguros + 1;
				END IF;
				IF (salud = 'S') THEN
					SET numeroSeguros = numeroSeguros + 1;
				END IF;
                SET precio = precio * 0.1 * numeroSeguros;
                
				UPDATE seguros
					SET pBase = precio WHERE id_cliente = cliente_id;
	
            END LOOP bucle1;
            
			SELECT id_cliente, pBase FROM seguros;
            
        CLOSE cursor1;
    END$$
DELIMITER ;

CALL calculo_seguros();