
-- OTROS SERVICIOS
-- MANUAL		
		
INSERT INTO rips_ripsotrosservicios ( "codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia", "nomTecnologiaSalud", "cantidadOS", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio", "valorPagoModerador", "numFEVPagoModerador", consecutivo, "fechaRegistro", "codTecnologiaSalud_id", "conceptoRecaudo_id", "tipoDocumentoIdentificacion_id", "tipoOS_id", "usuarioRegistro_id", "ripsDetalle_id", "itemFactura", "ripsTipos_id", "ripsTransaccion_id", glosa_id, "cantidadAceptada", "cantidadGlosada", "cantidadSoportado", "motivoGlosa_id", "notasCreditoGlosa", "notasCreditoOtras", "notasDebito", "vAceptado", "valorGlosado", "valorSoportado", "estadoReg", ingreso_id
)
SELECT sed."codigoHabilitacion", facdet."fecha", null mipres, null numeroAutorizacion,usu.documento,facdet."valorTotal",'cccc', fac.id,
	row_number() OVER(ORDER BY facdet.id) AS consecutivo, now(), null,diag1.id,diag2.id,	exa.id, serv.id, '5', 	final.id, gru.id, mod.id,
	tipdocrips.id, '1', ingreso.id, detrips.id, facdet."consecutivoFactura", '4',
	(select max(ripsmoderadora.id) from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora where  i."tipoDoc_id" =  pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)),'tx','A','ingresoId.id'
	FROM sitios_sedesclinica sed inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id) 
	inner join  facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R') and "tipoRegistro" = 'MANUAL')
	inner join clinico_examenes exa ON (exa.id = facdet."examen_id" ) 
	inner  join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision") 
	left join rips_ripsviasingresosalud ingreso ON (ingreso.id = i."ripsViaIngresoServicioSalud_id") 
	inner  join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id)
	inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id)
	left join rips_ripsmodalidadatencion  mod ON (mod.id = i."ripsmodalidadGrupoServicioTecSal_id") 
	left join rips_ripsgruposervicios gru ON (gru.id = i."ripsGrupoServicios_id") 
	left join rips_ripsServicios serv ON (serv.id = i."ripsGrupoServicios_id")  
	left join rips_ripsfinalidadconsulta final on (final.id = i."ripsFinalidadConsulta_id") 
	inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) 
	left join rips_ripstiposdocumento tipdocrips on (tipdocrips.id = tipdoc."tipoDocRips_id" )
	inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )
	left join clinico_diagnosticos diag1 on (diag1.id=i."dxActual_id")
	left join clinico_diagnosticos diag2 on (diag2.id= i."dxIngreso_id") 
	where sed.id = '1' and e.id = '72' and fac.id = '151' and facdet.examen_id is not null

 
select * from rips_ripsotrosservicios
	select * from rips_ripstipootrosservicios
	select * from rips_ripsenvios
	select * from rips_ripsdetalle
	select "tipoHonorario_id",cirugia_id,"tipoRegistro",examen_id,cums_id,* from facturacion_facturaciondetalle where facturacion_id=152;
select * from facturacion_facturacion where id=151
select * from clinico_historia where documento_id='16'	
select * from tarifarios_tiposhonorarios;
UPDATE tarifarios_tiposhonorarios SET "ripsTipoOtrosServicios_id"= 5 where id=5
select * from autorizaciones_autorizaciones;
select * from facturacion_suministros where id = 34657

 
-- OPS No existe un FOLIO para la cirugia (En que momento se deberia crear folio de la cirugia ???)
  -- IDEAS cuando crea la cirugia O mejor caundo relaiza la Cirugia crea Automaticamente un folio en HC y un registro en clinico_historialcirugias y encadena la cirugia y YAP, puede ser 
-- SISTEMA
-- Veamos el de material Qx
-- ops que es que una cirugia requiera autorizacion
   select * from rips_ripstipospagomoderador
	   select * from cartera_pagosfacturas
	   
 select * from cirugia_cirugias;
select * from admisiones_ingresos
select * from facturacion_conveniospacienteingresos	
	select * from contratacion_convenios
 
