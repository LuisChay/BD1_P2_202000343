CREATE DATABASE IF NOT EXISTS proyecto2_bases;
USE proyecto2_bases;

CREATE TABLE IF NOT EXISTS carrera (
    id_carrera INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_carrera VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS curso (
    codigo_curso INT NOT NULL PRIMARY KEY,
    nombre_curso VARCHAR(100) NOT NULL,
    creditos_necesarios INT NOT NULL,
    creditos_otorgados INT NOT NULL,
    carrera_perteneciente INT NOT NULL,
    FOREIGN KEY (carrera_perteneciente) REFERENCES carrera(id_carrera),
    obligatorio BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS estudiante (
    carnet BIGINT NOT NULL  PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono BIGINT NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    dpi BIGINT NOT NULL,
    id_carrera_estudiante INT NOT NULL,
    FOREIGN KEY (id_carrera_estudiante) REFERENCES carrera(id_carrera),
    creditos INT NOT NULL,
    fecha_creacion DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS docente (
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    correo VARCHAR(100) NOT NULL,
    telefono BIGINT NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    dpi BIGINT NOT NULL,
    siif BIGINT NOT NULL PRIMARY KEY,
    fecha_creacion DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS curso_habilitado (
    codigo_curso_habilitado INT NOT NULL,
    FOREIGN KEY (codigo_curso_habilitado) REFERENCES curso(codigo_curso),
    ciclo VARCHAR(10) NOT NULL,
    docente BIGINT NOT NULL,
    FOREIGN KEY (docente) REFERENCES docente(siif),
    cupo_maximo INT NOT NULL,
    seccion CHAR NOT NULL,
    anio INT NOT NULL,
    canitdad_estudiantes INT NOT NULL,
    id_habilitado INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE IF NOT EXISTS horario (
    codigo_curso INT NOT NULL,
    FOREIGN KEY (codigo_curso) REFERENCES curso_habilitado(codigo_curso_habilitado),
    dia int NOT NULL,
    horario VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS asignacion (
    codigo_curso INT NOT NULL,
    FOREIGN KEY (codigo_curso) REFERENCES curso_habilitado(codigo_curso_habilitado),
    carnet_estudiante BIGINT NOT NULL,
    FOREIGN KEY (carnet_estudiante) REFERENCES estudiante(carnet),
    estado BOOLEAN NOT NULL, 
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS nota (
    codigo_curso INT NOT NULL,
    FOREIGN KEY (codigo_curso) REFERENCES curso_habilitado(codigo_curso_habilitado),
    ciclo VARCHAR(10) NOT NULL,
    seccion CHAR NOT NULL,
    carnet_estudiante BIGINT NOT NULL,
    FOREIGN KEY (carnet_estudiante) REFERENCES estudiante(carnet),
    nota INT NOT NULL,
    anio INT NOT NULL
);

CREATE TABLE IF NOT EXISTS acta (
    codigo_curso INT NOT NULL,
    FOREIGN KEY (codigo_curso) REFERENCES curso_habilitado(codigo_curso_habilitado),
    ciclo VARCHAR(10) NOT NULL,
    seccion CHAR NOT NULL,
    fecha_creacion DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS transaccion (
    fecha DATETIME NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    tipo VARCHAR(100) NOT NULL
);

-- REGISTRO DE CARRERAS
CALL crearCarrera('Ingenieria Civil');       -- 1  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Industrial');  -- 2  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Sistemas');    -- 3  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Electronica'); -- 4  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Mecanica');    -- 5  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Mecatronica'); -- 6  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Quimica');     -- 7  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Ambiental');   -- 8  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Materiales');  -- 9  VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE
CALL crearCarrera('Ingenieria Textil');      -- 10 VALIDAR QUE LES QUEDE ESTE ID EN LA CARRERA CORRESPONDIENTE

-- REGISTRO DE DOCENTES
CALL registrarDocente('DocenteUno','ApellidoUno','1999-10-30','aadf@ingenieria.usac.edu.gt',12345678,'direccion',12345678910,1);
CALL registrarDocente('DocenteDos','ApellidoDos','1999-11-20','docente2@ingenieria.usac.edu.gt',12345678,'direcciondocente2',12345678911,2);
CALL registrarDocente('DocenteTres','ApellidoTres','1980-12-20','docente3@ingenieria.usac.edu.gt',12345678,'direcciondocente3',12345678912,3);
CALL registrarDocente('DocenteCuatro','ApellidoCuatro','1981-11-20','docente4@ingenieria.usac.edu.gt',12345678,'direcciondocente4',12345678913,4);
CALL registrarDocente('DocenteCinco','ApellidoCinco','1982-09-20','docente5@ingenieria.usac.edu.gt',12345678,'direcciondocente5',12345678914,5);

-- REGISTRO DE ESTUDIANTES
-- SISTEMAS
CALL registrarEstudiante(202000001,'Estudiante de','Sistemas Uno','1999-10-30','sistemasuno@gmail.com',12345678,'direccion estudiantes sistemas 1',337859510101,3);
CALL registrarEstudiante(202000002,'Estudiante de','Sistemas Dos','2000-05-03','sistemasdos@gmail.com',12345678,'direccion estudiantes sistemas 2',32781580101,3);
CALL registrarEstudiante(202000003,'Estudiante de','Sistemas Tres','2002-05-03','sistemastres@gmail.com',12345678,'direccion estudiantes sistemas 3',32791580101,3);
-- CIVIL
CALL registrarEstudiante(202100001,'Estudiante de','Civil Uno','1990-05-03','civiluno@gmail.com',12345678,'direccion de estudiante civil 1',3182781580101,1);
CALL registrarEstudiante(202100002,'Estudiante de','Civil Dos','1998-08-03','civildos@gmail.com',12345678,'direccion de estudiante civil 2',3181781580101,1);
-- INDUSTRIAL
CALL registrarEstudiante(202200001,'Estudiante de','Industrial Uno','1999-10-30','industrialuno@gmail.com',12345678,'direccion de estudiante industrial 1',3878168901,2);
CALL registrarEstudiante(202200002,'Estudiante de','Industrial Dos','1994-10-20','industrialdos@gmail.com',89765432,'direccion de estudiante industrial 2',29781580101,2);
-- ELECTRONICA
CALL registrarEstudiante(202300001, 'Estudiante de','Electronica Uno','2005-10-20','electronicauno@gmail.com',89765432,'direccion de estudiante electronica 1',29761580101,4);
CALL registrarEstudiante(202300002, 'Estudiante de','Electronica Dos', '2008-01-01','electronicados@gmail.com',12345678,'direccion de estudiante electronica 2',387916890101,4);
-- ESTUDIANTES RANDOM
CALL registrarEstudiante(201710160, 'ESTUDIANTE','SISTEMAS RANDOM','1994-08-20','estudiasist@gmail',89765432,'direccionestudisist random',29791580101,3);
CALL registrarEstudiante(201710161, 'ESTUDIANTE','CIVIL RANDOM','1995-08-20','estudiacivl@gmail',89765432,'direccionestudicivl random',30791580101,1);


-- AGREGAR CURSO
-- aqui se debe de agregar el AREA COMUN a carrera
-- Insertar el registro con id 0
INSERT INTO carrera(id_carrera, nombre_carrera) VALUES (0, 'Area Comun');
UPDATE carrera SET id_carrera = 0 WHERE id_carrera = LAST_INSERT_ID();

-- AREA COMUN
CALL crearCurso(0006,'Idioma Tecnico 1',0,7,0,false); 
CALL crearCurso(0007,'Idioma Tecnico 2',0,7,0,false);
CALL crearCurso(101,'MB 1',0,7,0,true); 
CALL crearCurso(103,'MB 2',0,7,0,true); 
CALL crearCurso(017,'SOCIAL HUMANISTICA 1',0,4,0,true); 
CALL crearCurso(019,'SOCIAL HUMANISTICA 2',0,4,0,true); 
CALL crearCurso(348,'QUIMICA GENERAL',0,3,0,true); 
CALL crearCurso(349,'QUIMICA GENERAL LABORATORIO',0,1,0,true);
-- INGENIERIA EN SISTEMAS
CALL crearCurso(777,'Compiladores 1',80,4,3,true); 
CALL crearCurso(770,'INTR. A la Programacion y computacion 1',0,4,3,true); 
CALL crearCurso(960,'MATE COMPUTO 1',33,5,3,true); 
CALL crearCurso(795,'lOGICA DE SISTEMAS',33,2,3,true);
CALL crearCurso(796,'LENGUAJES FORMALES Y DE PROGRAMACIÓN',0,3,3,TRUE);
-- INGENIERIA INDUSTRIAL
CALL crearCurso(123,'Curso Industrial 1',0,4,2,true); 
CALL crearCurso(124,'Curso Industrial 2',0,4,2,true);
CALL crearCurso(125,'Curso Industrial enseñar a pensar',10,2,2,false);
CALL crearCurso(126,'Curso Industrial ENSEÑAR A DIBUJAR',2,4,2,true);
CALL crearCurso(127,'Curso Industrial 3',8,4,2,true);
-- INGENIERIA CIVIL
CALL crearCurso(321,'Curso Civil 1',0,4,1,true);
CALL crearCurso(322,'Curso Civil 2',4,4,1,true);
CALL crearCurso(323,'Curso Civil 3',8,4,1,true);
CALL crearCurso(324,'Curso Civil 4',12,4,1,true);
CALL crearCurso(325,'Curso Civil 5',16,4,1,false);
CALL crearCurso(0250,'Mecanica de Fluidos',0,5,1,true);
-- INGENIERIA ELECTRONICA
CALL crearCurso(421,'Curso Electronica 1',0,4,4,true);
CALL crearCurso(422,'Curso Electronica 2',4,4,4,true);
CALL crearCurso(423,'Curso Electronica 3',8,4,4,false);
CALL crearCurso(424,'Curso Electronica 4',12,4,4,true);
CALL crearCurso(425,'Curso Electronica 5',16,4,4,true);

CALL habilitarCurso(777, '1S', 1, 150, 'B');
CALL habilitarCurso(770, '2S', 1, 110, 'A');
CALL habilitarCurso(960, '1S', 1, 150, 'B');
CALL habilitarCurso(795, '2S', 1, 110, 'A');
CALL habilitarCurso(796, '1S', 1, 150, 'B');

CALL agregarHorario(777, 4, '07:00-07:50');
CALL agregarHorario(770, 7, '08:00-08:50');
CALL agregarHorario(960, 4, '07:00-07:50');
CALL agregarHorario(795, 7, '08:00-08:50');
CALL agregarHorario(796, 4, '07:00-07:50');

CALL asignarCurso(777, '1S', 'B', 202000001);
CALL asignarCurso(777, '1S', 'B', 202000002);
CALL asignarCurso(777, '1S', 'B', 202000003);
CALL asignarCurso(960, '1S', 'B', 202000001);
CALL asignarCurso(960, '1S', 'B', 202000002);
CALL asignarCurso(795, '2S', 'A', 202000002);
CALL asignarCurso(796, '1S', 'B', 202000003);


CALL desasignarCurso(777, '1S', 'B', 202000002);
CALL desasignarCurso(1, '1S', 'B', 202300002);
CALL desasignarCurso(2, '2S', 'A', 202300001);

CALL ingresarNota(777, '1S', 'B', 202000001,  65);
CALL ingresarNota(777, '1S', 'B', 202000002,  25);
CALL ingresarNota(777, '1S', 'B', 202000003, 41);
CALL ingresarNota(960, '1S', 'B', 202000001, 74);

CALL generarActa(777, '1S', 'B');
CALL generarActa(960, '1S', 'B');

CALL consultarPensum(2);
CALL consultarEstudiante(202000001);
CALL consultarDocente(1);
CALL consultarAsignados(777,'1S', 2023, 'B');
CALL consultarAprobacion(777,'1S', 2023, 'B');
CALL consultarDesasignacion(777,'1S', 2023, 'B');
CALL consultarActas(777);


USE proyecto2_bases;
DROP TABLE IF EXISTS estudiante, docente, curso_habilitado, horario, asignacion, nota, acta, curso, carrera, transaccion;
DROP TABLE IF EXISTS carrera;

SHOW tables;
SELECT * FROM carrera;
SELECT * FROM curso;
SELECT * FROM estudiante;
SELECT * FROM docente;
SELECT * FROM curso_habilitado;
SELECT * FROM horario;
SELECT * FROM asignacion;
SELECT * FROM nota;
SELECT * FROM acta;
SELECT * FROM transaccion;
DELETE FROM carrera;
DELETE FROM curso;
DELETE FROM estudiante;
DELETE FROM docente;
DELETE FROM curso_habilitado;
DELETE FROM horario;
DELETE FROM asignacion;
DELETE FROM nota;
DELETE FROM acta;
