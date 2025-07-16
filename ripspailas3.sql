SELECT '"servicios": {"procedimientos": [{"codPrestador": '|| '"' || proc."codPrestador" || '",'  ||'"fechaInicioAtencion": '|| '"' || proc."fechaInicioAtencion" || '",'
	||'"valorPagoModerador": '|| '"' ||   CASE WHEN trim(cast(proc."valorPagoModerador" as text)) is null THEN 0 ELSE proc."valorPagoModerador"  END  || '",'	
	||'"numFEVPagoModerador": '|| '"' || proc."numFEVPagoModerador" || '",'
	||'"consecutivo": '|| '"' || proc."consecutivo" || '",'	
	||'	},],'
	||'"idMIPRES": '|| '"' ||  CASE WHEN trim(proc."idMIPRES") is null THEN 'null' ELSE proc."idMIPRES"  END || '",'  	
	 ||'"numAutorizacion": '|| '"' || CASE WHEN trim(proc."numAutorizacion") is null THEN 'null' ELSE proc."numAutorizacion"  END || '",'	
	||'"codProcedimiento": '|| '"' || proc."codProcedimiento_id" || '",'	
		||'"viaIngresoServicioSalud": '|| '"' ||proc."viaIngresoServicioSalud_id"  || '",'	
		||'"modalidadGrupoServicioTecSal": '|| '"' || proc."modalidadGrupoServicioTecSal_id"  || '",'	
		||'"finalidadTecnologiaSalud": '|| '"' ||proc."finalidadTecnologiaSalud_id"  || '",'	
	||'"tipoDocumentoIdentificacion": '|| '"' || proc."tipoDocumentoIdentificacion_id"  || '",'	
	||'"numDocumentoIdentificacion": '|| '"' || CASE WHEN trim(proc."numDocumentoIdentificacion") is null THEN 'null' ELSE proc."numDocumentoIdentificacion"  END  || '",'	
	||'"codDiagnosticoPrincipal": '|| '"' || CASE WHEN trim(cast(proc."codDiagnosticoPrincipal_id" as text)) is null THEN 0 ELSE proc."codDiagnosticoPrincipal_id"  END || '",'	
	||'"codDiagnosticoRelacionado": '|| '"' ||  CASE WHEN trim(cast(proc."codDiagnosticoRelacionado_id" as text)) is null THEN 0 ELSE proc."codDiagnosticoRelacionado_id"  END    || '",'	
	||'"codComplicacion": '|| '"' ||CASE WHEN trim(cast(proc."codComplicacion_id" as text)) is null THEN 0 ELSE proc."codComplicacion_id"  END   || '",'
	||'"vrProcedimiento": '|| '"' || proc."vrServicio"  || '",'	
	||'"tipoPagoModerador": '|| '"' || CASE WHEN trim(cast(proc."tipoPagoModerador_id" as text)) is null THEN 0 ELSE proc."tipoPagoModerador_id"  END  || '",'	
	||'"consecutivo": '|| '"' || proc."consecutivo"  || '",'	
	||'	},],'
dato1
from rips_ripstransaccion, rips_ripsprocedimientos proc
where  rips_ripstransaccion."ripsEnvio_id" = 31 and proc."ripsTransaccion_id" = rips_ripstransaccion.id 

select * from rips_ripsprocedimientos;
select * from rips_ripshospitalizacion;
select * from rips_ripscausaexterna;
select * from rips_ripstransaccion;
select * from rips_ripscausaexterna;
select * from clinico_diagnosticos;
select * from clinico_historia;

