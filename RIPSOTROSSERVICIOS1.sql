INNER JOIN admisiones_ingresos ing on (ing."tipoDoc_id" = l1."tipoDoc_id" and ing.documento_id = l1.documento_id and ing.consec = l1."consecAdmision")	-- PRIMER QUERY
select "ripsTransaccion_id",* from rips_ripsotrosservicios
detalle ='INSERT INTO rips_ripsotrosservicios ( "codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia","tipoOS_id", "codTecnologiaSalud_id",	"nomTecnologiaSalud", "cantidadOS", 	"tipoDocumentoIdentificacion_id", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio",	"tipoPagoModerador_id",	"valorPagoModerador","numFEVPagoModerador", consecutivo, "fechaRegistro",   "usuarioRegistro_id",	"ripsDetalle_id", "itemFactura", "ripsTipos_id", "ripsTransaccion_id", "estadoReg", ingreso_id) SELECT sed."codigoHabilitacion", autdet."numeroAutorizacion", his.mipres, facdet."fecha",   ripsOtros.id,  exa.id,  substring(exa.nombre,1,60), facdet.cantidad,	tipdocrips.id, usu.documento,facdet."valorUnitario",	facdet."valorTotal", (select max(ripsmoderadora.id) from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)),  (select carFac."valorAplicado" from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFacwhere i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)),  fac.id, row_number()  OVER(ORDER BY facdet.id)  AS consecutivo, now(), ' + "'" + str(username_id) + "'" + ',detrips.id,facdet."consecutivoFactura",' + "'" + str('9') + "','" + 	str(transaccionId) + "','A',''" + str(ingresoId) + "'" + '	FROM sitios_sedesclinica sed inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id) inner join facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = ' + "'" + str('N') + "'" + ' or facdet.anulado = ' + "'" + str('R') + "')" + ' and "tipoRegistro" = ' + "'" + str('SISTEMA') + "'" + ' AND facDet.cirugia_id is not null) inner join clinico_examenes exa ON (exa.id = facdet."examen_id") inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision")	inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) left join  rips_ripstiposdocumento tipdocrips on (tipdocrips.id = tipdoc."tipoDocRips_id" ) inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )  left join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec ) inner join clinico_historialcirugias hisCiru ON (hisCiru.historia_id = his.id and hisCiru.cirugia_id = facDet.cirugia_id) left join autorizaciones_autorizaciones  aut on (aut.historia_id = his.id) left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id) inner join tarifarios_tiposhonorarios tipHonor on ( tipHonor.id = facDet."tipoHonorario_id" ) inner join rips_ripstipootrosservicios ripsOtros on (ripsOtros.id=tipHonor."ripsTipoOtrosServicios_id"  and ripsOtros.nombre=' + "'" + str('DISPOSITIVOS MEDICOS E INSUMOS') + "'" + ' where sed.id = ' + "'" + str(sede) + "'" + ' and e.id = ' + "'" + str(envioRipsId) + "'" + ' and fac.id = ' + "'" +str(elemento) + "'"
 
-- SEGUNDO QUERY

detalle =	'INSERT INTO rips_ripsotrosservicios ( "codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia","tipoOS_id", "codTecnologiaSalud_id","nomTecnologiaSalud", "cantidadOS", 	"tipoDocumentoIdentificacion_id", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio",	"tipoPagoModerador_id",	"valorPagoModerador","numFEVPagoModerador", consecutivo, "fechaRegistro",   "usuarioRegistro_id",	"ripsDetalle_id", "itemFactura", "ripsTipos_id","ripsTransaccion_id", "estadoReg", ingreso_id) SELECT sed."codigoHabilitacion", autdet."numeroAutorizacion", his.mipres, facdet."fecha",   ripsOtros.id,  exa.id,  substring(exa.nombre,1,60), facdet.cantidad, tipdocrips.id, usu.documento,facdet."valorUnitario",	facdet."valorTotal", (select max(ripsmoderadora.id) from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFacwhere i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)),  (select carFac."valorAplicado"	from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)),   fac.id, row_number()  OVER(ORDER BY facdet.id)  AS consecutivo, now(), ' + "'" + str(username_id) + "'" + ',detrips.id,facdet."consecutivoFactura",' + "'" + str('9') + "','" + str(transaccionId) + "','A'," + "'" + str(ingresoId.id) + "'" + '	FROM sitios_sedesclinica sed inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id) inner join facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."cums_id" is not null and (facdet.anulado = ' + "'" + str('N') + "'" + ' or facdet.anulado = ' + "'" + str('R') + "')" + ' and "tipoRegistro" = ' + "'" + str('MANUAL') + "'" + ' AND facDet.cirugia_id is not null) inner join facturacion_suministros exa ON (exa.id = facdet."cums_id")	inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision") inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id)  inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) 	left join  rips_ripstiposdocumento tipdocrips on (tipdocrips.id = tipdoc."tipoDocRips_id" ) inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )  left join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec ) inner join clinico_historialcirugias hisCiru ON (hisCiru.historia_id = his.id and hisCiru.cirugia_id = facDet.cirugia_id) left join autorizaciones_autorizaciones  aut on (aut.historia_id = his.id) left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id) inner join rips_ripstipootrosservicios ripsOtros on (ripsOtros.nombre=' + "'" + str('DISPOSITIVOS MEDICOS E INSUMOS') + "')" +  ' where sed.id = ' + "'" + str(sede) + "'" + ' and e.id = ' + "'" + str(envioRipsId) + "'" + ' and fac.id = ' + "'" +str(elemento) + "'"	
	

-- TERCER QUERY

detalle = 'INSERT INTO rips_ripsotrosservicios ( "codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia","tipoOS_id", "codTecnologiaSalud_id", "nomTecnologiaSalud", "cantidadOS", 	"tipoDocumentoIdentificacion_id", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio",	"tipoPagoModerador_id",	"valorPagoModerador","numFEVPagoModerador", consecutivo, "fechaRegistro",   "usuarioRegistro_id",	"ripsDetalle_id", "itemFactura", "ripsTipos_id", "ripsTransaccion_id", "estadoReg", ingreso_id) SELECT facDet."tipoHonorario_id" ,ripsOtros.id, ripsOtros.nombre,sed."codigoHabilitacion", autdet."numeroAutorizacion", his.mipres, facdet."fecha",	ripsOtros.id,  exa.id,  exa.nombre, facdet.cantidad, tipdocrips.id, usu.documento,facdet."valorUnitario",	facdet."valorTotal",  (select max(ripsmoderadora.id) from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), (select carFac."valorAplicado" from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), fac.id, row_number()  OVER(ORDER BY facdet.id) + 1 AS consecutivo, now(), ' + "'" + str(username_id) + "'" + ',detrips.id,facdet."consecutivoFactura",' + "'" + str('9') + "','" + str(transaccionId) + "','A'," + "'" + str(ingresoId.id) + "'" + '	FROM sitios_sedesclinica sed inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)	inner join facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = ' + "'" + str('N') + "'" + ' or facdet.anulado = ' + "'" + str('R') + "')" + ' and "tipoRegistro" = ' + "'" + str('SISTEMA') + "'" + ' AND facDet.cirugia_id is not null) inner join clinico_examenes exa ON (exa.id = facdet."examen_id") inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision") inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) left join  rips_ripstiposdocumento tipdocrips on (tipdocrips.id = tipdoc."tipoDocRips_id" ) inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )  left join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec ) INNER join clinico_historialcirugias hisCiru ON (hisCiru.historia_id = his.id and hisCiru.cirugia_id = facDet.cirugia_id ) left join autorizaciones_autorizaciones  aut on (aut.historia_id = his.id)	left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id) inner join tarifarios_tiposhonorarios tipHonor on ( tipHonor.id = facDet."tipoHonorario_id" ) inner join rips_ripstipootrosservicios ripsOtros on ( ripsOtros.id=tipHonor."ripsTipoOtrosServicios_id" and ripsOtros.nombre=' + "'" + str('HONORARIOS') + "')" + ' where sed.id = ' + "'" + str(sede) + "'" + ' and e.id = ' + "'" + str(envioRipsId) + "'" + ' and fac.id = ' + "'" +str(elemento) + "'"	


