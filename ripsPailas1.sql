select * from usuarios_usuarios;

select * from clinico_historia order by id desc

select "ripsEnvio_id",* from facturacion_facturacion order by id desc
select "numeroFactura_id",* from rips_ripsdetalle order by "numeroFactura_id"
select * from rips_ripsenvios;
select * from facturacion_empresas;
select * from contratacion_convenios where empresa_id=1 -- 9,1,21,7,19

select "ripsEnvio_id",convenio_id,* from facturacion_facturacion where "ripsEnvio_id" IS NULL order by id desc


select * from rips_ripstiposnotas --

select "ripsTransaccion_id",* from rips_ripsprocedimientos  order by id desc;
select * from rips_ripstransaccion order by id desc;
select "ripsTransaccion_id",* from rips_ripsusuarios order by id desc;

-- MANUAL

SELECT sed."codigoHabilitacion", facdet."fecha", null mipres, null numeroAutorizacion,usu.documento,
	facdet."valorTotal",'xx'  , fac.id, 
	row_number() OVER(ORDER BY facdet.id) AS consecutivo, now(), 
	null,null,null,
	exa.id, serv.id, null, 
	final.id, gru.id, mod.id, tipdocrips.id, '1' , ingreso.id, detrips.id, 
	facdet."consecutivoFactura", '4' ,
	(select max(ripsmoderadora.id) 
	from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora
	where  i."tipoDoc_id" =  pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and
	pagos."formaPago_id" = formapago.id and
	ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), 102,'A'
	FROM sitios_sedesclinica sed 
	inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id) 
	inner join  facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R') and "tipoRegistro" = 'MANUAL')
	inner join clinico_examenes exa ON (exa.id = facdet."examen_id" ) 
	inner join admisiones_ingresos i on (i.factura = fac.id and i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision") 
	left join rips_ripsviasingresosalud ingreso ON (ingreso.id = i."ripsViaIngresoServicioSalud_id") 
	inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) 
	inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) 
	left join rips_ripsmodalidadatencion mod ON (mod.id = i."ripsmodalidadGrupoServicioTecSal_id")  
	left join rips_ripsgruposervicios gru ON (gru.id = i."ripsGrupoServicios_id") 
	left join rips_ripsServicios serv ON (serv.id = i."ripsGrupoServicios_id")  
	left join  rips_ripsfinalidadconsulta final on (final.id = i."ripsFinalidadConsulta_id") 
	inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) 
	left join rips_ripstiposdocumento tipdocrips on (tipdocrips.id=tipdoc."tipoDocRips_id" )
	inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id ) 
--	inner join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec ) 
	--inner join clinico_historiaexamenes hisexa ON (hisexa.historia_id=his.id and hisexa."codigoCups" = exa."codigoCups" and hisexa."consecutivoLiquidacion" = facdet."consecutivoFactura"  ) 
	--left join autorizaciones_autorizaciones aut on (aut.historia_id = his.id) 
	--left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id)
	where sed.id = '1' and e.id = '67' and fac.id = 131  -- 3
UNION
-- SISTEMA
SELECT sed."codigoHabilitacion", facdet."fecha", his.mipres, autdet."numeroAutorizacion",usu.documento,
	facdet."valorTotal",'xx'  , fac.id, 
	row_number() OVER(ORDER BY facdet.id) AS consecutivo, now(), 
	(select max(diag4.id) from clinico_diagnosticos diag4 where diag4.id = i."dxComplicacion_id"),
	(select  max(diag1.id) from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 
	where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '2') ,
	(select max(diag3.id) from clinico_historialdiagnosticos histdiag3, clinico_diagnosticos diag3 
	where histdiag3.historia_id = his.id and histdiag3."tiposDiagnostico_id" = '3') , exa.id, serv.id, null, 
	final.id, gru.id, mod.id, tipdocrips.id, '1' , ingreso.id, detrips.id, 
	facdet."consecutivoFactura", '4' ,
	(select max(ripsmoderadora.id) 
	from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora
	where  i."tipoDoc_id" =  pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and
	pagos."formaPago_id" = formapago.id and
	ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), 102,'A'
	FROM sitios_sedesclinica sed 
	inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id) 
	inner join  facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R') and "tipoRegistro" = 'SISTEMA')
	inner join clinico_examenes exa ON (exa.id = facdet."examen_id" ) 
	inner join admisiones_ingresos i on (i.factura = fac.id and i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision") 
	left join rips_ripsviasingresosalud ingreso ON (ingreso.id = i."ripsViaIngresoServicioSalud_id") 
	inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) 
	inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) 
	left join rips_ripsmodalidadatencion mod ON (mod.id = i."ripsmodalidadGrupoServicioTecSal_id")  
	left join rips_ripsgruposervicios gru ON (gru.id = i."ripsGrupoServicios_id") 
	left join rips_ripsServicios serv ON (serv.id = i."ripsGrupoServicios_id")  
	left join  rips_ripsfinalidadconsulta final on (final.id = i."ripsFinalidadConsulta_id") 
	inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) 
	left join rips_ripstiposdocumento tipdocrips on (tipdocrips.id=tipdoc."tipoDocRips_id" )
	inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id ) 
	inner join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec ) 
	inner join clinico_historiaexamenes hisexa ON (hisexa.historia_id=his.id and hisexa."codigoCups" = exa."codigoCups" and hisexa."consecutivoLiquidacion" = facdet."consecutivoFactura"  ) 
	left join autorizaciones_autorizaciones aut on (aut.historia_id = his.id) 
	left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id)
	where sed.id = '1' and e.id = '67' and fac.id = 131  -- 12
	-- TOTAL 3+13=16 

 	
