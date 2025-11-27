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
select * from cartera_glosasdetalle
--	delete from cartera_glosasdetalle where id=22
select * from cartera_glosasdetallerips
select * from rips_ripstransaccion order by id desc
	SELECT * FROM RIPS_RIPSUSUARIOS ORDER BY ID DESC
select * from rips_ripsotrosservicios 	

select * from facturacion_facturaciondetalle where facturacion_id=152 -- 9 / 9
select * from facturacion_facturaciondetalle where facturacion_id=151 -- 11 / 20
select * from cartera_glosasdetallerips

	select * from rips_ripstransaccion
--
select * from rips_ripsprocedimientos WHERE "numFEVPagoModerador" = '151' -- 6/3
select * from rips_ripsmedicamentos WHERE "numFEVPagoModerador" = '151'  -- 9/8
	select * from rips_ripsotrosservicios WHERE "numFEVPagoModerador" = '152'  -- 9/8
select 'MEDICAMENTOS' tipo,med.id, med.consecutivo consec, med."itemFactura",cums.cum codigo,cums.nombre nombre,substring(mot.nombre,1,10) glosaNombre,med."vrServicio",  gloDetRips."valorGlosa",    gloDetRips."valorSoportado" valosSoportado,   gloDetRips."valorAceptado" ,    gloDetRips."valorNotasCredito" , gloDetRips.id gloDetRips, gloDet.glosa_id glosaId  FROM rips_ripstransaccion ripstra inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id)    inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) inner join cartera_glosasdetalle gloDet on (gloDet.id = '21') left join cartera_glosasdetalleRips gloDetRips on (gloDetRips."glosasDetalle_id" =  gloDet.id and  gloDetRips."itemFactura" = det."consecutivoFactura" AND gloDetRips."ripsMedicamentos_id" = med.id) left join cartera_motivosglosas mot on (mot.id = gloDetRips."motivoGlosa_id") where cast(ripstra."numFactura" as float) = '151' and ripstra."numNota"= '0'
UNION
select 'PROCEDIMIENTOS' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", exa."codigoCups" codigo,    exa.nombre nombre,  substring(mot.nombre,1,10)  glosaNombre,proc."vrServicio",gloDetRips."valorGlosa",    gloDetRips."valorSoportado" valosSoportado,   gloDetRips."valorAceptado" ,    gloDetRips."valorNotasCredito" , gloDetRips.id gloDetRipsId , gloDet.glosa_id glosaId  FROM  rips_ripstransaccion ripstra inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = proc."itemFactura") inner join cartera_glosasdetalle gloDet on (gloDet.id = '21') left join cartera_glosasdetalleRips gloDetRips on (gloDetRips."glosasDetalle_id" =  gloDet.id and  gloDetRips."itemFactura" = det."consecutivoFactura" AND gloDetRips."ripsProcedimientos_id" = proc.id) left join cartera_motivosglosas mot on (mot.id = gloDetRips."motivoGlosa_id") where cast(ripstra."numFactura" as float) = '152' and ripstra."numNota"= '0'
UNION
select 'CONSULTAS' tipo, cons.id, cons.consecutivo consec, cons."itemFactura", exa."codigoCups" codigo,  exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre,cons."vrServicio",        gloDetRips."valorGlosa",    gloDetRips."valorSoportado" valosSoportado,   gloDetRips."valorAceptado" ,    gloDetRips."valorNotasCredito", gloDetRips.id gloDetRipsId , gloDet.glosa_id glosaId    FROM rips_ripstransaccion  ripstra inner join  rips_ripsconsultas cons on (cons."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =cons."codConsulta_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = cons."itemFactura") inner join cartera_glosasdetalle gloDet on (gloDet.id = '21') left join cartera_glosasdetalleRips gloDetRips on (gloDetRips."glosasDetalle_id" =  gloDet.id and  gloDetRips."itemFactura" = det."consecutivoFactura" AND gloDetRips."ripsConsultas_id" = cons.id) left join cartera_motivosglosas mot on (mot.id = gloDetRips."motivoGlosa_id")      where cast(ripstra."numFactura" as float) = '151' and ripstra."numNota"= '0'
UNION
select 'OTROS SERVICIOS' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre, serv."vrServicio",     gloDetRips."valorGlosa",    gloDetRips."valorSoportado" valosSoportado,   gloDetRips."valorAceptado" ,    gloDetRips."valorNotasCredito", gloDetRips.id gloDetRipsId  , gloDet.glosa_id glosaId FROM rips_ripstransaccion  ripstra inner join  rips_ripsotrosservicios serv on (serv."ripsTransaccion_id" = ripstra.id) left join clinico_examenes exa on ( exa.id =serv."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = serv."itemFactura") inner join cartera_glosasdetalle gloDet on (gloDet.id = '21') left join cartera_glosasdetalleRips gloDetRips on (gloDetRips."glosasDetalle_id" =  gloDet.id and  gloDetRips."itemFactura" = det."consecutivoFactura" AND gloDetRips."ripsOtrosServicios_id" = serv.id) left join cartera_motivosglosas mot on (mot.id = gloDetRips."motivoGlosa_id")    where cast(ripstra."numFactura" as float) = '151' and ripstra."numNota"= '0' order by 1,4
