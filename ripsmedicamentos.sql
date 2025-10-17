select * from rips_ripsmedicamentos
select * from rips_ripsenvios;

SELECT * FROM RIPS_RIPSESTADOS;
select * from cartera_pagosfacturas;
delete from cartera_pagosfacturas where id in (58,59,60,61,62);
select * from cartera_pagos;
select * from cartera_caja;


select "tipoDoc_id",* from usuarios_usuarios order by id desc;

select * from admisiones_ingresos where documento_id=57 -- 510777

select * from facturacion_conveniospacienteingresos where documento_id=57;
select * from facturacion_liquidacion where documento_id=57;
select * from cartera_Pagos order by id desc

update facturacion_liquidacion set "valorApagar"  = 69000, anticipos=36000, "totalCopagos" = 0, "totalCuotaModeradora" = 0,"totalRecibido" = 36000  where documento_id=57;
select * from rips_RIPSTRANSACCION ORDER BY ID DESC
	select * from rips_ripsusuarios where "ripsTransaccion_id"=404
select * from rips_ripshospitalizacion where "ripsTransaccion_id"=404	
select * from rips_ripsurgenciasobservacion where "ripsTransaccion_id"=404
select * from rips_ripsmedicamentos where "ripsTransaccion_id"=407
select * from rips_ripsprocedimientos where "ripsTransaccion_id"=404
select * from rips_ripsreciennacido where "ripsTransaccion_id"=404

	select * from facturacion_facturaciondetalle where facturacion_id=148
	

SELECT sed."codigoHabilitacion", aut."numeroAutorizacion", historia.mipres, 
	cast(facdet.fecha as timestamp), ripscums.cum, histmed."concentracionMedicamento",histmed."cantidadOrdenada",
	histmed."diasTratamiento",planta.documento, facdet."valorUnitario", facdet."valorTotal", 'prorata', fac.id,
	row_number() OVER(ORDER BY histmed.id), now(), diag1.id, diag2.id, null, null, ripsfarma.id, 
	ripstipdoc.id, tipmed.id, ripsumm.id, ripsupr.id, '1' , det.id,
	facdet."consecutivoFactura",' 8' , rips_ripstransaccion.id , 'A','1001' 
from rips_ripstransaccion 
	inner join rips_ripsenvios env on(env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" ) 
	inner join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id" ) 
	inner join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric)) 
	inner join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" )
	inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null
	and (facdet.anulado = 'N' or facdet.anulado = 'R')  AND facDet."tipoRegistro" = 'SISTEMA' ) 
	inner join clinico_historiamedicamentos histmed on (histmed.id = facdet."historiaMedicamento_id") 
	left join autorizaciones_autorizacionesDetalle  aut on (aut.id = histmed.autorizacion_id) 
	inner join facturacion_suministros sum on (sum.id = facdet.cums_id) 
	left join rips_ripstipomedicamento tipmed on (tipmed.id = sum."ripsTipoMedicamento_id" )
	left join rips_ripscums ripscums  on (ripscums.cum = sum."cums") 
	left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id") 
	left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id")  
	left join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id")
	inner join clinico_historia historia on (historia.id = histmed.historia_id) 
	inner join planta_planta planta on (planta.id = historia."usuarioRegistro_id") 
	left join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id") 
	left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = usutipdoc."tipoDocRips_id") 
	left join clinico_historialdiagnosticos histdiag1 on (histdiag1.historia_id = historia.id and histdiag1."tiposDiagnostico_id" = '1') 
	left join clinico_historialdiagnosticos histdiag2 on (histdiag2.historia_id = historia.id and histdiag2."tiposDiagnostico_id" = '2')
	left join clinico_diagnosticos diag1 on (diag1.id = histdiag1.diagnosticos_id) left join clinico_diagnosticos diag2 on (diag2.id = histdiag2.diagnosticos_id) 
	where env.id =  '68' and rips_ripstransaccion."ripsEnvio_id" = env.id  and 
	cast(rips_ripstransaccion."numFactura" as numeric) = fac.id  and fac.id = '148'
            
update facturacion_facturaciondetalle set  "tipoRegistro" = 'SISTEMA' where id = 419
update facturacion_facturaciondetalle set  "tipoRegistro" = 'MANUAL' where id = 419
	
	SELECT sed."codigoHabilitacion", null, null, cast(facdet.fecha as timestamp), ripscums.cum,null ,null ,null ,planta.documento, facdet."valorUnitario",	facdet."valorTotal", pagos."totalAplicado", fac.id, row_number() OVER(ORDER BY facdet.id)  + ' + str(traigoConsecutivo) + ' , now(),diag1.id , diag2.id, null, null, ripsfarma.id, ripstipdoc.id, tipmed.id, ripsumm.id, ripsupr.id, ' + "'" + str(username_id) + "'" + ' , det.id, facdet."consecutivoFactura", ' + "'" + str('8') + "'" + ' , rips_ripstransaccion.id , ' + "'" + str('A') + "','" + str(ingresoId.id) + "'"  + ' from rips_ripstransaccion inner join rips_ripsenvios env on(env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" ) inner join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id") inner join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric)) inner join facturacion_facturacion fac on (fac.id = det."numeroFactura_id") inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null and (facdet.anulado = ' + "'" + str('N') + "'" + ' or facdet.anulado = ' + "'" + str('R') + "')" + ' AND facDet."tipoRegistro" = ' + "'" + str('MANUAL') + "')" + ' inner join facturacion_suministros sum on (sum.id = facdet.cums_id) left join rips_ripstipomedicamento tipmed on (tipmed.id = sum."ripsTipoMedicamento_id" ) inner join rips_ripscums ripscums  on (ripscums.cum = sum."cums") left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id") left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id") left join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id") inner join admisiones_ingresos adm on (adm."tipoDoc_id" = fac."tipoDoc_id" and adm.documento_id=fac.documento_id and adm.consec=fac."consecAdmision")left join 	clinico_medicos medico on (medico.id =adm."medicoActual_id") inner join planta_planta planta on (planta.id = medico.planta_id) left join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id") left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = usutipdoc."tipoDocRips_id") left join cartera_pagos pagos on (pagos."tipoDoc_id" = fac."tipoDoc_id" and pagos.documento_id = fac.documento_id and pagos.consec = fac."consecAdmision") left join cartera_formaspagos formaspagos on (formaspagos.id = pagos."formaPago_id") left join rips_ripstipospagomoderador ripstipopago  on(cast(ripstipopago."codigoAplicativo" as numeric) = formaspagos.id and cast(ripstipopago."codigoAplicativo" as numeric) in (' + "'" + str('3') + "','" + str('4') + "'" + ' ))   left join clinico_diagnosticos diag1 on (diag1.id=adm."dxActual_id") left join clinico_diagnosticos diag2 on (diag2.id=adm."dxIngreso_id") where env.id =  ' + "'" + str(envioRipsId) + "'" + ' and rips_ripstransaccion."ripsEnvio_id" = env.id  and cast(rips_ripstransaccion."numFactura" as numeric) = fac.id  and fac.id = ' + "'" + str(elemento) + "'"


select * from cartera_FormasPagos