select * from clinico_examenes where id=384 -- "902207"
select * from clinico_historiaexamenes;	
select * from clinico_historiaexamenes where "codigoCups" = '902207' -- 1
	update clinico_historiaexamenes set "consecutivoLiquidacion" = 4  where "codigoCups" = '902207'
	select * from facturacion_facturaciondetalle where facturacion_id=131 order by "consecutivoFactura"

select anulado,* from facturacion_facturaciondetalle where facturacion_id=131 -- 22
select anulado,* from facturacion_facturaciondetalle where facturacion_id=131 and examen_id is not  null and (anulado = 'N' or anulado = 'R') and "tipoRegistro" = 'SISTEMA'--13
	
select anulado,* from facturacion_facturaciondetalle where facturacion_id=131 and examen_id is not  null and (anulado = 'N' or anulado = 'R') and "tipoRegistro" = 'SISTEMA' and examen_id= '384'
select anulado,* from facturacion_facturaciondetalle where facturacion_id=131 and examen_id is not  null and (anulado = 'N' or anulado = 'R') and "tipoRegistro" = 'MANUAL'--3

	
select anulado,* from facturacion_facturaciondetalle where facturacion_id=131 and cums_id is not  null and (anulado = 'N' or anulado = 'R') --4

	SELECT generaFacturaJSON(67,131,'FACTURA')

	SELECT generaenvioripsjson(67,'FACTURA')

	select * from rips_ripstransaccion order by id

	select count(*) from rips_ripstransaccion ripstra, rips_ripsprocedimientos proc
	where ripstra."ripsEnvio_id" = 67 and ripstra."numFactura" =cast(131 as text ) and proc."ripsTransaccion_id" = ripstra.id;	
	


select count(*) from rips_ripstransaccion ripstra, rips_ripsprocedimientos proc 
where ripstra."ripsEnvio_id" = 67 and ripstra."numFactura" =cast('131' as text ) and 
	proc."ripsTransaccion_id" = ripstra.id and cast("numNota" as float)  = 0  AND (proc."valorGlosado" > 0 or proc."valorGlosado" is null) and 
	ripstra."numFactura" = cast('131' as text) 

select "itemFactura",consecutivo,"codProcedimiento_id", "ripsTransaccion_id",* from rips_ripsprocedimientos where "ripsTransaccion_id" = 221 order by "itemFactura";	
select "ripsEnvio_id",* from rips_ripstransaccion
select "ripsTransaccion_id","itemFactura", consecutivo,* from 	rips_ripsprocedimientos where "ripsTransaccion_id" = 215 order by "itemFactura"
select examen_id, cums_id,* from facturacion_facturaciondetalle where facturacion_id=131 and anulado in ('N','R') order by "consecutivoFactura" ;

	-- otravoz

	select * from rips_ripsmedicamentos;
select * from factutacion_detalle where facturacion_id = 
	select * from facturacion_facturaciondetalle where facturacion_id = 131 order by "consecutivoFactura" -- 2217,2578// 2,2,791

	select row_number()  OVER(ORDER BY facdet.id) AS consecutivo


