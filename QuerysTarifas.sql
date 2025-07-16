select * from tarifas_liquidacionhonorarios where  "tipoTarifa_id" = 5
select * from tarifas_liquidaciontarifashonorarios where  "tipoTarifa_id" = 5 
select * from tarifas_honorariosiss;
select * from tarifas_honorariosiss
select * from tarifas_honorariossoat;
select * from tarifas_tarifas;
select * from tarifas_tipostarifa;
select * from facturacion_salariosminimoslegales;
select * from tarifas_liquidaciontarifashonorarios where "tipoTarifa_id" = 1;;
select * from tarifas_tiposhonorarios;

--1. Todos los procedimientos Quirurgicos
  
-- Query masivo carga (HONORARIOS MEDICOS soat)   acuerdo parametrizacion de tarifas_honorariossoat a la tabla select * from tarifas_liquidaciontarifashonorarios;

BEGIN TRANSACTION;
INSERT INTO tarifas_liquidaciontarifashonorarios ("codigoHomologado" ,  descripcion ,  "salMinLeg" ,  "cantidadUvr" ,  "valorIss" ,  "valorSoat" ,  "valorPropio" ,  "fechaRegistro" ,
  "estadoReg" ,  "codigoCups_id" ,  "codigoSuministro_id" ,  "salariosMinimosLegales_id" ,  "tipoHonorario_id" ,  "tipoTarifa_id" ,
  "usuarioRegistro_id" ,  "uvrAño_id" )
SELECT s."codigoHomologado" codHomologado,s.descripcion descripcion ,s."salMinLeg" salminleg,0 cantidadUvr,0 valorIss,round(s."salMinLeg" * s.valor/30,0) valorSoat ,
0 valorPropio ,'2024-10-21 15:54:00' fechaRegistro,'A' estadoReg,
      e.id cupsId   , null suministroId  ,l.id  salMinLegId, s."tipoHonorario_id" tipoHonorarioId,tipostar.id tipoTarifaId,'1' usuarioRegistro  ,null uvrAñoId
FROM tarifas_honorariossoat s,clinico_examenes e, facturacion_salariosminimoslegales l, tarifas_tipostarifa tipostar
where l.id = s."salariosMinimosLegales_id" AND l.año= '2024' and   e."grupoQx_id" IS NOT NULL and tipostar.nombre ='SOAT 2024' and 
        s."tipoTarifa_id" =  tipostar.id and  e."grupoQx_id" = s."grupoQx_id"
ROLLBACK;
COMMIT;

 
 
  
-- Query masivo carga (HONORARIOS MEDICOS ISS)   acuerdo parametrizacion de tarifas_honorariosiss a la tabla select * from tarifas_liquidaciontarifashonorarios;

select * from facturacion_suministros;
select * from tarifas_liquidaciontarifashonorarios;

BEGIN TRANSACTION;
INSERT INTO tarifas_liquidaciontarifashonorarios ("codigoHomologado" ,  descripcion ,  "salMinLeg" ,  "cantidadUvr" ,  "valorIss" ,  "valorSoat" ,  "valorPropio" ,  "fechaRegistro" ,
  "estadoReg" ,  "codigoCups_id" ,  "codigoSuministro_id" ,  "salariosMinimosLegales_id" ,  "tipoHonorario_id" ,  "tipoTarifa_id" ,
  "usuarioRegistro_id" ,  "uvrAño_id" )
SELECT iss."codigoHomologado" codHomologado,iss.descripcion descripcion ,0 salminleg,cast(e."cantidadUvr" as numeric) cantidadUvr,
round(iss.valor * cast(e."cantidadUvr" as numeric) ,0) valorIss,0 valorSoat ,
0 valorPropio ,'2024-10-21 15:54:00' fechaRegistro,'A' estadoReg,
      e.id cupsId   , null suministroId  ,0  salMinLegId, iss."tipoHonorario_id" tipoHonorarioId,tipostar.id tipoTarifaId,'1' usuarioRegistro  ,null uvrAñoId
FROM tarifas_honorariosiss iss,clinico_examenes e, facturacion_salariosminimoslegales l, tarifas_tipostarifa tipostar
where   e."grupoQx_id" IS NOT NULL and tipostar.nombre ='ISS 2001' and 
        iss."tipoTarifa_id" =  tipostar.id and iss."tipoHonorario_id" <=3
select * from tarifas_liquidaciontarifashonorarios;
-- rollback;
-- commit

--2. Todos los Procedimientos No Qx
--  Carga Masiva SOAT
-- Hay que cargar tabla temporal con numero de salario minimos legales, codigoCups para Noqx, con lab,rad,terapias,

select * from clinico_examenes;


select * from tarifas_tarifas;


select * from tmp_tar_tmp_imhotep where cod_tipotarifa = 'SOAT-2024'; -- DEBEN SER 9500

BEGIN TRANSACTION;
INSERT INTO tarifas_tarifas (nombre ,"codigoHomologado",  "cantidadUvr" ,  "valorIss" ,  paquete,  "fechaRegistro" ,
  "estadoReg" ,  "codigoCups_id" , concepto_id,   "tipoTarifa_id", "usuarioRegistro_id" ,  "uvrAño_id", "grupoQx_id" ,
 "valorSoat", "valorPropio", "codigoSuministro_id" ,"salMinLeg",  "salariosMinimosLegales_id"    )
SELECT e.nombre descripcion , imhotep.homologado codHomologado,0,0,'N','2024-10-22 16:20:00' fechaRegistro,'A' estadoReg,
	e.id cupsId ,null concepto, 1 tipoTarifa, 1  usuarioRegistro, null uvrAño, null grupoQx,imhotep.valor_act valorSoat,