-- hospitalizaCION


		   
SELECT '{"hospitalizacion": [{"codPrestador": ' ||  '"' || hosp."codPrestador"|| '",'  ||
		   '"viaIngresoServicioSalud": ' || '"'  ||hosp."viaIngresoServicioSalud_id"|| '",'  ||
	    '"fechaInicioAtencion": ' || '"'  ||hosp."fechaInicioAtencion"|| '",'  || 
		 '"numAutorizacion": ' || '"'  ||hosp."numAutorizacion"|| '",'   || 
	 '"causaMotivoAtencion": ' || '"'  ||cauext.codigo|| '",'   || 
	 '"codDiagnosticoPrincipal": ' || '"'  ||dxppal.cie10|| '",'   || 
		  '"codDiagnosticoPrincipalE": ' || '"'  ||dxppale.cie10|| '",'    ||

	'"codDiagnosticoRelacionadoE1": ' || '"'  ||coalesce(dxrel1.cie10,'null')|| '",'  ||

		 '"codDiagnosticoRelacionadoE2": ' || '"'  ||coalesce(dxrel2.cie10,'null')|| '",'  ||
	'"codDiagnosticoRelacionadoE3": ' || '"'  ||coalesce(dxrel3.cie10,'null')|| '",'  ||
	'"codComplicacion": ' || '"'  ||'null'|| '",'  ||
		 '"condicionDestinoUsuarioEgreso": ' || '"'  ||cauext.codigo|| '",'   || 
		'"codDiagnosticoMuerte": ' || '"'  ||'null'|| '",'  ||
		 '"fechaEgreso": ' || '"'  ||hosp."fechaEgreso"|| '",'   || 
	'"consecutivo": ' || '"'  ||hosp.consecutivo|| '",'   || 
'}]}'
from rips_ripstransaccion
	left join rips_ripshospitalizacion hosp on (hosp."ripsTransaccion_id" = rips_ripstransaccion.id)
	left join rips_ripscausaexterna cauext on (cauext.id =hosp."causaMotivoAtencion_id" )
	left join clinico_diagnosticos dxppal on (dxppal.id =hosp."codDiagnosticoPrincipal_id")
	left join clinico_diagnosticos dxppale on (dxppale.id =hosp."codDiagnosticoPrincipalE_id")
	left join clinico_diagnosticos dxrel1 on (dxrel1.id = hosp."codDiagnosticoRelacionadoE1_id")
	left join clinico_diagnosticos dxrel2 on (dxrel2.id =  hosp."codDiagnosticoRelacionadoE2_id")
	left join clinico_diagnosticos dxrel3 on (dxrel3.id =  hosp."codDiagnosticoRelacionadoE3_id")
	left join rips_ripsDestinoEgreso egreso on (egreso.id = hosp."condicionDestinoUsuarioEgreso_id" )
where  rips_ripstransaccion."ripsEnvio_id" = 31 and   rips_ripstransaccion."numFactura" =cast ('41' as text)

	

	
-- Urgencias

	select * from rips_ripsprocedimientos;
select * from rips_ripshospitalizacion;
select * from rips_ripscausaexterna;
select * from rips_ripstransaccion;
select * from rips_ripscausaexterna;
select * from clinico_diagnosticos;
select * from clinico_historia;
select * from rips_ripsurgenciasobservacion;

select count(*) from rips_ripstransaccion ripstra, rips_ripsurgenciasobservacion urg where ripstra."ripsEnvio_id" = 31 and ripstra."numFactura" =cast('41' as text ) and urg."ripsTransaccion_id" = ripstra.id
		   
SELECT '{"urgencias": [{"codPrestador": ' ||  '"' || urg."codPrestador"|| '",'  ||
	   	    '"fechaInicioAtencion": ' || '"'  ||urg."fechaInicioAtencion"|| '",'  || 	
	 '"causaMotivoAtencion": ' || '"'  ||cauext.codigo|| '",'   || 
	 '"codDiagnosticoPrincipal": ' || '"'  ||dxppal.cie10|| '",'   || 
		  '"codDiagnosticoPrincipalE": ' || '"'  ||dxppale.cie10|| '",'    ||
	
	'"codDiagnosticoRelacionadoE1": ' || '"'  ||coalesce(dxrel1.cie10,'null')|| '",'  ||
		 '"codDiagnosticoRelacionadoE2": ' || '"'  ||coalesce(dxrel2.cie10,'null')|| '",'  ||
	'"codDiagnosticoRelacionadoE3": ' || '"'  ||coalesce(dxrel3.cie10,'null')|| '",'  ||
		 '"condicionDestinoUsuarioEgreso": ' || '"'  ||cauext.codigo|| '",'   || 
		'"codDiagnosticoCausaMuerte": ' || '"'  ||'null'|| '",'  ||

		 '"fechaEgreso": ' || '"'  ||urg."fechaEgreso"|| '",'   || 
	'"consecutivo": ' || '"'  ||urg.consecutivo|| '",'   || 
