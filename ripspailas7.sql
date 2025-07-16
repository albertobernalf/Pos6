select * from rips_ripsdetalle;
select * from rips_ripsenvios;

select * from autorizaciones_autorizaciones;
select * from autorizaciones_autorizacionesdetalle;

select * from facturacion_liquidaciondetalle;

select * from clinico_historia;

select * from clinico_tiposExamen;

select * from clinico_historiamedicamentos;

select * from rips_ripstransaccion;
select * from rips_ripsusuarios;
select * from rips_ripsprocedimientos;
select * from rips_ripshospitalizacion;
select * from rips_ripsmedicamentos;
select * from rips_ripsenvios;
select * from rips_ripstipos;
select * from cartera_tiposnotas;
select * from cartera_tiposglosas;
select * from clinico_historialincapacidades;


INSERT INTO rips_ripsusuarios("tipoDocumentoIdentificacion", "tipoUsuario", "fechaNacimiento", "codSexo", "codZonaTerritorialResidencia", incapacidad, consecutivo, "fechaRegistro", "codMunicipioResidencia_id", "codPaisOrigen_id", "codPaisResidencia_id", "usuarioRegistro_id", "numDocumentoIdentificacion", "ripsDetalle_id", "ripsTransaccion_id")
	
	select tipdoc.abreviatura, tipousu.codigo, u."fechaNacio" , u.genero, local.id, 
	(select case when inca.id is not null  then 'SI' else 'NO' end incap
	 from clinico_historia hist, clinico_historialincapacidades inca
	 where hist."tipoDoc_id" = fac."tipoDoc_id"  and hist.documento_id = fac.documento_id  and hist."consecAdmision" = fac."consecAdmision"  and 
      hist.id = inca.historia_id) 	 ,
	 row_number() OVER(ORDER BY det.id) AS consecutivo, now(), muni.id, pais.id, pais.id, '1',
	u.documento, det.id, 'xxx ' 
	from rips_ripsenvios e, rips_ripsdetalle det, usuarios_tiposdocumento tipdoc, usuarios_usuarios u, sitios_paises  pais, sitios_municipios muni, sitios_localidades local,
	facturacion_facturacion fac, rips_ripstipousuario tipousu, admisiones_ingresos i 
	where i.factura = fac.id and e.id = 31 and e.id=det."ripsEnvios_id" and det."numeroFactura_id" = fac.id and 
	fac."tipoDoc_id" = u."tipoDoc_id" and fac.documento_id = u.id and fac."tipoDoc_id" = tipdoc.id and u.pais_id = pais.id and u.municipio_id = muni.id and
	u.localidad_id = local.id and tipousu.id = i."ripsTipoUsuario_id"
-- ingresar el case de la INCAPACIDDA
	
-- Rips de procedimientos
	select * from rips_ripsprocedimientos;
select * from autorizaciones_autorizaciones;
select * from autorizaciones_autorizacionesdetalle;
select * from clinico_historia;
select * from clinico_historiaExamenes;