0 valorpropio, null suministro ,0 salminleg, 1 salariosMinimos 
FROM tmp_tar_tmp_imhotep imhotep , clinico_examenes e, facturacion_salariosminimoslegales l, tarifas_tipostarifa tipostar
where l.año= '2024' and   e."grupoQx_id" IS NULL and tipostar.nombre ='SOAT 2024' and 
         imhotep.cups = e."codigoCups"  AND imhotep.cod_tipotarifa='SOAT-2024'  -- Solo 2030
and e.id not in (select "codigoCups_id" FROM tarifas_tarifas)
--order by cupsid  
select * from tarifas_tarifas order by "codigoCups_id";
ROLLBACK;
COMMIT;



--  Carga Masiva ISS Proceds No qx

BEGIN TRANSACTION;
INSERT INTO tarifas_tarifas (nombre ,"codigoHomologado",  "cantidadUvr" ,  "valorIss" ,  paquete,  "fechaRegistro" ,
  "estadoReg" ,  "codigoCups_id" , concepto_id,   "tipoTarifa_id", "usuarioRegistro_id" ,  "uvrAño_id", "grupoQx_id" ,
 "valorSoat", "valorPropio", "codigoSuministro_id" ,"salMinLeg",  "salariosMinimosLegales_id"    )
SELECT e.nombre descripcion , imhotep.homologado codHomologado,0,imhotep.valor_act,'N','2024-10-22 16:20:00' fechaRegistro,'A' estadoReg,
	e.id cupsId ,null concepto, 5 tipoTarifa, 1  usuarioRegistro, null uvrAño, null grupoQx,0  valorSoat,
0 valorpropio, null suministro ,0 salminleg, NULL salariosMinimos 
FROM tmp_tar_tmp_imhotep imhotep , clinico_examenes e, facturacion_salariosminimoslegales l, tarifas_tipostarifa tipostar
where l.año= '2024' and   e."grupoQx_id" IS NULL and tipostar.nombre ='ISS 2001' and 
         imhotep.cups = e."codigoCups"  AND imhotep.cod_tipotarifa='ISS'  -- Solo 2030
and e.id not in (select "codigoCups_id" FROM tarifas_tarifas WHERE "tipoTarifa_id"=5	 )
--order by cupsid  
select * from tarifas_tarifas order by "codigoCups_id";
ROLLBACK;
COMMIT;



select * from tmp_tar_tmp_imhotep where cod_tipotarifa = 'ISS'; -- 5733 No mas

--3. Todos los Suministros
DROP TABLE pruebascums
create table pruebascums (cum  character(15) , nombre character varying (300),  descripcion character varying (300) , codigoAtc character(50),nombreAtc character varying (300), invima character varying (50), principioActivo character varying (300),administracion character varying (100))
 
copy pruebascums from '/mnt/sda3/PostgreSQL/9.4/backups/Referencia_CUM__Pruebas2.csv' WITH DELIMITER ';' CSV;

select * from pruebascums;
delete from pruebascums;



-- Tarifas SOAT-2024




-- Tarifas ISS-2001



-- Tarifas PARTCULAR 2024
select * from tmpsuministros;
select * from
begin transaction;
insert into tarifas_tarifassuministros ("codigoHomologado", valor,"fechaRegistro", "estadoReg","suministro_id" , "tipoTarifa_id", "usuarioRegistro_id")
select '', 0,'2024-10-23 00:00:00','A',sum.id suministroId,2,1
 from facturacion_suministros sum
;
select * from tarifas_tarifassuministros;
-- rollback
-- commit;
select * from facturacion_empresas;
select * from contratacion_convenios;
select * from tarifas_tipostarifas;

select conv.nombre, "vigenciaDesde" vigenciaDesde, "vigenciaHasta" vigenciaHasta, emp.nombre  empresa, tar.nombre
from contratacion_convenios conv, facturacion_empresas emp, tarifas_tipostarifa tar
WHERE emp.id = conv.empresa_id and tar.id = conv."tipoTarifa_id";

detalle = 'select conv.nombre nombre, "vigenciaDesde" vigenciaDesde, "vigenciaHasta" vigenciaHasta, emp.nombre  empresa, tar.nombre from contratacion_convenios conv, facturacion_empresas emp, tarifas_tipostarifa tar WHERE emp.id = conv.empresa_id and tar.id = conv."tipoTarifa_id"'

-- Fin Tarifas PARTCULAR 2024
select * from tarifas_tarifassuministros;
select * from tarifas_tarifas;
select * from tarifas_tipostarifa; -- 2 medical


 

select * from pruebascums where cum= '104739-1';
select * from rips_ripscums where id=5779
select distinct "principioActivo" from rips_ripscums
select * from rips_ripsformafarmaceutica; -- 6

select * from facturacion_conceptos; -- 6 medicamento
select * from facturacion_tipossuministro; -- 1 med
select cums, nombre, "concepto_id", "tipoSuministro_id","viaAdministracion_id","formasFarmaceutica_id",
"unidadMedida_id" , "principioActivo_id", * 
from facturacion_suministros
order by cums


select * from clinico_formasfarmaceuticas;
select * from rips_ripscums 
select * from clinico_examenes;
select * from facturacion_suministros;

insert into facturacion_suministros (nombre,"nombreGenerico",cums,"estadoReg",concepto_id,"tipoSuministro_id", "unidadMedida_id", 
                   "viaAdministracion_id"  ,"formasFarmaceutica_id","principioActivo_id","descripcionComercial" , "fechaExpedicion", 
                    "registroSanitario", "ripsCums_id")
select nombre,nombre,cum ,'A', 6  , 1 ,1 , "viaAdministracion_id", 6, "principiosActivos_id"  , descripcion, '20245-10-23 00:00:00' , invima ,
         id
from rips_ripscums 

select * from clinico_viasadministracion;







