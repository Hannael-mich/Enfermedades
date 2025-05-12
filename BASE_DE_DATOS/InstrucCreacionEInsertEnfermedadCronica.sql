-- Database: prueba_sye

-- DROP DATABASE IF EXISTS prueba_sye;

CREATE DATABASE prueba_sye
    WITH
    OWNER = fer
    ENCODING = 'UTF8'
    LC_COLLATE = 'es_ES.UTF-8'
    LC_CTYPE = 'es_ES.UTF-8'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

create schema schemasye;

create table if not exists schemasye.tc_enfermedad_cronica
(
    id_enf_cronica serial,
    nombre varchar(255) not null,
    descripcion varchar(255) default '' not null,
    fecha_registro date default current_date,
    fecha_inicio date default current_date,
    estado boolean not null default true,
    fecha_actualizacion date default null,
    primary key (id_enf_cronica)
);

INSERT INTO schemasye.tc_enfermedad_cronica (nombre, descripcion, fecha_registro, fecha_inicio, estado, fecha_actualizacion) VALUES
('Hipertensión', 'Diagnóstico de hipertensión.', '2025-04-24', '2008-11-20', false, '2015-12-08'),
('Diabetes Tipo 2', 'Diagnóstico de diabetes tipo 2.', '2025-04-24', '2008-11-21', true, NULL),
('Asma', 'Diagnóstico de asma.', '2025-04-24', '2018-09-26', true, '2022-08-05'),
('Epilepsia', 'Diagnóstico de epilepsia.', '2025-04-24', '2018-05-24', false, '2023-09-29'),
('Artritis Reumatoide', 'Diagnóstico de artritis reumatoide.', '2025-04-24', '1999-06-06', false, '2009-12-26'),
('EPOC', 'Diagnóstico de epoc.', '2025-04-24', '2010-02-07', true, '2012-12-02'),
('Fibromialgia', 'Diagnóstico de fibromialgia.', '2025-04-24', '2013-03-21', false, NULL),
('Insuficiencia Renal Crónica', 'Diagnóstico de insuficiencia renal crónica.', '2025-04-24', '2006-03-22', true, '2016-01-24'),
('Esclerosis Múltiple', 'Diagnóstico de esclerosis múltiple.', '2025-04-24', '2001-01-24', true, '2013-01-22'),
('Lupus', 'Diagnóstico de lupus.', '2025-04-24', '2013-03-30', true, NULL),
('Cardiopatía Isquémica', 'Diagnóstico de cardiopatía isquémica.', '2025-04-24', '2013-12-30', true, '2023-05-15'),
('Obesidad', 'Diagnóstico de obesidad.', '2025-04-24', '2017-08-29', false, '2019-01-25'),
('Hepatitis Crónica', 'Diagnóstico de hepatitis crónica.', '2025-04-24', '2007-07-20', false, '2013-03-01'),
('Enfermedad de Crohn', 'Diagnóstico de enfermedad de crohn.', '2025-04-24', '2017-10-08', false, '2021-04-11'),
('Colitis Ulcerosa', 'Diagnóstico de colitis ulcerosa.', '2025-04-24', '2006-02-26', true, '2007-04-27'),
('Esquizofrenia', 'Diagnóstico de esquizofrenia.', '2025-04-24', '2006-12-10', true, NULL),
('Trastorno Bipolar', 'Diagnóstico de trastorno bipolar.', '2025-04-24', '2004-06-11', false, '2016-08-06'),
('Cáncer', 'Diagnóstico de cáncer.', '2025-04-24', '2012-03-11', false, '2018-02-13'),
('Parkinson', 'Diagnóstico de parkinson.', '2025-04-24', '2014-07-25', true, NULL),
('Alzheimer', 'Diagnóstico de alzheimer.', '2025-04-24', '2004-09-04', true, '2014-11-18');

select * from schemasye.tc_enfermedad_cronica;

--Creacion de sp para la agregacion de datos
CREATE OR REPLACE PROCEDURE schemasye.sp_insertar_enfermedad(
    p_nombre VARCHAR,
    p_descripcion VARCHAR DEFAULT '',
    p_fecha_inicio DATE DEFAULT CURRENT_DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO schemasye.tc_enfermedad_cronica (
        nombre, descripcion, fecha_inicio
    )
    VALUES (
        p_nombre, p_descripcion, p_fecha_inicio
    );
END;
$$;

--Ejemplo del sp sp_insertar_enfermedad para agregar
CALL schemasye.sp_insertar_enfermedad(
    'Hipertensión',
    'Presión arterial elevada crónica',
    '2024-01-15'
);

-- Creacion de sp para la actualizacion de datos.
CREATE OR REPLACE PROCEDURE schemasye.sp_actualizar_enfermedad(
    p_id_enf_cronica INT,
    p_nombre VARCHAR,
    p_descripcion VARCHAR,
    p_fecha_inicio DATE,
    p_estado BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE schemasye.tc_enfermedad_cronica
    SET nombre = p_nombre,
        descripcion = p_descripcion,
        fecha_inicio = p_fecha_inicio,
        estado = p_estado,
        fecha_actualizacion = CURRENT_DATE
    WHERE id_enf_cronica = p_id_enf_cronica;
END;
$$;


--Ejemplo de la llamado al sp de schemasye.sp_actualizar_enfermedad
CALL schemasye.sp_actualizar_enfermedad(
    1,
    'Hipertensión arterial',
    'Enfermedad crónica del sistema circulatorio',
    '2024-01-01',
    true
);

--Creacion del sp para la eliminacion
CREATE OR REPLACE PROCEDURE schemasye.sp_eliminar_enfermedad(
    p_id_enf_cronica INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_exists BOOLEAN;
BEGIN
    -- Verificar si el registro existe
    SELECT EXISTS (
        SELECT 1 FROM schemasye.tc_enfermedad_cronica
        WHERE id_enf_cronica = p_id_enf_cronica
    ) INTO v_exists;

    IF v_exists THEN
        DELETE FROM schemasye.tc_enfermedad_cronica
        WHERE id_enf_cronica = p_id_enf_cronica;

        RAISE NOTICE 'Registro con ID % fue eliminado definitivamente.', p_id_enf_cronica;
    ELSE
        RAISE NOTICE 'No se encontró un registro con ID %.', p_id_enf_cronica;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error al intentar eliminar la enfermedad: %', SQLERRM;
END;
$$;

--Ejecucion del sp para la eliminacion de un registro
CALL schemasye.sp_eliminar_enfermedad(1);

select * from schemasye.tc_enfermedad_cronica;

