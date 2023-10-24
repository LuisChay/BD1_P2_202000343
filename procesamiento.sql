DELIMITER $$
CREATE PROCEDURE consultarPensum(IN curso_id INT)
BEGIN
    SELECT
        codigo_curso,
        nombre_curso,
        CASE
            WHEN obligatorio = 1 THEN 'Si'
            ELSE 'No'
        END AS obligatorio,
        creditos_necesarios
    FROM
        curso
    WHERE
        carrera_perteneciente = curso_id;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE consultarEstudiante(IN carnete BIGINT)
BEGIN
    SELECT
        e.carnet,
        CONCAT(e.nombres, ' ', e.apellidos) AS nombre_completo,
        e.fecha_nacimiento,
        e.correo,
        e.telefono,
        e.direccion,
        e.dpi,
        c.nombre_carrera AS carrera,
        e.creditos
    FROM
        estudiante e
    JOIN
        carrera c ON e.id_carrera_estudiante = c.id_carrera
    WHERE
        e.carnet = carnete;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE consultarDocente(IN siife BIGINT)
BEGIN
    SELECT
        siif,
        CONCAT(nombres, ' ', apellidos) AS nombre_completo,
        fecha_nacimiento,
        correo,
        telefono,
        direccion,
        dpi
    FROM
        docente
    WHERE
        siif = siife;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE consultarAsignados(IN codigo_cursoe INT, IN cicloe VARCHAR(2), IN anioe INT, IN seccionea CHAR)
BEGIN
    SELECT
        e.carnet,
        CONCAT(e.nombres, ' ', e.apellidos) AS nombre_completo,
        e.creditos
    FROM
        estudiante e
    JOIN
        asignacion a ON e.carnet = a.carnet_estudiante
    JOIN 
        curso_habilitado ch ON a.codigo_curso = ch.codigo_curso_habilitado    
    WHERE
        a.codigo_curso = codigo_cursoe
        AND ch.ciclo = cicloe
        AND ch.anio = anioe
        AND ch.seccion = seccionea ;
END $$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE consultarAprobacion(IN codigo_cursoe INT, IN cicloe VARCHAR(2), IN anioe INT, IN seccionea CHAR)
BEGIN
    SELECT
        ch.codigo_curso_habilitado AS codigo_curso,
        e.carnet,
        CONCAT(e.nombres, ' ', e.apellidos) AS nombre_completo,
        IF(n.nota >= 61, 'APROBADO', 'REPROBADO') AS aprobado
    FROM
        nota n
    INNER JOIN
        asignacion a ON n.codigo_curso = a.codigo_curso
    INNER JOIN 
        curso_habilitado ch ON a.codigo_curso = ch.codigo_curso_habilitado
	INNER JOIN 
		estudiante e ON a.carnet_estudiante = e.carnet 
    WHERE
        ch.codigo_curso_habilitado = codigo_cursoe
        AND ch.ciclo = cicloe
        AND ch.anio = anioe
        AND ch.seccion = seccionea;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE consultarActas(IN codigo_cursoe BIGINT)
BEGIN
    SELECT
        ch.codigo_curso_habilitado AS codigo_curso,
        ch.seccion,
        CASE
            WHEN ch.ciclo = '1S' THEN 'PRIMER SEMESTRE'
            WHEN ch.ciclo = '2S' THEN 'SEGUNDO SEMESTRE'
            WHEN ch.ciclo = 'VD' THEN 'VACACIONES DE DICIEMBRE'
            WHEN ch.ciclo = 'VJ' THEN 'VACACIONES DE JULIO'
            ELSE 'NO REGISTRADO'
        END AS ciclo,
        ch.anio AS anio,
        ch.canitdad_estudiantes AS cantidad_estudiantes,
        ac.fecha_creacion
    FROM
        curso_habilitado ch
    JOIN
        acta ac ON ac.codigo_curso = ch.codigo_curso_habilitado
    WHERE
        ac.codigo_curso = codigo_cursoe;
END $$

DELIMITER $$
CREATE PROCEDURE consultarDesasignacion(IN codigo_cursoe INT, IN cicloe VARCHAR(2), IN anioe INT, IN seccionea CHAR)
BEGIN
    SELECT
        ch.codigo_curso_habilitado AS codigo_curso,
        ch.seccion,
        CASE
            WHEN ch.ciclo = '1S' THEN 'PRIMER SEMESTRE'
            WHEN ch.ciclo = '2S' THEN 'SEGUNDO SEMESTRE'
            WHEN ch.ciclo = 'VD' THEN 'VACACIONES DE DICIEMBRE'
            WHEN ch.ciclo = 'VJ' THEN 'VACACIONES DE JULIO'
            ELSE 'NO REGISTRADO'
        END AS ciclo,
        ch.anio AS anio,
        ch.canitdad_estudiantes AS cantidad_estudiantes,
        SUM(a.estado = 0) AS cantidad_desasignados,
        SUM(a.estado = 0) / COUNT(*) * 100 AS porcentaje_desasignados
    FROM
        estudiante e
    JOIN
        asignacion a ON e.carnet = a.carnet_estudiante
    JOIN 
        curso_habilitado ch ON a.codigo_curso = ch.codigo_curso_habilitado    
    JOIN
        acta ac ON a.codigo_curso = ac.codigo_curso
    WHERE
        ch.codigo_curso_habilitado = codigo_cursoe
        AND ch.ciclo = cicloe
        AND ch.anio = anioe
        AND ch.seccion = seccionea 
	GROUP BY	
		a.estado;
END $$