INSERT INTO rips_ripsprocedimientos ( "codPrestador", "fechaInicioAtencion", "idMIPRES", "numAutorizacion","numDocumentoIdentificacion", "vrServicio", "valorPagoModerador", 
	"numFEVPagoModerador", consecutivo, "fechaRegistro", "codComplicacion_id", "codDiagnosticoPrincipal_id", "codDiagnosticoRelacionado_id", "codProcedimiento_id",
	"codServicio_id", "conceptoRecaudo_id", "finalidadTecnologiaSalud_id", "grupoServicios_id", "modalidadGrupoServicioTecSal_id", "tipoDocumentoIdentificacion_id", 
	"usuarioRegistro_id",  "viaIngresoServicioSalud_id", "ripsDetalle_id", "itemFactura", "ripsTipos_id", "tipoPagoModerador_id", "ripsTransaccion_id") 
	
	SELECT sed."codigoHabilitacion", facdet."fecha", his.mipres,autdet."numeroAutorizacion" ,usu.documento, facdet."valorTotal",
	(select pagos.valor from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora 
	where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and pagos."formaPago_id" = formapago.id and 
	ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)),
	fac.id, row_number() OVER(ORDER BY facdet.id) AS consecutivo, now(), 
	(select diag4.id from  clinico_diagnosticos diag4 where diag4.id = i."dxComplicacion_id"), 
	(select diag1.id from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 where histdiag1.historia_id = histdiag.historia_id and histdiag1."tiposDiagnostico_id" = 2),
	(select diag3.id from clinico_historialdiagnosticos histdiag3, clinico_diagnosticos diag3 where histdiag3.historia_id = histdiag.historia_id and histdiag3."tiposDiagnostico_id" = 3), 
	exa.id, serv.id, null, final.id, gru.id, mod.id, tipdocrips.id, '1', ingreso.id, detrips.id,
	facdet."consecutivoFactura", '4' ,
	(select ripsmoderadora.id from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora where  i."tipoDoc_id" =  pagos."tipoDoc_id" and 
	i.documento_id = pagos.documento_id and i.consec = pagos.consec and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text))  ,
	 65
	FROM sitios_sedesclinica sed
	inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)
	inner join  facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null  )
	inner join clinico_examenes exa ON (exa.id = facdet."examen_id")
	inner join admisiones_ingresos i on (i.factura = fac.id and i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision")
	left join rips_ripsviasingresosalud ingreso ON (ingreso.id = i."ripsViaIngresoServicioSalud_id")
	left join rips_ripsenvios e ON (e."sedesClinica_id" =  sed.id)
	left join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id)
	left join rips_ripsmodalidadatencion mod ON ( mod.id = i."ripsmodalidadGrupoServicioTecSal_id"  )
	left join rips_ripsgruposervicios gru ON (gru.id = i."ripsGrupoServicios_id") 
	left join rips_ripsServicios serv ON (serv.id = i."ripsGrupoServicios_id")
	left join rips_ripsfinalidadconsulta final on (final.id = i."ripsFinalidadConsulta_id")
	left join rips_ripstiposdocumento tipdocrips on (1=1)
	left join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" and tipdoc."tipoDocRips_id" = tipdocrips.id)
	left join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id  =  fac.documento_id )
	inner join clinico_historia his ON (his."tipoDoc_id" =  i."tipoDoc_id" and  his.documento_id = i.documento_id and his."consecAdmision" = i.consec )
   left join clinico_historialdiagnosticos histdiag on (histdiag.historia_id = his.id  and histdiag."tiposDiagnostico_id" = 1 )
	left join autorizaciones_autorizaciones aut  on (aut.historia_id =his.id)
	inner join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id)
	where sed.id = 1 and e.id >= 25



	
select * from admisiones_ingresos;	
	- 1er cambio codigocupa_id a examen

		select 

-- tipopagomoderador_id ??
-- conceptorecaudo_id ??
-- vlr pago moderado
select * from rips_ripsenvios;

select * from rips_ripshospitalizacion;