'}]}'
from rips_ripstransaccion
	left join rips_ripsurgenciasobservacion urg on (urg."ripsTransaccion_id" = rips_ripstransaccion.id)
	left join rips_ripscausaexterna cauext on (cauext.id =urg."causaMotivoAtencion_id" )
	left join clinico_diagnosticos dxppal on (dxppal.id =urg."codDiagnosticoPrincipal_id")
	left join clinico_diagnosticos dxppale on (dxppale.id =urg."codDiagnosticoPrincipalE_id")
	left join clinico_diagnosticos dxrel1 on (dxrel1.id = urg."codDiagnosticoRelacionadoE1_id")
	left join clinico_diagnosticos dxrel2 on (dxrel2.id =  urg."codDiagnosticoRelacionadoE2_id")
	left join clinico_diagnosticos dxrel3 on (dxrel3.id =  urg."codDiagnosticoRelacionadoE3_id")
	left join rips_ripsDestinoEgreso egreso on (egreso.id = urg."condicionDestinoUsuarioEgreso_id" )
where  rips_ripstransaccion."ripsEnvio_id" = 31 and   rips_ripstransaccion."numFactura" =cast ('41' as text)



select * from rips_ripsprocedimientos;
select * from rips_ripshospitalizacion;
select * from rips_ripscausaexterna;
select * from rips_ripstransaccion;
select * from rips_ripscausaexterna;
select * from clinico_diagnosticos;
select * from clinico_historia;
select * from rips_ripsurgenciasobservacion;
select * from rips_ripsmedicamentos;
select * from autorizaciones_autorizaciones;
select * from rips_ripsenvios;
select * from facturacion_facturaciondetalle;
select * from clinico_historiaexamenes;
select * from rips_ripsdetalle;
select * from clinico_historiamedicamentos;
select * from rips_ripsmedicamentos;
select * from rips_ripstipomedicamento;
select * from clinico_medicamentos;
select * from facturacion_suministros;  --3494
select * from facturacion_suministros where id = 3494;
select * from rips_ripscums;
select * from rips_ripscums where cum= '10815-6'
	select * from rips_ripscums where id=1240;
select * from rips_ripsumm;
select * from rips_RipsFormaFarmaceutica;
select * from rips_ripsunidadupr;
select * from clinico_historia;
select * from planta_planta;
select * from rips_ripstiposdocumento;
select * from usuarios_tiposdocumento;
select * from rips_ripstipospagomoderador;
select * from cartera_pagos;
select * from cartera_tipospagos;
select * from cartera_formaspagos;
 

select * from rips_ripsmedicamentos;	
select * from rips_ripstransaccion;
select * from cartera_tiposnotas;
select * from rips_ripstiposnotas;
select * from clinico_historialdiagnosticos;
select * from clinico_diagnosticos;
select * from sitios_sedesclinica;
select * from autorizaciones_autorizaciones;
select * from clinico_historiaexamenes;
select * from clinico_historiamedicamentos;
select * from rips_ripstipos;
select * from rips_ripstiposnotas;
select * from rips_ripsenvios;
update  rips_ripsenvios set "ripsTiposNotas_id" = 4;
select * from rips_ripstipos;
update clinico_historiamedicamentos set "cantidadAplicada" = 2
tipoNota = GLOSA, FACTURA, NOTA CREDITO, NOTA DEBITO
	select * from rips_ripsmedicamentos;
select * from facturacion_suministros where id = 16294; -- "19491-5"   16294 va con el 42/3494 va con el 40

