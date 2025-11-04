select * from cirugia_cirugias;

SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionInicia" as time), cast(prog."horaProgramacionFin" as time) , 'OCUPADO' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1'
	ORDER BY salas.numero,prog."fechaProgramacionInicia",cast(prog."horaProgramacionInicia" as time)


select * from sitios_salas;

select * from sitios_tipossalas;
select * from cirugia_estadossalas;

select * from cirugia_programacioncirugias
	update cirugia_programacioncirugias set sala_id=1

SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionInicia" as time), cast(prog."horaProgramacionFin" as time) , 'OCUPADO' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1'
union
SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionFin" as time) + interval '1 minute' , cast(salas."finServicio" as time) , 'LIBRE' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1'
--ORDER BY salas.numero,prog."fechaProgramacionInicia",cast(prog."horaProgramacionInicia" as time)
order by 2,4,6

-- El que sigue

	SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionInicia" as time), cast(prog."horaProgramacionFin" as time) , 'OCUPADO' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1'
union
	SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionInicia" as time)  , -- cast(prog."horaProgramacionFin" as time) 
		CASE when cast(salas."finServicio" as time) >= cast(prog."horaProgramacionInicia" as time) then cast(salas."finServicio" as time)   ELSE cast(prog."horaProgramacionInicia" as time)  END
	, 'LIBRE' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1' AND prog.id > (select min(prog1.id) from cirugia_programacioncirugias prog1 
														where prog1.id <> prog.id  ) 

	/*
SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionFin" as time) + interval '1 minute' ,
	CASE when cast(salas."finServicio" as time) >= cast(prog."horaProgramacionFin" as time) then cast(salas."finServicio" as time)   ELSE cast(prog."horaProgramacionFin" as time)  END
	, 'LIBRE' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1'	
*/
union	
SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionInicia" as time)  , cast(prog."horaProgramacionFin" as time) , 'OCUPADO' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1' AND prog.id > (select min(prog1.id) from cirugia_programacioncirugias prog1 
														where prog1.id <> prog.id  ) 
order by 2,4,6
	
select * from sitios_salas
select * from clinico_especialidadesmedicos
select * from cirugia_cirugias;
update cirugia_cirugias set especialidad_id=1
	select * from cirugia_programacioncirugias;

-- Otra voz

	SELECT prog.id, salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionInicia" as time), cast(prog."horaProgramacionFin" as time) , 'OCUPADO' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id and salas."sedesClinica_id" = prog."sedesClinica_id" )
	WHERE salas."sedesClinica_id" = '1'
union
SELECT prog.id,salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionFin" as time) + interval '1 minute' ,
	CASE when cast(salas."finServicio" as time) >= cast(prog."horaProgramacionFin" as time) then cast(salas."finServicio" as time)   ELSE cast(prog."horaProgramacionFin" as time)  END
	, 'LIBRE' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1'
		/*
SELECT prog.id, salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionFin", prog2."fechaProgramacionInicia" ,
	cast(prog."horaProgramacionFin" as time) + interval '1 minute' , cast(prog2."horaProgramacionInicia" as time) - interval '1 minute' , 'LIBRE' estado 
FROM cirugia_programacioncirugias prog , sitios_salas salas, cirugia_programacioncirugias prog2
where salas.id = prog.sala_id  and salas."sedesClinica_id" = prog."sedesClinica_id" and prog2."sedesClinica_id" = prog."sedesClinica_id"
		and	salas."sedesClinica_id" = '1' and prog.sala_id = prog2.sala_id and prog2.id = (select min(prog3.id) from cirugia_programacioncirugias prog3
														where prog3.id > prog.id and prog3.sala_id = prog.sala_id) 
*/
UNION
SELECT prog.id, salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionFin", prog2."fechaProgramacionInicia" ,
	cast(prog2."horaProgramacionFin" as time) + interval '1 minute' , cast(salas."finServicio" as time)  , 'LIBRE' estado 
FROM cirugia_programacioncirugias prog , sitios_salas salas, cirugia_programacioncirugias prog2
where salas.id = prog.sala_id  and salas."sedesClinica_id" = prog."sedesClinica_id" and prog2."sedesClinica_id" = prog."sedesClinica_id"
		and	salas."sedesClinica_id" = '1' and prog.sala_id = prog2.sala_id and prog2.id = (select min(prog3.id) from cirugia_programacioncirugias prog3
														where prog3.id > prog.id  and prog3.sala_id = prog.sala_id ) 