-- CUARTO QUERY
	-- es el honorarios MANUAL
-- QUINTO QUERY

	SELECT "serviciosSedes_id",* FROM sitios_dependencias
	select * from facturacion_liquidacion;
	select * from facturacion_liquidaciondetalle;
select * from clinico_examenes where nombre like ('%HABITACION');

SELECT * FROM SITIOS_SERVICIOSSEDES
SELECT * FROM CLINICO_SERVICIOS	
	select * from contratacion_convenios -- "tarifariosDescipcionProc_id"
	select "tiposTarifa_id",* from tarifarios_tarifariosdescripcion;
	select * from tarifarios_tipostarifa
		select * from tarifarios_tipostarifaproducto
		select * from tarifarios_estanciasiss
		SELECT * from rips_ripstipootrosservicios
		SELECT * FROM rips_ripsdetalle
	-- SON LAS ESTANCIAS
select * from rips_ripstipos
		SELECT * from tarifarios_tipostarifaproducto
		SELECT * from tarifarios_tipostarifa
		
-- PRIMERO LAS TARIFAS ISS
select * from tarifarios_estanciasiss
detalle = 'INSERT INTO rips_ripsotrosservicios ( "codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia","tipoOS_id", "codTecnologiaSalud_id", "nomTecnologiaSalud", "cantidadOS", 	"tipoDocumentoIdentificacion_id", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio",	"tipoPagoModerador_id",	"valorPagoModerador","numFEVPagoModerador", consecutivo, "fechaRegistro",   "usuarioRegistro_id",	"ripsDetalle_id", "itemFactura", "ripsTipos_id", "ripsTransaccion_id", "estadoReg", ingreso_id) SELECT facDet."tipoHonorario_id" ,ripsOtros.id, ripsOtros.nombre,sed."codigoHabilitacion",  ' + "' ' , ' '," +  ' facdet."fecha",	ripsOtros.id,  exa.id,  exa.nombre, facdet.cantidad, tipdocrips.id, usu.documento,facdet."valorUnitario",	facdet."valorTotal",  (select max(ripsmoderadora.id) from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), (select carFac."valorAplicado" from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), fac.id, row_number()  OVER(ORDER BY facdet.id) + 1 AS consecutivo, now(), ' + "'" + str(username_id) + "'" + ',detrips.id,facdet."consecutivoFactura",' + "'" + str('9') + "','" + str(transaccionId) + "','A'," + "'" + str(ingresoId.id) + "'" + '	FROM sitios_sedesclinica sed inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)	inner join facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = ' + "'" + str('N') + "'" + ' or facdet.anulado = ' + "'" + str('R') + "')" + ' and "tipoRegistro" = ' + "'" + str('SISTEMA') + "'" + ' AND facDet.cirugia_id is not null) inner join clinico_examenes exa ON (exa.id = facdet."examen_id") inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision") inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) left join  rips_ripstiposdocumento tipdocrips on (tipdocrips.id = tipdoc."tipoDocRips_id" ) inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )  inner join rips_ripstipootrosservicios ripsOtros on ( ripsOtros.nombre=' + "'" + str('HONORARIOS') + "')" + ' where sed.id = ' + "'" + str(sede) + "'" + ' and e.id = ' + "'" + str(envioRipsId) + "'" + ' and fac.id = ' + "'" +str(elemento) + "'"	

SELECT facDet."tipoHonorario_id" ,ripsOtros.id, ripsOtros.nombre,sed."codigoHabilitacion", ' ' , -- autdet."numeroAutorizacion",
--his.mipres,
		' ',
		facdet."fecha",	ripsOtros.id,  exa.id,  exa.nombre, facdet.cantidad, tipdocrips.id, usu.documento,
		facdet."valorUnitario",	facdet."valorTotal",  
		(select max(ripsmoderadora.id) 
		from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora ,
		cartera_pagosfacturas carFac where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and
		i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and
		ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)),
		(select carFac."valorAplicado" from cartera_pagos pagos, cartera_formaspagos formapago, 
		rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac 
		where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and
		carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and 
		ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)),
		fac.id, row_number()  OVER(ORDER BY facdet.id) + 1 AS consecutivo, now(), '1',detrips.id,facdet."consecutivoFactura",' 9' , 'xxxx','A','32323'
FROM sitios_sedesclinica sed
inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)
inner join facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R') and "tipoRegistro" = 'SISTEMA' AND facDet.cirugia_id is not null) 
inner join clinico_examenes exa ON (exa.id = facdet."examen_id" and exa.concepto_id=1) 
inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision") inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) 
inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) 
inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) 
left join  rips_ripstiposdocumento tipdocrips on (tipdocrips.id = tipdoc."tipoDocRips_id" )
inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )  
--left join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec )
--INNER join clinico_historialcirugias hisCiru ON (hisCiru.historia_id = his.id and hisCiru.cirugia_id = facDet.cirugia_id )
--left join autorizaciones_autorizaciones  aut on (aut.historia_id = his.id)
--left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id) 
--inner join tarifarios_tiposhonorarios tipHonor on ( tipHonor.id = facDet."tipoHonorario_id" )
--inner join rips_ripstipootrosservicios ripsOtros on ( ripsOtros.id=tipHonor."ripsTipoOtrosServicios_id" and 
--		ripsOtros.nombre='ESTANCIAS')
inner join rips_ripstipootrosservicios ripsOtros on ( 	ripsOtros.nombre='ESTANCIAS')
where sed.id = '1' and e.id = '138' and fac.id = '152'	

select * from tarifarios_tarifariosdescripcion	
select * from tarifarios_tipostarifa
select * from facturacion_conceptos;
SELECT * FROM TARIFARIOS_ESTANCIAS
	SELECT * FROM TARIFARIOS_ESTANCIASISS

	
-- SEXTO QUERY
	-- SON LAS ESTANCIAS MANUALES


	

select * from facturacion_liquidaciondetalle;
-- pruebas

