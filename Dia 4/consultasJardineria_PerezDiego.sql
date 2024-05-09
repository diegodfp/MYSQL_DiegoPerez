-- Active: 1715038113479@@172.16.101.129@3306@jardineria


-- ##############################################
-- ############### EJERCICIO DIA 4 ##############
-- ##### CONSULTAS BASE DE DATOS JARDINERIA #####
-- ##############################################

use jardineria;
-- Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

select O.codigo_oficina, O.ciudad 
from oficina as O;

--  Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
 select O.codigo_oficina, O.ciudad 
from oficina as O
where O.pais = "España";

-- Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.

select E.nombre, concat(E.apellido1,"  ", E.apellido2) as apellidos, E.email 
from empleado as E
where E.codigo_jefe = 7;

-- Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
select E.puesto as "Nombre del puesto", concat(E.nombre,"  ",E.apellido1,"  ", E.apellido2) as "Nombre Completo", E.email 
from empleado as E
where E.puesto = "Director General";

-- Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
select  concat(E.nombre,"  ",E.apellido1,"  ", E.apellido2) as "Nombre Completo", E.puesto as "Nombre del puesto"
from empleado as E
where E.puesto != "Representante Ventas" ;

-- Devuelve un listado con el nombre de los todos los clientes españoles.
select pais from cliente ; -- Buscamos como sale españa en la tabla
select C.nombre_cliente, C.pais
from cliente as C
where C.pais = "Spain";

-- Devuelve un listado con los distintos estados por los que puede pasar un pedido.

select distinct P.estado as "posible Estado del Pedido"
from pedido as P;

-- Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. 
-- Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
-- Utilizando la función YEAR de MySQL --

select distinct P.codigo_cliente, year(P.fecha_pago) as "Año Pago"
from pago as P
where year(P.fecha_pago) = 2008;

-- Utilizando la función DATE_FORMAT de MySQL. 
SELECT distinct P.codigo_cliente, DATE_FORMAT(P.fecha_pago, '%Y')
from pago as P
where DATE_FORMAT(P.fecha_pago, '%Y') = 2008;

-- Sin utilizar ninguna de las funciones anteriores --
select distinct P.codigo_cliente
from pago as P
where P.fecha_pago between "2008-01-01" and "2008-12-31"; 

/*
Devuelve un listado con el código de pedido, código de cliente, fecha esperada y 
fecha de entrega de los pedidos que no han sido entregados a tiempo
*/
select P.codigo_pedido, P.codigo_cliente, P.fecha_esperada, P.fecha_entrega
from pedido as P
where P.fecha_esperada < P.fecha_entrega;

/*
Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega 
de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
*/
-- Utilizando la función ADDDATE de MySQL.
select P.codigo_pedido, P.codigo_cliente, P.fecha_esperada, P.fecha_entrega
from pedido as P
where P.fecha_entrega <= ADDDATE(P.fecha_esperada,  -2 );
 -- la logica seria. donde fecha de entrega sea menor o igual a la fecha esperada restandole 2 dias

-- Utilizando la función DATEDIFF de MySQL. --
select P.fecha_esperada, P.fecha_entrega, datediff(P.fecha_esperada , P.fecha_entrega) from pedido as P;
select P.codigo_pedido, P.codigo_cliente, P.fecha_esperada, P.fecha_entrega
from pedido as P
where datediff(P.fecha_esperada , P.fecha_entrega) >= 2 ;
-- La opcion DATEDIFF ME DEVUELVE UN NUMERO ENTERO, le resta la diferencia del primer parametro al segundo
-- ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -? -- 
-- si es posible -- 
select P.codigo_pedido, P.codigo_cliente, P.fecha_esperada, P.fecha_entrega
from pedido as P
where (P.fecha_esperada - P.fecha_entrega) >= 2 ;

-- Devuelve un listado de todos los pedidos que fueron en 2009. --
SELECT * 
from pedido as P
where DATE_FORMAT(P.fecha_pedido, '%Y') = 2009;

