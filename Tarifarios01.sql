select * from tarifarios_tipostarifa;
select * from contratacion_conveniosprocedimientos;
SELECT * FROM bak_contratacion_conveniosprocedimientos;
select * from contratacion_conveniossuministros;
create table bak_contratacion_conveniosprocedimientos as select * from contratacion_conveniosprocedimientos;
create table bak_contratacion_conveniossuministros as select * from contratacion_conveniossuministros;

SELECT * FROM CLINICO_EXAMENES WHERE ID IN (238,360);

SELECT * FROM TARIFARIOS_tarifariosprocedimientos;
SELECT * FROM TARIFAS_tiposhonorarios;

select * from bak_contratacion_conveniosprocedimientos where cups_id=238 ;
delete from TARIFARIOS_tarifariosprocedimientos

insert into tarifarios_tarifariosprocedimientos ("tiposTarifa_id", "codigoCups_id", "codigoHomologado", concepto_id, "colValorBase", "usuarioRegistro_id", "fechaRegistro", "estadoReg") 
select "tipoTarifa_id",cups_id, "codigoHomologado", concepto_id, cast(valor as numeric), "usuarioRegistro_id", now(), "estadoReg"
from bak_contratacion_conveniosprocedimientos
where cups_id != 238 ;

select count(*) from contratacion_conveniosprocedimientos; -- 1751
select count(*) from tarifarios_tarifariosprocedimientos; -- 1749
 
 
--delete from contratacion_conveniosprocedimientos;
select *  from contratacion_conveniosprocedimientos;

select * from facturacion_conceptos;

SELECT * FROM CONTRATACION_CONVENIOS;
select * from facturacion_conveniospacienteingresos

-- qUERY CONVENIOS DE LOS pACIENMTES

SeLECT 	ing.id,ing."tipoDoc_id", ing.documento_id,ing."consecAdmision",usu.nombre, ing.convenio_id, conv.nombre
FROM facturacion_conveniospacienteingresos ing, contratacion_convenios conv, usuarios_usuarios usu
WHERE usu."tipoDoc_id" = ing."tipoDoc_id" and usu.id = ing.documento_id AND conv.id = ing.convenio_id
	order by documento_id,ing."consecAdmision"

select * from tarifarios_TarifariosDescripcion;
delete from tarifarios_TarifariosDescripcion where id>=25;
--delete from tarifarios_TarifariosDescripcion where id=14;
select * from tarifarios_tipostarifa;
select * from tarifarios_tipostarifaProducto;
select * from tarifarios_tarifariosprocedimientos; -- 1749
select * from tarifarios_tarifariosprocedimientos where "codigoHomologado" = '19729'

select * from tarifarios_tarifariosprocedimientos order by "colValor1"; 
select * from clinico_examenes;
select * from contratacion_convenios;
select * from facturacion_ConveniosPaciente;
select * from tarifarios_tipostarifa where "tiposTarifaProducto_id" in (select id from tarifarios_tipostarifaProducto where nombre like ('%PROCED%'));

SELECT x.id id, x.nombre  nombre
	FROM  tarifas_tipostarifa x
	where x."tiposTarifaProducto_id" in (select id from tarifarios_tipostarifaProducto where nombre like ('%PROCED%'))

select tiptar.id  id,tarprod.nombre tipo, tiptar.nombre tipoTarifa, tardes.columna columna, tardes.descripcion descripcion
	from tarifarios_tipostarifaProducto tarprod, tarifarios_tipostarifa tiptar, tarifarios_TarifariosDescripcion tardes
	where tarprod.id = tiptar."tiposTarifaProducto_id" and tiptar.id = tardes."tiposTarifa_id"  and tarprod.nombre like ('%PROCE%') 
	order by tarprod.nombre
 
-- QUerys valiosos :

-- 1 er Query

select tiptar.id  id,tarprod.nombre tipo, tiptar.nombre tipoTarifa, tardes.columna columna, tardes.descripcion descripcion
from tarifarios_tipostarifaProducto tarprod, tarifarios_tipostarifa tiptar, tarifarios_TarifariosDescripcion tardes
where tarprod.id = tiptar."tiposTarifaProducto_id" and tiptar.id = tardes."tiposTarifa_id" and tarprod.nombre like ('%PROCE%')
order by tarprod.nombre 


-- do Query El detalle
	
select tarprod.nombre, tiptar.nombre , tardes.columna, tardes.descripcion , tarproc."codigoHomologado", exa.nombre, tarproc."colValorBase", tarproc."colValor1", tarproc."colValor2"
from tarifarios_tipostarifaProducto tarprod, tarifarios_tipostarifa tiptar, tarifarios_TarifariosDescripcion tardes, tarifarios_tarifariosprocedimientos tarproc,
	 clinico_examenes exa
where tarprod.id = tiptar."tiposTarifaProducto_id" and tiptar.id = tardes."tiposTarifa_id" and tarproc."tiposTarifa_id" = tiptar.id 
	and tardes.columna='colValorBase' and exa.id = tarproc."codigoCups_id"