INSERT INTO rips_ripsotrosservicios ( "codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia","tipoOS_id", "codTecnologiaSalud_id",        "nomTecnologiaSalud", "cantidadOS",      "tipoDocumentoIdentificacion_id", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio",        "tipoPagoModerador_id", "valorPagoModerador","numFEVPagoModerador", consecutivo, "fechaRegistro",   "usuarioRegistro_id",        "ripsDetalle_id", "itemFactura", "ripsTipos_id", "ripsTransaccion_id", "estadoReg", ingreso_id) SELECT sed."codigoHabilitacion", autdet."numeroAutorizacion", his.mipres, facdet."fecha",   ripsOtros.id,  exa.id,  substring(exa.nombre,1,60), facdet.cantidad,   tipdocrips.id, usu.documento,facdet."valorUnitario",    facdet."valorTotal", (select max(ripsmoderadora.id) from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)),  (select carFac."valorAplicado" from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)),  fac.id, row_number()  OVER(ORDER BY facdet.id)  AS consecutivo, now(), '1',detrips.id,facdet."consecutivoFactura",'9','953','A','50364'      FROM sitios_sedesclinica sed inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id) inner join facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R') and "tipoRegistro" = 'SISTEMA' AND facDet.cirugia_id is not null) inner join clinico_examenes exa ON (exa.id = facdet."examen_id") inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision")        inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) left join  rips_ripstiposdocumento tipdocrips on (tipdocrips.id = tipdoc."tipoDocRips_id" ) inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )  left join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec ) inner join clinico_historialcirugias hisCiru ON (hisCiru.historia_id = his.id and hisCiru.cirugia_id = facDet.cirugia_id) left join autorizaciones_autorizaciones  aut on (aut.historia_id = his.id) left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id) inner join tarifarios_tiposhonorarios tipHonor on ( tipHonor.id = facDet."tipoHonorario_id" ) inner join rips_ripstipootrosservicios ripsOtros on (ripsOtros.id=tipHonor."ripsTipoOtrosServicios_id"  and ripsOtros.nombre='DISPOSITIVOS MEDICOS E INSUMOS'
	where sed.id = '1' and e.id = '73' and fac.id = '152'

	-- Aqui la funcion de OTROS SERVICIO

	
		SELECT '{"codPrestador": '|| '"' || otros."codPrestador" || '"' 
	   ||',"numAutorizacion": '|| '"' || CASE WHEN trim(otros."numAutorizacion") is null THEN 'null' ELSE otros."numAutorizacion"  END || '"'		
  		',"idMIPRES": ' || '"'   ||CASE WHEN trim(otros."idMIPRES") is null THEN 'null'  WHEN trim(otros."idMIPRES") = null THEN 'null' WHEN trim(otros."idMIPRES") = '' THEN 'null'  ELSE otros."idMIPRES"  END|| '"'  
	||',"fechaSuministroTecnologia": '|| '"' || substring(cast(otros."fechaSuministroTecnologia" as text), 1,16) || '"'  
	 	||',"tipoOs": '|| '"' ||ripsTipo.codigo || '"'	
		||',"codTecnologiaSalud": '|| '"' || ripsCums.cum || '"'	
		||'"nomTecnologiaSalud": '|| '"' ||otros."nomTecnologiaSalud"  || '"'	
	   ||'"cantidadOS": '||  otros."cantidadOS" ||'	}'
	||',"tipoDocumentoIdentificacion": '|| '"' || ripsTiposDoc.codigo  || '"'		
	||',"numDocumentoIdentificacion":  '|| '"' || CASE WHEN trim(otros."numDocumentoIdentificacion") is null THEN 'null' ELSE otros."numDocumentoIdentificacion"  END  || '"'		
	||',"vrUnitOS": '|| otros."vrUnitOS"   || ''		
	||',"vrServicio": '|| otros."vrServicio"   || ''		
	||',"tipoPagoModerador": '|| '"' || case when modera.codigo is null then 'null' else modera.codigo end   || '"'		
	||'"valorPagoModerador": '||  CASE WHEN trim(cast(otros."valorPagoModerador" as text)) is null THEN 0 ELSE otros."valorPagoModerador"  END  || ''
	||',"numFEVPagoModerador": '|| '"' || otros."numFEVPagoModerador" || '"'
	||'"consecutivo": '||  otros."consecutivo" ||'	},'
	--INTO valorOtrosServicios
	from rips_ripstransaccion ripstra
	inner join rips_ripsotrosservicios otros on (otros."ripsTransaccion_id" = ripstra.id)
	inner join rips_ripscums ripsCums on (ripsCums.id = otros."codTecnologiaSalud_id" )
	inner join rips_ripstipootrosservicios ripsTipo on (ripsTipo.id = otros."tipoOS_id" ) 
	left join rips_ripstipospagomoderador modera on (modera.id=otros."tipoPagoModerador_id")
	inner join rips_ripstiposdocumento ripsTiposDoc on (ripsTiposDoc.id = otros."tipoDocumentoIdentificacion_id" )
--	   where  ripstra."ripsEnvio_id" = envioRipsId AND  ripstra."numFactura" = cast(facturaId as text) AND (proc."valorGlosado" > 0 or proc."valorGlosado" is null) and proc.consecutivo = i; 
	   where  ripstra."ripsEnvio_id" = 73 AND  ripstra."numFactura" = cast('152' as text) AND (otros."valorGlosado" > 0 or otros."valorGlosado" is null) and otros.consecutivo >= 1; 

select generafacturajsonbak(73,152,'FACTURA',0)

select * from rips_ripsenvios;	
select "vrServicio","codTecnologiaSalud_id", * from rips_ripsotrosservicios
select * from rips_ripsmedicamentos 	where "ripsTransaccion_id"=970
select * from rips_ripscums where id = 17006
select * from rips_ripstipootrosservicios

	SELECT "tipoHonorario_id","valorTotal",* FROM FACTURACION_FACTURACIONDETALLE WHERE FACTURACION_ID =152

select * from rips_ripstipospagomoderador

INSERT INTO rips_ripsotrosservicios ( "codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia","tipoOS_id", "codTecnologiaSalud_id", "nomTecnologiaSalud", "cantidadOS",         "tipoDocumentoIdentificacion_id", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio",
        "tipoPagoModerador_id", "valorPagoModerador","numFEVPagoModerador", consecutivo, "fechaRegistro",   "usuarioRegistro_id",  "ripsDetalle_id", "itemFactura", "ripsTipos_id", "ripsTransaccion_id", "estadoReg", ingreso_id)
SELECT sed."codigoHabilitacion", autdet."numeroAutorizacion",
	his.mipres, facdet."fecha",   ripsOtros.id,  exa.id,  exa.nombre, facdet.cantidad, tipdocrips.id, usu.documento,
	facdet."valorUnitario",  facdet."valorTotal",  
	(select max(ripsmoderadora.id) from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), (select carFac."valorAplicado" from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), fac.id, row_number()  OVER(ORDER BY facdet.id) +   4   AS consecutivo, now(), '1',detrips.id,facdet."consecutivoFactura",'9','961','A','50364'   
	FROM sitios_sedesclinica sed
	inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)    
	inner join facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R') and "tipoRegistro" = 'SISTEMA' AND facDet.cirugia_id is not null)
	inner join clinico_examenes exa ON (exa.id = facdet."examen_id") inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision")
	inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) 
	inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id)
	inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) 
	left join  rips_ripstiposdocumento tipdocrips on (tipdocrips.id = tipdoc."tipoDocRips_id" ) 
	inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id ) 
	left join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec )
	INNER join clinico_historialcirugias hisCiru ON (hisCiru.historia_id = his.id and hisCiru.cirugia_id = facDet.cirugia_id )
	left join autorizaciones_autorizaciones  aut on (aut.historia_id = his.id)      
	left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id)
	inner join tarifarios_tiposhonorarios tipHonor on ( tipHonor.id = facDet."tipoHonorario_id" )
	inner join rips_ripstipootrosservicios ripsOtros on ( ripsOtros.id=tipHonor."ripsTipoOtrosServicios_id" and ripsOtros.nombre='HONORARIOS') 
	where sed.id = '1' and e.id = '73' and fac.id = '152'