order by 3,5,7

detalle = 'SELECT prog.id, salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,	cast(prog."horaProgramacionInicia" as time), cast(prog."horaProgramacionFin" as time) , 'OCUPADO' estado FROM cirugia_programacioncirugias prog LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id and salas."sedesClinica_id" = prog."sedesClinica_id" ) WHERE salas."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' union SELECT prog.id, salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionFin", prog2."fechaProgramacionInicia" ,cast(prog."horaProgramacionFin" as time) + interval ' + "'" + str('1 minute') + "'" + ' , cast(prog2."horaProgramacionInicia" as time) - interval ' + "'" + str('1 minute') + "'" + ', ' + "'" + str('LIBRE') + "'" + ' estado FROM cirugia_programacioncirugias prog , sitios_salas salas, cirugia_programacioncirugias prog2 where salas.id = prog.sala_id  and salas."sedesClinica_id" = prog."sedesClinica_id" and prog2."sedesClinica_id" = prog."sedesClinica_id" and	salas."sedesClinica_id" =  ' + "'" + str(sede) + "'" + ' and  prog2.id = (select min(prog3.id) from cirugia_programacioncirugias prog3 where prog3.id > prog.id) UNION SELECT prog.id, salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionFin", prog2."fechaProgramacionInicia" ,cast(prog2."horaProgramacionFin" as time) + interval ' + "'" + str('1 minute') + "'" + ' , cast(salas."finServicio" as time)  , ' + "'" + str('LIBRE') + "'" + ' estado FROM cirugia_programacioncirugias prog , sitios_salas salas, cirugia_programacioncirugias prog2 where salas.id = prog.sala_id  and salas."sedesClinica_id" = prog."sedesClinica_id" and prog2."sedesClinica_id" = prog."sedesClinica_id" and	salas."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' and  prog2.id = (select min(prog3.id) from cirugia_programacioncirugias prog3 where prog3.id > prog.id ) order by 3,5,7'

SELECT em.id ,e.nombre 
		FROM clinico_Especialidades e, clinico_EspecialidadesMedicos em,planta_planta pl 
		where em."especialidades_id" = e.id and em."planta_id" = pl.id AND pl.documento = '19465673' AND
		em."sedesClinica_id" = '1'

		select * from clinico_EspecialidadesMedicos where planta_id='1'

		select * from cirugia_cirugiasparticipantes 
		select * from cirugia_cirugias;

select cirpart.id id, cirpart.cirugia_id cirugiaId, hon.nombre honNombre, med.nombre medicoNombre, esp.nombre especialidadNombre , exa.nombre cupsNombre 
FROM cirugia_cirugiasparticipantes cirpart, tarifarios_tiposhonorarios hon, clinico_especialidadesmedicos med, clinico_especialidades esp, 
	clinico_examenes exa 
WHERE cirpart.cirugia_id = '33' and cirpart."tipoHonorarios_id" = hon.id  and cirpart.medico_id = med.id and med.especialidades_id = esp.id and
	exa.id = cirpart.cups_id


      

		select * from cirugia_programacioncirugias
-- otro
SELECT count(*) id
FROM cirugia_programacioncirugias cir 
	where sala_id =  '1' AND date('2025-10-29') BETWEEN date('2025-10-29') AND date('2025-10-29') AND '12:00:00'::time BETWEEN  '12:00'::time and '14:00'::time


SELECT count(*) id
FROM cirugia_programacioncirugias cir 
	where sala_id =  '1' AND cir."fechaProgramacionInicia" BETWEEN date('2025-10-29') AND date('2025-10-29') AND cir."horaProgramacionInicia" BETWEEN  '12:00' and '14:00'


		select * from cirugia_programacioncirugias;

SELECT count(*) id
FROM cirugia_programacioncirugias cir 
where cir.id != 20    and  sala_id =  '1' AND cir."fechaProgramacionInicia" = date('2025-10-29') and (
cir."horaProgramacionInicia"  BETWEEN  '13:00' and '14:00' OR
cir."horaProgramacionFin"  BETWEEN  '13:00' and '14:00')
	