-- Query detalle_1

	select tarprod.nombre, tiptar.nombre ,  tarproc."codigoHomologado", exa.nombre, tarproc."colValorBase", tarproc."colValor1", tarproc."colValor2"
	, tarproc."colValor3"	, tarproc."colValor4"	, tarproc."colValor5"	, tarproc."colValor6"	, tarproc."colValor7"	, tarproc."colValor8"	, tarproc."colValor9" , tarproc."colValor10"	
from tarifarios_tipostarifaProducto tarprod, tarifarios_tipostarifa tiptar, tarifarios_TarifariosDescripcion tardes, tarifarios_tarifariosprocedimientos tarproc,
	 clinico_examenes exa
where tarprod.id = tiptar."tiposTarifaProducto_id" and tiptar.id = tardes."tiposTarifa_id" and tarproc."tiposTarifa_id" = tiptar.id 
	and tardes.columna='colValorBase' and exa.id = tarproc."codigoCups_id"

-- Query detalle_2

select tiptar.nombre , tarproc."codigoCups_id" cups, tarproc."codigoHomologado", exa.nombre, tarproc."colValorBase", tarproc."colValor1", tarproc."colValor2"
	, tarproc."colValor3"	, tarproc."colValor4"	, tarproc."colValor5"	, tarproc."colValor6"	, tarproc."colValor7"	, tarproc."colValor8"	, tarproc."colValor9" , tarproc."colValor10"	
from tarifarios_tipostarifaProducto tarprod, tarifarios_tipostarifa tiptar, tarifarios_TarifariosDescripcion tardes, tarifarios_tarifariosprocedimientos tarproc,
	 clinico_examenes exa
where tarprod.id = tiptar."tiposTarifaProducto_id" and tiptar.id = tardes."tiposTarifa_id" and tarproc."tiposTarifa_id" = tiptar.id 
	and tardes.columna='colValorBase' and exa.id = tarproc."codigoCups_id"


	
-- Otro query	

select tarprod.nombre, tiptar.nombre , tardes.columna, tardes.descripcion , tarproc."codigoHomologado", tarproc."colValorBase",
	tarproc."colValor1", tarproc."colValor2"
from tarifarios_tipostarifaProducto tarprod, tarifarios_tipostarifa tiptar, tarifarios_TarifariosDescripcion tardes, tarifarios_tarifariosprocedimientos tarproc
where tarprod.id = tiptar."tiposTarifaProducto_id" and tiptar.id = tardes."tiposTarifa_id" and tarproc."tiposTarifa_id" = tiptar.id 
and tardes.columna='colValor1'

-- delete

-- delete from tarifarios_tarifariosprocedimientos where "codigoCups_id" = 2692;
select * from clinico_examenes where id = 2692

select * from tarifarios_tarifariosprocedimientos order by "codigoCups_id"
	DELETE FROM tarifarios_tarifariosprocedimientos  WHERE "tiposTarifa_id" = 2;
select * from tarifas_tipostarifa;


select count(*) from tarifarios_tarifariosprocedimientos -- 3876
select * from tarifarios_tarifariosdescripcion;
-- delete from tarifarios_tarifariosdescripcion
	where id >= 5;
select empresa_id,* from contratacion_convenios order by id;

select * from facturacion_conveniospacienteingresos;

UPDATE contratacion_convenios set "tarifariosDescripcionProc_id" = null where id !=1;

SELECT p.id id, p.nombre  nombre 
	FROM  tarifarios_tipostarifa  p
	where p."tiposTarifaProducto_id" in (select id from tarifarios_tipostarifaProducto where nombre like ('%PROCED%'))
   
	select * from tarifarios_tipostarifaproducto;
select * from tarifarios_tarifariosdescripcion; -- tiposTarifa_id
select * from tarifarios_tipostarifa;


select * from tarifarios_tarifariosprocedimientos order by "codigoCups_id", "tiposTarifa_id"
	select * from tarifarios_tarifariosprocedimientos where "tiposTarifa_id" = 2 order by "codigoCups_id", "tiposTarifa_id" -- 3876
	
begin transaction;
delete from tarifarios_tarifariosprocedimientos where "tiposTarifa_id" = 2 
	-- rollback;
	--commit;
	select * from contratacion_convenios;
	
		select * from tarifarios_tarifariosprocedimientos where "tiposTarifa_id" = 1 order by "codigoCups_id", "tiposTarifa_id" -- 3876

	select * from tarifas_TiposHonorarios;

SELECT * FROM contratacion_convenios order by id;
select  * from tarifarios_tarifariosprocedimientos;

select * from clinico_examenes;
select * from facturacion_conceptos;
select * from tarifarios_tipostarifa;
select * from contratacion_convenios;
select cums,* from facturacion_suministros order by cums;
select * from tarifarios_tipostarifa order by "tiposTarifaProducto_id";;



select
codigoHomologado, colValorBase, fechaRegistro, estadoReg  ,exa.id  , concepto,    tiposTarifa_id
from tarifarios_tarifariosprocedimientos
where 

