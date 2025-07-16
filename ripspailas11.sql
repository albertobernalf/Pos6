SELECT id, "codPrestador", "fechaInicioAtencion", "fechaEgreso", consecutivo, "fechaRegistro", "causaMotivoAtencion_id", "codDiagnosticoCausaMuerte_id", "codDiagnosticoPrincipal_id", "codDiagnosticoPrincipalE_id", "codDiagnosticoRelacionadoE1_id", "codDiagnosticoRelacionadoE2_id", "codDiagnosticoRelacionadoE3_id", "condicionDestinoUsuarioEgreso_id", "usuarioRegistro_id", "ripsDetalle_id", "ripsTipos_id", "ripsTransaccion_id"
	FROM public.rips_ripsurgenciasobservacion;

select * from rips_ripshospitalizacion;

select * from rips_ripsenvios;
select * from cartera_tiposnotas;
select * from cartera_glosas;
select * from facturacion_empresas;
select * from contratacion_convenios;



"compensar eps" 1
	"SURA EPS"  2
   glosa	fact   ripstransaccion
	5  -->  42   --  98
	6  -->  40   -- 111


select * from rips_ripsenvios;
select * from rips_ripsdetalle;
select * from rips_ripstiposnotas;

INSERT INTO RIPS_RIPSDETALLE ("numeroFactura_id", "estadoPasoMinisterio", "fechaRegistro", "estadoReg", "ripsEnvios_id", "usuarioRegistro_id", estado)
	VALUES ('5','N','2025-03-20 10:20:13.300987','A','32','1','ELABORADA')

SELECT * FROM CARTERA_GLOSAS;
update CARTERA_GLOSAS set "ripsEnvio_id" = null where id in (5,6);

select * from rips_ripstransaccion;
delete from rips_ripstransaccion where id=112;
select * from rips_ripstiposnotas;
select * from rips_ripsenvios;
select * from cartera_glosas;
select * from rips_ripstiposnotas;


INSERT into rips_ripstransaccion ("numDocumentoIdObligado",  "numNota","fechaRegistro", "tipoNota_id","usuarioRegistro_id" ,"ripsEnvio_id","sedesClinica_id" ,"numFactura")
		select sed.nit,  glo.id, now(), tipnot.id, '1', e.id, sed.id , glo.factura_id
	from sitios_sedesclinica sed, cartera_glosas glo, rips_ripsEnvios e  , rips_ripsdetalle det ,rips_ripstiposnotas tipnot
	where e.id = 32 and e."sedesClinica_id" = sed.id and glo."ripsEnvio_id" = e.id and
			det."ripsEnvios_id" = e.id -- and cast(det."numeroFactura" as float) = glo.factura_id
	and e."ripsTiposNotas_id" = tipnot.id and tipnot.nombre='Glosa'
 	
select * from rips_ripsdetalle;

