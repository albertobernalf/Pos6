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

	select * from rips_ripstransaccion order by id

	select count(*) from rips_ripstransaccion ripstra, rips_ripsprocedimientos proc
	where ripstra."ripsEnvio_id" = 67 and ripstra."numFactura" =cast(131 as text ) and proc."ripsTransaccion_id" = ripstra.id;	
	


detalle ='SELECT sed."codigoHabilitacion", facdet."fecha", null mipres, null numeroAutorizacion,usu.documento,facdet."valorTotal",' + "'" + str(proRata) + "'" + ', fac.id, row_number() OVER(ORDER BY facdet.id) AS consecutivo, now(), null,null,null,	exa.id, serv.id, null, 	final.id, gru.id, mod.id, tipdocrips.id, ' + "'" + str(username_id) + "'" + ', ingreso.id, detrips.id, facdet."consecutivoFactura", ' + "'" + str('4') + "'" + ', (select max(ripsmoderadora.id) from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora 	where  i."tipoDoc_id" =  pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)),' + "'" + str(transaccionId) + "','A'," + ' FROM sitios_sedesclinica sed inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)  inner join  facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = ' + "'" + str('N') + "' or facdet.anulado = 'R') and " + '"tipoRegistro" = ' + "'" + str('MANUAL') + "'" + '"+ ')  inner join clinico_examenes exa ON (exa.id = facdet."examen_id" ) 	inner join admisiones_ingresos i on (i.factura = fac.id and i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision") left join rips_ripsviasingresosalud ingreso ON (ingreso.id = i."ripsViaIngresoServicioSalud_id") inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) left join rips_ripsmodalidadatencion mod ON (mod.id = i."ripsmodalidadGrupoServicioTecSal_id") left join rips_ripsgruposervicios gru ON (gru.id = i."ripsGrupoServicios_id") 	left join rips_ripsServicios serv ON (serv.id = i."ripsGrupoServicios_id")  left join  rips_ripsfinalidadconsulta final on (final.id = i."ripsFinalidadConsulta_id") 	inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) left join rips_ripstiposdocumento tipdocrips on (tipdocrips.id=tipdoc."tipoDocRips_id" ) inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id ) where sed.id = ' + "'" + str(sede) + "'" + ' and e.id = ' + "'" + str(envioRipsId) + "'" + ' and fac.id = ' + "'" + str(elemento) + "'"  + ' UNION SELECT sed."codigoHabilitacion", facdet."fecha", his.mipres, autdet."numeroAutorizacion",usu.documento, facdet."valorTotal",' + "'" + str(proRata) + "'" + ', fac.id, 	row_number() OVER(ORDER BY facdet.id) AS consecutivo, now(), 	(select max(diag4.id) from clinico_diagnosticos diag4 where diag4.id = i."dxComplicacion_id"),(select  max(diag1.id) from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = ' + "'" + str('2' + "')" + ' ,	(select max(diag3.id) from clinico_historialdiagnosticos histdiag3, clinico_diagnosticos diag3 where histdiag3.historia_id = his.id and histdiag3."tiposDiagnostico_id" = ' + "'" + str('3') + "'" + ' , exa.id, serv.id, null, 	final.id, gru.id, mod.id, tipdocrips.id, '1' , ingreso.id, detrips.id, facdet."consecutivoFactura", ' + "'" + str('4') + "'" + ' , (select max(ripsmoderadora.id) from cartera_pagos pagos, cartera_formaspagos formapago, rips_ripstipospagomoderador ripsmoderadora where  i."tipoDoc_id" =  pagos."tipoDoc_id" and i.documento_id = pagos.documento_id and i.consec = pagos.consec and pagos."formaPago_id" = formapago.id and ripsmoderadora."codigoAplicativo" = cast(formapago.id as text)), ' + "'" + str(transaccionId) + "','A'," + ' FROM sitios_sedesclinica sed inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id) inner join  facturacion_facturaciondetalle facdet ON (facdet.facturacion_id = fac.id and facdet."examen_id" is not null and (facdet.anulado = ' + "'" + str('N') + "'" + ' or facdet.anulado = ' + "'" + str('R') + "')" + ' and "tipoRegistro" = ' + "'" + str('SISTEMA') + "'" + ' inner join clinico_examenes exa ON (exa.id = facdet."examen_id" ) inner join admisiones_ingresos i on (i.factura = fac.id and i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id = fac.documento_id and i.consec = fac."consecAdmision") left join rips_ripsviasingresosalud ingreso ON (ingreso.id = i."ripsViaIngresoServicioSalud_id") inner join rips_ripsenvios e ON (e."sedesClinica_id" = sed.id) inner join rips_ripsdetalle detrips ON (detrips."ripsEnvios_id" = e.id and detrips."numeroFactura_id" = fac.id) left join rips_ripsmodalidadatencion mod ON (mod.id = i."ripsmodalidadGrupoServicioTecSal_id") left join rips_ripsgruposervicios gru ON (gru.id = i."ripsGrupoServicios_id") 	left join rips_ripsServicios serv ON (serv.id = i."ripsGrupoServicios_id")  left join  rips_ripsfinalidadconsulta final on (final.id = i."ripsFinalidadConsulta_id") 	inner join usuarios_tiposdocumento tipdoc ON (tipdoc.id = fac."tipoDoc_id" ) left join rips_ripstiposdocumento tipdocrips on (tipdocrips.id=tipdoc."tipoDocRips_id" ) 	inner join usuarios_usuarios usu ON (usu."tipoDoc_id" = fac."tipoDoc_id" and usu.id = fac.documento_id )  inner join clinico_historia his ON (his."tipoDoc_id" = i."tipoDoc_id" and his.documento_id = i.documento_id and his."consecAdmision" = i.consec ) inner join clinico_historiaexamenes hisexa ON (hisexa.historia_id=his.id and hisexa."codigoCups" = exa."codigoCups" and hisexa."consecutivoLiquidacion" = facdet."consecutivoFactura"  ) left join autorizaciones_autorizaciones aut on (aut.historia_id = his.id) 	left join autorizaciones_autorizacionesdetalle autdet on (autdet.autorizaciones_id = aut.id and autdet.examenes_id = facdet.examen_id) where sed.id = ' + "'" + str(sede) + "'" + ' and e.id = ' + "'" + str(envioRipsId) + "'" + ' and fac.id = ' + "'" + str(elemento) + "'"  


	SELECT '{"codPrestador": '|| '"' || proc."codPrestador" || '",'  ||'"fechaInicioAtencion": '|| '"' || proc."fechaInicioAtencion" || '",'  
	||'"idMIPRES": '|| '"' ||  CASE WHEN trim(proc."idMIPRES") is null THEN 'null' ELSE proc."idMIPRES"  END || '",'  	
	 ||'"numAutorizacion": '|| '"' || CASE WHEN trim(proc."numAutorizacion") is null THEN 'null' ELSE proc."numAutorizacion"  END || '",'	
	||'"codProcedimiento": '|| '"' || proc."codProcedimiento_id" || '",'	
	||'"viaIngresoServicioSalud": '|| '"' ||proc."viaIngresoServicioSalud_id"  || '",'	
	||'"modalidadGrupoServicioTecSal": '|| '"' || proc."modalidadGrupoServicioTecSal_id"  || '",'	