select * from 	tarifarios_tarifariosprocedimientos;
select * from 	tarifarios_tarifariossuministros    '555114';
select * from 	tarifarios_tarifariossuministros  WHERE   '555114';
select * from 	tarifarios_tarifariossuministros  WHERE  cums = '555115';

select * from facturacion_suministros where cums like ('%S5511%');

select '' codigoHomologado, "colValorBase" colValorBase , now() fechaRegistro, 'A' estadoReg  ,  exa.id codigoCups_id , 4 concepto,    2 tiposTarifa_id
from clinico_examenes exa, tarifarios_tarifariosprocedimientos tar
where tar."tiposTarifa_id" = 1 AND tar."codigoCups_id" = exa.id order by exa.id --  3876 registros

select 'xyz-1' codigoHomologado, (row_number() OVER(ORDER BY exa.id) +  200000) colValorBase , now() fechaRegistro, 'A' estadoReg  ,  exa.id codigoCums_id , exa.concepto_id concepto,
	4 tiposTarifa_id
from facturacion_suministros exa -- , tarifarios_tarifariossuministros tar
--where tar."tiposTarifa_id" = 4 AND tar."codigoCum_id" = exa.id
	order by exa.id
update tarifarios_TarifariosDescripcion set descripcion = 'I'

		select * from tarifarios_tipostarifaproducto;
delete  from 	tarifarios_tarifariossuministros where "codigoCum_id"= 613;

select tarsum.id id, tiptar.nombre tipoTarifa, exa.cums cums, tarsum."codigoHomologado" codigoHomologado, exa.nombre exaNombre, tarsum."colValorBase", tarsum."colValor1", tarsum."colValor2" , tarsum."colValor3"      , tarsum."colValor4"
        , tarsum."colValor5"    , tarsum."colValor6"    , tarsum."colValor7"    , tarsum."colValor8"    , tarsum."colValor9" , tarsum."colValor10"
	from tarifarios_tipostarifaProducto tarprod, tarifarios_tipostarifa tiptar, tarifarios_TarifariosDescripcion tardes,
	tarifarios_tarifariossuministros tarsum, facturacion_suministros exa 
	where tiptar.id = tardes."tiposTarifa_id" and tarsum."tiposTarifa_id" = tiptar.id and
	tardes.columna='colValorBase' and exa.id = tarsum."codigoCum_id" and tarsum."tiposTarifa_id" ='4' and tarprod.id = tiptar."tiposTarifaProducto_id"


select * from contratacion_convenios;
select * from facturacion_conveniospacienteingresos;
select * from usuarios_usuarios;

INSERT INTO facturacion_liquidacion (documento_id,"consecAdmision", fecha,"fechaRegistro","estadoRegistro", convenio_id, "tipoDoc_id", "sedesClinica_id")
	VALUES ()

insert into facturacion_ConveniosPacienteIngresos ("consecAdmision", "fechaRegistro",  convenio_id, documento_id, "tipoDoc_id" , "usuarioRegistro_id" ,
	"estadoReg")
	values ('1' , '2025-04-08 12:11:07.336252', '8'  , '24', '3','1','A');

SELECT * FROM clinico_examenes where 
select convenio_id,* from facturacion_liquidacion;
update facturacion_liquidacion set convenio_id=1 where id=120;
select * from tarifarios_tarifariosdescripcion;
select * from tarifarios_tarifariosprocedimientos where id in (27235,19012,30647);
select * from clinico_examenes where "codigoCups" = '903402'; -- 487

-- Este es el qury que trae la tariufa SUPOER QUERY En la tarde trabajarlop


SELECT conv.convenio_id convenio ,exa."codigoCups" cups, proc."colValorBase" tarifaValor , proc."colValor1" colValor1,exa.id, proc.id
	FROM facturacion_conveniospacienteingresos conv, tarifarios_tarifariosdescripcion des, tarifarios_tarifariosprocedimientos proc,
	     clinico_examenes exa, contratacion_convenios conv1 , tarifarios_tipostarifa tiptar
	WHERE conv."tipoDoc_id" = '3' AND conv.documento_id = 24 AND conv."consecAdmision" = 1 and conv.convenio_id = conv1.id AND
	des.id = conv1."tarifariosDescripcionProc_id" AND conv1.id = 1 AND proc."codigoCups_id" = exa.id      And exa."codigoCups" = '903402'  
	and des."tiposTarifa_id" = tiptar.id and proc."tiposTarifa_id" = tiptar.id

	select * from facturacion_liquidaciondetalle order by fecha;
	   
SELECT conv.convenio_id convenio ,exa."codigoCups" cups, proc."colValorBase" tarifaValor 
	FROM facturacion_conveniospacienteingresos conv, tarifarios_tarifariosdescripcion des, tarifarios_tarifariosprocedimientos proc,
	     clinico_examenes exa, contratacion_convenios conv1 , tarifarios_tipostarifa tiptar
	WHERE conv."tipoDoc_id" = '3' AND conv.documento_id = 24 AND conv."consecAdmision" = 1 and conv.convenio_id = conv1.id AND
	des.id = conv1."tarifariosDescripcionProc_id" AND conv1.id = 1 AND proc."codigoCups_id" = exa.id      And exa."codigoCups" = '903402'  
	and des."tiposTarifa_id" = tiptar.id and proc."tiposTarifa_id" = tiptar.id

