select * from rips_ripsenvios;
select * from rips_ripsdetalle;
select * from facturacion_facturacion;
select  "consecutivoFactura", examen_id, * from  facturacion_facturaciondetalle where facturacion_id=42 order by examen_id;
select * from rips_ripsprocedimientos;
select * from clinico_examenes where id = 2450 -- cups 951503
select * from rips_ripstiposdocumento;
select * from usuarios_tiposdocumento;
SELECT id, "numeroFactura_id" item from rips_ripsdetalle det where det."ripsEnvios_id"  = 46

select * from facturacion_liquidaciondetalle;
select * from rips_ripsurgenciasobservacion;


	select * from clinico_historia where documento_id = 16; -- folio 553
select * from clinico_historiaexamenes where historia_id in (549,550,551,552,555) order by "codigoCups"
select * from clinico_historiaexamenes where historia_id in (549,550,551,552,555) and  "codigoCups" = 'A10302'
	300  y 308
update clinico_historiaexamenes set  "consecutivoLiquidacion" =17  where id= 303;
update clinico_historiaexamenes set  "consecutivoLiquidacion" = 9  where id= 311;

update clinico_historiamedicamentos set  "consecutivoLiquidacion" = 19  where id= 311;

select * from clinico_historiamedicamentos

select * from rips_ripstipomedicamento;
select * from rips_ripsformafarmaceutica;


	select "codigoCups", * from clinico_examenes where 	id=3682;
select * from rips_ripsumm;
select * from facturacion_suministros where cums = '19932826-3'
	update facturacion_suministros set "ripsUnidadMedida_id" =1  where cums = '19932826-3'
		update rips_ripscums set "ripsUnidadMedida_id" =1  where id=16294 
		update rips_ripscums set "ripsTipoMedicamento_id" =1  where id=16294 
			update facturacion_suministros set "ripsTipoMedicamento_id" =1  where id=16294 
		update facturacion_suministros set "ripsUnidadMedida_id" =1  where id=16294 
		update facturacion_suministros set "ripsFormaFarmaceutica_id" =1  where id=16294 
	update facturacion_suministros set "ripsUnidadUpr_id" =1  where id=16294 

select * from rips_RipsFormaFarmaceutica;

INSERT INTO rips_ripsmedicamentos ("codPrestador", "numAutorizacion", "idMIPRES", "fechaDispensAdmon", "nomTecnologiaSalud", "concentracionMedicamento", 
	"cantidadMedicamento", 	"diasTratamiento",	"numDocumentoIdentificacion", "vrUnitMedicamento", "vrServicio", "valorPagoModerador", "numFEVPagoModerador",
	consecutivo, "fechaRegistro", "codDiagnosticoPrincipal_id", "codDiagnosticoRelacionado_id", "codTecnologiaSalud_id", "conceptoRecaudo_id", "formaFarmaceutica_id", 
	"tipoDocumentoIdentificacion_id", "tipoMedicamento_id", "unidadMedida_id", "unidadMinDispensa_id", "usuarioRegistro_id", "ripsDetalle_id", "itemFactura",
	"ripsTipos_id", "ripsTransaccion_id")
SELECT sed."codigoHabilitacion", aut."numeroAutorizacion", historia.mipres, cast(facdet.fecha as timestamp), ripscums.cum, histmed."concentracionMedicamento",
	histmed."cantidadAplicada", histmed."diasTratamiento",planta.documento, facdet."valorUnitario", facdet."valorTotal", pagos."totalAplicado", fac.id,
	row_number() OVER(ORDER BY histmed.id), now(), diag1.id, diag2.id, null, null, ripsfarma.id, ripstipdoc.id, tipmed.id, ripsumm.id, ripsupr.id, '1' , 
	det.id, facdet."consecutivoFactura",'8', rips_ripstransaccion.id 
	from rips_ripstransaccion 
	left join rips_ripsenvios env on(env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" )
	inner join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id" ) 
	inner join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric)) 
	inner join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" ) 
	inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null )
	left join clinico_historiamedicamentos histmed on (histmed.id = facdet."historiaMedicamento_id" and histmed."consecutivoLiquidacion" = facdet."consecutivoFactura" ) 
	left join autorizaciones_autorizaciones aut on (aut.id = histmed.autorizacion_id) 
	inner join facturacion_suministros sum on (sum.id = facdet.cums_id)
	inner join rips_ripstipomedicamento tipmed on (tipmed.id = sum."ripsTipoMedicamento_id" )
	inner join rips_ripscums ripscums  on (ripscums.cum = sum."cums") 
	inner join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id") 
	inner join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id") 
	inner join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id") 
	left join clinico_historia historia on (historia.id = histmed.historia_id) 
	left join planta_planta planta on (planta.id = historia.planta_id) 
	left join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id")
	left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = usutipdoc."tipoDocRips_id")
	left join cartera_pagos pagos on (pagos."tipoDoc_id" = fac."tipoDoc_id" and pagos.documento_id = fac.documento_id and pagos.consec = fac."consecAdmision") 
	left join cartera_formaspagos formaspagos on (formaspagos.id = pagos."formaPago_id") 
	left join rips_ripstipospagomoderador ripstipopago  on(cast(ripstipopago."codigoAplicativo" as numeric) = formaspagos.id and cast(ripstipopago."codigoAplicativo" as numeric) in ('3', '4')) 
	left join clinico_historialdiagnosticos histdiag1 on (histdiag1.historia_id = historia.id and histdiag1."tiposDiagnostico_id" = '1')
	left join clinico_historialdiagnosticos histdiag2 on (histdiag2.historia_id = historia.id and histdiag2."tiposDiagnostico_id" = '2') 
	left join clinico_diagnosticos diag1 on (diag1.id = histdiag1.diagnosticos_id) 
	left join clinico_diagnosticos diag2 on (diag2.id = histdiag2.diagnosticos_id) 
	where env.id = '46' and rips_ripstransaccion."ripsEnvio_id" = env.id  and cast(rips_ripstransaccion."numFactura" as numeric) = fac.id       and fac.id = '42'

