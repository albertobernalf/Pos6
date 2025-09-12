select * from clinico_historialnotasenfermeria;

select * from clinico_tiposfolio;
select * from clinico_historia order by id desc

INSERT INTO clinico_Historia ("sedesClinica_id", "tipoDoc_id" , documento_id , "consecAdmision", folio ,fecha , "tiposFolio_id" ,"causasExterna_id" , "serviciosAdministrativos_id" , especialidades_id ,planta_id, motivo , subjetivo,objetivo, analisis ,plann, tratamiento ,                apache2, antibioticos, monitoreo, "movilidadLimitada", nauseas, "llenadoCapilar", neurologia, irritacion, pulsos, "retiroPuntos",             inmovilizacion, "notaAclaratoria", "fecNotaAclaratoria", "examenFisico", "noQx", observaciones, "riesgoHemodinamico", riesgos, trombocitopenia, hipotension, "indiceMortalidad", "ingestaAlcohol", "inmovilizacionObservaciones", justificacion, leucopenia, "manejoQx", "fechaRegistro", "usuarioRegistro_id", "estadoReg" , mipres,"ordenMedicaLab","ordenMedicaRad","ordenMedicaTer","ordenMedicaMed","ordenMedicaOxi","ordenMedicaInt", "especialidadesMedicos_id", "ordenDeControl")  VALUES('1','1','1','1','66','2025-09-11 13:41:21.748130+00:00','2','',4,'8','8','','','','','','','0','','','','','','','','','','','','0001-01-01 00:00:00','','','','','','','','0','','','','','','2025-09-11 13:41:21.748130+00:00','8','A','','','','','','','','17','') RETURNING id ;


select * from usuarios_usuarios; -- 16

select convenio_id,* from facturacion_facturacion where documento_id='16'
select * from facturacion_liquidacion where documento_id='16'

select * from facturacion_facturacion order by id desc
select * from facturacion_conveniospacienteingresos where documento_id='16'
select * from admisiones_ingresos  where documento_id='16'

SELECT facturas.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,
	i.consec consec , i."fechaIngreso" fechaIngreso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida,
	dep.nombre camaNombreSalida , diag.nombre dxSalida , conv.nombre convenio, conv.id convenioId , 	
	i."salidaClinica" salidaClinica, facturas."estadoReg" estadoReg
	FROM admisiones_ingresos i 
	inner JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id" and sd.id = i."serviciosSalida_id") 
	--inner JOIN sitios_historialdependencias histdep ON (histdep."tipoDoc_id" = i."tipoDoc_id" AND histdep.documento_id = i.documento_id AND histdep.consec=i.consec) -- AND histdep.disponibilidad= 'L')
	inner JOIN sitios_historialdependencias histdep ON (histdep.dependencias_id = i."dependenciasSalida_id")
	inner JOIN sitios_dependencias dep ON (dep.id=histdep.dependencias_id) 	
	inner JOIN sitios_dependenciastipo deptip  ON (deptip.id = dep."dependenciasTipo_id") 
	inner JOIN usuarios_usuarios u ON (u."tipoDoc_id" =  i."tipoDoc_id" AND u.id = i."documento_id" ) 
	inner JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") 
	inner JOIN clinico_servicios ser  ON ( ser.id  = sd.servicios_id )
	inner JOIN clinico_Diagnosticos diag ON (diag.id = i."dxSalida_id")
	INNER JOIN facturacion_facturacion facturas ON (facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and facturas."consecAdmision" = i.consec ) 
	inner JOIN contratacion_convenios conv  ON (conv.id = facturas.convenio_id )
	WHERE i."fechaSalida" between '2025-01-01 00:00:00' and '2025-12-31 23:59:59' AND i."sedesClinica_id" = '1'
	GROUP BY 	facturas.id  , facturas."fechaFactura" , tp.nombre ,u.documento ,u.nombre , i.consec , i."fechaIngreso"  , i."fechaSalida" , ser.nombre ,	dep.nombre  , diag.nombre  , conv.nombre , conv.id  , 	i."salidaClinica" , facturas."estadoReg" 

 
select documento_id,convenio_id,* from facturacion_facturacion order by id desc;
select * from sitios_historialdependencias where documento_id='19'

	select * from clinico_historialinterconsultas;
