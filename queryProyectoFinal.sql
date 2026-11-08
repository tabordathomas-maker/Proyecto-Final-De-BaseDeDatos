CREATE DATABASE RENTA_VEHICULOS  -- acá se crea la base de datos
GO

USE RENTA_VEHICULOS  -- para usar la base de datos
GO


-- =====================================================================
-- 2. CREACIÓN DE TABLAS
--    Primero se crean todas las tablas con su PK.
--    Las relaciones (FK) se agregan después con ALTER TABLE (punto 3).
-- =====================================================================


-- ---------------------------------------------------------------------
-- Catálogos (tablas "TIPO")
-- ---------------------------------------------------------------------

-- TIPO_DOCUMENTO: Tipos de documento de identidad (CC, CE, PA...).
CREATE TABLE TIPO_DOCUMENTO(
	ID_TIPO_DOCUMENTO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOMBRE VARCHAR(45)
);
GO

-- TIPO_TELEFONO: Tipos de teléfono (celular, fijo...).
CREATE TABLE TIPO_TELEFONO(
	ID_TIPO_TELEFONO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOMBRE VARCHAR(45)
);
GO

-- TIPO_EMPRESA: Tipos de empresa con convenio (aseguradora, bancaria...).
CREATE TABLE TIPO_EMPRESA(
	ID_TIPO_EMPRESA INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOMBRE VARCHAR(45)
);
GO

-- TIPO_MULTIMEDIA: Tipos de archivo multimedia (foto, video).
CREATE TABLE TIPO_MULTIMEDIA(
	ID_TIPO_MULTIMEDIA INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOMBRE VARCHAR(45)
);
GO

-- TIPO_MANTENIMIENTO: Tipos: mantenimiento o reparación.
CREATE TABLE TIPO_MANTENIMIENTO(
	ID_TIPO_MANTENIMIENTO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOMBRE VARCHAR(45)
);
GO

-- TIPO_INSPECCION: Tipos de inspección: entrega o devolución.
CREATE TABLE TIPO_INSPECCION(
	ID_TIPO_INSPECCION INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOMBRE VARCHAR(45)
);
GO


-- ---------------------------------------------------------------------
-- Personas (especialización USUARIO -> CLIENTE / EMPLEADO)
-- ---------------------------------------------------------------------

-- USUARIO: Superclase de todas las personas que entran al sistema (clientes y empleados).
CREATE TABLE USUARIO(
	ID_USUARIO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	CORREO VARCHAR(100),
	CONTRASENA_HASH VARBINARY(32),
	ROL VARCHAR(45),
	ACTIVO BIT
);
GO

-- CLIENTE: Subclase de USUARIO: cliente registrado que puede reservar.
CREATE TABLE CLIENTE(
	ID_CLIENTE INT PRIMARY KEY NOT NULL,
	ID_TIPO_DOCUMENTO INT NOT NULL,
	NUM_DOCUMENTO VARCHAR(20),
	NOMBRES VARCHAR(45),
	DIRECCION VARCHAR(255),
	CODIGO_POSTAL VARCHAR(10),
	GENERO VARCHAR(45),
	FECHA_NACIMIENTO DATE,
	NIVEL_ESTUDIOS VARCHAR(45),
	NUM_LICENCIA VARCHAR(20),
	CATEGORIA_LICENCIA VARCHAR(45),
	VENCIMIENTO_LICENCIA DATE,
	ESTADO VARCHAR(45),
	ULTIMOS4_TARJETA CHAR(4)
);
GO

-- EMPLEADO: Subclase de USUARIO: administrador, gerente, coordinador o cajero.
CREATE TABLE EMPLEADO(
	ID_EMPLEADO INT PRIMARY KEY NOT NULL,
	NOMBRES VARCHAR(45),
	CARGO VARCHAR(45)
);
GO

