-- #############################
-- ##### EJERCICIO DIA 4 #######
-- #############################

-- Creacion y uso de la BBDD  paises
CREATE DATABASE Paises;

use  Paises;



--  CREACION TABLA PAIS --
CREATE TABLE  pais(
    id_pais int PRIMARY KEY,
    nombre VARCHAR(20),
    continente VARCHAR(50),
    poblacion int
);
--  CREACION TABLA IDIOMA --

CREATE TABLE  idioma(
    id_idioma int PRIMARY KEY,
    idioma VARCHAR(50)
);
--  CREACION TABLA CIUDAD, RELACION DEBIL CON CIUDAD--

CREATE TABLE ciudad(
    id_ciudad int,
    nombre VARCHAR(20),
    id_pais int,
    Foreign Key (id_pais) REFERENCES pais(id_pais)
);
--  CREACION TABLA IDIOMA PAIS, RELACION FUERTE --

CREATE TABLE  idioma_pais(
    id_idioma int,
    id_pais int,
    es_oficial TINYINT(1),
    PRIMARY KEY (id_idioma, id_pais),
    Foreign Key (id_idioma) REFERENCES idioma (id_idioma),
    Foreign Key (id_pais) REFERENCES pais(id_pais)
);

 -- INSERCION DE DATOS EN LA TABLA PAIS --
INSERT INTO pais VALUES
     (1,"Colombia","Sur America", 48000000),
     (2,"Venezuela","Sur America", 8000000),
     (3,"Brazil","Sur America", 98000000),
     (4,"Peru","Sur America", 24000000),
     (5,"Estados unidos","Norte America", 333000000),
     (6,"Mexico","Sur America", 148000000),
     (7,"España","Europa", 88000000),
     (8,"Italia","Europa", 58000000),
     (9,"Japon","Asia", 148000000),
     (10,"China","Asia", 1412000000) ;

-- INSERCION DE DATOS EN LA TABLA IDIOMA --
INSERT INTO  idioma VALUES
    (6,"Chibcha"),
    (7,"Señas"),
    (8,"Spagueti"),
    (9,"Cantones"),
    (10,"mudo");

-- INSERCION DE DATOS EN LA TABLA CIUDAD --

INSERT INTO  ciudad VALUES
    (1,"Bucaramanga",1),
    (2,"Caracas",2),
    (3,"Brasilia",3),
    (4,"Cusco",4),
    (5,"New York",5),
    (6,"Monterrey",6),
    (7,"Madird",7),
    (8,"Roma",8),
    (9,"Osaka",9),
    (10,"Pekin",10);

-- INSERCION DE DATOS EN LA TABLA IDIOMA_PAIS --

INSERT INTO  idioma_pais(id_idioma, id_pais, es_oficial) VALUES
    (10,10,1);


INSERT INTO ciudad (id_ciudad, nombre, id_pais)
VALUES 
       (2, 'Medellín', 1),
       (3, 'Cali', 1),
       (4, 'Barranquilla', 1),
       (5, 'Cartagena', 1),
       (6, 'Cúcuta', 1),
       (7, 'Bogotá', 1),
       (8, 'Pasto', 1),
       (9, 'Manizales', 1),
       (10, 'Pereira', 1),
       (11, 'Santa Marta', 1),
       (12, 'Villavicencio', 1),
       (13, 'Neiva', 1),
       (14, 'Armenia', 1),
       (15, 'Ibagué', 1),
       (16, 'Popayán', 1),
       (17, 'Sincelejo', 1),
       (18, 'Valledupar', 1),
       (19, 'Riohacha', 1),
       (20, 'Tunja', 1),
       (21, 'Quibdó', 1),
       (22, 'Montería', 1),
       (23, 'Villavicencio', 1),
       (24, 'Florence', 1),
       (25, 'Yopal', 1);

-- consulta para averiguar todas las ciudades de un pais en especifico
-- SE Usa inner join, junto la restriccion  del pais deseado 

select C.nombre
from ciudad as C
INNER JOIN pais as P on C.id_pais = P.id_pais
WHERE P.nombre = "Colombia";
ddd


-- DESARROLLADO POR  DIEGO PEREZ C.C 1.098.792.956 --
