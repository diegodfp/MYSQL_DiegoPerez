-- Active: 1714079791094@@127.0.0.1@3306


create DATABASE escuelaPrueba;
use escuelaPrueba;
CREATE TABLE Alumno    (
  id_alumno        INT            PRIMARY KEY ,
  nif      VARCHAR(9)   NOT NULL,
  nombre          VARCHAR(25)   NOT NULL,
  apellido1         VARCHAR(50)   NOT NULL,
  apellido2          VARCHAR(50),
  ciudad         VARCHAR(25)   NOT NULL,
  direccion         VARCHAR(50)   NOT NULL,
  telefono         VARCHAR(9)   ,
  fecha_nacimiento         DATE  NOT NULL,
  sexo         VARCHAR(7)   NOT NULL,
  tipo         VARCHAR(10)   NOT NULL
);
drop Table Alumno;

CREATE TABLE Departamento (
    id_departamento int PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

drop TABLE Departamento;
CREATE TABLE Profesor (
    id_profesor int PRIMARY KEY,
    id_departamento int,
    Foreign Key (id_departamento) REFERENCES Departamento(id_departamento)
);

CREATE TABLE Grado (
    id_grado int PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Asignatura (
    id_asignatura int PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    creditos FLOAT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    curso TINYINT(3) NOT NULL,
    cuatrimestre TINYINT(3) NOT NULL,
    id_profesor INT,
    id_grado INT,
    Foreign Key (id_profesor) REFERENCES Profesor(id_profesor),
    Foreign Key (id_grado) REFERENCES Grado(id_grado)
);

CREATE TABLE Curso_escolar(
    id_curso_escolar int PRIMARY KEY,
    anyo_inicio  YEAR(4) NOT NULL,
    anyo_fin  YEAR(4) NOT NULL
);


CREATE TABLE Alumno_se_matricula_asignatura(
    id_alumno int,
    id_asignatura int,
    id_curso_escolar INT,
    PRIMARY KEY (id_alumno, id_asignatura, id_curso_escolar),
    Foreign Key (id_alumno) REFERENCES Alumno(id_alumno),
    Foreign Key (id_asignatura) REFERENCES Asignatura(id_asignatura),
    Foreign Key (id_curso_escolar) REFERENCES Curso_escolar(id_curso_escolar)
);