select * from facturacion_tipossuministro

	--medicamentos sistema
SELECT sed."codigoHabilitacion", aut."numeroAutorizacion", historia.mipres, facdet.fecha , null,
	histmed."concentracionMedicamento",histmed."cantidadOrdenada", histmed."diasTratamiento",planta.documento, 
	facdet."valorUnitario", facdet."valorTotal", 0,  fac.id, row_number() OVER(ORDER BY histmed.id), now(), diag1.id, diag2.id,
	ripscums.id, (select min(ripsRecaudo.id) 
	FROM cartera_pagos pagos 
	INNER JOIN cartera_formaspagos carteraFormasPago ON (carteraFormasPago.id =pagos."formaPago_id" )
	INNER JOIN rips_ripsconceptorecaudo ripsRecaudo ON (ripsRecaudo.id = cast(carteraFormasPago."codigoRips" as integer))
	WHERE pagos.documento_id=fac.documento_id and pagos."tipoDoc_id" = fac."tipoDoc_id" and pagos.consec=fac."consecAdmision") recaudo, ripsfarma.id, ripstipdoc.id, tipmed.id, ripsumm.id,
	ripsupr.id, '1' , det.id, facdet."consecutivoFactura",'8' , rips_ripstransaccion.id , 'A','ingresoId.id'
	from rips_ripstransaccion 
	inner join rips_ripsenvios env on(env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" )
	inner join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id" ) 
	inner join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric)) 
	inner join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" ) 
	inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null and 
	(facdet.anulado = 'N' or facdet.anulado = 'R')  AND facDet."tipoRegistro" = 'SISTEMA')
	inner join clinico_historiamedicamentos histmed on (histmed.id = facdet."historiaMedicamento_id") 
	left join autorizaciones_autorizacionesDetalle  aut on (aut.id = histmed.autorizacion_id)
	inner join facturacion_suministros sum on (sum.id = facdet.cums_id) 
	inner join facturacion_tipossuministro tiposSum ON (tiposSum.id=sum."tipoSuministro_id" and tiposSum.nombre='MEDICAMENTOS')
	left join rips_ripstipomedicamento tipmed on (tipmed.id = sum."ripsTipoMedicamento_id" )
	inner join rips_ripscums ripscums  on (ripscums.cum = sum."cums") 
	left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id")
	left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id")  
	left join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id") 
	inner join clinico_historia historia on (historia.id = histmed.historia_id) 
	inner join planta_planta planta on (planta.id = historia."usuarioRegistro_id") 
	left join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id") 
	left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = usutipdoc."tipoDocRips_id") 
	left join clinico_historialdiagnosticos histdiag1 on (histdiag1.historia_id = historia.id and
	histdiag1."tiposDiagnostico_id" = '1') 
	left join clinico_historialdiagnosticos histdiag2 on (histdiag2.historia_id = historia.id and histdiag2."tiposDiagnostico_id" = '2')
	left join clinico_diagnosticos diag1 on (diag1.id = histdiag1.diagnosticos_id) 
	left join clinico_diagnosticos diag2 on (diag2.id = histdiag2.diagnosticos_id) 
	where env.id =  '73' and rips_ripstransaccion."ripsEnvio_id" = env.id 
	and cast(rips_ripstransaccion."numFactura" as numeric) = fac.id  and fac.id = '152' AND facdet.cums_id is not null

-- mediamento manual

SELECT sed."codigoHabilitacion", null, null, facdet.fecha,null,null ,null ,null ,planta.documento, facdet."valorUnitario",
	facdet."valorTotal", 0,  fac.id, row_number() OVER(ORDER BY facdet.id)  , now(),diag1.id , diag2.id, ripscums.id, 
	(select min(ripsRecaudo.id)  FROM cartera_pagos pagos 
	INNER JOIN cartera_formaspagos carteraFormasPago ON (carteraFormasPago.id =pagos."formaPago_id" )
	INNER JOIN rips_ripsconceptorecaudo ripsRecaudo ON (ripsRecaudo.id = cast(carteraFormasPago."codigoRips" as integer)) 	
	WHERE pagos.documento_id=fac.documento_id and pagos."tipoDoc_id" = fac."tipoDoc_id" and pagos.consec=fac."consecAdmision") recaudo, ripsfarma.id, ripstipdoc.id, tipmed.id, ripsumm.id,
	ripsupr.id, '1' , det.id, facdet."consecutivoFactura", '8' , rips_ripstransaccion.id , 'A','ingresoId.id'
	from rips_ripstransaccion 
	inner join rips_ripsenvios env on(env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" ) 
	inner join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id")
	inner join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric)) 
	inner join facturacion_facturacion fac on (fac.id = det."numeroFactura_id") 
	inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R') AND facDet."tipoRegistro" = 'MANUAL')
	inner join facturacion_suministros sum on (sum.id = facdet.cums_id)
	inner join facturacion_tipossuministro tiposSum ON (tiposSum.id=sum."tipoSuministro_id" and tiposSum.nombre='MEDICAMENTOS')
	left join rips_ripstipomedicamento tipmed on (tipmed.id = sum."ripsTipoMedicamento_id" ) 
	inner join rips_ripscums ripscums  on (ripscums.cum = sum."cums") 
	left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id") 
	left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id")
	left join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id")
	inner join admisiones_ingresos adm on (adm."tipoDoc_id" = fac."tipoDoc_id" and adm.documento_id=fac.documento_id and adm.consec=fac."consecAdmision") 
	left join 	clinico_medicos medico on (medico.id =adm."medicoActual_id") 
	inner join planta_planta planta on (planta.id = medico.planta_id)
	left join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id") 
	left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = usutipdoc."tipoDocRips_id")  
	left join clinico_diagnosticos diag1 on (diag1.id=adm."dxActual_id") 
	left join clinico_diagnosticos diag2 on (diag2.id=adm."dxIngreso_id")
	where env.id =  '73' and rips_ripstransaccion."ripsEnvio_id" = env.id  and cast(rips_ripstransaccion."numFactura" as numeric) = fac.id  and fac.id = '152' AND facdet.cums_id is not null

select "rutaXml",* from facturacion_facturacion

-- Para ripotrosserivios glosas

 detalle = 'INSERT INTO rips_ripsmedicamentos (glosa_id,"codPrestador", "numAutorizacion", "idMIPRES", "fechaDispensAdmon", "nomTecnologiaSalud", "concentracionMedicamento", "cantidadMedicamento", "diasTratamiento",	"numDocumentoIdentificacion", "vrUnitMedicamento", "vrServicio", "valorPagoModerador", "numFEVPagoModerador",consecutivo, "fechaRegistro", "codDiagnosticoPrincipal_id", "codDiagnosticoRelacionado_id", "codTecnologiaSalud_id", "conceptoRecaudo_id", "formaFarmaceutica_id", "tipoDocumentoIdentificacion_id","tipoMedicamento_id", "unidadMedida_id", "unidadMinDispensa_id", 
	"usuarioRegistro_id", "ripsDetalle_id", "itemFactura","ripsTipos_id", "ripsTransaccion_id", ingreso_id, "estadoReg" , "motivoGlosa_id", "notasCreditoGlosa", "notasCreditoOtras","notasDebito","vAceptado","valorGlosado","valorSoportado") 
	
