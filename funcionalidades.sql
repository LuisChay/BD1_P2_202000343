DELIMITER $$
CREATE PROCEDURE registrarEstudiante(IN carnete BIGINT, IN nombrese VARCHAR(100), IN apellidose VARCHAR(100), IN fecha_nacimientoe DATE, IN correoe VARCHAR(100), IN telefonoe BIGINT, IN direccione VARCHAR(100), IN dpie BIGINT, IN id_carreraent INT)
BEGIN
    IF NOT soloNumeros(carnete) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El carnet debe contener solo numeros';
    END IF;
    IF EXISTS (SELECT * FROM estudiante WHERE carnet = carnete) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El estudiante ya existe';
	END IF;
    IF NOT soloLetras(nombrese) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre debe contener solo letras';
    END IF;
    IF NOT soloLetras(apellidose) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El apellido debe contener solo letras';
    END IF;
    IF NOT validarEmail(correoe) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo no es valido';
    END IF;
    IF NOT soloNumeros(telefonoe) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El telefono debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(dpie) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El dpi debe contener solo numeros';
    END IF;
    IF NOT EXISTS (SELECT * FROM carrera WHERE id_carrera = id_carreraent) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La carrera no existe';
    END IF;
    INSERT INTO estudiante (carnet, nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, fecha_creacion, creditos, id_carrera_estudiante)
    VALUES (carnete, nombrese, apellidose, fecha_nacimientoe, correoe, telefonoe, direccione, dpie, CURDATE(), 0, id_carreraent);
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
CREATE PROCEDURE registrarDocente(IN nombrese VARCHAR(100), IN apellidose VARCHAR(100), IN fecha_nacimientoe DATE, IN correoe VARCHAR(100), IN telefonoe BIGINT, IN direccione VARCHAR(100), IN dpie BIGINT, IN siife BIGINT)
BEGIN 
    IF NOT soloLetras(nombrese) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre debe contener solo letras';
    END IF;
    IF NOT soloLetras(apellidose) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El apellido debe contener solo letras';
    END IF;
    IF NOT validarEmail(correoe) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo no es valido';
    END IF;
    IF NOT soloNumeros(telefonoe) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El telefono debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(dpie) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El dpi debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(siife) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El siif debe contener solo numeros';
    END IF;
    IF EXISTS (SELECT * FROM docente WHERE siif = siife) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El docente ya existe';
    END IF;
    INSERT INTO docente (nombres, apellidos, fecha_nacimiento, correo, telefono, direccion, dpi, siif, fecha_creacion)
    VALUES (nombrese, apellidose, fecha_nacimientoe, correoe, telefonoe, direccione, dpie, siife, CURDATE());
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
CREATE PROCEDURE habilitarCurso(IN codigo_cursoe INT, IN ciclo VARCHAR(2), IN docente BIGINT, IN cupo_maximo INT, IN seccion CHAR)
BEGIN 
    IF NOT soloNumeros(codigo_cursoe) THEN
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
    IF NOT EXISTS (SELECT * FROM curso WHERE codigo_curso = codigo_cursoe) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no existe';
    END IF;
    IF NOT EXISTS (SELECT * FROM docente WHERE siif = docente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El docente no existe';
    END IF;
    INSERT INTO curso_habilitado(codigo_curso_habilitado, ciclo, docente, cupo_maximo, seccion, anio, canitdad_estudiantes)
    VALUES (codigo_cursoe, ciclo, docente, cupo_maximo, seccion, YEAR(CURDATE()), 0);
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

    UPDATE curso_habilitado AS ch
    SET ch.canitdad_estudiantes = ch.canitdad_estudiantes + 1
    WHERE ch.codigo_curso_habilitado = codigo_curso AND ch.ciclo = ciclo;

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
CREATE PROCEDURE ingresarNota(IN codigo_cursoe INT, IN cicloe VARCHAR(2), IN seccione CHAR, IN carnete BIGINT, IN notae INT)
BEGIN 
    IF NOT soloNumeros(codigo_cursoe) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El codigo del curso debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(carnete) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El carnet debe contener solo numeros';
    END IF;
    IF NOT soloNumeros(notae) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La nota debe contener solo numeros';
    END IF;
    IF NOT validarCiclo(cicloe) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El ciclo no es valido';
    END IF;
    IF NOT verificarSeccion(seccione) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La seccion debe contener solo una letra mayuscula';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso_habilitado = codigo_cursoe) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no existe';
    END IF;
    IF NOT EXISTS (SELECT * FROM estudiante WHERE carnet = carnete) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El estudiante no existe';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso_habilitado = codigo_cursoe AND ciclo = cicloe) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no esta habilitado en este ciclo';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso_habilitado = codigo_cursoe AND ciclo = cicloe AND seccion = seccione) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no tiene esta seccion';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso_habilitado = codigo_cursoe AND ciclo = cicloe AND anio = YEAR(CURDATE())) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no esta habilitado en este año';
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

    INSERT INTO nota(codigo_curso, ciclo, seccion, carnet_estudiante,nota, anio)
    VALUES (codigo_curso, cicloe, seccione, carnete, ROUND(notae), YEAR(CURDATE()));
END $$

DELIMITER $$
CREATE PROCEDURE generarActa(IN codigo_cursoe INT, IN cicloe VARCHAR(2), IN seccione CHAR)
BEGIN 
    IF NOT soloNumeros(codigo_cursoe) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El codigo del curso debe contener solo numeros';
    END IF;
    IF NOT validarCiclo(cicloe) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El ciclo no es valido';
    END IF;
    IF NOT verificarSeccion(seccioen) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La seccion debe contener solo una letra mayuscula';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso_habilitado = codigo_cursoe) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no existe';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso_habilitado = codigo_cursoe AND ciclo = cicloe) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no esta habilitado en este ciclo';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso_habilitado = codigo_curso AND ciclo = cicloe AND seccion = seccione) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no tiene esta seccion';
    END IF;
    IF NOT EXISTS (SELECT * FROM curso_habilitado WHERE codigo_curso_habilitado = codigo_curso AND ciclo = cicloe AND anio = YEAR(CURDATE())) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El curso no esta habilitado en este año';
    END IF;

    INSERT INTO acta(codigo_curso, ciclo, seccion, fecha_creacion)
    VALUES (codigo_cursoe, cicloe, seccione, NOW());
END $$