12663
	select * from clinico_diagnosticos where id in ('2586','12663')
	select * from rips_ripsmedicamentos;
	select * from rips_ripsmedicamentos
	select * from rips_ripsprocedimientos
	select  * from facturacion_suministros where cums='19930533-8'
	select * from rips_ripstransaccion order by id desc;
	select * from rips_ripsenvios order by id desc
	select * from rips_ripsdetalle where "ripsEnvios_id" = '67' order by id desc
	select * from rips_RipsCums
	select * from rips_ripsdetalle
	select * from facturacion_facturacion
	select * from rips_ripsusuarios
	select * from rips_ripsreciennacido
		select * from clinico_diagnosticos

select * from clinico_tiposdiagnostico		

	   
	SELECT '{"codPrestador": '|| '"' || proc."codPrestador" || '",'  ||'"fechaInicioAtencion": '|| '"' || proc."fechaInicioAtencion" || '",'  
	||'"idMIPRES": '|| '"' ||  CASE WHEN trim(proc."idMIPRES") is null THEN 'null' ELSE proc."idMIPRES"  END || '",'  	
	 ||'"numAutorizacion": '|| '"' || CASE WHEN trim(proc."numAutorizacion") is null THEN 'null' ELSE proc."numAutorizacion"  END || '",'	
	||'"codProcedimiento": '|| '"' || proc."codProcedimiento_id" || '",'	
		||'"viaIngresoServicioSalud": '|| '"' ||proc."viaIngresoServicioSalud_id"  || '",'	
		||'"modalidadGrupoServicioTecSal": '|| '"' || proc."modalidadGrupoServicioTecSal_id"  || '",'	
		-- ||'"finalidadTecnologiaSalud": '|| '"' ||proc."finalidadTecnologiaSalud_id"  || '",'	
		||'"finalidadTecnologiaSalud": '|| '"' ||CASE WHEN trim(cast(proc."finalidadTecnologiaSalud_id" as text)) is null THEN 0 ELSE proc."finalidadTecnologiaSalud_id"  END  || '",'			   
	||'"tipoDocumentoIdentificacion": '|| '"' || proc."tipoDocumentoIdentificacion_id"  || '",'	
	||'"numDocumentoIdentificacion": '|| '"' || CASE WHEN trim(proc."numDocumentoIdentificacion") is null THEN 'null' ELSE proc."numDocumentoIdentificacion"  END  || '",'	
	||'"codDiagnosticoPrincipal": '|| '"' || CASE WHEN trim(cast(diag1.cie10 as text)) is null THEN 'null' ELSE diag1.cie10  END || '",'	
	||'"codDiagnosticoRelacionado": '|| '"' ||  CASE WHEN trim(cast(diag2.cie10 as text)) is null THEN 'null' ELSE diag2.cie10  END    || '",'	
	||'"codComplicacion": '|| '"' ||CASE WHEN trim(cast(diag3.cie10 as text)) is null THEN 'null' ELSE diag3.cie10 END   || '",'
	--||'"vrProcedimiento": '|| '"' || CASE WHEN trim(cast(proc."vrServicio" as text)) is null THEN 0 ELSE proc."notasCreditoGlosa" END  || '",'	
	||'"vrProcedimiento": '|| '"' || proc."vrServicio"   || '",'		   
	||'"tipoPagoModerador": '|| '"' || CASE WHEN trim(cast(proc."tipoPagoModerador_id" as text)) is null THEN 0 ELSE proc."tipoPagoModerador_id"  END  || '",'	
	||'"valorPagoModerador": '|| '"' ||   CASE WHEN trim(cast(proc."valorPagoModerador" as text)) is null THEN 0 ELSE proc."valorPagoModerador"  END  || '",'	
	||'"numFEVPagoModerador": '|| '"' || proc."numFEVPagoModerador" || '",'
	||'"consecutivo": '|| '"' || proc."consecutivo" || '",'	
	||'	},'
	from rips_ripstransaccion ripstra
	inner join rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id)
	left join clinico_diagnosticos diag1 on (diag1.id=proc."codDiagnosticoPrincipal_id")   
	left join clinico_diagnosticos diag2 on (diag2.id=proc."codDiagnosticoRelacionado_id")   
	left join clinico_diagnosticos diag3 on (diag3.id=proc."codComplicacion_id")   
    where  ripstra."ripsEnvio_id" = '67' AND  ripstra."numFactura" = cast('131' as text) AND (proc."valorGlosado" > 0 or proc."valorGlosado" is null)
		 
		and proc.consecutivo = consecutivos[contador];

select documento_id,* from facturacion_facturacion where id in (109,122,124)
select documento_id,* from admisiones_ingresos where documento_id in ('16','56')

select * from sitios_dependencias where id in ('21','32','31')
-- estoy mirandop el envio 64