-- PRIMER QUERY DISPOSITIVOS MEDICOS	SISTEMA
select "tipoHonorario_id",cirugia_id,"tipoRegistro",examen_id, cums_id,* from facturacion_facturaciondetalle where facturacion_id =	152
select * from tarifarios_tiposhonorarios;
select * from rips_ripstipootrosservicios
	select * from facturacion_suministros where id=3178
	select * from clinico_examenes where id=3178
	select "ripsCums_id",* from facturacion_suministros where id =34657 -- SOND019,, ripsCums_id
	UPDATE facturacion_suministros SET "ripsCums_id" = 17006 WHERE  id =34657
	select * from rips_ripsotrosservicios;
select * from rips_ripstipos
	select * from rips_ripscums where nombre like ('%SONDA NELA%') -- 17006
	select * from rips_ripscums where id=34657
	select * from rips_ripscums where id=3178 -- ojo esta mal el primer query de otros servivios en el codigo cuu
	 
INSERT INTO rips_ripsotrosservicios ( "codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia","tipoOS_id", "codTecnologiaSalud_id",
	"nomTecnologiaSalud", "cantidadOS", 	"tipoDocumentoIdentificacion_id", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio",	
	"tipoPagoModerador_id",	"valorPagoModerador","numFEVPagoModerador", consecutivo, "fechaRegistro",
	"usuarioRegistro_id",	"ripsDetalle_id", "itemFactura", "ripsTipos_id",
	"ripsTransaccion_id", "estadoReg", ingreso_id
)
SELECT sed."codigoHabilitacion", autdet."numeroAutorizacion", his.mipres, facdet."fecha",   ripsOtros.id,  exa.id,  substring(exa.nombre,1,60), facdet.cantidad,
	tipdocrips.id, usu.documento,facdet."valorUnitario",	facdet."valorTotal", 
	(select max(ripsmoderadora.id) 
	from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac
	where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), 
	(select carFac."valorAplicado"
	from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac
	where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), 
    fac.id, row_number()  OVER(ORDER BY facdet.id)  AS consecutivo, now(), '1',detrips.id,facdet."consecutivoFactura",'9' ,
	1,'A',50364
	FROM sitios_sedesclinica sed 
	inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)
	inner join facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R') and "tipoRegistro" = 'SISTEMA' AND facDet.cirugia_id is not null)
	inner join clinico_examenes exa ON (exa.id = facdet."examen_id")
	inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision")	
	inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) 
	inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) 
	inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" )
	left join  rips_ripstiposdocumento tipdocrips on (tipdocrips.id = tipdoc."tipoDocRips_id" ) 
	inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )  
	left join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec ) 
	inner join clinico_historialcirugias hisCiru ON (hisCiru.historia_id = his.id and hisCiru.cirugia_id = facDet.cirugia_id) 
	left join autorizaciones_autorizaciones  aut on (aut.historia_id = his.id)
	left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id)
    inner join tarifarios_tiposhonorarios tipHonor on ( tipHonor.id = facDet."tipoHonorario_id"   )
	inner join rips_ripstipootrosservicios ripsOtros on (ripsOtros.id=tipHonor."ripsTipoOtrosServicios_id"  and ripsOtros.nombre='DISPOSITIVOS MEDICOS E INSUMOS')
	where sed.id = '1' and e.id = '73' and fac.id = '152'
 
	
-- SEGUNDO QUERY DISPOSITIVOS MEDICOS MANUAL
	