INSERT INTO rips_ripshospitalizacion (  "codPrestador","viaIngresoServicioSalud_id","fechaInicioAtencion", "numAutorizacion","causaMotivoAtencion_id","codComplicacion_id", "codDiagnosticoPrincipal_id", "codDiagnosticoPrincipalE_id",  "codDiagnosticoRelacionadoE1_id", "codDiagnosticoRelacionadoE2_id",
	"codDiagnosticoRelacionadoE3_id","condicionDestinoUsuarioEgreso_id", "codDiagnosticoCausaMuerte_id","fechaEgreso",  consecutivo, "usuarioRegistro_id",
	"ripsDetalle_id", "tipoRips", "ripsTransaccion_id",  "fechaRegistro")
	SELECT sed."codigoHabilitacion",i."ripsViaIngresoServicioSalud_id", cast(i."fechaIngreso" as date),aut."numeroAutorizacion" , i."ripsCausaMotivoAtencion_id", 
    (select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxComplicacion_id"),
	(select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxIngreso_id"), 
	(select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxSalida_id"),
	(select diag1.id from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = 2 and histdiag1.diagnosticos_id = diag1.id),
	(select diag1.id from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = 3 and histdiag1.diagnosticos_id = diag1.id),
	(select diag1.id from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = 4 and histdiag1.diagnosticos_id = diag1.id), 
 i."ripsCondicionDestinoUsuarioEgreso_id", null,  cast(i."fechaSalida" as date), row_number() OVER(ORDER BY i.id) AS consecutivo ,'1' ,det.id,env."ripsEstados_id",
	ripstra.id,now()  
	FROM sitios_sedesclinica sed
	inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)
	inner join clinico_historia his ON (his."tipoDoc_id" = fac."tipoDoc_id" and his.documento_id = fac.documento_id AND his."consecAdmision" = fac."consecAdmision")
	inner join admisiones_ingresos i ON (i."sedesClinica_id" = sed.id and i."tipoDoc_id" = his."tipoDoc_id" and i.documento_id = his.documento_id AND i.consec = his."consecAdmision")
	inner join rips_ripsenvios env ON (env."sedesClinica_id" = sed.id)
	inner join rips_ripsdetalle det ON ( det."ripsEnvios_id" = env.id )
	inner join rips_ripstransaccion ripstra ON ( ripstra."sedesClinica_id" = sed.id and ripstra."ripsEnvio_id" = env.id and ripstra."numFactura" = cast(fac.id as text))
	left join autorizaciones_autorizaciones aut  on (aut.id = i.autorizaciones_id)
	where sed.id = 1 AND env.id =31 AND i.factura = det."numeroFactura_id" 


detalle = 'INSERT INTO rips_ripshospitalizacion (  "codPrestador","viaIngresoServicioSalud_id","fechaInicioAtencion", "numAutorizacion","causaMotivoAtencion_id","codComplicacion_id", "codDiagnosticoPrincipal_id", "codDiagnosticoPrincipalE_id",  "codDiagnosticoRelacionadoE1_id", "codDiagnosticoRelacionadoE2_id",	"codDiagnosticoRelacionadoE3_id","condicionDestinoUsuarioEgreso_id", "codDiagnosticoCausaMuerte_id","fechaEgreso",  consecutivo, "usuarioRegistro_id",	"ripsDetalle_id", "tipoRips", "ripsTransaccion_id",  "fechaRegistro") SELECT sed."codigoHabilitacion",i."ripsViaIngresoServicioSalud_id", cast(i."fechaIngreso" as date),aut."numeroAutorizacion" , i."ripsCausaMotivoAtencion_id", (select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxComplicacion_id"), (select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxIngreso_id"), (select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxSalida_id"), 	(select diag1.id from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = 2 and histdiag1.diagnosticos_id = diag1.id), 	(select diag1.id from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = 3 and histdiag1.diagnosticos_id = diag1.id), 	(select diag1.id from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = 4 and histdiag1.diagnosticos_id = diag1.id),  i."ripsCondicionDestinoUsuarioEgreso_id", null,  cast(i."fechaSalida" as date), row_number() OVER(ORDER BY i.id) AS consecutivo ,' + "'" + str('1') + "'" + ' ,det.id,env."ripsEstados_id", 	ripstra.id,now() FROM sitios_sedesclinica sed inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id) 	inner join clinico_historia his ON (his."tipoDoc_id" = fac."tipoDoc_id" and his.documento_id = fac.documento_id AND his."consecAdmision" = fac."consecAdmision") 	inner join admisiones_ingresos i ON (i."sedesClinica_id" = sed.id and i."tipoDoc_id" = his."tipoDoc_id" and i.documento_id = his.documento_id AND i.consec = his."consecAdmision") inner join rips_ripsenvios env ON (env."sedesClinica_id" = sed.id) inner join rips_ripsdetalle det ON ( det."ripsEnvios_id" = env.id ) 	inner join rips_ripstransaccion ripstra ON ( ripstra."sedesClinica_id" = sed.id and ripstra."ripsEnvio_id" = env.id and ripstra."numFactura" = cast(fac.id as text))	left join autorizaciones_autorizaciones aut  on (aut.id = i.autorizaciones_id) where sed.id = ' + "'" + str('1') + "'" + ' AND env.id = ' + "'" + str(envioRips) + "'" + ' AND i.factura = det."numeroFactura_id" '
select * from rips_ripsmedicamentos;


INSERT INTO rips_ripsmedicamentos ("codPrestador", "numAutorizacion", "idMIPRES", "fechaDispensAdmon", "nomTecnologiaSalud", "concentracionMedicamento", 
	"cantidadMedicamento", 	"diasTratamiento",	"numDocumentoIdentificacion", "vrUnitMedicamento", "vrServicio", "valorPagoModerador", "numFEVPagoModerador",
	consecutivo, "fechaRegistro", "codDiagnosticoPrincipal_id", "codDiagnosticoRelacionado_id", "codTecnologiaSalud_id", "conceptoRecaudo_id", "formaFarmaceutica_id", 
	"tipoDocumentoIdentificacion_id", "tipoMedicamento_id", "unidadMedida_id", "unidadMinDispensa_id", "usuarioRegistro_id", "ripsDetalle_id", "itemFactura",
	"ripsTipos_id", "ripsTransaccion_id")
	SELECT sed."codigoHabilitacion", aut."numeroAutorizacion", historia.mipres, cast(facdet.fecha as timestamp),
	ripscums.cum, histmed."concentracionMedicamento", histmed."cantidadAplicada", histmed."diasTratamiento",planta.documento, facdet."valorUnitario",
	facdet."valorTotal", pagos."totalAplicado", fac.id, row_number() OVER(ORDER BY histmed.id), now(), diag1.id, diag2.id, null, null, ripsfarma.id, ripstipdoc.id,
	tipmed.id, ripsumm.id, ripsupr.id, '1' , det.id, facdet."consecutivoFactura",'8', rips_ripstransaccion.id 
	from rips_ripstransaccion left join rips_ripsenvios env on(env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and 
	env.id = rips_ripstransaccion."ripsEnvio_id" ) left join sitios_sedesclinica sed on(sed.id = env."sedesClinica_id" ) 
	left join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric)) 
	left join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" ) 
	inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null ) 
	left join clinico_historiamedicamentos histmed on (histmed.id = facdet."historiaMedicamento_id")  
	left join autorizaciones_autorizaciones aut on (aut.id = histmed.autorizacion_id)
	left join facturacion_suministros sum on (sum.id = facdet.cums_id) 
	left join rips_ripstipomedicamento tipmed on (tipmed.id = sum."ripsTipoMedicamento_id" ) 
	left join rips_ripscums ripscums  on (ripscums.id = facdet."cums_id") 
	left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id") 
	left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id") 
	left join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id")
	left join clinico_historia historia on (historia.id = histmed.historia_id)
	left join planta_planta planta on (planta.id = historia.planta_id) 
	left join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id") 
	left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = usutipdoc."tipoDocRips_id")
	left join cartera_pagos pagos on (pagos."tipoDoc_id" = fac."tipoDoc_id" and pagos.documento_id = fac.documento_id and pagos.consec = fac."consecAdmision") 
	left join cartera_formaspagos formaspagos on (formaspagos.id = pagos."formaPago_id") 
	left join rips_ripstipospagomoderador ripstipopago  on(cast(ripstipopago."codigoAplicativo" as numeric) = formaspagos.id and
	cast(ripstipopago."codigoAplicativo" as numeric) in ('3','4') ) 
	left join clinico_historialdiagnosticos histdiag1 on (histdiag1.historia_id = historia.id and histdiag1."tiposDiagnostico_id" = '1' )
	left join clinico_historialdiagnosticos histdiag2 on (histdiag2.historia_id = historia.id and histdiag2."tiposDiagnostico_id" = '2') 
	left join clinico_diagnosticos diag1 on (diag1.id = histdiag1.diagnosticos_id) left join clinico_diagnosticos diag2 on (diag2.id = histdiag2.diagnosticos_id) 
	where env.id =31 and rips_ripstransaccion."ripsEnvio_id" = env.id  and
	cast(rips_ripstransaccion."numFactura" as numeric) = fac.id	