SELECT * FROM tarifarios_tarifariossuministros WHERE "codigoCum_id" = 616;
select * from facturacion_suministros where id= 616
	select * from tarifarios_tipostarifa
	select * from tarifarios_tipostarifaproducto;
select * from tarifarios_tarifariosdescripcion;
select * from facturacion_liquidacion;
	


SELECT conv.convenio_id convenio ,exa.cums cums, sum."colValor1" tarifaValor ,  tiptar.id
	FROM facturacion_conveniospacienteingresos conv, tarifarios_tarifariosdescripcion des, tarifarios_tarifariossuministros sum, 
	facturacion_suministros exa, contratacion_convenios conv1 , tarifarios_tipostarifa tiptar, tarifarios_tipostarifaproducto tipprod
	WHERE conv."tipoDoc_id" = '3' AND conv.documento_id = '24' AND conv."consecAdmision" = '1' AND conv.convenio_id = conv1.id AND
	des.id = conv1."tarifariosDescripcionSum_id" AND conv1.id = 1 AND sum."codigoCum_id" = exa.id  
	And exa.id = '616' AND des."tiposTarifa_id" = tiptar.id and tiptar."tiposTarifaProducto_id" = tipprod.id 
	and sum."tiposTarifa_id" = tiptar.id 

SELECT * FROM autorizaciones_autorizaciones;

select documento_id,empresa_id, * from admisiones_ingresos;
select convenio_id,* from facturacion_liquidacion;
select * from facturacion_liquidaciondetalle where liquidacion_id=120;
select * from facturacion_liquidaciondetalle where liquidacion_id=126;
select * from contratacion_convenios;

select documento_id,* from admisiones_ingresos;
select * from usuarios_usuarios;
select * from sitios_dependencias;

select * from contratacion_convenios;
select convenio_id,* from facturacion_liquidacion;

update facturacion_liquidacion 
set "totalProcedimientos" = 88000,"totalSuministros" = 0,"totalLiquidacion" = 0,"valorApagar" = 0,"totalCopagos"=0,"totalCuotaModeradora"=0,"totalAbonos"=0,anticipos=0,"totalRecibido"=0
where id=127
select * from facturacion_liquidacion  
	
	select  * from facturacion_ConveniosPacienteIngresos;
select * from cartera_pagos;
delete from cartera_pagos where documento_id=27
select * from cartera_formaspagos;

select documento_id,  * from cartera_pagos order by documento_id;
update cartera_pagos set saldo=valor, "valorEnCurso" = 0 where id = 149;

select * from cartera_pagosfacturas;
select * from facturacion_liquidacion;
	

select * from facturacion_liquidaciondetalle WHERE liquidacion_id= 127 ;
update facturacion_liquidacion
set convenio_id = 1
where id=120;

SELECT conv.convenio_id convenio ,exa.cums cums, sum."colValor1" tarifaValor
	FROM facturacion_conveniospacienteingresos conv, tarifarios_tarifariosdescripcion des, tarifarios_tarifariossuministros sum, facturacion_suministros exa, contratacion_convenios conv1 , tarifarios_tipostarifa tiptar 
	WHERE conv."tipoDoc_id" = '1' AND conv.documento_id = '27' AND conv."consecAdmision" = '1' AND conv.convenio_id = conv1.id AND 
	des.id = conv1."tarifariosDescripcionSum_id" AND sum."codigoCum_id" = exa.id  And exa.id = '5651' AND des."tiposTarifa_id" = tiptar.id and
	sum."tiposTarifa_id" = tiptar.id
-- 127 y 128
-- rollback
select * from contratacion_convenios;
select * from facturacion_liquidaciondetalle where liquidacion_id = 127;
select * from facturacion_liquidaciondetalle where liquidacion_id = 128;
select * from facturacion_liquidacion where id in (127,128)

	
-- estas son las que voy a pasar:

select liq.convenio_id , conv.nombre,det.examen_id, det.cums_id, det.cantidad
from facturacion_liquidacion liq  , facturacion_liquidaciondetalle det, contratacion_convenios conv
where det.liquidacion_id = liq.id and det.liquidacion_id = 127 and liq.convenio_id= conv.id and det."estadoRegistro" = 'A'


select liq.convenio_id , conv.nombre,det.examen_id, det.cums_id, det.cantidad, conv."tarifariosDescripcionProc_id", conv."tarifariosDescripcionSum_id"
from facturacion_liquidacion liq  , facturacion_liquidaciondetalle det, contratacion_convenios conv
where det.liquidacion_id = liq.id and det.liquidacion_id = 127 and liq.convenio_id= conv.id and det."estadoRegistro" = 'A'

-- Ahora con tarifas nuevas Para procedimientos

	select * from tarifarios_tipostarifa;
