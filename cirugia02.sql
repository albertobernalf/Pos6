select * from facturacion_FACTURACIONdetalle order by id desc



select * from facturacion_conceptos;  -- 3 / 6 = Medicamentos
select concepto_id,* from clinico_examenes where id in (3178,2708,2365,4021)
SELECT * FROM FACTURACION_TIPOSSUMINISTRO
	select "tipoSuministro_id",concepto_id,* from facturacion_suministros  order by "tipoSuministro_id" desc
update 	facturacion_suministros set concepto_id=11 where concepto_id=6
update 	facturacion_suministros set concepto_id=6
		where id not in (18613,18578,17642,18478,18378,18258,17779,17638,17637,17634,17883,18306,17639,18377,34652,34653,34654,34655,34656,34657	)
	
update clinico_examenes
	set concepto_id=3
	where id in (3178,2708,2365,4021)

SELECT distinct con.id, con.nombre nombreConcepto 
from facturacion_conceptos con 
INNER JOIN clinico_examenes exa ON (exa.concepto_id = con.id) 
where exa.id in (select facdet.examen_id from facturacion_facturaciondetalle facdet
	where facdet.facturacion_id = '149')
union
SELECT distinct con.id, con.nombre nombreConcepto 
from facturacion_conceptos con 
INNER JOIN facturacion_suministros sum ON (sum.concepto_id = con.id) 
where sum.id in (select facdet.cums_id from facturacion_facturaciondetalle facdet 
where facdet.facturacion_id = '149')
order by 1 desc 
	--2,1,3,5

select concepto_id,* from clinico_examenes where concepto_id=14;

select cums_id, examen_id,cirugia_id,"tipoHonorario_id",* from facturacion_facturaciondetalle where facturacion_id='149'

select detFac."tipoHonorario_id", exa."codigoCups" cups,tarProc."codigoHomologado" homologado, exa.nombre  descripcion, detFac.cantidad cantidad,
	detFac."valorUnitario" valorUnitario, detFac."valorTotal" valorTotal 
	FROM facturacion_facturaciondetalle detFac
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	LEFT JOIN tarifarios_tarifariosdescripcion tarDesc ON (tarDesc.id=conv."tarifariosDescripcionProc_id")
	LEFT JOIN tarifarios_tarifariosprocedimientos tarProc ON (tarProc."tiposTarifa_id"=tarDesc."tiposTarifa_id" AND tarProc."codigoCups_id" = detFac.examen_id )
where detfac.facturacion_id= '149' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'

select * from tarifarios_tarifariosprocedimientos where "codigoCups_id" = 4021
select "cantidadUvr",* from clinico_examenes where "codigoCups" = '471100'

select exa."codigoCups" cups,tarProc."codigoHomologado" homologado, exa.nombre  descripcion, 1 cantidad,
	sum(detFac."valorUnitario") valorUnitario, sum(detFac."valorTotal") valorTotal 
	FROM facturacion_facturaciondetalle detFac
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	LEFT JOIN tarifarios_tarifariosdescripcion tarDesc ON (tarDesc.id=conv."tarifariosDescripcionProc_id")
	LEFT JOIN tarifarios_tarifariosprocedimientos tarProc ON (tarProc."tiposTarifa_id"=tarDesc."tiposTarifa_id" AND tarProc."codigoCups_id" = detFac.examen_id )
where detfac.facturacion_id= '149' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'
group by exa."codigoCups", tarProc."codigoHomologado",exa.nombre

select convenio_id,* from facturacion_facturacion where id=149
select * from facturacion_conveniospacienteingresos where documento_id='24'
select * from contratacion_convenios order by id -- 3 , el de proced 77 1 = el de honorarios
select * from tarifarios_tarifariosprocedimientos
select * from tarifarios_tarifariosdescripcion
select * from tarifarios_tarifariosdescripcionhonorarios;
select * from tarifarios_tablahonorariosiss;
SELECT * FROM tarifarios_tablasalasdecirugiaiss
select * from tarifarios_tiposhonorarios;
select * from facturacion_conceptos;
SELECT * FROM tarifarios_tarifariosprocedimientos; -- 471100
SELECT * FROM CLINICO_EXAMENES WHERE "codigoCups" = '471100' --4021
SELECT * FROM tarifarios_tarifariosprocedimientos where "codigoCups_id" = 4021
select * from facturacion_facturaciondetalle where facturacion_id=149
	select * from tarifarios_tablamaterialsuturacuracioniss;