-- Devuelve un listado de todos los pedidos que han sido  en el mes de enero de cualquier año.

SELECT * 
from pedido as P
where DATE_FORMAT(P.fecha_pedido, '%m') = 01;

--  Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
select *
from pago as P
where DATE_FORMAT(P.fecha_pago, '%Y') = 2008 AND P.forma_pago = "Paypal"
order by P.total;

--  Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. 
-- Tenga en cuenta que no deben aparecer formas de pago repetidas.

select distinct P.forma_pago as "Formas de pago" 
from pago as P;

/* Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock.
 El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
 */ 
 
 select *
 from producto as P
 where P.gama = "Ornamentales" and P.cantidad_en_stock > 100
 order by P.precio_venta desc;
 
 -- Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga 
 -- el código de empleado 11 o 30.

select * 
from cliente as C
where C.ciudad = "Madrid" and C.codigo_empleado_rep_ventas = 11 or C.codigo_empleado_rep_ventas = 30 ;


-- #### CONSULTAS CON INNER JOIN ####
-- Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

use jardineria;
select C.nombre_cliente, concat( E.nombre, " " , E.apellido1) 
from cliente as C
inner join empleado as E on C.codigo_empleado_rep_ventas = E.codigo_empleado;

--  Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
select distinct C.nombre_cliente, concat( E.nombre, " " , E.apellido1) 
from cliente as C
inner join empleado as E on C.codigo_empleado_rep_ventas = E.codigo_empleado
inner join  pago as P on P.codigo_cliente = C.codigo_cliente;

-- Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de
-- la oficina a la que  pertenece el representante. 
select distinct C.nombre_cliente, concat( E.nombre, " " , E.apellido1) as "nombre completo" , O.ciudad
from cliente as C
inner join empleado as E on C.codigo_empleado_rep_ventas = E.codigo_empleado
inner join  pago as P on P.codigo_cliente = C.codigo_cliente
inner join oficina as O on O.codigo_oficina = E.codigo_oficina;
/* Devuelve el nombre de los clientes que  hayan hecho pagos y
 el nombre de sus representantes junto con la ciudad de la oficina a 
 la que pertenece el representante.Lista la dirección 
de las oficinas que tengan clientes en Fuenlabrada. */


/*Devuelve el nombre de los clientes y el nombre de sus representantes 
junto con la ciudad de la oficina a la que pertenece el representante. */

select C.nombre_cliente as "Nombre Cliente",  concat(E.nombre, " ",E.apellido1) as 
"Empleado Nombre", O.ciudad as "Oficina a la que pertenece"
from cliente as C
inner join empleado as E on E.codigo_empleado = C.codigo_empleado_rep_ventas
inner join oficina as O on O.codigo_oficina = E.codigo_oficina;

/* Devuelve un listado con el nombre de los empleados junto con el nombre de 
sus jefes. */
SELECT e.nombre, j.nombre AS nombre_jefe
FROM empleado e
LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado; 
select * from empleado;

/* Devuelve un listado que muestre el nombre de cada empleados, el nombre de su 
jefe y el nombre del jefe de sus jefe. */ 

SELECT 
    E1.nombre AS empleado,
    E2.nombre AS jefe,
    E3.nombre AS jefe_del_jefe
FROM 
    empleado as E1
    JOIN empleado as E2 ON E1.codigo_jefe = E2.codigo_empleado 
    LEFT JOIN empleado as E3 ON E2.codigo_jefe = E3.codigo_empleado; 
    
/* Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido. */

SELECT DISTINCT c.nombre_cliente
FROM cliente as c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada OR p.fecha_entrega IS NULL;

-- Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

SELECT DISTINCT c.nombre_cliente, gp.gama
FROM cliente as c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
JOIN detalle_pedido as dp ON p.codigo_pedido = dp.codigo_pedido
JOIN producto as pr ON dp.codigo_producto = pr.codigo_producto
JOIN gama_producto  as gp ON pr.gama = gp.gama
ORDER BY c.nombre_cliente, gp.gama;