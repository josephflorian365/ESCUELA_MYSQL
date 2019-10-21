create database venta
	DEFAULT CHARACTER SET utf8;
USE venta;

CREATE TABLE CURSO (
    CODCUR char(3) NOT NULL COMMENT 'Contiene el código único para cada curso ofertado.',
    DESCUR varchar(30) NULL COMMENT 'Descripción corta del curso.',
    CATCUR char(3) NULL COMMENT 'Categoría de curso (GEN = General, DEV = Desarrollo y ADS = Análisis y Diseño de Sistemas).',
    DURCUR int NULL COMMENT 'Duración del curso en número de días.',
    CONSTRAINT CURSO_pk PRIMARY KEY (CODCUR)
) COMMENT 'Contiene los cursos ofertados.';

-- Table: DEPARTAMENTO
CREATE TABLE DEPARTAMENTO (
    IDDEP int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de cada departamento.',
    NOMDEP varchar(50) NULL COMMENT 'Nombre descriptivo de departamento.',
    IDEMP int NOT NULL,
    CONSTRAINT DEPARTAMENTO_pk PRIMARY KEY (IDDEP)
) COMMENT 'Contiene la descripcion del departamento.';

-- Table: EMPLEADO
CREATE TABLE EMPLEADO (
    IDEMP int NOT NULL AUTO_INCREMENT COMMENT 'Es el identificador de todo empleado.',
    FECINGEMP date NULL COMMENT 'Fecha de ingreso del empleado.',
    CARGEMP varchar(40) NULL COMMENT 'Descripción del cargo del empleado.',
    JEFE_IDEMP int NOT NULL COMMENT 'Identificador del jefe del empleado.',
    SALEMP decimal(6,2) NULL COMMENT 'Monto de salario del empleado (no incluye bonos).',
    ESTEMP char(1) NULL COMMENT 'Determina si es A activo o I inactivo. Si está trabajando actualmente o no. Por default será A.',
    DEMP int NOT NULL COMMENT 'Es el dato identificador de todo empleado..',
    IDPER int NOT NULL COMMENT 'Es el dato identificador de la persona.',
    IDDEP int NOT NULL COMMENT 'Identificador de cada departamento.',
    NIVSUE int NOT NULL COMMENT 'Identificador del grado o nivel de venta que puede alcanzar el vendedor.',
    CONSTRAINT EMPLEADO_pk PRIMARY KEY (IDEMP)
) COMMENT 'Contiene los datos de los empleados.';

-- Table: HISTORICO
CREATE TABLE HISTORICO (
    IDHIS int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de Histórico.',
    FECFINHIST date NULL COMMENT 'Fin de fecha de intervalo de trabajo, ya sea por despido o por cambios de cargo.',
    TIPHIS char(3) NULL COMMENT 'Tipo de Histórico: CAMB cambio de departamento ó FIN término de labores en la empresa.',
    COMEHIST varchar(100) NOT NULL COMMENT 'Comentarios del motivo de cambio y/o finalización de labores en la empresa.',
    IDEMP int NOT NULL COMMENT 'Es el identificador de todo empleado.',
    CONSTRAINT HISTORICO_pk PRIMARY KEY (IDHIS)
) COMMENT 'Contiene el historial de cada empleado.';

-- Table: INSCRIPCION
CREATE TABLE INSCRIPCION (
    IDINSC int NOT NULL COMMENT 'Identificador de la inscripción realizada.',
    FECINS date NOT NULL COMMENT 'Fecha en que se realiza la inscripción.',
    EVALINSC int NOT NULL COMMENT 'Opinión sobre la persona que lo atendió (escala del 1 - 5)',
    IDOFER int NOT NULL COMMENT 'Identificador de oferta.',
    IDPER int NOT NULL COMMENT 'Es el dato identificador de la persona.',
    IDEMP int NOT NULL COMMENT 'Es el identificador de todo empleado.',
    CONSTRAINT INSCRIPCION_pk PRIMARY KEY (IDINSC)
) COMMENT 'Contiene la descripcion de la inscripcion.';

-- Table: NIVEL_SUELDO
CREATE TABLE NIVEL_SUELDO (
    NIVSUE int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del grado o nivel de venta que puede alcanzar el vendedor.',
    MONMINNIVSUE decimal(6,2) NULL COMMENT 'Monto mínimo de venta realizada.',
    MONMAXNIVSUE decimal(6,2) NULL COMMENT 'Monto máximo de venta realizada.',
    BONUSNIVSUE decimal(6,2) NULL COMMENT 'Bonificación neta adicional a su salario mensual.',
    CONSTRAINT NIVEL_SUELDO_pk PRIMARY KEY (NIVSUE)
) COMMENT 'Contiene el registro del Nivel de sueldo.';

-- Table: OFERTA
CREATE TABLE OFERTA (
    IDOFER int NOT NULL AUTO_INCREMENT COMMENT 'Identificador de oferta.',
    FECOFER date NULL COMMENT 'Fecha de inicio de oferta de curso.',
    FECINICCUROFER date NULL COMMENT 'Fecha de inicio de curso ofertado.',
    CODCUR char(3) NOT NULL COMMENT 'Contiene el código único para cada curso ofertado.',
    IDEMP int NOT NULL COMMENT 'Es el identificador de todo empleado.',
    CONSTRAINT OFERTA_pk PRIMARY KEY (IDOFER)
) COMMENT 'Contiene la descripcion de la oferta.';