select * from tarifarios_tipostarifaproducto
	select "cantidadUvr",* from clinico_examenes where "codigoCups" = '471100'
select * from sitios_tipossalas;	
select sala_id,* from cirugia_cirugias;

-- query para calcular los valores de los mateiales segun ISS
-- registroCirugia
detalle = 'select matIss.homologado, matIss.valor FROM clinico_examenes exa INNER JOIN tarifarios_tablamaterialsuturacuracioniss matIss on (matIss."desdeUvr" <= exa."cantidadUvr" AND matIss."hastaUvr" >= exa."cantidadUvr") INNER JOIN 	sitios_tipossalas tipsal ON (tipsal.id =matIss."tiposSala_id" and tipsal.id = ' + "'" + str(registroCirugia.sala_id) + "'" +' ) WHERE exa.id = ' + "'" + str(procedimiento)  + "'"
-- y EL QUERY DE LA SUMATORIA TOTAL SERIA:

select exa."codigoCups" cups,tarProc."codigoHomologado" homologado, exa.nombre  descripcion, 1 cantidad,
	sum(detFac."valorUnitario") valorUnitario, sum(detFac."valorTotal") valorTotal 
	FROM facturacion_facturaciondetalle detFac
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	LEFT JOIN tarifarios_tarifariosdescripcion tarDesc ON (tarDesc.id=conv."tarifariosDescripcionProc_id")
	LEFT JOIN tarifarios_tarifariosprocedimientos tarProc ON (tarProc."tiposTarifa_id"=tarDesc."tiposTarifa_id" AND tarProc."codigoCups_id" = detFac.examen_id )
where detfac.facturacion_id= '149' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'
group by exa."codigoCups", tarProc."codigoHomologado",exa.nombre
ORDER BY 2,1

comando = 'select exa."codigoCups" cups,tarProc."codigoHomologado" homologado, exa.nombre  descripcion, 1 cantidad,sum(detFac."valorUnitario") valorUnitario, sum(detFac."valorTotal") valorTotal FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) LEFT JOIN tarifarios_tarifariosdescripcion tarDesc ON (tarDesc.id=conv."tarifariosDescripcionProc_id") LEFT JOIN tarifarios_tarifariosprocedimientos tarProc ON (tarProc."tiposTarifa_id"=tarDesc."tiposTarifa_id" AND tarProc."codigoCups_id" = detFac.examen_id ) where detfac.facturacion_id= '149' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3' group by exa."codigoCups", tarProc."codigoHomologado",exa.nombre ORDER BY 2,1'
 
-- HONORARIOS 
	-- tocaria de a (2:4) o subselect, homologado y valor

	select * from tarifarios_tiposhonorarios;

select tipHono.id,
(select 'Cod:'||' '||tarIss."homologado" ||' $ '||sum(detFac."valorTotal") 	
	FROM facturacion_facturaciondetalle detFac
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	INNER JOIN tarifarios_tablahonorariosiss tarIss ON (tarIss."tiposHonorarios_id" = detFac."tipoHonorario_id" )
where detfac.facturacion_id= '149' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'
	and detFac.examen_id= '4021' and tarIss."tiposHonorarios_id" = 1
group by tarIss."homologado",exa.nombre) CIRUJANO,
(select 'Cod:'||' '||tarIss."homologado" ||' $ '||sum(detFac."valorTotal") 	
	FROM facturacion_facturaciondetalle detFac
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	INNER JOIN tarifarios_tablahonorariosiss tarIss ON (tarIss."tiposHonorarios_id" = detFac."tipoHonorario_id" )
where detfac.facturacion_id= '149' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'
	and detFac.examen_id= '4021' and tarIss."tiposHonorarios_id" = 2
group by tarIss."homologado",exa.nombre) ANESTESIOLOGO,
(select 'Cod:'||' '||tarIss."homologado" ||' $ '||sum(detFac."valorTotal") 	
	FROM facturacion_facturaciondetalle detFac
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	INNER JOIN tarifarios_tablahonorariosiss tarIss ON (tarIss."tiposHonorarios_id" = detFac."tipoHonorario_id" )
where detfac.facturacion_id= '149' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'
	and detFac.examen_id= '4021' and tarIss."tiposHonorarios_id" = 3
group by tarIss."homologado",exa.nombre) AYUDANTE,
	(select 'Cod:'||' '||tarIss."homologado" ||' $ '||sum(detFac."valorTotal") 	
	FROM facturacion_facturaciondetalle detFac
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	INNER JOIN tarifarios_tablahonorariosiss tarIss ON (tarIss."tiposHonorarios_id" = detFac."tipoHonorario_id" )
where detfac.facturacion_id= '149' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'
	and detFac.examen_id= '4021' and tarIss."tiposHonorarios_id" = 5
group by tarIss."homologado",exa.nombre) SALAS
FROM tarifarios_tiposhonorarios tipHono
WHERE tipHono.nombre in ('CIRUJANO')
ORDER BY tipHono.id