select * from rips_ripsprocedimientos;
         
			INSERT INTO rips_ripsprocedimientos ("codPrestador", "fechaInicioAtencion", "idMIPRES", "numAutorizacion","numDocumentoIdentificacion", "vrServicio",
				"valorPagoModerador", "numFEVPagoModerador", consecutivo, "fechaRegistro", "codComplicacion_id", "codDiagnosticoPrincipal_id", "codDiagnosticoRelacionado_id",
				"codProcedimiento_id", "codServicio_id", "conceptoRecaudo_id", "finalidadTecnologiaSalud_id", "grupoServicios_id", "modalidadGrupoServicioTecSal_id",
				"tipoDocumentoIdentificacion_id","usuarioRegistro_id", "viaIngresoServicioSalud_id", "ripsDetalle_id", "itemFactura", "ripsTipos_id",
				"tipoPagoModerador_id", "ripsTransaccion_id")  
				
				SELECT sed."codigoHabilitacion", facdet."fecha", his.mipres, autdet."numeroAutorizacion", 
				usu.documento, facdet."valorTotal", 
				(select pagos.valor from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora where i."tipoDoc_id" = pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), fac.id, row_number() OVER(ORDER BY facdet.id) AS consecutivo, now(), 
				(select diag4.id from clinico_diagnosticos diag4 where diag4.id = i."dxComplicacion_id"),  
				(select  max(diag1.id) from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '2'),
				(select max(diag3.id) from clinico_historialdiagnosticos histdiag3, clinico_diagnosticos diag3 where histdiag3.historia_id = his.id and histdiag3."tiposDiagnostico_id" = '3'),
				exa.id, serv.id, null, final.id, gru.id, mod.id, tipdocrips.id, '1' , ingreso.id, detrips.id, facdet."consecutivoFactura",
				'4' , (select ripsmoderadora.id from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora where  i."tipoDoc_id" =  pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)),  '95'
				FROM sitios_sedesclinica sed  
				inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)  
				inner join  facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and facdet."estadoRegistro" = 'A')  
				left join clinico_examenes exa ON (exa.id = facdet."examen_id")
				inner join admisiones_ingresos i on (i.factura = fac.id and i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision") 
				left join rips_ripsviasingresosalud ingreso ON (ingreso.id = i."ripsViaIngresoServicioSalud_id")
				left join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) 
				inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and cast(detrips."numeroFactura" as float) = fac.id) 
				left join rips_ripsmodalidadatencion mod ON (mod.id = i."ripsmodalidadGrupoServicioTecSal_id") 
				left join rips_ripsgruposervicios gru ON (gru.id = i."ripsGrupoServicios_id") 
				left join rips_ripsServicios serv ON (serv.id = i."ripsGrupoServicios_id") 
				left join  rips_ripsfinalidadconsulta final on (final.id = i."ripsFinalidadConsulta_id") 
				left join rips_ripstiposdocumento tipdocrips on (1=1)
				inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" and tipdoc."tipoDocRips_id" = tipdocrips.id)
				inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )
				inner join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec ) 
				inner join clinico_historiaexamenes hisexa ON (hisexa.historia_id=his.id and hisexa."codigoCups" = exa."codigoCups") 
				left join autorizaciones_autorizaciones aut on (aut.historia_id = his.id) 
				left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id)
				where sed.id = 1 and e.id = 32

-- ripshospitalizacion
select * from rips_ripshospitalizacion;

select * from rips_ripstransaccion;
select * from rips_ripsdetalle where "numeroFactura" ='47'

INSERT INTO rips_ripshospitalizacion ("codPrestador","viaIngresoServicioSalud_id","fechaInicioAtencion", "numAutorizacion","causaMotivoAtencion_id","codComplicacion_id",
"codDiagnosticoPrincipal_id", "codDiagnosticoPrincipalE_id",  "codDiagnosticoRelacionadoE1_id", "codDiagnosticoRelacionadoE2_id", "codDiagnosticoRelacionadoE3_id",
"condicionDestinoUsuarioEgreso_id", "codDiagnosticoCausaMuerte_id","fechaEgreso",  consecutivo, "usuarioRegistro_id", "ripsDetalle_id", "tipoRips", "ripsTransaccion_id",
"fechaRegistro") 

	select * from admisiones_ingresos; --11
select * from sitios_dependencias where id=11;
select * from sitios_serviciossedes;
select * from clinico_servicios;
	