begin transaction;
UPDATE cirugia_Cirugias 
SET "ingresoQuirofano" =  '2025-10-29',"horaIngresoQuirofano" = '11:10:10',  "salidaQuirofano" =  '2025-10-29',"horaSalidaQuirofano" = '13:10:10',"fechaIniAnestesia" = '2025-10-29',"HoraIniAnestesia" = '11:11:00',"fechaQxInicial" = '2025-10-29',"horaQxInicial" = '11:20:10',"fechaQxFinal" = '2025-10-29',"horaQxFinal" = '12:10:10',"fechaFinAnestesia" = '2025-10-29',"horaFinAnestesia" = '12:05:10',"ingresoRecuperacion" = '2025-10-29',"horaIngresoRecuperacion" = '14:10:10',"salidaRecuperacion" = '2025-10-29',"horaSalidaRecuperacion" = '15:10:10',"dxPreQx_id" = '1',"dxPostQx_id" = '15',"impresionDx_id" = '13',
	"dxComplicacion_id" = null,"formaRealiza" = 'FF',"patologia" = 'S',"tipofractura" = '',"intensificador" = 'S',"descripcionQx" = 'Paciente n posicion supina ..',"hallazgos" = 'Normal',"analisis" = 'Bien la cirugu¿ia',"planx" = 'Le va a ir muy bien',"estadoCirugia_id" = '4'

Where id = '33'
select "ingresoQuirofano",* from cirugia_cirugias where id=33
-- commit;
-- rollbacK

	select documento_id,* from cirugia_cirugias;

select * from usuarios_usuarios;
select * from admisiones_ingresos where documento_id=37
	select * from contratacion_convenios where id in (7,20,1)

select convenio_id,* from facturacion_liquidacion where documento_id=24
select anulado,* from facturacion_liquidaciondetalle where liquidacion_id = 263 -- compe
select anulado,* from facturacion_liquidaciondetalle where liquidacion_id = 293 -- ecope
	select convenio_id,* from facturacion_liquidacion where id = 293 

	select * from facturacion_liquidacion where id in (263,293)

	select * from tarifarios_tablaSalasdecirugiaiss

SELECT "grupoQx_id" ,tarifa.smldv * 1400000/30 valor
	FROM cirugia_cirugias cir,  tarifarios_tablaSalasdecirugia tarifa 
	WHERE cir.id = '33' AND  "grupoQx_id" =  ' + "'" + str(grupoQx) + "'"

select * from facturacion_liquidacion	order by id desc
select anulado,* from facturacion_liquidaciondetalle where liquidacion_id=263 --288
	
select matqx.suministro_id suministro, sum.nombre nomSuministro , tipos.nombre tipo ,matqx."valorLiquidacion" valorLiquidacionMat 
from cirugia_cirugiasmaterialqx matqx, facturacion_suministros sum, facturacion_tipossuministro tipos
where matqx.cirugia_id= '28' and matqx.suministro_id = sum.id and sum."tipoSuministro_id" = tipos.id and 
	tipos.nombre = 'MATERIAL QX'
begin transaction;
INSERT INTO facturacion_liquidaciondetalle (consecutivo,fecha, cantidad, "valorUnitario", "valorTotal",cirugia_id,"fechaCrea", "fechaRegistro", "estadoRegistro", "examen_id",  "usuarioRegistro_id", liquidacion_id, "tipoRegistro",anulado) VALUES ('3','2025-10-29 21:37:34.076570+00:00','1','0','0.0',null,'2025-10-29 21:37:34.076570+00:00','2025-10-29 21:37:34.076570+00:00','A','4021','1', 263  ,'SISTEMA','N')
--rollback;	

	      detalle = 'SELECT tarifa.valor valor FROM cirugia_cirugias cir, sitios_tipossalas tipsal, tarifarios_tablaSalasdecirugiaiss tarifa, sitios_salas sala WHERE cir.id = ' + "'" + str(cirugiaId) + "'" + ' AND cir.sala_id = sala.id and sala."tipoSala_id" = tipsal.id and tarifa."tiposSala_id" = tipsal.id and ' + "'" + str(cantidadUvrProced) + "'" + ' between tarifa."desdeUvr" AND tarifa."hastaUvr"'

	
	SELECT tarifa.valor valor FROM cirugia_cirugias cir, sitios_tipossalas tipsal, tarifarios_tablaSalasdecirugiaiss tarifa, sitios_salas sala WHERE cir.id = '28' AND cir.sala_id = sala.id and sala."tipoSala_id" = tipsal.id and tarifa."tiposSala_id" = tipsal.id and '31' between tarifa."desdeUvr" AND tarifa."hastaUvr"
