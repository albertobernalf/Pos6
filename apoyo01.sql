select * from usuarios_usuarios order by id desc

select * from facturacion_conveniospacienteingresos where documento_id='19'
select convenio_id,* from facturacion_liquidacion  where documento_id='19'
delete from facturacion_liquidacion where id=216

	select * from admisiones_ingresos  where documento_id='55'
select * from sitios_dependencias where documento_id='55'
select * from sitios_historialdependencias where documento_id='16'


SELECT 'INGRESO'||'-'||i.id||'-'||case when conv.id != 0 then conv.id else '00' end id, tp.nombre tipoDoc, u.documento documento,
	u.nombre nombre,i.consec consec , i."fechaIngreso" , i."fechaSalida", sd.nombre servicioNombreIng, dep.nombre camaNombreIng ,
	diag.nombre dxActual,conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica 
	FROM admisiones_ingresos i 
	INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id" 	and sd.id  = i."serviciosActual_id")
	inner join clinico_servicios ser on (ser.id = sd.servicios_id)
	INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  i."sedesClinica_id" and
	dep.id = i."dependenciasActual_id" and dep."serviciosSedes_id" = sd.id   AND  (dep.disponibilidad= 'O' OR (dep.disponibilidad = 'L' AND ser.id=3)) AND 
	dep."serviciosSedes_id" = sd.id ) 	
	INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") 
	INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i."documento_id" ) 
	INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") 	
	INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxActual_id")
	LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and  fac."consecAdmision" = i.consec  and fac.factura_id is null) 
	LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) 
	WHERE i."sedesClinica_id" =  '1' AND ((i."salidaDefinitiva" = 'N')) 
	UNION

	SELECT 'TRIAGE'||'-'||t.id||'-'||case when conv.id != 0 then conv.id else '00' end id, tp.nombre tipoDoc,
	u.documento documento,u.nombre nombre, t.consec consec , t."fechaSolicita" , cast('0001-01-01 00:00:00' as timestamp) fechaSalida,
	sd.nombre servicioNombreIng, dep.nombre camaNombreIng , ' ' dxActual , conv.nombre convenio, conv.id convenioId ,
	'N' salidaClinica  
	FROM triage_triage t   
	INNER JOIN sitios_serviciosSedes sd ON (t."sedesClinica_id" = sd."sedesClinica_id" AND sd.id = t."serviciosSedes_id" ) 
	INNER JOIN clinico_servicios ser ON ( ser.id = sd.servicios_id AND ser.nombre = 'TRIAGE')
	INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  t."sedesClinica_id" and dep.id = t.dependencias_id  AND
	dep.disponibilidad = 'O' AND dep."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and 
	t."consecAdmision" = 0 and dep."documento_id" = t."documento_id")
	INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") 
	INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" ) 
	INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") 
	LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = t."tipoDoc_id" and fac.documento_id = t.documento_id and  fac."consecAdmision" = t.consec ) 
	LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id)
	WHERE  t."sedesClinica_id" = '1' 
	UNION
	SELECT 'INGRESO'||'-'||i.id||'-'||case when conv.id != 0 then conv.id else '00' end id, tp.nombre tipoDoc,
	u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" , i."fechaSalida", sd.nombre servicioNombreIng,
	dep.nombre camaNombreIng , diag.nombre dxActual,conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica 
	FROM admisiones_ingresos i 
	INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id" and sd.id  = i."serviciosActual_id") 
	inner join clinico_servicios ser on (ser.id = sd.servicios_id) 
	INNER join sitios_historialdependencias histdep on (i."tipoDoc_id" = histdep."tipoDoc_id" and i.documento_id = histdep."documento_id" and i.consec=histdep.consec)  
	INNER JOIN  sitios_dependencias dep  ON (dep.id =  histdep.dependencias_id) 
	INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id")
	INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i.documento_id ) 
	INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") 
	INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxActual_id")
	LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and  fac."consecAdmision" = i.consec ) 
	LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) 
	inner join facturacion_refacturacion refact on (cast(refact."facturaAnulada" as integer)  = fac.factura_id) 
	WHERE i."sedesClinica_id" =  '1' AND ((i."salidaDefinitiva" = 'R')) and (histdep.id = (select max(histdep1.id) from sitios_historialdependencias histdep1 where histdep1."tipoDoc_id" = histdep."tipoDoc_id" and histdep1.documento_id = histdep.documento_id and histdep1.consec = histdep.consec))