SELECT sed."codigoHabilitacion",i."ripsViaIngresoServicioSalud_id",cast(i."fechaIngreso" as date),aut."numeroAutorizacion" ,
i."ripsCausaMotivoAtencion_id", (select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxComplicacion_id"),
(select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxIngreso_id"), 
(select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxSalida_id"),   
(select max(diag1.id)  from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 , clinico_historia his where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '2' and histdiag1.diagnosticos_id = diag1.id and his."tipoDoc_id" = fac."tipoDoc_id" and his.documento_id = fac.documento_id AND his."consecAdmision" = fac."consecAdmision") , 
(select max(diag1.id)  from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1, clinico_historia his  where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '3' and histdiag1.diagnosticos_id = diag1.id  and his."tipoDoc_id" = fac."tipoDoc_id" and his.documento_id = fac.documento_id AND his."consecAdmision" =fac."consecAdmision"), 
(select max(diag1.id) from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1, clinico_historia his where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '4' and histdiag1.diagnosticos_id = diag1.id  and his."tipoDoc_id" = fac."tipoDoc_id" and his.documento_id = fac.documento_id AND his."consecAdmision" =fac."consecAdmision" ), i."ripsCondicionDestinoUsuarioEgreso_id", null,  cast(i."fechaSalida" as date),
row_number() OVER(ORDER BY i.id) AS consecutivo ,'1' ,det.id,env."ripsEstados_id",  ripstra.id,now()
FROM sitios_sedesclinica sed 
inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id) 
inner join admisiones_ingresos i ON (i."sedesClinica_id" = sed.id and i."tipoDoc_id" =fac."tipoDoc_id" and i.documento_id = fac.documento_id AND i.consec =fac."consecAdmision")
inner join rips_ripsenvios env ON (env."sedesClinica_id" = sed.id) 
	inner join rips_ripsdetalle det ON ( det."ripsEnvios_id" = env.id and  det."ripsEnvios_id" = fac."ripsEnvio_id" and cast(det."numeroFactura" as float) = fac.id ) 
inner join rips_ripstransaccion ripstra ON ( ripstra."sedesClinica_id" = sed.id and ripstra."ripsEnvio_id" = env.id and ripstra."numFactura" = cast(fac.id as text))
left join autorizaciones_autorizaciones aut  on (aut.id = i.autorizaciones_id) 
inner join 	clinico_servicios serv on (serv.nombre = 'HOSPITALIZACION')
	inner join 	sitios_dependencias dep on (dep.id = i."dependenciasSalida_id" )
	inner join 	sitios_serviciossedes servsedes on (servsedes.id = dep."serviciosSedes_id" and servsedes.servicios_id= serv.id )
where sed.id = '1' AND env.id = 34

-- URGENCIAS
 
INSERT INTO rips_ripsurgenciasobservacion ("codPrestador","fechaInicioAtencion","causaMotivoAtencion_id", 	"codDiagnosticoPrincipal_id", 
	"codDiagnosticoPrincipalE_id",  "codDiagnosticoRelacionadoE1_id", "codDiagnosticoRelacionadoE2_id", "codDiagnosticoRelacionadoE3_id",
	"condicionDestinoUsuarioEgreso_id", "codDiagnosticoCausaMuerte_id","fechaEgreso",  consecutivo, "usuarioRegistro_id", "ripsDetalle_id",
	"ripsTipos_id", "ripsTransaccion_id", "fechaRegistro")
	
	SELECT sed."codigoHabilitacion",cast(i."fechaIngreso" as date), 
	i."ripsCausaMotivoAtencion_id", (select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxIngreso_id"),
	(select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxSalida_id"),
	(select max(diag1.id) from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 , clinico_historia his where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '2' and histdiag1.diagnosticos_id = diag1.id and his."tipoDoc_id" = fac."tipoDoc_id" and his.documento_id = fac.documento_id AND his."consecAdmision" = fac."consecAdmision") ,
	(select max(diag1.id)  from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1, clinico_historia his where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '3' and histdiag1.diagnosticos_id = diag1.id  and his."tipoDoc_id" = fac."tipoDoc_id" and his.documento_id = fac.documento_id AND his."consecAdmision" =fac."consecAdmision"), 
	(select max(diag1.id) from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1, clinico_historia his where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '4' and histdiag1.diagnosticos_id = diag1.id  and his."tipoDoc_id" = fac."tipoDoc_id" and his.documento_id = fac.documento_id AND his."consecAdmision" =fac."consecAdmision" ), dest.id, 
	(select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxSalida_id"), cast(i."fechaSalida" as date), row_number() OVER(ORDER BY i.id) AS consecutivo ,'1' ,det.id,'6',  ripstra.id,now() FROM sitios_sedesclinica sed 
	inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id) 
	inner join admisiones_ingresos i ON (i."sedesClinica_id" = sed.id and i."tipoDoc_id" =fac."tipoDoc_id" and i.documento_id = fac.documento_id AND i.consec =fac."consecAdmision") 	
	inner join rips_ripsenvios env ON (env."sedesClinica_id" = sed.id) 
	inner join rips_ripsdetalle det ON ( det."ripsEnvios_id" = env.id and  det."ripsEnvios_id" = fac."ripsEnvio_id" and cast(det."numeroFactura" as float) = fac.id ) 
	inner join rips_ripstransaccion ripstra ON ( ripstra."sedesClinica_id" = sed.id and ripstra."ripsEnvio_id" = env.id and ripstra."numFactura" = cast(fac.id as text)) 
	left join rips_ripsdestinoegreso dest  on (dest.id = i."ripsCondicionDestinoUsuarioEgreso_id") 
	inner join 	clinico_servicios serv on (serv.nombre = 'URGENCIAS' )
	inner join 	sitios_dependencias dep on (dep.id = i."dependenciasSalida_id" )
	inner join 	sitios_serviciossedes servsedes on (servsedes.id = dep."serviciosSedes_id" and servsedes.servicios_id= serv.id)
	where sed.id = '1'  AND env.id = 34

   