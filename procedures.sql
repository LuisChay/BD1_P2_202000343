DELIMITER $$
CREATE PROCEDURE registrarEstudiante(IN carnet BIGINT, IN nombres VARCHAR(100), IN apellidos VARCHAR(100), IN fecha_nacimiento DATE, IN correo VARCHAR(100), IN telefono BIGINT, IN direccion VARCHAR(100), IN dpi BIGINT, IN id_carrera INT)
BEGIN
    IF NOT soloNumeros(carnet) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El carnet debe contener solo numeros';
    END IF;
    IF EXISTS (SELECT * FROM estudiante WHERE carnet = carnet) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El estudiante ya existe';
        END IF;
    IF NOT soloLetras(nombres) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre debe contener solo letras';
    END IF;
    IF NOT soloLetras(apellidos) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El apellido debe contener solo letras';
    END IF;
    IF NOT validarEmail(correo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo no es valido';
    END IF;
    IF NOT soloNumeros(telefono) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El telefono debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(dpi) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El dpi debe contener solo numeros';
    END IF;
    IF NOT EXISTS (SELECT * FROM carrera WHERE id_carrera = id_carrera) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La carrera no existe';
    END IF;
    INSERT INTO estudiante (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, fecha_creacion, creditos, id_carrera)
    VALUES (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, CURDATE(), 0, id_carrera);
END $$

DELIMITER $$
CREATE PROCEDURE crearCarrera(IN nombre_carrera VARCHAR(100))
BEGIN 
    IF NOT soloLetras(nombre_carrera) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre de la carrera debe contener solo letras';
    END IF;
    INSERT INTO carrera (nombre_carrera)
    VALUES (nombre_carrera);
END $$

DELIMITER $$
CREATE PROCEDURE registrarDocente(IN nombres VARCHAR(100), IN apellidos VARCHAR(100), IN fecha_nacimiento DATE, IN correo VARCHAR(100), IN telefono BIGINT, IN direccion VARCHAR(100), IN dpi BIGINT, IN siif BIGINT)
BEGIN 
    IF NOT soloLetras(nombres) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre debe contener solo letras';
    END IF;
    IF NOT soloLetras(apellidos) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El apellido debe contener solo letras';
    END IF;
    IF NOT validarEmail(correo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo no es valido';
    END IF;
    IF NOT soloNumeros(telefono) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El telefono debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(dpi) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El dpi debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(siif) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El siif debe contener solo numeros';
    END IF;
    IF EXISTS (SELECT * FROM docente WHERE siif = siif) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El docente ya existe';
    END IF;
    INSERT INTO docente (nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, siif, fecha_creacion)
    VALUES (nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, siif, CURDATE());
END $$

DELIMITER $$
CREATE PROCEDURE crearCurso(IN codigo_curso INT, IN nombre_curso VARCHAR(100), IN creditos_necesarios INT, IN creditos_otorgados INT, IN carrera_perteneciente INT, IN obligatorio BOOLEAN)
BEGIN 
    IF NOT soloNumeros(codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El codigo del curso debe contener solo numeros';
    END IF;
    IF NOT soloLetras(nombre_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del curso debe contener solo letras';
    END IF;
    IF NOT soloNumeros(creditos_necesarios) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Los creditos necesarios deben contener solo numeros';
    END IF;
    IF NOT soloNumeros(creditos_otorgados) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Los creditos otorgados deben contener solo numeros';
    END IF;
    IF NOT soloNumeros(carrera_perteneciente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La carrera perteneciente debe contener solo numeros';
    END IF;
    IF NOT EXISTS (SELECT * FROM carrera WHERE id_carrera = carrera_perteneciente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La carrera no existe';
    END IF;
    INSERT INTO curso(codigo_curso, nombre_curso, creditos_necesarios, creditos_otorgados, carrera_perteneciente, obligatorio)
    VALUES (codigo_curso, nombre_curso, creditos_necesarios, creditos_otorgados, carrera_perteneciente, obligatorio);

END $$

DELIMITER $$
CREATE PROCEDURE habilitarCurso(IN codigo_curso INT, IN ciclo VARCHAR(2), IN docente BIGINT, IN cupo_maximo INT, IN seccion CHAR)
BEGIN 
    IF NOT soloNumeros(codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El codigo del curso debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(docente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El docente debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(cupo_maximo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El cupo maximo debe contener solo numeros';
    END IF;
    IF NOT verificarSeccion(seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La seccion debe contener solo una letra mayuscula';
    END IF;
    IF NOT validarCiclo(ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El ciclo no es valido';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso WHERE codigo_curso = codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no existe';
    END IF;
    IF NOT EXISTS (SELECT * FROM docente WHERE siif = docente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El docente no existe';
    END IF;
    INSERT INTO curso_habilitado(codigo_curso, ciclo, docente, cupo_maximo, seccion, anio, canitdad_estudiantes)
    VALUES (codigo_curso, ciclo, docente, cupo_maximo, seccion, YEAR(CURDATE()), 0);
END $$


DELIMITER $$
CREATE PROCEDURE agregarHorario(IN codigo_curso INT, IN dia INT, IN horario VARCHAR(100))
BEGIN 
    IF NOT soloNumeros(codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El codigo del curso debe contener solo numeros';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no existe';
    END IF;
    IF NOT verificarDiaHorario(dia) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El dia no es valido';
    END IF;

    INSERT INTO horario(codigo_curso, dia, horario)
    VALUES (codigo_curso, dia, horario);
END $$

DELIMITER $$
CREATE PROCEDURE asignarCurso(IN codigo_curso INT, IN ciclo VARCHAR(2),IN seccion CHAR, IN carnet BIGINT)
BEGIN 
    IF NOT soloNumeros(codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El codigo del curso debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(carnet) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El carnet debe contener solo numeros';
    END IF;
    IF NOT validarCiclo(ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El ciclo no es valido';
    END IF;
    IF NOT verificarSeccion(seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La seccion debe contener solo una letra mayuscula';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no existe';
    END IF;
    IF NOT EXISTS (SELECT * FROM estudiante WHERE carnet = carnet) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El estudiante no existe';
    END IF;
    IF EXISTS (SELECT * FROM asignacion WHERE carnet = carnet AND codigo_curso = codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El estudiante ya esta asignado a este curso';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso AND ciclo = ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no esta habilitado en este ciclo';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso AND ciclo = ciclo AND canitdad_estudiantes < cupo_maximo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso ya no tiene cupo';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso AND ciclo = ciclo AND seccion = seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no tiene esta seccion';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso AND ciclo = ciclo AND anio = YEAR(CURDATE())) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no esta habilitado en este año';
    END IF;

    INSERT INTO asignacion(codigo_curso, ciclo, seccion, carnet_estudiante)
    VALUES (codigo_curso, ciclo, seccion, carnet);
END $$


DELIMITER $$
CREATE PROCEDURE desasignarCurso(IN codigo_curso INT, IN ciclo VARCHAR(2),IN seccion CHAR , IN carnet BIGINT)
BEGIN 
    IF NOT soloNumeros(codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El codigo del curso debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(carnet) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El carnet debe contener solo numeros';
    END IF;
    IF NOT validarCiclo(ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El ciclo no es valido';
    END IF;
    IF NOT verificarSeccion(seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La seccion debe contener solo una letra mayuscula';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no existe';
    END IF;
    IF NOT EXISTS (SELECT * FROM estudiante WHERE carnet = carnet) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El estudiante no existe';
    END IF;
    IF EXISTS (SELECT * FROM asignacion WHERE carnet = carnet AND codigo_curso = codigo_curso) THEN
        SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'Estudiante desasignado correctamente';
        DELETE FROM asignacion WHERE codigo_curso = codigo_curso AND ciclo = ciclo AND seccion = seccion AND carnet_estudiante = carnet;
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso AND ciclo = ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no esta habilitado en este ciclo';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso AND ciclo = ciclo AND seccion = seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no tiene esta seccion';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso AND ciclo = ciclo AND anio = YEAR(CURDATE())) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no esta habilitado en este año';
    END IF;
END $$
    

DELIMITER $$
CREATE PROCEDURE ingresarNota(IN codigo_curso INT, IN ciclo VARCHAR(2), IN seccion CHAR, IN carnet BIGINT, IN nota INT)
BEGIN 
    IF NOT soloNumeros(codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El codigo del curso debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(carnet) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El carnet debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(nota) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La nota debe contener solo numeros';
    END IF;
    IF NOT validarCiclo(ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El ciclo no es valido';
    END IF;
    IF NOT verificarSeccion(seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La seccion debe contener solo una letra mayuscula';
    END IF;

    IF nota >= 61 THEN
        UPDATE estudiante AS e
        SET e.creditos = e.creditos + (
            SELECT c.creditos_otorgados
            FROM curso AS c
            WHERE c.codigo_curso = codigo_curso
        )
        WHERE e.carnet = carnet;
    END IF;

    INSERT INTO nota(codigo_curso, ciclo, seccion, carnet_estudiante, ROUND(nota), anio)
    VALUES (codigo_curso, ciclo, seccion, carnet, nota, YEAR(CURDATE()));

END $$

DELIMITER $$
CREATE PROCEDURE crearActa(IN codigo_curso INT, IN ciclo VARCHAR(2), IN seccion CHAR)
BEGIN 
    IF NOT soloNumeros(codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El codigo del curso debe contener solo numeros';
    END IF;
    IF NOT validarCiclo(ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El ciclo no es valido';
    END IF;
    IF NOT verificarSeccion(seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La seccion debe contener solo una letra mayuscula';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no existe';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso AND ciclo = ciclo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no esta habilitado en este ciclo';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso AND ciclo = ciclo AND seccion = seccion) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no tiene esta seccion';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso = codigo_curso AND ciclo = ciclo AND anio = YEAR(CURDATE())) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no esta habilitado en este año';
    END IF;

    INSERT INTO acta(codigo_curso, ciclo, seccion, fecha_creacion)
    VALUES (codigo_curso, ciclo, seccion, NOW());
END $$