select * from tarifarios_tarifariosdescripcion;
select * from tarifarios_tarifariosProcedimientos;
select * from tarifarios_tarifariosSuministros;
select * from tarifarios_tarifariosProcedimientos where "codigoCups_id"= '2060';

select liq.convenio_id , conv.nombre,det.examen_id, det.cums_id, det.cantidad, conv."tarifariosDescripcionProc_id", conv."tarifariosDescripcionSum_id",
	 descrip.columna, tiptar.nombre, descrip.descripcion, det."valorUnitario" estaba, proc."colValor1" nuevo
from facturacion_liquidacion liq  , facturacion_liquidaciondetalle det, contratacion_convenios conv,
	  tarifarios_tarifariosdescripcion descrip, tarifarios_tipostarifa tiptar, tarifarios_tarifariosProcedimientos proc
where det.liquidacion_id = liq.id and det.liquidacion_id = 127 and liq.convenio_id= conv.id and det."estadoRegistro" = 'A' and
   descrip.id = conv."tarifariosDescripcionProc_id" and tiptar.id = descrip."tiposTarifa_id" and
tiptar.id = proc."tiposTarifa_id" and proc."codigoCups_id" = det.examen_id

begin transaction;	
insert into facturacion_liquidaciondetalle
( consecutivo, fecha, cantidad, "valorUnitario", "valorTotal", cirugia, "fechaCrea", "fechaModifica", observaciones, "fechaRegistro", "estadoRegistro",
	examen_id,  "usuarioModifica_id", "usuarioRegistro_id", liquidacion_id, "tipoHonorario_id", "tipoRegistro", "historiaMedicamento_id"	)
select  det.consecutivo, liq.fecha, cantidad,proc."colValor1"    , proc."colValor1" * cantidad, cirugia, "fechaCrea", "fechaModifica", liq.observaciones,
	liq."fechaRegistro",
	liq."estadoRegistro", examen_id, "usuarioModifica_id", liq."usuarioRegistro_id", liquidacion_id, "tipoHonorario_id",
	"tipoRegistro", "historiaMedicamento_id"
from facturacion_liquidacion liq  , facturacion_liquidaciondetalle det, contratacion_convenios conv,
	  tarifarios_tarifariosdescripcion descrip, tarifarios_tipostarifa tiptar, tarifarios_tarifariosProcedimientos proc
where det.liquidacion_id = liq.id and det.liquidacion_id = 127 and liq.convenio_id= conv.id and det."estadoRegistro" = 'A' and
   descrip.id = conv."tarifariosDescripcionProc_id" and tiptar.id = descrip."tiposTarifa_id" and
tiptar.id = proc."tiposTarifa_id" and proc."codigoCups_id" = det.examen_id
	
-- rollback;

comando ='INSERT INTO facturacion_liquidaciondetalle ( consecutivo, fecha, cantidad, "valorUnitario", "valorTotal", cirugia, "fechaCrea", "fechaModifica", observaciones, "fechaRegistro", "estadoRegistro",examen_id,  "usuarioModifica_id", "usuarioRegistro_id", liquidacion_id, "tipoHonorario_id", "tipoRegistro", "historiaMedicamento_id") select  det.consecutivo, liq.fecha, cantidad, proc."' + str(columna) + "'" + ', proc."' + str(columna) + "'" + ' * cantidad, cirugia, "fechaCrea", "fechaModifica", liq.observaciones, liq."fechaRegistro", liq."estadoRegistro", examen_id, "usuarioModifica_id", liq."usuarioRegistro_id", liquidacion_id, "tipoHonorario_id",	"tipoRegistro", "historiaMedicamento_id" from facturacion_liquidacion liq  , facturacion_liquidaciondetalle det, contratacion_convenios conv,	  tarifarios_tarifariosdescripcion descrip, tarifarios_tipostarifa tiptar, tarifarios_tarifariosProcedimientos proc where det.liquidacion_id = liq.id and det.liquidacion_id = ' + "'" + str(liquidacionIdHasta) + "'" + ' and liq.convenio_id= conv.id and det."estadoRegistro" = 'A' and descrip.id = conv."tarifariosDescripcionProc_id" and tiptar.id = descrip."tiposTarifa_id" and tiptar.id = proc."tiposTarifa_id" and proc."codigoCups_id" = det.examen_id'
-- Buscar columna De Procedimientos
SELECT descrip.columna FROM facturacion_liquidacion liq,contratacion_convenios conv,tarifarios_tarifariosdescripcion descrip
where liq.id =	127 AND liq.convenio_id = conv.id and descrip.id = conv."tarifariosDescripcionProc_id"
	
comando =	'SELECT descrip.columna FROM facturacion_liquidacion liq,contratacion_convenios conv,tarifarios_tarifariosdescripcion descrip where liq.id =	' + "'" + str(liquidacionIdHasta) + "'" + ' AND liq.convenio_id = conv.id and descrip.id = conv."tarifariosDescripcionProc_id"'

	
-- uery para suministros