INSERT INTO rips_ripsotrosservicios ( "codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia","tipoOS_id", "codTecnologiaSalud_id",
	"nomTecnologiaSalud", "cantidadOS", 	"tipoDocumentoIdentificacion_id", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio",	"tipoPagoModerador_id",	"valorPagoModerador","numFEVPagoModerador", consecutivo, "fechaRegistro",   "usuarioRegistro_id",	"ripsDetalle_id", "itemFactura", "ripsTipos_id",
	"ripsTransaccion_id", "estadoReg", ingreso_id
)
SELECT sed."codigoHabilitacion", autdet."numeroAutorizacion", his.mipres, facdet."fecha",   ripsOtros.id,  ripsCums.id,  substring(exa.nombre,1,60), facdet.cantidad,
	tipdocrips.id, usu.documento,facdet."valorUnitario",	facdet."valorTotal", 
	(select max(ripsmoderadora.id) 
	from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac
	where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), 
	(select carFac."valorAplicado"
	from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac
	where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), 
    fac.id, row_number()  OVER(ORDER BY facdet.id) + 1 AS consecutivo, now(), 1,detrips.id,facdet."consecutivoFactura",'5' ,
	1,'A',50364
	FROM sitios_sedesclinica sed 
	inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)
	inner join facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."cums_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R') and "tipoRegistro" = 'MANUAL' AND facDet.cirugia_id is not null)
	inner join facturacion_suministros exa ON (exa.id = facdet."cums_id")
	inner join rips_ripscums ripsCums ON (ripsCums.id = exa."ripsCums_id")
	inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision")	
	inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) 
	inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) 
	inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" )
	left join  rips_ripstiposdocumento tipdocrips on (tipdocrips.id = tipdoc."tipoDocRips_id" ) 
	inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )  
	left join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec ) 
	inner join clinico_historialcirugias hisCiru ON (hisCiru.historia_id = his.id and hisCiru.cirugia_id = facDet.cirugia_id) 
	left join autorizaciones_autorizaciones  aut on (aut.historia_id = his.id)
	left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id)
 --   inner join tarifarios_tiposhonorarios tipHonor on ( tipHonor.id = facDet."tipoHonorario_id"   )
	--inner join rips_ripstipootrosservicios ripsOtros on (ripsOtros.id=tipHonor."ripsTipoOtrosServicios_id"  and ripsOtros.nombre='DISPOSITIVOS MEDICOS E INSUMOS')
	inner join rips_ripstipootrosservicios ripsOtros on (ripsOtros.nombre='DISPOSITIVOS MEDICOS E INSUMOS')
	where sed.id = '1' and e.id = '73' and fac.id = '152'
 


	 
-- TERCER QUERY HONORARIOS MEDICOS SISTEMA

INSERT INTO rips_ripsotrosservicios ( "codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia","tipoOS_id", "codTecnologiaSalud_id",
	"nomTecnologiaSalud", "cantidadOS", 	"tipoDocumentoIdentificacion_id", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio",	"tipoPagoModerador_id",	"valorPagoModerador","numFEVPagoModerador", consecutivo, "fechaRegistro",   "usuarioRegistro_id",	"ripsDetalle_id", "itemFactura", "ripsTipos_id", "ripsTransaccion_id", "estadoReg", ingreso_id
)
SELECT facDet."tipoHonorario_id" ,ripsOtros.id, ripsOtros.nombre,sed."codigoHabilitacion", autdet."numeroAutorizacion", his.mipres, facdet."fecha",
	ripsOtros.id,  exa.id,  exa.nombre, facdet.cantidad,
	tipdocrips.id, usu.documento,facdet."valorUnitario",	facdet."valorTotal", 
	(select max(ripsmoderadora.id) 
	from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac
	where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), 
	(select carFac."valorAplicado"
	from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac
	where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), 
    fac.id, row_number()  OVER(ORDER BY facdet.id) + 1 AS consecutivo, now(), 1,detrips.id,facdet."consecutivoFactura",'5' ,
	1,'A',50364
	FROM sitios_sedesclinica sed 
	inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)
	inner join facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R') and "tipoRegistro" = 'SISTEMA' AND facDet.cirugia_id is not null)
	inner join clinico_examenes exa ON (exa.id = facdet."examen_id")
	inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision")
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
	inner join rips_ripstipootrosservicios ripsOtros on ( ripsOtros.id=tipHonor."ripsTipoOtrosServicios_id" and ripsOtros.nombre='HONORARIOS' )
	where sed.id = '1' and e.id = '73' and fac.id = '152'  

select "tipoHonorario_id", examen_id, anulado, "tipoRegistro",cirugia_id,* from facturacion_facturaciondetalle
select * from clinico_historialcirugias 

	-- CUARTO QUERY HONORARIOS MANUAL

