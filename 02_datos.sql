-- ===========================================================
--     PROYECTO FINAL BASES DE DATOS: CASO 1 RENTA DE VEHICULOS V2
--     INCISO B: DATOS DE PRUEBA  (02_datos.sql)
--     10-11-2026
-- ===========================================================


/*
INCISO B:
A CADA TABLA, INSERTARLE MINIMO 50 Y MAXIMO 100 TUPLAS.

28 TABLAS QUEDAN ENTRE 50 Y 100 FILAS. LOS 4 CATALOGOS QUE FIJA EL CASO
(POLIZA = 3, MODALIDAD = 2, TIPO_INSPECCION = 2, TIPO_TELEFONO = 3)
SE DEJAN CON SUS VALORES REALES: SI SE LES METEN 50 FILAS SE INVENTAN
REGLAS DE NEGOCIO QUE EL CASO NO TIENE Y SE ROMPEN LOS CHECK.

TOTAL DE FILAS: 1.826
"HOY" EN LOS DATOS = 10 DE NOVIEMBRE DE 2026 (DIA DE LA EXPOSICION)
*/


-- NECESITO: LAS 32 TABLAS YA CREADAS CON queryProyectoFinal.sql
-- ETICA: TODOS LOS DATOS SON FICTICIOS, LOS CORREOS SON .example
-- Y DE LA TARJETA SOLO SE GUARDAN LOS ULTIMOS 4 DIGITOS


-- PARA USAR LA BASE DE DATOS:
USE RENTA_VEHICULOS
GO

SET NOCOUNT ON; -- QUITA EL MENSAJE "(N filas afectadas)" DE CADA INSERT


-- ===========================================================
-- PASO 1: LA BASE DEBE ESTAR RECIEN CREADA
-- LAS TABLAS CON IDENTITY (1,1) PONEN EL ID SOLAS: 1, 2, 3... EN EL ORDEN DEL INSERT.
-- POR ESO LOS INSERT NO LLEVAN EL ID (COMO EN LA TABLA VENDEDOR DE CLASE)
-- Y LAS FK USAN ESOS NUMEROS. SI EL SCRIPT YA SE HABIA EJECUTADO, LOS ID
-- SEGUIRIAN EN 51, 52... Y LAS FK FALLAN. EN ESE CASO PRIMERO SE HACE:
--
--     USE master
--     GO
--     DROP DATABASE RENTA_VEHICULOS   -- ELIMINA TODO
--     GO
--
-- Y SE EJECUTA OTRA VEZ queryProyectoFinal.sql (CREA LA BASE Y LAS TABLAS)
-- ===========================================================

IF EXISTS (SELECT 1 FROM USUARIO)
BEGIN
	RAISERROR('LA BASE YA TIENE DATOS: HAGA DROP DATABASE Y EJECUTE OTRA VEZ queryProyectoFinal.sql',16,1)
	RETURN;
END
GO


-- ===========================================================
-- PASO 2: INSERTAR LOS DATOS
-- PRIMERO LOS PADRES (CATALOGOS) Y DESPUES LOS HIJOS (TABLAS CON FK),
-- PORQUE UNA FK SOLO ACEPTA UN VALOR QUE YA EXISTA EN LA TABLA DE LA PK
--
-- EN LAS TABLAS CON IDENTITY EL ID NO SE ESCRIBE: AL FINAL DE CADA FILA
-- VA UN COMENTARIO CON EL ID QUE LE VA A TOCAR (-- ID 1, -- ID 2...)
-- ===========================================================


--  ======================================================
--  CATALOGOS (TABLAS "TIPO")
--  ======================================================

/*
TABLA TIPO_DOCUMENTO: 50 FILAS
50 TIPOS: LOS COLOMBIANOS (CC, CE, TI, PEP, PPT...) Y LOS DOCUMENTOS DE EXTRANJEROS (DNI, PASAPORTES),
PORQUE LA EMPRESA ATIENDE TURISTAS QUE PAGAN EN USD O EUR.
*/

INSERT INTO TIPO_DOCUMENTO(
NOMBRE
)
VALUES('CEDULA DE CIUDADANIA'),  -- ID 1
	('CEDULA DE EXTRANJERIA'),  -- ID 2
	('TARJETA DE IDENTIDAD'),  -- ID 3
	('PASAPORTE COLOMBIANO'),  -- ID 4
	('PERMISO ESPECIAL DE PERMANENCIA'),  -- ID 5
	('PERMISO POR PROTECCION TEMPORAL'),  -- ID 6
	('NIT'),  -- ID 7
	('REGISTRO CIVIL'),  -- ID 8
	('CARNE DIPLOMATICO'),  -- ID 9
	('SALVOCONDUCTO DE PERMANENCIA'),  -- ID 10
	('DOCUMENTO EXTRANJERO (DIE)'),  -- ID 11
	('DNI PERU'),  -- ID 12
	('DNI ARGENTINA'),  -- ID 13
	('DNI ESPANA'),  -- ID 14
	('CEDULA DE IDENTIDAD ECUADOR'),  -- ID 15
	('CEDULA DE IDENTIDAD VENEZUELA'),  -- ID 16
	('CEDULA DE IDENTIDAD BOLIVIA'),  -- ID 17
	('CEDULA DE IDENTIDAD URUGUAY'),  -- ID 18
	('CEDULA DE IDENTIDAD PARAGUAY'),  -- ID 19
	('RUN CHILE'),  -- ID 20
	('INE MEXICO'),  -- ID 21
	('DPI GUATEMALA'),  -- ID 22
	('DUI EL SALVADOR'),  -- ID 23
	('CEDULA PANAMA'),  -- ID 24
	('CEDULA COSTA RICA'),  -- ID 25
	('CEDULA REPUBLICA DOMINICANA'),  -- ID 26
	('DNI HONDURAS'),  -- ID 27
	('CEDULA NICARAGUA'),  -- ID 28
	('RG BRASIL'),  -- ID 29
	('DNI ALEMANIA'),  -- ID 30
	('CARTE D IDENTITE FRANCIA'),  -- ID 31
	('CARTA D IDENTITA ITALIA'),  -- ID 32
	('PASAPORTE ESTADOS UNIDOS'),  -- ID 33
	('PASAPORTE CANADA'),  -- ID 34
	('PASAPORTE MEXICO'),  -- ID 35
	('PASAPORTE ESPANA'),  -- ID 36
	('PASAPORTE FRANCIA'),  -- ID 37
	('PASAPORTE ALEMANIA'),  -- ID 38
	('PASAPORTE ITALIA'),  -- ID 39
	('PASAPORTE REINO UNIDO'),  -- ID 40
	('PASAPORTE PAISES BAJOS'),  -- ID 41
	('PASAPORTE SUIZA'),  -- ID 42
	('PASAPORTE PORTUGAL'),  -- ID 43
	('PASAPORTE BRASIL'),  -- ID 44
	('PASAPORTE ARGENTINA'),  -- ID 45
	('PASAPORTE CHILE'),  -- ID 46
	('PASAPORTE PERU'),  -- ID 47
	('PASAPORTE JAPON'),  -- ID 48
	('PASAPORTE COREA DEL SUR'),  -- ID 49
	('PASAPORTE AUSTRALIA')  -- ID 50
GO

SELECT * FROM TIPO_DOCUMENTO  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----

/*
TABLA TIPO_TELEFONO: 3 FILAS
CATÁLOGO CERRADO (3 FILAS): UN TELÉFONO SOLO PUEDE SER CELULAR, FIJO U OFICINA.
INVENTAR 50 TIPOS DE TELÉFONO NO TENDRÍA SENTIDO PARA EL NEGOCIO.
*/

INSERT INTO TIPO_TELEFONO(
NOMBRE
)
VALUES('CELULAR'),  -- ID 1
	('FIJO'),  -- ID 2
	('OFICINA')  -- ID 3
GO

SELECT * FROM TIPO_TELEFONO  -- TOTAL REGISTROS 3
GO

---   -----          ------          -----

/*
TABLA TIPO_EMPRESA: 50 FILAS
50 SECTORES ECONÓMICOS. SOLO 25 TIENEN CONVENIO: LOS OTROS 25 SIRVEN PARA LEFT/RIGHT JOIN
("TIPOS DE EMPRESA SIN CONVENIO").
*/

INSERT INTO TIPO_EMPRESA(
NOMBRE
)
VALUES('ASEGURADORA'),  -- ID 1
	('BANCO'),  -- ID 2
	('COOPERATIVA FINANCIERA'),  -- ID 3
	('FONDO DE EMPLEADOS'),  -- ID 4
	('CAJA DE COMPENSACION'),  -- ID 5
	('UNIVERSIDAD'),  -- ID 6
	('INSTITUCION EDUCATIVA'),  -- ID 7
	('CLINICA U HOSPITAL'),  -- ID 8
	('EPS'),  -- ID 9
	('AEROLINEA'),  -- ID 10
	('AGENCIA DE VIAJES'),  -- ID 11
	('HOTEL'),  -- ID 12
	('CONSTRUCTORA'),  -- ID 13
	('MINERA'),  -- ID 14
	('PETROLERA'),  -- ID 15
	('EMPRESA DE ENERGIA'),  -- ID 16
	('TELECOMUNICACIONES'),  -- ID 17
	('DESARROLLO DE SOFTWARE'),  -- ID 18
	('CONSULTORIA'),  -- ID 19
	('COMERCIO MINORISTA'),  -- ID 20
	('LOGISTICA'),  -- ID 21
	('TRANSPORTE DE CARGA'),  -- ID 22
	('FARMACEUTICA'),  -- ID 23
	('ALIMENTOS'),  -- ID 24
	('BEBIDAS'),  -- ID 25
	('TEXTIL Y CONFECCION'),  -- ID 26
	('AUTOMOTRIZ'),  -- ID 27
	('ENTIDAD PUBLICA'),  -- ID 28
	('ALCALDIA O GOBERNACION'),  -- ID 29
	('ONG'),  -- ID 30
	('EVENTOS Y CONVENCIONES'),  -- ID 31
	('PUBLICIDAD'),  -- ID 32
	('MEDIOS DE COMUNICACION'),  -- ID 33
	('AGROINDUSTRIA'),  -- ID 34
	('FLORICULTURA'),  -- ID 35
	('CAFE'),  -- ID 36
	('INMOBILIARIA'),  -- ID 37
	('SERVICIOS PUBLICOS'),  -- ID 38
	('SEGURIDAD PRIVADA'),  -- ID 39
	('ASEO Y MANTENIMIENTO'),  -- ID 40
	('CENTRO DE INVESTIGACION'),  -- ID 41
	('EMPRESA DE TECNOLOGIA'),  -- ID 42
	('CALL CENTER'),  -- ID 43
	('BPO'),  -- ID 44
	('EXPORTADORA'),  -- ID 45
	('IMPORTADORA'),  -- ID 46
	('FERRETERIA'),  -- ID 47
	('LABORATORIO'),  -- ID 48
	('RESTAURANTES'),  -- ID 49
	('EMPRESA FAMILIAR')  -- ID 50
GO

SELECT * FROM TIPO_EMPRESA  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----

/*
TABLA TIPO_MULTIMEDIA: 50 FILAS
50 TIPOS: 39 ÁNGULOS DE FOTO Y 11 TIPOS DE VIDEO DEL VEHÍCULO (EL CASO PIDE FOTOS Y VIDEOS).
FILTRAR CON NOMBRE LIKE 'FOTO%' O LIKE 'VIDEO%'.
*/

INSERT INTO TIPO_MULTIMEDIA(
NOMBRE
)
VALUES('FOTO - FRONTAL'),  -- ID 1
	('FOTO - TRASERA'),  -- ID 2
	('FOTO - LATERAL IZQUIERDO'),  -- ID 3
	('FOTO - LATERAL DERECHO'),  -- ID 4
	('FOTO - TRES CUARTOS DELANTERO'),  -- ID 5
	('FOTO - TRES CUARTOS TRASERO'),  -- ID 6
	('FOTO - TABLERO'),  -- ID 7
	('FOTO - TIMON'),  -- ID 8
	('FOTO - SILLAS DELANTERAS'),  -- ID 9
	('FOTO - SILLAS TRASERAS'),  -- ID 10
	('FOTO - BAUL'),  -- ID 11
	('FOTO - MOTOR'),  -- ID 12
	('FOTO - LLANTA DELANTERA IZQ'),  -- ID 13
	('FOTO - LLANTA DELANTERA DER'),  -- ID 14
	('FOTO - LLANTA TRASERA IZQ'),  -- ID 15
	('FOTO - LLANTA TRASERA DER'),  -- ID 16
	('FOTO - LLANTA DE REPUESTO'),  -- ID 17
	('FOTO - KIT DE CARRETERA'),  -- ID 18
	('FOTO - ODOMETRO'),  -- ID 19
	('FOTO - NIVEL DE COMBUSTIBLE'),  -- ID 20
	('FOTO - TECHO'),  -- ID 21
	('FOTO - PARABRISAS'),  -- ID 22
	('FOTO - VIDRIO TRASERO'),  -- ID 23
	('FOTO - ESPEJO IZQUIERDO'),  -- ID 24
	('FOTO - ESPEJO DERECHO'),  -- ID 25
	('FOTO - FAROLAS'),  -- ID 26
	('FOTO - STOPS'),  -- ID 27
	('FOTO - PLACA DELANTERA'),  -- ID 28
	('FOTO - PLACA TRASERA'),  -- ID 29
	('FOTO - PUERTA CONDUCTOR'),  -- ID 30
	('FOTO - PUERTA COPILOTO'),  -- ID 31
	('FOTO - PUERTAS TRASERAS'),  -- ID 32
	('FOTO - PARACHOQUES DELANTERO'),  -- ID 33
	('FOTO - PARACHOQUES TRASERO'),  -- ID 34
	('FOTO - TAPICERIA'),  -- ID 35
	('FOTO - CINTURONES'),  -- ID 36
	('FOTO - PANTALLA MULTIMEDIA'),  -- ID 37
	('FOTO - AIRE ACONDICIONADO'),  -- ID 38
	('FOTO - DOCUMENTOS DEL VEHICULO'),  -- ID 39
	('VIDEO - RECORRIDO 360 EXTERIOR'),  -- ID 40
	('VIDEO - RECORRIDO INTERIOR'),  -- ID 41
	('VIDEO - ENCENDIDO DEL MOTOR'),  -- ID 42
	('VIDEO - PRUEBA DE LUCES'),  -- ID 43
	('VIDEO - PRUEBA DE MANEJO'),  -- ID 44
	('VIDEO - FUNCIONES DEL TABLERO'),  -- ID 45
	('VIDEO - APERTURA DEL BAUL'),  -- ID 46
	('VIDEO - CAMARA DE REVERSA'),  -- ID 47
	('VIDEO - SENSORES DE PARQUEO'),  -- ID 48
	('VIDEO - PRESENTACION COMERCIAL'),  -- ID 49
	('VIDEO - CARGA ELECTRICA')  -- ID 50
GO

SELECT * FROM TIPO_MULTIMEDIA  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----

/*
TABLA TIPO_MANTENIMIENTO: 50 FILAS
50 TIPOS: 26 'MANTENIMIENTO: ...' (PREVENTIVO) Y 24 'REPARACION: ...' (CORRECTIVO).
EL CASO PIDE LA HOJA DE VIDA CON MANTENIMIENTOS Y REPARACIONES.
*/

INSERT INTO TIPO_MANTENIMIENTO(
NOMBRE
)
VALUES('MANTENIMIENTO: Cambio de aceite y filtro'),  -- ID 1
	('MANTENIMIENTO: Alineacion y balanceo'),  -- ID 2
	('MANTENIMIENTO: Rotacion de llantas'),  -- ID 3
	('MANTENIMIENTO: Cambio de llantas'),  -- ID 4
	('MANTENIMIENTO: Cambio de pastillas de freno'),  -- ID 5
	('MANTENIMIENTO: Cambio de liquido de frenos'),  -- ID 6
	('MANTENIMIENTO: Cambio de filtro de aire'),  -- ID 7
	('MANTENIMIENTO: Cambio de filtro de cabina'),  -- ID 8
	('MANTENIMIENTO: Cambio de bujias'),  -- ID 9
	('MANTENIMIENTO: Sincronizacion'),  -- ID 10
	('MANTENIMIENTO: Cambio de correa de reparticio'),  -- ID 11
	('MANTENIMIENTO: Cambio de refrigerante'),  -- ID 12
	('MANTENIMIENTO: Revision de 10.000 km'),  -- ID 13
	('MANTENIMIENTO: Revision de 20.000 km'),  -- ID 14
	('MANTENIMIENTO: Revision de 40.000 km'),  -- ID 15
	('MANTENIMIENTO: Lavado de inyectores'),  -- ID 16
	('MANTENIMIENTO: Revision tecnico-mecanica'),  -- ID 17
	('MANTENIMIENTO: Carga de aire acondicionado'),  -- ID 18
	('MANTENIMIENTO: Cambio de bateria'),  -- ID 19
	('MANTENIMIENTO: Revision sistema electrico'),  -- ID 20
	('MANTENIMIENTO: Lavado y polichado'),  -- ID 21
	('MANTENIMIENTO: Desinfeccion de cabina'),  -- ID 22
	('MANTENIMIENTO: Cambio de plumillas'),  -- ID 23
	('MANTENIMIENTO: Revision de suspension'),  -- ID 24
	('MANTENIMIENTO: Cambio de aceite de caja'),  -- ID 25
	('MANTENIMIENTO: Revision bateria de alta tensi'),  -- ID 26
	('REPARACION: Reparacion de latoneria'),  -- ID 27
	('REPARACION: Reparacion de pintura'),  -- ID 28
	('REPARACION: Cambio de parabrisas'),  -- ID 29
	('REPARACION: Reparacion de rayones'),  -- ID 30
	('REPARACION: Cambio de espejo retrovisor'),  -- ID 31
	('REPARACION: Reparacion de parachoques'),  -- ID 32
	('REPARACION: Cambio de farola'),  -- ID 33
	('REPARACION: Reparacion de stop'),  -- ID 34
	('REPARACION: Reparacion de tapiceria'),  -- ID 35
	('REPARACION: Reparacion de suspension'),  -- ID 36
	('REPARACION: Reparacion de embrague'),  -- ID 37
	('REPARACION: Reparacion de caja'),  -- ID 38
	('REPARACION: Reparacion de motor'),  -- ID 39
	('REPARACION: Reparacion de frenos'),  -- ID 40
	('REPARACION: Reparacion de direccion'),  -- ID 41
	('REPARACION: Reparacion de aire acondicionado'),  -- ID 42
	('REPARACION: Reparacion electrica'),  -- ID 43
	('REPARACION: Cambio de rin'),  -- ID 44
	('REPARACION: Reparacion de pinchazo'),  -- ID 45
	('REPARACION: Reparacion de cerradura'),  -- ID 46
	('REPARACION: Reparacion de vidrio electrico'),  -- ID 47
	('REPARACION: Cambio de radiador'),  -- ID 48
	('REPARACION: Reparacion de escape'),  -- ID 49
	('REPARACION: Reparacion por siniestro')  -- ID 50
GO

SELECT * FROM TIPO_MANTENIMIENTO  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----

/*
TABLA TIPO_INSPECCION: 2 FILAS
CATÁLOGO CERRADO (2 FILAS): EL CASO SOLO TIENE ACTA DE ENTREGA Y ACTA DE DEVOLUCION.
ADEMÁS UQ_INSPECCION_ALQUILER_TIPO USA ESTOS 2 VALORES (1 ACTA DE CADA TIPO POR ALQUILER).
*/

INSERT INTO TIPO_INSPECCION(
NOMBRE
)
VALUES('ENTREGA'),  -- ID 1
	('DEVOLUCION')  -- ID 2
GO

SELECT * FROM TIPO_INSPECCION  -- TOTAL REGISTROS 2
GO

---   -----          ------          -----


--  ======================================================
--  PERSONAS (ESPECIALIZACION USUARIO -> CLIENTE / EMPLEADO)
--  ======================================================

/*
TABLA USUARIO: 100 FILAS
100 USUARIOS (SUPERCLASE). 1-50 = EMPLEADOS, 51-100 = CLIENTES (ESPECIALIZACIÓN TOTAL Y DISJUNTA).
LA CONTRASEÑA (CONTRASENA_HASH) NO SE CARGA AQUI: QUEDA EN NULL Y LA ASIGNA EL SISTEMA AL REGISTRARSE.
CORREOS CON DOMINIO .EXAMPLE (FICTICIOS). INACTIVOS: EMPLEADOS 12, 33, 47 Y CLIENTES VETADOS 73, 85.
*/

INSERT INTO USUARIO(
CORREO, ROL, ACTIVO
)
VALUES('sebastian.posada@rentaitm.example', 'GERENTE', 1),  -- ID 1
	('mauricio.agudelo@rentaitm.example', 'ADMINISTRADOR', 1),  -- ID 2
	('mateo.moreno@rentaitm.example', 'ADMINISTRADOR', 1),  -- ID 3
	('jorge.ramirez@rentaitm.example', 'ADMINISTRADOR', 1),  -- ID 4
	('maria.henao@rentaitm.example', 'ADMINISTRADOR', 1),  -- ID 5
	('sebastian.cardona@rentaitm.example', 'COORDINADOR', 1),  -- ID 6
	('diana.martinez@rentaitm.example', 'COORDINADOR', 1),  -- ID 7
	('luisa.londono@rentaitm.example', 'COORDINADOR', 1),  -- ID 8
	('oscar.hernandez@rentaitm.example', 'COORDINADOR', 1),  -- ID 9
	('sofia.henao@rentaitm.example', 'COORDINADOR', 1),  -- ID 10
	('lucia.garcia@rentaitm.example', 'COORDINADOR', 1),  -- ID 11
	('andres.posada@rentaitm.example', 'COORDINADOR', 0),  -- ID 12
	('mauricio.botero@rentaitm.example', 'COORDINADOR', 1),  -- ID 13
	('mateo.velez@rentaitm.example', 'COORDINADOR', 1),  -- ID 14
	('julian.rios@rentaitm.example', 'COORDINADOR', 1),  -- ID 15
	('luis.garcia@rentaitm.example', 'COORDINADOR', 1),  -- ID 16
	('paula.munoz@rentaitm.example', 'COORDINADOR', 1),  -- ID 17
	('carlos.agudelo@rentaitm.example', 'COORDINADOR', 1),  -- ID 18
	('jorge.moreno@rentaitm.example', 'COORDINADOR', 1),  -- ID 19
	('sara.quintero@rentaitm.example', 'COORDINADOR', 1),  -- ID 20
	('paola.mejia@rentaitm.example', 'COORDINADOR', 1),  -- ID 21
	('ana.velez@rentaitm.example', 'COORDINADOR', 1),  -- ID 22
	('jorge.jaramillo@rentaitm.example', 'COORDINADOR', 1),  -- ID 23
	('laura.quintero@rentaitm.example', 'COORDINADOR', 1),  -- ID 24
	('diego.henao@rentaitm.example', 'COORDINADOR', 1),  -- ID 25
	('juan.moreno@rentaitm.example', 'COORDINADOR', 1),  -- ID 26
	('carlos.botero@rentaitm.example', 'COORDINADOR', 1),  -- ID 27
	('esteban.londono@rentaitm.example', 'COORDINADOR', 1),  -- ID 28
	('diana.uribe@rentaitm.example', 'CAJERO', 1),  -- ID 29
	('natalia.echeverri@rentaitm.example', 'CAJERO', 1),  -- ID 30
	('oscar.mejia@rentaitm.example', 'CAJERO', 1),  -- ID 31
	('tomas.uribe@rentaitm.example', 'CAJERO', 1),  -- ID 32
	('lucia.osorio@rentaitm.example', 'CAJERO', 0),  -- ID 33
	('felipe.castano@rentaitm.example', 'CAJERO', 1),  -- ID 34
	('alejandro.castano@rentaitm.example', 'CAJERO', 1),  -- ID 35
	('maria.restrepo@rentaitm.example', 'CAJERO', 1),  -- ID 36
	('oscar.moreno@rentaitm.example', 'CAJERO', 1),  -- ID 37
	('paola.vasquez@rentaitm.example', 'CAJERO', 1),  -- ID 38
	('mateo.uribe@rentaitm.example', 'CAJERO', 1),  -- ID 39
	('jorge.ramirez2@rentaitm.example', 'CAJERO', 1),  -- ID 40
	('juliana.moreno@rentaitm.example', 'CAJERO', 1),  -- ID 41
	('carolina.hernandez@rentaitm.example', 'CAJERO', 1),  -- ID 42
	('natalia.osorio@rentaitm.example', 'CAJERO', 1),  -- ID 43
	('felipe.hernandez@rentaitm.example', 'CAJERO', 1),  -- ID 44
	('oscar.velez@rentaitm.example', 'CAJERO', 1),  -- ID 45
	('veronica.tobon@rentaitm.example', 'CAJERO', 1),  -- ID 46
	('mauricio.salazar@rentaitm.example', 'CAJERO', 0),  -- ID 47
	('lucia.martinez@rentaitm.example', 'CAJERO', 1),  -- ID 48
	('oscar.osorio@rentaitm.example', 'CAJERO', 1),  -- ID 49
	('oscar.ramirez@rentaitm.example', 'CAJERO', 1),  -- ID 50
	('juan.henao@correo.example', 'CLIENTE', 1),  -- ID 51
	('hernan.rios@correo.example', 'CLIENTE', 1),  -- ID 52
	('john.miller@correo.example', 'CLIENTE', 1),  -- ID 53
	('diego.hernandez@correo.example', 'CLIENTE', 1),  -- ID 54
	('carlos.henao@correo.example', 'CLIENTE', 1),  -- ID 55
	('felipe.vasquez@correo.example', 'CLIENTE', 1),  -- ID 56
	('andres.jaramillo@correo.example', 'CLIENTE', 1),  -- ID 57
	('jorge.osorio@correo.example', 'CLIENTE', 1),  -- ID 58
	('mateo.lopez@correo.example', 'CLIENTE', 1),  -- ID 59
	('julian.rodriguez@correo.example', 'CLIENTE', 1),  -- ID 60
	('emily.johnson@correo.example', 'CLIENTE', 1),  -- ID 61
	('antonia.henao@correo.example', 'CLIENTE', 1),  -- ID 62
	('antonia.henao2@correo.example', 'CLIENTE', 1),  -- ID 63
	('daniela.posada@correo.example', 'CLIENTE', 1),  -- ID 64
	('andres.vasquez@correo.example', 'CLIENTE', 1),  -- ID 65
	('simon.jaramillo@correo.example', 'CLIENTE', 1),  -- ID 66
	('pierre.dubois@correo.example', 'CLIENTE', 1),  -- ID 67
	('mateo.botero@correo.example', 'CLIENTE', 1),  -- ID 68
	('mauricio.montoya@correo.example', 'CLIENTE', 1),  -- ID 69
	('maria.salazar@correo.example', 'CLIENTE', 1),  -- ID 70
	('hans.schmidt@correo.example', 'CLIENTE', 1),  -- ID 71
	('andres.hernandez@correo.example', 'CLIENTE', 1),  -- ID 72
	('carolina.cardona@correo.example', 'CLIENTE', 0),  -- ID 73
	('jorge.munoz@correo.example', 'CLIENTE', 1),  -- ID 74
	('juan.ospina@correo.example', 'CLIENTE', 1),  -- ID 75
	('giulia.rossi@correo.example', 'CLIENTE', 1),  -- ID 76
	('veronica.botero@correo.example', 'CLIENTE', 1),  -- ID 77
	('alejandro.martinez@correo.example', 'CLIENTE', 1),  -- ID 78
	('luisa.duque@correo.example', 'CLIENTE', 1),  -- ID 79
	('mateo.vasquez@correo.example', 'CLIENTE', 1),  -- ID 80
	('tomas.vasquez@correo.example', 'CLIENTE', 1),  -- ID 81
	('emilio.uribe@correo.example', 'CLIENTE', 1),  -- ID 82
	('lucia.fernandez@correo.example', 'CLIENTE', 1),  -- ID 83
	('valentina.gonzalez@correo.example', 'CLIENTE', 1),  -- ID 84
	('paula.posada@correo.example', 'CLIENTE', 0),  -- ID 85
	('julian.rodriguez2@correo.example', 'CLIENTE', 1),  -- ID 86
	('sophie.tremblay@correo.example', 'CLIENTE', 1),  -- ID 87
	('simon.henao@correo.example', 'CLIENTE', 1),  -- ID 88
	('valentina.echeverri@correo.example', 'CLIENTE', 1),  -- ID 89
	('kenji.tanaka@correo.example', 'CLIENTE', 1),  -- ID 90
	('natalia.ramirez@correo.example', 'CLIENTE', 1),  -- ID 91
	('juliana.ospina@correo.example', 'CLIENTE', 1),  -- ID 92
	('mariana.uribe@correo.example', 'CLIENTE', 1),  -- ID 93
	('liam.smith@correo.example', 'CLIENTE', 1),  -- ID 94
	('felipe.rios@correo.example', 'CLIENTE', 1),  -- ID 95
	('sofia.arango@correo.example', 'CLIENTE', 1),  -- ID 96
	('luisa.posada@correo.example', 'CLIENTE', 1),  -- ID 97
	('ji-woo.park@correo.example', 'CLIENTE', 1),  -- ID 98
	('david.gonzalez@correo.example', 'CLIENTE', 1),  -- ID 99
	('hernan.rodriguez@correo.example', 'CLIENTE', 1)  -- ID 100
