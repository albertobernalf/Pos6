CREATE OR REPLACE FUNCTION generaFacturaDualJSON(envioRipsId numeric, facturaId numeric, tipo character varying)
  RETURNS character varying  AS
$BODY$ 
DECLARE valorJson character(50000);

	    valorTransaccionYusuarios character(50000);
	    valorProcedimientos character(50000) :='';
		valorHospitalizacion character(50000):='';
		valorUrgencias character(50000):='';
		valorRecienNacidos character(50000):='';
	    valorOtrosServicios character(50000):='';
	    valorMedicamentos character(50000):='';
		valorConsultas character(50000):='';
		totalUrgencias integer := 0;
		totalHospitalizacion integer := 0;
		totalProcedimientos integer := 0;
		totalMedicamentos integer := 0; 
		totalRecienNacidos integer := 0;
		contador integer := 1;
		tabla RECORD;
		consecutivos integer[] ;

BEGIN
	
	valorJson= '';

if (tipo = 'FACTURA') then 
	
SELECT '{"numDocumentoIdObligado": ""' || "numDocumentoIdObligado" ||'",' || '"numFactura": ""' || "numFactura" || '"", "TipoNota": null,"numNota": null,"usuarios": ['
		||'"tipoDocumentoIdentificacion": '|| '"' || u."tipoDocumentoIdentificacion" || '",'||'"numDocumentoIdentificacion": '|| '"' || u."numDocumentoIdentificacion" || '",'
		||'"tipoUsuario": '|| '"' || CASE WHEN trim(u."tipoUsuario") is null THEN 'null' ELSE u."tipoUsuario"  END    || '",'||'"fechaNacimiento": '|| '"' || u."fechaNacimiento" || '",'
		||'"codSexo": '|| '"' || u."codSexo" || '",'||'"codPaisResidencia": '|| '"' || CASE WHEN trim(pais.codigo) is null THEN 'null' ELSE pais.codigo  END || '",'||'"codMunicipioResidencia": '|| '"' ||muni."municipioCodigoDian" || '",'
		||'"codZonaTerritorialResidencia": '|| '"' || u."codZonaTerritorialResidencia" || '",'||'"incapacidad": '|| '"' || u."incapacidad" || '",'
		||'"consecutivo": '|| '"' || u."consecutivo" || '",'||'"codPaisOrigen": '|| '"' || CASE WHEN trim(pais.codigo) is null THEN 'null' ELSE pais.codigo  END
	|| '",' DATO1
INTO valorTransaccionYusuarios
	from rips_ripstransaccion ripstra
	inner join  rips_ripsusuarios u on (u."ripsTransaccion_id" = ripstra.id)
	left join  rips_ripspaises pais on (pais.id =  u."codPaisResidencia_id")
	left join  sitios_municipios muni on ( muni.id = u."codMunicipioResidencia_id")	
where  ripstra."ripsEnvio_id" = envioRipsId and ripstra."numFactura" = cast(facturaId as text)  and u."ripsTransaccion_id" = ripstra.id  ;

valorJson = valorJson ||' ' || valorTransaccionYusuarios;

end if;

if (tipo = 'GLOSA') then 
	
SELECT '{"numDocumentoIdObligado": ""' || "numDocumentoIdObligado" ||'",' || '"numFactura": ""' || 'null' || '"", "TipoNota":' || tipnot.codigo || ',"numNota": ' || ripstra."numNota" || ' ,"usuarios": ['
		||'"tipoDocumentoIdentificacion": '|| '"' || u."tipoDocumentoIdentificacion" || '",'||'"numDocumentoIdentificacion": '|| '"' || u."numDocumentoIdentificacion" || '",'
		||'"tipoUsuario": '|| '"' || CASE WHEN trim(u."tipoUsuario") is null THEN 'null' ELSE u."tipoUsuario"  END    || '",'||'"fechaNacimiento": '|| '"' || u."fechaNacimiento" || '",'
		||'"codSexo": '|| '"' || u."codSexo" || '",'||'"codPaisResidencia": '|| '"' || CASE WHEN trim(pais.codigo) is null THEN 'null' ELSE pais.codigo  END || '",'||'"codMunicipioResidencia": '|| '"' ||muni."municipioCodigoDian" || '",'
		||'"codZonaTerritorialResidencia": '|| '"' || u."codZonaTerritorialResidencia" || '",'||'"incapacidad": '|| '"' || u."incapacidad" || '",'
		||'"consecutivo": '|| '"' || u."consecutivo" || '",'||'"codPaisOrigen": '|| '"' || CASE WHEN trim(pais.codigo) is null THEN 'null' ELSE pais.codigo  END
	|| '",' DATO1
INTO valorTransaccionYusuarios
	from rips_ripstransaccion ripstra
	inner join  rips_ripsusuarios u on (u."ripsTransaccion_id" = ripstra.id)
	left join  rips_ripspaises pais on (pais.id =  u."codPaisResidencia_id")
	left join  sitios_municipios muni on ( muni.id = u."codMunicipioResidencia_id")
	inner join rips_ripstiposnotas tipnot on (tipnot.id = ripstra."tipoNota_id")
where  ripstra."ripsEnvio_id" = envioRipsId and ripstra."numNota" = cast(facturaId as text)  and u."ripsTransaccion_id" = ripstra.id  ;

