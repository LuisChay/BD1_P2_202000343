--Creacion base de datos
CREATE DATABASE IF NOT EXISTS proyecto2_bases;
USE proyecto2_bases;

--Creacion de tablas del modelo

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
    ciclo VARCHAR(10) NOT NULL,
    seccion CHAR NOT NULL,
    carnet_estudiante BIGINT NOT NULL,
    FOREIGN KEY (carnet_estudiante) REFERENCES estudiante(carnet),
    estado BOOLEAN NOT NULL
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

--Insercion de datos en las tablas

INSERT INTO carrera(id_carrera, nombre_carrera) VALUES (0, 'Area Comun');
UPDATE carrera SET id_carrera = 0 WHERE id_carrera = 1;
ALTER TABLE carrera AUTO_INCREMENT = 1;

CALL crearCarrera('Ingenieria en Ciencias y Sistemas');
CALL crearCarrera('Ingenieria Industrial');
CALL crearCarrera('Ingenieria Quimica'); 
CALL crearCarrera('Ingenieria Civil');

CALL registrarDocente('Juan Alberto', 'Perez Mendez', '1976-05-08', 'juanperez@gmail.com', 12345678, 'Guatemala', 4829163729457, 65432109);
CALL registrarDocente('Maria Jose', 'Gonzalez Perez', '1980-05-08', 'mariagonzales@gmail.com', 12345678, 'Mixco', 7891034568210, 12345678);
CALL registrarDocente('Pedro Manuel', 'Ortiz Fuentes', '1992-09-10', 'pedrofuentes@gmail.com', 12345678, 'Villa Nueva', 5642378901234, 87654321);
CALL registrarDocente('Ana Luisa', 'Garcia Marroquin', '1985-07-08', 'anagarcia@gmail.com', 12345678, 'San Juan Sacatepequez', 9783456210145, 23456789);
CALL registrarDocente('Jorge Mario', 'Diaz Vasquez', '1972-01-02', 'jorgediaz@gmail.com', 12345678, 'San Miguel Petapa', 1234567890123, 98765432);

CALL registrarEstudiante(202300001, 'Juan Miguel', 'Pérez Perez', '1998-05-15', 'juanperez@email.com', 48759614, '123 Main St', 1234567890123, 1);
CALL registrarEstudiante(202300002, 'Maria Anotieta', 'González Lopez', '1999-03-20', 'mariagonzalez@email.com', 5559876543, '456 Elm St', 987654321012, 1);
CALL registrarEstudiante(202300003, 'Pedro Ivan', 'López Fuentes', '2000-07-10', 'pedrolopez@email.com', 5555551234, '789 Oak St', 4567890123456, 3);
CALL registrarEstudiante(202300004, 'Ana Sofia', 'Martínez Ortiz', '1997-11-28', 'anamartinez@email.com', 5552345678, '567 Pine St', 7890123456789, 4);
CALL registrarEstudiante(202300005, 'Luis Arturo', 'Sánchez Mendez', '1996-02-05', 'luissanchez@email.com', 5558765432, '234 Cedar St', 8901234567890, 1);
CALL registrarEstudiante(202300006, 'Dulce Maria', 'Ramírez Sontay', '1998-09-12', 'sofiaramirez@email.com', 555765321, '345 Birch St', 9012345678901, 2);
CALL registrarEstudiante(202300007, 'Carlos Jose', 'Torres Rios', '1999-04-30', 'carlostorres@email.com', 5551112222, '678 Walnut St', 2345678901234, 3);
CALL registrarEstudiante(202300008, 'Laura Samanta', 'Gómez Baez', '2001-01-03', 'lauragomez@email.com', 5552223333, '456 Maple St', 1234567890123, 3);
CALL registrarEstudiante(202300009, 'Javier Roberto', 'Rodríguez Palacios', '1997-06-18', 'javierrodriguez@email.com', 5553334444, '567 Oak St', 9876543210123, 4);
CALL registrarEstudiante(202300111, 'Maria Isabel', 'Díaz Reyes', '1995-08-22', 'isabeldiaz@email.com', 5554445555, '789 Pine St', 4567890123456, 1);

CALL crearCurso(1, 'Matematica Basica', 0, 7, 0, 1);
CALL crearCurso(2, 'Fisica', 0, 5, 0, 1);
CALL crearCurso(3, 'Social Humanistica', 0, 4, 0, 1);
CALL crearCurso(4, 'Deportes', 0, 1, 0, 1);
CALL crearCurso(5, 'Tecnica Complementaria', 0, 3, 0, 1);

CALL crearCurso(111, 'Mate Computo', 5, 7, 1, 1);
CALL crearCurso(112, 'Logica de Sistemas', 2, 5, 1, 0);
CALL crearCurso(113, 'IPC', 5, 4, 1, 0);
CALL crearCurso(114, 'Inteligencia Artificial', 5, 1, 1, 1);
CALL crearCurso(115, 'Compiladores', 2, 3, 1, 0);

CALL crearCurso(121, 'Contabilidad', 5, 7, 2, 0);
CALL crearCurso(122, 'Mecanica de Fluidos', 2, 5, 2, 1);
CALL crearCurso(123, 'Resistencia de Materiales', 5, 4, 2, 1);
CALL crearCurso(124, 'Mercadotecnia', 5, 1, 2, 0);
CALL crearCurso(125, 'Ingenieria de Plantas', 2, 3, 2, 0);

CALL crearCurso(131, 'Quimica Organica', 5, 7, 3, 0);
CALL crearCurso(132, 'Balance de Masa y Energia', 2, 5, 3, 1);
CALL crearCurso(133, 'Fisico Quimica', 5, 4, 3, 0);
CALL crearCurso(134, 'Flujo de Fluidos', 5, 1, 3, 1);
CALL crearCurso(135, 'Transferencia de Calor', 2, 3, 3, 1);

CALL crearCurso(151, 'Topografia', 5, 7, 4, 1);
CALL crearCurso(152, 'GeoFisica', 2, 5, 4, 1);
CALL crearCurso(153, 'Hidraulica', 5, 4, 4, 0);
CALL crearCurso(154, 'Analisis Estructural', 5, 1, 4, 0);
CALL crearCurso(155, 'Concreto Armado', 2, 3, 4, 0);


-- Debug
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