select  * from cirugia_cirugiasmaterialqx;	
	select * from facturacion_tipossuministro;
	select "tipoSuministro_id",* from facturacion_suministros where id in (31196,18926,17638)

select matqx.suministro_id suministro, sum.nombre nomSuministro , tipos.nombre tipo ,matqx."valorLiquidacion" valorLiquidacionMat 
from cirugia_cirugiasmaterialqx matqx
left  join facturacion_suministros sum ON (sum.id = matqx.suministro_id)
inner join facturacion_tipossuministro tipos on (tipos.id = sum."tipoSuministro_id"  )
where matqx.cirugia_id= '28' and tipos.nombre = 'MEDICAMENTOS'
	
select * from tarifarios_tarifariossuministros
select * from tarifarios_tarifariosprocedimientos

select * from facturacion_suministros
select * from clinico_examenes
	select * from contratacion_convenios;
	select * from facturacion_conveniospacienteingresos
select convenio_id,"tipoDoc_id" ,* from cirugia_cirugias;	
	update cirugia_cirugias set convenio_id=20 where id=28
SELECT c.id id, c.nombre nombre FROM  contratacion_convenios c ,facturacion_conveniospacienteingresos  p
	where c.id=p.convenio_id

	select * from cirugia_programacioncirugias
	select * from usuarios_usuarios;
 
	select * from tarifarios_tarifariosprocedimientos
	SELECT tarifa.valor valor FROM cirugia_cirugias cir, sitios_tipossalas tipsal, tarifarios_tablaSalasdecirugiaiss tarifa, sitios_salas sala WHERE cir.id = '28' AND cir.sala_id = sala.id and sala."tipoSala_id" = tipsal.id and tarifa."tiposSala_id" = tipsal.id and '31' between tarifa."desdeUvr" AND tarifa."hastaUvr"
	ORDER BY nombre

-- ojo mañana esteq euqry tuene problemas
-- no trae nada porcua ??
-- por ello hace todo el rollback;	

	select "tiposSala_id",* from tarifarios_tablaSalasdecirugiaiss;
	select * from sitios_tipossalas;
	select * from sitios_salas;
	select sala_id,* from cirugia_cirugias;
	

SELECT tarifa.valor valor 
FROM cirugia_cirugias cir, sitios_tipossalas tipsal, tarifarios_tablaSalasdecirugiaiss tarifa, sitios_salas sala
WHERE cir.id = '28' AND cir.sala_id = sala.id and sala."tipoSala_id" = tipsal.id and tarifa."tiposSala_id" = tipsal.id and '30' between tarifa."desdeUvr" AND tarifa."hastaUvr"

	select * from cirugia_cirugiasprocedimientos where cirugia_id=28;	
	
	and '31' between tarifa."desdeUvr" AND tarifa."hastaUvr"

select "grupoQx_id","cantidadUvr",* from clinico_examenes where id in (4021,2365,2708,3178)
select "tiposSala_id",* from tarifarios_tablaSalasdecirugiaiss;
	select * from sitios_tipossalas;
select sala_id, * from cirugia_cirugias where id='28'
select "tipoSala_id",* from sitios_salas where id='2'	
	
SELECT tarifa.valor valor 
FROM cirugia_cirugias cir, sitios_tipossalas tipsal, tarifarios_tablaSalasdecirugiaiss tarifa, sitios_salas sala 
WHERE cir.id = '28' AND cir.sala_id = sala.id and sala."tipoSala_id" = tipsal.id and tarifa."tiposSala_id" = tipsal.id and '31' 
	between tarifa."desdeUvr" AND tarifa."hastaUvr"

select * from contratacion_convenios;
SELECT * FROM USUARIOS_USUARIOS;
select anulado,convenio_id,* from facturacion_liquidacion where documento_id = '24' -- 251
select * from facturacion_liquidaciondetalle where liquidacion_id = 263