SELECT * FROM FACTURACION_FACTURACION WHERE documento_id='19'
select * from facturacion_refacturacion;

SELECT * FROM FACTURACION_liquidacion WHERE documento_id='19'
	select * from admisiones_ingresos  where documento_id='19'

select "serviciosAdministrativos_id" ,* from clinico_historiaexamenes

select exam.id examId,  exam."tiposExamen_id" tipoExamenId, tip.nombre tipoExamen, exam."codigoCups" CupsId , 
	examenes.nombre nombreExamen,exam.cantidad cantidad, exam.observaciones observaciones, exam."estadoExamenes_id" estado,
	historia.folio folio,exam.interpretacion1 interpretacion1,exam.interpretacion2 interpretacion2, 
	exam."medicoInterpretacion1_id" medicoInterpretacion1,exam."medicoInterpretacion2_id" medicoInterpretacion2,
	exam."medicoReporte_id" medicoReporte, exam."rutaImagen" rutaImagen, exam."rutaVideo" rutaVideo , 
	est.nombre estadoNombre, exam."serviciosAdministrativos_id" dependencias  
	from clinico_historiaexamenes exam, clinico_historia historia, clinico_tiposexamen tip, clinico_examenes examenes , 
	clinico_estadoexamenes est
	where historia.id= exam.historia_id and exam.id = '652' and 
	tip.id=exam."tiposExamen_id" and exam."tiposExamen_id" = examenes."TiposExamen_id" 
	And exam."codigoCups" = examenes."codigoCups" and est.id = exam."estadoExamenes_id"


	select * from clinico_historia where id=1162

select resul.id rasgosId, exam.id examId,  exam."tiposExamen_id" tipoExamenId, tip.nombre tipoExamen,
	exam."codigoCups" codigoCups,examenes.nombre nombreExamen,exam.cantidad cantidad,rasgos.unidad unidad, 
	exam.observaciones observaciones, exam."estadoExamenes_id" estado,resul.valor valorResultado,rasgos.nombre nombreRasgo,
	rasgos.minimo minimo, rasgos.maximo maximo, resul.observaciones observa 
	from clinico_historiaexamenes exam, clinico_tiposexamen tip, clinico_examenes examenes, clinico_historiaresultados resul,
	clinico_examenesrasgos rasgos 
	where resul."historiaExamenes_id" = exam.id and exam.id ='652' and
	tip.id=exam."tiposExamen_id" and exam."tiposExamen_id" = examenes."TiposExamen_id" And
	exam."codigoCups" = examenes."codigoCups" AND resul."examenesRasgos_id" = rasgos.id  And
	exam."codigoCups" = rasgos."codigoCups"
	
	
select * from clinico_historiaexamenes order by id desc;
select * from clinico_historiaresultados order by id desc;
select * from clinico_examenesrasgos;

select * from clinico_medicos;

select * from clinico_historiaexamenes where id=652;
select * from clinico_historiaexamenes where id=652;
select * from clinico_examenes where "codigoCups" =  '901241' -- id = 273
select * from clinico_historia where id=1162	
SELECT hisExa.interpretacion1, hisExa."fechaInterpretacion1", med.nombre medico 
FROM historia_historiaexamenes hisExa 
INNER JOIN  clinico_medicos med ON (med.id = hisExa."medicoInterpretacion1_id") INNER JOIN clinico_historia historia on (historia.id = hisExa.historia_id ) 
	WHERE hisExa.historia_id = '1162'


