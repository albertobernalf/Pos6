select * from rips_ripstransaccion order by id desc
	select * from rips_ripsmedicamentos where "ripsTransaccion_id" in ( 809,810)
	select * from rips_ripsprocedimientos where "ripsTransaccion_id" in ( 809,810)
select * from rips_ripsprocedimientos
 
select "ripsTransaccion_id","notasCreditoGlosa",glosa_id,* from rips_ripsprocedimientos order by "ripsTransaccion_id" desc
select "ripsTransaccion_id","notasCreditoGlosa",glosa_id,* from rips_ripsmedicamentos order by "ripsTransaccion_id" desc
select * from cartera_glosas  order by id desc
	

	select * from rips_ripstransaccion order by id desc
SELECT "codMunicipioResidencia_id",* FROM rips_ripsusuarios where "ripsTransaccion_id" =763
select * from rips_ripsmunicipios
	select municipio_id,* from usuarios_usuarios where id=18
	select * from sitios_municipios
	update sitios_municipios set "ripsMunicipios_id" = 1 where id in (2,4)
select * from rips_ripsmedicamentos where "ripsTransaccion_id" = 763
	
	select * from rips_ripsZonaTerritorial
	select "codZonaTerritorialResidencia",* from rips_ripsusuarios;
select * from sitios_municipios
update rips_ripsusuarios set "codZonaTerritorialResidencia"=1 where "codZonaTerritorialResidencia" !='2' or "codZonaTerritorialResidencia" is null

	select * from rips_ripsusuarios;

select * from rips_ripstransaccion order by id desc
select * from rips_ripstransaccion where "numFactura" = '136' order by id desc

select * from rips_ripsusuarios where "ripsTransaccion_id" = 772
select * from rips_ripsprocedimientos where "ripsTransaccion_id" = 772
select * from rips_ripsmedicamentos where "ripsTransaccion_id" = 772

select "ripsRecienNacido",documento_id,* from admisiones_ingresos order by "ripsRecienNacido" desc ;
select * from usuarios_usuarios where id=57
select * from facturacion_facturacion where documento_id=57 -- factura 148
select * from facturacion_conveniospacienteingresos where documento_id=57 -- convenio 7
select * from contratacion_convenios where id=7
	

select *  from rips_ripsreciennacido where "ripsTransaccion_id" = 775
select * from rips_ripsDestinoEgreso