-- 5651

	select * from tarifarios_tarifariossuministros where "codigoCum_id"= '5651';

-- Ops no tengo tarifa de compensar como soluciono las que no esten con tarifas. Tocaria en ceros OPS mas querys pero toca papa??

select liq.convenio_id , conv.nombre,det.examen_id, det.cums_id, det.cantidad, conv."tarifariosDescripcionProc_id", conv."tarifariosDescripcionSum_id",
	 descrip.columna, tiptar.nombre, descrip.descripcion, det."valorUnitario" estaba, sum."colValor1" nuevo
from facturacion_liquidacion liq  , facturacion_liquidaciondetalle det, contratacion_convenios conv,
	  tarifarios_tarifariosdescripcion descrip, tarifarios_tipostarifa tiptar, tarifarios_tarifariosSuministros sum
where det.liquidacion_id = liq.id and det.liquidacion_id = 127 and liq.convenio_id= conv.id and det."estadoRegistro" = 'A' and
   descrip.id = conv."tarifariosDescripcionProc_id" and tiptar.id = descrip."tiposTarifa_id" and
tiptar.id = sum."tiposTarifa_id" and sum."codigoCum_id" = det.cums_id

insert into
( consecutivo, fecha, cantidad, "valorUnitario", "valorTotal", cirugia, "fechaCrea", "fechaModifica", observaciones, "fechaRegistro", "estadoRegistro", examen_id, cums_id, "usuarioModifica_id", "usuarioRegistro_id", liquidacion_id, "tipoHonorario_id", "tipoRegistro", "historiaMedicamento_id"
	
	)
select  consecutivo, liq.fecha, cantidad, "valorUnitario", "valorTotal", cirugia, "fechaCrea", "fechaModifica", liq.observaciones, liq."fechaRegistro",
	liq."estadoRegistro", examen_id, cums_id, "usuarioModifica_id", liq."usuarioRegistro_id", liquidacion_id, "tipoHonorario_id",
	"tipoRegistro", "historiaMedicamento_id"
	
from facturacion_liquidacion liq  , facturacion_liquidaciondetalle det, contratacion_convenios conv,
	  tarifarios_tarifariosdescripcion descrip, tarifarios_tipostarifa tiptar, tarifarios_tarifariosSuministros sum
where det.liquidacion_id = liq.id and det.liquidacion_id = 127 and liq.convenio_id= conv.id and det."estadoRegistro" = 'A' and
   descrip.id = conv."tarifariosDescripcionProc_id" and tiptar.id = descrip."tiposTarifa_id" and
tiptar.id = sum."tiposTarifa_id" and sum."codigoCum_id" = det.cums_id


comando ='INSERT INTO facturacion_liquidaciondetalle ( consecutivo, fecha, cantidad, "valorUnitario", "valorTotal", cirugia, "fechaCrea", "fechaModifica", observaciones, "fechaRegistro", "estadoRegistro",cums_id,  "usuarioModifica_id", "usuarioRegistro_id", liquidacion_id, "tipoHonorario_id", "tipoRegistro", "historiaMedicamento_id") select  det.consecutivo, liq.fecha, cantidad, sum."' + str(columnaSuministro) + "'" + ', sum."' + str(columnaSuministro) + "'" + ' * cantidad, cirugia, "fechaCrea", "fechaModifica", liq.observaciones, liq."fechaRegistro", liq."estadoRegistro", cums_id, "usuarioModifica_id", liq."usuarioRegistro_id", liquidacion_id, "tipoHonorario_id",	"tipoRegistro", "historiaMedicamento_id" from facturacion_liquidacion liq  , facturacion_liquidaciondetalle det, contratacion_convenios conv,	  tarifarios_tarifariosdescripcion descrip, tarifarios_tipostarifa tiptar, tarifarios_tarifariosSuministros sum where det.liquidacion_id = liq.id and det.liquidacion_id = ' + "'" + str(liquidacionIdHasta) + "'" + ' and liq.convenio_id= conv.id and det."estadoRegistro" = 'A' and descrip.id = conv."tarifariosDescripcionProc_id" and tiptar.id = descrip."tiposTarifa_id" and tiptar.id = sum."tiposTarifa_id" and sum."codigoCum_id" = det.cums_id'
	

-- Busco la columna de suministros

comando =	'SELECT descrip.columna FROM facturacion_liquidacion liq,contratacion_convenios conv,tarifarios_tarifariosdescripcion descrip where liq.id =	' + "'" + str(liquidacionIdHasta) + "'" + ' AND liq.convenio_id = conv.id and descrip.id = conv."tarifariosDescripcionSumc_id"'

 
select * from tarifarios_tarifariosProcedimientos;