--	||'"finalidadTecnologiaSalud": '|| '"' ||proc."finalidadTecnologiaSalud_id"  || '",'	
	||'"finalidadTecnologiaSalud": '|| '"' ||CASE WHEN trim(cast(proc."finalidadTecnologiaSalud_id" as text)) is null THEN 0 ELSE proc."finalidadTecnologiaSalud_id"  END  || '",'		
	||'"tipoDocumentoIdentificacion": '|| '"' || proc."tipoDocumentoIdentificacion_id"  || '",'	
	||'"numDocumentoIdentificacion": '|| '"' || CASE WHEN trim(proc."numDocumentoIdentificacion") is null THEN 'null' ELSE proc."numDocumentoIdentificacion"  END  || '",'	
	||'"codDiagnosticoPrincipal": '|| '"' || CASE WHEN trim(cast(proc."codDiagnosticoPrincipal_id" as text)) is null THEN 0 ELSE proc."codDiagnosticoPrincipal_id"  END || '",'	
	||'"codDiagnosticoRelacionado": '|| '"' ||  CASE WHEN trim(cast(proc."codDiagnosticoRelacionado_id" as text)) is null THEN 0 ELSE proc."codDiagnosticoRelacionado_id"  END    || '",'	
	||'"codComplicacion": '|| '"' ||CASE WHEN trim(cast(proc."codComplicacion_id" as text)) is null THEN 0 ELSE proc."codComplicacion_id"  END   || '",'
