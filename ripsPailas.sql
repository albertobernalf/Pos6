SELECT * FROM RIPS_RIPSENVIOS;
SELECT * FROM RIPS_RIPSdetalle;
SELECT * FROM USUARIOS_USUARIOS;
select * from facturacion_facturaciondetalle;
 
select * from sitios_sedesclinica;

SELECT * FROM CARTERA_PAGOS;
SELECT * FROM CARTERA_FORMASPAGOS;
SELECT * FROM RIPS_RIPSTIPOSNOTAS
SELECT * FROM cartera_tiposnotas;

select * from rips_ripstransaccion;
update rips_ripstransaccion set "tipoNota_id" =null;
select * from rips_ripsusuarios;
select * from rips_ripsprocedimientos;

select * from rips_ripspaises;
select * from sitios_sedesclinica;
select * from clinico_examenes;
select * from admisiones_ingresos;
select * from rips_ripsviasingresosalud;
SELECT * FROM RIPS_RIPSdetalle;
select * from rips_ripsmodalidadatencion;
select * from admisiones_ingresos;
select * from rips_ripsgruposervicios
select * from rips_ripsservicios;
select * from rips_ripsfinalidadconsulta;
update admisiones_ingresos set "ripsFinalidadConsulta_id"=1
	select * from rips_ripstiposdocumento;
select * from usuarios_tiposdocumento;
select * from usuarios_usuarios
	select * from clinico_historia

	select * from clinico_historialdiagnosticos;
select * from clinico_diagnosticos;
select * from cartera_pagos;
select * from rips_ripstipospagomoderador
	select * from cartera_formaspagos;

 select tipdoc.abreviatura, tipousu.codigo, substring(cast (u."fechaNacio" as text ),1, 19) , u.genero, local.id, 'NO', row_number() OVER(ORDER BY det.id) AS consecutivo, 
	 now(), muni.id, pais.id, pais.id,'1', u.documento, det.id, 18 
	 from rips_ripsenvios e, rips_ripsdetalle det, usuarios_tiposdocumento tipdoc, usuarios_usuarios u, sitios_paises  pais, sitios_municipios muni, sitios_localidades local,
	 facturacion_facturacion fac, rips_ripstipousuario tipousu, admisiones_ingresos i 
	 where i.factura = fac.id and e.id =16 and e.id=det."ripsEnvios_id" and det."numeroFactura_id" = fac.id and
	 fac."tipoDoc_id" = u."tipoDoc_id" and fac.documento_id = u.id and fac."tipoDoc_id" = tipdoc.id and u.pais_id = pais.id and u.municipio_id = muni.id and
	 u.localidad_id = local.id and tipousu.id = i."ripsTipoUsuario_id"

-- Query Procedimientos:

SELECT sed."codigoHabilitacion", substring(cast (facdet."fecha" as text ),1, 19), null,null,exa."codigoCups",ingreso.codigo, mod.codigo, gru.codigo, serv.codigo, 
	    final.codigo, tipdocrips.codigo,usu.documento, diag.cie10
	 , (select diag1.cie10 from  clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 
	 								where histdiag1.historia_id = histdiag.historia_id and histdiag1."tiposDiagnostico_id" = 2),
	 	  (select diag2.cie10 from  clinico_historialdiagnosticos histdiag2, clinico_diagnosticos diag2 
	 								where histdiag2.historia_id = histdiag.historia_id and histdiag2."tiposDiagnostico_id" = 3),
	  facdet."valorTotal",(select ripsmoderadora.codigo from cartera_pagos pagos, cartera_formaspagos formapago,rips_ripstipospagomoderador ripsmoderadora 
	 						where  i."tipoDoc_id" =  pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and 
								  pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)) 
	 ,(select pagos.valor from cartera_pagos pagos, cartera_formaspagos formapago,rips_ripstipospagomoderador ripsmoderadora 
	 						where  i."tipoDoc_id" =  pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and 
								  pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)) ,
	  fac.id, row_number() OVER(ORDER BY facdet.id) AS consecutivo
 
FROM sitios_sedesclinica sed , facturacion_facturacion fac, facturacion_facturaciondetalle facdet, clinico_examenes exa, admisiones_ingresos i, rips_ripsviasingresosalud ingreso,
	  rips_ripsenvios e, rips_ripsdetalle detrips, rips_ripsmodalidadatencion mod, rips_ripsgruposervicios gru, rips_ripsServicios serv, rips_ripsfinalidadconsulta final,
		rips_ripstiposdocumento tipdocrips, usuarios_tiposdocumento tipdoc, usuarios_usuarios usu, clinico_historia his, clinico_historialdiagnosticos histdiag,
	 clinico_diagnosticos diag 