begin transaction;
INSERT INTO facturacion_liquidaciondetalle ( consecutivo, fecha, cantidad, "valorUnitario", "valorTotal", cirugia, "fechaCrea", "fechaModifica",
	observaciones, "fechaRegistro", "estadoRegistro",examen_id,  "usuarioModifica_id", "usuarioRegistro_id", liquidacion_id, "tipoHonorario_id",
	"tipoRegistro", "historiaMedicamento_id") 

	select  det.consecutivo, liq.fecha, cantidad, proc."colValor1", proc."colValor1" * cantidad, cirugia, "fechaCrea", "fechaModifica", liq.observaciones, liq."fechaRegistro",
	liq."estadoRegistro", examen_id, "usuarioModifica_id", liq."usuarioRegistro_id", liquidacion_id, "tipoHonorario_id", 
	"tipoRegistro", "historiaMedicamento_id" from facturacion_liquidacion liq  , facturacion_liquidaciondetalle det, contratacion_convenios conv,
	tarifarios_tarifariosdescripcion descrip, tarifarios_tipostarifa tiptar, tarifarios_tarifariosProcedimientos proc
	where det.liquidacion_id = liq.id and det.liquidacion_id = '128' and liq.convenio_id= conv.id and det."estadoRegistro" = 'A' and
	descrip.id = conv."tarifariosDescripcionProc_id" and tiptar.id = descrip."tiposTarifa_id" and tiptar.id = proc."tiposTarifa_id" and 
	proc."codigoCups_id" = det.examen_id

-- rollback;

select * from facturacion_conveniospacienteingresos
select * from cartera_pagos;
select * from admisiones_ingresos;

select count(*)  from facturacion_conveniospacienteingresos where "tipoDoc_id" = '1' and documento_id=27 and "consecAdmision"=2
select count(*) from cartera_pagos where "tipoDoc_id" = '1' and documento_id=27 and consec=1

(select count(*)  from facturacion_conveniospacienteingresos conv where conv."tipoDoc_id" = i."tipoDoc_id" and conv.documento_id=i.documento_id  and conv."consecAdmision"=i.consec) numConvenios,(select count(*)  from cartera_pagos pag where pag."tipoDoc_id" = i."tipoDoc_id" and pag.documento_id=i.documento_id  and pag.consec=i.consec) numPagos

select * from cartera_pagosfacturas;

select * from facturacion_liquidacion where	id in (127,128);
select * from facturacion_liquidaciondetalle where	liquidacion_id in (127,128); 
select * from facturacion_liquidaciondetalle where	liquidacion_id in (128); 
select * from facturacion_liquidaciondetalle where	liquidacion_id in (127);
select convenio_id,* from facturacion_liquidacion where	id in (127,128); 
select * from contratacion_convenios;

select * from sitios_dependencias;
select * from sitios_historialdependencias;; dep=12, doc_id=27 tipodoc 1

	update sitios_dependencias set documento_id=27, "tipoDoc_id"=1, consec=1, disponibilidad='O'
where id=12

	select * from cartera_pagos
	select * from cartera_pagosFacturas;

	INSERT INTO cartera_pagosFacturas ("valorAplicado", "fechaRegistro","estadoReg", "facturaAplicada_id",pago_id)
	
	SELECT "valorEnCurso", '2025-04-11 10:58:20.706465','A',52, id 
	FROM cartera_pagos 
	WHERE documento_id = '25' AND "tipoDoc_id" = '3' AND consec = '1'

		select * from facturacion_facturacion where id=53;
select * from facturacion_facturaciondetalle where facturacion_id=53;
select * from facturacion_facturacion where id=53;

	

select * from facturacion_suministros where id=5651;
select * from tarifarios_tarifariosdescripcion
select * from tarifarios_tarifariosSuministros where "codigoCum_id"= 5651; -- 4
select * from tarifarios_tipostarifa;
select * from admisiones_ingresos where factura=53

SELECT facturas.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , 
	i."fechaIngreso" fechaIngreso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida, dep.nombre camaNombreSalida , diag.nombre dxSalida ,
	conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica, facturas."estadoReg" estadoReg 
	FROM admisiones_ingresos i
	INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id") 
	INNER JOIN sitios_dependencias dep ON (dep."sedesClinica_id" = i."sedesClinica_id" AND dep."serviciosSedes_id" = sd.id AND dep.id = i."dependenciasSalida_id") 
	INNER JOIN sitios_dependenciastipo deptip  ON (deptip.id = dep."dependenciasTipo_id")
	INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" =  i."tipoDoc_id" AND u.id = i."documento_id" ) 
	INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") 
	INNER JOIN clinico_servicios ser  ON ( ser.id  = i."serviciosSalida_id")  
	INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxSalida_id") 
	INNER JOIN facturacion_facturacion facturas ON (facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and facturas."consecAdmision" = i.consec )
	LEFT JOIN contratacion_convenios conv  ON (conv.id = facturas.convenio_id )
	WHERE i."fechaSalida" between '2025-01-01 00:00:00'  and '2025-05-01 23:59:59' AND i."sedesClinica_id" = '1' AND i."fechaSalida" is not null


select * from usuarios_usuarios -- 18 paula
select  documento_id, * from facturacion_liquidacion -- estadoRegistro = 'R'
select   * from facturacion_liquidaciondetalle where liquidacion_id = 129;
select * from admisiones_ingresos where factura=40;
select * from admisiones_ingresos where documento_id = 18;

