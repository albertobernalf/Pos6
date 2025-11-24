select * from cartera_notascredito
select * from cartera_notascreditodetalle
	select * from cartera_notascreditodetallerips
	
update cartera_notascreditodetalle set "tiposNotasCredito_id" =1
select * from RIPS_RIPSDETALLE


select * from cartera_TiposNotasCredito


select "notasCredito",* from facturacion_facturacion 
SELECT * FROM RIPS_ripstiposnotas;
select * from rips_ripsenvios
	select * from rips_ripsdetalle where "ripsEnvios_id" = 75
select * from rips_ripsenvios

	select * from rips_ripstransaccion

select * from facturacion_facturacion;
select * from rips_ripsdetalle
	select * from cartera_glosas
	select * from cartera_notascredito
	
SELECT det.id, det."notaCredito_id" item , ncDet.factura_id itemOtro from rips_ripsdetalle det left join cartera_notascredito nc on (nc."ripsEnvio_id" =det."ripsEnvios_id" and nc.id =det."notaCredito_id" )
	left join cartera_notascreditodetalle ncDet on (ncDet."notaCredito_id" =nc.id ) where det."ripsEnvios_id"  = '75'

detalle ='SELECT det.id, det."notaCredito_id" item , ncDet.factura_id itemOtro from rips_ripsdetalle det left join cartera_notascredito nc on (nc."ripsEnvio_id" =det."ripsEnvios_id" and nc.id =det."notaCredito_id" ) left join cartera_notascreditodetalle ncDet on (ncDet."notaCredito_id" =nc.id ) where det."ripsEnvios_id"  = ' + "'" + str(envioRipsId) + "'"

select * from rips_ripstransaccion
select * from rips_ripstiposnotas
	select * from cartera_notascredito
select * from cartera_notascreditodetalle
	select * from cartera_notascreditodetalleRips
select * from rips_ripsenvios
	select * from rips_ripsdetalle where "ripsEnvios_id" = 75	
	-- nc 2 factura 151
select * from rips_ripsmedicamentos where "ripsTransaccion_id" = 949	
select * from cartera_glosasdetalle

	select 'MEDICAMENTOS' tipo,med.id, med.consecutivo consec, med."itemFactura",cums.cum codigo,cums.nombre nombre,med."vrServicio",  detCreRips."valorNota", detCre.id detCreId, detCreRips.id detCreRipsId, detCre."notaCredito_id" notaCreditoId  FROM rips_ripstransaccion ripstra inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id) inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) left join cartera_notascreditodetalle detCre on (detCre."notaCredito_id" = '2') left join cartera_notascreditodetalleRips detCreRips on (detCreRips."notaCreditoDetalle_id" = detCre.id AND  detCreRips."ripsMedicamentos_id" = med.id)  where  ripstra."numFactura"= '151' 
	UNION
	select 'PROCEDIMIENTOS' tipo,proc.id, proc.consecutivo consec, proc."itemFactura",exa."codigoCups" codigo,exa.nombre nombre,     proc."vrServicio",
	detCreRips."valorNota", detCre.id detCreId, detCreRips.id detCreRipsId, detCre."notaCredito_id" notaCreditoId 
	FROM rips_ripstransaccion ripstra 
	inner join rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) 
	inner join  clinico_examenes exa on (exa.id =proc."codProcedimiento_id" ) 
	inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = proc."itemFactura" )
	left join cartera_notascreditodetalle detCre on (detCre."notaCredito_id" = '2') 
	left join cartera_notascreditodetalleRips detCreRips on (detCreRips."notaCreditoDetalle_id" = detCre.id AND  detCreRips."ripsProcedimientos_id" = proc.id)
	where  ripstra."numFactura"= '151' 
	
	UNION select 'CONSULTAS' tipo,cons.id, cons.consecutivo consec, cons."itemFactura",exa."codigoCups" codigo,exa.nombre nombre, cons."vrServicio",  detCreRips."valorNota", detCre.id detCreId, detCreRips.id detCreRipsId, detCre."notaCredito_id" notaCreditoId        FROM rips_ripstransaccion ripstra inner join rips_ripsconsultas cons on (cons."ripsTransaccion_id" = ripstra.id)     inner join  clinico_examenes exa on (exa.id =cons."codConsulta_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = cons."itemFactura" ) left join cartera_notascreditodetalle detCre on (detCre."notaCredito_id" = '2') left join cartera_notascreditodetalleRips detCreRips on (detCreRips."notaCreditoDetalle_id" = detCre.id AND  detCreRips."ripsMedicamentos_id" = cons.id) where  ripstra."numFactura"= '151' UNION select 'OTROS SERVICIOS' tipo,otros.id, otros.consecutivo consec, otros."itemFactura",exa."codigoCups" codigo,exa.nombre nombre,  otros."vrServicio",  detCreRips."valorNota", detCre.id detCreId, detCreRips.id detCreRipsId, detCre."notaCredito_id" notaCreditoId FROM rips_ripstransaccion ripstra inner join rips_ripsotrosservicios otros on (otros."ripsTransaccion_id" = ripstra.id) inner join  clinico_examenes exa on (exa.id =otros."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = otros."itemFactura" ) left join cartera_notascreditodetalle detCre on (detCre."notaCredito_id" = '2') left join cartera_notascreditodetalleRips detCreRips on (detCreRips."notaCreditoDetalle_id" = detCre.id AND  detCreRips."ripsMedicamentos_id" = otros.id) where  ripstra."numFactura"= '151'
	select * from rips_ripsmedicamentos where id = 615
