    SELECT histoexa.id examId ,'INGRESO' tipoIng, i.id||'-INGRESO', tp.nombre tipoDoc,u.documento documento,u.nombre nombre, 
		i.consec consec , i."fechaIngreso" , i."fechaSalida",ser.nombre servicioNombreIng, dep.nombre camaNombreIng ,	
		diag.nombre dxActual ,historia.fecha fechaExamen,tipoExa.nombre tipoExamen ,exam.nombre examen , 
		estadosExam.nombre estadoExamen ,histoexa.consecutivo consecutivo,histoexa."codigoCups" cups, histoexa.cantidad cantidad,
		histoexa.observaciones observa, historia.folio folio 
		FROM admisiones_ingresos i 
		INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i."documento_id")
		INNER JOIN sitios_dependencias dep ON (dep."sedesClinica_id" = i."sedesClinica_id" AND dep.disponibilidad = 'O' and 
		     dep."tipoDoc_id" = u."tipoDoc_id" and  dep.documento_id= u.id) 
		INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") 
		INNER JOIN sitios_dependenciastipo deptip ON ( deptip.id = dep."dependenciasTipo_id")
		LEFT JOIN clinico_Diagnosticos diag on (diag.id = i."dxActual_id")
		INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id" and  sd.id = dep."serviciosSedes_id") 
		INNER JOIN clinico_servicios ser ON (ser.id=sd.servicios_id) 
		INNER JOIN clinico_historia historia ON (historia."tipoDoc_id" =  u."tipoDoc_id" AND historia.documento_id = u.id AND historia."consecAdmision" = i.consec)
		--INNER JOIN clinico_historiaexamenes histoexa on (histoexa.historia_id = historia.id) 
		INNER JOIN clinico_tiposexamen tipoExa ON (tipoExa.id = histoexa."tiposExamen_id" )
		INNER JOIN  clinico_examenes exam ON (exam."TiposExamen_id" = tipoExa.id  and  exam."TiposExamen_id" = histoexa."tiposExamen_id" AND  exam."codigoCups" =   Histoexa."codigoCups")
		LEFT JOIN clinico_estadoexamenes estadosExam ON (estadosExam.id = histoexa."estadoExamenes_id")
		WHERE  i."sedesClinica_id" = '1' AND  i."salidaDefinitiva" = 'N' and i."fechaSalida" is null 
		AND estadosExam.nombre = 'ORDENADO'

-- Query que debe3 ser

    SELECT 'INGRESO' tipoIng, i.id||'-INGRESO', tp.nombre tipoDoc,u.documento documento,u.nombre nombre, 
		i.consec consec , i."fechaIngreso" ,ser.nombre servicioNombreIng, dep.nombre camaNombreIng-- ,	
		FROM admisiones_ingresos i 
		INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i."documento_id")
		INNER JOIN sitios_dependencias dep ON (dep."sedesClinica_id" = i."sedesClinica_id" AND dep.disponibilidad = 'O' and 
		     dep."tipoDoc_id" = u."tipoDoc_id" and  dep.documento_id= u.id) 
		INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") 
		INNER JOIN sitios_dependenciastipo deptip ON ( deptip.id = dep."dependenciasTipo_id")
		INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id" and  sd.id = dep."serviciosSedes_id") 
		INNER JOIN clinico_servicios ser ON (ser.id=sd.servicios_id) 
		WHERE  i."sedesClinica_id" = '1' AND  i."salidaDefinitiva" = 'N' and i."fechaSalida" is null and
		  (u."tipoDoc_id",u.id, i.consec ) IN (SELECT 
						historia."tipoDoc_id", historia.documento_id,historia."consecAdmision"
						FROM clinico_historiaexamenes histoexa 
						INNER JOIN clinico_historia historia ON (historia."tipoDoc_id" =  u."tipoDoc_id" AND historia.documento_id = u.id AND historia."consecAdmision" = i.consec)
						INNER JOIN clinico_estadoexamenes estadosExam ON (estadosExam.id= histoexa."estadoExamenes_id" AND estadosExam.nombre = 'ORDENADO' )
						WHERE histoexa.historia_id = historia.id)
		UNION
    SELECT 'TRIAGE' tipoIng, t.id||'-TRIAGE', tp.nombre tipoDoc,u.documento documento,u.nombre nombre, 
		t.consec consec , t."fechaSolicita" ,ser.nombre servicioNombreIng, dep.nombre camaNombreIng-- ,	
		FROM triage_triage t 
		INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id")
		INNER JOIN sitios_dependencias dep ON (dep."sedesClinica_id" = t."sedesClinica_id" AND dep.disponibilidad = 'O' and 
		     dep."tipoDoc_id" = u."tipoDoc_id" and  dep.documento_id= u.id) 
		INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") 
		INNER JOIN sitios_dependenciastipo deptip ON ( deptip.id = dep."dependenciasTipo_id")
		INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = t."sedesClinica_id" and  sd.id = dep."serviciosSedes_id") 
		INNER JOIN clinico_servicios ser ON (ser.id=sd.servicios_id) 
		WHERE  t."sedesClinica_id" = '1' AND  t."salidaDefinitiva" = 'N' and  
		  (u."tipoDoc_id",u.id, t.consec ) IN (SELECT 
						historia."tipoDoc_id", historia.documento_id,historia."consecAdmision"
						FROM clinico_historiaexamenes histoexa 
						INNER JOIN clinico_historia historia ON (historia."tipoDoc_id" =  u."tipoDoc_id" AND historia.documento_id = u.id AND historia."consecAdmision" = t.consec)
						INNER JOIN clinico_estadoexamenes estadosExam ON (estadosExam.id= histoexa."estadoExamenes_id" AND estadosExam.nombre = 'ORDENADO' )
						WHERE histoexa.historia_id = historia.id)



		


		
		
	