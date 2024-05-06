USE tienda;

-- 1. Devuelve todos los productos del fabricante Lenovo.
SELECT * FROM producto WHERE id_fabricante =
	(SELECT id FROM fabricante WHERE nombre = 'Lenovo');

-- 2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo.
SELECT * FROM producto WHERE precio =
	(SELECT max(precio) FROM producto WHERE id_fabricante =
		(SELECT id FROM fabricante WHERE nombre = 'Lenovo'));
        
-- 3. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT nombre FROM producto WHERE precio =
	(SELECT max(precio) FROM producto WHERE id_fabricante =
		(SELECT id FROM fabricante WHERE nombre = 'Lenovo'))
        AND id_fabricante =
        (SELECT id FROM fabricante WHERE nombre = 'Lenovo');
        
-- 4. Lista el nombre del producto más barato del fabricante Hewlett-Packard
SELECT nombre FROM producto WHERE precio =
	(SELECT min(precio) FROM producto WHERE id_fabricante =
		(SELECT id FROM fabricante WHERE nombre = 'Hewlett-Packard'))
        AND id_fabricante =
        (SELECT id FROM fabricante WHERE nombre = 'Hewlett-Packard');
        
-- 5. Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.
SELECT * FROM producto WHERE precio >=
	(SELECT max(precio) FROM producto WHERE id_fabricante =
		(SELECT id FROM fabricante WHERE nombre = 'Lenovo'));
        
-- 6. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT * FROM producto WHERE precio >
	(SELECT avg(precio) FROM producto WHERE id_fabricante =
		(SELECT id FROM fabricante WHERE nombre = 'Asus'))
        AND id_fabricante =
        (SELECT id FROM fabricante WHERE nombre = 'Asus');
        
-- 12. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM fabricante WHERE id IN
	(SELECT id_fabricante FROM producto GROUP BY id_fabricante HAVING count(id_fabricante) > 1);
    
-- 13. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM fabricante WHERE id NOT IN
	(SELECT id_fabricante FROM producto GROUP BY id_fabricante HAVING count(id_fabricante) > 1);
    
-- 16. Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.
SELECT f.nombre,
	(SELECT p.nombre FROM producto p WHERE f.id = p.id_fabricante ORDER BY p.precio DESC LIMIT 1) AS nombre,
	(SELECT p.precio FROM producto p WHERE f.id = p.id_fabricante ORDER BY p.precio DESC LIMIT 1) AS precio FROM fabricante f;

-- 17. Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos de su mismo fabricante.
SELECT * FROM producto p WHERE precio >=
	(SELECT avg(p.precio) FROM producto p, fabricante f WHERE p.id_fabricante = f.id);

-- 18. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT nombre FROM producto WHERE precio =
	(SELECT max(precio) FROM producto WHERE id_fabricante =
		(SELECT id FROM fabricante WHERE nombre = 'Lenovo'));

-- 19. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
SELECT f.nombre FROM fabricante f, producto p GROUP BY f.id HAVING count(p.id) =
	(SELECT count(id) FROM producto WHERE id_fabricante =
		(SELECT id FROM fabricante WHERE nombre = 'Lenovo'));