SELECT sed."codigoHabilitacion",  usu.documento,  usu."fechaNacio", i."ripsEdadGestacional", i."ripsNumConsultasCPrenatal" ,       usu.genero, i."ripsPesoRecienNacido" ,cast(i."fechaSalida" as date), row_number() OVER(ORDER BY i.id) AS consecutivo ,now(), (select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxSalida_id"), (select max(diag1.id) from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 , clinico_historia his where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '1' and histdiag1.diagnosticos_id = diag1.id and his."tipoDoc_id" = fac."tipoDoc_id" and his.documento_id = fac.documento_id AND his."consecAdmision" = fac."consecAdmision") , dest.id, tipoDoc."tipoDocRips_id", '1' ,det.id,'7' , ripstra.id, 'A','50360'       FROM sitios_sedesclinica sed inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id) inner join admisiones_ingresos i ON (i."sedesClinica_id" = sed.id and i."tipoDoc_id" =fac."tipoDoc_id" and i.documento_id = fac.documento_id AND i.consec =fac."consecAdmision")  inner join rips_ripsenvios env ON (env."sedesClinica_id" = sed.id) inner join rips_ripsdetalle det ON ( det."ripsEnvios_id" = env.id and  det."ripsEnvios_id" = fac."ripsEnvio_id" and det."numeroFactura_id" = fac.id )  inner join rips_ripstransaccion ripstra ON ( ripstra."sedesClinica_id" = sed.id and ripstra."ripsEnvio_id" = env.id and ripstra."numFactura" = cast(fac.id as text))  left join rips_ripsdestinoegreso dest  on (dest.id = i."ripsCondicionDestinoUsuarioEgreso_id") inner join usuarios_usuarios usu on (usu."tipoDoc_id" = i."tipoDoc_id" AND usu.id = i.documento_id) inner join usuarios_tiposdocumento tipoDoc on (tipoDoc.id = i."tipoDoc_id") where sed.id = '1' AND env.id = '68' and fac.id = '148' and i."ripsRecienNacido" = 'S'
SELECT generaFacturaJSONBAK('68','148','FACTURA',0) dato


select generaFacturaJSONBAK('70','28','GLOSA',806) valorJson
	select * from cartera_glosas;
select * from rips_ripsdetalle where glosa_id=27
select * from rips_ripstransaccion where 	"numNota" = '27' and "numFactura" = '136'

 select substring(sed.nit,1,9) ,  glo.id, now(), tipnot.id, '1', e.id, sed.id , glo.factura_id , 'A' 
from sitios_sedesclinica sed, cartera_glosas glo, rips_ripsEnvios e  , rips_ripsdetalle det ,rips_ripstiposnotas tipnot 
	where e.id = '70' and e."sedesClinica_id" = sed.id and glo."ripsEnvio_id" = e.id and det."ripsEnvios_id" = e.id and
	e."ripsTiposNotas_id" = tipnot.id and tipnot.nombre='Glosa' AND glo.id = '28' and glo.id = det.glosa_id


select generaFacturaJSONBAK('70','28','GLOSA',812) valorJson

	select "ripsTransaccion_id", * from rips_ripsprocedimientos order by "ripsTransaccion_id";
select generaFacturaJSONBAK('70','27','GLOSA',811) valorJson

select * from cartera_glosas;
select * from cartera_glosasdetalle;
select glosa_id,* from rips_ripsprocedimientos order by glosa_id asc;
select * from rips_ripstransaccion order by id desc

select 'MEDICAMENTOS' tipo,med.id, med.consecutivo consec, med."itemFactura",med."nomTecnologiaSalud" codigo,cums.nombre nombre,
	med."vrServicio",mot.nombre glosaNombre, med."cantidadGlosada",med."cantidadAceptada",med."cantidadSoportado", med."valorGlosado",
	med."vAceptado", med."valorSoportado",med."notasCreditoGlosa"
	FROM rips_ripstransaccion ripstra 
	inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id) 
	inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) 
	inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) 
	left join cartera_motivosglosas mot on (mot.id = med."motivoGlosa_id")   
	where  cast(ripstra."numFactura" as float) = '136' and ripstra."numNota"= '0'
	UNION
	select 'PROCEDIMIENTOS' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", cast(proc."codProcedimiento_id" as text) codigo,
	exa.nombre nombre, proc."vrServicio", mot.nombre glosaNombre, proc."cantidadGlosada", proc."cantidadAceptada", proc."cantidadSoportado",
	proc."valorGlosado", proc."vAceptado", proc."valorSoportado", proc."notasCreditoGlosa" 
	FROM  rips_ripstransaccion ripstra
	inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) 
	inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) 
	inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = proc."itemFactura") 
	left join cartera_motivosglosas mot on (mot.id = proc."motivoGlosa_id") 
	where cast(ripstra."numFactura" as float) = '136' and ripstra."numNota"= '0'
	UNION
	select 'CONSULTAS' tipo, cons.id, cons.consecutivo consec, cons."itemFactura", cast(cons."codConsulta_id" as text) codigo, exa.nombre nombre,
	cons."vrServicio", mot.nombre glosaNombre, cons."cantidadGlosada", cons."cantidadAceptada", cons."cantidadSoportado", cons."valorGlosado",
	cons."vAceptado", cons."valorSoportado", cons."notasCreditoGlosa" 
	FROM rips_ripstransaccion  ripstra, rips_ripsconsultas cons, clinico_examenes exa, facturacion_facturaciondetalle det, cartera_motivosglosas mot 
	where cast(ripstra."numFactura" as float) = '136' and cons."ripsTransaccion_id" = ripstra.id and 
	cast(ripstra."numFactura" as float) = det.facturacion_id and cons. "codConsulta_id" = exa.id and cons."itemFactura" = det."consecutivoFactura" 
	and mot.id = cons."motivoGlosa_id"
