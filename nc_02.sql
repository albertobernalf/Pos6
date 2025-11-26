SELECT * FROM RIPS_RIPSPROCEDIMIENTOS -- notasCreditoOtras

 SELECT nc.id,
        "codPrestador", "fechaInicioAtencion", "idMIPRES", "numAutorizacion","numDocumentoIdentificacion", "notasCreditoGlosa","valorPagoModerador", "numFEVPagoModerador", row_number() OVER(ORDER BY proc.id) AS consecutivo , '2025-11-25 22:51:34.373546+00:00' , "codComplicacion_id", "codDiagnosticoPrincipal_id","codDiagnosticoRelacionado_id", "codProcedimiento_id", "codServicio_id", "conceptoRecaudo_id", "finalidadTecnologiaSalud_id",    "grupoServicios_id", "modalidadGrupoServicioTecSal_id","tipoDocumentoIdentificacion_id", '1' , "viaIngresoServicioSalud_id",'140', proc."itemFactura", proc."ripsTipos_id",   proc."tipoPagoModerador_id",'981','A','50363', ncDetRips."valorNota" 
	FROM rips_ripsProcedimientos proc 
	inner join cartera_notascreditodetallerips ncDetRips on (ncDetRips."ripsProcedimientos_id" = proc.id) 
	inner join cartera_notascreditoDetalle ncDet on (ncDet.id =  ncDetRips."notaCreditoDetalle_id")
	inner join cartera_notascredito nc on (nc.id = ncDet."notaCredito_id")
	inner join rips_ripsdetalle det on (det."numeroFactura_id" =  ncDet.factura_id and  
--	det."notaCredito_id"= ncDet.id  AND
	det."notaCredito_id" = '2')
where proc."numFEVPagoModerador" = '152'

	select * from rips_ripsdetalle
	select * from rips_ripsMedicamentos
	select * from rips_ripsotrosservicios


	

	select * from cartera_notascreditoDetallerips
select * from rips_ripsMedicamentos

	
SELECT nc.id, "codPrestador", "numAutorizacion", "idMIPRES", "fechaDispensAdmon", "nomTecnologiaSalud", "concentracionMedicamento", "cantidadMedicamento", "diasTratamiento","numDocumentoIdentificacion", "vrUnitMedicamento",
	"vrServicio", "valorPagoModerador", "numFEVPagoModerador",row_number() OVER(ORDER BY med.id) AS consecutivo , med."fechaRegistro", "codDiagnosticoPrincipal_id", "codDiagnosticoRelacionado_id", "codTecnologiaSalud_id", "conceptoRecaudo_id", "formaFarmaceutica_id", "tipoDocumentoIdentificacion_id","tipoMedicamento_id", "unidadMedida_id", "unidadMinDispensa_id", med."usuarioRegistro_id", '150' , med."itemFactura",med."ripsTipos_id", '987','50363','A', ncDetRips."valorNota" 
	FROM rips_ripsMedicamentos med  
	inner join cartera_notascreditodetallerips ncDetRips  ON (ncDetRips."ripsMedicamentos_id" = med.id)
	inner join cartera_notascreditodetalle  ncDet on (ncDet.id = ncDetRips."notaCreditoDetalle_id")
	inner join cartera_notascredito nc on (nc.id = ncDet."notaCredito_id" and ncDet.factura_id = cast(med."numFEVPagoModerador"  as integer))
	inner join rips_ripsdetalle det on (det."numeroFactura_id" =  cast(med."numFEVPagoModerador"  as integer) and  det."notaCredito_id" =nc.id and det."notaCredito_id"='2') 
where med."numFEVPagoModerador" = '151'

-- Estas son las que va a varrer
select * from rips_ripsenvios
select * from rips_ripstiposnotas
select * from rips_ripsdetalle;
select * from cartera_notascredito where id =2
select * from cartera_notascreditodetalle where "notaCredito_id" =2
select * from cartera_notascreditodetallerips where "notaCreditoDetalle_id" =13

select * from rips_ripstransaccion order by id desc
	SELECT * FROM RIPS_RIPSUSUARIOS ORDER BY ID DESC
	
select "ripsTransaccion_id","fechaRegistro",* from rips_ripsprocedimientos order by id desc
select "ripsTransaccion_id",* from rips_ripsmedicamentos order by id desc
select "ripsTransaccion_id",* from rips_ripsotrosservicios order by id desc	
select "ripsTransaccion_id",* from rips_ripsUSUARIOS order by id desc	

	
select generaFacturaJSONBAK1('75','2','NOTA CREDITO',1057) valorJson
	select generaFacturaJSONBAK1('75','2','NOTA CREDITO',1046) valorJson

select * from clinico_diagnosticos where id =1	
	select * from rips_ripscums where id = 154