-- TELEFONO_CLIENTE: Atributo multivaluado de CLIENTE (1FN): un cliente tiene varios teléfonos.
CREATE TABLE TELEFONO_CLIENTE(
	ID_CLIENTE INT NOT NULL,
	ID_TIPO_TELEFONO INT NOT NULL,
	NUMERO VARCHAR(20)
);
GO


-- ---------------------------------------------------------------------
-- Datos de la empresa
-- ---------------------------------------------------------------------

-- SEDE: Sitio donde se recoge el vehículo.
CREATE TABLE SEDE(
	ID_SEDE INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOMBRE VARCHAR(45),
	DIRECCION VARCHAR(255),
	CIUDAD VARCHAR(45)
);
GO

-- POLIZA: Pólizas de seguro: básica, intermedia, premium.
CREATE TABLE POLIZA(
	ID_POLIZA INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOMBRE VARCHAR(45),
	COBERTURA_MAXIMA DECIMAL(14,2),
	VALOR_DIA DECIMAL(14,2)
);
GO

-- MODALIDAD: Modalidad de alquiler: por kilometraje o por día (con límite de km).
CREATE TABLE MODALIDAD(
	ID_MODALIDAD INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOMBRE VARCHAR(45),
	KM_LIMITE_DIA INT
);
GO

-- TARIFA: Valor por día según gama, rango de kilometraje y modalidad.
CREATE TABLE TARIFA(
	ID_TARIFA INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ID_MODALIDAD INT NOT NULL,
	GAMA VARCHAR(45),
	KM_MIN INT,
	KM_MAX INT,
	VALOR_DIA DECIMAL(14,2)
);
GO

-- CONVENIO: Empresas con convenio y su porcentaje de descuento (5% a 10%).
CREATE TABLE CONVENIO(
	ID_CONVENIO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ID_TIPO_EMPRESA INT NOT NULL,
	EMPRESA VARCHAR(45),
	PORCENTAJE_DESCUENTO DECIMAL(5,2)
);
GO


-- ---------------------------------------------------------------------
-- Vehículos
-- ---------------------------------------------------------------------

-- VEHICULO: Vehículos de la empresa (incluye el stock de respaldo: ES_RESPALDO).
CREATE TABLE VEHICULO(
	ID_VEHICULO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	PLACA VARCHAR(10),
	MARCA VARCHAR(45),
	MODELO VARCHAR(45),
	GAMA VARCHAR(45),
	CATEGORIA_LICENCIA VARCHAR(45),
	CAPACIDAD TINYINT,
	KILOMETRAJE INT,
	COLOR VARCHAR(45),
	CONSUMO DECIMAL(5,2),
	COMBUSTIBLE VARCHAR(45),
	PUERTAS TINYINT,
	TRANSMISION VARCHAR(45),
	ES_RESPALDO BIT,
	ESTADO VARCHAR(45)
);
GO

-- MULTIMEDIA_VEHICULO: Fotos y videos de cada vehículo (entidad débil, solo FK).
CREATE TABLE MULTIMEDIA_VEHICULO(
	ID_VEHICULO INT NOT NULL,
	ID_TIPO_MULTIMEDIA INT NOT NULL,
	URL VARCHAR(255)
);
GO

-- TALLER: Talleres donde se hacen mantenimientos y reparaciones.
CREATE TABLE TALLER(
	ID_TALLER INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	NOMBRE VARCHAR(45),
	TELEFONO VARCHAR(45),
	DIRECCION VARCHAR(255)
);
GO

-- MANTENIMIENTO: Hoja de vida del vehículo (entidad débil, solo FK).
CREATE TABLE MANTENIMIENTO(
	ID_VEHICULO INT NOT NULL,
	ID_TALLER INT NOT NULL,
	ID_TIPO_MANTENIMIENTO INT NOT NULL,
	FECHA DATE,
	COSTO DECIMAL(14,2),
	DESCRIPCION VARCHAR(255)
);
GO


-- ---------------------------------------------------------------------
-- Operación: reserva, alquiler e inspecciones
-- ---------------------------------------------------------------------

