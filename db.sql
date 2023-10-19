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

-- Insercion de datos a tablas del modelo.
INSERT INTO carrera (id_carrera, nombre_carrera) VALUES (1, 'Ingenieria en Ciencias y Sistemas');
INSERT INTO carrera (id_carrera, nombre_carrera) VALUES (2, 'Ingenieria Industrial');
INSERT INTO carrera (id_carrera, nombre_carrera) VALUES (3, 'Ingenieria Mecanica');
INSERT INTO carrera (id_carrera, nombre_carrera) VALUES (4, 'Ingenieria Quimica');

INSERT INTO docente (nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, siif, fecha_creacion) VALUES ('Juan Alberto', 'Perez Mendez', '1976-05-08', 'juanperez@gmail.com', 12345678, 'Guatemala', 4829163729457, 65432109, CURDATE());
INSERT INTO docente (nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, siif, fecha_creacion)  VALUES ('Maria Jose', 'Gonzalez Perez', '1980-05-08', 'mariagonzales@gmail.com', 12345678, 'Mixco', 7891034568210, 12345678, CURDATE());
INSERT INTO docente (nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, siif, fecha_creacion)  VALUES ('Pedro Manuel', 'Ortiz Fuentes', '1992-09-10', 'pedrofuentes@gmail.com', 12345678, 'Villa Nueva', 5642378901234, 87654321, CURDATE());
INSERT INTO docente (nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, siif, fecha_creacion)  VALUES ('Ana Luisa', 'Garcia Marroquin', '1985-07-08', 'anagarcia@gmail.com', 12345678, 'San Juan Sacatepequez', 9783456210145, 23456789, CURDATE()); 
INSERT INTO docente (nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, siif, fecha_creacion)  VALUES ('Jorge Mario', 'Diaz Vasquez', '1972-01-02', 'jorgediaz@gmail.com', 12345678, 'San Miguel Petapa', 1234567890123, 98765432, CURDATE());

INSERT INTO estudiante (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera, creditos, fecha_de_creacion) VALUES ('202300001', 'Juan Miguel', 'Pérez Perez', '1998-05-15', 'juanperez@email.com', '555-123-4567', '123 Main St', 1234567890123, 1, 90, CURDATE());
INSERT INTO estudiante (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera, creditos, fecha_de_creacion) VALUES ('202300002', 'Maria Anotieta', 'González Lopez', '1999-03-20', 'mariagonzalez@email.com', '555-987-6543', '456 Elm St', 987654321012, 2, 75, CURDATE());
INSERT INTO estudiante (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera, creditos, fecha_de_creacion) VALUES ('202300003', 'Pedro Ivan', 'López Fuentes', '2000-07-10', 'pedrolopez@email.com', '555-555-1234', '789 Oak St', 4567890123456, 3, 110, CURDATE());
INSERT INTO estudiante (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera, creditos, fecha_de_creacion) VALUES ('202300004', 'Ana Sofia', 'Martínez Ortiz', '1997-11-28', 'anamartinez@email.com', '555-234-5678', '567 Pine St', 7890123456789, 4, 80, CURDATE());
INSERT INTO estudiante (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera, creditos, fecha_de_creacion) VALUES ('202300005', 'Luis Arturo', 'Sánchez Mendez', '1996-02-05', 'luissanchez@email.com', '555-876-5432', '234 Cedar St', 8901234567890, 1, 95, CURDATE());
INSERT INTO estudiante (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera, creditos, fecha_de_creacion) VALUES ('202300006', 'Dulce Maria', 'Ramírez Sontay', '1998-09-12', 'sofiaramirez@email.com', '555-765-4321', '345 Birch St', 9012345678901, 2, 70, CURDATE());
INSERT INTO estudiante (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera, creditos, fecha_de_creacion) VALUES ('202300007', 'Carlos Jose', 'Torres Rios', '1999-04-30', 'carlostorres@email.com', '555-111-2222', '678 Walnut St', 2345678901234, 3, 60, CURDATE());
INSERT INTO estudiante (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera, creditos, fecha_de_creacion) VALUES ('202300008', 'Laura Samanta', 'Gómez Baez', '2001-01-03', 'lauragomez@email.com', '555-222-3333', '456 Maple St', 1234567890123, 3, 120, CURDATE());
INSERT INTO estudiante (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera, creditos, fecha_de_creacion) VALUES ('202300009', 'Javier Roberto', 'Rodríguez Palacios', '1997-06-18', 'javierrodriguez@email.com', '555-333-4444', '567 Oak St', 9876543210123, 4, 85, CURDATE());
INSERT INTO estudiante (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, id_carrera, creditos, fecha_de_creacion) VALUES ('202300111', 'Maria Isabel', 'Díaz Reyes', '1995-08-22', 'isabeldiaz@email.com', '555-444-5555', '789 Pine St', 4567890123456, 1, 100, CURDATE());




--Eliminar tablas
DROP TABLE IF EXISTS estudiante, docente, curso_habilitado, horario, asignacion, nota, acta, curso, carrera;

DELETE FROM carrera;
DELETE FROM curso;
DELETE FROM estudiante;
DELETE FROM docente;
DELETE FROM curso_habilitado;
DELETE FROM horario;
DELETE FROM asignacion;
DELETE FROM nota;
DELETE FROM acta;