UNION 
select 'OTROS SERVICIOS' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, cums.nombre nombre,
	serv."vrServicio", mot.nombre glosaNombre, serv."cantidadGlosada", serv."cantidadAceptada", serv."cantidadSoportado", 
	serv."valorGlosado", serv."vAceptado", serv."valorSoportado", serv."notasCreditoGlosa" 
	FROM rips_ripstransaccion ripstra, rips_ripsotrosservicios serv, rips_ripscums cums, facturacion_facturaciondetalle  det,
	cartera_motivosglosas  mot 
	where cast(ripstra."numFactura" as float) = '136' and serv."ripsTransaccion_id" = ripstra.id and 
	cast(ripstra."numFactura" as float) = det.facturacion_id and serv."codTecnologiaSalud_id" = cums.id and
	serv."itemFactura" = det."consecutivoFactura" and mot.id = serv."motivoGlosa_id"  
	order by 1,4



-- Como debe quedar
select * from cartera_glosasdetalle
select * from rips_ripscums

select 'MEDICAMENTOS' tipo,med.id, med.consecutivo consec, med."itemFactura",cums.cum codigo,cums.nombre nombre,
	mot.nombre glosaNombre,med."vrServicio",  med."valorGlosado",	med."vAceptado", med."valorSoportado",med."notasCreditoGlosa",
	detGlo."valorGlosa",    detGlo."valorSoportado",   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"
	FROM rips_ripstransaccion ripstra 
	inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id) 
	inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) 
	inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) 
	left join cartera_motivosglosas mot on (mot.id = med."motivoGlosa_id")   
	left join cartera_glosasdetalle detGlo on (detGlo."ripsMedicamentos_id" = med.id)
	where  cast(ripstra."numFactura" as float) = '136' and ripstra."numNota"= '0'
	UNION
	select 'PROCEDIMIENTOS' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", exa."codigoCups" codigo,
	exa.nombre nombre,  mot.nombre glosaNombre,proc."vrServicio",proc."valorGlosado", proc."vAceptado", proc."valorSoportado", proc."notasCreditoGlosa" ,
	detGlo."valorGlosa",    detGlo."valorSoportado",   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"
	FROM  rips_ripstransaccion ripstra
	inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) 
	inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) 
	inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = proc."itemFactura") 
	left join cartera_motivosglosas mot on (mot.id = proc."motivoGlosa_id") 
	left join cartera_glosasdetalle detGlo on (detGlo."ripsMedicamentos_id" = proc.id)
	where cast(ripstra."numFactura" as float) = '136' and ripstra."numNota"= '0'
	UNION
	select 'CONSULTAS' tipo, cons.id, cons.consecutivo consec, cons."itemFactura", exa."codigoCups" codigo,
	exa.nombre nombre, mot.nombre glosaNombre,cons."vrServicio",cons."valorGlosado", cons."vAceptado", cons."valorSoportado", cons."notasCreditoGlosa" ,
	detGlo."valorGlosa",    detGlo."valorSoportado",   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"	
	FROM rips_ripstransaccion  ripstra
	inner join  rips_ripsconsultas cons on (cons."ripsTransaccion_id" = ripstra.id) 
	inner join clinico_examenes exa on ( exa.id =cons."codConsulta_id" ) 
	inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = cons."itemFactura") 
	left join cartera_motivosglosas mot on (mot.id = cons."motivoGlosa_id") 
	left join cartera_glosasdetalle detGlo on (detGlo."ripsConsultas_id" = cons.id)	
	where cast(ripstra."numFactura" as float) = '136' and ripstra."numNota"= '0'
UNION	
select 'OTROS SERVICIOS' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, exa.nombre nombre,
	 mot.nombre glosaNombre, serv."vrServicio", serv."valorGlosado", serv."vAceptado", serv."valorSoportado", serv."notasCreditoGlosa" ,
	detGlo."valorGlosa",    detGlo."valorSoportado",   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"		
	FROM rips_ripstransaccion  ripstra
	inner join  rips_ripsotrosservicios serv on (serv."ripsTransaccion_id" = ripstra.id) 
	inner join clinico_examenes exa on ( exa.id =serv."codTecnologiaSalud_id" ) 
	inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = serv."itemFactura") 
	left join cartera_motivosglosas mot on (mot.id = serv."motivoGlosa_id") 
	left join cartera_glosasdetalle detGlo on (detGlo."ripsOtrosServicios_id" = serv.id)	
	where cast(ripstra."numFactura" as float) = '136' and ripstra."numNota"= '0'
	order by 1,4


