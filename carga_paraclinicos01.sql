select * from clinico_historiaexamenes;
select * from clinico_tiposexamen;
select * from clinico_tiposexamen;
select * from clinico_examenes;
select * from clinico_historia ;
select * from clinico_examenes where nombre like ('%PRUEBA INTRADERMOREACCIAN DE ESPOROTRIQUINA%');
select * from clinico_examenes where nombre = 'PRUEBA INTRADERMOREACCIAN DE ESPOROTRIQUINA ';
select * from clinico_examenes where id=24;
"PRUEBA INTRADERMOREACCIAN DE ESPOROTRIQUINA "
select * from clinico_tiposdiagnostico;
select * from clinico_diagnosticos;
select * from clinico_historialdiagnosticos;
select * from clinico_antecedentes;
select * from clinico_tiposantecedente;
select * from clinico_historialantecedentes;


-- ojo aquip hay problema ver mañana jueves 05 de septiembre
-- volver a ser ejemllplo conel cargue de los 4: lab,rx,terap,noqx
-- esta grabando mal el id del examen
select * from clinico_examenes where "codigoCups" = '903413'  -- 1  / 1
select * from clinico_examenes where "codigoCups" = '871402' -- 3  / 3
select * from clinico_examenes where "codigoCups" = '877131' -- 2 y 4  / 2
select * from clinico_examenes where "codigoCups" = '877131'

 
-- delete  from clinico_historiaexamenes;

select * from mae_articulos  where articulo like ('%SANGRE%');
SELECT codreg_cups,desc_cups FROM MAE_CUPS where cod_concepto='RAYX';



CREATE EXTENSION dblink;
SELECT dblink_connect('myconn', 'dbname=bd_imhotep,hostaddr=192.168.0.238,user=postgres,password=BD_m3d1c4l');
SELECT c.idcanton, c.nombre AS canton, c.idprovincia
FROM dblink('myconn', 'SELECT codreg,estado FROM public.bd_imhotep'::text) c(codreg text, estado text);

create table laboratorios (codreg_cups character varying (15), desc_cups character varying(300));
COPY laboratorios  FROM '/var/lib/pgsql/9.4/backups/ExportLaboratorios.csv' HEADER CSV DELIMITER ';';
select * from laboratorios;

create table radiologia (codreg_cups character varying (15), desc_cups character varying(300));
COPY radiologia  FROM '/var/lib/pgsql/9.4/backups/ExportRx.csv' HEADER CSV DELIMITER ';';
select * from radiologia;

insert into clinico_examenes ("codigoCups",nombre,"TiposExamen_id", "edadIni", "edadFin","estadoReg", autorizar, "citaControl", "codigoRips", "solicitaEnfermeria")
select codreg_cups,desc_cups,'1',0,120,'A',0,0,0,'.' from laboratorios;

 
insert into clinico_examenes ("codigoCups",nombre,"TiposExamen_id", "edadIni", "edadFin","estadoReg", autorizar, "citaControl", "codigoRips", "solicitaEnfermeria")
select codreg_cups,desc_cups,'3',0,120,'A',0,0,0,'.' from radiologia;

select * from clinico_examenes;

SELECT codreg_cups,desc_cups FROM MAE_CUPS where cod_concepto='TERAPIAS';
create table terapias (codreg_cups character varying (15), desc_cups character varying(300));
COPY terapias  FROM '/var/lib/pgsql/9.4/backups/ExportTerapias.csv' HEADER CSV DELIMITER ';';
select * from terapias;

 
insert into clinico_examenes ("codigoCups",nombre,"TiposExamen_id", "edadIni", "edadFin","estadoReg", autorizar, "citaControl", "codigoRips", "solicitaEnfermeria")
select codreg_cups,desc_cups,'2',0,120,'A',0,0,0,'.' from terapias;

delete from clinico_examenes where "TiposExamen_id" = 2 and nombre  in
(
select nombre from clinico_examenes where "TiposExamen_id" =2 group by nombre having count(*) > 1)

delete from clinico_examenes where "TiposExamen_id" =2 group by nombre having count(*) >1

SELECT codreg_cups,desc_cups FROM MAE_CUPS where cod_concepto='TERAPIAS';
create table noQx (codreg_cups character varying (15), desc_cups character varying(300));
COPY noQx  FROM '/var/lib/pgsql/9.4/backups/ExportnoQx.csv' HEADER CSV DELIMITER ';';
select * from noQx;

 
insert into clinico_examenes ("codigoCups",nombre,"TiposExamen_id", "edadIni", "edadFin","estadoReg", autorizar, "citaControl", "codigoRips", "solicitaEnfermeria")
select codreg_cups,desc_cups,'4',0,120,'A',0,0,0,'.' from noQx;



--delete from  clinico_examenes
where nombre in
(
select nombre  from clinico_examenes group by  nombre having count(*) > 1);


select * from  clinico_examenes

        SELECT t.id TipoId, e.id id, e.nombre nombre , e."codigoCups" cups FROM clinico_tiposExamen t, clinico_examenes e 
	WHERE t.id = e."TiposExamen_id" and t.nombre = 'PROCEDIMIENTOS NO QX'


drop table medicamentos ;
create table medicamentos (EXPEDIENTE	 varchar(20),PRODUCTO	varchar(250),TITULAR	 varchar(120),REGISTRO_SANITARIO varchar(150),	
FECHA_EXPEDICIÓN	varchar(20),FECHA_VENCIMIENTO	varchar(20),ESTADO_REGISTRO	 varchar(50),	EXPEDIENTE_CUM	varchar(150),	CONSECUTIVO	varchar(150),	
CANTIDAD_CUM	varchar(50),	DESCRIPCIÓN_COMERCIAL	varchar(500),	ESTADO_CUM	varchar(50),	FECHA_ACTIVO	 varchar(20),
FECHA_INACTIVO	 varchar(20),MUESTRA_MÉDICA	 varchar(150),	UNIDAD_ATC	varchar(150),	DESCRIPCIÓN_ATC	 varchar(150),	VÍA_ADMINISTRACIÓN	varchar(150),	
CONCENTRACIÓN	varchar(150),	PRINCIPIO_ACTIVO	varchar(150),	UNIDAD_MEDIDA	varchar(250),	CANTIDAD	varchar(50),	
UNIDAD_REFERENCIA	varchar(150),	FORMA_FARMACÉUTICA	varchar(150),	NOMBRE_ROL	varchar(150),	TIPO_ROL	varchar(150),	
MODALIDAD	varchar(150),	IUM varchar(150))


COPY medicamentos  FROM '/mnt/sda3/PostgreSQL/9.4/backups/MedicamentosVigentes2022Copia2.csv' HEADER CSV DELIMITER ';';

select * from medicamentos;
select * from facturacion_suministros;

insert into facturacion_suministros (nombre,"nombreGenerico",cums,"estadoReg", concepto_id,"tipoSuministro_id","unidadMedida_id",
		"viaAdministracion_id","formasFarmaceutica_id", "principioActivo_id","descripcionComercial",
		"fechaExpedicion","registroSanitario") 
select substring(producto,1,30),substring(producto,1,30) ,'zzzz','A',6,1,1,48,1,1,substring(DESCRIPCIÓN_COMERCIAL,1,250),  '2024-09-17 16:00:00',REGISTRO_SANITARIO
from medicamentos