where sed.id = '1' and e.id=16 and sed.id = e."sedesClinica_id" and e.id = detrips."ripsEnvios_id" and detrips."numeroFactura_id" = fac.id and   facdet.facturacion_id = fac.id and i.factura = fac.id and i."ripsViaIngresoServicioSalud_id" = ingreso.id
   and facdet."codigoCups_id" is not null and exa.id = facdet."codigoCups_id" and i."ripsmodalidadGrupoServicioTecSal_id" = mod.id and i."ripsGrupoServicios_id" = gru.id and
    serv.id = i."ripsGrupoServicios_id" and final.id = i."ripsFinalidadConsulta_id" and tipdoc.id =  fac."tipoDoc_id" and        fac."tipoDoc_id" = usu."tipoDoc_id" and fac.documento_id = usu.id and
	tipdoc."tipoDocRips_id" = tipdocrips.id 
	 and i."tipoDoc_id" =  fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision" 
	 and i."tipoDoc_id" =  his."tipoDoc_id" and i.documento_id = his.documento_id and i.consec = his."consecAdmision" and
   histdiag.historia_id = his.id and histdiag."tiposDiagnostico_id" = 1 and diag.id = histdiag.diagnosticos_id 

select * from rips_ripsprocedimientos;
select * from rips_ripstipos;

INSERT INTO rips_ripsprocedimientos ( "codPrestador", "fechaInicioAtencion", "idMIPRES", "numAutorizacion",	"numDocumentoIdentificacion", "vrServicio", "valorPagoModerador", "numFEVPagoModerador",
	consecutivo, "fechaRegistro","codComplicacion_id", "codDiagnosticoPrincipal_id", "codDiagnosticoRelacionado_id", "codProcedimiento_id", "codServicio_id","conceptoRecaudo_id", "finalidadTecnologiaSalud_id", "grupoServicios_id", "modalidadGrupoServicioTecSal_id", "tipoDocumentoIdentificacion_id", 
	"usuarioRegistro_id", "viaIngresoServicioSalud_id", "ripsDetalle_id", "itemFactura", "ripsTipos_id", "tipoPagoModerador_id")
SELECT sed."codigoHabilitacion", facdet."fecha", null,null, usu.documento,facdet."valorTotal",(select COALESCE(pagos.valor,0) from cartera_pagos pagos, cartera_formaspagos formapago,rips_ripstipospagomoderador ripsmoderadora 
	 						where  i."tipoDoc_id" =  pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and  pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)) , 
 fac.id, row_number() OVER(ORDER BY facdet.id) AS consecutivo, now(),	 	null,(select diag1.id from  clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 
	 								where histdiag1.historia_id = histdiag.historia_id and histdiag1."tiposDiagnostico_id" = 2),	(select diag3.id from  clinico_historialdiagnosticos histdiag3, clinico_diagnosticos diag3 
	 								where histdiag3.historia_id = histdiag.historia_id and histdiag3."tiposDiagnostico_id" = 3),	exa.id,serv.id, null, final.id,gru.id,mod.id,tipdocrips.id,'1',ingreso.id,detrips.id, facdet."consecutivoFactura",'4'
	  ,(select ripsmoderadora.id from cartera_pagos pagos, cartera_formaspagos formapago,rips_ripstipospagomoderador ripsmoderadora 	where  i."tipoDoc_id" =  pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and 
								  pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)) FROM sitios_sedesclinica sed , facturacion_facturacion fac, facturacion_facturaciondetalle facdet, clinico_examenes exa, admisiones_ingresos i, rips_ripsviasingresosalud ingreso,
	  rips_ripsenvios e, rips_ripsdetalle detrips, rips_ripsmodalidadatencion mod, rips_ripsgruposervicios gru, rips_ripsServicios serv, rips_ripsfinalidadconsulta final,
		rips_ripstiposdocumento tipdocrips, usuarios_tiposdocumento tipdoc, usuarios_usuarios usu, clinico_historia his, clinico_historialdiagnosticos histdiag,
	 clinico_diagnosticos diag where sed.id = '1' and e.id=16 and sed.id = e."sedesClinica_id" and e.id = detrips."ripsEnvios_id" and detrips."numeroFactura_id" = fac.id and   facdet.facturacion_id = fac.id and i.factura = fac.id and i."ripsViaIngresoServicioSalud_id" = ingreso.id
   and facdet."codigoCups_id" is not null and exa.id = facdet."codigoCups_id" and i."ripsmodalidadGrupoServicioTecSal_id" = mod.id and i."ripsGrupoServicios_id" = gru.id and
    serv.id = i."ripsGrupoServicios_id" and final.id = i."ripsFinalidadConsulta_id" and tipdoc.id =  fac."tipoDoc_id" and  fac."tipoDoc_id" = usu."tipoDoc_id" and fac.documento_id = usu.id and
	tipdoc."tipoDocRips_id" = tipdocrips.id and i."tipoDoc_id" =  fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision" 
	 and i."tipoDoc_id" =  his."tipoDoc_id" and i.documento_id = his.documento_id and i.consec = his."consecAdmision" and histdiag.historia_id = his.id and histdiag."tiposDiagnostico_id" = 1 and diag.id = histdiag.diagnosticos_id 