-- RESERVA: Entidad de transacción: el cliente reserva un vehículo.
CREATE TABLE RESERVA(
	ID_RESERVA INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ID_CLIENTE INT NOT NULL,
	ID_VEHICULO INT NOT NULL,
	ID_SEDE INT NOT NULL,
	ID_POLIZA INT NOT NULL,
	ID_MODALIDAD INT NOT NULL,
	ID_CONVENIO INT,
	CODIGO_RESERVA VARCHAR(20),
	FECHA_INICIO DATETIME,
	FECHA_FIN DATETIME,
	ESTADO VARCHAR(45),
	FECHA_CANCELACION DATETIME,
	VALOR_MULTA DECIMAL(14,2),
	MONEDA CHAR(3)
);
GO

-- ALQUILER: Alquiler que nace de una reserva (contrato).
CREATE TABLE ALQUILER(
	ID_ALQUILER INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ID_RESERVA INT NOT NULL,
	FECHA_ENTREGA DATETIME,
	FECHA_FIN_PACTADA DATETIME,
	FECHA_DEVOLUCION DATETIME,
	ANTICIPO DECIMAL(14,2),
	VALOR_TOTAL DECIMAL(14,2)
);
GO

-- INSPECCION: Actas de entrega y de devolución del vehículo.
CREATE TABLE INSPECCION(
	ID_INSPECCION INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ID_ALQUILER INT NOT NULL,
	ID_EMPLEADO INT NOT NULL,
	ID_TIPO_INSPECCION INT NOT NULL,
	FECHA_HORA DATETIME,
	KILOMETRAJE INT,
	NIVEL_GASOLINA TINYINT
);
GO

-- FOTO_INSPECCION: Fotos de cada inspección (atributo multivaluado, solo FK).
CREATE TABLE FOTO_INSPECCION(
	ID_INSPECCION INT NOT NULL,
	URL VARCHAR(255)
);
GO

-- DANIO: Daños encontrados en una inspección.
CREATE TABLE DANIO(
	ID_DANO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ID_INSPECCION INT NOT NULL,
	DESCRIPCION VARCHAR(255),
	VALOR DECIMAL(14,2)
);
GO

-- ENCUESTA: Encuesta de satisfacción de un alquiler.
CREATE TABLE ENCUESTA(
	ID_ENCUESTA INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ID_ALQUILER INT NOT NULL,
	CALIF_SERVICIO TINYINT,
	CALIF_VEHICULO TINYINT,
	COMENTARIO VARCHAR(255)
);
GO


-- ---------------------------------------------------------------------
-- Facturación y pagos (especialización PAGO -> TARJETA / EFECTIVO)
-- ---------------------------------------------------------------------

-- FACTURA: Factura generada por un alquiler.
CREATE TABLE FACTURA(
	ID_FACTURA INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ID_ALQUILER INT NOT NULL,
	CODIGO VARCHAR(20),
	FECHA DATE,
	TOTAL DECIMAL(14,2)
);
GO

-- DETALLE_FACTURA: Líneas de la factura (entidad débil, PK compuesta).
CREATE TABLE DETALLE_FACTURA(
	ID_FACTURA INT NOT NULL,
	LINEA INT NOT NULL,
	CONCEPTO VARCHAR(45),
	VALOR DECIMAL(14,2),
	CONSTRAINT PK_DETALLE_FACTURA PRIMARY KEY (ID_FACTURA, LINEA)
);
GO

-- PAGO: Superclase de los pagos de una factura.
CREATE TABLE PAGO(
	ID_PAGO INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ID_FACTURA INT NOT NULL,
	ID_EMPLEADO INT NOT NULL,
	FECHA DATE,
	VALOR DECIMAL(14,2),
	MONEDA CHAR(3)
);
GO

-- PAGO_TARJETA: Subclase de PAGO: pago con tarjeta (solo últimos 4 dígitos).
CREATE TABLE PAGO_TARJETA(
	ID_PAGO INT PRIMARY KEY NOT NULL,
	ULTIMOS4 CHAR(4),
	FRANQUICIA VARCHAR(45)
);
GO