select sum("valorTotal") from facturacion_liquidaciondetalle where liquidacion_id = 263 and cums_id is not null and  anulado='N';
	-- 30500
select sum("valorTotal") from facturacion_liquidaciondetalle where liquidacion_id = 263 and examen_id is not null and  anulado='N';
-- 5073535
 
update facturacion_liquidacion set anulado='N' where id=263

select anulado,convenio_id,* from facturacion_facturacion where documento_id = '24'
select glosa_id,* from rips_ripsprocedimientos where id = 3433
select * from cartera_glosasdetalle where "ripsProcedimientos_id" = 3433
	select * from cartera_glosasdetalle where ID=19
--
update cartera_glosasdetalle set "ripsProcedimientos_id" = null where id=19 -- estaba 3433
update cartera_glosasdetalle set "ripsProcedimientos_id" = 3531 where id=19 
	
select * from cartera_glosas where factura_id=142
select * from cartera_glosasdetalle where glosa_id=39 -- vams a borrar la 19

		SELECT * FROM rips_ripstransaccion order by id desc

select * from rips_ripsprocedimientos where "ripsTransaccion_id" >= 938 and "numFEVPagoModerador" = '142'
	

select * from rips_ripstransaccion order by id desc
	
update facturacion_facturaciondetalle set  "tipoRegistro"= 'MANUAL' where id in (420,421)
update facturacion_facturaciondetalle set  "tipoRegistro"= 'SISTEMA' where id in (420,421)
SELECT * FROM rips_ripstransaccion where "numFactura" = '149'
 

 SELECT generaFacturaJSONBAK('68','149','FACTURA',0)

SELECT * FROM rips_ripstransaccion WHERE "ripsEnvio_id"= '68'
	SELECT * FROM rips_ripstransaccion order by id desc

select * from rips_ripsprocedimientos where "ripsTransaccion_id" >= 938 and "numFEVPagoModerador" = '142'
select * from rips_ripshospitalizacion where "ripsTransaccion_id" = 935
select * from rips_ripsmedicamentos where "ripsTransaccion_id" = 935
select * from rips_ripsusuarios where "ripsTransaccion_id" = 935

SELECT * FROM rips_ripstiposdocumento
	SELECT * FROM usuarios_tiposDocumento
	SELECT "tipoDoc_id",* FROM USUARIOS_USUARIOS WHERE ID=24;
	SELECT "tipoDoc_id",* FROM admisiones_ingresos WHERE documento_id=24;
	

SELECT '[{"codPrestador": ' ||'"'  ||   hosp."codPrestador"|| '",'  ||
	   '"viaIngresoServicioSalud": ' || '"'  ||hosp."viaIngresoServicioSalud_id"|| '",'  ||
	    '"fechaInicioAtencion": ' || '"'  ||substring(CAST( hosp."fechaInicioAtencion"  as text),1,16) || '",'  || 
		 '"numAutorizacion": ' || '"'  ||CASE WHEN trim(cast(hosp."numAutorizacion" as text)) is null THEN 'null' WHEN trim(cast(hosp."numAutorizacion" as text)) = '' THEN 'null' ELSE hosp."numAutorizacion"  END|| '",'   || 
	 '"causaMotivoAtencion": ' || '"'  ||cauext.codigo|| '",'   || 

	'"codDiagnosticoPrincipal": ' || '"'  ||dxppal.cie10|| '",'   || 
		  '"codDiagnosticoPrincipalE": ' || '"'  ||dxppale.cie10|| '",'    ||
   '"codDiagnosticoRelacionadoE1": ' || '"'  ||CASE WHEN trim(cast(dxrel1.cie10 as text)) is null THEN 'null' WHEN trim(cast(dxrel1.cie10 as text)) = '' THEN 'null' ELSE dxrel1.cie10  END|| '",'   || 	
   '"codDiagnosticoRelacionadoE2": ' || '"'  ||CASE WHEN trim(cast(dxrel2.cie10  as text)) is null THEN 'null' WHEN trim(cast(dxrel2.cie10 as text)) = '' THEN 'null' ELSE dxrel2.cie10  END|| '",'   || 	
   '"codDiagnosticoRelacionadoE3": ' || '"'  ||CASE WHEN trim(cast(dxrel3.cie10  as text)) is null THEN 'null' WHEN trim(cast(dxrel3.cie10 as text)) = '' THEN 'null' ELSE dxrel3.cie10  END|| '",'   || 	
	'"codComplicacion": ' || '"'  ||'null'|| '",'  ||

	'"condicionDestinoUsuarioEgreso": ' || '"'  ||cauext.codigo|| '",'   || 
		'"codDiagnosticoMuerte": ' || '"'  ||'null'|| '",'  ||

	'"fechaEgreso": ' || '"'  ||case when hosp."fechaEgreso" is null then 'null' else substring(cast(hosp."fechaEgreso" as text),1,16) end|| '",'   || 

	'"consecutivo": ' || hosp.consecutivo|| '}]'