valorJson = valorJson ||' ' || valorTransaccionYusuarios;

end if;


raise notice 'Va esto en el JSON : %s' , valorJson;
	
-- Procedimientos


if (tipo = 'FACTURA') then 
	
	totalProcedimientos  = (select count(*) from rips_ripstransaccion ripstra, rips_ripsprocedimientos proc where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numFactura" =cast(facturaId as text ) and proc."ripsTransaccion_id" = ripstra.id and cast("numNota" as float)  = 0 ) ;

	contador = 1;
	   	FOR tabla IN select * from rips_ripstransaccion ripstra, rips_ripsprocedimientos proc where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numFactura" =cast(facturaId as text ) and proc."ripsTransaccion_id" = ripstra.id and cast("numNota" as float)  = 0
		LOOP 
          consecutivos[contador] := tabla.consecutivo;
          contador := contador + 1;
		raise notice 'consecutivos : %' , consecutivos[contador];
		END LOOP;
end if;

if (tipo = 'GLOSA') then 
	totalProcedimientos  = (select count(*) from rips_ripstransaccion ripstra, rips_ripsprocedimientos proc where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numNota" =cast(facturaId as text ) and proc."ripsTransaccion_id" = ripstra.id);	
	contador = 1;
	   	FOR tabla IN select * from rips_ripstransaccion ripstra, rips_ripsprocedimientos proc where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numNota" =cast(facturaId as text ) and proc."ripsTransaccion_id" = ripstra.id
		LOOP 
          consecutivos[contador] := tabla.consecutivo;
          contador := contador + 1;
		raise notice 'consecutivos : %' , consecutivos[contador];
		END LOOP;

end if;

if (totalProcedimientos> 0) then

	valorJson = valorJson ||'"servicios": { "procedimientos" : [{' ;
	
	RAISE NOTICE 'ENTRE TOTAL totalProcedimientos = %s', totalProcedimientos;

   contador :=1 ;

   for i in 1..totalProcedimientos

   
	loop
	   if (tipo = 'FACTURA') then 
	SELECT '"codPrestador": '|| '"' || proc."codPrestador" || '",'  ||'"fechaInicioAtencion": '|| '"' || proc."fechaInicioAtencion" || '",'
	||'"valorPagoModerador": '|| '"' ||   CASE WHEN trim(cast(proc."valorPagoModerador" as text)) is null THEN 0 ELSE proc."valorPagoModerador"  END  || '",'	
	||'"numFEVPagoModerador": '|| '"' || proc."numFEVPagoModerador" || '",'
	||'"consecutivo": '|| '"' || proc."consecutivo" || '",'	
	||'	},],'
	||'"idMIPRES": '|| '"' ||  CASE WHEN trim(proc."idMIPRES") is null THEN 'null' ELSE proc."idMIPRES"  END || '",'  	
	 ||'"numAutorizacion": '|| '"' || CASE WHEN trim(proc."numAutorizacion") is null THEN 'null' ELSE proc."numAutorizacion"  END || '",'	
	||'"codProcedimiento": '|| '"' || proc."codProcedimiento_id" || '",'	
		||'"viaIngresoServicioSalud": '|| '"' ||proc."viaIngresoServicioSalud_id"  || '",'	
		||'"modalidadGrupoServicioTecSal": '|| '"' || proc."modalidadGrupoServicioTecSal_id"  || '",'	
		||'"finalidadTecnologiaSalud": '|| '"' ||proc."finalidadTecnologiaSalud_id"  || '",'	
	||'"tipoDocumentoIdentificacion": '|| '"' || proc."tipoDocumentoIdentificacion_id"  || '",'	
	||'"numDocumentoIdentificacion": '|| '"' || CASE WHEN trim(proc."numDocumentoIdentificacion") is null THEN 'null' ELSE proc."numDocumentoIdentificacion"  END  || '",'	
	||'"codDiagnosticoPrincipal": '|| '"' || CASE WHEN trim(cast(proc."codDiagnosticoPrincipal_id" as text)) is null THEN 0 ELSE proc."codDiagnosticoPrincipal_id"  END || '",'	
	||'"codDiagnosticoRelacionado": '|| '"' ||  CASE WHEN trim(cast(proc."codDiagnosticoRelacionado_id" as text)) is null THEN 0 ELSE proc."codDiagnosticoRelacionado_id"  END    || '",'	
	||'"codComplicacion": '|| '"' ||CASE WHEN trim(cast(proc."codComplicacion_id" as text)) is null THEN 0 ELSE proc."codComplicacion_id"  END   || '",'
	||'"vrProcedimiento": '|| '"' || proc."vrServicio"  || '",'	
	||'"tipoPagoModerador": '|| '"' || CASE WHEN trim(cast(proc."tipoPagoModerador_id" as text)) is null THEN 0 ELSE proc."tipoPagoModerador_id"  END  || '",'	
	||'"consecutivo": '|| '"' || proc."consecutivo" 
	INTO valorProcedimientos
	from rips_ripstransaccion ripstra
	inner join rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id)
	where  ripstra."ripsEnvio_id" = envioRipsId AND proc."ripsTransaccion_id" = ripstra.id AND ripstra."numFactura" = cast(facturaId as text) and proc.consecutivo = consecutivos[contador];
	contador := contador +1;
	valorJson = valorJson ||' ' ||  valorProcedimientos;
	valorJson = valorJson ||'},' ;
	end if;

	   if (tipo = 'GLOSA') then 
	SELECT '"codPrestador": '|| '"' || proc."codPrestador" || '",'  ||'"fechaInicioAtencion": '|| '"' || proc."fechaInicioAtencion" || '",'
	||'"valorPagoModerador": '|| '"' ||   CASE WHEN trim(cast(proc."valorPagoModerador" as text)) is null THEN 0 ELSE proc."valorPagoModerador"  END  || '",'	
	||'"numFEVPagoModerador": '|| '"' || proc."numFEVPagoModerador" || '",'
	||'"consecutivo": '|| '"' || proc."consecutivo" || '",'	
	||'	},],'
	||'"idMIPRES": '|| '"' ||  CASE WHEN trim(proc."idMIPRES") is null THEN 'null' ELSE proc."idMIPRES"  END || '",'  	
	 ||'"numAutorizacion": '|| '"' || CASE WHEN trim(proc."numAutorizacion") is null THEN 'null' ELSE proc."numAutorizacion"  END || '",'	
	||'"codProcedimiento": '|| '"' || proc."codProcedimiento_id" || '",'	
		||'"viaIngresoServicioSalud": '|| '"' ||proc."viaIngresoServicioSalud_id"  || '",'	
		||'"modalidadGrupoServicioTecSal": '|| '"' || proc."modalidadGrupoServicioTecSal_id"  || '",'	
		||'"finalidadTecnologiaSalud": '|| '"' ||proc."finalidadTecnologiaSalud_id"  || '",'	
	||'"tipoDocumentoIdentificacion": '|| '"' || proc."tipoDocumentoIdentificacion_id"  || '",'	
	||'"numDocumentoIdentificacion": '|| '"' || CASE WHEN trim(proc."numDocumentoIdentificacion") is null THEN 'null' ELSE proc."numDocumentoIdentificacion"  END  || '",'	
	||'"codDiagnosticoPrincipal": '|| '"' || CASE WHEN trim(cast(proc."codDiagnosticoPrincipal_id" as text)) is null THEN 0 ELSE proc."codDiagnosticoPrincipal_id"  END || '",'	
	||'"codDiagnosticoRelacionado": '|| '"' ||  CASE WHEN trim(cast(proc."codDiagnosticoRelacionado_id" as text)) is null THEN 0 ELSE proc."codDiagnosticoRelacionado_id"  END    || '",'	
	||'"codComplicacion": '|| '"' ||CASE WHEN trim(cast(proc."codComplicacion_id" as text)) is null THEN 0 ELSE proc."codComplicacion_id"  END   || '",'
	||'"vrProcedimiento": '|| '"' || proc."notasCreditoGlosa"  || '",'	
	||'"tipoPagoModerador": '|| '"' || CASE WHEN trim(cast(proc."tipoPagoModerador_id" as text)) is null THEN 0 ELSE proc."tipoPagoModerador_id"  END  || '",'	
	||'"consecutivo": '|| '"' || proc."consecutivo" 
	INTO valorProcedimientos
	from rips_ripstransaccion ripstra
	inner join rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id)
	where  ripstra."ripsEnvio_id" = envioRipsId AND ripstra."ripsEnvio_id" = envioRipsId and ripstra."numNota" = cast(facturaId as text) and proc.consecutivo = consecutivos[contador];

	contador := contador +1;

	valorJson = valorJson ||' ' ||  valorProcedimientos;
	valorJson = valorJson ||'},' ;
	end if;

	end loop;