detalle ='INSERT INTO rips_ripsmedicamentos ("codPrestador", "numAutorizacion", "idMIPRES", "fechaDispensAdmon", "nomTecnologiaSalud", "concentracionMedicamento", "cantidadMedicamento", 	"diasTratamiento",	"numDocumentoIdentificacion", "vrUnitMedicamento", "vrServicio", "valorPagoModerador", "numFEVPagoModerador",consecutivo, "fechaRegistro", "codDiagnosticoPrincipal_id", "codDiagnosticoRelacionado_id", "codTecnologiaSalud_id", "conceptoRecaudo_id", "formaFarmaceutica_id", "tipoDocumentoIdentificacion_id", "tipoMedicamento_id", "unidadMedida_id", "unidadMinDispensa_id", "usuarioRegistro_id", "ripsDetalle_id", "itemFactura","ripsTipos_id", "ripsTransaccion_id") SELECT sed."codigoHabilitacion", aut."numeroAutorizacion", historia.mipres, cast(facdet.fecha as timestamp), ripscums.cum, histmed."concentracionMedicamento",histmed."cantidadAplicada", histmed."diasTratamiento",planta.documento, facdet."valorUnitario", facdet."valorTotal", pagos."totalAplicado", fac.id, row_number() OVER(ORDER BY histmed.id), now(), diag1.id, diag2.id, null, null, ripsfarma.id, ripstipdoc.id, tipmed.id, ripsumm.id, ripsupr.id, ' + "'" + str(username_id) + "'"  + ' , det.id, facdet."consecutivoFactura",' + "'" + str('8') +  "'" + ' , rips_ripstransaccion.id from rips_ripstransaccion left join rips_ripsenvios env on(env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" ) inner join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id" ) inner join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric)) inner join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" ) inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null ) left join clinico_historiamedicamentos histmed on (histmed.id = facdet."historiaMedicamento_id" and histmed."consecutivoLiquidacion" = facdet."consecutivoFactura" ) left join autorizaciones_autorizaciones aut on (aut.id = histmed.autorizacion_id) inner join facturacion_suministros sum on (sum.id = facdet.cums_id) inner join rips_ripstipomedicamento tipmed on (tipmed.id = sum."ripsTipoMedicamento_id" ) inner join rips_ripscums ripscums  on (ripscums.cum = sum."cums") inner join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id") inner join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id")  inner join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id") left join clinico_historia historia on (historia.id = histmed.historia_id) left join planta_planta planta on (planta.id = historia.planta_id) left join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id") left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = usutipdoc."tipoDocRips_id") left join cartera_pagos pagos on (pagos."tipoDoc_id" = fac."tipoDoc_id" and pagos.documento_id = fac.documento_id and pagos.consec = fac."consecAdmision") left join cartera_formaspagos formaspagos on (formaspagos.id = pagos."formaPago_id")  left join rips_ripstipospagomoderador ripstipopago  on(cast(ripstipopago."codigoAplicativo" as numeric) = formaspagos.id and cast(ripstipopago."codigoAplicativo" as numeric) in ('3', '4')) left join clinico_historialdiagnosticos histdiag1 on (histdiag1.historia_id = historia.id and histdiag1."tiposDiagnostico_id" = ' + "'" + str('1') + "')" + ' left join clinico_historialdiagnosticos histdiag2 on (histdiag2.historia_id = historia.id and histdiag2."tiposDiagnostico_id" = ' + "'" + str('2') + "')" + ' 	left join clinico_diagnosticos diag1 on (diag1.id = histdiag1.diagnosticos_id) left join clinico_diagnosticos diag2 on (diag2.id = histdiag2.diagnosticos_id) where env.id = '46' and rips_ripstransaccion."ripsEnvio_id" = env.id  and cast(rips_ripstransaccion."numFactura" as numeric) = fac.id  and fac.id = ' + "'" + str(elemento) + "'"

	
	