from rips_ripstransaccion
	left join rips_ripshospitalizacion hosp on (hosp."ripsTransaccion_id" = rips_ripstransaccion.id)
	left join rips_ripscausaexterna cauext on (cauext.id =hosp."causaMotivoAtencion_id" )
	left join clinico_diagnosticos dxppal on (dxppal.id =hosp."codDiagnosticoPrincipal_id")
	left join clinico_diagnosticos dxppale on (dxppale.id =hosp."codDiagnosticoPrincipalE_id")
	left join clinico_diagnosticos dxrel1 on (dxrel1.id = hosp."codDiagnosticoRelacionadoE1_id")
	left join clinico_diagnosticos dxrel2 on (dxrel2.id =  hosp."codDiagnosticoRelacionadoE2_id")
	left join clinico_diagnosticos dxrel3 on (dxrel3.id =  hosp."codDiagnosticoRelacionadoE3_id")
	left join rips_ripsDestinoEgreso egreso on (egreso.id = hosp."condicionDestinoUsuarioEgreso_id" )
where  rips_ripstransaccion."ripsEnvio_id" = 68 and   rips_ripstransaccion."numFactura" =cast('149' as text) ;

select * from admisiones_ingresos where documento_id='24'

SELECT sum("valorAceptado")  vAceptado, sum("valorSoportado") valorSoportado, sum("valorGlosa") valorGlosado , sum("valorGlosa") totalGlosa , sum("valorNotasCredito") totalNotasCredito  
	FROM cartera_glosasdetalle 
	WHERE glosa_id = 39

select * from cirugia_cirugiasmaterialqx
SELECT * FROM facturacion_tipossuministro;
select * from facturacion_suministros where nombre like ('%VENDA%')
	select * from facturacion_suministros where nombre like ('%EQUIPO%')
	select * from facturacion_suministros where nombre like ('%JERINGA%')
	select * from facturacion_suministros where nombre like ('%SONDA%')
	select "tipoSuministro_id",* from facturacion_suministros where nombre like ('%GASAS%')
select * from facturacion_suministros where "tipoSuministro_id"=2

select documento_id,convenio_id,* from cirugia_cirugias;
select * from facturacion_conveniospacienteingresos where documento_id=24;
update cirugia_cirugias set convenio_id=1 where id=28
select * from facturacion_tipossuministro
	select * from cirugia_cirugiasmaterialqx;

select matqx.suministro_id suministro, sum.nombre nomSuministro , tipos.nombre tipo ,matqx."valorLiquidacion" valorLiquidacionMat 
	from cirugia_cirugiasmaterialqx matqx, facturacion_suministros sum, facturacion_tipossuministro tipos 
	where matqx.cirugia_id= '28' and matqx.suministro_id = sum.id and sum."tipoSuministro_id" = tipos.id 

	select * from tarifarios_tiposhonorarios;
select * from cirugia_programacioncirugias;	
select * from cirugia_cirugiasparticipantes
	update cirugia_cirugiasparticipantes set "cirugiaProcedimiento_id" = 33 where id=39
	update cirugia_cirugiasparticipantes set "cirugiaProcedimiento_id" = 34 where id=40
	select * from clinico_examenes
	select * from cirugia_cirugiasprocedimientos -- 4021 ,2365 // 33,34

	select * from cirugia_cirugiasprocedimientos where cirugia_id='28'
	select * from cirugia_cirugiasparticipantes where cirugia_id='28'



