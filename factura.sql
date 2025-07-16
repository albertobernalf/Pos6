SELECT min(convenio_id) convenioId FROM facturacion_ConveniosPacienteIngresos WHERE "tipoDoc_id" = '1' AND documento_id = '40' AND "consecAdmision" = '1'
SELECT convenio_id FROM facturacion_ConveniosPacienteIngresos WHERE "tipoDoc_id" = '1' AND documento_id = '40' AND "consecAdmision" = '1'

SELECT cups_id cups FROM cirugia_cirugiasprocedimientos WHERE cirugia_id = '18'

select * from facturacion_liquidaciondetalle order by id; -- 380	6	"2025-05-21 09:14:48.853081-05"	1.00	31750.00	31750.00	18	"2025-05-21 09:14:48.853081-05"			"2025-05

select "tipoSuministro_id", * from facturacion_suministros ;
select "tipoSuministro_id", * from facturacion_suministros WHERE  "tipoSuministro_id" <>'1';
select * from cirugia_cirugiasmaterialqx;


SELECT * FROM tarifarios_tablaSalasdecirugiaiss;

select * from tarifarios_tiposhonorarios;

UPDATE tarifas_tiposhonorarios SET nombre='DERECHOSDESALA' where id=6

SELECT * from cirugia_cirugias where id=18;
select * from sitios_tipossalas;
select * from sitios_salas;

SELECT tipsal.nombre,tarifa.valor , tarifa."desdeUvr", tarifa."hastaUvr"
FROM cirugia_cirugias cir, sitios_tipossalas tipsal, tarifarios_tablaSalasdecirugiaiss tarifa, sitios_salas sala
WHERE cir.id = 18 AND cir.sala_id = sala.id and sala."tipoSala_id" = tipsal.id and tarifa."tiposSala_id" = tipsal.id and '52' between tarifa."desdeUvr" AND tarifa."hastaUvr"

SELECT tarifa.valor FROM cirugia_cirugias cir, sitios_tipossalas tipsal, tarifarios_tablaSalasdecirugiaiss tarifa, sitios_salas sala WHERE cir.id = 18 AND cir.sala_id = sala.id and sala."tipoSala_id" = tipsal.id and tarifa."tiposSala_id" = tipsal.id and '52' between tarifa."desdeUvr" AND tarifa."hastaUvr"

select * from tarifarios_tablamaterialsuturacuracioniss;
select * from cirugia_cirugiasmaterialqx where cirugia_id=18;

SELECT sum.nombre,cirmat."valorLiquidacion" FROM cirugia_cirugiasmaterialqx cirmat LEFT JOIN facturacion_suministros sum ON ( sum.id=cirmat.suministro_id ) WHERE cirmat.cirugia_id = 18 

select * from facturacion_suministros where id in (17622,17621,17620,17620)

select * from facturacion_conceptos;
select * from facturacion_tipossuministro ;

SELECT * FROM FACTURACION_SUMINISTROS;
	
SELECT concepto_id", codigoCups", * FROM clinico_examenes;
SELECT concepto_id,"tipoSuministro_id",  cums,"ripsCums_id",* FROM facturacion_suministros order by "tipoSuministro_id" desc;

select * from cirugia_cirugiasmaterialqx;	
SELECT "tipoSuministro_id",* FROM FACTURACION_SUMINISTROS where "tipoSuministro_id" >1;
update FACTURACION_SUMINISTROS set "tipoSuministro_id" = 4 where "tipoSuministro_id"  = 9;

select matqx.suministro_id, sum.nombre, tipos.nombre,matqx."valorLiquidacion"
from cirugia_cirugiasmaterialqx matqx, facturacion_suministros sum, facturacion_tipossuministro tipos 
where matqx.cirugia_id=18 and matqx.suministro_id = sum.id and sum."tipoSuministro_id" = tipos.id and tipos.nombre = 'MATERIAL DE SUTURA Y CURACION'


select matqx.suministro_id, sum.nombre, tipos.nombre,matqx."valorLiquidacion"
from cirugia_cirugiasmaterialqx matqx, facturacion_suministros sum, facturacion_tipossuministro tipos 
where matqx.cirugia_id=18 and matqx.suministro_id = sum.id and sum."tipoSuministro_id" = tipos.id and tipos.nombre = 'MATERIAL QX'

