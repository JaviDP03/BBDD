USE ventas;

-- 1. Devuelve un listado con todos los pedidos que ha realizado Adela Salas Díaz. (Sin utilizar INNER JOIN).
SELECT * FROM pedido WHERE id_cliente IN
	(SELECT id FROM cliente WHERE upper(nombre) = 'ADELA' AND upper(apellido1) = 'SALAS' AND upper(apellido2) = 'DÍAZ');
    
-- 2. Devuelve el número de pedidos en los que ha participado el comercial Daniel Sáez Vega. (Sin utilizar INNER JOIN).
SELECT * FROM pedido WHERE id_comercial IN
	(SELECT id FROM comercial WHERE upper(nombre) = 'DANIEL' AND upper(apellido1) = 'SÁEZ' AND upper(apellido2) = 'VEGA');
    
-- 3. Devuelve los datos del cliente que realizó el pedido más caro en el año 2019. (Sin utilizar INNER JOIN).
SELECT * FROM cliente WHERE id =
	(SELECT id_cliente FROM pedido WHERE total =
		(SELECT max(total) FROM pedido WHERE year(fecha) = 2019));
        
-- 4. Devuelve la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe Ruiz Santana.
SELECT fecha, min(total) AS cantidad FROM pedido WHERE id_cliente =
		(SELECT id FROM cliente WHERE upper(nombre) = 'PEPE' AND upper(apellido1) = 'RUIZ' AND upper(apellido2) = 'SANTANA');
        
/* 5. Devuelve un listado con los datos de los clientes y los pedidos, de todos los clientes que han realizado
un pedido durante el año 2017 con un valor mayor o igual al valor medio de los pedidos realizados durante ese mismo año. */
SELECT c.*, p.* FROM cliente c, pedido p WHERE c.id IN
	(SELECT id_cliente FROM pedido WHERE total >=
		(SELECT avg(total) FROM pedido WHERE year(fecha) = 2017))
AND c.id = p.id_cliente;

-- 9. Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando IN o NOT IN).
SELECT * FROM cliente WHERE id NOT IN
	(SELECT id_cliente FROM pedido);
    
-- 10. Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando IN o NOT IN).
SELECT * FROM comercial WHERE id NOT IN
	(SELECT id_comercial FROM pedido);