SELECT glosa.id, "codPrestador", "numAutorizacion", "idMIPRES", "fechaDispensAdmon", "nomTecnologiaSalud", 
	"concentracionMedicamento", "cantidadMedicamento", "diasTratamiento",	"numDocumentoIdentificacion", "vrUnitMedicamento",
	"vrServicio", "valorPagoModerador", "numFEVPagoModerador",row_number() OVER(ORDER BY med.id) AS consecutivo , 
	med."fechaRegistro", "codDiagnosticoPrincipal_id", "codDiagnosticoRelacionado_id", "codTecnologiaSalud_id", 
	"conceptoRecaudo_id", "formaFarmaceutica_id", "tipoDocumentoIdentificacion_id",
	"tipoMedicamento_id", "unidadMedida_id", "unidadMinDispensa_id", med."usuarioRegistro_id",
	' + "'" + str(elementox['id']) + "'" + ' , med."itemFactura",med."ripsTipos_id", ' + "'" + str(transaccionId) + "','" 
	+ str(ingresoId.id) + "','A'"  + ' , gloDet."motivoGlosa_id",
	gloDet."valorNotasCredito", gloDet."valorNotasCreditoOtras",
	gloDet."valorNotasDebito",gloDet."valorAceptado",gloDet."valorGlosa",gloDet."valorSoportado"  
FROM rips_ripsMedicamentos med
inner join cartera_glosasdetalle gloDet on (gloDet."ripsMedicamentos_id" = med.id) 
inner join cartera_glosas glosa on (glosa.id = gloDet.glosa_id and glosa.factura_id = cast(med."numFEVPagoModerador"  as integer))
inner join rips_ripsdetalle det on (det."numeroFactura_id" =  cast(med."numFEVPagoModerador"  as integer) and  det.glosa_id=glosa.id and det.glosa_id=' + "'" + str(elemento) + "'" + ') 
where med."numFEVPagoModerador" = ' + "'" + str(elementoOtro) + "'"

-- supuesto es elquery
	
detalle = 'INSERT INTO rips_ripsotrosservicios (glosa_id,"codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia", "nomTecnologiaSalud", "cantidadOS", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio", "valorPagoModerador", "numFEVPagoModerador", consecutivo, "fechaRegistro", "codTecnologiaSalud_id", "conceptoRecaudo_id", "tipoDocumentoIdentificacion_id", "tipoOS_id", "usuarioRegistro_id", "ripsDetalle_id", "itemFactura", "ripsTipos_id", "ripsTransaccion_id","motivoGlosa_id", "notasCreditoGlosa", "notasCreditoOtras", "notasDebito", "vAceptado", "valorGlosado", "valorSoportado", "estadoReg", ingreso_id, "tipoPagoModerador_id") SELECT glosa.id,"codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia", "nomTecnologiaSalud", "cantidadOS", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio", "valorPagoModerador", "numFEVPagoModerador", row_number() OVER(ORDER BY ripsOtros.id) AS consecutivo , ripsOtros."fechaRegistro", "codTecnologiaSalud_id", "conceptoRecaudo_id", "tipoDocumentoIdentificacion_id", "tipoOS_id",ripsOtros."usuarioRegistro_id",' + "'" + str(elementox['id']) + "'" + ', ripsOtros."itemFactura", ripsOtros."ripsTipos_id", ' + "'" + str(transaccionId) + "'," + 'glodet."motivoGlosa_id",gloDet."valorNotasCredito", gloDet."valorNotasCreditoOtras",gloDet."valorNotasDebito",gloDet."valorAceptado",gloDet."valorGlosa",gloDet."valorSoportado" ' +  ",'A','"  + str(ingresoId.id) + "'," + '"tipoPagoModerador_id" FROM rips_ripsotrosservicios ripsOtros inner join cartera_glosasdetalle gloDet on (gloDet."ripsMedicamentos_id" = ripsOtros.id) inner join cartera_glosas glosa on (glosa.id = gloDet.glosa_id and glosa.factura_id = cast(ripsOtros."numFEVPagoModerador"  as integer)) inner join rips_ripsdetalle det on (det."numeroFactura_id" =  cast(ripsOtros."numFEVPagoModerador"  as integer) and  det.glosa_id=glosa.id and det.glosa_id=' + "'" + str(elemento) + "'" + ') where ripsOtros."numFEVPagoModerador" = ' + "'" + str(elementoOtro) + "'"


-- VEamoslo
begin transaction;
	INSERT INTO rips_ripsotrosservicios (glosa_id,"codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia", "nomTecnologiaSalud", "cantidadOS", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio", "valorPagoModerador", "numFEVPagoModerador", consecutivo, "fechaRegistro", "codTecnologiaSalud_id", "conceptoRecaudo_id", "tipoDocumentoIdentificacion_id", "tipoOS_id", "usuarioRegistro_id", "ripsDetalle_id", "itemFactura", "ripsTipos_id", "ripsTransaccion_id",
	 "motivoGlosa_id", "notasCreditoGlosa", "notasCreditoOtras", "notasDebito", "vAceptado", "valorGlosado", "valorSoportado", "estadoReg", ingreso_id, "tipoPagoModerador_id")
SELECT glosa.id,"codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia", "nomTecnologiaSalud", "cantidadOS",
	"numDocumentoIdentificacion", "vrUnitOS", "vrServicio", "valorPagoModerador", "numFEVPagoModerador", 
	row_number() OVER(ORDER BY ripsOtros.id) AS consecutivo 
	, ripsOtros."fechaRegistro", "codTecnologiaSalud_id", "conceptoRecaudo_id", "tipoDocumentoIdentificacion_id", "tipoOS_id",ripsOtros."usuarioRegistro_id",
	'152', ripsOtros."itemFactura", ripsOtros."ripsTipos_id",-- ' + "'" +
	--str(transaccionId) + "'" + '	
	'1' , glodet."motivoGlosa_id",gloDet."valorNotasCredito", gloDet."valorNotasCreditoOtras",
	gloDet."valorNotasDebito",gloDet."valorAceptado",gloDet."valorGlosa",gloDet."valorSoportado" ,'A',
		--'ingresoId.id',
		1,
		"tipoPagoModerador_id" 
		FROM rips_ripsotrosservicios ripsOtros
inner join cartera_glosasdetalle gloDet on (gloDet."ripsOtrosServicios_id" = ripsOtros.id) 
		inner join cartera_glosas glosa on (glosa.id = gloDet.glosa_id and glosa.factura_id = cast(ripsOtros."numFEVPagoModerador"  as integer))
inner join rips_ripsdetalle det on (det."numeroFactura_id" =  cast(ripsOtros."numFEVPagoModerador"  as integer) and 
	det.glosa_id=glosa.id and det.glosa_id=41) 
 where ripsOtros."numFEVPagoModerador" = '152'
--rollback;

select * from cartera_glosasdetalle
select * from cartera_glosas
select "ripsTransaccion_id",* from rips_ripsotrosservicios


