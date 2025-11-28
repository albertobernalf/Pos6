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
select 'MEDICAMENTOS' tipo,med.id, med.consecutivo consec, med."itemFactura",cums.cum codigo,cums.nombre nombre,substring(mot.nombre,1,10) glosaNombre,med."vrServicio",  gloDetRips."valorGlosa",    gloDetRips."valorSoportado" valosSoportado,   gloDetRips."valorAceptado" ,    gloDetRips."valorNotasCredito" , gloDetRips.id gloDetRips, gloDet.glosa_id glosaId  FROM rips_ripstransaccion ripstra inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id)    inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) inner join cartera_glosasdetalle gloDet on (gloDet.id = '21') left join cartera_glosasdetalleRips gloDetRips on (gloDetRips."glosasDetalle_id" =  gloDet.id and  gloDetRips."itemFactura" = det."consecutivoFactura" AND gloDetRips."ripsMedicamentos_id" = med.id) left join cartera_motivosglosas mot on (mot.id = gloDetRips."motivoGlosa_id") where cast(ripstra."numFactura" as float) = '152' and ripstra."numNota"= '0'
UNION
select 'PROCEDIMIENTOS' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", exa."codigoCups" codigo,    exa.nombre nombre,  substring(mot.nombre,1,10)  glosaNombre,proc."vrServicio",gloDetRips."valorGlosa",    gloDetRips."valorSoportado" valosSoportado,   gloDetRips."valorAceptado" ,    gloDetRips."valorNotasCredito" , gloDetRips.id gloDetRipsId , gloDet.glosa_id glosaId  FROM  rips_ripstransaccion ripstra inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = proc."itemFactura") inner join cartera_glosasdetalle gloDet on (gloDet.id = '21') left join cartera_glosasdetalleRips gloDetRips on (gloDetRips."glosasDetalle_id" =  gloDet.id and  gloDetRips."itemFactura" = det."consecutivoFactura" AND gloDetRips."ripsProcedimientos_id" = proc.id) left join cartera_motivosglosas mot on (mot.id = gloDetRips."motivoGlosa_id") where cast(ripstra."numFactura" as float) = '152' and ripstra."numNota"= '0'
UNION
select 'CONSULTAS' tipo, cons.id, cons.consecutivo consec, cons."itemFactura", exa."codigoCups" codigo,  exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre,cons."vrServicio",        gloDetRips."valorGlosa",    gloDetRips."valorSoportado" valosSoportado,   gloDetRips."valorAceptado" ,    gloDetRips."valorNotasCredito", gloDetRips.id gloDetRipsId , gloDet.glosa_id glosaId    FROM rips_ripstransaccion  ripstra inner join  rips_ripsconsultas cons on (cons."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =cons."codConsulta_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = cons."itemFactura") inner join cartera_glosasdetalle gloDet on (gloDet.id = '21') left join cartera_glosasdetalleRips gloDetRips on (gloDetRips."glosasDetalle_id" =  gloDet.id and  gloDetRips."itemFactura" = det."consecutivoFactura" AND gloDetRips."ripsConsultas_id" = cons.id) left join cartera_motivosglosas mot on (mot.id = gloDetRips."motivoGlosa_id")      where cast(ripstra."numFactura" as float) = '152' and ripstra."numNota"= '0'
UNION
select 'OTROS SERVICIOS' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre, serv."vrServicio",     gloDetRips."valorGlosa",    gloDetRips."valorSoportado" valosSoportado,   gloDetRips."valorAceptado" ,    gloDetRips."valorNotasCredito", gloDetRips.id gloDetRipsId  , gloDet.glosa_id glosaId FROM rips_ripstransaccion  ripstra inner join  rips_ripsotrosservicios serv on (serv."ripsTransaccion_id" = ripstra.id) left join clinico_examenes exa on ( exa.id =serv."codTecnologiaSalud_id" )  inner join cartera_glosasdetalle gloDet on (gloDet.id = '21') left join cartera_glosasdetalleRips gloDetRips on (gloDetRips."glosasDetalle_id" =  gloDet.id and  gloDetRips."itemFactura" = serv."itemFactura" AND gloDetRips."ripsOtrosServicios_id" = serv.id) left join cartera_motivosglosas mot on (mot.id = gloDetRips."motivoGlosa_id")    where cast(ripstra."numFactura" as float) = '152' and ripstra."numNota"= '0' order by 1,4
--------------
-----------------
select 'MEDICAMENTOS' tipo,med.id, med.consecutivo consec, med."itemFactura",cums.cum codigo,cums.nombre nombre,substring(mot.nombre,1,10) glosaNombre,med."vrServicio",  gloDetRips."valorGlosa",    gloDetRips."valorSoportado" valosSoportado,   gloDetRips."valorAceptado" ,    gloDetRips."valorNotasCredito" , gloDetRips.id gloDetRips, gloDet.glosa_id glosaId  FROM rips_ripstransaccion ripstra inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id)       inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) inner join cartera_glosasdetalle gloDet on (gloDet.id = '23') left join cartera_glosasdetalleRips gloDetRips on (gloDetRips."glosasDetalle_id" =  gloDet.id and  gloDetRips."itemFactura" = med."itemFactura" AND gloDetRips."ripsMedicamentos_id" = med.id) left join cartera_motivosglosas mot on (mot.id = gloDetRips."motivoGlosa_id") where cast(ripstra."numFactura" as float) = '151' and ripstra."numNota"= '0'
UNION 
select 'PROCEDIMIENTOS' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", exa."codigoCups" codigo,    exa.nombre nombre,  substring(mot.nombre,1,10)  glosaNombre,proc."vrServicio",gloDetRips."valorGlosa",    gloDetRips."valorSoportado" valosSoportado,   gloDetRips."valorAceptado" ,    gloDetRips."valorNotasCredito" , gloDetRips.id gloDetRipsId , gloDet.glosa_id glosaId  FROM  rips_ripstransaccion ripstra inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) inner join cartera_glosasdetalle gloDet on (gloDet.id = '23') left join cartera_glosasdetalleRips gloDetRips on (gloDetRips."glosasDetalle_id" =  gloDet.id and  gloDetRips."itemFactura" = proc."itemFactura" AND gloDetRips."ripsProcedimientos_id" = proc.id) left join cartera_motivosglosas mot on (mot.id = gloDetRips."motivoGlosa_id") where cast(ripstra."numFactura" as float) = '152' and ripstra."numNota"= '0' 
UNION
select 'CONSULTAS' tipo, cons.id, cons.consecutivo consec, cons."itemFactura", exa."codigoCups" codigo,      exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre,cons."vrServicio",   gloDetRips."valorGlosa",    gloDetRips."valorSoportado" valosSoportado,   gloDetRips."valorAceptado" ,    gloDetRips."valorNotasCredito", gloDetRips.id gloDetRipsId , gloDet.glosa_id glosaId  FROM rips_ripstransaccion  ripstra inner join  rips_ripsconsultas cons on (cons."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =cons."codConsulta_id" ) inner join cartera_glosasdetalle gloDet on (gloDet.id = '23') left join cartera_glosasdetalleRips gloDetRips on (gloDetRips."glosasDetalle_id" =  gloDet.id and  gloDetRips."itemFactura" = cons."itemFactura" AND gloDetRips."ripsConsultas_id" = cons.id) left join cartera_motivosglosas mot on (mot.id = gloDetRips."motivoGlosa_id")        where cast(ripstra."numFactura" as float) = '152' and ripstra."numNota"= '0'
UNION
select 'OTROS SERVICIOS' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre, serv."vrServicio",   gloDetRips."valorGlosa",    gloDetRips."valorSoportado" valosSoportado,   gloDetRips."valorAceptado" ,    gloDetRips."valorNotasCredito", gloDetRips.id gloDetRipsId  , gloDet.glosa_id glosaId FROM rips_ripstransaccion  ripstra inner join  rips_ripsotrosservicios serv on (serv."ripsTransaccion_id" = ripstra.id) left join clinico_examenes exa on ( exa.id =serv."codTecnologiaSalud_id" ) inner join cartera_glosasdetalle gloDet on (gloDet.id = '23') left join cartera_glosasdetalleRips gloDetRips on (gloDetRips."glosasDetalle_id" =  gloDet.id and  gloDetRips."itemFactura" = serv."itemFactura" AND gloDetRips."ripsOtrosServicios_id" = serv.id) left join cartera_motivosglosas mot on (mot.id = gloDetRips."motivoGlosa_id")       where cast(ripstra."numFactura" as float) = '152' and ripstra."numNota"= '0' order by 1,4

select * from rips_ripsotrosservicios


-- delete from cartera_glosas
-- delete from cartera_glosasdetalle
--delete from cartera_glosasdetallerips
select * from rips_ripsdetalle
delete from rips_ripsdetalle where id = 139
update cartera_glosas set "totalAceptado" = 0, "totalGlosa" = 0, "totalNotasCredito"= 0

	select * from rips_ripshospitalizacion -- ripstransaccion 980 //  139 ripsdetalle

	select * from cartera_tiposglosas
	select * from rips_ripstransaccion
delete from rips_ripshospitalizacion	where "ripsTransaccion_id" =980
delete from rips_ripsprocedimientos	where "ripsTransaccion_id" =980
delete from rips_ripsmedicamentos	where "ripsTransaccion_id" =980
delete from rips_ripsreciennacidos	where "ripsTransaccion_id" =980
delete from rips_ripsusuarios	where "ripsTransaccion_id" =980
delete from rips_ripsmedicamentos	where "ripsTransaccion_id" =980
delete from rips_ripsotrosservicios	where "ripsTransaccion_id" =980
	delete from rips_ripstransaccion	where id =980
	

update cartera_glosasdetalle set "valorAceptado" = 0, "valorNotasCredito" =0,"valorSoportado"=0

select id, "valorApagar", "totalValorGlosado","totalValorAceptado","totalValorSoportado", "totalNotasCredito","totalNotasDebito",  "saldoFactura", * from facturacion_facturacion;
update facturacion_facturacion set "totalValorGlosado"=0, "totalNotasCredito"=0, "totalValorAceptado" = 0 where id=151
	
update cartera_glosasdetalle set "valorGlosa" = 200000
	
delete from cartera_glosasdetallerips
select * from cartera_glosas
select * from cartera_glosasdetallerips
select * from cartera_glosasdetalle
	select * from facturacion_facturacion
select * from rips_ripsmedicamentos

select * from rips_ripstransaccion order by id desc
 SELECT  "codPrestador","viaIngresoServicioSalud_id","fechaInicioAtencion", "numAutorizacion","causaMotivoAtencion_id","codComplicacion_id", "codDiagnosticoPrincipal_id", "codDiagnosticoPrincipalE_id",  "codDiagnosticoRelacionadoE1_id", "codDiagnosticoRelacionadoE2_id", "codDiagnosticoRelacionadoE3_id","condicionDestinoUsuarioEgreso_id", "codDiagnosticoCausaMuerte_id","fechaEgreso",  consecutivo, ripshosp."usuarioRegistro_id",'153' , "ripsTipos_id",'1092',  ripshosp."fechaRegistro",'50364','A' FROM rips_ripshospitalizacion ripshosp, rips_ripsdetalle det , rips_ripstransaccion ripstra where  ripshosp."ripsTransaccion_id" = ripstra.id and ripshosp."ripsDetalle_id" = det.id and cast(ripstra."numFactura" as float) =  det."numeroFactura_id" and cast(ripstra."numFactura" as float) = '152'  and cast(ripstra."numNota" as integer) = 0
SELECT tipdoc."tipoDocRips_id", tipousu.codigo, cast(u."fechaNacio" as date) , u.genero,u."ripsZonaTerritorial_id",   (select i.incapacidad from admisiones_ingresos i WHERE i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id=fac.documento_id and i.consec=fac."consecAdmision")      , row_number() OVER(ORDER BY det.id) AS consecutivo, now(), muni.id,  case when pais.id is null then '1' else pais.id end, case when pais.id is null then '1' else pais.id end, '1',u.documento, det.id, '1092','A','50364'from rips_ripsenvios e inner join rips_ripsdetalle det on (det."ripsEnvios_id"  = e.id)  inner join  facturacion_facturacion fac on (fac.id = det."numeroFactura_id" ) inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id"  and i.documento_id = fac.documento_id  and i.consec = fac."consecAdmision") inner join usuarios_tiposdocumento tipdoc on ( tipdoc.id=i."tipoDoc_id" )  inner join usuarios_usuarios u on (u."tipoDoc_id"=i."tipoDoc_id" and u.id = i.documento_id) left join sitios_paises  pais on (pais.id= u.pais_id)  left join sitios_municipios muni on ( muni.id = u.municipio_id) left join rips_ripstipousuario tipousu on (tipousu.id = i."ripsTipoUsuario_id") where  e.id= '74' AND det.glosa_id = '42'
	SELECT glosas.id,"codPrestador", "numAutorizacion", "idMIPRES", "fechaSuministroTecnologia", "nomTecnologiaSalud", "cantidadOS", "numDocumentoIdentificacion", "vrUnitOS", "vrServicio", "valorPagoModerador", "numFEVPagoModerador", row_number() OVER(ORDER BY ripsOtros.id) AS consecutivo , ripsOtros."fechaRegistro", "codTecnologiaSalud_id", "conceptoRecaudo_id", "tipoDocumentoIdentificacion_id", "tipoOS_id",ripsOtros."usuarioRegistro_id",'153', ripsOtros."itemFactura", ripsOtros."ripsTipos_id", '1092',gloDetRips."valorNotasCredito" ,'A','50364',"tipoPagoModerador_id" FROM rips_ripsotrosservicios ripsOtros inner join cartera_glosasdetallerips gloDetRips ON (gloDetRips."ripsOtrosServicios_id" = ripsOtros.id) inner join cartera_glosasdetalle gloDet on (gloDet.id = gloDetRips."glosasDetalle_id") inner join cartera_glosas glosas on (glosas.id = gloDet."glosa_id" and gloDet.factura_id = cast(ripsOtros."numFEVPagoModerador"  as integer)) inner join rips_ripsdetalle det on (det."numeroFactura_id" =  cast(ripsOtros."numFEVPagoModerador" as integer) and det."glosa_id"=glosas.id and det."glosa_id" ='42') where ripsOtros."numFEVPagoModerador" = '152'
  SELECT glosas.id, "codPrestador", "fechaInicioAtencion", "idMIPRES", "numAutorizacion","numDocumentoIdentificacion", "vrServicio","valorPagoModerador", "numFEVPagoModerador", row_number() OVER(ORDER BY proc.id) AS consecutivo , '2025-11-28 17:34:05.897384+00:00' , "codComplicacion_id", "codDiagnosticoPrincipal_id","codDiagnosticoRelacionado_id", "codProcedimiento_id", "codServicio_id", "conceptoRecaudo_id", "finalidadTecnologiaSalud_id",     "grupoServicios_id", "modalidadGrupoServicioTecSal_id","tipoDocumentoIdentificacion_id", '1' , "viaIngresoServicioSalud_id",'153', proc."itemFactura", proc."ripsTipos_id",         proc."tipoPagoModerador_id",'1092','A','50364', gloDetRips."valorAceptado" FROM rips_ripsProcedimientos proc inner join cartera_glosasdetallerips gloDetRips on (gloDetRips."ripsProcedimientos_id" = proc.id) inner join cartera_glosasDetalle gloDet on (gloDet.id =  gloDetRips."glosasDetalle_id") inner join cartera_glosas glosas on (glosas.id = gloDet."glosa_id") inner join rips_ripsdetalle det on (det."numeroFactura_id" =  gloDet.factura_id and  det."glosa_id" = '42') where proc."numFEVPagoModerador" = '152'