SELECT * FROM CLINICO_TIPOSINTERCONSULTA
	select id,especialidades_id,* from clinico_especialidadesmedicos;
select * from clinico_medicos;
select * from clinico_especialidades;
select * from clinico_historia;

select * from clinico_estadosinterconsulta

 SELECT em.id ,e.nombre 
FROM clinico_Especialidades e, clinico_EspecialidadesMedicos em,planta_planta pl 
	 where em."especialidades_id" = e.id and em."planta_id" = pl.id AND pl.documento = '19465673' AND em."sedesClinica_id" = '1'
 
SELECT e.id ,e.nombre 
FROM clinico_Especialidades e, clinico_EspecialidadesMedicos em,planta_planta pl 
where em."especialidades_id" = e.id and em."planta_id" = pl.id AND em."sedesClinica_id" = '1'
	 GROUP BY  e.id ,e.nombre


SELECT m.id id, pla.nombre nombre from clinico_medicos m, clinico_Especialidadesmedicos medesp,clinico_especialidades esp,sitios_sedesclinica sed,  planta_planta pla where  pla.id=medesp.planta_id and  medesp.especialidades_id = esp.id and m.planta_id = pla.id and  esp.id = '2' and esp.id=medesp.especialidades_id and pla."sedesClinica_id" = sed.id and pla.id = medesp.planta_id and pla."sedesClinica_id"='1' order by pla.nombre


	 

detalle =

	SELECT  int."descripcionConsulta", int."respuestaConsulta", int."estadoReg", int.diagnosticos_id, int."especialidadConsultada_id",
	int."estadosInterconsulta_id",int.historia_id, int."especialidadConsulta_id", int."medicoConsulta_id", int."medicoConsultado_id", 
	int."tipoInterconsulta_id", int."ordenMedica"
	FROM clinico_historialinterconsultas int
	INNER JOIN clinico_historia his ON (his.id = int.historia_id)
	INNER JOIN clinico_tiposinterconsulta tipos on (tipos.id =  int."tipoInterconsulta_id")
	INNER JOIN clinico_estadosInterconsulta estado on (estado.id =  int."estadosInterconsulta_id")
	WHERE int."medicoConsultado_id" = '1'

	
SELECT int.id, "descripcionConsulta", "respuestaConsulta", int."estadoReg", diag.nombre diagnostico, esp.nombre espConsulta,
	estados.nombre estadosNombre, historia_id, espmed.nombre especialidadMedico , pla1.nombre medicoConsulta,
	pla2.nombre medicoConsultado, tipos.nombre tiposNombre, "ordenMedica" 
	FROM public.clinico_historialinterconsultas int 
	INNER JOIN clinico_historia his ON (his.id=int.historia_id) 
	INNER JOIN clinico_estadosinterconsulta estados ON (estados.id=int."estadosInterconsulta_id") 
	INNER JOIN clinico_tiposinterconsulta tipos ON (tipos.id = int."tipoInterconsulta_id" ) 
	INNER JOIN clinico_especialidades esp ON (esp.id = int."especialidadConsultada_id")
	INNER JOIN clinico_medicos med1 ON (med1.id = int."medicoConsulta_id" ) 
	INNER JOIN planta_planta pla1 ON (pla1.id = med1.planta_id ) 
	INNER JOIN clinico_medicos med2 ON (med2.id = int."medicoConsultado_id") 
	INNER JOIN planta_planta pla2 ON (pla2.id = med2.planta_id ) 
	INNER JOIN clinico_especialidadesmedicos cliesp ON (cliesp.id = int."especialidadConsulta_id")
	INNER JOIN clinico_especialidades espmed ON (espmed.id= cliesp.especialidades_id  ) 
	LEFT JOIN clinico_diagnosticos diag ON (diag.id = int.diagnosticos_id) 
	WHERE his."sedesClinica_id" = '1' AND med2.planta_id = '1' AND int."estadosInterconsulta_id" = '1'

select * from planta_planta
UPDATE clinico_historialinterconsultas SET "respuestaConsulta" = 'ALA TOMATE UNAS BERENJENAS AL APOR',"estadoInterconsulta_id" = '2',fechaRespuesta" = '2025-09-12 12:48:35.038779+00:00'
	WHERE id = '7'