detalle = 'INSERT INTO rips_ripsprocedimientos ( "codPrestador", "fechaInicioAtencion", "idMIPRES", "numAutorizacion","numDocumentoIdentificacion", "vrServicio", "valorPagoModerador", "numFEVPagoModerador",
	consecutivo, "fechaRegistro","codComplicacion_id", "codDiagnosticoPrincipal_id", "codDiagnosticoRelacionado_id", "codProcedimiento_id", "codServicio_id","conceptoRecaudo_id", "finalidadTecnologiaSalud_id", "grupoServicios_id", "modalidadGrupoServicioTecSal_id", "tipoDocumentoIdentificacion_id", '
 + "'" + str(username_id) + "'" + ' , "viaIngresoServicioSalud_id", "ripsDetalle_id", "itemFactura", "ripsTipos_id", "tipoPagoModerador_id") SELECT sed."codigoHabilitacion", facdet."fecha", null,null,
	  usu.documento,facdet."valorTotal",(select COALESCE(pagos.valor,0) from cartera_pagos pagos, cartera_formaspagos formapago,rips_ripstipospagomoderador ripsmoderadora 
		where  i."tipoDoc_id" =  pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)) , 
 fac.id, row_number() OVER(ORDER BY facdet.id) AS consecutivo, now(),null,	(select diag1.id from  clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 
	where histdiag1.historia_id = histdiag.historia_id and histdiag1."tiposDiagnostico_id" = 2),(select diag3.id from  clinico_historialdiagnosticos histdiag3, clinico_diagnosticos diag3 
  where histdiag3.historia_id = histdiag.historia_id and histdiag3."tiposDiagnostico_id" = 3),exa.id,serv.id, null, final.id,gru.id,mod.id,tipdocrips.id,'1',ingreso.id,detrips.id, facdet."consecutivoFactura",'4'
	  ,(select ripsmoderadora.id from cartera_pagos pagos, cartera_formaspagos formapago,rips_ripstipospagomoderador ripsmoderadora 	where  i."tipoDoc_id" =  pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and 
								  pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)) FROM sitios_sedesclinica sed , facturacion_facturacion fac, facturacion_facturaciondetalle facdet, clinico_examenes exa, admisiones_ingresos i, rips_ripsviasingresosalud ingreso,
	  rips_ripsenvios e, rips_ripsdetalle detrips, rips_ripsmodalidadatencion mod, rips_ripsgruposervicios gru, rips_ripsServicios serv, rips_ripsfinalidadconsulta final,
		rips_ripstiposdocumento tipdocrips, usuarios_tiposdocumento tipdoc, usuarios_usuarios usu, clinico_historia his, clinico_historialdiagnosticos histdiag,
	 clinico_diagnosticos diag where sed.id = ' + "'" + str(sedeClinica_id) + "'" + ' and e.id= ' + "'" + str(envioRipsId) + "'" + ' and sed.id = e."sedesClinica_id" and e.id = detrips."ripsEnvios_id" and detrips."numeroFactura_id" = fac.id and   facdet.facturacion_id = fac.id and i.factura = fac.id and i."ripsViaIngresoServicioSalud_id" = ingreso.id
   and facdet."codigoCups_id" is not null and exa.id = facdet."codigoCups_id" and i."ripsmodalidadGrupoServicioTecSal_id" = mod.id and i."ripsGrupoServicios_id" = gru.id and
    serv.id = i."ripsGrupoServicios_id" and final.id = i."ripsFinalidadConsulta_id" and tipdoc.id =  fac."tipoDoc_id" and  fac."tipoDoc_id" = usu."tipoDoc_id" and fac.documento_id = usu.id and
	tipdoc."tipoDocRips_id" = tipdocrips.id and i."tipoDoc_id" =  fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision" 
	 and i."tipoDoc_id" =  his."tipoDoc_id" and i.documento_id = his.documento_id and i.consec = his."consecAdmision" and histdiag.historia_id = his.id and histdiag."tiposDiagnostico_id" = 1 and diag.id = histdiag.diagnosticos_id 	
'

delete from rips_ripstransaccion;
delete from rips_ripsusuarios;
delete from rips_ripsprocedimientos;
select * from rips_ripsprocedimientos