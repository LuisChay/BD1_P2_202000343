DELIMITER $$
CREATE TRIGGER insersionEstudiante
AFTER INSERT ON estudiante
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Estudiante', 'INSERT');
END$$


DELIMITER $$
CREATE TRIGGER actualizacionEstudiante
AFTER UPDATE ON estudiante
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Estudiante', 'UPDATE');
END$$

DELIMITER $$
CREATE TRIGGER eliminacionEstudiante
AFTER DELETE ON estudiante
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Estudiante', 'DELETE');
END$$

DELIMITER $$
CREATE TRIGGER insersionDocente
AFTER INSERT ON docente
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Docente', 'INSERT');
END$$

DELIMITER $$
CREATE TRIGGER actualizacionDocente
AFTER UPDATE ON docente
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Docente', 'UPDATE');
END$$

DELIMITER $$
CREATE TRIGGER eliminacionDocente
AFTER DELETE ON docente
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Docente', 'DELETE');
END$$

DELIMITER $$
CREATE TRIGGER insersionCurso
AFTER INSERT ON curso
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Curso', 'INSERT');
END$$

DELIMITER $$
CREATE TRIGGER actualizacionCurso
AFTER UPDATE ON curso
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Curso', 'UPDATE');
END$$

DELIMITER $$
CREATE TRIGGER eliminacionCurso
AFTER DELETE ON curso
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Curso', 'DELETE');
END$$

DELIMITER $$
CREATE TRIGGER insersionCursoHabilitado
AFTER INSERT ON curso_habilitado
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Curso_Habilitado', 'INSERT');
END$$

DELIMITER $$
CREATE TRIGGER actualizacionCursoHabilitado
AFTER UPDATE ON curso_habilitado
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Curso_Habilitado', 'UPDATE');
END$$

DELIMITER $$
CREATE TRIGGER eliminacionCursoHabilitado
AFTER DELETE ON curso_habilitado
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Curso_Habilitado', 'DELETE');
END$$

DELIMITER $$
CREATE TRIGGER insersionHorario
AFTER INSERT ON horario
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Horario', 'INSERT');
END$$

DELIMITER $$
CREATE TRIGGER actualizacionHorario
AFTER UPDATE ON horario
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Horario', 'UPDATE');
END$$

DELIMITER $$
CREATE TRIGGER eliminacionHorario
AFTER DELETE ON horario
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Horario', 'DELETE');
END$$

DELIMITER $$
CREATE TRIGGER insersionAsignacion
AFTER INSERT ON asignacion
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Asignacion', 'INSERT');
END$$

DELIMITER $$
CREATE TRIGGER actualizacionAsignacion
AFTER UPDATE ON asignacion
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Asignacion', 'UPDATE');
END$$

DELIMITER $$
CREATE TRIGGER eliminacionAsignacion
AFTER DELETE ON asignacion
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Asignacion', 'DELETE');
END$$

DELIMITER $$
CREATE TRIGGER insersionNota
AFTER INSERT ON nota
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Nota', 'INSERT');
END$$

DELIMITER $$
CREATE TRIGGER actualizacionNota
AFTER UPDATE ON nota
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Nota', 'UPDATE');
END$$

DELIMITER $$
CREATE TRIGGER eliminacionNota
AFTER DELETE ON nota
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Nota', 'DELETE');
END$$

DELIMITER $$
CREATE TRIGGER insersionActa
AFTER INSERT ON acta
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Acta', 'INSERT');
END$$

DELIMITER $$
CREATE TRIGGER actualizacionActa
AFTER UPDATE ON acta
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Acta', 'UPDATE');
END$$

DELIMITER $$
CREATE TRIGGER eliminacionActa
AFTER DELETE ON acta
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Acta', 'DELETE');
END$$

DELIMITER $$
CREATE TRIGGER insersionCarrera
AFTER INSERT ON carrera
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Carrera', 'INSERT');
END$$

DELIMITER $$
CREATE TRIGGER actualizacionCarrera
AFTER UPDATE ON carrera
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Carrera', 'UPDATE');
END$$

DELIMITER $$
CREATE TRIGGER eliminacionCarrera
AFTER DELETE ON carrera
FOR EACH ROW
BEGIN
    INSERT INTO transaccion (fecha, descripcion, tipo)
    VALUES (NOW(), 'Se ha realizado una accion en la tabla Carrera', 'DELETE');
END$$