tipoCirujano = TiposHonorarios.objects.get(nombre='CIRUJANO')
tipoAnestesiologo = TiposHonorarios.objects.get(nombre='ANESTESIOLOGO')
tipoAyudante =  TiposHonorarios.objects.get(nombre='AYUDANTE')
tipoDerechosSala	=  TiposHonorarios.objects.get(nombre='DERECHOS DE SALA')
	
	
comando =
'select tipHono.id,(select ' + "'" + str('Cod:') + "'" + '||' + "' '||" + ' tarIss."homologado" ||' + "' $ '||" + 'sum(detFac."valorTotal") 	
	FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	 INNER JOIN tarifarios_tablahonorariosiss tarIss ON (tarIss."tiposHonorarios_id" = detFac."tipoHonorario_id" ) where detfac.facturacion_id= ' + "'" + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') +"'" + '  AND exa.concepto_id = ' + "'" + str(concepto) + "'" +
' and detFac.examen_id= ' + "'" + str(procedimiento) + "'" + ' and tarIss."tiposHonorarios_id" = tipoCirujano.id
group by tarIss."homologado",exa.nombre) CIRUJANO, (select ' + "'" + str('Cod:' + "'||' '||" + 'tarIss."homologado" ||' + "'" + " $ '||" + ' sum(detFac."valorTotal") 	
	FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	INNER JOIN tarifarios_tablahonorariosiss tarIss ON (tarIss."tiposHonorarios_id" = detFac."tipoHonorario_id" )
where detfac.facturacion_id= ' + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" +' or detfac.anulado=' + "'" + str('R') + "'" + ' AND exa.concepto_id = ' + "'" + str(concepto) + "'" +
	' and detFac.examen_id= ' + "'" + str(procedimiento) + "'" + ' and tarIss."tiposHonorarios_id" = tipoAnestesiologo.id group by tarIss."homologado",exa.nombre) ANESTESIOLOGO,
(select ' + "'" + str('Cod:' + "'" + "||' '||" + 'tarIss."homologado" ||' + "' $ '||" + 'sum(detFac."valorTotal") 	
	FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id)  INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablahonorariosiss tarIss ON (tarIss."tiposHonorarios_id" = detFac."tipoHonorario_id" )
where detfac.facturacion_id= ' + "'" + str(factura) + "'"  + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') + "'" + ' AND exa.concepto_id = ' + "'" + str(concepto) + "'" +
	' and detFac.examen_id= ' + "'" + str(procedimiento) + "'" + ' and tarIss."tiposHonorarios_id" = tipoAyudante.id
group by tarIss."homologado",exa.nombre) AYUDANTE,	(select ' + "'" + str('Cod:' + "'" + "||' '||" + ' tarIss."homologado" ||' $ '||sum(detFac."valorTotal") 	
	FROM facturacion_facturaciondetalle detFac
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	INNER JOIN tarifarios_tablahonorariosiss tarIss ON (tarIss."tiposHonorarios_id" = detFac."tipoHonorario_id" )
where detfac.facturacion_id= '149' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'
	and detFac.examen_id= '4021' and tarIss."tiposHonorarios_id" = tipoDerechosSala.id
group by tarIss."homologado",exa.nombre) SALAS
FROM tarifarios_tiposhonorarios tipHono
WHERE tipHono.nombre in ('CIRUJANO')
ORDER BY tipHono.id
	
	'
	