select * from facturacion_liquidacion;
select * from facturacion_refacturacion;

update admisiones_ingresos set "salidaDefinitiva"='R' where id= 50101;

-- load_dataloiquidacion

SELECT 'INGRESO',  i.id, conv.id convenioId, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" , 
	i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual,conv.nombre convenio, conv.id convenioId ,
	i."salidaClinica" salidaClinica 
	FROM admisiones_ingresos i 
	INNER JOIN clinico_servicios ser ON (ser.id = i."serviciosActual_id" ) 
	INNER JOIN sitios_serviciosSedes sd ON (i."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id)
	INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  i."sedesClinica_id" and dep.id = i."dependenciasActual_id"  AND  (dep.disponibilidad= 'O' OR (dep.disponibilidad = 'L' AND ser.id=3)) AND dep."serviciosSedes_id" = sd.id )
	INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id")
	INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i."documento_id" )
	INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id")
	INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxActual_id") 
	LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and  fac."consecAdmision" = i.consec ) 
	LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id)
	WHERE i."sedesClinica_id" =  '1' AND ((i."salidaDefinitiva" = 'N' and i."fechaSalida" is null)  or  (i."fechaSalida" is not null and i."salidaDefinitiva"='R' )) 
	
	UNION
	SELECT ' + "'"  + str("TRIAGE") + "'"+ "||'-'||"  + ' t.id'  + "||" +"'" + "-'||case when conv.id != 0 then conv.id else " + "'" + str('00') + "'" + ' end id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre, t.consec consec , t."fechaSolicita" , cast(' + "'" + str('0001-01-01 00:00:00') + "'" + ' as timestamp) fechaSalida,ser.nombre servicioNombreIng, dep.nombre camaNombreIng , ' + "' '" + ' dxActual , conv.nombre convenio, conv.id convenioId , ' + "'" + str('N') + "'" + ' salidaClinica  FROM triage_triage t INNER JOIN clinico_servicios ser ON ( ser.nombre = ' + "'" + str('TRIAGE') + "')" + ' INNER JOIN sitios_serviciosSedes sd ON (t."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id and sd.id = t."serviciosSedes_id" ) INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  t."sedesClinica_id" and dep.id = t.dependencias_id  AND dep.disponibilidad = ' + "'" + str('O') + "'" + ' AND dep."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and t."consecAdmision" = 0 and dep."documento_id" = t."documento_id") INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = t."tipoDoc_id" and fac.documento_id = t.documento_id and  fac."consecAdmision" = t.consec ) LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) WHERE  t."sedesClinica_id" = ' + "'" + str(sede) + "'"


	select * from usuarios_usuarios;
select "tipoDoc_id", documento_id,consec,disponibilidad,* from sitios_dependencias order by documento_id;

select * from sitios_historialdependencias where documento_id=16;

select * from admisiones_ingresos;
	select * from clinico_historia;

	select * from triage_triage;

	select * from planta_planta;

select * from autorizaciones_autorizaciones;
select * from autorizaciones_autorizacionesdetalle;
select * from autorizaciones_estadosautorizacion

select aut.id id,  aut."fechaSolicitud" fechaSolicitud ,aut."numeroAutorizacion" numeroAutorizacion,aut."fechaAutorizacion" fechaAutorizacion, est.nombre estado, emp.nombre empresa,det.examenes_id examen ,det.cums_id cums, det."valorAutorizado" valorAutorizado, det."numeroAutorizacion" autDetalle, sum.nombre nombreSuministro, exa.nombre nombreExamen from autorizaciones_autorizaciones aut left join autorizaciones_autorizacionesdetalle det on (det.autorizaciones_id = aut.id)	inner join autorizaciones_estadosautorizacion est on (est.id = aut."estadoAutorizacion_id" ) left join facturacion_empresas emp on (emp.id = aut.empresa_id) left join facturacion_suministros sum on (sum.id=det.cums_id) left join clinico_examenes exa on (exa.id = det.examenes_id)


	select aut.id id,  aut."fechaSolicitud" fechaSolicitud ,aut."numeroAutorizacion" numeroAutorizacion,aut."fechaAutorizacion" fechaAutorizacion, 
	est.nombre estado, emp.nombre empresa,det.examenes_id examen ,det.cums_id cums, det."valorAutorizado" valorAutorizado, 
	det."numeroAutorizacion" autDetalle, sum.nombre nombreSuministro, exa.nombre nombreExamen 
	from autorizaciones_autorizaciones aut
	inner join clinico_historia his on (his.id = aut.historia_id)
	left join autorizaciones_autorizacionesdetalle det on (det.autorizaciones_id = aut.id)	
	inner join autorizaciones_estadosautorizacion est on (est.id = aut."estadoAutorizacion_id" ) 
	left join facturacion_empresas emp on (emp.id = aut.empresa_id) 
	left join facturacion_suministros sum on (sum.id=det.cums_id) 
	left join clinico_examenes exa on (exa.id = det.examenes_id)
	