-- PAGO_EFECTIVO: Subclase de PAGO: pago en efectivo.
CREATE TABLE PAGO_EFECTIVO(
	ID_PAGO INT PRIMARY KEY NOT NULL,
	VALOR_RECIBIDO DECIMAL(14,2),
	CAMBIO DECIMAL(14,2)
);
GO


-- =====================================================================
-- 3. RELACIONES (PK + FK)
--    ALTER TABLE <tabla donde está la FK>
--    ADD CONSTRAINT <nombre de la relación>
--    FOREIGN KEY (<columna FK>)
--    REFERENCES <tabla con la PK> (<columna PK>)
-- =====================================================================


-- --- Personas (especialización USUARIO -> CLIENTE / EMPLEADO) ---

-- especialización: CLIENTE es un USUARIO
ALTER TABLE CLIENTE   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_CLIENTE_USUARIO
FOREIGN KEY (ID_CLIENTE)   -- atributo de la FK
REFERENCES USUARIO (ID_USUARIO)   -- tabla y la clave PK
GO

-- especialización: EMPLEADO es un USUARIO
ALTER TABLE EMPLEADO   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_EMPLEADO_USUARIO
FOREIGN KEY (ID_EMPLEADO)   -- atributo de la FK
REFERENCES USUARIO (ID_USUARIO)   -- tabla y la clave PK
GO

-- relación "tiene" del MER (CLIENTE 1 : M TELEFONO_CLIENTE)
ALTER TABLE TELEFONO_CLIENTE   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_TELEFONO_CLIENTE_CLIENTE
FOREIGN KEY (ID_CLIENTE)   -- atributo de la FK
REFERENCES CLIENTE (ID_CLIENTE)   -- tabla y la clave PK
GO

-- CLIENTE es de un TIPO_DOCUMENTO
ALTER TABLE CLIENTE   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_CLIENTE_TIPO_DOCUMENTO
FOREIGN KEY (ID_TIPO_DOCUMENTO)   -- atributo de la FK
REFERENCES TIPO_DOCUMENTO (ID_TIPO_DOCUMENTO)   -- tabla y la clave PK
GO

-- TELEFONO_CLIENTE es de un TIPO_TELEFONO
ALTER TABLE TELEFONO_CLIENTE   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_TELEFONO_CLIENTE_TIPO_TELEFONO
FOREIGN KEY (ID_TIPO_TELEFONO)   -- atributo de la FK
REFERENCES TIPO_TELEFONO (ID_TIPO_TELEFONO)   -- tabla y la clave PK
GO


-- --- Datos de la empresa ---

-- relación "se define por" del MER (MODALIDAD 1 : M TARIFA)
ALTER TABLE TARIFA   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_TARIFA_MODALIDAD
FOREIGN KEY (ID_MODALIDAD)   -- atributo de la FK
REFERENCES MODALIDAD (ID_MODALIDAD)   -- tabla y la clave PK
GO

-- CONVENIO es de un TIPO_EMPRESA
ALTER TABLE CONVENIO   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_CONVENIO_TIPO_EMPRESA
FOREIGN KEY (ID_TIPO_EMPRESA)   -- atributo de la FK
REFERENCES TIPO_EMPRESA (ID_TIPO_EMPRESA)   -- tabla y la clave PK
GO


-- --- Vehículos ---

-- relación "recibe" del MER (VEHICULO 1 : M MANTENIMIENTO)
ALTER TABLE MANTENIMIENTO   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_MANTENIMIENTO_VEHICULO
FOREIGN KEY (ID_VEHICULO)   -- atributo de la FK
REFERENCES VEHICULO (ID_VEHICULO)   -- tabla y la clave PK
GO

-- relación "realiza" del MER (TALLER 1 : M MANTENIMIENTO)
ALTER TABLE MANTENIMIENTO   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_MANTENIMIENTO_TALLER
FOREIGN KEY (ID_TALLER)   -- atributo de la FK
REFERENCES TALLER (ID_TALLER)   -- tabla y la clave PK
GO