--	||'"vrProcedimiento": '|| '"' || CASE WHEN trim(cast(proc."vrServicio" as text)) is null THEN null ELSE proc."notasCreditoGlosa"   END  || '",'	
	||'"vrProcedimiento": '|| '"' || proc."vrServicio"   || '",'	
	||'"tipoPagoModerador": '|| '"' || CASE WHEN trim(cast(proc."tipoPagoModerador_id" as text)) is null THEN 0 ELSE proc."tipoPagoModerador_id"  END  || '",'	
	||'"valorPagoModerador": '|| '"' ||   CASE WHEN trim(cast(proc."valorPagoModerador" as text)) is null THEN 0 ELSE proc."valorPagoModerador"  END  || '",'	
	||'"numFEVPagoModerador": '|| '"' || proc."numFEVPagoModerador" || '",'
	||'"consecutivo": '|| '"' || proc."consecutivo" || '",'	
	||'	},'
	from rips_ripstransaccion ripstra
	inner join rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id)
	where  ripstra."ripsEnvio_id" = 67  AND --  proc."ripsTransaccion_id" = ripstra.id AND
	ripstra."numFactura" = cast('131' as text) AND (proc."valorGlosado" > 0 or proc."valorGlosado" is null)   --      and proc.consecutivo = 1;

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

-- medicamentos

	select * from rips_ripsmedicamentos;


	
	 SELECT	
	'"codPrestador": ' ||  '"' ||med."codPrestador"|| '",'   ||		
	   	    '"numAutorizacion": ' || '"'  ||CASE WHEN trim(med."numAutorizacion") is null THEN 'null' ELSE med."numAutorizacion"  END|| '",'   || 	
	 	  '"idMIPRES": ' || '"'   ||CASE WHEN trim(med."idMIPRES") is null THEN 'null' ELSE med."idMIPRES"  END|| '",'  || 	
		  '"fechaDispensAdmon": ' || '"'  ||'null'|| '",'     || 	

	  '"codDiagnosticoPrincipal": ' || '"'  ||CASE WHEN trim(diag1.cie10) is null THEN 'null' ELSE diag1.cie10  END|| '",'  || 	
	'"codDiagnosticoRelacionado": ' || '"'  ||CASE WHEN trim(diag2.cie10) is null THEN 'null' ELSE diag2.cie10  END|| '",' 	  || 	 
	'"tipoMedicamento": ' || '"'  ||CASE WHEN trim(tipmed.codigo) is null THEN 'null' ELSE tipmed.codigo  END|| '",'   || 	

	'"codTecnologiaSalud": ' || '"'  ||  CASE WHEN trim(ripscums.cum) is null THEN 'null' ELSE ripscums.cum  END           || '",'  || 	
	'"nomTecnologiaSalud": ' || '"'  ||   CASE WHEN trim(med."nomTecnologiaSalud") is null THEN 'null' ELSE med."nomTecnologiaSalud"  END               || '",'  || 	
	'"concentracionMedicamento": ' || '"'  || CASE WHEN trim(med."concentracionMedicamento") is null THEN 'null' ELSE med."concentracionMedicamento"  END  || '",'    || 	
	'"unidadMedida": ' || '"'  ||CASE WHEN trim(ripsumm.codigo) is null THEN 'null' ELSE ripsumm.codigo  END           || '",'  || 	
	'"formaFarmaceutica": ' || '"'  ||  CASE WHEN trim(ripsfarma.codigo) is null THEN 'null' ELSE ripsfarma.codigo  END  || '",'  || 	
