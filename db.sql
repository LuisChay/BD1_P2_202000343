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
    id_carrera INT NOT NULL,
    FOREIGN KEY (id_carrera) REFERENCES carrera(id_carrera),
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
    codigo_curso INT NOT NULL,
    FOREIGN KEY (codigo_curso) REFERENCES curso(codigo_curso),
    ciclo VARCHAR(2) NOT NULL,
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
    FOREIGN KEY (codigo_curso) REFERENCES curso_habilitado(id_habilitado),
    dia int NOT NULL,
    horario VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS asignacion (
    codigo_curso INT NOT NULL,
    FOREIGN KEY (codigo_curso) REFERENCES curso(codigo_curso),
    ciclo VARCHAR(2) NOT NULL,
    seccion CHAR NOT NULL,
    carnet_estudiante BIGINT NOT NULL,
    FOREIGN KEY (carnet_estudiante) REFERENCES estudiante(carnet)
);

CREATE TABLE IF NOT EXISTS nota (
    codigo_curso INT NOT NULL,
    FOREIGN KEY (codigo_curso) REFERENCES curso_habilitado(id_habilitado),
    ciclo VARCHAR(2) NOT NULL,
    seccion CHAR NOT NULL,
    carnet_estudiante BIGINT NOT NULL,
    FOREIGN KEY (carnet_estudiante) REFERENCES estudiante(carnet),
    nota INT NOT NULL,
    anio INT NOT NULL
);

CREATE TABLE IF NOT EXISTS acta (
    codigo_curso INT NOT NULL,
    FOREIGN KEY (codigo_curso) REFERENCES curso_habilitado(id_habilitado),
    ciclo VARCHAR(2) NOT NULL,
    seccion CHAR NOT NULL,
    fecha_creacion DATETIME NOT NULL
);




USE proyecto2_bases;
DROP TABLE IF EXISTS estudiante, docente, curso_habilitado, horario, asignacion, nota, acta, curso, carrera, transaccion;
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