INSERT INTO rips_ripsotrosservicios ( "codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia","tipoOS_id", "codTecnologiaSalud_id",
	"nomTecnologiaSalud", "cantidadOS", 	"tipoDocumentoIdentificacion_id", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio",	"tipoPagoModerador_id",	"valorPagoModerador","numFEVPagoModerador", consecutivo, "fechaRegistro",   "usuarioRegistro_id",	"ripsDetalle_id", "itemFactura", "ripsTipos_id", "ripsTransaccion_id", "estadoReg", ingreso_id
)
SELECT facDet."tipoHonorario_id" ,ripsOtros.id, ripsOtros.nombre,sed."codigoHabilitacion", autdet."numeroAutorizacion", his.mipres, facdet."fecha",
	ripsOtros.id,  exa.id,  exa.nombre, facdet.cantidad,
	tipdocrips.id, usu.documento,facdet."valorUnitario",	facdet."valorTotal", 
	(select max(ripsmoderadora.id) 
	from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac
	where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), 
	(select carFac."valorAplicado"
	from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac
	where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), 
    fac.id, row_number()  OVER(ORDER BY facdet.id) + 1 AS consecutivo, now(), 1,detrips.id,facdet."consecutivoFactura",'5' ,
	1,'A',50364
	FROM sitios_sedesclinica sed 
	inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)
	inner join facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R') and "tipoRegistro" = 'MANUAL' AND facDet.cirugia_id is not null)
	inner join clinico_examenes exa ON (exa.id = facdet."examen_id")
	inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision")
	inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) 
	inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) 
	inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" )
	left join  rips_ripstiposdocumento tipdocrips on (tipdocrips.id = tipdoc."tipoDocRips_id" ) 
	inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )  
	left join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec ) 
	left join clinico_historialcirugias hisCiru ON (hisCiru.historia_id = his.id and hisCiru.cirugia_id = facDet.cirugia_id ) 
	left join autorizaciones_autorizaciones  aut on (aut.historia_id = his.id)
	left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id)
    inner join tarifarios_tiposhonorarios tipHonor on ( tipHonor.id = facDet."tipoHonorario_id" )
	inner join rips_ripstipootrosservicios ripsOtros on ( ripsOtros.id=tipHonor."ripsTipoOtrosServicios_id" and ripsOtros.nombre='HONORARIOS' )
	where sed.id = '1' and e.id = '73' and fac.id = '152'  
 


-- QUINTO QUERY ESTANCIAS SISTEMA

INSERT INTO rips_ripsotrosservicios ( "codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia","tipoOS_id", "codTecnologiaSalud_id",
	"nomTecnologiaSalud", "cantidadOS", 	"tipoDocumentoIdentificacion_id", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio",	"tipoPagoModerador_id",	"valorPagoModerador","numFEVPagoModerador", consecutivo, "fechaRegistro",   "usuarioRegistro_id",	"ripsDetalle_id", "itemFactura", "ripsTipos_id", "ripsTransaccion_id", "estadoReg", ingreso_id
)
SELECT sed."codigoHabilitacion", ' ', ' ' , facdet."fecha",
	ripsOtros.id,  exa.id,  exa.nombre, facdet.cantidad,
	tipdocrips.id, usu.documento,facdet."valorUnitario",	facdet."valorTotal", 
	(select max(ripsmoderadora.id) 
	from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac
	where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), 
	(select carFac."valorAplicado"
	from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora , cartera_pagosfacturas carFac
	where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and carFac.pago_id = pagos.id and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), 
    fac.id, row_number()  OVER(ORDER BY facdet.id) + 1 AS consecutivo, now(), 1,detrips.id,facdet."consecutivoFactura",'5' ,
	1,'A',50364
	FROM sitios_sedesclinica sed 
	inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)
	inner join facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R') and "tipoRegistro" = 'SISTEMA' AND facDet.cirugia_id is not null)
	inner join clinico_examenes exa ON (exa.id = facdet."examen_id")
	inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision")
	inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) 
	inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) 
	inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" )
	left join  rips_ripstiposdocumento tipdocrips on (tipdocrips.id = tipdoc."tipoDocRips_id" ) 
	inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )  
    inner join facturacion_conceptos concepto on ( concepto.id = exa.concepto_id and exa.nombre='ESTANCIAS')
	inner join rips_ripstipootrosservicios ripsOtros on (  ripsOtros.nombre='ESTANCIAS' )
	where sed.id = '1' and e.id = '72' and fac.id = '151'  