-- relación "tiene" del MER (VEHICULO 1 : M MULTIMEDIA_VEHICULO)
ALTER TABLE MULTIMEDIA_VEHICULO   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_MULTIMEDIA_VEHICULO_VEHICULO
FOREIGN KEY (ID_VEHICULO)   -- atributo de la FK
REFERENCES VEHICULO (ID_VEHICULO)   -- tabla y la clave PK
GO

-- MANTENIMIENTO es de un TIPO_MANTENIMIENTO
ALTER TABLE MANTENIMIENTO   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_MANTENIMIENTO_TIPO_MANTENIMIENTO
FOREIGN KEY (ID_TIPO_MANTENIMIENTO)   -- atributo de la FK
REFERENCES TIPO_MANTENIMIENTO (ID_TIPO_MANTENIMIENTO)   -- tabla y la clave PK
GO

-- MULTIMEDIA_VEHICULO es de un TIPO_MULTIMEDIA
ALTER TABLE MULTIMEDIA_VEHICULO   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_MULTIMEDIA_VEHICULO_TIPO_MULTIMEDIA
FOREIGN KEY (ID_TIPO_MULTIMEDIA)   -- atributo de la FK
REFERENCES TIPO_MULTIMEDIA (ID_TIPO_MULTIMEDIA)   -- tabla y la clave PK
GO


-- --- Operación: reserva, alquiler e inspecciones ---

-- relación "realiza" del MER (CLIENTE 1 : M RESERVA)
ALTER TABLE RESERVA   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_RESERVA_CLIENTE
FOREIGN KEY (ID_CLIENTE)   -- atributo de la FK
REFERENCES CLIENTE (ID_CLIENTE)   -- tabla y la clave PK
GO

-- relación "se reserva" del MER (VEHICULO 1 : M RESERVA)
ALTER TABLE RESERVA   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_RESERVA_VEHICULO
FOREIGN KEY (ID_VEHICULO)   -- atributo de la FK
REFERENCES VEHICULO (ID_VEHICULO)   -- tabla y la clave PK
GO

-- relación "se recoge en" del MER (SEDE 1 : M RESERVA)
ALTER TABLE RESERVA   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_RESERVA_SEDE
FOREIGN KEY (ID_SEDE)   -- atributo de la FK
REFERENCES SEDE (ID_SEDE)   -- tabla y la clave PK
GO

-- relación "incluye" del MER (POLIZA 1 : M RESERVA)
ALTER TABLE RESERVA   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_RESERVA_POLIZA
FOREIGN KEY (ID_POLIZA)   -- atributo de la FK
REFERENCES POLIZA (ID_POLIZA)   -- tabla y la clave PK
GO

-- relación "incluye" del MER (MODALIDAD 1 : M RESERVA)
ALTER TABLE RESERVA   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_RESERVA_MODALIDAD
FOREIGN KEY (ID_MODALIDAD)   -- atributo de la FK
REFERENCES MODALIDAD (ID_MODALIDAD)   -- tabla y la clave PK
GO

-- relación "aplica" del MER (CONVENIO 1 : M RESERVA)
ALTER TABLE RESERVA   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_RESERVA_CONVENIO
FOREIGN KEY (ID_CONVENIO)   -- atributo de la FK
REFERENCES CONVENIO (ID_CONVENIO)   -- tabla y la clave PK
GO

-- relación "se convierte en" del MER (RESERVA 1 : 1 ALQUILER)
ALTER TABLE ALQUILER   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_ALQUILER_RESERVA
FOREIGN KEY (ID_RESERVA)   -- atributo de la FK
REFERENCES RESERVA (ID_RESERVA)   -- tabla y la clave PK
GO

-- relación "tiene" del MER (ALQUILER 1 : M INSPECCION)
ALTER TABLE INSPECCION   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_INSPECCION_ALQUILER
FOREIGN KEY (ID_ALQUILER)   -- atributo de la FK
REFERENCES ALQUILER (ID_ALQUILER)   -- tabla y la clave PK
GO

