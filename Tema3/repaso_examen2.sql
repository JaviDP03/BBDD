-- Selección base de datos
USE BD_ejemploEx1;


-- Ejercicio 5
UPDATE empleado
	SET jefe = 2 WHERE idEmpleado = 3;
    
    
-- Ejercicio 6
ALTER TABLE emp_pro
	DROP FOREIGN KEY fk1_emppro,
	DROP FOREIGN KEY fk2_emppro;
    
ALTER TABLE emp_pro
	ADD CONSTRAINT fk1_emppro FOREIGN KEY (idEmpleado) REFERENCES empleado (idEmpleado) ON DELETE CASCADE,
    ADD CONSTRAINT fk2_emppro FOREIGN KEY (idProyecto) REFERENCES proyecto (idProyecto) ON DELETE CASCADE;
/* Es una buena práctica, ya que si borramos un registro, se borran los demás que estén relacionados 
y no habría que ir buscando los registros y eliminando uno por uno. */