BEGIN TRANSACTION;
 INSERT INTO rips_ripsotrosservicios (glosa_id,"codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia",
	 "nomTecnologiaSalud", "cantidadOS", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio", "valorPagoModerador",
	 "numFEVPagoModerador", consecutivo, "fechaRegistro", "codTecnologiaSalud_id", "conceptoRecaudo_id", 
	 "tipoDocumentoIdentificacion_id", "tipoOS_id", "usuarioRegistro_id", "ripsDetalle_id", "itemFactura", "ripsTipos_id", 
	 "ripsTransaccion_id","motivoGlosa_id", "notasCreditoGlosa", "notasCreditoOtras", "notasDebito", "vAceptado", 
	 "valorGlosado", "valorSoportado", "estadoReg", ingreso_id, "tipoPagoModerador_id") 
	SELECT glosa.id,"codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia", "nomTecnologiaSalud", "cantidadOS", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio", "valorPagoModerador", "numFEVPagoModerador", row_number() OVER(ORDER BY ripsOtros.id) AS consecutivo , ripsOtros."fechaRegistro", "codTecnologiaSalud_id", "conceptoRecaudo_id", "tipoDocumentoIdentificacion_id", "tipoOS_id",ripsOtros."usuarioRegistro_id",'139', ripsOtros."itemFactura", ripsOtros."ripsTipos_id", '975',glodet."motivoGlosa_id",gloDet."valorNotasCredito", gloDet."valorNotasCreditoOtras",gloDet."valorNotasDebito",gloDet."valorAceptado",gloDet."valorGlosa",gloDet."valorSoportado" ,'A','50364',"tipoPagoModerador_id" 
	 FROM rips_ripsotrosservicios ripsOtros 
	inner join cartera_glosasdetalle gloDet on (gloDet."ripsOtrosServicios_id" = ripsOtros.id) 
inner join cartera_glosas glosa on (glosa.id = gloDet.glosa_id and glosa.factura_id = cast(ripsOtros."numFEVPagoModerador"  as integer)) 
inner join rips_ripsdetalle det on (det."numeroFactura_id" =  cast(ripsOtros."numFEVPagoModerador"  as integer) and  det.glosa_id=glosa.id and det.glosa_id='41')
where ripsOtros."numFEVPagoModerador" = '152'
--ROLLBACK

select * from rips_ripstransaccion

-- Programacion de cirugia

SELECT prog.id id,  u."tipoDoc_id" tipoDoc_id ,tipdoc.abreviatura abrev, u.documento documento, i.consec consecutivo,
	 u.nombre paciente,estprog.nombre estadoProg,sala.numero, sala.nombre sala, prog."fechaProgramacionInicia" inicia, 
	 prog."horaProgramacionInicia" horaInicia, prog."fechaProgramacionFin" Termina, prog."horaProgramacionFin" horaTermina 
	 ,(SELECT exa.nombre FROM cirugia_cirugias cir
	 LEFT JOIN cirugia_cirugiasprocedimientos cirproc on (cirproc.cirugia_id = cir.id) 
	 INNER JOIN clinico_examenes exa on (exa.id = cirproc.cups_id) 
	 WHERE cir."tipoDoc_id" = prog."tipoDoc_id" and cir.documento_id = prog.documento_id  and cir."consecAdmision" = prog."consecAdmision" limit 1) cirugias ,
	 estcir.nombre estadoCirugia 
	 FROM cirugia_programacioncirugias prog 
	 INNER JOIN sitios_sedesclinica sed	on (sed.id = prog."sedesClinica_id") 
	 INNER JOIN admisiones_ingresos i ON (i."tipoDoc_id" =prog."tipoDoc_id" AND i.documento_id =  prog.documento_id AND i.consec= prog."consecAdmision" )  
	 LEFT JOIN cirugia_cirugias cir ON (cir."tipoDoc_id" =prog."tipoDoc_id" AND cir.documento_id =  prog.documento_id AND cir."consecAdmision" = prog."consecAdmision" ) 
	 INNER JOIN cirugia_estadoscirugias estcir ON (estcir.id = cir."estadoCirugia_id")
	 INNER JOIN usuarios_usuarios u ON (u.id = i.documento_id )
	 INNER JOIN usuarios_tiposdocumento tipdoc ON (tipdoc.id =  u."tipoDoc_id")
	 INNER JOIN cirugia_estadosprogramacion estprog ON (estprog.id = prog."estadoProgramacion_id" ) 
	 LEFT JOIN sitios_salas sala ON (sala.id =prog.sala_id ) 
	 WHERE sed.id = '1' AND  estcir.id IN (2,3)
	 order by sala.numero
 
	 SELECT * FROM cirugia_estadosprogramacion
SELECT * FROM cirugia_estadoscirugias
select * from cirugia_cirugias
select * from cirugia_programacioncirugias
update cirugia_cirugias set "estadoCirugia_id" =5  where id=40
SELECT * FROM tarifarios_estancias
SELECT * FROM tarifarios_tipostarifa

----------------
-- FUNCTION
--------------
	 
CREATE OR REPLACE FUNCTION creaEstanciaAutomatica()

 RETURNS character varying
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

	DECLARE  estancias character(50000);
             tabla  RECORD;
BEGIN

/* PRIMERO ISS */

INSERT INTO facturacion_liquidaciondetalle(consecutivo, fecha, cantidad, "valorUnitario", "valorTotal",  "fechaCrea", 
		observaciones, "fechaRegistro", "estadoRegistro", examen_id, liquidacion_id 
		,"tipoRegistro",anulado, "codigoHomologado") 
select 
	(SELECT  coalesce(max(liqDet.consecutivo), 1) AS MaxX
		FROM facturacion_liquidaciondetalle liqdet
		WHERE liqDet.liquidacion_id = l1.id) consecutivo,
		now(),1,tar.valor,tar.valor,now(),'',now(),'A',dep.cups_id,l1.id,'SISTEMA','N',tar.referencia
FROM facturacion_liquidacion l1
INNER JOIN admisiones_ingresos ing on (ing."tipoDoc_id" = l1."tipoDoc_id" and ing.documento_id = l1.documento_id and ing.consec = l1."consecAdmision")	
INNER JOIN SITIOS_SERVICIOSSEDES servSed on (servSed."sedesClinica_id"=l1."sedesClinica_id")
INNER JOIN clinico_servicios serv on (serv.id =servSed.servicios_id   )
INNER JOIN sitios_dependencias dep on (dep."sedesClinica_id" = servSed."sedesClinica_id" AND   dep."serviciosSedes_id" = servSed.id and dep.id=ing."dependenciasActual_id")	
INNER JOIN contratacion_convenios conv on (conv.id = l1.convenio_id)
INNER JOIN tarifarios_tarifariosdescripcion descripcion ON (descripcion.id=conv."tarifariosDescripcionProc_id")	
INNER JOIN 	tarifarios_tipostarifa tiptar on (tiptar.id= descripcion."tiposTarifa_id" AND tiptar.nombre = 'ISS 2001')	
INNER JOIN 	tarifarios_tipostarifaproducto tipProd on (tipProd.id=tiptar."tiposTarifaProducto_id" and tipProd.nombre='PROCEDIMIENTOS')
INNER JOIN 	tarifarios_estancias tar on (tar.cups_id = dep.cups_id and tar."tipoEstancia" = 'I')	
WHERE serv.nombre = 'HOSPITALIZACION' and  l1.anulado = 'N' and l1.convenio_id = (SELECT max(l2.convenio_id) 
											FROM facturacion_liquidacion l2 
											where  l2."tipoDoc_id" = l1."tipoDoc_id" AND l2.documento_id = l1.documento_id AND l2."consecAdmision" = l1."consecAdmision");