GO

SELECT * FROM USUARIO  -- TOTAL REGISTROS 100
GO

---   -----          ------          -----

/*
TABLA EMPLEADO: 50 FILAS
50 EMPLEADOS: 1 GERENTE, 4 ADMINISTRADOR, 23 COORDINADOR (HACEN LAS ACTAS) Y 22 CAJERO (REGISTRAN PAGOS).
*/

INSERT INTO EMPLEADO(
ID_EMPLEADO, NOMBRES, CARGO
)
VALUES(1, 'Sebastian Posada Alzate', 'GERENTE'),
	(2, 'Mauricio Agudelo Tobon', 'ADMINISTRADOR'),
	(3, 'Mateo Moreno Cardona', 'ADMINISTRADOR'),
	(4, 'Jorge Ramirez Rodriguez', 'ADMINISTRADOR'),
	(5, 'Maria Camila Henao Henao', 'ADMINISTRADOR'),
	(6, 'Sebastian Cardona Arango', 'COORDINADOR'),
	(7, 'Diana Martinez Montoya', 'COORDINADOR'),
	(8, 'Luisa Londono Castano', 'COORDINADOR'),
	(9, 'Oscar Hernandez Arango', 'COORDINADOR'),
	(10, 'Sofia Henao Mejia', 'COORDINADOR'),
	(11, 'Lucia Garcia Castano', 'COORDINADOR'),
	(12, 'Andres Posada Agudelo', 'COORDINADOR'),
	(13, 'Mauricio Botero Martinez', 'COORDINADOR'),
	(14, 'Mateo Velez Martinez', 'COORDINADOR'),
	(15, 'Julian Rios Munoz', 'COORDINADOR'),
	(16, 'Luis Fernando Garcia Lopez', 'COORDINADOR'),
	(17, 'Paula Andrea Munoz Jaramillo', 'COORDINADOR'),
	(18, 'Carlos Agudelo Arango', 'COORDINADOR'),
	(19, 'Jorge Moreno Agudelo', 'COORDINADOR'),
	(20, 'Sara Quintero Ospina', 'COORDINADOR'),
	(21, 'Paola Mejia Uribe', 'COORDINADOR'),
	(22, 'Ana Maria Velez Posada', 'COORDINADOR'),
	(23, 'Jorge Jaramillo Velez', 'COORDINADOR'),
	(24, 'Laura Quintero Martinez', 'COORDINADOR'),
	(25, 'Diego Henao Tobon', 'COORDINADOR'),
	(26, 'Juan Pablo Moreno Henao', 'COORDINADOR'),
	(27, 'Carlos Botero Lopez', 'COORDINADOR'),
	(28, 'Esteban Londono Montoya', 'COORDINADOR'),
	(29, 'Diana Uribe Mejia', 'CAJERO'),
	(30, 'Natalia Echeverri Londono', 'CAJERO'),
	(31, 'Oscar Mejia Gonzalez', 'CAJERO'),
	(32, 'Tomas Uribe Duque', 'CAJERO'),
	(33, 'Lucia Osorio Munoz', 'CAJERO'),
	(34, 'Felipe Castano Ochoa', 'CAJERO'),
	(35, 'Alejandro Castano Ospina', 'CAJERO'),
	(36, 'Maria Camila Restrepo Cardona', 'CAJERO'),
	(37, 'Oscar Moreno Alzate', 'CAJERO'),
	(38, 'Paola Vasquez Londono', 'CAJERO'),
	(39, 'Mateo Uribe Agudelo', 'CAJERO'),
	(40, 'Jorge Ramirez Gomez', 'CAJERO'),
	(41, 'Juliana Moreno Rios', 'CAJERO'),
	(42, 'Carolina Hernandez Munoz', 'CAJERO'),
	(43, 'Natalia Osorio Ospina', 'CAJERO'),
	(44, 'Felipe Hernandez Osorio', 'CAJERO'),
	(45, 'Oscar Velez Mejia', 'CAJERO'),
	(46, 'Veronica Tobon Zapata', 'CAJERO'),
	(47, 'Mauricio Salazar Arango', 'CAJERO'),
	(48, 'Lucia Martinez Velez', 'CAJERO'),
	(49, 'Oscar Osorio Rodriguez', 'CAJERO'),
	(50, 'Oscar Ramirez Munoz', 'CAJERO')
GO

SELECT * FROM EMPLEADO  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----

/*
TABLA CLIENTE: 50 FILAS
50 CLIENTES. ESCENARIO PARA LA EXPOSICIÓN:
  MOROSOS (NO PUEDEN RESERVAR): 58, 66, 79, 92 -> DEBEN PARTE DE UNA FACTURA.
  VETADOS (NO PUEDEN INGRESAR): 73, 85 -> CAUSARON UN DAÑO GRAVE; USUARIO.ACTIVO = 0.
  LICENCIA VENCIDA: 96 (VENCIÓ EL 30-SEP-2026; SU ALQUILER FUE ANTES).
  SOLO LICENCIA DE MOTO (A2): 63, 88, 99 -> NUNCA HAN ALQUILADO (SIRVEN PARA LEFT JOIN).
  EXTRANJEROS (PASAPORTE/DNI, PAGAN EN USD O EUR): 53, 61, 67, 71, 76, 83, 87, 90, 94, 98.
ÉTICA: DE LA TARJETA SOLO SE GUARDAN LOS ÚLTIMOS 4 DÍGITOS.
*/

INSERT INTO CLIENTE(
ID_CLIENTE, ID_TIPO_DOCUMENTO, NUM_DOCUMENTO, NOMBRES, DIRECCION, CODIGO_POSTAL, GENERO, FECHA_NACIMIENTO, NIVEL_ESTUDIOS, NUM_LICENCIA, CATEGORIA_LICENCIA, VENCIMIENTO_LICENCIA, ESTADO, ULTIMOS4_TARJETA
)
VALUES(51, 1, '1038157137', 'Juan Pablo Henao Rendon', 'Carrera 42 # 68-52, Sabaneta', '055450', 'MASCULINO', '19820105', 'TECNICO', '1038157137', 'B1', '20340320', 'AL_DIA', '3231'),
	(52, 1, '1079731932', 'Hernan Rios Gonzalez', 'Transversal 26 # 95-12, Itagui', '055412', 'MASCULINO', '19620622', 'PROFESIONAL', '1079731932', 'B1', '20281025', 'AL_DIA', '4565'),
	(53, 33, 'E5861687', 'John Miller', 'Carrera 15 # 37-50, Bello', '051050', 'MASCULINO', '19961028', 'TECNOLOGO', 'INTE5861687', 'C1', '20360401', 'AL_DIA', '4464'),
	(54, 1, '1061634972', 'Diego Hernandez Mejia', 'Circular 26 # 73-80, Rionegro', '054040', 'MASCULINO', '19651123', 'POSGRADO', '1061634972', 'B2', '20290704', 'AL_DIA', '1688'),
	(55, 1, '1183307020', 'Carlos Henao Correa', 'Transversal 39 # 17-77, Itagui', '055412', 'MASCULINO', '19700524', 'TECNOLOGO', '1183307020', 'B1', '20290719', 'AL_DIA', '1003'),
	(56, 1, '1096638020', 'Felipe Vasquez Montoya', 'Diagonal 58 # 28-67, Sabaneta', '055450', 'MASCULINO', '19670804', 'BACHILLERATO', '1096638020', 'B1', '20320323', 'AL_DIA', '8389'),
	(57, 1, '1175912347', 'Andres Jaramillo Restrepo', 'Calle 33 # 68-29, Itagui', '055410', 'MASCULINO', '20010808', 'PROFESIONAL', '1175912347', 'B1', '20320621', 'AL_DIA', '4946'),
	(58, 1, '1105246023', 'Jorge Osorio Mejia', 'Transversal 21 # 43-75, Rionegro', '054040', 'MASCULINO', '19891007', 'PROFESIONAL', '1105246023', 'B1', '20310102', 'MOROSO', '2212'),
	(59, 2, '8144577', 'Mateo Lopez Henao', 'Circular 28 # 21-39, Sabaneta', '055450', 'MASCULINO', '19640104', 'TECNOLOGO', '8144577', 'C1', '20320817', 'AL_DIA', '3619'),
	(60, 1, '1087160748', 'Julian Rodriguez Henao', 'Circular 44 # 48-64, Envigado', '055422', 'MASCULINO', '20040721', 'BACHILLERATO', '1087160748', 'B1', '20320721', 'AL_DIA', '4781'),
	(61, 33, 'P7970602', 'Emily Johnson', 'Carrera 59 # 47-38, Sabaneta', '055450', 'FEMENINO', '19930628', 'BACHILLERATO', 'INTP7970602', 'C1', '20350426', 'AL_DIA', '2848'),
	(62, 1, '1023170023', 'Antonia Henao Cardona', 'Carrera 46 # 68-87, Sabaneta', '055450', 'FEMENINO', '20020915', 'PRIMARIA', '1023170023', 'B1', '20300927', 'AL_DIA', '9399'),
	(63, 1, '1135561971', 'Antonia Henao Jaramillo', 'Carrera 50 # 52-65, Itagui', '055412', 'FEMENINO', '19790725', 'PROFESIONAL', '1135561971', 'A2', '20301011', 'AL_DIA', '4470'),
	(64, 1, '1190159115', 'Daniela Posada Munoz', 'Circular 53 # 49-95, Sabaneta', '055450', 'FEMENINO', '19911127', 'PROFESIONAL', '1190159115', 'B1', '20350908', 'AL_DIA', '3138'),
	(65, 1, '1011896361', 'Andres Vasquez Henao', 'Diagonal 60 # 90-57, Rionegro', '054040', 'MASCULINO', '19880810', 'PRIMARIA', '1011896361', 'B1', '20290125', 'AL_DIA', '2408'),
	(66, 1, '1055202850', 'Simon Jaramillo Zapata', 'Carrera 105 # 25-2, Sabaneta', '055450', 'MASCULINO', '19790824', 'BACHILLERATO', '1055202850', 'B1', '20290810', 'MOROSO', '5351'),
	(67, 37, 'X4947970', 'Pierre Dubois', 'Diagonal 33 # 42-36, Sabaneta', '055450', 'MASCULINO', '19660625', 'POSGRADO', 'INTX4947970', 'C1', '20350511', 'AL_DIA', '8148'),
	(68, 1, '1070479768', 'Mateo Botero Posada', 'Circular 94 # 63-76, Sabaneta', '055450', 'MASCULINO', '19890227', 'TECNICO', '1070479768', 'B1', '20280615', 'AL_DIA', '2952'),
	(69, 1, '1073753343', 'Mauricio Montoya Quintero', 'Carrera 92 # 58-14, Envigado', '055420', 'MASCULINO', '20020603', 'POSGRADO', '1073753343', 'C1', '20300611', 'AL_DIA', '7199'),
	(70, 1, '1090280565', 'Maria Camila Salazar Ochoa', 'Circular 38 # 50-69, Envigado', '055422', 'FEMENINO', '19781105', 'PROFESIONAL', '1090280565', 'B2', '20321119', 'AL_DIA', '8865'),
	(71, 38, 'E1322199', 'Hans Schmidt', 'Circular 88 # 55-85, Itagui', '055410', 'MASCULINO', '19690928', 'TECNICO', 'INTE1322199', 'B1', '20310608', 'AL_DIA', '1750'),
	(72, 1, '1169882866', 'Andres Hernandez Mejia', 'Carrera 94 # 21-41, Rionegro', '054040', 'MASCULINO', '19760828', 'POSGRADO', '1169882866', 'C1', '20320112', 'AL_DIA', '6218'),
	(73, 1, '1126180400', 'Carolina Cardona Giraldo', 'Carrera 81 # 71-66, Envigado', '055420', 'FEMENINO', '19701018', 'TECNOLOGO', '1126180400', 'B1', '20330928', 'VETADO', '1920'),
	(74, 1, '1053242625', 'Jorge Munoz Gonzalez', 'Transversal 93 # 1-49, Sabaneta', '055450', 'MASCULINO', '19660308', 'TECNOLOGO', '1053242625', 'B1', '20281219', 'AL_DIA', '0379'),
	(75, 1, '1018195929', 'Juan Pablo Ospina Quintero', 'Circular 22 # 85-92, Rionegro', '054040', 'MASCULINO', '19731207', 'TECNICO', '1018195929', 'B1', '20290224', 'AL_DIA', '4133'),
	(76, 39, 'X5586863', 'Giulia Rossi', 'Calle 70 # 80-85, Rionegro', '054040', 'FEMENINO', '19990625', 'BACHILLERATO', 'INTX5586863', 'B1', '20270205', 'AL_DIA', '8022'),
	(77, 1, '1078918339', 'Veronica Botero Botero', 'Transversal 109 # 49-39, Medellin', '050010', 'OTRO', '19641210', 'PROFESIONAL', '1078918339', 'B1', '20320910', 'AL_DIA', '4455'),
	(78, 1, '1119566054', 'Alejandro Martinez Mejia', 'Circular 26 # 93-62, Bello', '051050', 'MASCULINO', '20031116', 'PRIMARIA', '1119566054', 'B1', '20310221', 'AL_DIA', '2726'),
	(79, 1, '1118943444', 'Luisa Duque Hernandez', 'Carrera 57 # 38-87, Bello', '051052', 'FEMENINO', '19890114', 'PROFESIONAL', '1118943444', 'B1', '20360925', 'MOROSO', '5157'),
	(80, 1, '1012993279', 'Mateo Vasquez Ochoa', 'Circular 39 # 67-38, Itagui', '055412', 'MASCULINO', '19810813', 'PROFESIONAL', '1012993279', 'B1', '20280718', 'AL_DIA', '3217'),
	(81, 1, '1001294760', 'Tomas Vasquez Zapata', 'Circular 54 # 74-5, Envigado', '055422', 'MASCULINO', '19891125', 'TECNOLOGO', '1001294760', 'C2', '20330325', 'AL_DIA', '4717'),
	(82, 1, '1085976031', 'Emilio Uribe Ramirez', 'Carrera 115 # 15-34, Medellin', '050012', 'MASCULINO', '19640524', 'PROFESIONAL', '1085976031', 'B1', '20290518', 'AL_DIA', '3654'),
	(83, 36, 'N9181489', 'Lucia Fernandez', 'Diagonal 109 # 28-69, Medellin', '050022', 'FEMENINO', '19720608', 'BACHILLERATO', 'INTN9181489', 'B1', '20360626', 'AL_DIA', '6637'),
	(84, 6, '9784753', 'Valentina Gonzalez Munoz', 'Circular 70 # 91-28, Itagui', '055410', 'FEMENINO', '19770121', 'POSGRADO', '9784753', 'B1', '20361127', 'AL_DIA', '8360'),
	(85, 1, '1006459005', 'Paula Andrea Posada Alzate', 'Diagonal 114 # 13-85, Itagui', '055410', 'FEMENINO', '20040916', 'TECNICO', '1006459005', 'B1', '20350802', 'VETADO', '3861'),
	(86, 1, '1175096754', 'Julian Rodriguez Garcia', 'Circular 105 # 57-24, Medellin', '050021', 'MASCULINO', '19750123', 'TECNICO', '1175096754', 'B1', '20290615', 'AL_DIA', '7600'),
	(87, 34, 'P6907001', 'Sophie Tremblay', 'Diagonal 53 # 32-72, Itagui', '055410', 'FEMENINO', '19780402', 'POSGRADO', 'INTP6907001', 'B1', '20300601', 'AL_DIA', '8206'),
	(88, 1, '1064222862', 'Simon Henao Henao', 'Diagonal 110 # 60-91, Sabaneta', '055450', 'MASCULINO', '20040208', 'BACHILLERATO', '1064222862', 'A2', '20340711', 'AL_DIA', '3047'),
	(89, 1, '1181894212', 'Valentina Echeverri Toro', 'Carrera 118 # 37-91, Itagui', '055410', 'FEMENINO', '19951210', 'BACHILLERATO', '1181894212', 'B1', '20350823', 'AL_DIA', '0443'),
	(90, 48, 'P1815145', 'Kenji Tanaka', 'Diagonal 45 # 54-18, Sabaneta', '055450', 'MASCULINO', '19680317', 'PROFESIONAL', 'INTP1815145', 'B1', '20290407', 'AL_DIA', '6012'),
	(91, 1, '1097741973', 'Natalia Ramirez Henao', 'Transversal 52 # 77-44, Medellin', '050022', 'FEMENINO', '19640611', 'BACHILLERATO', '1097741973', 'B1', '20361001', 'AL_DIA', '7030'),
	(92, 1, '1169797067', 'Juliana Ospina Gomez', 'Calle 108 # 35-93, Bello', '051052', 'FEMENINO', '19770610', 'BACHILLERATO', '1169797067', 'B1', '20360526', 'MOROSO', '8379'),
	(93, 1, '1198876809', 'Mariana Uribe Rendon', 'Transversal 62 # 95-15, Itagui', '055412', 'FEMENINO', '20040304', 'PRIMARIA', '1198876809', 'C1', '20350919', 'AL_DIA', '4808'),
	(94, 40, 'P7990498', 'Liam Smith', 'Circular 91 # 18-81, Medellin', '050026', 'MASCULINO', '19900405', 'PRIMARIA', 'INTP7990498', 'B1', '20310808', 'AL_DIA', '8159'),
	(95, 1, '1126396400', 'Felipe Rios Montoya', 'Carrera 109 # 67-17, Sabaneta', '055450', 'MASCULINO', '19780919', 'PROFESIONAL', '1126396400', 'B1', '20330807', 'AL_DIA', '2449'),
	(96, 1, '1195561619', 'Sofia Arango Posada', 'Diagonal 28 # 22-5, Medellin', '050021', 'FEMENINO', '19921113', 'POSGRADO', '1195561619', 'C1', '20260930', 'AL_DIA', '8292'),
	(97, 1, '1104662319', 'Luisa Posada Giraldo', 'Calle 51 # 13-72, Medellin', '050034', 'FEMENINO', '19910326', 'TECNICO', '1104662319', 'C1', '20361004', 'AL_DIA', '4856'),
	(98, 49, 'X6058723', 'Ji-woo Park', 'Calle 82 # 97-43, Sabaneta', '055450', 'FEMENINO', '19690905', 'TECNICO', 'INTX6058723', 'B1', '20270414', 'AL_DIA', '2194'),
	(99, 1, '1028148295', 'David Gonzalez Zapata', 'Carrera 43 # 59-72, Envigado', '055422', 'MASCULINO', '19730501', 'PROFESIONAL', '1028148295', 'A2', '20360102', 'AL_DIA', '9713'),
	(100, 1, '1079876375', 'Hernan Rodriguez Gonzalez', 'Carrera 37 # 30-12, Envigado', '055422', 'MASCULINO', '19741226', 'TECNICO', '1079876375', 'B1', '20271212', 'AL_DIA', '7674')
GO

SELECT * FROM CLIENTE  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----

/*
TABLA TELEFONO_CLIENTE: 100 FILAS
100 TELÉFONOS: 2 POR CLIENTE (EL CASO PIDE 2 TELÉFONOS). 10 DÍGITOS (FIJOS DE ANTIOQUIA EMPIEZAN POR 604).
*/

INSERT INTO TELEFONO_CLIENTE(
ID_CLIENTE, ID_TIPO_TELEFONO, NUMERO
)
VALUES(51, 1, '3190387588'),
	(51, 2, '6044580570'),
	(52, 1, '3242309950'),
	(52, 3, '3568344127'),
	(53, 1, '3175008791'),
	(53, 2, '6043749108'),
	(54, 1, '3569957967'),
	(54, 3, '3570275961'),
	(55, 1, '3199069044'),
	(55, 2, '6044915659'),
	(56, 1, '3552806335'),
	(56, 3, '3111485363'),
	(57, 1, '3149284340'),
	(57, 2, '6044261904'),
	(58, 1, '3258758232'),
	(58, 3, '3136157968'),
	(59, 1, '3516126235'),
	(59, 2, '6043080750'),
	(60, 1, '3011460160'),
	(60, 3, '3155421338'),
	(61, 1, '3576578923'),
	(61, 2, '6043426613'),
	(62, 1, '3599245853'),
	(62, 3, '3242687992'),
	(63, 1, '3123017104'),
	(63, 2, '6042836390'),
	(64, 1, '3089796829'),
	(64, 3, '3073400449'),
	(65, 1, '3552172653'),
	(65, 2, '6042426650'),
	(66, 1, '3542787452'),
	(66, 3, '3539544031'),
	(67, 1, '3525536233'),
	(67, 2, '6044251417'),
	(68, 1, '3287152146'),
	(68, 3, '3118987056'),
	(69, 1, '3054206123'),
	(69, 2, '6043587251'),
	(70, 1, '3053475241'),
	(70, 3, '3581798103'),
	(71, 1, '3013588470'),
	(71, 2, '6042666187'),
	(72, 1, '3540555222'),
	(72, 3, '3184589350'),
	(73, 1, '3053698385'),
	(73, 2, '6044776822'),
	(74, 1, '3131454791'),
	(74, 3, '3564315299'),
	(75, 1, '3589867651'),
	(75, 2, '6042213553'),
	(76, 1, '3192410616'),
	(76, 3, '3599471235'),
	(77, 1, '3563734499'),
	(77, 2, '6044792454'),
	(78, 1, '3059461327'),
	(78, 3, '3073363489'),
	(79, 1, '3257078565'),
	(79, 2, '6042446658'),
	(80, 1, '3539590654'),
	(80, 3, '3181673230'),
	(81, 1, '3071946708'),
	(81, 2, '6044846147'),
	(82, 1, '3597997127'),
	(82, 3, '3162958560'),
	(83, 1, '3051714291'),
	(83, 2, '6044650988'),
	(84, 1, '3538762779'),
	(84, 3, '3249221450'),
	(85, 1, '3134796587'),
	(85, 2, '6044799490'),
	(86, 1, '3160370489'),
	(86, 3, '3548602752'),
	(87, 1, '3517885810'),
	(87, 2, '6042546043'),
	(88, 1, '3193708728'),
	(88, 3, '3045203447'),
	(89, 1, '3263083636'),
	(89, 2, '6044682654'),
	(90, 1, '3111964547'),
	(90, 3, '3557016018'),
	(91, 1, '3136960557'),
	(91, 2, '6043520750'),
	(92, 1, '3071321183'),
	(92, 3, '3135023966'),
	(93, 1, '3534655440'),
	(93, 2, '6044336665'),
	(94, 1, '3214200566'),
	(94, 3, '3020482945'),
	(95, 1, '3242478045'),
	(95, 2, '6044961656'),
	(96, 1, '3215391959'),
	(96, 3, '3290332825'),
	(97, 1, '3257345627'),
	(97, 2, '6043093887'),
	(98, 1, '3288263077'),
	(98, 3, '3092566231'),
	(99, 1, '3236006941'),
	(99, 2, '6042301841'),
	(100, 1, '3264291939'),
	(100, 3, '3041522150')