end if;

RAISE NOTICE 'VALOR PROCEDIMIENTOS = %s' ,valorProcedimientos ;

raise notice 'Va esto en el JSON PROCED: %s' , valorJson;

-- Hospitalizacion

if (tipo = 'FACTURA') then 

totalHospitalizacion  = (select count(*) from rips_ripstransaccion ripstra, rips_ripshospitalizacion hosp where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numFactura" =cast(facturaId as text ) and hosp."ripsTransaccion_id" = ripstra.id and cast("numNota" as float)  = 0);

end if;

if (tipo = 'GLOSA') then 
totalHospitalizacion  = (select count(*) from rips_ripstransaccion ripstra, rips_ripshospitalizacion hosp where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numNota" =cast(facturaId as text ) and hosp."ripsTransaccion_id" = ripstra.id);
end if;	


if (totalHospitalizacion> 0) then

	RAISE NOTICE 'ENTRE TOTAL totalHospitalizacion = %s', totalHospitalizacion;

if (tipo = 'FACTURA') then 

SELECT '{"hospitalizacion": [{"codPrestador": ' ||'"'  ||   hosp."codPrestador"|| '",'  ||
	   '"viaIngresoServicioSalud": ' || '"'  ||hosp."viaIngresoServicioSalud_id"|| '",'  ||
	    '"fechaInicioAtencion": ' || '"'  ||hosp."fechaInicioAtencion"|| '",'  || 
		 '"numAutorizacion": ' || '"'  ||CASE WHEN trim(cast(hosp."numAutorizacion" as text)) is null THEN '' ELSE hosp."numAutorizacion"  END|| '",'   || 
	 '"causaMotivoAtencion": ' || '"'  ||cauext.codigo|| '",'   || 
	 '"codDiagnosticoPrincipal": ' || '"'  ||dxppal.cie10|| '",'   || 
		  '"codDiagnosticoPrincipalE": ' || '"'  ||dxppale.cie10|| '",'    ||

	'"codDiagnosticoRelacionadoE1": ' || '"'  ||coalesce(dxrel1.cie10,'null')|| '",'  ||

		 '"codDiagnosticoRelacionadoE2": ' || '"'  ||coalesce(dxrel2.cie10,'null')|| '",'  ||
	'"codDiagnosticoRelacionadoE3": ' || '"'  ||coalesce(dxrel3.cie10,'null')|| '",'  ||
	'"codComplicacion": ' || '"'  ||'null'|| '",'  ||
		 '"condicionDestinoUsuarioEgreso": ' || '"'  ||cauext.codigo|| '",'   || 
		'"codDiagnosticoMuerte": ' || '"'  ||'null'|| '",'  ||
		 '"fechaEgreso": ' || '"'  ||hosp."fechaEgreso"|| '",'   || 
	'"consecutivo": ' || '"'  ||hosp.consecutivo|| '",'   || 
'}]}'
	INTO valorHospitalizacion
from rips_ripstransaccion
	left join rips_ripshospitalizacion hosp on (hosp."ripsTransaccion_id" = rips_ripstransaccion.id)
	left join rips_ripscausaexterna cauext on (cauext.id =hosp."causaMotivoAtencion_id" )
	left join clinico_diagnosticos dxppal on (dxppal.id =hosp."codDiagnosticoPrincipal_id")
	left join clinico_diagnosticos dxppale on (dxppale.id =hosp."codDiagnosticoPrincipalE_id")
	left join clinico_diagnosticos dxrel1 on (dxrel1.id = hosp."codDiagnosticoRelacionadoE1_id")
	left join clinico_diagnosticos dxrel2 on (dxrel2.id =  hosp."codDiagnosticoRelacionadoE2_id")
	left join clinico_diagnosticos dxrel3 on (dxrel3.id =  hosp."codDiagnosticoRelacionadoE3_id")
	left join rips_ripsDestinoEgreso egreso on (egreso.id = hosp."condicionDestinoUsuarioEgreso_id" )
where  rips_ripstransaccion."ripsEnvio_id" = envioRipsId and   rips_ripstransaccion."numFactura" =cast(facturaId as text) ;
	valorJson = valorJson ||' ' ||  valorHospitalizacion;
end if;	

if (tipo = 'GLOSA') then 

SELECT '{"hospitalizacion": [{"codPrestador": ' ||'"'  ||   hosp."codPrestador"|| '",'  ||
	   '"viaIngresoServicioSalud": ' || '"'  ||hosp."viaIngresoServicioSalud_id"|| '",'  ||
	    '"fechaInicioAtencion": ' || '"'  ||hosp."fechaInicioAtencion"|| '",'  || 
		 '"numAutorizacion": ' || '"'  ||CASE WHEN trim(cast(hosp."numAutorizacion" as text)) is null THEN '' ELSE hosp."numAutorizacion"  END|| '",'   || 
	 '"causaMotivoAtencion": ' || '"'  ||cauext.codigo|| '",'   || 
	 '"codDiagnosticoPrincipal": ' || '"'  ||dxppal.cie10|| '",'   || 
		  '"codDiagnosticoPrincipalE": ' || '"'  ||dxppale.cie10|| '",'    ||

	'"codDiagnosticoRelacionadoE1": ' || '"'  ||coalesce(dxrel1.cie10,'null')|| '",'  ||

		 '"codDiagnosticoRelacionadoE2": ' || '"'  ||coalesce(dxrel2.cie10,'null')|| '",'  ||
	'"codDiagnosticoRelacionadoE3": ' || '"'  ||coalesce(dxrel3.cie10,'null')|| '",'  ||
	'"codComplicacion": ' || '"'  ||'null'|| '",'  ||
		 '"condicionDestinoUsuarioEgreso": ' || '"'  ||cauext.codigo|| '",'   || 
		'"codDiagnosticoMuerte": ' || '"'  ||'null'|| '",'  ||
		 '"fechaEgreso": ' || '"'  ||hosp."fechaEgreso"|| '",'   || 
	'"consecutivo": ' || '"'  ||hosp.consecutivo|| '",'   || 
'}]}'
	INTO valorHospitalizacion
from rips_ripstransaccion
	left join rips_ripshospitalizacion hosp on (hosp."ripsTransaccion_id" = rips_ripstransaccion.id)
	left join rips_ripscausaexterna cauext on (cauext.id =hosp."causaMotivoAtencion_id" )
	left join clinico_diagnosticos dxppal on (dxppal.id =hosp."codDiagnosticoPrincipal_id")
	left join clinico_diagnosticos dxppale on (dxppale.id =hosp."codDiagnosticoPrincipalE_id")
	left join clinico_diagnosticos dxrel1 on (dxrel1.id = hosp."codDiagnosticoRelacionadoE1_id")
	left join clinico_diagnosticos dxrel2 on (dxrel2.id =  hosp."codDiagnosticoRelacionadoE2_id")
	left join clinico_diagnosticos dxrel3 on (dxrel3.id =  hosp."codDiagnosticoRelacionadoE3_id")
	left join rips_ripsDestinoEgreso egreso on (egreso.id = hosp."condicionDestinoUsuarioEgreso_id" )
where  rips_ripstransaccion."ripsEnvio_id" = envioRipsId and   rips_ripstransaccion."numNota" =cast(facturaId as text) ;
	valorJson = valorJson ||' ' ||  valorHospitalizacion;
end if;	
 end if;

raise notice 'Va esto en el JSON HOSP: %s' , valorJson;

-- Urgencias

totalUrgencias  = (select count(*) from rips_ripstransaccion ripstra, rips_ripsurgenciasobservacion urg where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numFactura" =cast(facturaId as text ) and urg."ripsTransaccion_id" = ripstra.id);


if (tipo = 'FACTURA') then 

totalUrgencias  = (select count(*) from rips_ripstransaccion ripstra, rips_ripsurgenciasobservacion urg where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numFactura" =cast(facturaId as text ) and urg."ripsTransaccion_id" = ripstra.id and cast("numNota" as float)  = 0);


end if;

if (tipo = 'GLOSA') then 

totalUrgencias  = (select count(*) from rips_ripstransaccion ripstra, rips_ripsurgenciasobservacion urg where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numNota" =cast(facturaId as text ) and urg."ripsTransaccion_id" = ripstra.id );

end if;	



	RAISE NOTICE 'ANTES DE URGENCIAS';
RAISE NOTICE 'TOTAL URGENCIAS = %s', totalUrgencias;

if (totalUrgencias> 0) then

	RAISE NOTICE 'eNTRE uRGENCIAS';

	if (tipo = 'FACTURA') then 
	
	
	 SELECT '{"urgencias": [{"codPrestador": ' ||  '"' || urg."codPrestador"|| '",'  ||
	   	    '"fechaInicioAtencion": ' || '"'  ||urg."fechaInicioAtencion"|| '",'  || 	
			 '"causaMotivoAtencion": ' || '"'  ||cauext.codigo|| '",'   || 
	 		'"codDiagnosticoPrincipal": ' || '"'  ||dxppal.cie10|| '",'   || 
		  '"codDiagnosticoPrincipalE": ' || '"'  ||dxppale.cie10|| '",'    ||
			'"codDiagnosticoRelacionadoE1": ' || '"'  ||coalesce(dxrel1.cie10,'null')|| '",'  ||
		 	'"codDiagnosticoRelacionadoE2": ' || '"'  ||coalesce(dxrel2.cie10,'null')|| '",'  ||
			'"codDiagnosticoRelacionadoE3": ' || '"'  ||coalesce(dxrel3.cie10,'null')|| '",'  ||
		 	'"condicionDestinoUsuarioEgreso": ' || '"'  ||cauext.codigo|| '",'   || 
			'"codDiagnosticoCausaMuerte": ' || '"'  ||coalesce(dxMuerte.cie10,'null')|| '",'  ||
		 	'"fechaEgreso": ' || '"'  ||urg."fechaEgreso"|| '",'   || 
		'"consecutivo": ' || '"'  ||urg.consecutivo|| '",'   || 
		'}]}'
	INTO valorUrgencias
	from rips_ripstransaccion
	left join rips_ripsurgenciasobservacion urg on (urg."ripsTransaccion_id" = rips_ripstransaccion.id)
	left join rips_ripscausaexterna cauext on (cauext.id =urg."causaMotivoAtencion_id" )
	left join clinico_diagnosticos dxppal on (dxppal.id =urg."codDiagnosticoPrincipal_id")
	left join clinico_diagnosticos dxppale on (dxppale.id =urg."codDiagnosticoPrincipalE_id")
	left join clinico_diagnosticos dxrel1 on (dxrel1.id = urg."codDiagnosticoRelacionadoE1_id")
	left join clinico_diagnosticos dxrel2 on (dxrel2.id =  urg."codDiagnosticoRelacionadoE2_id")
	left join clinico_diagnosticos dxrel3 on (dxrel3.id =  urg."codDiagnosticoRelacionadoE3_id")
	left join clinico_diagnosticos dxMuerte on (dxMuerte.id =  urg."codDiagnosticoCausaMuerte_id")
	left join rips_ripsDestinoEgreso egreso on (egreso.id = urg."condicionDestinoUsuarioEgreso_id" )
	where  rips_ripstransaccion."ripsEnvio_id" = envioRipsId and   rips_ripstransaccion."numFactura" =cast(facturaId as text);
	valorJson = valorJson ||' ' || valorUrgencias;
    end if;

if (tipo = 'GLOSA') then 
	
	
	 SELECT '{"urgencias": [{"codPrestador": ' ||  '"' || urg."codPrestador"|| '",'  ||
	   	    '"fechaInicioAtencion": ' || '"'  ||urg."fechaInicioAtencion"|| '",'  || 	
			 '"causaMotivoAtencion": ' || '"'  ||cauext.codigo|| '",'   || 
	 		'"codDiagnosticoPrincipal": ' || '"'  ||dxppal.cie10|| '",'   || 
		  '"codDiagnosticoPrincipalE": ' || '"'  ||dxppale.cie10|| '",'    ||
			'"codDiagnosticoRelacionadoE1": ' || '"'  ||coalesce(dxrel1.cie10,'null')|| '",'  ||
		 	'"codDiagnosticoRelacionadoE2": ' || '"'  ||coalesce(dxrel2.cie10,'null')|| '",'  ||
			'"codDiagnosticoRelacionadoE3": ' || '"'  ||coalesce(dxrel3.cie10,'null')|| '",'  ||
		 	'"condicionDestinoUsuarioEgreso": ' || '"'  ||cauext.codigo|| '",'   || 
			'"codDiagnosticoCausaMuerte": ' || '"'  ||coalesce(dxMuerte.cie10,'null')|| '",'  ||
		 	'"fechaEgreso": ' || '"'  ||urg."fechaEgreso"|| '",'   || 
		'"consecutivo": ' || '"'  ||urg.consecutivo|| '",'   || 
		'}]}'
	INTO valorUrgencias
	from rips_ripstransaccion
	left join rips_ripsurgenciasobservacion urg on (urg."ripsTransaccion_id" = rips_ripstransaccion.id)
	left join rips_ripscausaexterna cauext on (cauext.id =urg."causaMotivoAtencion_id" )
	left join clinico_diagnosticos dxppal on (dxppal.id =urg."codDiagnosticoPrincipal_id")
	left join clinico_diagnosticos dxppale on (dxppale.id =urg."codDiagnosticoPrincipalE_id")
	left join clinico_diagnosticos dxrel1 on (dxrel1.id = urg."codDiagnosticoRelacionadoE1_id")
	left join clinico_diagnosticos dxrel2 on (dxrel2.id =  urg."codDiagnosticoRelacionadoE2_id")
	left join clinico_diagnosticos dxrel3 on (dxrel3.id =  urg."codDiagnosticoRelacionadoE3_id")
	left join clinico_diagnosticos dxMuerte on (dxMuerte.id =  urg."codDiagnosticoCausaMuerte_id")
	left join rips_ripsDestinoEgreso egreso on (egreso.id = urg."condicionDestinoUsuarioEgreso_id" )
	where  rips_ripstransaccion."ripsEnvio_id" = envioRipsId and   rips_ripstransaccion."numNota" =cast(facturaId as text);
	valorJson = valorJson ||' ' || valorUrgencias;
    end if;

END IF;

raise notice 'Va esto en el JSON URGE: %s' , valorJson;


totalMedicamentos  = (select count(*) from rips_ripstransaccion ripstra, rips_ripsmedicamentos ripsmed where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numFactura" =cast(facturaId as text ) and ripsmed."ripsTransaccion_id" = ripstra.id);


if (tipo = 'FACTURA') then 

totalMedicamentos  = (select count(*) from rips_ripstransaccion ripstra, rips_ripsmedicamentos ripsmed where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numFactura" =cast(facturaId as text ) and ripsmed."ripsTransaccion_id" = ripstra.id  and cast("numNota" as float)  = 0);


end if;

if (tipo = 'GLOSA') then 

totalMedicamentos  = (select count(*) from rips_ripstransaccion ripstra, rips_ripsmedicamentos ripsmed where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numNota" =cast(facturaId as text ) and ripsmed."ripsTransaccion_id" = ripstra.id);

end if;	





RAISE NOTICE 'ANTES DE totalMedicamentos';
	RAISE NOTICE 'TOTAL totalMedicamentos = %s', totalMedicamentos;



if (totalMedicamentos> 0) then

	valorJson = valorJson ||'{ "medicamentos" : [{' ;

	RAISE NOTICE 'ENTRE TOTAL totalMedicamentos = %s', totalMedicamentos;


	
   
	for i in 1..totalMedicamentos
	loop   

			if (tipo = 'FACTURA') then 
		
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
		'"valorPagoModerador": ' || '"'  ||  med."valorPagoModerador"|| '",'  || 	
	
	'"numFEVPagoModerador": ' || '"'  ||med."numFEVPagoModerador"|| '",'   || 	
	'"consecutivo": ' || '"'  ||med.consecutivo
	INTO valorMedicamentos
	from rips_ripstransaccion
	left join rips_ripsenvios  env on (env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" )
	left join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = rips_ripstransaccion.id)
	left join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id" )
	left join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric))
	left join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" )
	inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null )
	left join clinico_historiamedicamentos histmed on (histmed.id = facdet."historiaMedicamento_id") 
	left join autorizaciones_autorizaciones aut on (aut.id = histmed.autorizacion_id)
	left join facturacion_suministros sum  on (sum.id = facdet.cums_id)
	left join rips_ripstipomedicamento tipmed on (tipmed.id =sum."ripsTipoMedicamento_id" )
	left join rips_ripscums ripscums on (ripscums.id = facdet."cums_id")	
	left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id")	
	left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id")	
	left join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id")	
	left join clinico_historia historia on (historia.id = histmed.historia_id)	
	left join planta_planta planta on (planta.id = historia.planta_id)	
	left join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id")	
	left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = usutipdoc."tipoDocRips_id")	
	left join cartera_pagos pagos on (pagos."tipoDoc_id" =  fac."tipoDoc_id"  and pagos.documento_id = fac.documento_id and pagos.consec = fac."consecAdmision")	
	left join cartera_formaspagos formaspagos on (formaspagos.id = pagos."formaPago_id")		
	left join rips_ripstipospagomoderador ripstipopago on (cast(ripstipopago."codigoAplicativo" as numeric) = formaspagos.id and cast(ripstipopago."codigoAplicativo" as numeric) in ('3','4') )	
	left join clinico_historialdiagnosticos histdiag1 on (histdiag1.historia_id = historia.id and  histdiag1."tiposDiagnostico_id" = 1)	
	left join clinico_historialdiagnosticos histdiag2 on (histdiag2.historia_id = historia.id and  histdiag2."tiposDiagnostico_id" = 2)	
	left join clinico_diagnosticos diag1 on (diag1.id = histdiag1.diagnosticos_id)	
	left join clinico_diagnosticos diag2 on (diag2.id = histdiag2.diagnosticos_id)	
	where rips_ripstransaccion."ripsEnvio_id" = envioRipsId and rips_ripstransaccion."ripsEnvio_id" = env.id  and cast(rips_ripstransaccion."numFactura" as numeric) = fac.id	and rips_ripstransaccion."numFactura" =cast(facturaId as text ) ;


	valorJson = valorJson ||' ' ||  valorMedicamentos;
	valorJson = valorJson ||'},' ;
    end if;

			if (tipo = 'GLOSA') then 
		
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
		'"valorPagoModerador": ' || '"'  ||  med."valorPagoModerador"|| '",'  || 	
	
	'"numFEVPagoModerador": ' || '"'  ||med."numFEVPagoModerador"|| '",'   || 	
	'"consecutivo": ' || '"'  ||med.consecutivo
	INTO valorMedicamentos
	from rips_ripstransaccion
	left join rips_ripsenvios  env on (env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" )
	left join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = rips_ripstransaccion.id)
	left join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id" )
	left join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric))
	left join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" )
	inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null )
	left join clinico_historiamedicamentos histmed on (histmed.id = facdet."historiaMedicamento_id") 
	left join autorizaciones_autorizaciones aut on (aut.id = histmed.autorizacion_id)
	left join facturacion_suministros sum  on (sum.id = facdet.cums_id)
	left join rips_ripstipomedicamento tipmed on (tipmed.id =sum."ripsTipoMedicamento_id" )
	left join rips_ripscums ripscums on (ripscums.id = facdet."cums_id")	
	left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id")	
	left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id")	
	left join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id")	
	left join clinico_historia historia on (historia.id = histmed.historia_id)	
	left join planta_planta planta on (planta.id = historia.planta_id)	
	left join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id")	
	left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = usutipdoc."tipoDocRips_id")	
	left join cartera_pagos pagos on (pagos."tipoDoc_id" =  fac."tipoDoc_id"  and pagos.documento_id = fac.documento_id and pagos.consec = fac."consecAdmision")	
	left join cartera_formaspagos formaspagos on (formaspagos.id = pagos."formaPago_id")		
	left join rips_ripstipospagomoderador ripstipopago on (cast(ripstipopago."codigoAplicativo" as numeric) = formaspagos.id and cast(ripstipopago."codigoAplicativo" as numeric) in ('3','4') )	
	left join clinico_historialdiagnosticos histdiag1 on (histdiag1.historia_id = historia.id and  histdiag1."tiposDiagnostico_id" = 1)	
	left join clinico_historialdiagnosticos histdiag2 on (histdiag2.historia_id = historia.id and  histdiag2."tiposDiagnostico_id" = 2)	
	left join clinico_diagnosticos diag1 on (diag1.id = histdiag1.diagnosticos_id)	
	left join clinico_diagnosticos diag2 on (diag2.id = histdiag2.diagnosticos_id)	
	where rips_ripstransaccion."ripsEnvio_id" = envioRipsId and rips_ripstransaccion."ripsEnvio_id" = env.id  and cast(rips_ripstransaccion."numNota" as numeric) = fac.id	and rips_ripstransaccion."numFactura" =cast(facturaId as text ) ;


	valorJson = valorJson ||' ' ||  valorMedicamentos;
	valorJson = valorJson ||'},' ;
    end if;


	end loop;
 END IF;

