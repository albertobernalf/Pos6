select * from rips_ripsmedicamentos
select * from rips_ripsenvios;

SELECT * FROM RIPS_RIPSESTADOS;
select * from cartera_pagosfacturas;
delete from cartera_pagosfacturas where id in (58,59,60,61,62);
select * from cartera_pagos;
select * from cartera_caja;

select generaenvioripsjson(64,'FACTURA')
	select generafacturajson(64,122,'FACTURA')
	select generafacturajson(64,136,'FACTURA')

select "tipoDoc_id",* from usuarios_usuarios order by id desc;

select * from facturacion_facturaciondetalle where facturacion_id=136
	select "ripsUnidadUpr_id","unidadMedida_id", * from facturacion_suministros where id=27620

	update facturacion_suministros
	set  "ripsUnidadUpr_id" = null
	where id=27620
select * from rips_ripsumm

	select * from rips_ripsunidadupr

select * from admisiones_ingresos where documento_id=57 -- 510777

select * from facturacion_conveniospacienteingresos where documento_id=57;
select * from facturacion_liquidacion where documento_id=57;
select * from cartera_Pagos order by id desc

update facturacion_liquidacion set "valorApagar"  = 69000, anticipos=36000, "totalCopagos" = 0, "totalCuotaModeradora" = 0,"totalRecibido" = 36000  where documento_id=57;
select * from rips_RIPSTRANSACCION ORDER BY ID DESC
	select * from rips_ripsusuarios where "ripsTransaccion_id"=404
