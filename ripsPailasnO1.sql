select * from usuarios_usuarios;
select * from facturacion_facturacion where documento_id='37'
select * from facturacion_liquidacion where documento_id='37'

select * from admisiones_ingresos where documento_id='37'
select * from facturacion_facturaciondetalle where facturacion_id =138
select * from clinico_historiamedicamentos;
select * from rips_ripshospitalizacion;

select "requiereAutorizacion",* from clinico_examenes 
update facturacion_facturaciondetalle set cantidad = 1,anulado='N' where id=385

select * from autorizaciones_autorizaciones
select * from autorizaciones_autorizacionesdetalle

select * from rips_ripstransaccion order by id desc
select * from rips_ripsusuarios where "ripsTransaccion_id" = 270
select * from rips_ripshospitalizacion where "ripsTransaccion_id" = 270
select * from rips_ripsurgenciasobservacion where "ripsTransaccion_id" = 270
select * from rips_ripsprocedimientos where "ripsTransaccion_id" = 270
select * from rips_ripsmedicamentos where "ripsTransaccion_id" = 270

INSERT INTO rips_ripsprocedimientos ("codPrestador", "fechaInicioAtencion", "idMIPRES", "numAutorizacion","numDocumentoIdentificacion",
	"vrServicio",	"valorPagoModerador", "numFEVPagoModerador", consecutivo, "fechaRegistro", "codComplicacion_id", 
	"codDiagnosticoPrincipal_id","codDiagnosticoRelacionado_id", "codProcedimiento_id", "codServicio_id", 
	"conceptoRecaudo_id", "finalidadTecnologiaSalud_id",	"grupoServicios_id", "modalidadGrupoServicioTecSal_id",
	"tipoDocumentoIdentificacion_id","usuarioRegistro_id", "viaIngresoServicioSalud_id", "ripsDetalle_id", "itemFactura",
	"ripsTipos_id", "tipoPagoModerador_id", "ripsTransaccion_id", "estadoReg", ingreso_id )  
	
SELECT sed."codigoHabilitacion", facdet."fecha", his.mipres, autdet."numeroAutorizacion", usu.documento,
	facdet."valorTotal", ' + str(proRata) + ', fac.id, row_number()  OVER(ORDER BY facdet.id) +1 AS consecutivo, now(), 
	(select max(diag4.id) from clinico_diagnosticos diag4 where  diag4.id = i."dxComplicacion_id"),
	(select  max(diag1.id) from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 
	where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '1'), 
	(select max(diag3.id) from clinico_historialdiagnosticos histdiag3, clinico_diagnosticos diag3 where histdiag3.historia_id = his.id 
	and histdiag3."tiposDiagnostico_id" = '2'), exa.id, serv.id,'5'  , final.id, gru.id, mod.id, tipdocrips.id, '1', ingreso.id,
	detrips.id, facdet."consecutivoFactura", '4', (select max(ripsmoderadora.id) from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and pagos."formaPago_id" = formapago.id and
	ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), '270','A','50339'
FROM sitios_sedesclinica sed inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id) 
inner join facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R' and "tipoRegistro" = 'SISTEMA'))
inner join clinico_examenes exa ON (exa.id = facdet."examen_id") 
inner join admisiones_ingresos i on (i.factura = fac.id and i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision")
left join rips_ripsviasingresosalud ingreso ON (ingreso.id = i."ripsViaIngresoServicioSalud_id")
inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) 
inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) 
left join rips_ripsmodalidadatencion mod ON (mod.id = i."ripsmodalidadGrupoServicioTecSal_id") 
left join  rips_ripsgruposervicios gru ON (gru.id = i."ripsGrupoServicios_id")    
left join rips_ripsServicios serv ON (serv.id = i."ripsGrupoServicios_id") 
left join  rips_ripsfinalidadconsulta final on (final.id = i."ripsFinalidadConsulta_id") 
inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) 
left join  rips_ripstiposdocumento tipdocrips on (tipdocrips.id = tipdoc."tipoDocRips_id" ) 
inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id ) 
inner join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec )
inner join clinico_historiaexamenes hisexa ON (hisexa.historia_id = his.id and hisexa."codigoCups" = exa."codigoCups" and hisexa."consecutivoLiquidacion" = facdet."consecutivoFactura"  )
left join autorizaciones_autorizaciones  aut on (aut.historia_id = his.id) 
left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id)
where sed.id = ' 1' and e.id = '63' and fac.id = '138'