-- relación "realiza" del MER (EMPLEADO 1 : M INSPECCION)
ALTER TABLE INSPECCION   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_INSPECCION_EMPLEADO
FOREIGN KEY (ID_EMPLEADO)   -- atributo de la FK
REFERENCES EMPLEADO (ID_EMPLEADO)   -- tabla y la clave PK
GO

-- relación "registra" del MER (INSPECCION 1 : M DANIO)
ALTER TABLE DANIO   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_DANIO_INSPECCION
FOREIGN KEY (ID_INSPECCION)   -- atributo de la FK
REFERENCES INSPECCION (ID_INSPECCION)   -- tabla y la clave PK
GO

-- relación "evalua" del MER (ALQUILER 1 : 1 ENCUESTA)
ALTER TABLE ENCUESTA   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_ENCUESTA_ALQUILER
FOREIGN KEY (ID_ALQUILER)   -- atributo de la FK
REFERENCES ALQUILER (ID_ALQUILER)   -- tabla y la clave PK
GO

-- relación "tiene" del MER (INSPECCION 1 : M FOTO_INSPECCION)
ALTER TABLE FOTO_INSPECCION   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_FOTO_INSPECCION_INSPECCION
FOREIGN KEY (ID_INSPECCION)   -- atributo de la FK
REFERENCES INSPECCION (ID_INSPECCION)   -- tabla y la clave PK
GO

-- INSPECCION es de un TIPO_INSPECCION
ALTER TABLE INSPECCION   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_INSPECCION_TIPO_INSPECCION
FOREIGN KEY (ID_TIPO_INSPECCION)   -- atributo de la FK
REFERENCES TIPO_INSPECCION (ID_TIPO_INSPECCION)   -- tabla y la clave PK
GO


-- --- Facturación y pagos (especialización PAGO -> TARJETA / EFECTIVO) ---

-- especialización: PAGO_TARJETA es un PAGO
ALTER TABLE PAGO_TARJETA   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_PAGO_TARJETA_PAGO
FOREIGN KEY (ID_PAGO)   -- atributo de la FK
REFERENCES PAGO (ID_PAGO)   -- tabla y la clave PK
GO

-- especialización: PAGO_EFECTIVO es un PAGO
ALTER TABLE PAGO_EFECTIVO   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_PAGO_EFECTIVO_PAGO
FOREIGN KEY (ID_PAGO)   -- atributo de la FK
REFERENCES PAGO (ID_PAGO)   -- tabla y la clave PK
GO

-- relación "genera" del MER (ALQUILER 1 : 1 FACTURA)
ALTER TABLE FACTURA   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_FACTURA_ALQUILER
FOREIGN KEY (ID_ALQUILER)   -- atributo de la FK
REFERENCES ALQUILER (ID_ALQUILER)   -- tabla y la clave PK
GO

-- relación "contiene" del MER (FACTURA 1 : M DETALLE_FACTURA)
ALTER TABLE DETALLE_FACTURA   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_DETALLE_FACTURA_FACTURA
FOREIGN KEY (ID_FACTURA)   -- atributo de la FK
REFERENCES FACTURA (ID_FACTURA)   -- tabla y la clave PK
GO

-- relación "se paga con" del MER (FACTURA 1 : M PAGO)
ALTER TABLE PAGO   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_PAGO_FACTURA
FOREIGN KEY (ID_FACTURA)   -- atributo de la FK
REFERENCES FACTURA (ID_FACTURA)   -- tabla y la clave PK
GO

-- relación "registra" del MER (EMPLEADO 1 : M PAGO)
ALTER TABLE PAGO   -- tabla donde se encuentra la FK
ADD CONSTRAINT FK_PAGO_EMPLEADO
FOREIGN KEY (ID_EMPLEADO)   -- atributo de la FK
REFERENCES EMPLEADO (ID_EMPLEADO)   -- tabla y la clave PK
GO

