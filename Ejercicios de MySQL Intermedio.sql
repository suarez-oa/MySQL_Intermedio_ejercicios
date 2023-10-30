-- Gestión de ventas
-- DROP DATABASE IF EXISTS ventas;

CREATE DATABASE ventas CHARACTER SET utf8mb4;
USE ventas;

CREATE TABLE cliente (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  ciudad VARCHAR(100),
  categoria INT UNSIGNED
);

CREATE TABLE comercial (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  comision FLOAT
);

CREATE TABLE pedido (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  total DOUBLE NOT NULL,
  fecha DATE,
  id_cliente INT UNSIGNED NOT NULL,
  id_comercial INT UNSIGNED NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);

INSERT INTO cliente VALUES(1, 'Aarón', 'Rivero', 'Gómez', 'Almería', 100);
INSERT INTO cliente VALUES(2, 'Adela', 'Salas', 'Díaz', 'Granada', 200);
INSERT INTO cliente VALUES(3, 'Adolfo', 'Rubio', 'Flores', 'Sevilla', NULL);
INSERT INTO cliente VALUES(4, 'Adrián', 'Suárez', NULL, 'Jaén', 300);
INSERT INTO cliente VALUES(5, 'Marcos', 'Loyola', 'Méndez', 'Almería', 200);
INSERT INTO cliente VALUES(6, 'María', 'Santana', 'Moreno', 'Cádiz', 100);
INSERT INTO cliente VALUES(7, 'Pilar', 'Ruiz', NULL, 'Sevilla', 300);
INSERT INTO cliente VALUES(8, 'Pepe', 'Ruiz', 'Santana', 'Huelva', 200);
INSERT INTO cliente VALUES(9, 'Guillermo', 'López', 'Gómez', 'Granada', 225);
INSERT INTO cliente VALUES(10, 'Daniel', 'Santana', 'Loyola', 'Sevilla', 125);

INSERT INTO comercial VALUES(1, 'Daniel', 'Sáez', 'Vega', 0.15);
INSERT INTO comercial VALUES(2, 'Juan', 'Gómez', 'López', 0.13);
INSERT INTO comercial VALUES(3, 'Diego','Flores', 'Salas', 0.11);
INSERT INTO comercial VALUES(4, 'Marta','Herrera', 'Gil', 0.14);
INSERT INTO comercial VALUES(5, 'Antonio','Carretero', 'Ortega', 0.12);
INSERT INTO comercial VALUES(6, 'Manuel','Domínguez', 'Hernández', 0.13);
INSERT INTO comercial VALUES(7, 'Antonio','Vega', 'Hernández', 0.11);
INSERT INTO comercial VALUES(8, 'Alfredo','Ruiz', 'Flores', 0.05);

INSERT INTO pedido VALUES(1, 150.5, '2017-10-05', 5, 2);
INSERT INTO pedido VALUES(2, 270.65, '2016-09-10', 1, 5);
INSERT INTO pedido VALUES(3, 65.26, '2017-10-05', 2, 1);
INSERT INTO pedido VALUES(4, 110.5, '2016-08-17', 8, 3);
INSERT INTO pedido VALUES(5, 948.5, '2017-09-10', 5, 2);
INSERT INTO pedido VALUES(6, 2400.6, '2016-07-27', 7, 1);
INSERT INTO pedido VALUES(7, 5760, '2015-09-10', 2, 1);
INSERT INTO pedido VALUES(8, 1983.43, '2017-10-10', 4, 6);
INSERT INTO pedido VALUES(9, 2480.4, '2016-10-10', 8, 3);
INSERT INTO pedido VALUES(10, 250.45, '2015-06-27', 8, 2);
INSERT INTO pedido VALUES(11, 75.29, '2016-08-17', 3, 7);
INSERT INTO pedido VALUES(12, 3045.6, '2017-04-25', 2, 1);
INSERT INTO pedido VALUES(13, 545.75, '2019-01-25', 6, 1);
INSERT INTO pedido VALUES(14, 145.82, '2017-02-02', 6, 1);
INSERT INTO pedido VALUES(15, 370.85, '2019-03-11', 1, 5);
INSERT INTO pedido VALUES(16, 2389.23, '2019-03-11', 1, 5);

-- EJERCICIOS 1.1 Consultas sobre una tabla

-- 1 Devuelve un listado con todos los pedidos que se han realizado. 
-- Los pedidos deben estar ordenados por la fecha de realización, 
-- mostrando en primer lugar los pedidos más recientes.
SELECT *
FROM pedido
ORDER BY fecha DESC;

-- 2 Devuelve todos los datos de los dos pedidos de mayor valor.
SELECT * 
FROM pedido 
ORDER BY total DESC
LIMIT 2;