select * from facturacion_facturaciondetalle;

  	  { data: "fields.codPrestador"},
	  { data: "fields.numAutorizacion"},
	  { data: "fields.idMIPRES"},
	  { data: "fields.fechaDispensAdmon"},
	  { data: "fields.nomTecnologiaSalud"},
	  { data: "fields.concentracionMedicamento"},
	  { data: "fields.cantidadMedicamento"},
	  { data: "fields.diasTratamiento"},
	  { data: "fields.numDocumentoIdentificacion"},
	  { data: "fields.vrUnitMedicamento"},
	  { data: "fields.vrServicio"},
	  { data: "fields.valorPagoModerador"},
	  { data: "fields.numFEVPagoModerador"},
	  { data: "fields.consecutivo"},
	  { data: "fields.fechaRegistro"},
	  { data: "fields.codDiagnosticoPrincipal_id"},
	  { data: "fields.codDiagnosticoRelacionado_id"},
	  { data: "fields.codTecnologiaSalud_id"},
	  { data: "fields.conceptoRecaudo_id"},
	  { data: "fields.formaFarmaceutica_id"},
	  { data: "fields.tipoDocumentoIdentificacion_id"},
	  { data: "fields.tipoMedicamento_id"},
	  { data: "fields.unidadMedida_id"},
	  { data: "fields.unidadMinDispensa_id"},
	  { data: "fields.usuarioRegistro_id"},
	  { data: "fields.ripsDetalle_id"},
	  { data: "fields.itemFactura"},
	  { data: "fields.ripsTipos_id"},
	  { data: "fields.ripsTransaccion_id"},
	  

	"",
	""


select * from planta_planta;