select 'MEDICAMENTOS' tipo,med.id, med.consecutivo consec, med."itemFactura",cums.cum codigo,cums.nombre nombre,
	med."vrServicio",  detCreRips."valorNota", detCre.id detCreId, detCreRips.id detCreRipsId, detCre."notaCredito_id" notaCreditoId	
FROM rips_ripstransaccion ripstra 
inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id) 	
inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) 
inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) 
left join cartera_notascreditodetalle detCre on (detCre."notaCredito_id" = '2' )	
left join cartera_notascreditodetalleRips detCreRips on (detCreRips."notaCreditoDetalle_id" = detCre.id AND  detCreRips."ripsMedicamentos_id" = med.id)	
where  ripstra."numFactura"= '151' 
UNION
select 'PROCEDIMIENTOS' tipo,proc.id, proc.consecutivo consec, proc."itemFactura",exa."codigoCups" codigo,exa.nombre nombre,
	proc."vrServicio",  detCreRips."valorNota", detCre.id detCreId, detCreRips.id detCreRipsId, detCre."notaCredito_id" notaCreditoId	
FROM rips_ripstransaccion ripstra 
inner join rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) 	
inner join  clinico_examenes exa on (exa.id =proc."codProcedimiento_id" ) 
inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = proc."itemFactura" ) 
left join cartera_notascreditodetalle detCre on (detCre."notaCredito_id" = '2' )	
left join cartera_notascreditodetalleRips detCreRips on (detCreRips."notaCreditoDetalle_id" = detCre.id AND  detCreRips."ripsMedicamentos_id" = proc.id)	
where  ripstra."numFactura"= '151' 
UNION
select 'CONSULTAS' tipo,cons.id, cons.consecutivo consec, cons."itemFactura",exa."codigoCups" codigo,exa.nombre nombre,
	cons."vrServicio",  detCreRips."valorNota", detCre.id detCreId, detCreRips.id detCreRipsId, detCre."notaCredito_id" notaCreditoId	
FROM rips_ripstransaccion ripstra 
inner join rips_ripsconsultas cons on (cons."ripsTransaccion_id" = ripstra.id) 	
inner join  clinico_examenes exa on (exa.id =cons."codConsulta_id" ) 
inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = cons."itemFactura" ) 
left join cartera_notascreditodetalle detCre on (detCre."notaCredito_id" = '2' )	
left join cartera_notascreditodetalleRips detCreRips on (detCreRips."notaCreditoDetalle_id" = detCre.id AND  detCreRips."ripsMedicamentos_id" = cons.id)	
where  ripstra."numFactura"= '151'
UNION
select 'OTROS SERVICIOS' tipo,otros.id, otros.consecutivo consec, otros."itemFactura",exa."codigoCups" codigo,exa.nombre nombre,
	otros."vrServicio",  detCreRips."valorNota", detCre.id detCreId, detCreRips.id detCreRipsId, detCre."notaCredito_id" notaCreditoId	
FROM rips_ripstransaccion ripstra 
inner join rips_ripsotrosservicios otros on (otros."ripsTransaccion_id" = ripstra.id) 	
inner join  clinico_examenes exa on (exa.id =otros."codTecnologiaSalud_id" ) 
inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = otros."itemFactura" ) 
left join cartera_notascreditodetalle detCre on (detCre."notaCredito_id" = '2' )	
left join cartera_notascreditodetalleRips detCreRips on (detCreRips."notaCreditoDetalle_id" = detCre.id AND  detCreRips."ripsMedicamentos_id" = otros.id)	
where  ripstra."numFactura"= '151'
	
	
select * from rips_ripsotrosservicios