select * from facturacion_facturaciondetalle;
select * from rips_ripsenvios;
select * from rips_ripsdetalle; -- envio 31 / factura 41
delete from rips_ripsdetalle where id=48;
select * from rips_ripstransaccion;
select * from contratacion_convenios;
select * from facturacion_empresas;
select * from facturacion_facturaciondetalle where facturacion_id =42
select * from cartera_pagos where documento_id=16
	update facturacion_facturacion set "ripsEnvio_id" =33 where id=42

select * from facturacion_facturaciondetalle facdet where CASE WHEN trim(cast(facdet."cums_id" as text)) is null THEN 0 ELSE facdet."cums_id"  END > 0
select * from facturacion_facturaciondetalle facdet where facturacion_id = 42 and facdet."cums_id"  is not null --campo cums --> ripscums
select * from rips_ripscums where id = 16294;	 -- "CLOTRIMAZOL SOLUCION 1%"
select * from rips_ripscums where id = 40;	 -- "CLOTRIMAZOL SOLUCION 1%"
select * from facturacion_suministros where id = 16294;  -- "ABACAVIR 300 MG TABLETAS" ops spon diferetnmtes ÑUQUISIMAS PAPABEROL
select * from facturacion_suministros where id = 635 --  "CODEIDOL" estap loquisisimo  // ojoo  mañana arreglAR EL APUNTADOR DE CUMS  A RIPSCUM Y FACTURACIONDETALLE DEBE APUNTAR A
													-- FACTURACION_SUMINISTROS
										-- REVIZAR PROCESO DESDE QUE SE CARGA EL MEDICAMENTO.. GISTORIALMEDICAMENTOS ETC.
									-- CUANDO SE LIQUIDADETALLE / Y SE FACTURADETALLE 
	

select * from rips_ripstransaccion;

-- Medicamentos
	 

insert into rips_ripstransaccion ("numDocumentoIdObligado", "numNota", "fechaRegistro", "tipoNota_id", "usuarioRegistro_id", "ripsEnvio_id", "sedesClinica_id", "numFactura")
	values ('830507718-8',0,now(),null,1,33,1,42)
select * from facturacion_facturacion;	
select * from clinico_historia;
	
select * from rips_ripstipos;

-- EL INSERT
INSERT INTO rips_ripsmedicamentos ("codPrestador", "numAutorizacion", "idMIPRES", "fechaDispensAdmon", "nomTecnologiaSalud", "concentracionMedicamento", "cantidadMedicamento", 
	"diasTratamiento",	"numDocumentoIdentificacion", "vrUnitMedicamento", "vrServicio", "valorPagoModerador", "numFEVPagoModerador", consecutivo, "fechaRegistro", "codDiagnosticoPrincipal_id",
	"codDiagnosticoRelacionado_id", "codTecnologiaSalud_id", "conceptoRecaudo_id", "formaFarmaceutica_id", "tipoDocumentoIdentificacion_id", "tipoMedicamento_id", 
	"unidadMedida_id", "unidadMinDispensa_id", "usuarioRegistro_id", "ripsDetalle_id", "itemFactura", "ripsTipos_id", "ripsTransaccion_id")

	SELECT  sed."codigoHabilitacion", aut."numeroAutorizacion", historia.mipres,cast(facdet.fecha  as timestamp),ripscums.cum,   histmed."concentracionMedicamento" , 
	histmed."cantidadAplicada", histmed."diasTratamiento",
	planta.documento,facdet."valorUnitario", facdet."valorTotal", pagos."totalAplicado", fac.id,row_number() OVER(ORDER BY histmed.id), now(),diag1.id, 
	diag2.id,null,null,ripsfarma.id,ripstipdoc.id,tipmed.id,
	ripsumm.id, ripsupr.id,'1',det.id,facdet."consecutivoFactura", 8,rips_ripstransaccion.id