-- Table: PERSONA
CREATE TABLE PERSONA (
    IDPER int NOT NULL AUTO_INCREMENT COMMENT 'Es el dato identificador de la persona.',
    DNIPER char(8) NULL COMMENT 'Numero de DNI(Documento Nacional de Identificacion)',
    NOMPER varchar(50) NULL COMMENT 'Contiene los nombres de las personas.',
    APEPER varchar(80) NULL COMMENT 'Contiene los apellidos de la persona.',
    FECNACPER date NULL COMMENT 'Contiene la fecha de nacimiento de la persona.',
    CELPER char(9) NOT NULL COMMENT 'Contiene el numero de celular de la persona.',
    EMAPER varchar(100) NOT NULL COMMENT 'Contiene el correo electronico de la persona.',
    SEXPER char(1) NULL COMMENT 'Contiene el identificador de sexo de la persona.',
    TIPER char(3) NULL COMMENT 'Determina si la persona es un EMP Empleado.',
    DISTPER varchar(80) NOT NULL COMMENT 'Contiene el nombre del distrito de procedencia.',
    CONSTRAINT PERSONA_pk PRIMARY KEY (IDPER)
) COMMENT 'Contiene los datos de las personas.';

-- foreign keys
-- Reference: DEPARTAMENTO_EMPLEADO (table: DEPARTAMENTO)
ALTER TABLE DEPARTAMENTO ADD CONSTRAINT DEPARTAMENTO_EMPLEADO FOREIGN KEY DEPARTAMENTO_EMPLEADO (IDEMP)
    REFERENCES EMPLEADO (IDEMP);

-- Reference: EMPLEADO_DEPARTAMENTO (table: EMPLEADO)
ALTER TABLE EMPLEADO ADD CONSTRAINT EMPLEADO_DEPARTAMENTO FOREIGN KEY EMPLEADO_DEPARTAMENTO (IDDEP)
    REFERENCES DEPARTAMENTO (IDDEP);

-- Reference: EMPLEADO_EMPLEADO (table: EMPLEADO)
ALTER TABLE EMPLEADO ADD CONSTRAINT EMPLEADO_EMPLEADO FOREIGN KEY EMPLEADO_EMPLEADO (DEMP)
    REFERENCES EMPLEADO (IDEMP);

-- Reference: EMPLEADO_NIVEL_SUELDO (table: EMPLEADO)
ALTER TABLE EMPLEADO ADD CONSTRAINT EMPLEADO_NIVEL_SUELDO FOREIGN KEY EMPLEADO_NIVEL_SUELDO (NIVSUE)
    REFERENCES NIVEL_SUELDO (NIVSUE);

-- Reference: EMPLEADO_PERSONA (table: EMPLEADO)
ALTER TABLE EMPLEADO ADD CONSTRAINT EMPLEADO_PERSONA FOREIGN KEY EMPLEADO_PERSONA (IDPER)
    REFERENCES PERSONA (IDPER);

-- Reference: HISTORICO_EMPLEADO (table: HISTORICO)
ALTER TABLE HISTORICO ADD CONSTRAINT HISTORICO_EMPLEADO FOREIGN KEY HISTORICO_EMPLEADO (IDEMP)
    REFERENCES EMPLEADO (IDEMP);

-- Reference: INSCRIPCION_EMPLEADO (table: INSCRIPCION)
ALTER TABLE INSCRIPCION ADD CONSTRAINT INSCRIPCION_EMPLEADO FOREIGN KEY INSCRIPCION_EMPLEADO (IDEMP)
    REFERENCES EMPLEADO (IDEMP);

-- Reference: INSCRIPCION_OFERTA (table: INSCRIPCION)
ALTER TABLE INSCRIPCION ADD CONSTRAINT INSCRIPCION_OFERTA FOREIGN KEY INSCRIPCION_OFERTA (IDOFER)
    REFERENCES OFERTA (IDOFER);

-- Reference: INSCRIPCION_PERSONA (table: INSCRIPCION)
ALTER TABLE INSCRIPCION ADD CONSTRAINT INSCRIPCION_PERSONA FOREIGN KEY INSCRIPCION_PERSONA (IDPER)
    REFERENCES PERSONA (IDPER);

-- Reference: OFERTA_CURSO (table: OFERTA)
ALTER TABLE OFERTA ADD CONSTRAINT OFERTA_CURSO FOREIGN KEY OFERTA_CURSO (CODCUR)
    REFERENCES CURSO (CODCUR);

-- Reference: OFERTA_EMPLEADO (table: OFERTA)
ALTER TABLE OFERTA ADD CONSTRAINT OFERTA_EMPLEADO FOREIGN KEY OFERTA_EMPLEADO (IDEMP)
    REFERENCES EMPLEADO (IDEMP);