-- 3 Devuelve un listado con los identificadores de los clientes 
-- que han realizado algún pedido. Tenga en cuenta que no debe mostrar 
-- identificadores que estén repetidos.
SELECT DISTINCT id_cliente
FROM pedido;

-- 4 Devuelve un listado de todos los pedidos que se realizaron durante el año 2017, 
-- cuya cantidad total sea superior a 500.
SELECT *
FROM pedido
WHERE YEAR(fecha) = 2017 AND total > 500;

-- 5 Devuelve un listado con el nombre y los apellidos de los comerciales que tienen
--  una comisión entre 0.05 y 0.11.
SELECT nombre, apellido1, apellido2, comision
FROM comercial
WHERE comision BETWEEN 0.05 AND 0.11;

-- 6 Devuelve el valor de la comisión de mayor valor que existe en la tabla comercial.
SELECT MAX(comision)
FROM comercial;

-- 7 Devuelve el identificador, nombre y primer apellido de aquellos clientes 
-- cuyo segundo apellido no es NULL. 
-- El listado deberá estar ordenado alfabéticamente por apellidos y nombre.
SELECT id, nombre, apellido1
FROM cliente
WHERE apellido2 IS NOT NULL
ORDER BY apellido1, nombre;

-- 8 Devuelve un listado de los nombres de los clientes que empiezan por A  y terminan por n 
-- y también los nombres que empiezan por P. 
-- El listado deberá estar ordenado alfabéticamente.
SELECT nombre 
FROM cliente
WHERE (nombre LIKE 'A%n' OR nombre LIKE 'P%')
ORDER BY nombre;

-- 9 Devuelve un listado de los nombres de los clientes que no empiezan por A. 
-- El listado deberá estar ordenado alfabéticamente.
SELECT nombre
FROM cliente
WHERE nombre NOT LIKE 'A%'
ORDER BY nombre;

-- 10 Devuelve un listado con los nombres de los comerciales que terminan por el o,
-- Tenga en cuenta que se deberán eliminar los nombres repetidos.
SELECT DISTINCT nombre
FROM comercial
WHERE nombre LIKE '%o';

-- 1.2 Consultas multitabla (Composición interna)

-- 1 Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes 
-- que han realizado algún pedido. El listado debe estar ordenado alfabéticamente 
-- y se deben eliminar los elementos repetidos.
SELECT DISTINCT c.id, c.nombre, c.apellido1, c.apellido2
FROM cliente c
INNER JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.apellido1, c.nombre;

-- 2 Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. 
-- El resultado debe mostrar todos los datos de los pedidos y del cliente. 
-- El listado debe mostrar los datos de los clientes ordenados alfabéticamente.
SELECT c.nombre, c.apellido1, c.apellido2, p.*
FROM cliente c
INNER JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.apellido1, c.nombre;

-- 3 Devuelve un listado que muestre todos los pedidos en los que ha  
-- participado un comercial. El resultado debe mostrar todos los datos de los 
-- pedidos y de los comerciales. El listado debe mostrar los datos de los comerciales 
-- ordenados alfabéticamente.
SELECT co.id AS ComercialID, co.nombre AS NombreComercial, co.apellido1 AS Apellido1Comercial, co.apellido2 AS Apellido2Comercial, p.*
FROM comercial co
INNER JOIN pedido p ON co.id = p.id_comercial
ORDER BY co.apellido1, co.nombre;

-- 4 Devuelve un listado que muestre todos los clientes, con todos los pedidos que 
-- han realizado y con los datos de los comerciales asociados a cada pedido.
SELECT c.id AS ClienteID, c.nombre AS NombreCliente, c.apellido1 AS Apellido1Cliente, c.apellido2 AS Apellido2Cliente, p.*, co.id AS ComercialID, co.nombre AS NombreComercial, co.apellido1 AS Apellido1Comercial, co.apellido2 AS Apellido2Comercial
FROM cliente c
INNER JOIN pedido p ON c.id = p.id_cliente
INNER JOIN comercial co ON p.id_comercial = co.id;


-- 5 Devuelve un listado de todos los clientes que realizaron un pedido durante 
-- el año 2017, cuya cantidad esté entre 300 y 1000.
SELECT DISTINCT c.id, c.nombre, c.apellido1, c.apellido2, p.fecha, p.total
FROM cliente c
INNER JOIN pedido p ON c.id = p.id_cliente
WHERE YEAR(p.fecha) = 2017 AND p.total BETWEEN 300 AND 1000
ORDER BY c.apellido1, c.nombre;