from rips_ripstransaccion
	left join rips_ripsenvios  env on (env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" )
	left join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id" )
	left join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric))
	left join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" )
	inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null )
	left join clinico_historiamedicamentos histmed on (histmed.id = facdet."historiaMedicamento_id") 
	left join autorizaciones_autorizaciones aut on (aut.id = histmed.autorizacion_id)
	left join facturacion_suministros sum  on (sum.id = facdet.cums_id)
	left join rips_ripstipomedicamento tipmed on (tipmed.id =sum."ripsTipoMedicamento_id" )
	left join rips_ripscums ripscums on (ripscums.id = facdet."cums_id")	
	left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id")	
	left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id")	
	left join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id")	
	left join clinico_historia historia on (historia.id = histmed.historia_id)	
	left join planta_planta planta on (planta.id = historia.planta_id)	
	left join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id")	
	left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = usutipdoc."tipoDocRips_id")	
	left join cartera_pagos pagos on (pagos."tipoDoc_id" =  fac."tipoDoc_id"  and pagos.documento_id = fac.documento_id and pagos.consec = fac."consecAdmision")	
	left join cartera_formaspagos formaspagos on (formaspagos.id = pagos."formaPago_id")		
	left join rips_ripstipospagomoderador ripstipopago on (cast(ripstipopago."codigoAplicativo" as numeric) = formaspagos.id and cast(ripstipopago."codigoAplicativo" as numeric) in ('3','4') )	
	left join clinico_historialdiagnosticos histdiag1 on (histdiag1.historia_id = historia.id and  histdiag1."tiposDiagnostico_id" = 1)	
	left join clinico_historialdiagnosticos histdiag2 on (histdiag2.historia_id = historia.id and  histdiag2."tiposDiagnostico_id" = 2)	
	left join clinico_diagnosticos diag1 on (diag1.id = histdiag1.diagnosticos_id)	
	left join clinico_diagnosticos diag2 on (diag2.id = histdiag2.diagnosticos_id)	
	where  env.id = '33' and rips_ripstransaccion."ripsEnvio_id" = env.id  and cast(rips_ripstransaccion."numFactura" as numeric) = fac.id

 detalle ='INSERT INTO rips_ripsmedicamentos ("codPrestador", "numAutorizacion", "idMIPRES", "fechaDispensAdmon", "nomTecnologiaSalud", "concentracionMedicamento", "cantidadMedicamento", 	"diasTratamiento",	"numDocumentoIdentificacion", "vrUnitMedicamento", "vrServicio", "valorPagoModerador", "numFEVPagoModerador", consecutivo, "fechaRegistro", "codDiagnosticoPrincipal_id",
	"codDiagnosticoRelacionado_id", "codTecnologiaSalud_id", "conceptoRecaudo_id", "formaFarmaceutica_id", "tipoDocumentoIdentificacion_id", "tipoMedicamento_id", "unidadMedida_id", "unidadMinDispensa_id", "usuarioRegistro_id", "ripsDetalle_id", "itemFactura", "ripsTipos_id", "ripsTransaccion_id") SELECT  sed."codigoHabilitacion", aut."numeroAutorizacion", historia.mipres,cast(facdet.fecha  as timestamp),ripscums.cum,   histmed."concentracionMedicamento" , histmed."cantidadAplicada", histmed."diasTratamiento",
	planta.documento,facdet."valorUnitario", facdet."valorTotal", pagos."totalAplicado", fac.id,row_number() OVER(ORDER BY histmed.id), now(),diag1.id, diag2.id,null,null,ripsfarma.id,ripstipdoc.id,tipmed.id,
	ripsumm.id, ripsupr.id,'1',det.id,facdet."consecutivoFactura", 8,rips_ripstransaccion.id from rips_ripstransaccion left join rips_ripsenvios  env on (env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" )
	left join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id" ) left join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric))
	left join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" ) inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null )
	left join clinico_historiamedicamentos histmed on (histmed.id = facdet."historiaMedicamento_id")  left join autorizaciones_autorizaciones aut on (aut.id = histmed.autorizacion_id)
	left join facturacion_suministros sum  on (sum.id = facdet.cums_id) left join rips_ripstipomedicamento tipmed on (tipmed.id =sum."ripsTipoMedicamento_id" )
	left join rips_ripscums ripscums on (ripscums.id = facdet."cums_id") left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id")	
	left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id")	 left join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id")	
	left join clinico_historia historia on (historia.id = histmed.historia_id)	left join planta_planta planta on (planta.id = historia.planta_id)	
	left join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id") left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = usutipdoc."tipoDocRips_id")	
	left join cartera_pagos pagos on (pagos."tipoDoc_id" =  fac."tipoDoc_id"  and pagos.documento_id = fac.documento_id and pagos.consec = fac."consecAdmision")	
	left join cartera_formaspagos formaspagos on (formaspagos.id = pagos."formaPago_id") left join rips_ripstipospagomoderador ripstipopago on (cast(ripstipopago."codigoAplicativo" as numeric) = formaspagos.id and cast(ripstipopago."codigoAplicativo" as numeric) in (' + "'" + str('3') + "'" +  ' , ' + "'" + str('4') + "'" + ' )	
	left join clinico_historialdiagnosticos histdiag1 on (histdiag1.historia_id = historia.id and  histdiag1."tiposDiagnostico_id" = ' + "'"  + str('1') + "'" + ' left join clinico_historialdiagnosticos histdiag2 on (histdiag2.historia_id = historia.id and  histdiag2."tiposDiagnostico_id" = ' + "'" + str('2') + "'" + ')	
	left join clinico_diagnosticos diag1 on (diag1.id = histdiag1.diagnosticos_id)	left join clinico_diagnosticos diag2 on (diag2.id = histdiag2.diagnosticos_id)	
	where  env.id = ' + "'" + str(str(envioRipsId)) + "'" + '' and rips_ripstransaccion."ripsEnvio_id" = env.id  and cast(rips_ripstransaccion."numFactura" as numeric) = fac.id	'	
	
-- EL RIPS COMO TAL

select * from rips_ripsmedicamentos;	



SELECT
	
	'{"medicamentos": [{"codPrestador": ' ||  '"' ||med."codPrestador"|| '",'   ||
		
	   	    '"numAutorizacion": ' || '"'  ||CASE WHEN trim(med."numAutorizacion") is null THEN 'null' ELSE med."numAutorizacion"  END|| '",'   || 	
	 	  '"idMIPRES": ' || '"'   ||CASE WHEN trim(med."idMIPRES") is null THEN 'null' ELSE med."idMIPRES"  END|| '",'  || 	
		  '"fechaDispensAdmon": ' || '"'  ||'null'|| '",'     || 	

	  '"codDiagnosticoPrincipal": ' || '"'  ||CASE WHEN trim(diag1.cie10) is null THEN 'null' ELSE diag1.cie10  END|| '",'  || 	
	'"codDiagnosticoRelacionado": ' || '"'  ||CASE WHEN trim(diag2.cie10) is null THEN 'null' ELSE diag2.cie10  END|| '",' 	  || 	
	 
	'"tipoMedicamento": ' || '"'  ||CASE WHEN trim(tipmed.codigo) is null THEN 'null' ELSE tipmed.codigo  END|| '",'   || 	

	'"codTecnologiaSalud": ' || '"'  ||  CASE WHEN trim(ripscums.cum) is null THEN 'null' ELSE ripscums.cum  END           || '",'  || 	
	'"nomTecnologiaSalud": ' || '"'  ||   CASE WHEN trim(med."nomTecnologiaSalud") is null THEN 'null' ELSE med."nomTecnologiaSalud"  END               || '",'  || 	
	'"concentracionMedicamento": ' || '"'  || CASE WHEN trim(med."concentracionMedicamento") is null THEN 'null' ELSE med."concentracionMedicamento"  END  || '",'    || 	
	
	'"unidadMedida": ' || '"'  ||CASE WHEN trim(ripsumm.codigo) is null THEN 'null' ELSE ripsumm.codigo  END           || '",'  || 	
	'"formaFarmaceutica": ' || '"'  ||  CASE WHEN trim(ripsfarma.codigo) is null THEN 'null' ELSE ripsfarma.codigo  END  || '",'  || 	
'"unidadMinDispensa": ' || '"'  ||  CASE WHEN trim(ripsupr.codigo) is null THEN 'null' ELSE ripsupr.codigo  END           || '",'  || 	
	'"cantidadMedicamento": ' || '"'  || CASE WHEN trim(cast( med."cantidadMedicamento"  as text)) is null THEN 0 ELSE  med."cantidadMedicamento"   END      || '",'   /* || 	
	'"diasTratamiento": ' || '"'  ||   CASE WHEN trim(cast( med."diasTratamiento"  as text)) is null THEN 0 ELSE med."diasTratamiento"  END  || '",'  */ || 	
	
	'"tipoDocumentoldentificacion": ' || '"'  || CASE WHEN trim(ripstipdoc.codigo) is null THEN 'null' ELSE ripstipdoc.codigo  END   || '",'  || 	
	'"numDocumentoIdentificacion": ' || '"'  || CASE WHEN trim(med."numDocumentoIdentificacion") is null THEN 'null' ELSE med."numDocumentoIdentificacion"  END     || '",'  || 	
		'"vrUnitMedicamento": ' || '"'  ||  med."vrUnitMedicamento" || '",'  || 	
		'"vrServicio": ' || '"'  ||med."vrServicio"|| '",'  || 	
		'"tipoPagoModerador": ' || '"'  ||  CASE WHEN trim( ripstipopago.codigo) is null THEN 'null' ELSE  ripstipopago.codigo  END || '",'  || 	
		'"valorPagoModerador": ' || '"'  ||  med."valorPagoModerador"|| '",'  || 	
	
	'"numFEVPagoModerador": ' || '"'  ||med."numFEVPagoModerador"|| '",'   || 	
	'"consecutivo": ' || '"'  ||med.consecutivo|| '",'   || 
'}]}' 
from rips_ripstransaccion
left join rips_ripsenvios  env on (env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" )
	left join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = rips_ripstransaccion.id)
	left join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id" )
	left join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric))
	left join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" )
	inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null )
	left join clinico_historiamedicamentos histmed on (histmed.id = facdet."historiaMedicamento_id") 
	left join autorizaciones_autorizaciones aut on (aut.id = histmed.autorizacion_id)
	left join facturacion_suministros sum  on (sum.id = facdet.cums_id)
	left join rips_ripstipomedicamento tipmed on (tipmed.id =sum."ripsTipoMedicamento_id" )
	left join rips_ripscums ripscums on (ripscums.id = facdet."cums_id")	
	left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id")	
	left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id")	
	left join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id")	
	left join clinico_historia historia on (historia.id = histmed.historia_id)	
	left join planta_planta planta on (planta.id = historia.planta_id)	
	left join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id")	
	left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = usutipdoc."tipoDocRips_id")	
	left join cartera_pagos pagos on (pagos."tipoDoc_id" =  fac."tipoDoc_id"  and pagos.documento_id = fac.documento_id and pagos.consec = fac."consecAdmision")	
	left join cartera_formaspagos formaspagos on (formaspagos.id = pagos."formaPago_id")		
	left join rips_ripstipospagomoderador ripstipopago on (cast(ripstipopago."codigoAplicativo" as numeric) = formaspagos.id and cast(ripstipopago."codigoAplicativo" as numeric) in ('3','4') )	
	left join clinico_historialdiagnosticos histdiag1 on (histdiag1.historia_id = historia.id and  histdiag1."tiposDiagnostico_id" = 1)	
	left join clinico_historialdiagnosticos histdiag2 on (histdiag2.historia_id = historia.id and  histdiag2."tiposDiagnostico_id" = 2)	
	left join clinico_diagnosticos diag1 on (diag1.id = histdiag1.diagnosticos_id)	
	left join clinico_diagnosticos diag2 on (diag2.id = histdiag2.diagnosticos_id)	
where rips_ripstransaccion."ripsEnvio_id" =33 and rips_ripstransaccion."ripsEnvio_id" = env.id  and cast(rips_ripstransaccion."numFactura" as numeric) = fac.id	 