raise notice 'Voy por el FOR LOOP :' ;

FOR tabla IN SELECT * FROM facturacion_liquidacion l1
	INNER JOIN admisiones_ingresos ing on (ing."tipoDoc_id" = l1."tipoDoc_id" and ing.documento_id = l1.documento_id and ing.consec = l1."consecAdmision")	
	INNER JOIN SITIOS_SERVICIOSSEDES servSed on (servSed."sedesClinica_id"=l1."sedesClinica_id")
	INNER JOIN clinico_servicios serv on (serv.id =servSed.servicios_id   )
	INNER JOIN sitios_dependencias dep on (dep."sedesClinica_id" = servSed."sedesClinica_id" AND   dep."serviciosSedes_id" = servSed.id and dep.id=ing."dependenciasActual_id")	
	INNER JOIN contratacion_convenios conv on (conv.id = l1.convenio_id)
	INNER JOIN tarifarios_tarifariosdescripcion descripcion ON (descripcion.id=conv."tarifariosDescripcionProc_id")	
	INNER JOIN 	tarifarios_tipostarifa tiptar on (tiptar.id= descripcion."tiposTarifa_id" AND tiptar.nombre = 'ISS 2001')	
	INNER JOIN 	tarifarios_tipostarifaproducto tipProd on (tipProd.id=tiptar."tiposTarifaProducto_id" and tipProd.nombre='PROCEDIMIENTOS')
	INNER JOIN 	tarifarios_estancias tar on (tar.cups_id = dep.cups_id and tar."tipoEstancia" = 'I')	
	WHERE serv.nombre = 'HOSPITALIZACION' and  l1.anulado = 'N' and l1.convenio_id = (SELECT max(l2.convenio_id) 
											FROM facturacion_liquidacion l2 
											where  l2."tipoDoc_id" = l1."tipoDoc_id" AND l2.documento_id = l1.documento_id AND l2."consecAdmision" = l1."consecAdmision")
LOOP 
			
			raise notice 'Voy a guardar encabezados : %s' , tabla.id;
			Update facturacion_liquidacion SET  "totalProcedimientos" = "totalProcedimientos" + tabla.valor        where id = tabla.id;
			raise notice 'ya guarde1: %s' , tabla.id;
			Update facturacion_liquidacion SET  "totalLiquidacion" = "totalSuministros" + "totalProcedimientos"    where id = tabla.id;
			raise notice 'ya guarde2: : %s' , tabla.id;
			Update facturacion_liquidacion SET  "valorApagar" = "totalLiquidacion" - "totalRecibido"    where id = tabla.id;
			raise notice 'En teoria ya guardes : %s' , tabla.valor;

END LOOP;

/* SEGUNDO SOAT */ 


INSERT INTO facturacion_liquidaciondetalle(consecutivo, fecha, cantidad, "valorUnitario", "valorTotal",  "fechaCrea", 
		observaciones, "fechaRegistro", "estadoRegistro", examen_id, liquidacion_id 
		,"tipoRegistro",anulado, "codigoHomologado") 
select 
	(SELECT  coalesce(max(liqDet.consecutivo), 1) AS MaxX
		FROM facturacion_liquidaciondetalle liqdet
		WHERE liqDet.liquidacion_id = l1.id) consecutivo,	
		now(),1,tar.valor,tar.valor,now(),'',now(),'A',dep.cups_id,l1.id,'SISTEMA','N',tar.referencia
FROM facturacion_liquidacion l1
INNER JOIN admisiones_ingresos ing on (ing."tipoDoc_id" = l1."tipoDoc_id" and ing.documento_id = l1.documento_id and ing.consec = l1."consecAdmision")		
INNER JOIN SITIOS_SERVICIOSSEDES servSed on (servSed."sedesClinica_id"=l1."sedesClinica_id")
INNER JOIN clinico_servicios serv on (serv.id =servSed.servicios_id and serv.nombre = 'HOSPITALIZACION' )
INNER JOIN sitios_dependencias dep on (dep."sedesClinica_id" = servSed."sedesClinica_id" AND   dep."serviciosSedes_id" = servSed.id and dep.id=ing."dependenciasActual_id")	
INNER JOIN contratacion_convenios conv on (conv.id = l1.convenio_id)
INNER JOIN tarifarios_tarifariosdescripcion descripcion ON (descripcion.id=conv."tarifariosDescripcionProc_id")	
INNER JOIN 	tarifarios_tipostarifa tiptar on (tiptar.id= descripcion."tiposTarifa_id" AND tiptar.nombre = 'SOAT 2024')	
INNER JOIN 	tarifarios_tipostarifaproducto tipProd on (tipProd.id=tiptar."tiposTarifaProducto_id" and tipProd.nombre='PROCEDIMIENTOS')
INNER JOIN 	tarifarios_estancias tar on (tar.cups_id = dep.cups_id and tar."tipoEstancia" = 'S')	
WHERE l1.anulado = 'N' and l1.convenio_id = (SELECT max(l2.convenio_id) 
											FROM facturacion_liquidacion l2 
											where  l2."tipoDoc_id" = l1."tipoDoc_id" AND l2.documento_id = l1.documento_id AND l2."consecAdmision" = l1."consecAdmision");

FOR tabla IN SELECT * FROM facturacion_liquidacion l1
	INNER JOIN admisiones_ingresos ing on (ing."tipoDoc_id" = l1."tipoDoc_id" and ing.documento_id = l1.documento_id and ing.consec = l1."consecAdmision")		
	INNER JOIN SITIOS_SERVICIOSSEDES servSed on (servSed."sedesClinica_id"=l1."sedesClinica_id")
	INNER JOIN clinico_servicios serv on (serv.id =servSed.servicios_id and serv.nombre = 'HOSPITALIZACION' )
	INNER JOIN sitios_dependencias dep on (dep."sedesClinica_id" = servSed."sedesClinica_id" AND   dep."serviciosSedes_id" = servSed.id and dep.id=ing."dependenciasActual_id")	
	INNER JOIN contratacion_convenios conv on (conv.id = l1.convenio_id)
	INNER JOIN tarifarios_tarifariosdescripcion descripcion ON (descripcion.id=conv."tarifariosDescripcionProc_id")	
	INNER JOIN 	tarifarios_tipostarifa tiptar on (tiptar.id= descripcion."tiposTarifa_id" AND tiptar.nombre = 'SOAT 2024')	
	INNER JOIN 	tarifarios_tipostarifaproducto tipProd on (tipProd.id=tiptar."tiposTarifaProducto_id" and tipProd.nombre='PROCEDIMIENTOS')
	INNER JOIN 	tarifarios_estancias tar on (tar.cups_id = dep.cups_id and tar."tipoEstancia" = 'S')	
	WHERE l1.anulado = 'N' and l1.convenio_id = (SELECT max(l2.convenio_id) 
											FROM facturacion_liquidacion l2 
											where  l2."tipoDoc_id" = l1."tipoDoc_id" AND l2.documento_id = l1.documento_id AND l2."consecAdmision" = l1."consecAdmision")