'"unidadMinDispensa": ' || '"'  ||  CASE WHEN trim(ripsupr.codigo) is null THEN 'null' ELSE ripsupr.codigo  END           || '",'  || 	
	'"cantidadMedicamento": ' || '"'  || CASE WHEN trim(cast( med."cantidadMedicamento"  as text)) is null THEN 0 ELSE  med."cantidadMedicamento"   END      || '",'   /* || 	
	'"diasTratamiento": ' || '"'  ||   CASE WHEN trim(cast( med."diasTratamiento"  as text)) is null THEN 0 ELSE med."diasTratamiento"  END  || '",'  */ || 	

	'"tipoDocumentoldentificacion": ' || '"'  || CASE WHEN trim(ripstipdoc.codigo) is null THEN 'null' ELSE ripstipdoc.codigo  END   || '",'  || 	
	'"numDocumentoIdentificacion": ' || '"'  || CASE WHEN trim(med."numDocumentoIdentificacion") is null THEN 'null' ELSE med."numDocumentoIdentificacion"  END     || '",'  || 	
		'"vrUnitMedicamento": ' || '"'  ||  med."vrUnitMedicamento" || '",'  || 	
		'"vrServicio": ' || '"'  ||med."vrServicio"|| '",'  || 	
		'"tipoPagoModerador": ' || '"'  ||  CASE WHEN trim( ripstipopago.codigo) is null THEN 'null' ELSE  ripstipopago.codigo  END || '",'  || 	
		'"valorPagoModerador": ' || '"'  ||  CASE WHEN med."valorPagoModerador" is null THEN 'null' ELSE   cast(med."valorPagoModerador" as text) END || '",'  || 		
	'"numFEVPagoModerador": ' || '"'  || CASE WHEN trim(med."numFEVPagoModerador") is null THEN 'null' ELSE  med."numFEVPagoModerador"  END|| '",'   || 	
--	'"numFEVPagoModerador": ' || '"'  ||cast (med."numFEVPagoModerador" as text)    || '",'   || 	
	'"consecutivo": ' || '"'  ||med.consecutivo|| '},'	
	from rips_ripstransaccion
	--inner join rips_ripsenvios  env on (env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" )
	inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = rips_ripstransaccion.id)
	--inner join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id" )
	--inner join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric))
	--inner join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" )
	--inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null )
	--inner join clinico_historiamedicamentos histmed on (histmed.id = facdet."historiaMedicamento_id") 
	--left join autorizaciones_autorizacionesdetalle aut on (aut.id = histmed.autorizacion_id)
	inner join facturacion_suministros sum  on (sum.cums = med."nomTecnologiaSalud")
	left join rips_ripstipomedicamento tipmed on (tipmed.id =sum."ripsTipoMedicamento_id" )
	left join rips_ripscums ripscums on (ripscums.id = sum.id)	
	left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id")	
	left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id")	
	left join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id")	
	--inner join clinico_historia historia on (historia.id = histmed.historia_id)	
	--inner join planta_planta planta on (planta.id = historia."usuarioRegistro_id")	
	--inner join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id")	
	left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = med."tipoDocumentoIdentificacion_id" )	
	--left join cartera_pagos pagos on (pagos."tipoDoc_id" =  fac."tipoDoc_id"  and pagos.documento_id = fac.documento_id and pagos.consec = fac."consecAdmision")	
	--left join cartera_formaspagos formaspagos on (formaspagos.id = pagos."formaPago_id")		
	--left join rips_ripstipospagomoderador ripstipopago on (cast(ripstipopago."codigoAplicativo" as numeric) = formaspagos.id and cast(ripstipopago."codigoAplicativo" as numeric) in ('3','4') )	
	--left join clinico_historialdiagnosticos histdiag1 on (histdiag1.historia_id = historia.id and  histdiag1."tiposDiagnostico_id" = 1)	
	--left join clinico_historialdiagnosticos histdiag2 on (histdiag2.historia_id = historia.id and  histdiag2."tiposDiagnostico_id" = 2)	
	--left join clinico_diagnosticos diag1 on (diag1.id = histdiag1.diagnosticos_id)	
	--left join clinico_diagnosticos diag2 on (diag2.id = histdiag2.diagnosticos_id)	
	where rips_ripstransaccion."ripsEnvio_id" = '67' and rips_ripstransaccion."ripsEnvio_id" = env.id  and cast(rips_ripstransaccion."numFactura" as numeric) = fac.id	and rips_ripstransaccion."numFactura" =cast('131' as text ) ;

	
	select * from rips_ripsmedicamentos

	select  * from facturacion_suministros where cums='19930533-8'

	select * from rips_ripstransaccion order by id desc;
	select * from rips_ripsenvios order by id desc
	select * from rips_ripsdetalle where "ripsEnvios_id" = '67' order by id desc
	select * from rips_RipsCums