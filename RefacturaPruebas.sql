select * from facturacion_liquidacion where "sedesClinica_id" =1 order by fecha;
select * from usuarios_usuarios where id in (16,29,31,17,27);
16	"51872242"	"eumelia"
17	"101213"	"maria camila"
27	"313131"	"MARUJA CAMACHO"
29	"5101718"	"TIO MARCO"
31	"123456"	"HIJA DE EUMELIA"
	
select * from facturacion_liquidacion where "sedesClinica_id" =2 order by fecha;

select * from facturacion_liquidacion  order by fecha;
-- 39 carlos paniagua
select * from usuarios_usuarios;
select * from facturacion_liquidacion where "sedesClinica_id" =1 and documento_id=39;
SELECT "sedesClinica_id",convenio_id,* FROM facturacion_liquidacion WHERE "tipoDoc_id" = 1 AND documento_id = 39 AND "consecAdmision" =2 and convenio_id is null
select "sedesClinica_id",* from admisiones_ingresos where documento_id=39;

select * from facturacion_ConveniosPacienteIngresos where documento_id=39;
delete  from facturacion_ConveniosPacienteIngresos where documento_id=39;
delete from facturacion_liquidacion where id=170;


SELECT "sedesClinica_id",convenio_id,* FROM facturacion_liquidacion WHERE "tipoDoc_id" = 1 AND documento_id = 21

select * from facturacion_facturacion;

select * from sitios_historialdependencias;

select  * from facturacion_liquidacion where documento_id=26;

delete from facturacion_liquidacion where id=154;



select  * from facturacion_liquidacion where documento_id=39;

select * from facturacion_liquidacion where documento_id = 34;
select liquidacion_id,* from facturacion_liquidaciondetalle where liquidacion_id in (173) --,174)
update facturacion_liquidacion set "sedesClinica_id" = 2 where documento_id = 34;

select * from admisiones_ingresos where id = 50122;

UPDATE admisiones_ingresos
set "salidaDefinitiva" ='N'
where id = 50122;

select * from contratacion_convenios;

select * from facturacion_empresas;

select convenio_id,* from facturacion_facturacion where id = 60;

select * from facturacion_refacturacion;

select * from rips_ripsenvios;

select * from rips_ripsdetalle;
select * from rips_ripstransaccion where "ripsEnvio_id" =55
select * from rips_ripsprocedimientos where "ripsTransaccion_id" =176
select * from rips_ripsmedicamentos where "ripsTransaccion_id" =172

select * from facturacion_facturaciondetalle where facturacion_id=60;	

select * from admisiones_ingresos where documento_id = 34;
update admisiones_ingresos set "salidaDefinitiva" = 'N' where documento_id = 34;

-- Ojo ver mañana 30 de abril por que no sales los rips de enste envio en prpocedimeinto

INSERT INTO rips_ripsprocedimientos ("codPrestador", "fechaInicioAtencion", "idMIPRES", "numAutorizacion","numDocumentoIdentificacion", "vrServicio",	"valorPagoModerador", 
	"numFEVPagoModerador", consecutivo, "fechaRegistro", "codComplicacion_id", "codDiagnosticoPrincipal_id","codDiagnosticoRelacionado_id", "codProcedimiento_id",
	"codServicio_id", "conceptoRecaudo_id", "finalidadTecnologiaSalud_id",	"grupoServicios_id", "modalidadGrupoServicioTecSal_id",
	"tipoDocumentoIdentificacion_id","usuarioRegistro_id", "viaIngresoServicioSalud_id", "ripsDetalle_id", "itemFactura", "ripsTipos_id", "tipoPagoModerador_id",
	"ripsTransaccion_id")  
	
	SELECT sed."codigoHabilitacion", facdet."fecha", his.mipres, autdet."numeroAutorizacion",usu.documento, facdet."valorTotal",
	(select max(pagos.valor) from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), fac.id, row_number() OVER(ORDER BY facdet.id) AS consecutivo, now(), 
	(select max(diag4.id) from clinico_diagnosticos diag4 where diag4.id = i."dxComplicacion_id"),(select  max(diag1.id) from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '2') , 
	(select max(diag3.id) from clinico_historialdiagnosticos histdiag3, clinico_diagnosticos diag3 where histdiag3.historia_id = his.id and histdiag3."tiposDiagnostico_id" = '3') ,
	exa.id, serv.id, null, final.id, gru.id, mod.id, tipdocrips.id, '1' , ingreso.id, detrips.id, facdet."consecutivoFactura", '4',
	(select max(ripsmoderadora.id) from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora where  i."tipoDoc_id" =  pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), '172' 
	FROM sitios_sedesclinica sed 
	inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id) 
	inner join  facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and facdet."estadoRegistro" = 'A' ) -- and "tipoRegistro" = 'SISTEMA')
	left join clinico_examenes exa ON (exa.id = facdet."examen_id" ) 
	inner join admisiones_ingresos i on (i.factura = fac.id and i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision") 
	left join rips_ripsviasingresosalud ingreso ON (ingreso.id = i."ripsViaIngresoServicioSalud_id")
	left join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id)
	inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) 
	left join rips_ripsmodalidadatencion mod ON (mod.id = i."ripsmodalidadGrupoServicioTecSal_id") 
	left join rips_ripsgruposervicios gru ON (gru.id = i."ripsGrupoServicios_id") 
	left join rips_ripsServicios serv ON (serv.id = i."ripsGrupoServicios_id")  
	left join  rips_ripsfinalidadconsulta final on (final.id = i."ripsFinalidadConsulta_id")
	inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) 
	left join rips_ripstiposdocumento tipdocrips on (tipdocrips.id=tipdoc."tipoDocRips_id" )
	inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )
	left join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec )
	left join clinico_historiaexamenes hisexa ON (hisexa.historia_id=his.id and hisexa."codigoCups" = exa."codigoCups" and hisexa."consecutivoLiquidacion" = facdet."consecutivoFactura"  )
	left join autorizaciones_autorizaciones aut on (aut.historia_id = his.id)
	left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id)
	where sed.id = '2' and e.id = '55' and fac.id = 60



select generaEnvioRipsJSON(55,'FACTURA')

select * from cartera_glosas;


select * from cartera_glosasdetalle;
select * from rips_ripsprocedimientos;

update rips_ripsprocedimientos set "cantidadAceptada"=0,"notasCreditoGlosa"=0,"vAceptado" = 0,"valorGlosado"=0, "valorSoportado" =0, glosa_id=null