SELECT generaEnvioRipsJSON1(75,'NOTA CREDITO') dato


		
	 SELECT	'{"codPrestador": ' ||  '"' ||med."codPrestador"|| '",'   ||		
	   	    '"numAutorizacion": ' || '"'  ||CASE WHEN trim(med."numAutorizacion") is null THEN 'null' ELSE med."numAutorizacion"  END|| '",'   || 	
	 	  '"idMIPRES": ' || '"'   ||CASE WHEN trim(med."idMIPRES") is null THEN 'null'  WHEN trim(med."idMIPRES") = null THEN 'null' WHEN trim(med."idMIPRES") = '' THEN 'null'  ELSE med."idMIPRES"  END|| '",'  || 	
		'"fechaDispensAdmon": ' || '"'  ||substring(cast(med."fechaDispensAdmon" as text),1,16) || '",'     || 	
	  '"codDiagnosticoPrincipal": ' || '"'  ||CASE WHEN trim(diag1.cie10) is null THEN 'null' ELSE diag1.cie10  END|| '",'  || 	
	'"codDiagnosticoRelacionado": ' || '"'  ||CASE WHEN trim(diag2.cie10) is null THEN 'null' ELSE diag2.cie10  END|| '",' 	  || 	
	'"tipoMedicamento": ' || '"'  ||CASE WHEN trim(tipmed.codigo) is null THEN 'null' ELSE tipmed.codigo  END|| '",'   || 	
	'"codTecnologiaSalud": ' || '"'  ||  CASE WHEN trim(ripscums.cum) is null THEN 'null' ELSE ripscums.cum  END           || '",'  || 	
	'"nomTecnologiaSalud": ' || '"'  ||   CASE WHEN trim(med."nomTecnologiaSalud") is null THEN 'null' ELSE med."nomTecnologiaSalud"  END               || '",'  || 	
	'"concentracionMedicamento": ' || '"'  || CASE WHEN trim(med."concentracionMedicamento") is null THEN 'null' ELSE med."concentracionMedicamento"  END  || '",'    || 		
	'"unidadMedida": ' ||  CASE WHEN ripsumm.codigo is null THEN 'null' WHEN ripsumm.codigo = 'null' THEN 'null' ELSE ripsumm.codigo  END|| ','  || 	
	'"formaFarmaceutica": ' || '"'  ||  CASE WHEN trim(ripsfarma.codigo) is null THEN 'null' ELSE ripsfarma.codigo  END  || '",'  || 	
	'"unidadMinDispensa": ' || CASE WHEN trim(ripsupr.codigo) is null THEN 'null' WHEN trim(ripsupr.codigo) = 'null' THEN 'null' ELSE ripsupr.codigo  END || ','  || 	
	'"cantidadMedicamento": ' || med."cantidadMedicamento"  || ','    || 	
	'"diasTratamiento": ' ||    med."diasTratamiento"   || ','   || 		
	'"tipoDocumentoldentificacion": ' || '"'  || CASE WHEN trim(ripstipdoc.codigo) is null THEN 'null' ELSE ripstipdoc.codigo  END   || '",'  || 	
	'"numDocumentoIdentificacion": ' || '"'  || CASE WHEN trim(med."numDocumentoIdentificacion") is null THEN 'null' ELSE med."numDocumentoIdentificacion"  END     || '",'  || 	
		'"vrUnitMedicamento": ' || med."vrUnitMedicamento" || ','  || 	
		'"vrServicio": ' || med."notasCreditoOtras"|| ','  || 	
		'"conceptoRecaudo": ' || '"'  ||CASE WHEN trim(recaudo.codigo) is null THEN 'null' ELSE recaudo.codigo  END|| '",'  || 	
		'"tipoPagoModerador": ' || '"'  ||  CASE WHEN trim( ripstipopago.codigo) is null THEN 'null' ELSE  ripstipopago.codigo  END || '",'  || 	
	'"valorPagoModerador": ' || med."valorPagoModerador" || ','  || 				
	'"numFEVPagoModerador": ' || '"'  || CASE WHEN trim(med."numFEVPagoModerador") is null THEN 'null' ELSE  med."numFEVPagoModerador"  END|| '",'   || 	
	'"consecutivo": ' || med.consecutivo || '},'
	from rips_ripstransaccion
	inner join rips_ripsenvios  env on (env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" )
	inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = rips_ripstransaccion.id)
	inner join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id" )
	inner join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric) and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as integer) )
	inner join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" )
	inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null and facDet."consecutivoFactura" = med."itemFactura" )
	inner join facturacion_suministros sum  on (sum.id = facdet.cums_id )
	left join rips_ripstipomedicamento tipmed on (tipmed.id =sum."ripsTipoMedicamento_id" )
	left join rips_ripscums ripscums on (ripscums.id = med."codTecnologiaSalud_id")	
	left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id")	
	left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id")	
	left join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id")	
    left join rips_ripsconceptorecaudo recaudo on (recaudo.id = med."conceptoRecaudo_id")		
	inner join  rips_RipsTiposDocumento ripstipdoc on (ripstipdoc.id = med."tipoDocumentoIdentificacion_id")
	left join cartera_pagos pagos on (pagos."tipoDoc_id" =  fac."tipoDoc_id"  and pagos.documento_id = fac.documento_id and pagos.consec = fac."consecAdmision")	
	left join cartera_formaspagos formaspagos on (formaspagos.id = pagos."formaPago_id")		
	left join rips_ripstipospagomoderador ripstipopago on (cast(ripstipopago."codigoAplicativo" as numeric) = formaspagos.id and cast(ripstipopago."codigoAplicativo" as numeric) in ('3','4') )	
	left join clinico_diagnosticos diag1 on (diag1.id = med."codDiagnosticoPrincipal_id")	
	left join clinico_diagnosticos diag2 on (diag2.id = med."codDiagnosticoRelacionado_id")	
    where rips_ripstransaccion."ripsEnvio_id" = '75' and rips_ripstransaccion."ripsEnvio_id" = env.id  and cast(rips_ripstransaccion."numNota" as numeric) = det."notaCredito_id"	and rips_ripstransaccion."numNota" =cast('2' as text ) and  med.consecutivo = 1 and rips_ripstransaccion.id is not null;