SELECT * FROM facturacion_conceptos
  


-- SEXTO QUERY ESTANCIAS MANUAL

-------------
select "consecAdmision","estadoCirugia_id",* from cirugia_cirugias
select * from cirugia_estadoscirugias;
select * from clinico_historialcirugias
select * from clinico_tiposfolio
update cirugia_cirugias set "estadoCirugia_id"=3 where id=40
select * from clinico_historia order by id desc

select "tipoHonorario_id",* from facturacion_liquidaciondetalle
	
 (select 'Cod:'||' '|| detFac."codigoHomologado" ||'$'|| sum(detFac."valorTotal") 
	FROM facturacion_liquidaciondetalle detFac 
	INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id)
	INNER JOIN tarifarios_tablamaterialsuturacuracion tarMat ON (tarMat."tipoHonorario_id" = detFac."tipoHonorario_id" and tarMat."grupoQx_id" = exa."grupoQx_id"  )
	where detfac.liquidacion_id= '299' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3' and detFac.examen_id= '3178' and
	tarMat."tipoHonorario_id" = '7'
	GROUP BY detFac."codigoHomologado",exa.nombre) 

select * from tarifarios_tablamaterialsuturacuracion
select * from tarifarios_tiposhonorarios
	select * from cirugia_cirugiasmaterialqx
	select * from facturacion_TiposSuministro
	select examen_id,"tipoHonorario_id","tipoRegistro",* from facturacion_liquidaciondetalle
	SELECT * FROM FACTURACION_LIQUIDACION
select * from facturacion_facturacion where id =	152
	select * from facturacion_facturaciondetalle where facturacion_id =	152

select matqx.suministro_id suministro, sum.nombre nomSuministro , tipos.nombre tipo ,matqx."valorLiquidacion" valorLiquidacionMat 
	from cirugia_cirugiasmaterialqx matqx, facturacion_suministros sum, facturacion_tipossuministro tipos 
	where matqx.cirugia_id= '40' and matqx.suministro_id = sum.id and sum."tipoSuministro_id" = tipos.id  AND
	tipos.id != 10 AND matqx."hojaDeGasto" = 'N'

select matIss.homologado homologado1 , matIss.valor valorLiquidacionMat1 
FROM clinico_examenes exa
INNER JOIN tarifarios_tablamaterialsuturacuracioniss matIss on (matIss."desdeUvr" <= exa."cantidadUvr" AND matIss."hastaUvr" >= exa."cantidadUvr")
	INNER JOIN 	sitios_tipossalas tipsal ON (tipsal.id =matIss."tiposSala_id" and tipsal.id = '1')
	WHERE exa.id = '3178'

	select "cantidadUvr",* from clinico_examenes where id=3178
	select * from tarifarios_tablamaterialsuturacuracioniss


select matIss.homologado homologado1 , matIss.valor valorLiquidacionMat1 
FROM clinico_examenes exa 
INNER JOIN tarifarios_tablamaterialsuturacuracioniss matIss on (matIss."desdeUvr" <= exa."cantidadUvr" AND matIss."hastaUvr" >= exa."cantidadUvr") 
	INNER JOIN  sitios_tipossalas tipsal ON (tipsal.id =matIss."tiposSala_id"	and tipsal.id = '5' ) WHERE exa.id = '3178'

select sala_id,* from cirugia_cirugias  
select * from sitios_tipossalas	
select * from sitios_salas

select matIss.homologado homologado1 , matIss.valor valorLiquidacionMat1 
FROM clinico_examenes exa 
INNER JOIN tarifarios_tablamaterialsuturacuracioniss matIss on (matIss."desdeUvr" <= exa."cantidadUvr" AND matIss."hastaUvr" >= exa."cantidadUvr") 
	INNER JOIN  sitios_tipossalas tipsal ON (tipsal.id =matIss."tiposSala_id"	) 
	INNER JOIN cirugia_cirugias cir on (cir.id = 40)
	INNER JOIN sitios_salas sal ON (sal.id=cir.sala_id and sal."tipoSala_id" = tipsal.id)
	WHERE exa.id = '3178'


