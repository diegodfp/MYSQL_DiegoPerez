-- Active: 1715038113479@@172.16.101.129@3306@jardineria

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