-- 6 Devuelve el nombre y los apellidos de todos los comerciales que ha 
-- participado en algún pedido realizado por María Santana Moreno.
SELECT DISTINCT co.nombre, co.apellido1, co.apellido2
FROM comercial co
INNER JOIN pedido p ON co.id = p.id_comercial
INNER JOIN cliente c ON p.id_cliente = c.id
WHERE c.nombre = 'María' AND c.apellido1 = 'Santana' AND c.apellido2 = 'Moreno';


-- 7 Devuelve el nombre de todos los clientes que han realizado algún pedido con 
-- el comercial Daniel Sáez Vega.
SELECT DISTINCT c.nombre
FROM cliente c
INNER JOIN pedido p ON c.id = p.id_cliente
INNER JOIN comercial co ON p.id_comercial = co.id
WHERE co.nombre = 'Daniel' AND co.apellido1 = 'Sáez' AND co.apellido2 = 'Vega';


-- 1.3 Consultas resumen

-- 1 Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.
SELECT SUM(total) AS TotalCantidad
FROM pedido;

-- 2 Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.
SELECT AVG(total) AS MediaCantidad
FROM pedido;

-- 3 Calcula el número total de comerciales distintos que aparecen en la tabla pedido.
SELECT COUNT(DISTINCT id_comercial) AS TotalComerciales
FROM pedido;

-- 4 Calcula el número total de clientes que aparecen en la tabla cliente.
SELECT COUNT(*) AS TotalClientes
FROM cliente;

-- 5 Calcula cuál es la mayor cantidad que aparece en la tabla pedido.
SELECT MAX(total) AS MayorCantidad
FROM pedido;

-- 6 Calcula cuál es la menor cantidad que aparece en la tabla pedido.
SELECT MIN(total) AS MenorCantidad
FROM pedido;

-- 7 Calcula cuál es el valor máximo de categoría para cada una de las ciudades 
-- que aparece en la tabla cliente.
SELECT ciudad, MAX(categoria) AS MaxCategoria
FROM cliente
GROUP BY ciudad;

-- 8 Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales 
-- durante la fecha 2016-08-17. Muestra el identificador del comercial, nombre, apellidos y total.
SELECT id_comercial, nombre, apellido1, apellido2, MAX(total) AS MaxCantidad
FROM pedido
INNER JOIN comercial ON pedido.id_comercial = comercial.id
WHERE fecha = '2016-08-17'
GROUP BY id_comercial, nombre, apellido1, apellido2;

-- 9 Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total
--  de pedidos que ha realizado cada uno de clientes durante el año 2017.
SELECT c.id AS ClienteID, c.nombre AS NombreCliente, c.apellido1 AS Apellido1Cliente, c.apellido2 AS Apellido2Cliente, COUNT(p.id) AS TotalPedidos
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente AND YEAR(p.fecha) = 2017
GROUP BY c.id, c.nombre, c.apellido1, c.apellido2;


-- 10 Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido 
-- y el valor de la máxima cantidad del pedido realizado por cada uno de los clientes. 
-- El resultado debe mostrar aquellos clientes que no han realizado ningún pedido indicando
-- que la máxima cantidad de sus pedidos realizados es 0. 
-- Puede hacer uso de la función IFNULL.
SELECT c.id AS ClienteID, c.nombre AS NombreCliente, c.apellido1 AS Apellido1Cliente, IFNULL(MAX(p.total), 0) AS MaximaCantidad
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
GROUP BY c.id, c.nombre, c.apellido1;

-- 11 Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.
SELECT YEAR(fecha) AS Anio, MAX(total) AS MaximoValorPedido
FROM pedido
GROUP BY YEAR(fecha);

-- 12 Devuelve el número total de pedidos que se han realizado cada año.
SELECT YEAR(fecha) AS Anio, COUNT(*) AS TotalPedidosPorAnio
FROM pedido
GROUP BY YEAR(fecha);


-- -------------------- EXTRA NO TIENE PUNTO ------------------------------
-- A Devuelve el pedido más caro que existe en la tabla pedido si hacer uso de MAX, ORDER BY ni LIMIT.
SELECT *
FROM pedido
WHERE total = (SELECT MAX(total) FROM pedido);

-- B Devuelve un listado de los clientes que no han realizado ningún pedido. (Utilizando ANY o ALL).
SELECT id, nombre, apellido1, apellido2
FROM cliente
WHERE id NOT IN (SELECT DISTINCT id_cliente FROM pedido);

-- C Devuelve un listado de los comerciales que no han realizado ningún pedido. (Utilizando ANY o ALL).
SELECT id, nombre, apellido1, apellido2
FROM comercial
WHERE id NOT IN (SELECT DISTINCT id_comercial FROM pedido);