LOOP 
			
			raise notice 'Voy a guardar encabezados : %s' , tabla.id;
			Update facturacion_liquidacion SET  "totalProcedimientos" = "totalProcedimientos" + tabla.valor        where id = tabla.id;
			raise notice 'ya guarde1: %s' , tabla.id;
			Update facturacion_liquidacion SET  "totalLiquidacion" = "totalSuministros" + "totalProcedimientos"    where id = tabla.id;
			raise notice 'ya guarde2: : %s' , tabla.id;
			Update facturacion_liquidacion SET  "valorApagar" = "totalLiquidacion" - "totalRecibido"    where id = tabla.id;
			raise notice 'En teoria ya guardes : %s' , tabla.valor;

END LOOP;



/* TERCERO PARTICULAR */


INSERT INTO facturacion_liquidaciondetalle(consecutivo, fecha, cantidad, "valorUnitario", "valorTotal",  "fechaCrea", 
		observaciones, "fechaRegistro", "estadoRegistro", examen_id, liquidacion_id 
		,"tipoRegistro",anulado, "codigoHomologado") 
select 
	(SELECT  coalesce(max(liqDet.consecutivo), 1) AS MaxX
		FROM facturacion_liquidaciondetalle liqdet
		WHERE liqDet.liquidacion_id = l1.id) consecutivo,	
		now(),1,tar.valor,tar.valor,now(),'',now(),'A',dep.cups_id,l1.id,'SISTEMA','N',tar.referencia
FROM facturacion_liquidacion l1
INNER JOIN admisiones_ingresos ing on (ing."tipoDoc_id" = l1."tipoDoc_id" and ing.documento_id = l1.documento_id and ing.consec = l1."consecAdmision")		
INNER JOIN SITIOS_SERVICIOSSEDES servSed on (servSed."sedesClinica_id"=l1."sedesClinica_id")
INNER JOIN clinico_servicios serv on (serv.id =servSed.servicios_id and serv.nombre = 'HOSPITALIZACION' )
INNER JOIN sitios_dependencias dep on (dep."sedesClinica_id" = servSed."sedesClinica_id" AND   dep."serviciosSedes_id" = servSed.id and dep.id=ing."dependenciasActual_id")	
INNER JOIN contratacion_convenios conv on (conv.id = l1.convenio_id)
INNER JOIN tarifarios_tarifariosdescripcion descripcion ON (descripcion.id=conv."tarifariosDescripcionProc_id")	
INNER JOIN 	tarifarios_tipostarifa tiptar on (tiptar.id= descripcion."tiposTarifa_id" AND tiptar.nombre = 'PARTICULAR')	
INNER JOIN 	tarifarios_tipostarifaproducto tipProd on (tipProd.id=tiptar."tiposTarifaProducto_id" and tipProd.nombre='PROCEDIMIENTOS')
INNER JOIN 	tarifarios_estancias tar on (tar.cups_id = dep.cups_id and tar."tipoEstancia" = 'P')	
WHERE l1.anulado = 'N' and l1.convenio_id = (SELECT max(l2.convenio_id) 
											FROM facturacion_liquidacion l2 
											where  l2."tipoDoc_id" = l1."tipoDoc_id" AND l2.documento_id = l1.documento_id AND l2."consecAdmision" = l1."consecAdmision");

FOR tabla IN SELECT * FROM facturacion_liquidacion l1
	INNER JOIN admisiones_ingresos ing on (ing."tipoDoc_id" = l1."tipoDoc_id" and ing.documento_id = l1.documento_id and ing.consec = l1."consecAdmision")		
	INNER JOIN SITIOS_SERVICIOSSEDES servSed on (servSed."sedesClinica_id"=l1."sedesClinica_id")
	INNER JOIN clinico_servicios serv on (serv.id =servSed.servicios_id and serv.nombre = 'HOSPITALIZACION' )
	INNER JOIN sitios_dependencias dep on (dep."sedesClinica_id" = servSed."sedesClinica_id" AND   dep."serviciosSedes_id" = servSed.id and dep.id=ing."dependenciasActual_id")	
	INNER JOIN contratacion_convenios conv on (conv.id = l1.convenio_id)
	INNER JOIN tarifarios_tarifariosdescripcion descripcion ON (descripcion.id=conv."tarifariosDescripcionProc_id")	
	INNER JOIN 	tarifarios_tipostarifa tiptar on (tiptar.id= descripcion."tiposTarifa_id" AND tiptar.nombre = 'PARTICULAR')	
	INNER JOIN 	tarifarios_tipostarifaproducto tipProd on (tipProd.id=tiptar."tiposTarifaProducto_id" and tipProd.nombre='PROCEDIMIENTOS')
	INNER JOIN 	tarifarios_estancias tar on (tar.cups_id = dep.cups_id and tar."tipoEstancia" = 'P')	
	WHERE l1.anulado = 'N' and l1.convenio_id = (SELECT max(l2.convenio_id) 
											FROM facturacion_liquidacion l2 
											where  l2."tipoDoc_id" = l1."tipoDoc_id" AND l2.documento_id = l1.documento_id AND l2."consecAdmision" = l1."consecAdmision")
	
LOOP 
			
			raise notice 'Voy a guardar encabezados : %s' , tabla.id;
			Update facturacion_liquidacion SET  "totalProcedimientos" = "totalProcedimientos" + tabla.valor        where id = tabla.id;
			raise notice 'ya guarde1: %s' , tabla.id;
			Update facturacion_liquidacion SET  "totalLiquidacion" = "totalSuministros" + "totalProcedimientos"    where id = tabla.id;
			raise notice 'ya guarde2: : %s' , tabla.id;
			Update facturacion_liquidacion SET  "valorApagar" = "totalLiquidacion" - "totalRecibido"    where id = tabla.id;
			raise notice 'En teoria ya guardes : %s' , tabla.valor;

END LOOP;


RETURN 'OK'; 
END 
$BODY$;
ALTER FUNCTION public.creaEstanciaAutomatica()
    OWNER TO postgres;
  

select * from facturacion_liquidacion;
update facturacion_liquidacion set "totalProcedimientos" = 0,"totalLiquidacion"=0,"valorApagar"=0 where id=300
select * from facturacion_liquidaciondetalle;
delete from facturacion_liquidaciondetalle where liquidacion_id=300
select * from tarifarios_estancias
SELECT creaEstanciaAutomatica();
SELECT * FROM facturacion_conceptos;
select concepto_id,* from clinico_examenes
select * from clinico_tiposexamen
select * from usuarios_usuarios;
select * from tarifarios_estancias
	select * from admisiones_ingresos
	select * from tarifarios_tipostarifaproducto
	select * from contratacion_convenios
	select * from clinico_servicios
	select * from SITIOS_SERVICIOSSEDES
	select * from tarifarios_tipostarifa
	select * from tarifarios_tarifariosdescripcion
select "sedesClinica_id","serviciosSedes_id", * from sitios_dependencias where documento_id is not null order by  "sedesClinica_id","serviciosSedes_id"
	select "sedesClinica_id","serviciosSedes_id", * from sitios_dependencias  order by  "sedesClinica_id","serviciosSedes_id"
	select * from sitios_dependencias where cups_id=4032
	select * from facturacion_liquidacion

	- delete from facturacion_liquidaciondetalle where liquidacion_id=300

	select anulado,* from facturacion_liquidacion	
	update facturacion_liquidacion set anulado='N' where id=300

select * from facturacion_liquidaciondetalle where liquidacion_id=300

select concepto_id,* from clinico_examenes where id = 4032
select * from facturacion_conceptos;

select * from cartera_notascredito
select * from cartera_glosas
select * from cartera_glosasdetalle