select "tipoSuministro_id",* from facturacion_SUMINISTROS order by "tipoSuministro_id" desc;

select * from cirugia_cirugiasprocedimientos where cirugia_id=18;

select * from clinico_examenes where id=3173

select * from facturacion_liquidaciondetalle where cirugia_id=18 order by id
select * from facturacion_liquidaciondetalle where liquidacion_id=175

select * from tarifarios_tiposhonorarios;

	select * from cirugia_cirugiasmaterialqx;

	select "tipoSuministro_id",* from facturacion_suministros where id in (17622,17621,17620,17620,17628,17629,17630)

select * from cirugia_cirugiasprocedimientos where cirugia_id = 14;	

select * from tarifarios_tablamaterialsuturacuracion;
	
select * from cirugia_cirugiasmaterialqx where cirugia_id = 14;	

select "grupoQx_id",* from clinico_examenes where id=2365;	

select * from tarifarios_gruposqx;

SELECT cups_id cups, cruento, incruento , exa."grupoQx_id" grupoQx
FROM cirugia_cirugiasprocedimientos  cirproc
		INNER JOIN clinico_examenes exa ON (exa.id=cirproc.cups_id) 
WHERE cirugia_id = 14 

SELECT cups_id cups, cruento, incruento , max(exa."grupoQx_id") grupoQx
FROM cirugia_cirugiasprocedimientos  cirproc
		INNER JOIN clinico_examenes exa ON (exa.id=cirproc.cups_id) 
WHERE cirugia_id = 14 
group by  cups_id , cruento, incruento , exa."grupoQx_id"
	having exa."grupoQx_id" =(select  max(exa1."grupoQx_id")
							FROM cirugia_cirugiasprocedimientos  cirproc1
							INNER JOIN clinico_examenes exa1 ON (exa1.id=cirproc1.cups_id) 
							WHERE cirproc1.cirugia_id = cirproc.cirugia_id)
	
select "grupoQx_id",* from clinico_examenes;	
SELECT cups_id cups, cruento, incruento ,
	(
		select  max(exa1."grupoQx_id")
		FROM cirugia_cirugiasprocedimientos  cirproc1
		INNER JOIN clinico_examenes exa1 ON (exa1.id=cirproc1.cups_id and exa1.id=exa.id) 
		WHERE cirproc1.cirugia_id = cirproc.cirugia_id
	) grupoQx		
FROM cirugia_cirugiasprocedimientos  cirproc
		INNER JOIN clinico_examenes exa ON (exa.id=cirproc.cups_id) 
WHERE cirugia_id = 14 limit 1

select * from cirugia_cirugiasmaterialqx;
select * from tarifarios_tablahonorariossoat;

select * from tarifarios_tiposhonorarios;
select * from tarifarios_minimoslegales;
select * from tarifarios_tablasalasdecirugia;
select * from cirugia_programacioncirugias;

select empresa_id,* from admisiones_ingresos where "sedesClinica_id" = 1;

select empresa_id,* from contratacion_convenios where empresa_id in (5,1,3,4)

select * from tarifarios_tarifariosdescripcion;

select * from contratacion_convenios;
select * from facturacion_conveniospacienteingresos;

select adm.empresa_id , adm."tipoDoc_id", adm.documento_id, adm.consec, conv.id,conv.nombre, conv."tarifariosDescripcionProc_id"
from admisiones_ingresos adm, contratacion_convenios conv, facturacion_conveniospacienteingresos fac
where adm."sedesClinica_id" = 1 AND adm."tipoDoc_id" = fac."tipoDoc_id" AND adm.documento_id = fac.documento_id AND adm.consec= fac."consecAdmision" and
	fac.convenio_id = conv.id;


select * from cirugia_programacioncirugias;
select * from cirugia_programacioncirugias;


SELECT "smldv" * 1423500/30 valorCirujano
	FROM tarifarios_tablahonorariossoat 
	WHERE "grupoQx_id" = '5' AND  "tiposHonorarios_id" = '1'


select * from usuarios_usuarios where documento = '51872242';

select * from facturacion_liquidacion where documento_id = 16;
select * from facturacion_liquidaciondetalle where liquidacion_id= 138

select * from facturacion_conveniospacienteingresos;
select * from contratacion_convenios order by id;
select * from cirugia_estadosprogramacion where nombre in ('Programada','Cancelada')