detalle = 'select ' + "'" + str('MEDICAMENTOS') + "'" + ' tipo,med.id, med.consecutivo consec, med."itemFactura",cums.cum codigo,cums.nombre nombre,med."vrServicio",  detCreRips."valorNota", detCre.id detCreId, detCreRips.id detCreRipsId, detCre."notaCredito_id" notaCreditoId	FROM rips_ripstransaccion ripstra inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id) inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) left join cartera_notascreditodetalle detCre on (detCre."notaCredito_id" = ' + "'" + str(notaCreditoId) + "'" + ') left join cartera_notascreditodetalleRips detCreRips on (detCreRips."notaCreditoDetalle_id" = detCre.id AND  detCreRips."ripsMedicamentos_id" = med.id)	where  ripstra."numFactura"= ' + "'" + str(factura) + "'" + ' UNION select ' + "'" + str('PROCEDIMIENTOS') + "'" + ' tipo,proc.id, proc.consecutivo consec, proc."itemFactura",exa."codigoCups" codigo,exa.nombre nombre,	proc."vrServicio",  detCreRips."valorNota", detCre.id detCreId, detCreRips.id detCreRipsId, detCre."notaCredito_id" notaCreditoId	FROM rips_ripstransaccion ripstra inner join rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) inner join  clinico_examenes exa on (exa.id =proc."codProcedimiento_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = proc."itemFactura" ) left join cartera_notascreditodetalle detCre on (detCre."notaCredito_id" = ' + "'" + str(notaCreditoId) + "'" + ') left join cartera_notascreditodetalleRips detCreRips on (detCreRips."notaCreditoDetalle_id" = detCre.id AND  detCreRips."ripsMedicamentos_id" = proc.id) where  ripstra."numFactura"= ' + "'" + str(factura) + "'" + ' UNION select ' + "'" + str('CONSULTAS') + "'" + ' tipo,cons.id, cons.consecutivo consec, cons."itemFactura",exa."codigoCups" codigo,exa.nombre nombre, cons."vrServicio",  detCreRips."valorNota", detCre.id detCreId, detCreRips.id detCreRipsId, detCre."notaCredito_id" notaCreditoId	FROM rips_ripstransaccion ripstra inner join rips_ripsconsultas cons on (cons."ripsTransaccion_id" = ripstra.id) 	inner join  clinico_examenes exa on (exa.id =cons."codConsulta_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = cons."itemFactura" ) left join cartera_notascreditodetalle detCre on (detCre."notaCredito_id" = ' + "'" + str(notaCreditoId) + "'" + ') left join cartera_notascreditodetalleRips detCreRips on (detCreRips."notaCreditoDetalle_id" = detCre.id AND  detCreRips."ripsMedicamentos_id" = cons.id) where  ripstra."numFactura"= ' +  "'" + str(factura) + "'" + ' UNION select ' + "'" + str('OTROS SERVICIOS') + "'" + ' tipo,otros.id, otros.consecutivo consec, otros."itemFactura",exa."codigoCups" codigo,exa.nombre nombre,	otros."vrServicio",  detCreRips."valorNota", detCre.id detCreId, detCreRips.id detCreRipsId, detCre."notaCredito_id" notaCreditoId FROM rips_ripstransaccion ripstra inner join rips_ripsotrosservicios otros on (otros."ripsTransaccion_id" = ripstra.id) inner join  clinico_examenes exa on (exa.id =otros."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = otros."itemFactura" ) left join cartera_notascreditodetalle detCre on (detCre."notaCredito_id" = ' + "'" + str(notaCreditoId) + "'" + ') left join cartera_notascreditodetalleRips detCreRips on (detCreRips."notaCreditoDetalle_id" = detCre.id AND  detCreRips."ripsMedicamentos_id" = otros.id) where  ripstra."numFactura"= ' + "'" + str(factura) + "'"
select * from cartera_glosasdetalle	

	update facturacion_facturacion set "saldoFactura"  = "valorApagar"

SELECT 'MEDICAMENTOS' tipo, detCre.id detCreId, med.id,med."itemFactura", med."nomTecnologiaSalud" codigo, cums.nombre nombre, med."vrServicio",  
	med.consecutivo,  detCreRips."valorNota"   
FROM public.rips_ripsmedicamentos med 
inner join public.rips_ripscums cums  on (cums.id =med."codTecnologiaSalud_id") 
left join cartera_notascreditodetalle detCre on (detCre.id= '7') 
left join cartera_notascreditodetalleRips detCreRips on (detCreRips."notaCreditoDetalle_id  = detCre.id AND  detCreRips."ripsMedicamentos_id" =med.id)
where med.id= '615'

select * from cartera_notascredito
select * from cartera_notascreditodetalle
	delete from cartera_notascreditodetalle where id=11
select * from cartera_notascreditodetallerips
	delete from cartera_notascreditodetallerips where "notaCreditoDetalle_id"=12
		
select id,"valorApagar","saldoFactura","totalValorAceptado", "totalNotasCredito","totalNotasDebito",* from facturacion_facturacion		
--update facturacion_facturacion set "totalNotasCredito"=0,"saldoFactura"="valorApagar"

select "notaCreditoDetalle_id",* from cartera_notascreditodetallerips

	select * from rips_ripsotrosservicios
	