GO

SELECT * FROM TELEFONO_CLIENTE  -- TOTAL REGISTROS 100
GO

---   -----          ------          -----


--  ======================================================
--  DATOS DE LA EMPRESA
--  ======================================================

/*
TABLA SEDE: 50 FILAS
50 FILAS: LA SEDE PRINCIPAL (ID 1) Y 49 PUNTOS DE RECOGIDA DEL ÁREA METROPOLITANA Y EL ORIENTE
(AEROPUERTOS, TERMINALES, CENTROS COMERCIALES). EL CASO PIDE ELEGIR LA "SEDE DE RECOGIDA" AL RESERVAR.
*/

INSERT INTO SEDE(
NOMBRE, DIRECCION, CIUDAD
)
VALUES('SEDE PRINCIPAL RENTA ITM', 'Carrera 65 # 98A-75 (Robledo)', 'MEDELLIN'),  -- ID 1
	('PUNTO AEROPUERTO JOSE MARIA CORDOVA', 'Vereda Sajonia, terminal nacional', 'RIONEGRO'),  -- ID 2
	('PUNTO AEROPUERTO OLAYA HERRERA', 'Carrera 65A # 13-157', 'MEDELLIN'),  -- ID 3
	('PUNTO TERMINAL DEL NORTE', 'Carrera 64C # 78-580', 'MEDELLIN'),  -- ID 4
	('PUNTO TERMINAL DEL SUR', 'Carrera 65 # 8B-91', 'MEDELLIN'),  -- ID 5
	('PUNTO CC SANTAFE', 'Carrera 43A # 7 Sur-170', 'MEDELLIN'),  -- ID 6
	('PUNTO CC EL TESORO', 'Carrera 25A # 1A Sur-45', 'MEDELLIN'),  -- ID 7
	('PUNTO CC OVIEDO', 'Carrera 43A # 6 Sur-15', 'MEDELLIN'),  -- ID 8
	('PUNTO CC SAN DIEGO', 'Calle 34 # 43-66', 'MEDELLIN'),  -- ID 9
	('PUNTO CC UNICENTRO', 'Carrera 66B # 34A-76', 'MEDELLIN'),  -- ID 10
	('PUNTO CC LOS MOLINOS', 'Calle 30A # 82A-26', 'MEDELLIN'),  -- ID 11
	('PUNTO CC PREMIUM PLAZA', 'Carrera 43A # 30-25', 'MEDELLIN'),  -- ID 12
	('PUNTO CC MAYORCA', 'Calle 51 Sur # 48-57', 'SABANETA'),  -- ID 13
	('PUNTO CC VIVA ENVIGADO', 'Carrera 48 # 32B Sur-139', 'ENVIGADO'),  -- ID 14
	('PUNTO CC CITY PLAZA', 'Calle 36D Sur # 27-160', 'ENVIGADO'),  -- ID 15
	('PUNTO CC PUERTA DEL NORTE', 'Diagonal 55 # 34-67', 'BELLO'),  -- ID 16
	('PUNTO CC PARQUE FABRICATO', 'Carrera 50 # 38A-185', 'BELLO'),  -- ID 17
	('PUNTO CC ARKADIA', 'Carrera 70 # 1-141', 'MEDELLIN'),  -- ID 18
	('PUNTO CC CAMINO REAL', 'Carrera 52 # 49-26', 'MEDELLIN'),  -- ID 19
	('PUNTO CC LA STRADA', 'Carrera 43A # 1A Sur-29', 'MEDELLIN'),  -- ID 20
	('PUNTO CC SAN NICOLAS', 'Calle 43 # 54-139', 'RIONEGRO'),  -- ID 21
	('PUNTO ESTACION METRO POBLADO', 'Calle 10 # 46-10', 'MEDELLIN'),  -- ID 22
	('PUNTO ESTACION METRO ESTADIO', 'Carrera 70 # 48-20', 'MEDELLIN'),  -- ID 23
	('PUNTO ESTACION METRO ITAGUI', 'Carrera 50 # 46-01', 'ITAGUI'),  -- ID 24
	('PUNTO ESTACION METRO NIQUIA', 'Carrera 64 # 79-40', 'BELLO'),  -- ID 25
	('PUNTO ESTACION METRO ENVIGADO', 'Calle 37 Sur # 48-30', 'ENVIGADO'),  -- ID 26
	('PUNTO ESTACION METRO SAN ANTONIO', 'Carrera 49 # 45-20', 'MEDELLIN'),  -- ID 27
	('PUNTO PARQUE LLERAS', 'Carrera 37A # 8A-10', 'MEDELLIN'),  -- ID 28
	('PUNTO PARQUE DE ENVIGADO', 'Carrera 43 # 38 Sur-35', 'ENVIGADO'),  -- ID 29
	('PUNTO PARQUE DE SABANETA', 'Carrera 45 # 70 Sur-20', 'SABANETA'),  -- ID 30
	('PUNTO PARQUE DE BELLO', 'Carrera 50 # 50-12', 'BELLO'),  -- ID 31
	('PUNTO PARQUE DE ITAGUI', 'Carrera 51 # 51-30', 'ITAGUI'),  -- ID 32
	('PUNTO PARQUE DE LA ESTRELLA', 'Carrera 60 # 80 Sur-15', 'LA ESTRELLA'),  -- ID 33
	('PUNTO PARQUE DE COPACABANA', 'Carrera 50 # 50-05', 'COPACABANA'),  -- ID 34
	('PUNTO PARQUE DE CALDAS', 'Carrera 49 # 129 Sur-10', 'CALDAS'),  -- ID 35
	('PUNTO PARQUE DE GIRARDOTA', 'Carrera 15 # 7-20', 'GIRARDOTA'),  -- ID 36
	('PUNTO PARQUE DE LA CEJA', 'Carrera 20 # 19-50', 'LA CEJA'),  -- ID 37
	('PUNTO PARQUE DE EL RETIRO', 'Carrera 20 # 20-10', 'EL RETIRO'),  -- ID 38
	('PUNTO PARQUE DE GUATAPE', 'Calle 31 # 28-05', 'GUATAPE'),  -- ID 39
	('PUNTO PARQUE DE SANTA FE DE ANTIOQUIA', 'Calle 10 # 9-50', 'SANTA FE DE ANTIOQUIA'),  -- ID 40
	('PUNTO PARQUE DE MARINILLA', 'Carrera 30 # 29-40', 'MARINILLA'),  -- ID 41
	('PUNTO PARQUE DE EL CARMEN', 'Calle 31 # 30-10', 'EL CARMEN DE VIBORAL'),  -- ID 42
	('PUNTO PLAZA MAYOR', 'Calle 41 # 55-80', 'MEDELLIN'),  -- ID 43
	('PUNTO CENTRO INTERNACIONAL DE CONVENCIONES', 'Calle 47 # 55-50', 'MEDELLIN'),  -- ID 44
	('PUNTO MILLA DE ORO', 'Carrera 43A # 5A-113', 'MEDELLIN'),  -- ID 45
	('PUNTO LAURELES (CIRCULAR 1)', 'Circular 1 # 70-01', 'MEDELLIN'),  -- ID 46
	('PUNTO BELEN (PARQUE)', 'Carrera 76 # 30A-20', 'MEDELLIN'),  -- ID 47
	('PUNTO CIUDAD DEL RIO', 'Calle 20 # 43G-25', 'MEDELLIN'),  -- ID 48
	('PUNTO ITM CAMPUS ROBLEDO', 'Calle 73 # 76A-354', 'MEDELLIN'),  -- ID 49
	('PUNTO ITM CAMPUS FRAGUA', 'Calle 54A # 30-01', 'MEDELLIN')  -- ID 50
GO

SELECT * FROM SEDE  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----

/*
TABLA POLIZA: 3 FILAS
CATÁLOGO CERRADO (3 FILAS): EL CASO DEFINE EXACTAMENTE BÁSICA, INTERMEDIA (TERCEROS HASTA 500 MILLONES)
Y PREMIUM (CUBRIMIENTO TOTAL). MÁS FILAS ROMPERÍAN LA REGLA DE NEGOCIO Y EL CHECK CK_POLIZA_NOMBRE.
*/

INSERT INTO POLIZA(
NOMBRE, COBERTURA_MAXIMA, VALOR_DIA
)
VALUES('BASICA', 100000000.00, 25000.00),  -- ID 1
	('INTERMEDIA', 500000000.00, 45000.00),  -- ID 2
	('PREMIUM', 2000000000.00, 80000.00)  -- ID 3
GO

SELECT * FROM POLIZA  -- TOTAL REGISTROS 3
GO

---   -----          ------          -----

/*
TABLA MODALIDAD: 2 FILAS
CATÁLOGO CERRADO (2 FILAS): POR KILOMETRAJE (SIN LÍMITE) O POR DÍA (LÍMITE DE 200 KM/DÍA).
*/

INSERT INTO MODALIDAD(
NOMBRE, KM_LIMITE_DIA
)
VALUES('POR_KILOMETRAJE', NULL),  -- ID 1
	('POR_DIA', 200)  -- ID 2
GO

SELECT * FROM MODALIDAD  -- TOTAL REGISTROS 2
GO

---   -----          ------          -----

/*
TABLA TARIFA: 54 FILAS
54 TARIFAS = 2 MODALIDADES X 3 GAMAS X 9 RANGOS DE 10.000 KM.
REGLA: BASE POR GAMA (BAJA 120.000, MEDIA 180.000, ALTA 300.000), -3 % POR CADA RANGO DE KM,
Y +35 % EN LA MODALIDAD POR_KILOMETRAJE (PORQUE NO TIENE LÍMITE DE KM). EL ÚLTIMO RANGO NO TIENE TOPE (KM_MAX NULL).
*/

INSERT INTO TARIFA(
ID_MODALIDAD, GAMA, KM_MIN, KM_MAX, VALOR_DIA
)
VALUES(1, 'BAJA', 0, 9999, 162000.00),  -- ID 1
	(1, 'BAJA', 10000, 19999, 157100.00),  -- ID 2
	(1, 'BAJA', 20000, 29999, 152300.00),  -- ID 3
	(1, 'BAJA', 30000, 39999, 147400.00),  -- ID 4
	(1, 'BAJA', 40000, 49999, 142600.00),  -- ID 5
	(1, 'BAJA', 50000, 59999, 137700.00),  -- ID 6
	(1, 'BAJA', 60000, 69999, 132800.00),  -- ID 7
	(1, 'BAJA', 70000, 79999, 128000.00),  -- ID 8
	(1, 'BAJA', 80000, NULL, 123100.00),  -- ID 9
	(1, 'MEDIA', 0, 9999, 243000.00),  -- ID 10
	(1, 'MEDIA', 10000, 19999, 235700.00),  -- ID 11
	(1, 'MEDIA', 20000, 29999, 228400.00),  -- ID 12
	(1, 'MEDIA', 30000, 39999, 221100.00),  -- ID 13
	(1, 'MEDIA', 40000, 49999, 213800.00),  -- ID 14
	(1, 'MEDIA', 50000, 59999, 206600.00),  -- ID 15
	(1, 'MEDIA', 60000, 69999, 199300.00),  -- ID 16
	(1, 'MEDIA', 70000, 79999, 192000.00),  -- ID 17
	(1, 'MEDIA', 80000, NULL, 184700.00),  -- ID 18
	(1, 'ALTA', 0, 9999, 405000.00),  -- ID 19
	(1, 'ALTA', 10000, 19999, 392800.00),  -- ID 20
	(1, 'ALTA', 20000, 29999, 380700.00),  -- ID 21
	(1, 'ALTA', 30000, 39999, 368600.00),  -- ID 22
	(1, 'ALTA', 40000, 49999, 356400.00),  -- ID 23
	(1, 'ALTA', 50000, 59999, 344200.00),  -- ID 24
	(1, 'ALTA', 60000, 69999, 332100.00),  -- ID 25
	(1, 'ALTA', 70000, 79999, 320000.00),  -- ID 26
	(1, 'ALTA', 80000, NULL, 307800.00),  -- ID 27
	(2, 'BAJA', 0, 9999, 120000.00),  -- ID 28
	(2, 'BAJA', 10000, 19999, 116400.00),  -- ID 29
	(2, 'BAJA', 20000, 29999, 112800.00),  -- ID 30
	(2, 'BAJA', 30000, 39999, 109200.00),  -- ID 31
	(2, 'BAJA', 40000, 49999, 105600.00),  -- ID 32
	(2, 'BAJA', 50000, 59999, 102000.00),  -- ID 33
	(2, 'BAJA', 60000, 69999, 98400.00),  -- ID 34
	(2, 'BAJA', 70000, 79999, 94800.00),  -- ID 35
	(2, 'BAJA', 80000, NULL, 91200.00),  -- ID 36
	(2, 'MEDIA', 0, 9999, 180000.00),  -- ID 37
	(2, 'MEDIA', 10000, 19999, 174600.00),  -- ID 38
	(2, 'MEDIA', 20000, 29999, 169200.00),  -- ID 39
	(2, 'MEDIA', 30000, 39999, 163800.00),  -- ID 40
	(2, 'MEDIA', 40000, 49999, 158400.00),  -- ID 41
	(2, 'MEDIA', 50000, 59999, 153000.00),  -- ID 42
	(2, 'MEDIA', 60000, 69999, 147600.00),  -- ID 43
	(2, 'MEDIA', 70000, 79999, 142200.00),  -- ID 44
	(2, 'MEDIA', 80000, NULL, 136800.00),  -- ID 45
	(2, 'ALTA', 0, 9999, 300000.00),  -- ID 46
	(2, 'ALTA', 10000, 19999, 291000.00),  -- ID 47
	(2, 'ALTA', 20000, 29999, 282000.00),  -- ID 48
	(2, 'ALTA', 30000, 39999, 273000.00),  -- ID 49
	(2, 'ALTA', 40000, 49999, 264000.00),  -- ID 50
	(2, 'ALTA', 50000, 59999, 255000.00),  -- ID 51
	(2, 'ALTA', 60000, 69999, 246000.00),  -- ID 52
	(2, 'ALTA', 70000, 79999, 237000.00),  -- ID 53
	(2, 'ALTA', 80000, NULL, 228000.00)  -- ID 54
GO

SELECT * FROM TARIFA  -- TOTAL REGISTROS 54
GO

---   -----          ------          -----

/*
TABLA CONVENIO: 50 FILAS
50 EMPRESAS FICTICIAS CON DESCUENTO ENTRE 5 % Y 10 % (CHECK).
*/

INSERT INTO CONVENIO(
ID_TIPO_EMPRESA, EMPRESA, PORCENTAJE_DESCUENTO
)
VALUES(1, 'Seguros Andina S.A.S.', 5.00),  -- ID 1
	(2, 'Banco Cordillera S.A.S.', 6.00),  -- ID 2
	(3, 'Cooperativa Valle de Aburra S.A.S.', 7.00),  -- ID 3
	(4, 'Fondo Empleados Nutibara S.A.S.', 7.50),  -- ID 4
	(5, 'Caja Compensacion Guayacan S.A.S.', 8.00),  -- ID 5
	(6, 'Universidad Orquidea S.A.S.', 9.00),  -- ID 6
	(8, 'Clinica Montana Verde S.A.S.', 10.00),  -- ID 7
	(10, 'Aerolinea Rio Medellin S.A.S.', 5.00),  -- ID 8
	(11, 'Viajes Altavista S.A.S.', 6.00),  -- ID 9
	(12, 'Hotel Palmas S.A.S.', 7.00),  -- ID 10
	(13, 'Constructora Santa Elena S.A.S.', 7.50),  -- ID 11
	(16, 'Energia Cerro Azul S.A.S.', 8.00),  -- ID 12
	(17, 'Telecom Arrieros S.A.S.', 9.00),  -- ID 13
	(18, 'Software Silleteros S.A.S.', 10.00),  -- ID 14
	(19, 'Consultores Pueblito Paisa S.A.S.', 5.00),  -- ID 15
	(21, 'Logistica Guatape S.A.S.', 6.00),  -- ID 16
	(23, 'Laboratorios Piedra del Penol S.A.S.', 7.00),  -- ID 17
	(24, 'Alimentos Sabana S.A.S.', 7.50),  -- ID 18
	(27, 'Autopartes Horizonte S.A.S.', 8.00),  -- ID 19
	(28, 'Instituto Brisas S.A.S.', 9.00),  -- ID 20
	(31, 'Eventos Nevado S.A.S.', 10.00),  -- ID 21
	(34, 'Agroindustrial Llanogrande S.A.S.', 5.00),  -- ID 22
	(36, 'Cafe Aguacatala S.A.S.', 6.00),  -- ID 23
	(37, 'Inmobiliaria Poblado S.A.S.', 7.00),  -- ID 24
	(42, 'Tecnologia Laureles S.A.S.', 7.50),  -- ID 25
	(1, 'Seguros Estadio S.A.S.', 8.00),  -- ID 26
	(2, 'Banco Robledo S.A.S.', 9.00),  -- ID 27
	(3, 'Cooperativa Prado S.A.S.', 10.00),  -- ID 28
	(4, 'Fondo Empleados Envigado S.A.S.', 5.00),  -- ID 29
	(5, 'Caja Compensacion Itagui S.A.S.', 6.00),  -- ID 30
	(6, 'Universidad Bello S.A.S.', 7.00),  -- ID 31
	(8, 'Clinica Caldas S.A.S.', 7.50),  -- ID 32
	(10, 'Aerolinea La Estrella S.A.S.', 8.00),  -- ID 33
	(11, 'Viajes Copacabana S.A.S.', 9.00),  -- ID 34
	(12, 'Hotel Girardota S.A.S.', 10.00),  -- ID 35
	(13, 'Constructora Barbosa S.A.S.', 5.00),  -- ID 36
	(16, 'Energia Rionegro S.A.S.', 6.00),  -- ID 37
	(17, 'Telecom Marinilla S.A.S.', 7.00),  -- ID 38
	(18, 'Software El Retiro S.A.S.', 7.50),  -- ID 39
	(19, 'Consultores La Ceja S.A.S.', 8.00),  -- ID 40
	(21, 'Logistica Jardin S.A.S.', 9.00),  -- ID 41
	(23, 'Laboratorios Jerico S.A.S.', 10.00),  -- ID 42
	(24, 'Alimentos Urrao S.A.S.', 5.00),  -- ID 43
	(27, 'Autopartes Fredonia S.A.S.', 6.00),  -- ID 44
	(28, 'Instituto Amaga S.A.S.', 7.00),  -- ID 45
	(31, 'Eventos Titiribi S.A.S.', 7.50),  -- ID 46
	(34, 'Agroindustrial Concordia S.A.S.', 8.00),  -- ID 47
	(36, 'Cafe Betulia S.A.S.', 9.00),  -- ID 48
	(37, 'Inmobiliaria Salgar S.A.S.', 10.00),  -- ID 49
	(42, 'Tecnologia Sopetran S.A.S.', 5.00)  -- ID 50
GO

SELECT * FROM CONVENIO  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----


--  ======================================================
--  VEHICULOS Y HOJA DE VIDA
--  ======================================================

/*
TABLA MARCA: 50 FILAS
50 MARCAS. SOLO 28 TIENEN MODELOS REGISTRADOS: LAS DEMÁS SIRVEN PARA RIGHT/FULL JOIN Y CONJUNTOS (EXCEPT).
*/

INSERT INTO MARCA(
NOMBRE
)
VALUES('CHEVROLET'),  -- ID 1
	('RENAULT'),  -- ID 2
	('MAZDA'),  -- ID 3
	('KIA'),  -- ID 4
	('HYUNDAI'),  -- ID 5
	('TOYOTA'),  -- ID 6
	('NISSAN'),  -- ID 7
	('VOLKSWAGEN'),  -- ID 8
	('FORD'),  -- ID 9
	('SUZUKI'),  -- ID 10
	('MITSUBISHI'),  -- ID 11
	('HONDA'),  -- ID 12
	('BMW'),  -- ID 13
	('MERCEDES-BENZ'),  -- ID 14
	('AUDI'),  -- ID 15
	('PEUGEOT'),  -- ID 16
	('CITROEN'),  -- ID 17
	('FIAT'),  -- ID 18
	('JEEP'),  -- ID 19
	('DODGE'),  -- ID 20
	('RAM'),  -- ID 21
	('CHERY'),  -- ID 22
	('JAC'),  -- ID 23
	('BYD'),  -- ID 24
	('GREAT WALL'),  -- ID 25
	('MG'),  -- ID 26
	('SUBARU'),  -- ID 27
	('VOLVO'),  -- ID 28
	('LAND ROVER'),  -- ID 29
	('JAGUAR'),  -- ID 30
	('PORSCHE'),  -- ID 31
	('LEXUS'),  -- ID 32
	('MINI'),  -- ID 33
	('SEAT'),  -- ID 34
	('SKODA'),  -- ID 35
	('OPEL'),  -- ID 36
	('DS'),  -- ID 37
	('CHANGAN'),  -- ID 38
	('FOTON'),  -- ID 39
	('JMC'),  -- ID 40
	('DONGFENG'),  -- ID 41
	('GEELY'),  -- ID 42
	('SSANGYONG'),  -- ID 43
	('ISUZU'),  -- ID 44
	('HINO'),  -- ID 45
	('TESLA'),  -- ID 46
	('ALFA ROMEO'),  -- ID 47
	('CUPRA'),  -- ID 48
	('GAC'),  -- ID 49
	('ZEEKR')  -- ID 50
GO

SELECT * FROM MARCA  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----

/*
TABLA MODELO: 60 FILAS
60 MODELOS, CADA UNO DE UNA SOLA MARCA (3FN).
*/

INSERT INTO MODELO(
ID_MARCA, NOMBRE
)
VALUES(1, 'SPARK GT'),  -- ID 1
	(1, 'ONIX'),  -- ID 2
	(1, 'TRACKER'),  -- ID 3
	(1, 'N400 MAX'),  -- ID 4
	(2, 'KWID'),  -- ID 5
	(2, 'LOGAN'),  -- ID 6
	(2, 'SANDERO'),  -- ID 7
	(2, 'DUSTER'),  -- ID 8
	(2, 'KWID E-TECH'),  -- ID 9
	(2, 'MASTER'),  -- ID 10
	(3, 'MAZDA 2'),  -- ID 11
	(3, 'MAZDA 3'),  -- ID 12
	(3, 'CX-30'),  -- ID 13
	(3, 'CX-5'),  -- ID 14
	(4, 'PICANTO'),  -- ID 15
	(4, 'SOLUTO'),  -- ID 16
	(4, 'SPORTAGE'),  -- ID 17
	(4, 'NIRO HEV'),  -- ID 18
	(5, 'GRAND I10'),  -- ID 19
	(5, 'TUCSON'),  -- ID 20
	(5, 'H1'),  -- ID 21
	(5, 'CRETA'),  -- ID 22
	(6, 'COROLLA CROSS HEV'),  -- ID 23
	(6, 'HILUX'),  -- ID 24
	(6, 'FORTUNER'),  -- ID 25
	(6, 'YARIS'),  -- ID 26
	(7, 'VERSA'),  -- ID 27
	(7, 'KICKS'),  -- ID 28
	(7, 'FRONTIER'),  -- ID 29
	(8, 'GOL'),  -- ID 30
	(8, 'T-CROSS'),  -- ID 31
	(9, 'RANGER'),  -- ID 32
	(9, 'ESCAPE HEV'),  -- ID 33
	(10, 'SWIFT'),  -- ID 34
	(10, 'VITARA'),  -- ID 35
	(11, 'L200'),  -- ID 36
	(11, 'OUTLANDER'),  -- ID 37
	(13, 'X1'),  -- ID 38
	(14, 'SPRINTER'),  -- ID 39
	(14, 'CLASE GLA'),  -- ID 40
	(15, 'Q3'),  -- ID 41
	(16, '208'),  -- ID 42
	(16, '3008'),  -- ID 43
	(19, 'COMPASS'),  -- ID 44
	(19, 'RENEGADE'),  -- ID 45
	(22, 'TIGGO 2'),  -- ID 46
	(23, 'SUNRAY'),  -- ID 47
	(24, 'DOLPHIN'),  -- ID 48
	(24, 'YUAN PLUS'),  -- ID 49
	(24, 'SONG PLUS DM-I'),  -- ID 50
	(26, 'ZS'),  -- ID 51
	(27, 'FORESTER'),  -- ID 52
	(28, 'XC40 RECHARGE'),  -- ID 53
	(39, 'VIEW CS2'),  -- ID 54
	(25, 'POER'),  -- ID 55
	(46, 'MODEL 3'),  -- ID 56
	(12, 'HR-V'),  -- ID 57
	(12, 'CR-V'),  -- ID 58
	(18, 'MOBI'),  -- ID 59
	(17, 'C3')  -- ID 60