detalle = 'select ' + "'" + str('MEDICAMENTOS') + "'" + ' tipo,med.id, med.consecutivo consec, med."itemFactura",cums.cum codigo,cums.nombre nombre,mot.nombre glosaNombre,med."vrServicio",  med."valorGlosado",	med."vAceptado", med."valorSoportado",med."notasCreditoGlosa",	detGlo."valorGlosa",    detGlo."valorSoportado",   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"	FROM rips_ripstransaccion ripstra 	inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id) 	inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) left join cartera_motivosglosas mot on (mot.id = med."motivoGlosa_id")  left join cartera_glosasdetalle detGlo on (detGlo."ripsMedicamentos_id" = med.id)	where  cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select '  + "'" + str('PROCEDIMIENTOS') + "'" + ' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", exa."codigoCups" codigo,	exa.nombre nombre,  mot.nombre glosaNombre,proc."vrServicio",proc."valorGlosado", proc."vAceptado", proc."valorSoportado", proc."notasCreditoGlosa" ,detGlo."valorGlosa",    detGlo."valorSoportado",   detGlo."valorAceptado" ,    detGlo."valorNotasCredito" FROM  rips_ripstransaccion ripstra inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = proc."itemFactura") left join cartera_motivosglosas mot on (mot.id = proc."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo."ripsMedicamentos_id" = proc.id) where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'" + str('CONSULTAS') + "'" + ' tipo, cons.id, cons.consecutivo consec, cons."itemFactura", exa."codigoCups" codigo,	exa.nombre nombre, mot.nombre glosaNombre,cons."vrServicio",cons."valorGlosado", cons."vAceptado", cons."valorSoportado", cons."notasCreditoGlosa" ,	detGlo."valorGlosa",    detGlo."valorSoportado",   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"	FROM rips_ripstransaccion  ripstra inner join  rips_ripsconsultas cons on (cons."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =cons."codConsulta_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = cons."itemFactura") left join cartera_motivosglosas mot on (mot.id = cons."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo."ripsConsultas_id" = cons.id)	 where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" +  ' UNION	select ' + "'" + str('OTROS SERVICIOS') + "'" + ' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, exa.nombre nombre, mot.nombre glosaNombre, serv."vrServicio", serv."valorGlosado", serv."vAceptado", serv."valorSoportado", serv."notasCreditoGlosa" ,	detGlo."valorGlosa",    detGlo."valorSoportado",   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"	FROM rips_ripstransaccion  ripstra inner join  rips_ripsotrosservicios serv on (serv."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =serv."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = serv."itemFactura") left join cartera_motivosglosas mot on (mot.id = serv."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo."ripsOtrosServicios_id" = serv.id)	where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' order by 1,4'

--
--
	select * from rips_ripsmedicamentos where id = 540
	select * from cartera_glosasdetalle
		select * from cartera_motivosglosas

SELECT 'MEDICAMENTOS' tipo, med.id,"itemFactura", "nomTecnologiaSalud" codigo, cums.nombre nombre, "vrServicio",	consecutivo,  
	"cantidadGlosada", "cantidadAceptada", "cantidadSoportado", "valorGlosado","vAceptado","valorSoportado","motivoGlosa_id",
	"notasCreditoGlosa" 
	FROM public.rips_ripsmedicamentos med, 
	public.rips_ripscums cums 
	where med.id= '540' and cums.id ="codTecnologiaSalud_id"


SELECT 'MEDICAMENTOS' tipo, med.id,med."itemFactura", med."nomTecnologiaSalud" codigo, cums.nombre nombre, med."vrServicio",	med.consecutivo,  
	detGlo."valorGlosa",detGlo."valorAceptado",detGlo."valorSoportado",mot.nombre,
	detGlo."valorNotasCredito" 
	FROM public.rips_ripsmedicamentos med
	inner join public.rips_ripscums cums  on (cums.id =med."codTecnologiaSalud_id")
	left join cartera_glosasdetalle detGlo on (detGlo."ripsProcedimientos_id" =med.id)
	left join cartera_motivosglosas mot on (mot.id = detGlo."motivoGlosa_id" )
	where med.id= '540' 