raise notice 'Va esto en el JSON MEDICAMENTOS: %s' , valorJson;

	totalRecienNacidos  = (select count(*) from rips_ripstransaccion ripstra, rips_ripsreciennacido ripsnac where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numFactura" =cast(facturaId as text ) and ripsnac."ripsTransaccion_id" = ripstra.id);


if (tipo = 'FACTURA') then 

totalRecienNacidos  = (select count(*) from rips_ripstransaccion ripstra, rips_ripsreciennacido ripsnac where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numFactura" =cast(facturaId as text ) and ripsnac."ripsTransaccion_id" = ripstra.id and cast("numNota" as float)  = 0);


end if;

if (tipo = 'GLOSA') then 

totalRecienNacidos  = (select count(*) from rips_ripstransaccion ripstra, rips_ripsreciennacido ripsnac where ripstra."ripsEnvio_id" = envioRipsId and ripstra."numNota" =cast(facturaId as text ) and ripsnac."ripsTransaccion_id" = ripstra.id);

end if;	


RAISE NOTICE 'ANTES DE totalRecienNacidos';

RAISE NOTICE 'TOTAL totalRecienNacidos = %s', totalMedicamentos;

if (totalRecienNacidos> 0) then

	if (tipo = 'FACTURA') then 

	SELECT '{"urgencias": [{"codPrestador": ' ||  '"' || nac."codPrestador"|| '",'  ||
	   	    '"tipoDocumentoIdentificacion": ' || '"'  ||tipoDoc.codigo|| '",'  || 	
			 '"numDocumentoIdentificacion": ' || '"'  ||nac."numDocumentoIdentificacion"|| '",'   || 
	 		'"fechaNacimiento": ' || '"'  ||nac."fechaNacimiento"|| '",'   || 
		  '"edadGestacional": ' || '"'  ||nac."edadGestacional"|| '",'    ||
			'"numConsultasCPrenatal": ' || '"'  ||coalesce(nac."numConsultasCPrenatal",'null')|| '",'  ||
		 	'"codSexoBiologico": ' || '"'  ||coalesce(nac."codSexoBiologico",'null')|| '",'  ||
			'"peso": ' || '"'  ||coalesce(nac.peso,'null')|| '",'  ||
		 	'"codDiagnosticoPrincipal": ' || '"'  ||dxppal.cie10|| '",'   || 
			'"condicionDestino": ' || '"'  ||coalesce(dxMuerte.cie10,'null')|| '",'  ||
		 	'"codDiagnosticoCausaMuerte": ' || '"'  ||egreso.codigo|| '",'   || 
		'"fechaEgreso": ' || '"'  ||nac."fechaEgreso"|| '",'   || 
		'"consecutivo": ' || '"'  ||nac.consecutivo|| '",'   || 
		'}]}'
	INTO valorRecienNacidos
	from rips_ripstransaccion
	left join rips_ripsreciennacido nac on (nac."ripsTransaccion_id" = rips_ripstransaccion.id)
	left join clinico_diagnosticos dxppal on (dxppal.id =nac."codDiagnosticoPrincipal_id")
	left join clinico_diagnosticos dxMuerte on (dxMuerte.id =  nac."codDiagnosticoCausaMuerte_id")
	left join rips_ripsDestinoEgreso egreso on (egreso.id = nac."condicionDestinoUsuarioEgreso_id" )
	left join rips_ripstiposdocumento tipoDoc on (tipoDoc.id = nac."tipoDocumentoIdentificacion_id" )
	where  rips_ripstransaccion."ripsEnvio_id" = envioRipsId and   rips_ripstransaccion."numFactura" =cast(facturaId as text);

	valorJson = valorJson ||' ' || totalRecienNacidos;

end if;

	if (tipo = 'GLOSA') then 

	SELECT '{"urgencias": [{"codPrestador": ' ||  '"' || nac."codPrestador"|| '",'  ||
	   	    '"tipoDocumentoIdentificacion": ' || '"'  ||tipoDoc.codigo|| '",'  || 	
			 '"numDocumentoIdentificacion": ' || '"'  ||nac."numDocumentoIdentificacion"|| '",'   || 
	 		'"fechaNacimiento": ' || '"'  ||nac."fechaNacimiento"|| '",'   || 
		  '"edadGestacional": ' || '"'  ||nac."edadGestacional"|| '",'    ||
			'"numConsultasCPrenatal": ' || '"'  ||coalesce(nac."numConsultasCPrenatal",'null')|| '",'  ||
		 	'"codSexoBiologico": ' || '"'  ||coalesce(nac."codSexoBiologico",'null')|| '",'  ||
			'"peso": ' || '"'  ||coalesce(nac.peso,'null')|| '",'  ||
		 	'"codDiagnosticoPrincipal": ' || '"'  ||dxppal.cie10|| '",'   || 
			'"condicionDestino": ' || '"'  ||coalesce(dxMuerte.cie10,'null')|| '",'  ||
		 	'"codDiagnosticoCausaMuerte": ' || '"'  ||egreso.codigo|| '",'   || 
		'"fechaEgreso": ' || '"'  ||nac."fechaEgreso"|| '",'   || 
		'"consecutivo": ' || '"'  ||nac.consecutivo|| '",'   || 
		'}]}'
	INTO valorRecienNacidos
	from rips_ripstransaccion
	left join rips_ripsreciennacido nac on (nac."ripsTransaccion_id" = rips_ripstransaccion.id)
	left join clinico_diagnosticos dxppal on (dxppal.id =nac."codDiagnosticoPrincipal_id")
	left join clinico_diagnosticos dxMuerte on (dxMuerte.id =  nac."codDiagnosticoCausaMuerte_id")
	left join rips_ripsDestinoEgreso egreso on (egreso.id = nac."condicionDestinoUsuarioEgreso_id" )
	left join rips_ripstiposdocumento tipoDoc on (tipoDoc.id = nac."tipoDocumentoIdentificacion_id" )
	where  rips_ripstransaccion."ripsEnvio_id" = envioRipsId and   rips_ripstransaccion."numNota" =cast(facturaId as text);

	valorJson = valorJson ||' ' || totalRecienNacidos;
 
end if;

end if;
raise notice 'Va esto en el JSON RECIEN NACIDOS : %s' , valorJson;
 
	SELECT REPLACE (valorJson, '""', '')
	into valorJson;
 
   RETURN valorJson ;
END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION generaFacturaDualJSON
  OWNER TO postgres;

  
select generaFacturaDualJSON(47,12,'GLOSA');
select generaFacturaDualJSON(46,42,'FACTURA');
select generaFacturaDualJSON(46,42,'FACTURA');
select generaFacturaDualJSON(45,46,'FACTURA');

select generaFacturaJSON(46,42);

select * from rips_ripshospitalizacion;
select * from rips_ripsurgenciasobservacion;
select * from rips_ripstransaccion