select cirpart.id id, cirpart.cirugia_id cirugiaId, hon.nombre honNombre, med.nombre medicoNombre, esp.nombre especialidadNombre ,
	exa.nombre cupsNombre 
	FROM cirugia_cirugiasparticipantes cirpart 
	inner join tarifarios_tiposhonorarios hon ON (hon.id = cirpart."tipoHonorarios_id") 
	inner join clinico_especialidadesmedicos med ON ( med.id = cirpart.medico_id ) 
	inner join clinico_especialidades esp ON (esp.id =med.especialidades_id  ) 
	inner join cirugia_cirugiasprocedimientos cirProc ON ( cirProc.id = cirpart."cirugiaProcedimiento_id")  
	left join clinico_examenes exa ON (exa.id = cirProc.cups_id)
	WHERE cirpart.cirugia_id = '28'

	
	SELECT cirProc.id id,exa.nombre nombre FROM  cirugia_cirugiasprocedimientos cirProc LEFT JOIN cirugia_cirugiasparticipantes cirPart ON (cirPart.cirugia_id = cirProc.cirugia_id AND cirPart."cirugiaProcedimiento_id" = cirProc.id) LEFT JOIN clinico_examenes exa on (exa.id= cirProc.cups_id) where cirProc.cirugia_id = '36'

	select * from cirugia_cirugiasprocedimientos where cirugia_id=36
		select * from cirugia_cirugiasparticipantes where cirugia_id=36

	select * from clinico_especialidadesmedicos where id in (15,3,7)
	select * from clinico_especialidades where id in (2,3,7)

	SELECT cirProc.id id,exa.nombre nombre FROM  cirugia_cirugiasprocedimientos cirProc 
	LEFT JOIN cirugia_cirugiasmaterialqx cirMat ON (cirMat.cirugia_id = cirProc.cirugia_id AND cirMaT."cirugiaProcedimiento_id" = cirProc.id)
	LEFT JOIN clinico_examenes exa on (exa.id= cirProc.cups_id) where cirProc.cirugia_id = '28'
	
select * from cirugia_cirugiasmaterialqx where cirugia_id=28
update cirugia_cirugiasmaterialqx set "cirugiaProcedimiento_id" = 33 where cirugia_id=28

select cirmaterial.id id, cirmaterial.cirugia_id cirugia_id, cirmaterial.suministro_id suministro_id, suministros.nombre suministro , 
	tipo.nombre tipoSuministro , cirmaterial.unitario unitario, cirmaterial.cantidad cantidad ,
	cirmaterial."valorLiquidacion" valorLiquidacion ,exa.nombre cupsNombre 
	FROM cirugia_cirugiasMaterialQx cirmaterial
	INNER JOIN cirugia_cirugiasprocedimientos cirProc ON ( cirProc.id = cirmaterial."cirugiaProcedimiento_id") 
	INNER JOIN facturacion_suministros suministros ON ( suministros.id = cirmaterial.suministro_id) 
	INNER JOIN facturacion_tipossuministro tipo ON (tipo.id = suministros."tipoSuministro_id") 
	INNER JOIN clinico_examenes exa ON ( exa.id = cirProc.cups_id) 
	WHERE cirmaterial.cirugia_id = '28'


SELECT * FROM FACTURACION_TIPOSSUMINISTRO

	select * from facturacion_suministros  where "tipoSuministro_id" = 10;
	select * from cirugia_cirugiasprocedimientos where cirugia_id=28

SELECT * FROM cirugia_cirugiasMaterialQx;
SELECT * FROM FACTURACION_FACTURACIONDETALLE;

select sum(matqx."valorLiquidacion") valorLiquidacionMat 
from cirugia_cirugiasmaterialqx matqx, facturacion_suministros sum, facturacion_tipossuministro tipos , cirugia_cirugiasprocedimientos cirProc
where matqx.cirugia_id= '28' and matqx.suministro_id = sum.id and sum."tipoSuministro_id" = tipos.id  AND tipos.id = 10 
	and cirProc.id = matqx."cirugiaProcedimiento_id" and cirProc.cups_id=4021

	select cums_id, examen_id,"tipoHonorario_id",* from facturacion_liquidaciondetalle where liquidacion_id=293 
delete from facturacion_liquidaciondetalle where liquidacion_id=293  and cirugia_id is null
	