select * from rips_ripshospitalizacion where "ripsTransaccion_id"=404	
select * from rips_ripsurgenciasobservacion where "ripsTransaccion_id"=404
select * from rips_ripsmedicamentos where "ripsTransaccion_id">=407
		select substring(cast("fechaDispensAdmon" as text),1,16) ,* from rips_ripsmedicamentos where "ripsTransaccion_id">=407


		
	 SELECT	'{"codPrestador": ' ||  '"' ||med."codPrestador"|| '",'   ||		
	   	    '"numAutorizacion": ' || '"'  ||CASE WHEN trim(med."numAutorizacion") is null THEN 'null' ELSE med."numAutorizacion"  END|| '",'   || 	
		  '"idMIPRES": ' || '"'   ||CASE WHEN trim(med."idMIPRES") is null THEN 'null' ELSE med."idMIPRES"  END|| '",'  || 	
		  '"fechaDispensAdmon": ' || '"'  ||substring(cast(med."fechaDispensAdmon" as text),1,16) || '",'     || 	
	  '"codDiagnosticoPrincipal": ' || '"'  ||CASE WHEN trim(diag1.cie10) is null THEN 'null' ELSE diag1.cie10  END|| '",'  || 	
	'"codDiagnosticoRelacionado": ' || '"'  ||CASE WHEN trim(diag2.cie10) is null THEN 'null' ELSE diag2.cie10  END|| '",' 	  || 	
	'"tipoMedicamento": ' || '"'  ||CASE WHEN trim(tipmed.codigo) is null THEN 'null' ELSE tipmed.codigo  END|| '",'   || 	
	'"codTecnologiaSalud": ' || '"'  ||  CASE WHEN trim(ripscums.cum) is null THEN 'null' ELSE ripscums.cum  END           || '",'  || 	
	'"nomTecnologiaSalud": ' || '"'  ||   CASE WHEN trim(med."nomTecnologiaSalud") is null THEN 'null' ELSE med."nomTecnologiaSalud"  END               || '",'  || 	
	'"concentracionMedicamento": ' || '"'  || CASE WHEN trim(med."concentracionMedicamento") is null THEN 'null' ELSE med."concentracionMedicamento"  END  || '",'    || 		
	'"unidadMedida": ' || '"'  ||  CASE WHEN ripsumm.codigo is null THEN 'null' WHEN ripsumm.codigo = 'null' THEN 'null' ELSE ripsumm.codigo  END  || '",'  || 		
	'"formaFarmaceutica": ' || '"'  ||  CASE WHEN trim(ripsfarma.codigo) is null THEN 'null' ELSE ripsfarma.codigo  END  || '",'  || 	
	'"unidadMinDispensa": ' || '"'  ||  CASE WHEN trim(ripsupr.codigo) is null THEN 'null' WHEN trim(ripsupr.codigo) = 'null' THEN 'null' ELSE ripsupr.codigo  END  || '",'  || 	
	'"cantidadMedicamento": ' || med."cantidadMedicamento"  || ','    || 	
	'"diasTratamiento": ' ||    med."diasTratamiento"   || ','   || 		
	'"tipoDocumentoldentificacion": ' || '"'  || CASE WHEN trim(ripstipdoc.codigo) is null THEN 'null' ELSE ripstipdoc.codigo  END   || '",'  || 	
	'"numDocumentoIdentificacion": ' || '"'  || CASE WHEN trim(med."numDocumentoIdentificacion") is null THEN 'null' ELSE med."numDocumentoIdentificacion"  END     || '",'  || 	
		'"vrUnitMedicamento": ' || med."vrUnitMedicamento" || ','  || 	
		'"vrServicio": ' || med."vrServicio"|| ','  || 	
		'"conceptoRecaudo": ' || '"'  ||CASE WHEN trim(recaudo.codigo) is null THEN 'null' ELSE recaudo.codigo  END|| '",'  || 	
		'"tipoPagoModerador": ' || '"'  ||  CASE WHEN trim( ripstipopago.codigo) is null THEN 'null' ELSE  ripstipopago.codigo  END || '",'  || 	
	'"valorPagoModerador": ' || med."valorPagoModerador" || ','  || 				
	'"numFEVPagoModerador": ' || '"'  || CASE WHEN trim(med."numFEVPagoModerador") is null THEN 'null' ELSE  med."numFEVPagoModerador"  END|| '",'   || 	
	'"consecutivo": ' || med.consecutivo || '},'
	from rips_ripstransaccion
	inner join rips_ripsenvios  env on (env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" )
	inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = rips_ripstransaccion.id)
	inner join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id" )
	inner join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric))
	inner join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" )
	inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null )
	inner join facturacion_suministros sum  on (sum.id = facdet.cums_id )
	left join rips_ripstipomedicamento tipmed on (tipmed.id =sum."ripsTipoMedicamento_id" )
	left join rips_ripscums ripscums on (ripscums.id = med."codTecnologiaSalud_id")	
	left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id")	
	left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id")	
	left join rips_ripsunidadupr ripsupr on (ripsupr.id = cast(sum."ripsUnidadUpr_id" as integer))	
    left join rips_ripsconceptorecaudo recaudo on (recaudo.id = med."conceptoRecaudo_id")		
	inner join  rips_RipsTiposDocumento ripstipdoc on (ripstipdoc.id = med."tipoDocumentoIdentificacion_id")
	left join cartera_pagos pagos on (pagos."tipoDoc_id" =  fac."tipoDoc_id"  and pagos.documento_id = fac.documento_id and pagos.consec = fac."consecAdmision")	
	left join cartera_formaspagos formaspagos on (formaspagos.id = pagos."formaPago_id")		
	left join rips_ripstipospagomoderador ripstipopago on (cast(ripstipopago."codigoAplicativo" as numeric) = formaspagos.id and cast(ripstipopago."codigoAplicativo" as numeric) in ('3','4') )	
	left join clinico_diagnosticos diag1 on (diag1.id = med."codDiagnosticoPrincipal_id")	
	left join clinico_diagnosticos diag2 on (diag2.id = med."codDiagnosticoRelacionado_id")	
	where rips_ripstransaccion."ripsEnvio_id" = 64 and rips_ripstransaccion."ripsEnvio_id" = env.id  and cast(rips_ripstransaccion."numFactura" as numeric) = fac.id	and rips_ripstransaccion."numFactura" =cast('136' as text ) and med.consecutivo = 1;