GO

SELECT * FROM MODELO  -- TOTAL REGISTROS 60
GO

---   -----          ------          -----

/*
TABLA VEHICULO: 60 FILAS
60 VEHÍCULOS. 54 DE LA FLOTA Y 6 DE STOCK DE RESPALDO (ES_RESPALDO = 1, IDS 55-60): NUNCA SE RESERVAN.
ESTADOS DE HOY (10-NOV-2026): RESERVADO = TIENEN RESERVA FUTURA; EN_MANTENIMIENTO Y FUERA_DE_SERVICIO
COINCIDEN CON SU HOJA DE VIDA. KILOMETRAJE = ODÓMETRO DESPUÉS DEL ÚLTIMO ALQUILER.
CATEGORÍA DE LICENCIA: B1 = AUTOMÓVILES Y CAMIONETAS; B2 = VANS DE 16 PASAJEROS.
*/

INSERT INTO VEHICULO(
ID_MODELO, PLACA, GAMA, CATEGORIA_LICENCIA, CAPACIDAD, KILOMETRAJE, COLOR, CONSUMO, COMBUSTIBLE, PUERTAS, TRANSMISION, ES_RESPALDO, ESTADO
)
VALUES(1, 'WGU959', 'BAJA', 'B1', 5, 28714, 'BEIGE', 18.50, 'GASOLINA', 5, 'MANUAL', 0, 'DISPONIBLE'),  -- ID 1
	(2, 'LGT435', 'BAJA', 'B1', 5, 42756, 'PLATA', 17.00, 'GASOLINA', 4, 'AUTOMATICA', 0, 'RESERVADO'),  -- ID 2
	(3, 'TTN646', 'MEDIA', 'B1', 5, 8680, 'GRIS', 15.20, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 3
	(4, 'YUP847', 'MEDIA', 'B1', 7, 33759, 'VERDE OSCURO', 13.50, 'GASOLINA', 5, 'MANUAL', 0, 'DISPONIBLE'),  -- ID 4
	(5, 'GUX608', 'BAJA', 'B1', 5, 42361, 'VINOTINTO', 19.00, 'GASOLINA', 5, 'MANUAL', 0, 'RESERVADO'),  -- ID 5
	(6, 'FGH370', 'BAJA', 'B1', 5, 3777, 'NEGRO', 16.50, 'GAS', 4, 'MANUAL', 0, 'EN_MANTENIMIENTO'),  -- ID 6
	(7, 'KRC183', 'BAJA', 'B1', 5, 12252, 'GRIS', 16.00, 'GASOLINA', 5, 'MANUAL', 0, 'DISPONIBLE'),  -- ID 7
	(8, 'WIR285', 'MEDIA', 'B1', 5, 26472, 'NEGRO', 13.80, 'GASOLINA', 5, 'AUTOMATICA', 0, 'RESERVADO'),  -- ID 8
	(9, 'TPO185', 'BAJA', 'B1', 4, 19059, 'NARANJA', 7.50, 'ELECTRICO', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 9
	(10, 'BDJ462', 'MEDIA', 'B2', 16, 24307, 'GRIS', 9.50, 'DIESEL', 4, 'MANUAL', 0, 'EN_MANTENIMIENTO'),  -- ID 10
	(11, 'ZRK239', 'MEDIA', 'B1', 5, 35490, 'NEGRO', 17.50, 'GASOLINA', 4, 'MANUAL', 0, 'RESERVADO'),  -- ID 11
	(12, 'CUK707', 'MEDIA', 'B1', 5, 7968, 'BLANCO', 15.50, 'GASOLINA', 4, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 12
	(13, 'BPH869', 'MEDIA', 'B1', 5, 21924, 'PLATA', 14.80, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 13
	(14, 'NGY577', 'ALTA', 'B1', 5, 41389, 'PLATA', 13.00, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 14
	(15, 'BYJ103', 'BAJA', 'B1', 5, 23641, 'ROJO', 18.00, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 15
	(16, 'OGS756', 'BAJA', 'B1', 5, 30493, 'AZUL', 16.80, 'GASOLINA', 4, 'MANUAL', 0, 'DISPONIBLE'),  -- ID 16
	(17, 'CBP791', 'ALTA', 'B1', 5, 12499, 'BLANCO', 12.80, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 17
	(18, 'DOD997', 'MEDIA', 'B1', 5, 13306, 'BLANCO', 22.00, 'HIBRIDO', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 18
	(19, 'SUF980', 'BAJA', 'B1', 5, 3772, 'NARANJA', 17.80, 'GASOLINA', 4, 'MANUAL', 0, 'DISPONIBLE'),  -- ID 19
	(20, 'YCX999', 'ALTA', 'B1', 5, 43339, 'BEIGE', 12.50, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 20
	(21, 'GIL834', 'MEDIA', 'B1', 12, 5477, 'VERDE OSCURO', 10.50, 'DIESEL', 4, 'MANUAL', 0, 'FUERA_DE_SERVICIO'),  -- ID 21
	(22, 'PDC202', 'MEDIA', 'B1', 5, 34904, 'VINOTINTO', 14.50, 'GASOLINA', 5, 'MANUAL', 0, 'RESERVADO'),  -- ID 22
	(23, 'XXI814', 'ALTA', 'B1', 5, 27529, 'PLATA', 21.00, 'HIBRIDO', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 23
	(24, 'EDN711', 'ALTA', 'B1', 5, 16086, 'PLATA', 11.00, 'DIESEL', 4, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 24
	(25, 'UEH901', 'ALTA', 'B1', 7, 23691, 'GRIS', 10.80, 'DIESEL', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 25
	(26, 'TRU337', 'MEDIA', 'B1', 5, 44740, 'GRIS', 17.20, 'GASOLINA', 4, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 26
	(27, 'CGN612', 'MEDIA', 'B1', 5, 30644, 'BLANCO', 16.00, 'GASOLINA', 4, 'AUTOMATICA', 0, 'RESERVADO'),  -- ID 27
	(28, 'CTM177', 'MEDIA', 'B1', 5, 4562, 'AZUL', 15.00, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 28
	(29, 'RYU533', 'ALTA', 'B1', 5, 34579, 'VERDE OSCURO', 10.50, 'DIESEL', 4, 'MANUAL', 0, 'DISPONIBLE'),  -- ID 29
	(30, 'NJS195', 'BAJA', 'B1', 5, 10686, 'PLATA', 16.20, 'GASOLINA', 5, 'MANUAL', 0, 'EN_MANTENIMIENTO'),  -- ID 30
	(31, 'IJC157', 'MEDIA', 'B1', 5, 40140, 'ROJO', 15.00, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 31
	(32, 'SXK454', 'ALTA', 'B1', 5, 40567, 'ROJO', 10.00, 'DIESEL', 4, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 32
	(33, 'DNS568', 'ALTA', 'B1', 5, 27679, 'BEIGE', 19.50, 'HIBRIDO', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 33
	(34, 'NVS419', 'BAJA', 'B1', 5, 23062, 'VINOTINTO', 18.80, 'GASOLINA', 5, 'MANUAL', 0, 'DISPONIBLE'),  -- ID 34
	(35, 'WDB101', 'MEDIA', 'B1', 5, 28841, 'BEIGE', 15.50, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 35
	(36, 'IMZ797', 'ALTA', 'B1', 5, 30511, 'BLANCO', 10.20, 'DIESEL', 4, 'MANUAL', 0, 'DISPONIBLE'),  -- ID 36
	(37, 'NFB726', 'ALTA', 'B1', 7, 11342, 'NARANJA', 12.00, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 37
	(38, 'IHH527', 'ALTA', 'B1', 5, 14675, 'GRIS', 13.50, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 38
	(39, 'JFO543', 'ALTA', 'B2', 16, 40998, 'GRIS', 9.00, 'DIESEL', 4, 'MANUAL', 0, 'DISPONIBLE'),  -- ID 39
	(40, 'UIS719', 'ALTA', 'B1', 5, 6770, 'PLATA', 13.20, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 40
	(41, 'VNW958', 'ALTA', 'B1', 5, 24851, 'VERDE OSCURO', 13.00, 'GASOLINA', 5, 'AUTOMATICA', 0, 'RESERVADO'),  -- ID 41
	(42, 'ESW865', 'MEDIA', 'B1', 5, 22714, 'ROJO', 16.50, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 42
	(43, 'CRX936', 'ALTA', 'B1', 5, 23911, 'VERDE OSCURO', 13.80, 'GASOLINA', 5, 'AUTOMATICA', 0, 'RESERVADO'),  -- ID 43
	(44, 'IBH764', 'ALTA', 'B1', 5, 35009, 'GRIS', 12.00, 'GASOLINA', 5, 'AUTOMATICA', 0, 'EN_MANTENIMIENTO'),  -- ID 44
	(45, 'SBD470', 'MEDIA', 'B1', 5, 34624, 'BEIGE', 13.00, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 45
	(46, 'BOZ648', 'BAJA', 'B1', 5, 32334, 'BEIGE', 15.00, 'GASOLINA', 5, 'MANUAL', 0, 'DISPONIBLE'),  -- ID 46
	(47, 'LRU631', 'MEDIA', 'B2', 16, 16083, 'VINOTINTO', 9.80, 'DIESEL', 4, 'MANUAL', 0, 'DISPONIBLE'),  -- ID 47
	(48, 'LRW225', 'MEDIA', 'B1', 5, 11546, 'NARANJA', 7.00, 'ELECTRICO', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 48
	(49, 'YGO646', 'ALTA', 'B1', 5, 39113, 'GRIS', 6.50, 'ELECTRICO', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 49
	(50, 'FMV277', 'ALTA', 'B1', 5, 45702, 'AZUL', 20.00, 'HIBRIDO', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 50
	(51, 'EHT913', 'MEDIA', 'B1', 5, 7272, 'VINOTINTO', 14.50, 'GASOLINA', 5, 'MANUAL', 0, 'DISPONIBLE'),  -- ID 51
	(52, 'MYT184', 'ALTA', 'B1', 5, 22445, 'NEGRO', 12.50, 'GASOLINA', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 52
	(53, 'TIL388', 'ALTA', 'B1', 5, 37136, 'AZUL', 6.00, 'ELECTRICO', 5, 'AUTOMATICA', 0, 'DISPONIBLE'),  -- ID 53
	(54, 'SBC234', 'MEDIA', 'B2', 16, 25197, 'NEGRO', 10.00, 'DIESEL', 4, 'MANUAL', 0, 'DISPONIBLE'),  -- ID 54
	(55, 'NUF659', 'ALTA', 'B1', 5, 8467, 'VERDE OSCURO', 10.50, 'DIESEL', 4, 'MANUAL', 1, 'DISPONIBLE'),  -- ID 55
	(56, 'RGF377', 'ALTA', 'B1', 5, 36714, 'AZUL', 7.20, 'ELECTRICO', 4, 'AUTOMATICA', 1, 'DISPONIBLE'),  -- ID 56
	(57, 'PZJ867', 'MEDIA', 'B1', 5, 12792, 'PLATA', 15.80, 'GASOLINA', 5, 'AUTOMATICA', 1, 'DISPONIBLE'),  -- ID 57
	(58, 'OKR985', 'ALTA', 'B1', 5, 8373, 'BLANCO', 13.50, 'GASOLINA', 5, 'AUTOMATICA', 1, 'DISPONIBLE'),  -- ID 58
	(59, 'UBU682', 'BAJA', 'B1', 4, 7099, 'NEGRO', 18.00, 'GASOLINA', 5, 'MANUAL', 1, 'DISPONIBLE'),  -- ID 59
	(60, 'GYF173', 'BAJA', 'B1', 5, 6148, 'GRIS', 16.00, 'GASOLINA', 5, 'MANUAL', 1, 'DISPONIBLE')  -- ID 60
GO

SELECT * FROM VEHICULO  -- TOTAL REGISTROS 60
GO

---   -----          ------          -----

/*
TABLA MULTIMEDIA_VEHICULO: 95 FILAS
95 ARCHIVOS: FOTO FRONTAL DE LOS 60 VEHÍCULOS + 20 VIDEOS 360 + 15 FOTOS DEL TABLERO.
*/

INSERT INTO MULTIMEDIA_VEHICULO(
ID_VEHICULO, ID_TIPO_MULTIMEDIA, URL
)
VALUES(1, 1, 'https://media.rentaitm.example/vehiculos/WGU959/frontal.jpg'),
	(2, 1, 'https://media.rentaitm.example/vehiculos/LGT435/frontal.jpg'),
	(3, 1, 'https://media.rentaitm.example/vehiculos/TTN646/frontal.jpg'),
	(4, 1, 'https://media.rentaitm.example/vehiculos/YUP847/frontal.jpg'),
	(5, 1, 'https://media.rentaitm.example/vehiculos/GUX608/frontal.jpg'),
	(6, 1, 'https://media.rentaitm.example/vehiculos/FGH370/frontal.jpg'),
	(7, 1, 'https://media.rentaitm.example/vehiculos/KRC183/frontal.jpg'),
	(8, 1, 'https://media.rentaitm.example/vehiculos/WIR285/frontal.jpg'),
	(9, 1, 'https://media.rentaitm.example/vehiculos/TPO185/frontal.jpg'),
	(10, 1, 'https://media.rentaitm.example/vehiculos/BDJ462/frontal.jpg'),
	(11, 1, 'https://media.rentaitm.example/vehiculos/ZRK239/frontal.jpg'),
	(12, 1, 'https://media.rentaitm.example/vehiculos/CUK707/frontal.jpg'),
	(13, 1, 'https://media.rentaitm.example/vehiculos/BPH869/frontal.jpg'),
	(14, 1, 'https://media.rentaitm.example/vehiculos/NGY577/frontal.jpg'),
	(15, 1, 'https://media.rentaitm.example/vehiculos/BYJ103/frontal.jpg'),
	(16, 1, 'https://media.rentaitm.example/vehiculos/OGS756/frontal.jpg'),
	(17, 1, 'https://media.rentaitm.example/vehiculos/CBP791/frontal.jpg'),
	(18, 1, 'https://media.rentaitm.example/vehiculos/DOD997/frontal.jpg'),
	(19, 1, 'https://media.rentaitm.example/vehiculos/SUF980/frontal.jpg'),
	(20, 1, 'https://media.rentaitm.example/vehiculos/YCX999/frontal.jpg'),
	(21, 1, 'https://media.rentaitm.example/vehiculos/GIL834/frontal.jpg'),
	(22, 1, 'https://media.rentaitm.example/vehiculos/PDC202/frontal.jpg'),
	(23, 1, 'https://media.rentaitm.example/vehiculos/XXI814/frontal.jpg'),
	(24, 1, 'https://media.rentaitm.example/vehiculos/EDN711/frontal.jpg'),
	(25, 1, 'https://media.rentaitm.example/vehiculos/UEH901/frontal.jpg'),
	(26, 1, 'https://media.rentaitm.example/vehiculos/TRU337/frontal.jpg'),
	(27, 1, 'https://media.rentaitm.example/vehiculos/CGN612/frontal.jpg'),
	(28, 1, 'https://media.rentaitm.example/vehiculos/CTM177/frontal.jpg'),
	(29, 1, 'https://media.rentaitm.example/vehiculos/RYU533/frontal.jpg'),
	(30, 1, 'https://media.rentaitm.example/vehiculos/NJS195/frontal.jpg'),
	(31, 1, 'https://media.rentaitm.example/vehiculos/IJC157/frontal.jpg'),
	(32, 1, 'https://media.rentaitm.example/vehiculos/SXK454/frontal.jpg'),
	(33, 1, 'https://media.rentaitm.example/vehiculos/DNS568/frontal.jpg'),
	(34, 1, 'https://media.rentaitm.example/vehiculos/NVS419/frontal.jpg'),
	(35, 1, 'https://media.rentaitm.example/vehiculos/WDB101/frontal.jpg'),
	(36, 1, 'https://media.rentaitm.example/vehiculos/IMZ797/frontal.jpg'),
	(37, 1, 'https://media.rentaitm.example/vehiculos/NFB726/frontal.jpg'),
	(38, 1, 'https://media.rentaitm.example/vehiculos/IHH527/frontal.jpg'),
	(39, 1, 'https://media.rentaitm.example/vehiculos/JFO543/frontal.jpg'),
	(40, 1, 'https://media.rentaitm.example/vehiculos/UIS719/frontal.jpg'),
	(41, 1, 'https://media.rentaitm.example/vehiculos/VNW958/frontal.jpg'),
	(42, 1, 'https://media.rentaitm.example/vehiculos/ESW865/frontal.jpg'),
	(43, 1, 'https://media.rentaitm.example/vehiculos/CRX936/frontal.jpg'),
	(44, 1, 'https://media.rentaitm.example/vehiculos/IBH764/frontal.jpg'),
	(45, 1, 'https://media.rentaitm.example/vehiculos/SBD470/frontal.jpg'),
	(46, 1, 'https://media.rentaitm.example/vehiculos/BOZ648/frontal.jpg'),
	(47, 1, 'https://media.rentaitm.example/vehiculos/LRU631/frontal.jpg'),
	(48, 1, 'https://media.rentaitm.example/vehiculos/LRW225/frontal.jpg'),
	(49, 1, 'https://media.rentaitm.example/vehiculos/YGO646/frontal.jpg'),
	(50, 1, 'https://media.rentaitm.example/vehiculos/FMV277/frontal.jpg'),
	(51, 1, 'https://media.rentaitm.example/vehiculos/EHT913/frontal.jpg'),
	(52, 1, 'https://media.rentaitm.example/vehiculos/MYT184/frontal.jpg'),
	(53, 1, 'https://media.rentaitm.example/vehiculos/TIL388/frontal.jpg'),
	(54, 1, 'https://media.rentaitm.example/vehiculos/SBC234/frontal.jpg'),
	(55, 1, 'https://media.rentaitm.example/vehiculos/NUF659/frontal.jpg'),
	(56, 1, 'https://media.rentaitm.example/vehiculos/RGF377/frontal.jpg'),
	(57, 1, 'https://media.rentaitm.example/vehiculos/PZJ867/frontal.jpg'),
	(58, 1, 'https://media.rentaitm.example/vehiculos/OKR985/frontal.jpg'),
	(59, 1, 'https://media.rentaitm.example/vehiculos/UBU682/frontal.jpg'),
	(60, 1, 'https://media.rentaitm.example/vehiculos/GYF173/frontal.jpg'),
	(1, 40, 'https://media.rentaitm.example/vehiculos/WGU959/recorrido360.mp4'),
	(2, 40, 'https://media.rentaitm.example/vehiculos/LGT435/recorrido360.mp4'),
	(3, 40, 'https://media.rentaitm.example/vehiculos/TTN646/recorrido360.mp4'),
	(4, 40, 'https://media.rentaitm.example/vehiculos/YUP847/recorrido360.mp4'),
	(5, 40, 'https://media.rentaitm.example/vehiculos/GUX608/recorrido360.mp4'),
	(6, 40, 'https://media.rentaitm.example/vehiculos/FGH370/recorrido360.mp4'),
	(7, 40, 'https://media.rentaitm.example/vehiculos/KRC183/recorrido360.mp4'),
	(8, 40, 'https://media.rentaitm.example/vehiculos/WIR285/recorrido360.mp4'),
	(9, 40, 'https://media.rentaitm.example/vehiculos/TPO185/recorrido360.mp4'),
	(10, 40, 'https://media.rentaitm.example/vehiculos/BDJ462/recorrido360.mp4'),
	(11, 40, 'https://media.rentaitm.example/vehiculos/ZRK239/recorrido360.mp4'),
	(12, 40, 'https://media.rentaitm.example/vehiculos/CUK707/recorrido360.mp4'),
	(13, 40, 'https://media.rentaitm.example/vehiculos/BPH869/recorrido360.mp4'),
	(14, 40, 'https://media.rentaitm.example/vehiculos/NGY577/recorrido360.mp4'),
	(15, 40, 'https://media.rentaitm.example/vehiculos/BYJ103/recorrido360.mp4'),
	(16, 40, 'https://media.rentaitm.example/vehiculos/OGS756/recorrido360.mp4'),
	(17, 40, 'https://media.rentaitm.example/vehiculos/CBP791/recorrido360.mp4'),
	(18, 40, 'https://media.rentaitm.example/vehiculos/DOD997/recorrido360.mp4'),
	(19, 40, 'https://media.rentaitm.example/vehiculos/SUF980/recorrido360.mp4'),
	(20, 40, 'https://media.rentaitm.example/vehiculos/YCX999/recorrido360.mp4'),
	(21, 7, 'https://media.rentaitm.example/vehiculos/GIL834/tablero.jpg'),
	(22, 7, 'https://media.rentaitm.example/vehiculos/PDC202/tablero.jpg'),
	(23, 7, 'https://media.rentaitm.example/vehiculos/XXI814/tablero.jpg'),
	(24, 7, 'https://media.rentaitm.example/vehiculos/EDN711/tablero.jpg'),
	(25, 7, 'https://media.rentaitm.example/vehiculos/UEH901/tablero.jpg'),
	(26, 7, 'https://media.rentaitm.example/vehiculos/TRU337/tablero.jpg'),
	(27, 7, 'https://media.rentaitm.example/vehiculos/CGN612/tablero.jpg'),
	(28, 7, 'https://media.rentaitm.example/vehiculos/CTM177/tablero.jpg'),
	(29, 7, 'https://media.rentaitm.example/vehiculos/RYU533/tablero.jpg'),
	(30, 7, 'https://media.rentaitm.example/vehiculos/NJS195/tablero.jpg'),
	(31, 7, 'https://media.rentaitm.example/vehiculos/IJC157/tablero.jpg'),
	(32, 7, 'https://media.rentaitm.example/vehiculos/SXK454/tablero.jpg'),
	(33, 7, 'https://media.rentaitm.example/vehiculos/DNS568/tablero.jpg'),
	(34, 7, 'https://media.rentaitm.example/vehiculos/NVS419/tablero.jpg'),
	(35, 7, 'https://media.rentaitm.example/vehiculos/WDB101/tablero.jpg')
GO

SELECT * FROM MULTIMEDIA_VEHICULO  -- TOTAL REGISTROS 95
GO

---   -----          ------          -----

/*
TABLA TALLER: 50 FILAS
50 TALLERES FICTICIOS DEL ÁREA METROPOLITANA.
*/

INSERT INTO TALLER(
NOMBRE, TELEFONO, DIRECCION
)
VALUES('Autoservicio El Poblado', '3266060718', 'Calle 44 # 92-66'),  -- ID 1
	('Taller Mecanico Laureles', '6043763604', 'Carrera 105 # 11-11'),  -- ID 2
	('Serviteca La 80', '6044367360', 'Calle 24 # 86-76'),  -- ID 3
	('Frenos y Embragues Belen', '3284340473', 'Carrera 47 # 39-8'),  -- ID 4
	('Latoneria y Pintura Itagui', '6043190313', 'Carrera 8 # 61-56'),  -- ID 5
	('Electroauto Envigado', '6044003146', 'Calle 51 # 16-75'),  -- ID 6
	('Lubricentro Sabaneta', '3575606621', 'Carrera 46 # 8-12'),  -- ID 7
	('Diesel Center Bello', '6042008572', 'Calle 29 # 49-9'),  -- ID 8
	('Alineacion Total Guayabal', '6043858931', 'Carrera 18 # 67-51'),  -- ID 9
	('Taller Los Colores', '3159742827', 'Calle 9 # 38-74'),  -- ID 10
	('Autocentro Las Palmas', '6044638068', 'Calle 97 # 43-14'),  -- ID 11
	('Mecanica Rapida Robledo', '6044425706', 'Carrera 57 # 51-47'),  -- ID 12
	('Serviteca Castilla', '3019170565', 'Calle 86 # 19-94'),  -- ID 13
	('Tecnicentro Aranjuez', '6042098057', 'Carrera 62 # 13-89'),  -- ID 14
	('Taller El Estadio', '6043475471', 'Calle 17 # 5-11'),  -- ID 15
	('Autopintura Manrique', '3065583660', 'Carrera 6 # 82-90'),  -- ID 16
	('Clinica del Carro Calasanz', '6043681000', 'Carrera 49 # 32-93'),  -- ID 17
	('Taller Electrico San Joaquin', '6042700309', 'Carrera 72 # 2-43'),  -- ID 18
	('Llantas y Rines Conquistadores', '3021536963', 'Calle 18 # 14-27'),  -- ID 19
	('Taller Suspensiones Colombia', '6044315234', 'Carrera 74 # 30-10'),  -- ID 20
	('Taller Hibridos y Electricos', '6044680120', 'Carrera 100 # 74-68'),  -- ID 21
	('Radiadores La 65', '3564994927', 'Calle 89 # 86-26'),  -- ID 22
	('Escapes y Silenciadores Bello', '6044101806', 'Carrera 72 # 5-9'),  -- ID 23
	('Cerrajeria Automotriz Envigado', '6044590360', 'Calle 76 # 72-66'),  -- ID 24
	('Vidrios Autos Medellin', '3146619684', 'Calle 22 # 44-78'),  -- ID 25
	('Tapiceria Automotriz Itagui', '6043599430', 'Carrera 89 # 96-53'),  -- ID 26
	('Mecanica Diesel Caldas', '6043201459', 'Calle 53 # 40-66'),  -- ID 27
	('Taller La Estrella', '3152816881', 'Calle 89 # 75-67'),  -- ID 28
	('Autoservicio Copacabana', '6043630315', 'Carrera 76 # 70-37'),  -- ID 29
	('Taller Girardota', '6044878140', 'Carrera 35 # 16-22'),  -- ID 30
	('Serviteca Rionegro', '3063229997', 'Carrera 86 # 61-92'),  -- ID 31
	('Taller Llanogrande', '6042576017', 'Carrera 3 # 79-18'),  -- ID 32
	('Taller La Ceja', '6043539090', 'Carrera 34 # 97-12'),  -- ID 33
	('Mecanica Marinilla', '3273252355', 'Carrera 27 # 25-67'),  -- ID 34
	('Autocentro El Retiro', '6044186384', 'Carrera 100 # 6-92'),  -- ID 35
	('Taller Oriente Antioqueno', '6044594253', 'Calle 56 # 12-50'),  -- ID 36
	('Taller Norte Bello Niquia', '3027056127', 'Carrera 95 # 95-19'),  -- ID 37
	('Lubricantes y Filtros Centro', '6042663820', 'Carrera 22 # 85-43'),  -- ID 38
	('Servicio Tecnico Mazda Sur', '6044186786', 'Calle 42 # 57-24'),  -- ID 39
	('Servicio Tecnico Renault Norte', '3555881275', 'Carrera 43 # 85-15'),  -- ID 40
	('Servicio Tecnico Chevrolet Centro', '6042298806', 'Carrera 107 # 61-8'),  -- ID 41
	('Servicio Tecnico Toyota Sur', '6044543029', 'Calle 6 # 4-69'),  -- ID 42
	('Servicio Tecnico Kia Envigado', '3567946954', 'Calle 97 # 13-83'),  -- ID 43
	('Servicio Tecnico Hyundai', '6042528482', 'Calle 8 # 51-71'),  -- ID 44
	('Servicio Tecnico BYD', '6042152852', 'Carrera 107 # 82-83'),  -- ID 45
	('Taller Premium Alemanes', '3225530385', 'Calle 100 # 42-79'),  -- ID 46
	('Taller 4x4 Montana', '6043581340', 'Carrera 21 # 27-13'),  -- ID 47
	('Diagnostico Computarizado', '6044534043', 'Calle 37 # 29-45'),  -- ID 48
	('Centro de Diagnostico Automotor', '3020777560', 'Carrera 40 # 9-8'),  -- ID 49
	('Taller Express Aeropuerto', '6042809056', 'Carrera 3 # 53-54')  -- ID 50
GO

SELECT * FROM TALLER  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----

/*
TABLA MANTENIMIENTO: 83 FILAS
83 REGISTROS DE LA HOJA DE VIDA. NINGUNO CAE DENTRO DE UN ALQUILER DEL MISMO VEHÍCULO.
NUM_MANTENIMIENTO ES IDENTITY: SE LLENA SOLO (1, 2, 3...), NO VA EN EL INSERT.
*/

INSERT INTO MANTENIMIENTO(
ID_VEHICULO, ID_TALLER, ID_TIPO_MANTENIMIENTO, FECHA, COSTO, DESCRIPCION
)
VALUES(1, 23, 2, '20260527', 128000.00, 'Alineacion y balanceo (hoja de vida)'),  -- ID 1
	(2, 28, 21, '20250314', 81000.00, 'Lavado y polichado (hoja de vida)'),  -- ID 2
	(3, 7, 45, '20250517', 24000.00, 'Reparacion de pinchazo (hoja de vida)'),  -- ID 3
	(3, 12, 9, '20250214', 235000.00, 'Cambio de bujias (hoja de vida)'),  -- ID 4
	(4, 50, 6, '20260509', 115000.00, 'Cambio de liquido de frenos (hoja de vida)'),  -- ID 5
	(5, 30, 34, '20260306', 327000.00, 'Reparacion de stop (hoja de vida)'),  -- ID 6
	(6, 29, 42, '20260517', 799000.00, 'Reparacion de aire acondicionado (hoja de vida)'),  -- ID 7
	(6, 15, 23, '20260126', 52000.00, 'Cambio de plumillas (hoja de vida)'),  -- ID 8
	(7, 19, 21, '20260816', 97000.00, 'Lavado y polichado (hoja de vida)'),  -- ID 9
	(8, 24, 38, '20250425', 2942000.00, 'Reparacion de caja (hoja de vida)'),  -- ID 10
	(9, 12, 5, '20250301', 280000.00, 'Cambio de pastillas de freno (hoja de vida)'),  -- ID 11
	(9, 50, 11, '20250317', 902000.00, 'Cambio de correa de reparticion (hoja de vida)'),  -- ID 12
	(10, 49, 24, '20251023', 139000.00, 'Revision de suspension (hoja de vida)'),  -- ID 13
	(11, 12, 18, '20250220', 145000.00, 'Carga de aire acondicionado (hoja de vida)'),  -- ID 14
	(12, 39, 11, '20261007', 1031000.00, 'Cambio de correa de reparticion (hoja de vida)'),  -- ID 15
	(12, 44, 10, '20251112', 318000.00, 'Sincronizacion (hoja de vida)'),  -- ID 16
	(13, 26, 14, '20250604', 527000.00, 'Revision de 20.000 km (hoja de vida)'),  -- ID 17
	(14, 32, 3, '20250614', 61000.00, 'Rotacion de llantas (hoja de vida)'),  -- ID 18
	(15, 26, 26, '20250617', 312000.00, 'Revision bateria de alta tension (hoja de vida)'),  -- ID 19
	(15, 27, 16, '20260728', 191000.00, 'Lavado de inyectores (hoja de vida)'),  -- ID 20
	(16, 34, 10, '20260208', 388000.00, 'Sincronizacion (hoja de vida)'),  -- ID 21
	(17, 43, 17, '20260420', 223000.00, 'Revision tecnico-mecanica (hoja de vida)'),  -- ID 22
	(18, 48, 17, '20250917', 225000.00, 'Revision tecnico-mecanica (hoja de vida)'),  -- ID 23
	(18, 42, 14, '20260701', 572000.00, 'Revision de 20.000 km (hoja de vida)'),  -- ID 24
	(19, 42, 15, '20251226', 733000.00, 'Revision de 40.000 km (hoja de vida)'),  -- ID 25
	(20, 38, 18, '20250317', 149000.00, 'Carga de aire acondicionado (hoja de vida)'),  -- ID 26
	(21, 11, 24, '20250207', 136000.00, 'Revision de suspension (hoja de vida)'),  -- ID 27
	(21, 39, 4, '20251026', 1416000.00, 'Cambio de llantas (hoja de vida)'),  -- ID 28
	(22, 26, 13, '20260313', 386000.00, 'Revision de 10.000 km (hoja de vida)'),  -- ID 29
	(23, 4, 13, '20250323', 392000.00, 'Revision de 10.000 km (hoja de vida)'),  -- ID 30
	(24, 46, 14, '20250430', 595000.00, 'Revision de 20.000 km (hoja de vida)'),  -- ID 31
	(24, 18, 34, '20250502', 322000.00, 'Reparacion de stop (hoja de vida)'),  -- ID 32
	(25, 11, 29, '20250816', 1120000.00, 'Cambio de parabrisas (hoja de vida)'),  -- ID 33
	(26, 37, 26, '20250312', 281000.00, 'Revision bateria de alta tension (hoja de vida)'),  -- ID 34
	(27, 3, 22, '20260807', 47000.00, 'Desinfeccion de cabina (hoja de vida)'),  -- ID 35
	(27, 17, 25, '20251028', 275000.00, 'Cambio de aceite de caja (hoja de vida)'),  -- ID 36
	(28, 17, 3, '20260807', 58000.00, 'Rotacion de llantas (hoja de vida)'),  -- ID 37
	(29, 19, 20, '20250604', 138000.00, 'Revision sistema electrico (hoja de vida)'),  -- ID 38
	(30, 20, 34, '20261021', 278000.00, 'Reparacion de stop (hoja de vida)'),  -- ID 39
	(30, 42, 29, '20250525', 1069000.00, 'Cambio de parabrisas (hoja de vida)'),  -- ID 40
	(31, 35, 21, '20260813', 94000.00, 'Lavado y polichado (hoja de vida)'),  -- ID 41
	(32, 20, 1, '20250524', 194000.00, 'Cambio de aceite y filtro (hoja de vida)'),  -- ID 42
	(33, 30, 10, '20250819', 340000.00, 'Sincronizacion (hoja de vida)'),  -- ID 43
	(33, 2, 20, '20260702', 130000.00, 'Revision sistema electrico (hoja de vida)'),  -- ID 44
	(34, 8, 47, '20260701', 318000.00, 'Reparacion de vidrio electrico (hoja de vida)'),  -- ID 45
	(35, 30, 5, '20250801', 298000.00, 'Cambio de pastillas de freno (hoja de vida)'),  -- ID 46
	(36, 7, 24, '20260815', 121000.00, 'Revision de suspension (hoja de vida)'),  -- ID 47
	(36, 39, 22, '20250606', 48000.00, 'Desinfeccion de cabina (hoja de vida)'),  -- ID 48
	(37, 30, 15, '20250629', 729000.00, 'Revision de 40.000 km (hoja de vida)'),  -- ID 49
	(38, 40, 3, '20250226', 64000.00, 'Rotacion de llantas (hoja de vida)'),  -- ID 50
	(39, 39, 6, '20260602', 113000.00, 'Cambio de liquido de frenos (hoja de vida)'),  -- ID 51
	(39, 7, 13, '20260519', 417000.00, 'Revision de 10.000 km (hoja de vida)'),  -- ID 52
	(40, 21, 49, '20250206', 389000.00, 'Reparacion de escape (hoja de vida)'),  -- ID 53
	(41, 49, 11, '20250827', 840000.00, 'Cambio de correa de reparticion (hoja de vida)'),  -- ID 54
	(42, 32, 42, '20251216', 734000.00, 'Reparacion de aire acondicionado (hoja de vida)'),  -- ID 55
	(42, 25, 1, '20250922', 183000.00, 'Cambio de aceite y filtro (hoja de vida)'),  -- ID 56
	(43, 7, 41, '20250324', 1025000.00, 'Reparacion de direccion (hoja de vida)'),  -- ID 57
	(44, 38, 13, '20260729', 462000.00, 'Revision de 10.000 km (hoja de vida)'),  -- ID 58
	(45, 31, 3, '20250727', 58000.00, 'Rotacion de llantas (hoja de vida)'),  -- ID 59
	(45, 9, 34, '20260129', 297000.00, 'Reparacion de stop (hoja de vida)'),  -- ID 60
	(46, 27, 11, '20251120', 816000.00, 'Cambio de correa de reparticion (hoja de vida)'),  -- ID 61
	(47, 18, 4, '20261028', 1579000.00, 'Cambio de llantas (hoja de vida)'),  -- ID 62
	(48, 17, 13, '20250128', 424000.00, 'Revision de 10.000 km (hoja de vida)'),  -- ID 63
	(48, 31, 19, '20250921', 572000.00, 'Cambio de bateria (hoja de vida)'),  -- ID 64
	(49, 38, 1, '20250326', 199000.00, 'Cambio de aceite y filtro (hoja de vida)'),  -- ID 65
	(50, 46, 5, '20260514', 257000.00, 'Cambio de pastillas de freno (hoja de vida)'),  -- ID 66
	(51, 25, 6, '20250302', 102000.00, 'Cambio de liquido de frenos (hoja de vida)'),  -- ID 67
	(51, 1, 46, '20250325', 252000.00, 'Reparacion de cerradura (hoja de vida)'),  -- ID 68
	(52, 50, 2, '20260124', 130000.00, 'Alineacion y balanceo (hoja de vida)'),  -- ID 69
	(53, 36, 2, '20250413', 134000.00, 'Alineacion y balanceo (hoja de vida)'),  -- ID 70
	(54, 42, 8, '20260313', 62000.00, 'Cambio de filtro de cabina (hoja de vida)'),  -- ID 71
	(54, 25, 2, '20250108', 137000.00, 'Alineacion y balanceo (hoja de vida)'),  -- ID 72
	(55, 36, 3, '20260702', 59000.00, 'Rotacion de llantas (hoja de vida)'),  -- ID 73
	(56, 11, 30, '20250504', 381000.00, 'Reparacion de rayones (hoja de vida)'),  -- ID 74
	(57, 49, 17, '20250703', 253000.00, 'Revision tecnico-mecanica (hoja de vida)'),  -- ID 75
	(58, 26, 37, '20251128', 1181000.00, 'Reparacion de embrague (hoja de vida)'),  -- ID 76
	(59, 39, 7, '20251203', 72000.00, 'Cambio de filtro de aire (hoja de vida)'),  -- ID 77
	(60, 36, 10, '20260418', 321000.00, 'Sincronizacion (hoja de vida)'),  -- ID 78
	(6, 15, 27, '20261105', 850000.00, 'Reparacion de latoneria (en curso)'),  -- ID 79
	(30, 10, 13, '20261107', 420000.00, 'Revision de 10.000 km (en curso)'),  -- ID 80
	(10, 26, 14, '20261106', 520000.00, 'Revision de 20.000 km (en curso)'),  -- ID 81
	(44, 43, 15, '20261109', 780000.00, 'Revision de 40.000 km (en curso)'),  -- ID 82
	(21, 10, 50, '20261028', 6200000.00, 'Reparacion por siniestro: perdida parcial, espera de peritaje')  -- ID 83
GO

SELECT * FROM MANTENIMIENTO  -- TOTAL REGISTROS 83
GO

---   -----          ------          -----


--  ======================================================
--  OPERACION: RESERVA, ALQUILER, ACTAS, DAÑOS Y ENCUESTA
--  ======================================================

/*
TABLA RESERVA: 66 FILAS
66 RESERVAS: 50 CUMPLIDA (SE VOLVIERON ALQUILER), 8 CANCELADA Y 8 FUTURAS (6 CONFIRMADA, 2 MODIFICADA).
CANCELADAS: 5 GRATIS (MÁS DE 24 H ANTES -> MULTA 0) Y 3 TARDÍAS (MENOS DE 24 H -> MULTA = 1 DÍA DE TARIFA).
LAS NO CANCELADAS TIENEN FECHA_CANCELACION Y VALOR_MULTA EN NULL (CK_RESERVA_CANCELACION).
NINGÚN VEHÍCULO TIENE DOS RESERVAS VIGENTES QUE SE CRUCEN EN FECHAS.
*/

INSERT INTO RESERVA(
ID_CLIENTE, ID_VEHICULO, ID_SEDE, ID_POLIZA, ID_MODALIDAD, ID_CONVENIO, CODIGO_RESERVA, FECHA_INICIO, FECHA_FIN, ESTADO, FECHA_CANCELACION, VALOR_MULTA, MONEDA
)
VALUES(58, 44, 12, 1, 2, NULL, 'RV2501033136', '2025-01-08T08:00:00', '2025-01-11T08:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 1
	(91, 51, 2, 1, 2, NULL, 'RV2501198146', '2025-01-24T11:00:00', '2025-02-03T11:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 2
	(57, 23, 44, 1, 1, 31, 'RV2501317950', '2025-02-05T14:00:00', '2025-02-08T14:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 3
	(100, 44, 1, 3, 1, NULL, 'RV2502121586', '2025-02-17T10:00:00', '2025-02-27T10:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 4
	(66, 35, 1, 1, 2, NULL, 'RV2502277632', '2025-03-04T14:00:00', '2025-03-14T14:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 5
	(65, 50, 44, 2, 2, NULL, 'RV2503123280', '2025-03-17T08:00:00', '2025-03-21T08:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 6
	(76, 18, 1, 1, 2, NULL, 'RV2503236400', '2025-03-28T10:00:00', '2025-04-04T10:00:00', 'CUMPLIDA', NULL, NULL, 'EUR'),  -- ID 7
	(98, 2, 1, 3, 1, 12, 'RV2504041547', '2025-04-09T09:00:00', '2025-04-12T09:00:00', 'CUMPLIDA', NULL, NULL, 'USD'),  -- ID 8
	(79, 22, 27, 1, 2, NULL, 'RV2504188681', '2025-04-23T10:00:00', '2025-04-30T10:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 9
	(68, 30, 6, 2, 1, NULL, 'RV2505025759', '2025-05-07T09:00:00', '2025-05-10T09:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 10
	(78, 18, 44, 3, 2, 16, 'RV2505141994', '2025-05-19T11:00:00', '2025-05-24T11:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 11
	(84, 13, 12, 3, 2, NULL, 'RV2505265020', '2025-05-31T10:00:00', '2025-06-03T10:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 12
	(92, 23, 27, 2, 2, NULL, 'RV2506096148', '2025-06-14T10:00:00', '2025-06-18T10:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 13
	(61, 50, 6, 2, 2, NULL, 'RV2506216667', '2025-06-26T10:00:00', '2025-07-06T10:00:00', 'CUMPLIDA', NULL, NULL, 'USD'),  -- ID 14
	(70, 5, 1, 3, 2, 15, 'RV2507079320', '2025-07-12T11:00:00', '2025-07-19T11:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 15
	(59, 25, 2, 2, 2, NULL, 'RV2507197437', '2025-07-24T08:00:00', '2025-07-29T08:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 16
	(73, 13, 2, 1, 1, NULL, 'RV2508028400', '2025-08-07T11:00:00', '2025-08-14T11:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 17
	(86, 12, 6, 3, 2, NULL, 'RV2508135089', '2025-08-18T11:00:00', '2025-08-23T11:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 18
	(51, 40, 5, 1, 1, 50, 'RV2508286424', '2025-09-02T09:00:00', '2025-09-04T09:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 19
	(78, 12, 42, 2, 2, NULL, 'RV2509081623', '2025-09-13T14:00:00', '2025-09-18T14:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 20
	(85, 18, 44, 1, 1, NULL, 'RV2509236676', '2025-09-28T09:00:00', '2025-10-01T09:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 21
	(53, 11, 42, 2, 2, NULL, 'RV2510044862', '2025-10-09T10:00:00', '2025-10-13T10:00:00', 'CUMPLIDA', NULL, NULL, 'USD'),  -- ID 22
	(95, 12, 49, 2, 2, NULL, 'RV2510175759', '2025-10-22T11:00:00', '2025-10-25T11:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 23
	(56, 40, 1, 3, 1, NULL, 'RV2510303904', '2025-11-04T10:00:00', '2025-11-14T10:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 24
	(96, 38, 1, 2, 2, NULL, 'RV2511136017', '2025-11-18T08:00:00', '2025-11-20T08:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 25
	(84, 13, 5, 3, 2, NULL, 'RV2511255327', '2025-11-30T14:00:00', '2025-12-03T14:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 26
	(81, 2, 21, 2, 2, 37, 'RV2512088795', '2025-12-13T14:00:00', '2025-12-18T14:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 27
	(100, 18, 1, 1, 2, NULL, 'RV2512222127', '2025-12-27T11:00:00', '2026-01-03T11:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 28
	(54, 21, 49, 1, 1, NULL, 'RV2601021326', '2026-01-07T10:00:00', '2026-01-17T10:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 29
	(80, 2, 5, 1, 2, NULL, 'RV2601159644', '2026-01-20T11:00:00', '2026-01-30T11:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 30
	(82, 46, 12, 1, 1, NULL, 'RV2601297163', '2026-02-03T14:00:00', '2026-02-07T14:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 31
	(79, 6, 13, 1, 1, 30, 'RV2602101403', '2026-02-15T08:00:00', '2026-02-19T08:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 32
	(70, 47, 13, 2, 1, NULL, 'RV2602269617', '2026-03-03T10:00:00', '2026-03-08T10:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 33
	(93, 18, 6, 1, 1, 32, 'RV2603098267', '2026-03-14T09:00:00', '2026-03-19T09:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 34
	(92, 7, 5, 3, 1, NULL, 'RV2603213333', '2026-03-26T10:00:00', '2026-04-05T10:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 35
	(93, 13, 1, 1, 2, 22, 'RV2604049318', '2026-04-09T14:00:00', '2026-04-11T14:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 36
	(81, 13, 1, 2, 2, NULL, 'RV2604179800', '2026-04-22T08:00:00', '2026-04-25T08:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 37
	(62, 8, 13, 1, 2, NULL, 'RV2605011053', '2026-05-06T11:00:00', '2026-05-13T11:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 38
	(98, 18, 2, 3, 1, 16, 'RV2605133624', '2026-05-18T09:00:00', '2026-05-28T09:00:00', 'CUMPLIDA', NULL, NULL, 'USD'),  -- ID 39
	(55, 2, 3, 1, 1, 33, 'RV2605287290', '2026-06-02T08:00:00', '2026-06-09T08:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 40
	(52, 28, 42, 1, 1, NULL, 'RV2606101865', '2026-06-15T10:00:00', '2026-06-22T10:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 41
	(56, 38, 3, 1, 2, NULL, 'RV2606222766', '2026-06-27T11:00:00', '2026-07-07T11:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 42
	(70, 30, 2, 3, 2, NULL, 'RV2607062277', '2026-07-11T10:00:00', '2026-07-18T10:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 43
	(62, 12, 1, 1, 1, NULL, 'RV2607164084', '2026-07-21T11:00:00', '2026-07-24T11:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 44
	(60, 19, 5, 1, 2, NULL, 'RV2607319398', '2026-08-05T11:00:00', '2026-08-09T11:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 45
	(51, 38, 1, 3, 2, NULL, 'RV2608142461', '2026-08-19T08:00:00', '2026-08-24T08:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 46
	(61, 35, 12, 2, 2, NULL, 'RV2608248669', '2026-08-29T08:00:00', '2026-09-03T08:00:00', 'CUMPLIDA', NULL, NULL, 'USD'),  -- ID 47
	(54, 23, 5, 2, 2, NULL, 'RV2609063439', '2026-09-11T10:00:00', '2026-09-14T10:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 48
	(85, 44, 21, 1, 2, NULL, 'RV2609219711', '2026-09-26T11:00:00', '2026-09-28T11:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 49
	(60, 23, 21, 1, 1, 13, 'RV2610048756', '2026-10-09T09:00:00', '2026-10-13T09:00:00', 'CUMPLIDA', NULL, NULL, 'COP'),  -- ID 50
	(83, 4, 2, 1, 2, NULL, 'RV2505218648', '2025-05-27T08:00:00', '2025-05-29T08:00:00', 'CANCELADA', '2025-05-24T05:00:00', 0.00, 'EUR'),  -- ID 51
	(52, 19, 1, 3, 1, NULL, 'RV2502187677', '2025-02-26T08:00:00', '2025-03-02T08:00:00', 'CANCELADA', '2025-02-21T05:00:00', 0.00, 'COP'),  -- ID 52
	(64, 15, 2, 1, 2, NULL, 'RV2511268319', '2025-12-01T14:00:00', '2025-12-04T14:00:00', 'CANCELADA', '2025-11-29T11:00:00', 0.00, 'COP'),  -- ID 53
	(92, 15, 13, 1, 1, NULL, 'RV2509252663', '2025-10-03T14:00:00', '2025-10-06T14:00:00', 'CANCELADA', '2025-09-28T11:00:00', 0.00, 'COP'),  -- ID 54
	(53, 19, 1, 1, 2, NULL, 'RV2602077063', '2026-02-13T09:00:00', '2026-02-17T09:00:00', 'CANCELADA', '2026-02-10T06:00:00', 0.00, 'USD'),  -- ID 55
	(61, 36, 5, 1, 1, NULL, 'RV2602056706', '2026-02-09T09:00:00', '2026-02-11T09:00:00', 'CANCELADA', '2026-02-08T15:00:00', 368600.00, 'USD'),  -- ID 56
	(84, 2, 1, 1, 2, NULL, 'RV2608107697', '2026-08-14T08:00:00', '2026-08-18T08:00:00', 'CANCELADA', '2026-08-13T14:00:00', 105600.00, 'COP'),  -- ID 57
	(96, 12, 1, 1, 1, NULL, 'RV2607049305', '2026-07-08T08:00:00', '2026-07-11T08:00:00', 'CANCELADA', '2026-07-07T22:00:00', 243000.00, 'COP'),  -- ID 58
	(89, 11, 2, 3, 1, 4, 'RV2611015101', '2026-11-12T08:00:00', '2026-11-17T08:00:00', 'CONFIRMADA', NULL, NULL, 'COP'),  -- ID 59
	(51, 5, 1, 2, 2, NULL, 'RV2611021375', '2026-11-14T10:00:00', '2026-11-17T10:00:00', 'CONFIRMADA', NULL, NULL, 'COP'),  -- ID 60
	(72, 8, 5, 3, 1, NULL, 'RV2611034248', '2026-11-16T10:00:00', '2026-11-19T10:00:00', 'MODIFICADA', NULL, NULL, 'COP'),  -- ID 61
	(100, 2, 27, 2, 2, NULL, 'RV2611043548', '2026-11-18T10:00:00', '2026-11-22T10:00:00', 'CONFIRMADA', NULL, NULL, 'COP'),  -- ID 62
	(89, 43, 13, 3, 2, NULL, 'RV2611057680', '2026-11-20T09:00:00', '2026-11-25T09:00:00', 'CONFIRMADA', NULL, NULL, 'COP'),  -- ID 63
	(83, 22, 1, 3, 1, NULL, 'RV2611068201', '2026-11-22T08:00:00', '2026-11-26T08:00:00', 'MODIFICADA', NULL, NULL, 'EUR'),  -- ID 64
	(72, 41, 5, 3, 2, 17, 'RV2611073885', '2026-11-24T09:00:00', '2026-11-26T09:00:00', 'CONFIRMADA', NULL, NULL, 'COP'),  -- ID 65
	(75, 27, 2, 1, 1, NULL, 'RV2611083736', '2026-11-26T08:00:00', '2026-11-30T08:00:00', 'CONFIRMADA', NULL, NULL, 'COP')  -- ID 66
GO

SELECT * FROM RESERVA  -- TOTAL REGISTROS 66
GO

---   -----          ------          -----

/*
TABLA ALQUILER: 50 FILAS
50 ALQUILERES TERMINADOS (ENERO 2025 - OCTUBRE 2026), UNO POR RESERVA CUMPLIDA.
6 AMPLIARON EL TIEMPO EN LA ENTREGA (FECHA_FIN_PACTADA = FIN DE LA RESERVA + 2 DÍAS).
ANTICIPO = 30 % DE (ALQUILER + PÓLIZA - DESCUENTO). VALOR_TOTAL = TOTAL DE LA FACTURA.
*/

INSERT INTO ALQUILER(
ID_RESERVA, FECHA_ENTREGA, FECHA_FIN_PACTADA, FECHA_DEVOLUCION, ANTICIPO, VALOR_TOTAL
)
VALUES(1, '2025-01-08T08:00:00', '2025-01-11T08:00:00', '2025-01-11T08:00:00', 268200.00, 1026000.00),  -- ID 1
	(2, '2025-01-24T11:00:00', '2025-02-03T11:00:00', '2025-02-03T10:00:00', 615000.00, 3670000.00),  -- ID 2
	(3, '2025-02-05T14:00:00', '2025-02-10T14:00:00', '2025-02-10T14:00:00', 565952.00, 1886505.00),  -- ID 3
	(4, '2025-02-17T10:00:00', '2025-02-27T10:00:00', '2025-02-27T09:00:00', 1345800.00, 4486000.00),  -- ID 4
	(5, '2025-03-04T14:00:00', '2025-03-14T14:00:00', '2025-03-14T12:00:00', 582600.00, 2207644.00),  -- ID 5
	(6, '2025-03-17T08:00:00', '2025-03-21T08:00:00', '2025-03-21T07:00:00', 370800.00, 1360080.00),  -- ID 6
	(7, '2025-03-28T10:00:00', '2025-04-04T10:00:00', '2025-04-04T08:00:00', 430500.00, 1435000.00),  -- ID 7
	(8, '2025-04-09T09:00:00', '2025-04-12T09:00:00', '2025-04-12T04:00:00', 184313.00, 614376.00),  -- ID 8
	(9, '2025-04-23T10:00:00', '2025-05-02T10:00:00', '2025-05-02T15:00:00', 509760.00, 3053000.00),  -- ID 9
	(10, '2025-05-07T09:00:00', '2025-05-10T09:00:00', '2025-05-10T07:00:00', 186300.00, 621000.00),  -- ID 10
	(11, '2025-05-19T11:00:00', '2025-05-24T11:00:00', '2025-05-24T10:00:00', 366600.00, 1222000.00),  -- ID 11
	(12, '2025-05-31T10:00:00', '2025-06-03T10:00:00', '2025-06-03T05:00:00', 229140.00, 796800.00),  -- ID 12
	(13, '2025-06-14T10:00:00', '2025-06-18T10:00:00', '2025-06-18T10:00:00', 392400.00, 2398000.00),  -- ID 13
	(14, '2025-06-26T10:00:00', '2025-07-08T10:00:00', '2025-07-10T12:00:00', 1112400.00, 5428000.00),  -- ID 14
	(15, '2025-07-12T11:00:00', '2025-07-21T11:00:00', '2025-07-21T10:00:00', 476064.00, 1586880.00),  -- ID 15
	(16, '2025-07-24T08:00:00', '2025-07-29T08:00:00', '2025-07-29T08:00:00', 490500.00, 1690000.00),  -- ID 16
	(17, '2025-08-07T11:00:00', '2025-08-14T11:00:00', '2025-08-14T10:00:00', 532140.00, 7973800.00),  -- ID 17
	(18, '2025-08-18T11:00:00', '2025-08-23T11:00:00', '2025-08-23T11:00:00', 390000.00, 1531300.00),  -- ID 18
	(19, '2025-09-02T09:00:00', '2025-09-04T09:00:00', '2025-09-04T06:00:00', 245100.00, 817000.00),  -- ID 19
	(20, '2025-09-13T14:00:00', '2025-09-18T14:00:00', '2025-09-18T13:00:00', 337500.00, 1180000.00),  -- ID 20
	(21, '2025-09-28T09:00:00', '2025-10-01T09:00:00', '2025-10-01T09:00:00', 241200.00, 804000.00),  -- ID 21
	(22, '2025-10-09T10:00:00', '2025-10-13T10:00:00', '2025-10-13T10:00:00', 250560.00, 835200.00),  -- ID 22
	(23, '2025-10-22T11:00:00', '2025-10-25T11:00:00', '2025-10-25T10:00:00', 202500.00, 907200.00),  -- ID 23
	(24, '2025-11-04T10:00:00', '2025-11-16T10:00:00', '2025-11-16T07:00:00', 1746000.00, 5908000.00),  -- ID 24
	(25, '2025-11-18T08:00:00', '2025-11-20T08:00:00', '2025-11-20T08:00:00', 201600.00, 672000.00),  -- ID 25
	(26, '2025-11-30T14:00:00', '2025-12-03T14:00:00', '2025-12-03T13:00:00', 224280.00, 1053852.00),  -- ID 26
	(27, '2025-12-13T14:00:00', '2025-12-18T14:00:00', '2025-12-18T09:00:00', 212346.00, 707820.00),  -- ID 27
	(28, '2025-12-27T11:00:00', '2026-01-03T11:00:00', '2026-01-05T13:00:00', 430500.00, 2441200.00),  -- ID 28
	(29, '2026-01-07T10:00:00', '2026-01-17T10:00:00', '2026-01-17T10:00:00', 804000.00, 2680000.00),  -- ID 29
	(30, '2026-01-20T11:00:00', '2026-01-30T11:00:00', '2026-01-30T08:00:00', 391800.00, 1776000.00),  -- ID 30
	(31, '2026-02-03T14:00:00', '2026-02-09T14:00:00', '2026-02-09T12:00:00', 310320.00, 1122400.00),  -- ID 31
	(32, '2026-02-15T08:00:00', '2026-02-19T08:00:00', '2026-02-20T14:00:00', 210936.00, 1189120.00),  -- ID 32
	(33, '2026-03-03T10:00:00', '2026-03-08T10:00:00', '2026-03-08T08:00:00', 421050.00, 1953500.00),  -- ID 33
	(34, '2026-03-14T09:00:00', '2026-03-19T09:00:00', '2026-03-19T08:00:00', 361721.00, 1205738.00),  -- ID 34
	(35, '2026-03-26T10:00:00', '2026-04-05T10:00:00', '2026-04-06T16:00:00', 711300.00, 2842300.00),  -- ID 35
	(36, '2026-04-09T14:00:00', '2026-04-11T14:00:00', '2026-04-13T16:00:00', 110694.00, 1214980.00),  -- ID 36
	(37, '2026-04-22T08:00:00', '2026-04-25T08:00:00', '2026-04-25T07:00:00', 192780.00, 642600.00),  -- ID 37
	(38, '2026-05-06T11:00:00', '2026-05-13T11:00:00', '2026-05-13T06:00:00', 407820.00, 1359400.00),  -- ID 38
	(39, '2026-05-18T09:00:00', '2026-05-28T09:00:00', '2026-05-28T08:00:00', 890274.00, 2967580.00),  -- ID 39
	(40, '2026-06-02T08:00:00', '2026-06-09T08:00:00', '2026-06-09T07:00:00', 323803.00, 1244344.00),  -- ID 40
	(41, '2026-06-15T10:00:00', '2026-06-22T10:00:00', '2026-06-25T08:00:00', 562800.00, 3091000.00),  -- ID 41
	(42, '2026-06-27T11:00:00', '2026-07-07T11:00:00', '2026-07-08T17:00:00', 948000.00, 4121000.00),  -- ID 42
	(43, '2026-07-11T10:00:00', '2026-07-18T10:00:00', '2026-07-18T08:00:00', 420000.00, 1400000.00),  -- ID 43
	(44, '2026-07-21T11:00:00', '2026-07-24T11:00:00', '2026-07-24T08:00:00', 241200.00, 804000.00),  -- ID 44
	(45, '2026-08-05T11:00:00', '2026-08-09T11:00:00', '2026-08-09T09:00:00', 174000.00, 712000.00),  -- ID 45
	(46, '2026-08-19T08:00:00', '2026-08-24T08:00:00', '2026-08-24T05:00:00', 556500.00, 1855000.00),  -- ID 46
	(47, '2026-08-29T08:00:00', '2026-09-03T08:00:00', '2026-09-03T08:00:00', 321300.00, 1451000.00),  -- ID 47
	(48, '2026-09-11T10:00:00', '2026-09-14T10:00:00', '2026-09-14T05:00:00', 294300.00, 981000.00),  -- ID 48
	(49, '2026-09-26T11:00:00', '2026-09-28T11:00:00', '2026-09-28T11:00:00', 178800.00, 10429000.00),  -- ID 49
	(50, '2026-10-09T09:00:00', '2026-10-13T09:00:00', '2026-10-13T04:00:00', 443024.00, 1476748.00)  -- ID 50
GO

SELECT * FROM ALQUILER  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----

/*
TABLA INSPECCION: 100 FILAS
100 ACTAS = 2 POR ALQUILER (ENTREGA CON TANQUE AL 100 % Y DEVOLUCION). LAS HACEN COORDINADORES ACTIVOS.
EL KILOMETRAJE DE DEVOLUCIÓN SIEMPRE ES MAYOR QUE EL DE ENTREGA, Y EL ODÓMETRO DE CADA VEHÍCULO CRECE EN EL TIEMPO.
*/

INSERT INTO INSPECCION(
ID_ALQUILER, ID_EMPLEADO, ID_TIPO_INSPECCION, FECHA_HORA, KILOMETRAJE, NIVEL_GASOLINA
)
VALUES(1, 27, 1, '2025-01-08T08:10:00', 33799, 100),  -- ID 1
	(1, 10, 2, '2025-01-11T08:00:00', 34029, 40),  -- ID 2
	(2, 28, 1, '2025-01-24T11:10:00', 6698, 100),  -- ID 3
	(2, 26, 2, '2025-02-03T10:00:00', 7272, 100),  -- ID 4
	(3, 27, 1, '2025-02-05T14:15:00', 25997, 100),  -- ID 5
	(3, 6, 2, '2025-02-10T14:00:00', 26067, 100),  -- ID 6
	(4, 10, 1, '2025-02-17T10:10:00', 34029, 100),  -- ID 7
	(4, 26, 2, '2025-02-27T09:00:00', 34923, 100),  -- ID 8
	(5, 25, 1, '2025-03-04T14:20:00', 26413, 100),  -- ID 9
	(5, 8, 2, '2025-03-14T12:00:00', 28727, 100),  -- ID 10
	(6, 14, 1, '2025-03-17T08:20:00', 43971, 100),  -- ID 11
	(6, 22, 2, '2025-03-21T07:00:00', 44865, 100),  -- ID 12
	(7, 14, 1, '2025-03-28T10:05:00', 8215, 100),  -- ID 13
	(7, 27, 2, '2025-04-04T08:00:00', 8517, 100),  -- ID 14
	(8, 11, 1, '2025-04-09T09:05:00', 40403, 100),  -- ID 15
	(8, 24, 2, '2025-04-12T04:00:00', 40870, 100),  -- ID 16
	(9, 14, 1, '2025-04-23T10:20:00', 34369, 100),  -- ID 17
	(9, 7, 2, '2025-05-02T15:00:00', 34904, 100),  -- ID 18
	(10, 10, 1, '2025-05-07T09:15:00', 9120, 100),  -- ID 19
	(10, 27, 2, '2025-05-10T07:00:00', 9448, 100),  -- ID 20
	(11, 10, 1, '2025-05-19T11:05:00', 8517, 100),  -- ID 21
	(11, 26, 2, '2025-05-24T10:00:00', 9280, 100),  -- ID 22
	(12, 25, 1, '2025-05-31T10:20:00', 19897, 100),  -- ID 23
	(12, 14, 2, '2025-06-03T05:00:00', 20174, 85),  -- ID 24
	(13, 11, 1, '2025-06-14T10:10:00', 26067, 100),  -- ID 25
	(13, 11, 2, '2025-06-18T10:00:00', 26564, 100),  -- ID 26
	(14, 11, 1, '2025-06-26T10:20:00', 44865, 100),  -- ID 27
	(14, 24, 2, '2025-07-10T12:00:00', 45702, 100),  -- ID 28
	(15, 20, 1, '2025-07-12T11:10:00', 41419, 100),  -- ID 29
	(15, 10, 2, '2025-07-21T10:00:00', 42361, 100),  -- ID 30
	(16, 20, 1, '2025-07-24T08:15:00', 22882, 100),  -- ID 31
	(16, 23, 2, '2025-07-29T08:00:00', 23691, 75),  -- ID 32
	(17, 17, 1, '2025-08-07T11:20:00', 20174, 100),  -- ID 33
	(17, 9, 2, '2025-08-14T10:00:00', 20663, 100),  -- ID 34
	(18, 8, 1, '2025-08-18T11:10:00', 5046, 100),  -- ID 35
	(18, 10, 2, '2025-08-23T11:00:00', 6303, 100),  -- ID 36
	(19, 8, 1, '2025-09-02T09:15:00', 6249, 100),  -- ID 37
	(19, 6, 2, '2025-09-04T06:00:00', 6599, 100),  -- ID 38
	(20, 9, 1, '2025-09-13T14:05:00', 6303, 100),  -- ID 39
	(20, 13, 2, '2025-09-18T13:00:00', 6858, 75),  -- ID 40
	(21, 20, 1, '2025-09-28T09:15:00', 9280, 100),  -- ID 41
	(21, 6, 2, '2025-10-01T09:00:00', 9373, 100),  -- ID 42
	(22, 21, 1, '2025-10-09T10:20:00', 35389, 100),  -- ID 43
	(22, 19, 2, '2025-10-13T10:00:00', 35490, 100),  -- ID 44
	(23, 10, 1, '2025-10-22T11:05:00', 6858, 100),  -- ID 45
	(23, 11, 2, '2025-10-25T10:00:00', 7716, 100),  -- ID 46
	(24, 18, 1, '2025-11-04T10:20:00', 6599, 100),  -- ID 47
	(24, 6, 2, '2025-11-16T07:00:00', 6770, 60),  -- ID 48
	(25, 25, 1, '2025-11-18T08:10:00', 13650, 100),  -- ID 49
	(25, 28, 2, '2025-11-20T08:00:00', 13814, 100),  -- ID 50
	(26, 16, 1, '2025-11-30T14:10:00', 20663, 100),  -- ID 51
	(26, 25, 2, '2025-12-03T13:00:00', 21625, 100),  -- ID 52
	(27, 28, 1, '2025-12-13T14:20:00', 40870, 100),  -- ID 53
	(27, 25, 2, '2025-12-18T09:00:00', 41355, 100),  -- ID 54
	(28, 27, 1, '2025-12-27T11:05:00', 9373, 100),  -- ID 55
	(28, 10, 2, '2026-01-05T13:00:00', 10891, 100),  -- ID 56
	(29, 17, 1, '2026-01-07T10:20:00', 5002, 100),  -- ID 57
	(29, 27, 2, '2026-01-17T10:00:00', 5477, 100),  -- ID 58
	(30, 13, 1, '2026-01-20T11:05:00', 41355, 100),  -- ID 59
	(30, 25, 2, '2026-01-30T08:00:00', 41917, 100),  -- ID 60
	(31, 13, 1, '2026-02-03T14:10:00', 32036, 100),  -- ID 61
	(31, 15, 2, '2026-02-09T12:00:00', 32334, 60),  -- ID 62
	(32, 10, 1, '2026-02-15T08:20:00', 3161, 100),  -- ID 63
	(32, 11, 2, '2026-02-20T14:00:00', 3777, 100),  -- ID 64
	(33, 24, 1, '2026-03-03T10:20:00', 15331, 100),  -- ID 65
	(33, 19, 2, '2026-03-08T08:00:00', 16083, 100),  -- ID 66
	(34, 27, 1, '2026-03-14T09:15:00', 10891, 100),  -- ID 67
	(34, 14, 2, '2026-03-19T08:00:00', 11739, 100),  -- ID 68
	(35, 26, 1, '2026-03-26T10:05:00', 10567, 100),  -- ID 69
	(35, 28, 2, '2026-04-06T16:00:00', 12252, 100),  -- ID 70
	(36, 15, 1, '2026-04-09T14:15:00', 21625, 100),  -- ID 71
	(36, 26, 2, '2026-04-13T16:00:00', 21806, 100),  -- ID 72
	(37, 19, 1, '2026-04-22T08:10:00', 21806, 100),  -- ID 73
	(37, 23, 2, '2026-04-25T07:00:00', 21924, 100),  -- ID 74
	(38, 27, 1, '2026-05-06T11:20:00', 25312, 100),  -- ID 75
	(38, 14, 2, '2026-05-13T06:00:00', 26472, 100),  -- ID 76
	(39, 27, 1, '2026-05-18T09:20:00', 11739, 100),  -- ID 77
	(39, 17, 2, '2026-05-28T08:00:00', 13306, 100),  -- ID 78
	(40, 27, 1, '2026-06-02T08:10:00', 41917, 100),  -- ID 79
	(40, 7, 2, '2026-06-09T07:00:00', 42756, 25),  -- ID 80
	(41, 6, 1, '2026-06-15T10:10:00', 4268, 100),  -- ID 81
	(41, 8, 2, '2026-06-25T08:00:00', 4562, 100),  -- ID 82
	(42, 21, 1, '2026-06-27T11:20:00', 13814, 100),  -- ID 83
	(42, 22, 2, '2026-07-08T17:00:00', 14354, 60),  -- ID 84
	(43, 13, 1, '2026-07-11T10:05:00', 9448, 100),  -- ID 85
	(43, 10, 2, '2026-07-18T08:00:00', 10686, 100),  -- ID 86
	(44, 8, 1, '2026-07-21T11:15:00', 7716, 100),  -- ID 87
	(44, 18, 2, '2026-07-24T08:00:00', 7968, 100),  -- ID 88
	(45, 21, 1, '2026-08-05T11:05:00', 3376, 100),  -- ID 89
	(45, 17, 2, '2026-08-09T09:00:00', 3772, 40),  -- ID 90
	(46, 28, 1, '2026-08-19T08:15:00', 14354, 100),  -- ID 91
	(46, 14, 2, '2026-08-24T05:00:00', 14675, 100),  -- ID 92
	(47, 14, 1, '2026-08-29T08:05:00', 28727, 100),  -- ID 93
	(47, 18, 2, '2026-09-03T08:00:00', 28841, 100),  -- ID 94
	(48, 25, 1, '2026-09-11T10:05:00', 26564, 100),  -- ID 95
	(48, 21, 2, '2026-09-14T05:00:00', 26994, 100),  -- ID 96
	(49, 8, 1, '2026-09-26T11:15:00', 34923, 100),  -- ID 97
	(49, 14, 2, '2026-09-28T11:00:00', 35009, 85),  -- ID 98
	(50, 26, 1, '2026-10-09T09:05:00', 26994, 100),  -- ID 99
	(50, 10, 2, '2026-10-13T04:00:00', 27529, 100)  -- ID 100
GO

SELECT * FROM INSPECCION  -- TOTAL REGISTROS 100
GO

---   -----          ------          -----

/*
TABLA FOTO_INSPECCION: 100 FILAS
100 FOTOS: UNA PANORÁMICA POR ACTA (SOPORTE ANTE RECLAMOS POR DAÑOS).
*/

INSERT INTO FOTO_INSPECCION(
ID_INSPECCION, URL
)
VALUES(1, 'https://fotos.rentaitm.example/inspecciones/001/entrega_panoramica.jpg'),
	(2, 'https://fotos.rentaitm.example/inspecciones/002/devolucion_panoramica.jpg'),
	(3, 'https://fotos.rentaitm.example/inspecciones/003/entrega_panoramica.jpg'),
	(4, 'https://fotos.rentaitm.example/inspecciones/004/devolucion_panoramica.jpg'),
	(5, 'https://fotos.rentaitm.example/inspecciones/005/entrega_panoramica.jpg'),
	(6, 'https://fotos.rentaitm.example/inspecciones/006/devolucion_panoramica.jpg'),
	(7, 'https://fotos.rentaitm.example/inspecciones/007/entrega_panoramica.jpg'),
	(8, 'https://fotos.rentaitm.example/inspecciones/008/devolucion_panoramica.jpg'),
	(9, 'https://fotos.rentaitm.example/inspecciones/009/entrega_panoramica.jpg'),
	(10, 'https://fotos.rentaitm.example/inspecciones/010/devolucion_panoramica.jpg'),
	(11, 'https://fotos.rentaitm.example/inspecciones/011/entrega_panoramica.jpg'),
	(12, 'https://fotos.rentaitm.example/inspecciones/012/devolucion_panoramica.jpg'),
	(13, 'https://fotos.rentaitm.example/inspecciones/013/entrega_panoramica.jpg'),
	(14, 'https://fotos.rentaitm.example/inspecciones/014/devolucion_panoramica.jpg'),
	(15, 'https://fotos.rentaitm.example/inspecciones/015/entrega_panoramica.jpg'),
	(16, 'https://fotos.rentaitm.example/inspecciones/016/devolucion_panoramica.jpg'),
	(17, 'https://fotos.rentaitm.example/inspecciones/017/entrega_panoramica.jpg'),
	(18, 'https://fotos.rentaitm.example/inspecciones/018/devolucion_panoramica.jpg'),
	(19, 'https://fotos.rentaitm.example/inspecciones/019/entrega_panoramica.jpg'),
	(20, 'https://fotos.rentaitm.example/inspecciones/020/devolucion_panoramica.jpg'),
	(21, 'https://fotos.rentaitm.example/inspecciones/021/entrega_panoramica.jpg'),
	(22, 'https://fotos.rentaitm.example/inspecciones/022/devolucion_panoramica.jpg'),
	(23, 'https://fotos.rentaitm.example/inspecciones/023/entrega_panoramica.jpg'),
	(24, 'https://fotos.rentaitm.example/inspecciones/024/devolucion_panoramica.jpg'),
	(25, 'https://fotos.rentaitm.example/inspecciones/025/entrega_panoramica.jpg'),
	(26, 'https://fotos.rentaitm.example/inspecciones/026/devolucion_panoramica.jpg'),
	(27, 'https://fotos.rentaitm.example/inspecciones/027/entrega_panoramica.jpg'),
	(28, 'https://fotos.rentaitm.example/inspecciones/028/devolucion_panoramica.jpg'),
	(29, 'https://fotos.rentaitm.example/inspecciones/029/entrega_panoramica.jpg'),
	(30, 'https://fotos.rentaitm.example/inspecciones/030/devolucion_panoramica.jpg'),
	(31, 'https://fotos.rentaitm.example/inspecciones/031/entrega_panoramica.jpg'),
	(32, 'https://fotos.rentaitm.example/inspecciones/032/devolucion_panoramica.jpg'),
	(33, 'https://fotos.rentaitm.example/inspecciones/033/entrega_panoramica.jpg'),
	(34, 'https://fotos.rentaitm.example/inspecciones/034/devolucion_panoramica.jpg'),
	(35, 'https://fotos.rentaitm.example/inspecciones/035/entrega_panoramica.jpg'),
	(36, 'https://fotos.rentaitm.example/inspecciones/036/devolucion_panoramica.jpg'),
	(37, 'https://fotos.rentaitm.example/inspecciones/037/entrega_panoramica.jpg'),
	(38, 'https://fotos.rentaitm.example/inspecciones/038/devolucion_panoramica.jpg'),
	(39, 'https://fotos.rentaitm.example/inspecciones/039/entrega_panoramica.jpg'),
	(40, 'https://fotos.rentaitm.example/inspecciones/040/devolucion_panoramica.jpg'),
	(41, 'https://fotos.rentaitm.example/inspecciones/041/entrega_panoramica.jpg'),
	(42, 'https://fotos.rentaitm.example/inspecciones/042/devolucion_panoramica.jpg'),
	(43, 'https://fotos.rentaitm.example/inspecciones/043/entrega_panoramica.jpg'),
	(44, 'https://fotos.rentaitm.example/inspecciones/044/devolucion_panoramica.jpg'),
	(45, 'https://fotos.rentaitm.example/inspecciones/045/entrega_panoramica.jpg'),
	(46, 'https://fotos.rentaitm.example/inspecciones/046/devolucion_panoramica.jpg'),
	(47, 'https://fotos.rentaitm.example/inspecciones/047/entrega_panoramica.jpg'),
	(48, 'https://fotos.rentaitm.example/inspecciones/048/devolucion_panoramica.jpg'),
	(49, 'https://fotos.rentaitm.example/inspecciones/049/entrega_panoramica.jpg'),
	(50, 'https://fotos.rentaitm.example/inspecciones/050/devolucion_panoramica.jpg'),
	(51, 'https://fotos.rentaitm.example/inspecciones/051/entrega_panoramica.jpg'),
	(52, 'https://fotos.rentaitm.example/inspecciones/052/devolucion_panoramica.jpg'),
	(53, 'https://fotos.rentaitm.example/inspecciones/053/entrega_panoramica.jpg'),
	(54, 'https://fotos.rentaitm.example/inspecciones/054/devolucion_panoramica.jpg'),
	(55, 'https://fotos.rentaitm.example/inspecciones/055/entrega_panoramica.jpg'),
	(56, 'https://fotos.rentaitm.example/inspecciones/056/devolucion_panoramica.jpg'),
	(57, 'https://fotos.rentaitm.example/inspecciones/057/entrega_panoramica.jpg'),
	(58, 'https://fotos.rentaitm.example/inspecciones/058/devolucion_panoramica.jpg'),
	(59, 'https://fotos.rentaitm.example/inspecciones/059/entrega_panoramica.jpg'),
	(60, 'https://fotos.rentaitm.example/inspecciones/060/devolucion_panoramica.jpg'),
	(61, 'https://fotos.rentaitm.example/inspecciones/061/entrega_panoramica.jpg'),
	(62, 'https://fotos.rentaitm.example/inspecciones/062/devolucion_panoramica.jpg'),
	(63, 'https://fotos.rentaitm.example/inspecciones/063/entrega_panoramica.jpg'),
	(64, 'https://fotos.rentaitm.example/inspecciones/064/devolucion_panoramica.jpg'),
	(65, 'https://fotos.rentaitm.example/inspecciones/065/entrega_panoramica.jpg'),
	(66, 'https://fotos.rentaitm.example/inspecciones/066/devolucion_panoramica.jpg'),
	(67, 'https://fotos.rentaitm.example/inspecciones/067/entrega_panoramica.jpg'),
	(68, 'https://fotos.rentaitm.example/inspecciones/068/devolucion_panoramica.jpg'),
	(69, 'https://fotos.rentaitm.example/inspecciones/069/entrega_panoramica.jpg'),
	(70, 'https://fotos.rentaitm.example/inspecciones/070/devolucion_panoramica.jpg'),
	(71, 'https://fotos.rentaitm.example/inspecciones/071/entrega_panoramica.jpg'),
	(72, 'https://fotos.rentaitm.example/inspecciones/072/devolucion_panoramica.jpg'),
	(73, 'https://fotos.rentaitm.example/inspecciones/073/entrega_panoramica.jpg'),
	(74, 'https://fotos.rentaitm.example/inspecciones/074/devolucion_panoramica.jpg'),
	(75, 'https://fotos.rentaitm.example/inspecciones/075/entrega_panoramica.jpg'),
	(76, 'https://fotos.rentaitm.example/inspecciones/076/devolucion_panoramica.jpg'),
	(77, 'https://fotos.rentaitm.example/inspecciones/077/entrega_panoramica.jpg'),
	(78, 'https://fotos.rentaitm.example/inspecciones/078/devolucion_panoramica.jpg'),
	(79, 'https://fotos.rentaitm.example/inspecciones/079/entrega_panoramica.jpg'),
	(80, 'https://fotos.rentaitm.example/inspecciones/080/devolucion_panoramica.jpg'),
	(81, 'https://fotos.rentaitm.example/inspecciones/081/entrega_panoramica.jpg'),
	(82, 'https://fotos.rentaitm.example/inspecciones/082/devolucion_panoramica.jpg'),
	(83, 'https://fotos.rentaitm.example/inspecciones/083/entrega_panoramica.jpg'),
	(84, 'https://fotos.rentaitm.example/inspecciones/084/devolucion_panoramica.jpg'),
	(85, 'https://fotos.rentaitm.example/inspecciones/085/entrega_panoramica.jpg'),
	(86, 'https://fotos.rentaitm.example/inspecciones/086/devolucion_panoramica.jpg'),
	(87, 'https://fotos.rentaitm.example/inspecciones/087/entrega_panoramica.jpg'),
	(88, 'https://fotos.rentaitm.example/inspecciones/088/devolucion_panoramica.jpg'),
	(89, 'https://fotos.rentaitm.example/inspecciones/089/entrega_panoramica.jpg'),
	(90, 'https://fotos.rentaitm.example/inspecciones/090/devolucion_panoramica.jpg'),
	(91, 'https://fotos.rentaitm.example/inspecciones/091/entrega_panoramica.jpg'),
	(92, 'https://fotos.rentaitm.example/inspecciones/092/devolucion_panoramica.jpg'),
	(93, 'https://fotos.rentaitm.example/inspecciones/093/entrega_panoramica.jpg'),
	(94, 'https://fotos.rentaitm.example/inspecciones/094/devolucion_panoramica.jpg'),
	(95, 'https://fotos.rentaitm.example/inspecciones/095/entrega_panoramica.jpg'),
	(96, 'https://fotos.rentaitm.example/inspecciones/096/devolucion_panoramica.jpg'),
	(97, 'https://fotos.rentaitm.example/inspecciones/097/entrega_panoramica.jpg'),
	(98, 'https://fotos.rentaitm.example/inspecciones/098/devolucion_panoramica.jpg'),
	(99, 'https://fotos.rentaitm.example/inspecciones/099/entrega_panoramica.jpg'),
	(100, 'https://fotos.rentaitm.example/inspecciones/100/devolucion_panoramica.jpg')
GO

SELECT * FROM FOTO_INSPECCION  -- TOTAL REGISTROS 100
GO

---   -----          ------          -----

/*
TABLA DANIO: 53 FILAS
53 DAÑOS: LOS 'PREVIO: ...' SE ANOTAN EN LA ENTREGA CON VALOR 0 (YA EXISTÍAN, NO SE COBRAN);
LOS DE LA DEVOLUCIÓN SÍ TIENEN VALOR Y SE COBRAN, SALVO SI LA PÓLIZA ES PREMIUM (CUBRIMIENTO TOTAL).
DAÑOS GRAVES DE LOS CLIENTES VETADOS: INSPECCIONES 34 (CLIENTE 73) Y 98 (CLIENTE 85).
*/

INSERT INTO DANIO(
ID_INSPECCION, DESCRIPCION, VALOR
)
VALUES(1, 'Previo: Desgaste en tapiceria del conductor', 0.00),  -- ID 1
	(3, 'Previo: Despique pequeno en parabrisas', 0.00),  -- ID 2
	(4, 'Parabrisas fisurado', 1100000.00),  -- ID 3
	(4, 'Rayones en costado derecho', 520000.00),  -- ID 4
	(5, 'Previo: Despique pequeno en parabrisas', 0.00),  -- ID 5
	(7, 'Previo: Rayon leve puerta trasera derecha', 0.00),  -- ID 6
	(8, 'Tapiceria rasgada', 400000.00),  -- ID 7
	(11, 'Previo: Rayon en rin delantero', 0.00),  -- ID 8
	(13, 'Previo: Rayon en tapa de combustible', 0.00),  -- ID 9
	(15, 'Previo: Rayon en rin delantero', 0.00),  -- ID 10
	(17, 'Previo: Desgaste en tapiceria del conductor', 0.00),  -- ID 11
	(18, 'Llanta pinchada sin reparar', 90000.00),  -- ID 12
	(18, 'Parabrisas fisurado', 1100000.00),  -- ID 13
	(21, 'Previo: Desgaste en volante', 0.00),  -- ID 14
	(22, 'Abolladura en capo', 720000.00),  -- ID 15
	(23, 'Previo: Rayon leve puerta trasera derecha', 0.00),  -- ID 16
	(24, 'Llanta pinchada sin reparar', 90000.00),  -- ID 17
	(24, 'Abolladura en capo', 720000.00),  -- ID 18
	(25, 'Previo: Desgaste en tapiceria del conductor', 0.00),  -- ID 19
	(26, 'Rin delantero doblado', 690000.00),  -- ID 20
	(26, 'Tapiceria rasgada', 400000.00),  -- ID 21
	(27, 'Previo: Golpe pequeno en parachoques trasero', 0.00),  -- ID 22
	(28, 'Tapiceria rasgada', 400000.00),  -- ID 23
	(31, 'Previo: Abolladura leve en baul', 0.00),  -- ID 24
	(33, 'Previo: Despique pequeno en parabrisas', 0.00),  -- ID 25
	(34, 'Choque frontal con dano en radiador y capo', 6200000.00),  -- ID 26
	(35, 'Previo: Abolladura leve en baul', 0.00),  -- ID 27
	(37, 'Previo: Rayon en espejo izquierdo', 0.00),  -- ID 28
	(41, 'Previo: Rayon en espejo izquierdo', 0.00),  -- ID 29
	(43, 'Previo: Desgaste en volante', 0.00),  -- ID 30
	(45, 'Previo: Rayon en espejo izquierdo', 0.00),  -- ID 31
	(47, 'Previo: Tapete trasero manchado', 0.00),  -- ID 32
	(51, 'Previo: Rayon en rin delantero', 0.00),  -- ID 33
	(52, 'Rin delantero doblado', 690000.00),  -- ID 34
	(52, 'Golpe en parachoques delantero', 650000.00),  -- ID 35
	(53, 'Previo: Tapete trasero manchado', 0.00),  -- ID 36
	(55, 'Previo: Desgaste en tapiceria del conductor', 0.00),  -- ID 37
	(57, 'Previo: Rayon leve puerta trasera derecha', 0.00),  -- ID 38
	(60, 'Rayon profundo en puerta del conductor', 380000.00),  -- ID 39
	(60, 'Llanta pinchada sin reparar', 90000.00),  -- ID 40
	(61, 'Previo: Rayon en rin delantero', 0.00),  -- ID 41
	(63, 'Previo: Desgaste en volante', 0.00),  -- ID 42
	(65, 'Previo: Desgaste en tapiceria del conductor', 0.00),  -- ID 43
	(66, 'Stop trasero roto', 300000.00),  -- ID 44
	(66, 'Quemadura de cigarrillo en silla trasera', 250000.00),  -- ID 45
	(67, 'Previo: Desgaste en tapiceria del conductor', 0.00),  -- ID 46
	(70, 'Rin delantero doblado', 690000.00),  -- ID 47
	(71, 'Previo: Tapete trasero manchado', 0.00),  -- ID 48
	(73, 'Previo: Rayon leve puerta trasera derecha', 0.00),  -- ID 49
	(92, 'Stop trasero roto', 300000.00),  -- ID 50
	(92, 'Rin delantero doblado', 690000.00),  -- ID 51
	(94, 'Rayon profundo en puerta del conductor', 380000.00),  -- ID 52
	(98, 'Volcamiento parcial con dano en techo', 9800000.00)  -- ID 53
GO

SELECT * FROM DANIO  -- TOTAL REGISTROS 53
GO

---   -----          ------          -----

/*
TABLA ENCUESTA: 50 FILAS
50 ENCUESTAS (1 POR ALQUILER), CALIFICACIONES DE 1 A 5. SON MÁS BAJAS CUANDO HUBO RETRASO O DAÑOS.
*/

INSERT INTO ENCUESTA(
ID_ALQUILER, CALIF_SERVICIO, CALIF_VEHICULO, COMENTARIO
)
VALUES(1, 5, 2, 'El vehiculo tenia detalles de aseo'),  -- ID 1
	(2, 4, 5, 'Buen servicio, el carro en buen estado'),  -- ID 2
	(3, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 3
	(4, 4, 4, 'Buen servicio, el carro en buen estado'),  -- ID 4
	(5, 5, 4, 'Buen servicio, el carro en buen estado'),  -- ID 5
	(6, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 6
	(7, 5, 4, 'Buen servicio, el carro en buen estado'),  -- ID 7
	(8, 4, 4, 'Buen servicio, el carro en buen estado'),  -- ID 8
	(9, 4, 4, 'Buen servicio, el carro en buen estado'),  -- ID 9
	(10, 4, 5, 'Buen servicio, el carro en buen estado'),  -- ID 10
	(11, 4, 5, 'Buen servicio, el carro en buen estado'),  -- ID 11
	(12, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 12
	(13, 3, 5, 'Servicio aceptable, la entrega demoro'),  -- ID 13
	(14, 4, 4, 'Buen servicio, el carro en buen estado'),  -- ID 14
	(15, 5, 4, 'Buen servicio, el carro en buen estado'),  -- ID 15
	(16, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 16
	(17, 5, 4, 'Buen servicio, el carro en buen estado'),  -- ID 17
	(18, 4, 5, 'Buen servicio, el carro en buen estado'),  -- ID 18
	(19, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 19
	(20, 4, 4, 'Buen servicio, el carro en buen estado'),  -- ID 20
	(21, 5, 4, 'Buen servicio, el carro en buen estado'),  -- ID 21
	(22, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 22
	(23, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 23
	(24, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 24
	(25, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 25
	(26, 4, 4, 'Buen servicio, el carro en buen estado'),  -- ID 26
	(27, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 27
	(28, 3, 5, 'Servicio aceptable, la entrega demoro'),  -- ID 28
	(29, 5, 4, 'Buen servicio, el carro en buen estado'),  -- ID 29
	(30, 5, 4, 'Buen servicio, el carro en buen estado'),  -- ID 30
	(31, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 31
	(32, 4, 5, 'Buen servicio, el carro en buen estado'),  -- ID 32
	(33, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 33
	(34, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 34
	(35, 3, 4, 'Servicio aceptable, la entrega demoro'),  -- ID 35
	(36, 5, 4, 'Buen servicio, el carro en buen estado'),  -- ID 36
	(37, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 37
	(38, 5, 4, 'Buen servicio, el carro en buen estado'),  -- ID 38
	(39, 4, 5, 'Buen servicio, el carro en buen estado'),  -- ID 39
	(40, 5, 2, 'El vehiculo tenia detalles de aseo'),  -- ID 40
	(41, 4, 4, 'Buen servicio, el carro en buen estado'),  -- ID 41
	(42, 3, 5, 'Servicio aceptable, la entrega demoro'),  -- ID 42
	(43, 5, 4, 'Buen servicio, el carro en buen estado'),  -- ID 43
	(44, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 44
	(45, 4, 2, 'El vehiculo tenia detalles de aseo'),  -- ID 45
	(46, 4, 4, 'Buen servicio, el carro en buen estado'),  -- ID 46
	(47, 3, 4, 'Servicio aceptable, la entrega demoro'),  -- ID 47
	(48, 5, 5, 'Excelente servicio, todo muy rapido'),  -- ID 48
	(49, 4, 4, 'Buen servicio, el carro en buen estado'),  -- ID 49
	(50, 5, 5, 'Excelente servicio, todo muy rapido')  -- ID 50
GO

SELECT * FROM ENCUESTA  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----


--  ======================================================
--  FACTURACION Y PAGOS (ESPECIALIZACION PAGO -> TARJETA / EFECTIVO)
--  ======================================================

/*
TABLA FACTURA: 50 FILAS
50 FACTURAS (1 POR ALQUILER, EN LA FECHA DE DEVOLUCIÓN). TOTAL = SUMA DE SU DETALLE.
*/

INSERT INTO FACTURA(
ID_ALQUILER, CODIGO, FECHA, TOTAL
)
VALUES(1, 'FV-2025-00001', '20250111', 1026000.00),  -- ID 1
	(2, 'FV-2025-00002', '20250203', 3670000.00),  -- ID 2
	(3, 'FV-2025-00003', '20250210', 1886505.00),  -- ID 3
	(4, 'FV-2025-00004', '20250227', 4486000.00),  -- ID 4
	(5, 'FV-2025-00005', '20250314', 2207644.00),  -- ID 5
	(6, 'FV-2025-00006', '20250321', 1360080.00),  -- ID 6
	(7, 'FV-2025-00007', '20250404', 1435000.00),  -- ID 7
	(8, 'FV-2025-00008', '20250412', 614376.00),  -- ID 8
	(9, 'FV-2025-00009', '20250502', 3053000.00),  -- ID 9
	(10, 'FV-2025-00010', '20250510', 621000.00),  -- ID 10
	(11, 'FV-2025-00011', '20250524', 1222000.00),  -- ID 11
	(12, 'FV-2025-00012', '20250603', 796800.00),  -- ID 12
	(13, 'FV-2025-00013', '20250618', 2398000.00),  -- ID 13
	(14, 'FV-2025-00014', '20250710', 5428000.00),  -- ID 14
	(15, 'FV-2025-00015', '20250721', 1586880.00),  -- ID 15
	(16, 'FV-2025-00016', '20250729', 1690000.00),  -- ID 16
	(17, 'FV-2025-00017', '20250814', 7973800.00),  -- ID 17
	(18, 'FV-2025-00018', '20250823', 1531300.00),  -- ID 18
	(19, 'FV-2025-00019', '20250904', 817000.00),  -- ID 19
	(20, 'FV-2025-00020', '20250918', 1180000.00),  -- ID 20
	(21, 'FV-2025-00021', '20251001', 804000.00),  -- ID 21
	(22, 'FV-2025-00022', '20251013', 835200.00),  -- ID 22
	(23, 'FV-2025-00023', '20251025', 907200.00),  -- ID 23
	(24, 'FV-2025-00024', '20251116', 5908000.00),  -- ID 24
	(25, 'FV-2025-00025', '20251120', 672000.00),  -- ID 25
	(26, 'FV-2025-00026', '20251203', 1053852.00),  -- ID 26
	(27, 'FV-2025-00027', '20251218', 707820.00),  -- ID 27
	(28, 'FV-2026-00028', '20260105', 2441200.00),  -- ID 28
	(29, 'FV-2026-00029', '20260117', 2680000.00),  -- ID 29
	(30, 'FV-2026-00030', '20260130', 1776000.00),  -- ID 30
	(31, 'FV-2026-00031', '20260209', 1122400.00),  -- ID 31
	(32, 'FV-2026-00032', '20260220', 1189120.00),  -- ID 32
	(33, 'FV-2026-00033', '20260308', 1953500.00),  -- ID 33
	(34, 'FV-2026-00034', '20260319', 1205738.00),  -- ID 34
	(35, 'FV-2026-00035', '20260406', 2842300.00),  -- ID 35
	(36, 'FV-2026-00036', '20260413', 1214980.00),  -- ID 36
	(37, 'FV-2026-00037', '20260425', 642600.00),  -- ID 37
	(38, 'FV-2026-00038', '20260513', 1359400.00),  -- ID 38
	(39, 'FV-2026-00039', '20260528', 2967580.00),  -- ID 39
	(40, 'FV-2026-00040', '20260609', 1244344.00),  -- ID 40
	(41, 'FV-2026-00041', '20260625', 3091000.00),  -- ID 41
	(42, 'FV-2026-00042', '20260708', 4121000.00),  -- ID 42
	(43, 'FV-2026-00043', '20260718', 1400000.00),  -- ID 43
	(44, 'FV-2026-00044', '20260724', 804000.00),  -- ID 44
	(45, 'FV-2026-00045', '20260809', 712000.00),  -- ID 45
	(46, 'FV-2026-00046', '20260824', 1855000.00),  -- ID 46
	(47, 'FV-2026-00047', '20260903', 1451000.00),  -- ID 47
	(48, 'FV-2026-00048', '20260914', 981000.00),  -- ID 48
	(49, 'FV-2026-00049', '20260928', 10429000.00),  -- ID 49
	(50, 'FV-2026-00050', '20261013', 1476748.00)  -- ID 50
GO

SELECT * FROM FACTURA  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----

/*
TABLA DETALLE_FACTURA: 95 FILAS
95 LÍNEAS. LÍNEA 1 = ALQUILER (DÍAS X (TARIFA + VALOR DIARIO DE LA PÓLIZA)). CARGOS DE LA DEVOLUCIÓN:
  RETRASO      = 1 DÍA DE TARIFA LAS PRIMERAS 24 H; LUEGO 2 DÍAS DE TARIFA POR CADA DÍA ADICIONAL.
  EXCESO_KM    = KM EXTRA (SOBRE 200 KM/DÍA, SOLO POR_DIA) X (TARIFA / 200).
  COMBUSTIBLE  = (100 - NIVEL DE GASOLINA) X 2.200 COP.
  DANIO        = SUMA DE LOS DAÑOS DE LA DEVOLUCIÓN (NO SE COBRA CON PÓLIZA PREMIUM).
  DESCUENTO_CONVENIO = -% DEL CONVENIO X LÍNEA ALQUILER (NUNCA SOBRE MULTAS NI CARGOS). ÚNICA LÍNEA NEGATIVA.
*/

INSERT INTO DETALLE_FACTURA(
ID_FACTURA, LINEA, CONCEPTO, VALOR
)
VALUES(1, 1, 'ALQUILER', 894000.00),
	(1, 2, 'COMBUSTIBLE', 132000.00),
	(2, 1, 'ALQUILER', 2050000.00),
	(2, 2, 'DANIO', 1620000.00),
	(3, 1, 'ALQUILER', 2028500.00),
	(3, 2, 'DESCUENTO_CONVENIO', -141995.00),
	(4, 1, 'ALQUILER', 4486000.00),
	(5, 1, 'ALQUILER', 1942000.00),
	(5, 2, 'EXCESO_KM', 265644.00),
	(6, 1, 'ALQUILER', 1236000.00),
	(6, 2, 'EXCESO_KM', 124080.00),
	(7, 1, 'ALQUILER', 1435000.00),
	(8, 1, 'ALQUILER', 667800.00),
	(8, 2, 'DESCUENTO_CONVENIO', -53424.00),
	(9, 1, 'ALQUILER', 1699200.00),
	(9, 2, 'RETRASO', 163800.00),
	(9, 3, 'DANIO', 1190000.00),
	(10, 1, 'ALQUILER', 621000.00),
	(11, 1, 'ALQUILER', 1300000.00),
	(11, 2, 'DESCUENTO_CONVENIO', -78000.00),
	(12, 1, 'ALQUILER', 763800.00),
	(12, 2, 'COMBUSTIBLE', 33000.00),
	(13, 1, 'ALQUILER', 1308000.00),
	(13, 2, 'DANIO', 1090000.00),
	(14, 1, 'ALQUILER', 3708000.00),
	(14, 2, 'RETRASO', 1320000.00),
	(14, 3, 'DANIO', 400000.00),
	(15, 1, 'ALQUILER', 1670400.00),
	(15, 2, 'DESCUENTO_CONVENIO', -83520.00),
	(16, 1, 'ALQUILER', 1635000.00),
	(16, 2, 'COMBUSTIBLE', 55000.00),
	(17, 1, 'ALQUILER', 1773800.00),
	(17, 2, 'DANIO', 6200000.00),
	(18, 1, 'ALQUILER', 1300000.00),
	(18, 2, 'EXCESO_KM', 231300.00),
	(19, 1, 'ALQUILER', 860000.00),
	(19, 2, 'DESCUENTO_CONVENIO', -43000.00),
	(20, 1, 'ALQUILER', 1125000.00),
	(20, 2, 'COMBUSTIBLE', 55000.00),
	(21, 1, 'ALQUILER', 804000.00),
	(22, 1, 'ALQUILER', 835200.00),
	(23, 1, 'ALQUILER', 675000.00),
	(23, 2, 'EXCESO_KM', 232200.00),
	(24, 1, 'ALQUILER', 5820000.00),
	(24, 2, 'COMBUSTIBLE', 88000.00),
	(25, 1, 'ALQUILER', 672000.00),
	(26, 1, 'ALQUILER', 747600.00),
	(26, 2, 'EXCESO_KM', 306252.00),
	(27, 1, 'ALQUILER', 753000.00),
	(27, 2, 'DESCUENTO_CONVENIO', -45180.00),
	(28, 1, 'ALQUILER', 1435000.00),
	(28, 2, 'RETRASO', 900000.00),
	(28, 3, 'EXCESO_KM', 106200.00),
	(29, 1, 'ALQUILER', 2680000.00),
	(30, 1, 'ALQUILER', 1306000.00),
	(30, 2, 'DANIO', 470000.00),
	(31, 1, 'ALQUILER', 1034400.00),
	(31, 2, 'COMBUSTIBLE', 88000.00),
	(32, 1, 'ALQUILER', 748000.00),
	(32, 2, 'RETRASO', 486000.00),
	(32, 3, 'DESCUENTO_CONVENIO', -44880.00),
	(33, 1, 'ALQUILER', 1403500.00),
	(33, 2, 'DANIO', 550000.00),
	(34, 1, 'ALQUILER', 1303500.00),
	(34, 2, 'DESCUENTO_CONVENIO', -97762.00),
	(35, 1, 'ALQUILER', 2371000.00),
	(35, 2, 'RETRASO', 471300.00),
	(36, 1, 'ALQUILER', 388400.00),
	(36, 2, 'RETRASO', 846000.00),
	(36, 3, 'DESCUENTO_CONVENIO', -19420.00),
	(37, 1, 'ALQUILER', 642600.00),
	(38, 1, 'ALQUILER', 1359400.00),
	(39, 1, 'ALQUILER', 3157000.00),
	(39, 2, 'DESCUENTO_CONVENIO', -189420.00),
	(40, 1, 'ALQUILER', 1173200.00),
	(40, 2, 'COMBUSTIBLE', 165000.00),
	(40, 3, 'DESCUENTO_CONVENIO', -93856.00),
	(41, 1, 'ALQUILER', 1876000.00),
	(41, 2, 'RETRASO', 1215000.00),
	(42, 1, 'ALQUILER', 3160000.00),
	(42, 2, 'RETRASO', 873000.00),
	(42, 3, 'COMBUSTIBLE', 88000.00),
	(43, 1, 'ALQUILER', 1400000.00),
	(44, 1, 'ALQUILER', 804000.00),
	(45, 1, 'ALQUILER', 580000.00),
	(45, 2, 'COMBUSTIBLE', 132000.00),
	(46, 1, 'ALQUILER', 1855000.00),
	(47, 1, 'ALQUILER', 1071000.00),
	(47, 2, 'DANIO', 380000.00),
	(48, 1, 'ALQUILER', 981000.00),
	(49, 1, 'ALQUILER', 596000.00),
	(49, 2, 'COMBUSTIBLE', 33000.00),
	(49, 3, 'DANIO', 9800000.00),
	(50, 1, 'ALQUILER', 1622800.00),
	(50, 2, 'DESCUENTO_CONVENIO', -146052.00)
GO

SELECT * FROM DETALLE_FACTURA  -- TOTAL REGISTROS 95
GO

---   -----          ------          -----

/*
TABLA PAGO: 100 FILAS
100 PAGOS = 2 POR FACTURA: EL ANTICIPO (EN LA ENTREGA) Y EL SALDO (EN LA DEVOLUCIÓN). LOS REGISTRAN CAJEROS.
LOS MOROSOS SOLO ABONARON EL 40 % DEL SALDO: POR ESO DEBEN DINERO.
MONTOS EN COP; MONEDA = MONEDA EN LA QUE PAGÓ EL CLIENTE (SE CONVIERTE CON LA TRM).
*/

INSERT INTO PAGO(
ID_FACTURA, ID_EMPLEADO, FECHA, VALOR, MONEDA
)
VALUES(1, 29, '20250108', 268200.00, 'COP'),  -- ID 1
	(1, 38, '20250111', 303120.00, 'COP'),  -- ID 2
	(2, 32, '20250124', 615000.00, 'COP'),  -- ID 3
	(2, 32, '20250203', 3055000.00, 'COP'),  -- ID 4
	(3, 43, '20250205', 565952.00, 'COP'),  -- ID 5
	(3, 35, '20250210', 1320553.00, 'COP'),  -- ID 6
	(4, 32, '20250217', 1345800.00, 'COP'),  -- ID 7
	(4, 34, '20250227', 3140200.00, 'COP'),  -- ID 8
	(5, 48, '20250304', 582600.00, 'COP'),  -- ID 9
	(5, 36, '20250314', 650018.00, 'COP'),  -- ID 10
	(6, 32, '20250317', 370800.00, 'COP'),  -- ID 11
	(6, 34, '20250321', 989280.00, 'COP'),  -- ID 12
	(7, 46, '20250328', 430500.00, 'EUR'),  -- ID 13
	(7, 40, '20250404', 1004500.00, 'EUR'),  -- ID 14
	(8, 34, '20250409', 184313.00, 'USD'),  -- ID 15
	(8, 44, '20250412', 430063.00, 'USD'),  -- ID 16
	(9, 38, '20250423', 509760.00, 'COP'),  -- ID 17
	(9, 31, '20250502', 1017296.00, 'COP'),  -- ID 18
	(10, 42, '20250507', 186300.00, 'COP'),  -- ID 19
	(10, 50, '20250510', 434700.00, 'COP'),  -- ID 20
	(11, 50, '20250519', 366600.00, 'COP'),  -- ID 21
	(11, 32, '20250524', 855400.00, 'COP'),  -- ID 22
	(12, 49, '20250531', 229140.00, 'COP'),  -- ID 23
	(12, 45, '20250603', 567660.00, 'COP'),  -- ID 24
	(13, 32, '20250614', 392400.00, 'COP'),  -- ID 25
	(13, 48, '20250618', 802240.00, 'COP'),  -- ID 26
	(14, 37, '20250626', 1112400.00, 'USD'),  -- ID 27
	(14, 43, '20250710', 4315600.00, 'USD'),  -- ID 28
	(15, 36, '20250712', 476064.00, 'COP'),  -- ID 29
	(15, 35, '20250721', 1110816.00, 'COP'),  -- ID 30
	(16, 42, '20250724', 490500.00, 'COP'),  -- ID 31
	(16, 46, '20250729', 1199500.00, 'COP'),  -- ID 32
	(17, 43, '20250807', 532140.00, 'COP'),  -- ID 33
	(17, 44, '20250814', 7441660.00, 'COP'),  -- ID 34
	(18, 34, '20250818', 390000.00, 'COP'),  -- ID 35
	(18, 42, '20250823', 1141300.00, 'COP'),  -- ID 36
	(19, 35, '20250902', 245100.00, 'COP'),  -- ID 37
	(19, 32, '20250904', 571900.00, 'COP'),  -- ID 38
	(20, 32, '20250913', 337500.00, 'COP'),  -- ID 39
	(20, 48, '20250918', 842500.00, 'COP'),  -- ID 40
	(21, 29, '20250928', 241200.00, 'COP'),  -- ID 41
	(21, 32, '20251001', 562800.00, 'COP'),  -- ID 42
	(22, 40, '20251009', 250560.00, 'USD'),  -- ID 43
	(22, 42, '20251013', 584640.00, 'USD'),  -- ID 44
	(23, 46, '20251022', 202500.00, 'COP'),  -- ID 45
	(23, 40, '20251025', 704700.00, 'COP'),  -- ID 46
	(24, 40, '20251104', 1746000.00, 'COP'),  -- ID 47
	(24, 29, '20251116', 4162000.00, 'COP'),  -- ID 48
	(25, 42, '20251118', 201600.00, 'COP'),  -- ID 49
	(25, 46, '20251120', 470400.00, 'COP'),  -- ID 50
	(26, 39, '20251130', 224280.00, 'COP'),  -- ID 51
	(26, 31, '20251203', 829572.00, 'COP'),  -- ID 52
	(27, 40, '20251213', 212346.00, 'COP'),  -- ID 53
	(27, 46, '20251218', 495474.00, 'COP'),  -- ID 54
	(28, 32, '20251227', 430500.00, 'COP'),  -- ID 55
	(28, 32, '20260105', 2010700.00, 'COP'),  -- ID 56
	(29, 36, '20260107', 804000.00, 'COP'),  -- ID 57
	(29, 43, '20260117', 1876000.00, 'COP'),  -- ID 58
	(30, 49, '20260120', 391800.00, 'COP'),  -- ID 59
	(30, 34, '20260130', 1384200.00, 'COP'),  -- ID 60
	(31, 34, '20260203', 310320.00, 'COP'),  -- ID 61
	(31, 31, '20260209', 812080.00, 'COP'),  -- ID 62
	(32, 30, '20260215', 210936.00, 'COP'),  -- ID 63
	(32, 32, '20260220', 391274.00, 'COP'),  -- ID 64
	(33, 31, '20260303', 421050.00, 'COP'),  -- ID 65
	(33, 45, '20260308', 1532450.00, 'COP'),  -- ID 66
	(34, 40, '20260314', 361721.00, 'COP'),  -- ID 67
	(34, 45, '20260319', 844017.00, 'COP'),  -- ID 68
	(35, 39, '20260326', 711300.00, 'COP'),  -- ID 69
	(35, 31, '20260406', 852400.00, 'COP'),  -- ID 70
	(36, 43, '20260409', 110694.00, 'COP'),  -- ID 71
	(36, 38, '20260413', 1104286.00, 'COP'),  -- ID 72
	(37, 45, '20260422', 192780.00, 'COP'),  -- ID 73
	(37, 32, '20260425', 449820.00, 'COP'),  -- ID 74
	(38, 34, '20260506', 407820.00, 'COP'),  -- ID 75
	(38, 40, '20260513', 951580.00, 'COP'),  -- ID 76
	(39, 45, '20260518', 890274.00, 'USD'),  -- ID 77
	(39, 36, '20260528', 2077306.00, 'USD'),  -- ID 78
	(40, 30, '20260602', 323803.00, 'COP'),  -- ID 79
	(40, 39, '20260609', 920541.00, 'COP'),  -- ID 80
	(41, 37, '20260615', 562800.00, 'COP'),  -- ID 81
	(41, 44, '20260625', 2528200.00, 'COP'),  -- ID 82
	(42, 37, '20260627', 948000.00, 'COP'),  -- ID 83
	(42, 43, '20260708', 3173000.00, 'COP'),  -- ID 84
	(43, 46, '20260711', 420000.00, 'COP'),  -- ID 85
	(43, 45, '20260718', 980000.00, 'COP'),  -- ID 86
	(44, 31, '20260721', 241200.00, 'COP'),  -- ID 87
	(44, 31, '20260724', 562800.00, 'COP'),  -- ID 88
	(45, 31, '20260805', 174000.00, 'COP'),  -- ID 89
	(45, 31, '20260809', 538000.00, 'COP'),  -- ID 90
	(46, 43, '20260819', 556500.00, 'COP'),  -- ID 91
	(46, 38, '20260824', 1298500.00, 'COP'),  -- ID 92
	(47, 34, '20260829', 321300.00, 'USD'),  -- ID 93
	(47, 29, '20260903', 1129700.00, 'USD'),  -- ID 94
	(48, 45, '20260911', 294300.00, 'COP'),  -- ID 95
	(48, 40, '20260914', 686700.00, 'COP'),  -- ID 96
	(49, 42, '20260926', 178800.00, 'COP'),  -- ID 97
	(49, 31, '20260928', 10250200.00, 'COP'),  -- ID 98
	(50, 45, '20261009', 443024.00, 'COP'),  -- ID 99
	(50, 35, '20261013', 1033724.00, 'COP')  -- ID 100
GO

SELECT * FROM PAGO  -- TOTAL REGISTROS 100
GO

---   -----          ------          -----

/*
TABLA PAGO_TARJETA: 50 FILAS
50 PAGOS CON TARJETA (ESPECIALIZACIÓN DISJUNTA: UN PAGO ES TARJETA O EFECTIVO). SOLO ÚLTIMOS 4 DÍGITOS.
*/

INSERT INTO PAGO_TARJETA(
ID_PAGO, ULTIMOS4, FRANQUICIA
)
VALUES(1, '2212', 'DINERS'),
	(4, '7030', 'DINERS'),
	(5, '4946', 'DINERS'),
	(8, '7674', 'VISA'),
	(9, '5351', 'DINERS'),
	(12, '2408', 'MASTERCARD'),
	(13, '8022', 'DINERS'),
	(16, '2194', 'MASTERCARD'),
	(17, '5157', 'VISA'),
	(20, '2952', 'VISA'),
	(21, '2726', 'MASTERCARD'),
	(24, '1868', 'MASTERCARD'),
	(25, '8379', 'VISA'),
	(28, '2848', 'DINERS'),
	(29, '8865', 'DINERS'),
	(32, '3619', 'DINERS'),
	(33, '1920', 'MASTERCARD'),
	(36, '7600', 'MASTERCARD'),
	(37, '3231', 'VISA'),
	(40, '2726', 'MASTERCARD'),
	(41, '3861', 'AMERICAN_EXPRESS'),
	(44, '4464', 'VISA'),
	(45, '9484', 'AMERICAN_EXPRESS'),
	(48, '7875', 'MASTERCARD'),
	(49, '1227', 'VISA'),
	(52, '8360', 'AMERICAN_EXPRESS'),
	(53, '4717', 'DINERS'),
	(56, '7674', 'VISA'),
	(57, '1688', 'VISA'),
	(60, '9023', 'DINERS'),
	(61, '3654', 'MASTERCARD'),
	(64, '5157', 'AMERICAN_EXPRESS'),
	(65, '0172', 'VISA'),
	(68, '4808', 'MASTERCARD'),
	(69, '8379', 'DINERS'),
	(72, '1902', 'MASTERCARD'),
	(73, '4717', 'AMERICAN_EXPRESS'),
	(76, '9399', 'AMERICAN_EXPRESS'),
	(77, '2194', 'MASTERCARD'),
	(80, '1003', 'VISA'),
	(81, '2222', 'AMERICAN_EXPRESS'),
	(84, '1526', 'MASTERCARD'),
	(85, '3914', 'VISA'),
	(88, '9399', 'AMERICAN_EXPRESS'),
	(89, '4781', 'MASTERCARD'),
	(92, '3231', 'DINERS'),
	(93, '1754', 'VISA'),
	(96, '1688', 'AMERICAN_EXPRESS'),
	(97, '6190', 'MASTERCARD'),
	(100, '4781', 'MASTERCARD')
GO

SELECT * FROM PAGO_TARJETA  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----

/*
TABLA PAGO_EFECTIVO: 50 FILAS
50 PAGOS EN EFECTIVO. CAMBIO = VALOR_RECIBIDO - PAGO.VALOR (CUADRE DE CAJA).
*/

INSERT INTO PAGO_EFECTIVO(
ID_PAGO, VALOR_RECIBIDO, CAMBIO
)
VALUES(2, 350000.00, 46880.00),
	(3, 650000.00, 35000.00),
	(6, 1350000.00, 29447.00),
	(7, 1350000.00, 4200.00),
	(10, 700000.00, 49982.00),
	(11, 400000.00, 29200.00),
	(14, 1050000.00, 45500.00),
	(15, 200000.00, 15687.00),
	(18, 1050000.00, 32704.00),
	(19, 200000.00, 13700.00),
	(22, 900000.00, 44600.00),
	(23, 250000.00, 20860.00),
	(26, 850000.00, 47760.00),
	(27, 1150000.00, 37600.00),
	(30, 1150000.00, 39184.00),
	(31, 500000.00, 9500.00),
	(34, 7450000.00, 8340.00),
	(35, 400000.00, 10000.00),
	(38, 600000.00, 28100.00),
	(39, 350000.00, 12500.00),
	(42, 600000.00, 37200.00),
	(43, 300000.00, 49440.00),
	(46, 750000.00, 45300.00),
	(47, 1750000.00, 4000.00),
	(50, 500000.00, 29600.00),
	(51, 250000.00, 25720.00),
	(54, 500000.00, 4526.00),
	(55, 450000.00, 19500.00),
	(58, 1900000.00, 24000.00),
	(59, 400000.00, 8200.00),
	(62, 850000.00, 37920.00),
	(63, 250000.00, 39064.00),
	(66, 1550000.00, 17550.00),
	(67, 400000.00, 38279.00),
	(70, 900000.00, 47600.00),
	(71, 150000.00, 39306.00),
	(74, 450000.00, 180.00),
	(75, 450000.00, 42180.00),
	(78, 2100000.00, 22694.00),
	(79, 350000.00, 26197.00),
	(82, 2550000.00, 21800.00),
	(83, 950000.00, 2000.00),
	(86, 1000000.00, 20000.00),
	(87, 250000.00, 8800.00),
	(90, 550000.00, 12000.00),
	(91, 600000.00, 43500.00),
	(94, 1150000.00, 20300.00),
	(95, 300000.00, 5700.00),
	(98, 10300000.00, 49800.00),
	(99, 450000.00, 6976.00)
GO

SELECT * FROM PAGO_EFECTIVO  -- TOTAL REGISTROS 50
GO

---   -----          ------          -----


-- ===========================================================
-- PASO 3: VERIFICACION DE LOS DATOS
-- ===========================================================




-- LOS SIGUIENTES 11 CONTROLES DEBEN DAR 0 REGISTROS.
-- SI SALE ALGUNA FILA, ESE DATO NO CUMPLE UNA REGLA DEL CASO.

/*
CONSULTA DE CONTROL 1:
EL STOCK DE RESPALDO NUNCA SE RESERVA (EL CASO DICE QUE NO SE PUEDE RESERVAR)
*/

SELECT R.ID_RESERVA, V.PLACA
FROM RESERVA R  -- "R" es el alias de RESERVA
INNER JOIN VEHICULO V ON V.ID_VEHICULO = R.ID_VEHICULO  -- Se iguala PK con FK
WHERE V.ES_RESPALDO = 1  -- TOTAL REGISTROS 0
GO

---      -----

/*
CONSULTA DE CONTROL 2:
EL TOTAL DE CADA FACTURA ES IGUAL A LA SUMA DE SU DETALLE
*/

SELECT F.ID_FACTURA, F.TOTAL, SUM(DF.VALOR) AS SUMA_DETALLE
FROM FACTURA F
INNER JOIN DETALLE_FACTURA DF ON DF.ID_FACTURA = F.ID_FACTURA
GROUP BY F.ID_FACTURA, F.TOTAL
HAVING F.TOTAL > SUM(DF.VALOR) OR F.TOTAL < SUM(DF.VALOR)  -- MAYOR O MENOR = DIFERENTE  -- TOTAL REGISTROS 0
GO

---      -----

/*
CONSULTA DE CONTROL 3:
EL VALOR TOTAL DEL ALQUILER ES IGUAL AL TOTAL DE SU FACTURA
*/

SELECT A.ID_ALQUILER, A.VALOR_TOTAL, F.TOTAL
FROM ALQUILER A
INNER JOIN FACTURA F ON F.ID_ALQUILER = A.ID_ALQUILER
WHERE A.VALOR_TOTAL > F.TOTAL OR A.VALOR_TOTAL < F.TOTAL  -- TOTAL REGISTROS 0
GO

---      -----

/*
CONSULTA DE CONTROL 4:
EL KILOMETRAJE DE LA DEVOLUCION ES MAYOR QUE EL DE LA ENTREGA
*/

SELECT EN.ID_ALQUILER, EN.KILOMETRAJE AS KM_ENTREGA, DE.KILOMETRAJE AS KM_DEVOLUCION
FROM INSPECCION EN  -- "EN" = ACTA DE ENTREGA
INNER JOIN INSPECCION DE ON DE.ID_ALQUILER = EN.ID_ALQUILER  -- "DE" = ACTA DE DEVOLUCION DEL MISMO ALQUILER
WHERE EN.ID_TIPO_INSPECCION = 1 AND DE.ID_TIPO_INSPECCION = 2
AND DE.KILOMETRAJE <= EN.KILOMETRAJE  -- TOTAL REGISTROS 0
GO

---      -----

/*
CONSULTA DE CONTROL 5:
LA LICENCIA DEL CLIENTE ESTABA VIGENTE EL DIA DE LA ENTREGA
*/

SELECT A.ID_ALQUILER, C.ID_CLIENTE, C.VENCIMIENTO_LICENCIA, A.FECHA_ENTREGA
FROM ALQUILER A
INNER JOIN RESERVA R ON R.ID_RESERVA = A.ID_RESERVA
INNER JOIN CLIENTE C ON C.ID_CLIENTE = R.ID_CLIENTE
WHERE DATEDIFF(DAY, A.FECHA_ENTREGA, C.VENCIMIENTO_LICENCIA) < 0  -- DIAS DE LA ENTREGA AL VENCIMIENTO  -- TOTAL REGISTROS 0
GO

---      -----

/*
CONSULTA DE CONTROL 6:
LA CATEGORIA DE LICENCIA DEL CLIENTE SIRVE PARA EL VEHICULO
(UN VEHICULO B1 NO SE LE ENTREGA A LICENCIA A1 O A2,
Y UNA VAN B2 NO SE LE ENTREGA A LICENCIA A1, A2, B1 O C1)
*/

SELECT R.ID_RESERVA, V.CATEGORIA_LICENCIA AS LICENCIA_VEHICULO, C.CATEGORIA_LICENCIA AS LICENCIA_CLIENTE
FROM RESERVA R
INNER JOIN VEHICULO V ON V.ID_VEHICULO = R.ID_VEHICULO
INNER JOIN CLIENTE C ON C.ID_CLIENTE = R.ID_CLIENTE
WHERE (V.CATEGORIA_LICENCIA = 'B1' AND C.CATEGORIA_LICENCIA IN ('A1','A2'))
OR (V.CATEGORIA_LICENCIA = 'B2' AND C.CATEGORIA_LICENCIA IN ('A1','A2','B1','C1'))  -- TOTAL REGISTROS 0
GO

---      -----

/*
CONSULTA DE CONTROL 7:
ESPECIALIZACION TOTAL Y DISJUNTA DE PAGO: CADA PAGO ES CON TARJETA O EN EFECTIVO
(PRIMER SELECT: PAGOS QUE ESTAN EN LAS DOS SUBCLASES,
SEGUNDO SELECT: PAGOS QUE NO ESTAN EN NINGUNA)
*/

SELECT P.ID_PAGO
FROM PAGO P
INNER JOIN PAGO_TARJETA PT ON PT.ID_PAGO = P.ID_PAGO
INNER JOIN PAGO_EFECTIVO PE ON PE.ID_PAGO = P.ID_PAGO

UNION

SELECT P.ID_PAGO
FROM PAGO P
LEFT JOIN PAGO_TARJETA PT ON PT.ID_PAGO = P.ID_PAGO
LEFT JOIN PAGO_EFECTIVO PE ON PE.ID_PAGO = P.ID_PAGO
WHERE PT.ID_PAGO IS NULL AND PE.ID_PAGO IS NULL  -- TOTAL REGISTROS 0
GO

---      -----

/*
CONSULTA DE CONTROL 8:
ESPECIALIZACION TOTAL Y DISJUNTA DE USUARIO: CADA USUARIO ES CLIENTE O EMPLEADO
(PRIMER SELECT: EN LAS DOS, SEGUNDO SELECT: EN NINGUNA)
*/

SELECT U.ID_USUARIO
FROM USUARIO U
INNER JOIN CLIENTE C ON C.ID_CLIENTE = U.ID_USUARIO
INNER JOIN EMPLEADO E ON E.ID_EMPLEADO = U.ID_USUARIO

UNION

SELECT U.ID_USUARIO
FROM USUARIO U
LEFT JOIN CLIENTE C ON C.ID_CLIENTE = U.ID_USUARIO
LEFT JOIN EMPLEADO E ON E.ID_EMPLEADO = U.ID_USUARIO
WHERE C.ID_CLIENTE IS NULL AND E.ID_EMPLEADO IS NULL  -- TOTAL REGISTROS 0
GO

---      -----

/*
CONSULTA DE CONTROL 9:
UN CLIENTE MOROSO NO TIENE RESERVAS FUTURAS (EL CASO DICE QUE NO PUEDE RESERVAR)
*/

SELECT R.ID_RESERVA, C.ID_CLIENTE, C.ESTADO
FROM RESERVA R
INNER JOIN CLIENTE C ON C.ID_CLIENTE = R.ID_CLIENTE
WHERE C.ESTADO = 'MOROSO' AND R.ESTADO IN ('CONFIRMADA', 'MODIFICADA')  -- TOTAL REGISTROS 0
GO

---      -----

/*
CONSULTA DE CONTROL 10:
SOLO LOS CLIENTES MOROSOS DEBEN DINERO:
LAS FACTURAS DE CLIENTES AL DIA O VETADOS ESTAN PAGADAS COMPLETAS
Y LAS DE LOS MOROSOS TIENEN SALDO
*/

SELECT F.ID_FACTURA, C.ID_CLIENTE, C.ESTADO, F.TOTAL, SUM(P.VALOR) AS PAGADO
FROM CLIENTE C
INNER JOIN RESERVA R ON R.ID_CLIENTE = C.ID_CLIENTE
INNER JOIN ALQUILER A ON A.ID_RESERVA = R.ID_RESERVA
INNER JOIN FACTURA F ON F.ID_ALQUILER = A.ID_ALQUILER
INNER JOIN PAGO P ON P.ID_FACTURA = F.ID_FACTURA
GROUP BY F.ID_FACTURA, C.ID_CLIENTE, C.ESTADO, F.TOTAL
HAVING (C.ESTADO IN ('AL_DIA', 'VETADO') AND (F.TOTAL > SUM(P.VALOR) OR F.TOTAL < SUM(P.VALOR)))
OR (C.ESTADO = 'MOROSO' AND F.TOTAL <= SUM(P.VALOR))  -- TOTAL REGISTROS 0
GO

---      -----

/*
CONSULTA DE CONTROL 11:
UN VEHICULO NO TIENE DOS RESERVAS VIGENTES QUE SE CRUCEN EN FECHAS
*/

SELECT R1.ID_VEHICULO, R1.ID_RESERVA, R2.ID_RESERVA
FROM RESERVA R1
INNER JOIN RESERVA R2 ON R2.ID_VEHICULO = R1.ID_VEHICULO AND R1.ID_RESERVA < R2.ID_RESERVA  -- LA MISMA TABLA DOS VECES
WHERE R1.ESTADO IN ('CUMPLIDA', 'CONFIRMADA', 'MODIFICADA')
AND R2.ESTADO IN ('CUMPLIDA', 'CONFIRMADA', 'MODIFICADA')
AND R1.FECHA_INICIO < R2.FECHA_FIN AND R2.FECHA_INICIO < R1.FECHA_FIN  -- TOTAL REGISTROS 0
GO

---      -----


/*
CONSULTA PARA LA EXPOSICION:
LISTAR LAS FACTURAS DE LOS CLIENTES QUE NO ESTAN AL DIA (MOROSOS Y VETADOS),
CON LO QUE SE LES FACTURO, LO QUE PAGARON Y LO QUE DEBEN
*/

-- NECESITO CLIENTE - USUARIO - RESERVA - ALQUILER - FACTURA - PAGO

SELECT C.ID_CLIENTE, C.NOMBRES, C.ESTADO, U.ACTIVO, F.CODIGO,
F.TOTAL, SUM(P.VALOR) AS PAGADO,
F.TOTAL - SUM(P.VALOR) AS SALDO_PENDIENTE
FROM CLIENTE C
INNER JOIN USUARIO U ON U.ID_USUARIO = C.ID_CLIENTE  -- Se iguala PK con FK (ESPECIALIZACION)
INNER JOIN RESERVA R ON R.ID_CLIENTE = C.ID_CLIENTE
INNER JOIN ALQUILER A ON A.ID_RESERVA = R.ID_RESERVA
INNER JOIN FACTURA F ON F.ID_ALQUILER = A.ID_ALQUILER
INNER JOIN PAGO P ON P.ID_FACTURA = F.ID_FACTURA
WHERE C.ESTADO IN ('MOROSO', 'VETADO')
GROUP BY C.ID_CLIENTE, C.NOMBRES, C.ESTADO, U.ACTIVO, F.CODIGO, F.TOTAL
ORDER BY C.ESTADO, C.ID_CLIENTE  -- TOTAL REGISTROS 9 (FACTURAS DE 4 MOROSOS Y 2 VETADOS)
GO
