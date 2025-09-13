select * from clinico_examenes
where "codigoCups" in ('834930','770501','808051','836001')

SELECT * FROM planta_planta;
select * from clinico_tiposexamen
select "requiereAutorizacion",* from clinico_examenes where nombre like ('%POTASIO%')
select "requiereAutorizacion",* from clinico_examenes where nombre like ('%INSERCI%CATE%') -- 389105
select "requiereAutorizacion",* from clinico_examenes where nombre like ('%RADIOGRAFIA DE TORAX%') -- "871121"
	"RADIOGRAFIA DE TORAX (P.A. O A.P. Y LATERAL, DECUBITO LATERAL, OBLICUAS O LATERAL) CON BARIO"
select "requiereAutorizacion",* from clinico_examenes where nombre like ('%HEMOGRAMA%') -- ""902207""
"HEMOGRAMA I (HEMOGLOBINA HEMATOCRITO Y LEUCOGRAMA) MANUAL"	

	update clinico_examenes set "requiereAutorizacion"='N' WHERE "codigoCups" IN ('871121');
	update clinico_examenes set "requiereAutorizacion"='S' WHERE "codigoCups" IN ('871121','902207');
	RADIOGRAFIA DE TORAX (AP PA o LATERAL)

select * from autorizaciones_autorizaciones;
select * from autorizaciones_autorizacionesdetalle;
select * from contratacion_convenios;
select * from facturacion_liquidacion
 
select * from facturacion_liquidaciondetalle

	select * from clinico_estadoexamenes

select * from facturacion_conveniospacienteingresos;

select * from clinico_historia order by id desc;

select * from clinico_historiaexamenes where id=735;
select * from clinico_historiaexamenes where "codigoCups"= '902207'

	-- arreglar este query con inners joins
	select resul.id rasgosId, exam.id examId,  exam."tiposExamen_id" tipoExamenId, tip.nombre tipoExamen, exam."codigoCups" codigoCups,
	examenes.nombre nombreExamen,exam.cantidad cantidad,rasgos.unidad unidad, exam.observaciones observaciones, 
	exam."estadoExamenes_id" estado,resul.valor valorResultado,rasgos.nombre nombreRasgo, rasgos.minimo minimo, 
	rasgos.maximo maximo, resul.observaciones observa 
	from clinico_historiaexamenes exam, clinico_tiposexamen tip,
	clinico_examenes examenes, clinico_historiaresultados resul, clinico_examenesrasgos rasgos 
	where resul."historiaExamenes_id" = exam.id and exam.id ='735' and tip.id=exam."tiposExamen_id" and
	exam."tiposExamen_id" = examenes."TiposExamen_id" And exam."codigoCups" = examenes."codigoCups"
	AND resul."examenesRasgos_id" = rasgos.id  And exam."codigoCups" = rasgos."codigoCups"


	-- ARREGLAR ESTE QUERY
	

		select resul.id rasgosId, exam.id examId,  exam."tiposExamen_id" tipoExamenId, tip.nombre tipoExamen, exam."codigoCups" codigoCups,
	examenes.nombre nombreExamen,exam.cantidad cantidad,rasgos.unidad unidad, exam.observaciones observaciones, 
	exam."estadoExamenes_id" estado,resul.valor valorResultado,rasgos.nombre nombreRasgo, rasgos.minimo minimo, 
	rasgos.maximo maximo, resul.observaciones observa 
	from clinico_historiaexamenes exam
	 INNER JOIN clinico_tiposexamen tip on (tip.id=exam."tiposExamen_id"  )
	INNER JOIN clinico_examenes examenes on ( examenes."TiposExamen_id" =exam."tiposExamen_id" AND  examenes."codigoCups"  = exam."codigoCups" )
	LEFT JOIN clinico_examenesrasgos rasgos ON (rasgos."codigoCups" =  exam."codigoCups")
	LEFT JOIN clinico_historiaresultados resul ON  (resul."examenesRasgos_id" = rasgos.id)
	where resul."historiaExamenes_id" = exam.id and exam.id ='735' 

	
	select * from clinico_estadoexamenes

select * from clinico_historiaexamenes;
select * from autorizaciones_autorizaciones;
select * from autorizaciones_autorizacionesdetalle;

select * from facturacion_liquidacion
select * from facturacion_liquidaciondetalle
select * from admisiones_ingresos;

select * from clinico_especialidadesmedicos;
select * from planta_planta
select * from clinico_historia order by id desc
	
	select * from clinico_medicos;
select * from planta_planta

select * from sitios_serviciossedes;

select * from autorizaciones_autorizaciones order by id desc
	select * from autorizaciones_autorizacionesdetalle order by id desc
SELECT aut.id id FROM autorizaciones_autorizaciones  aut, clinico_historia historia WHERE  aut.historia_id = historia.id AND historia."tipoDoc_id" = '1' AND historia.documento_id = '60' AND historia."consecAdmision" = '1' AND aut.historia_id = '1275'

select * from tarifarios_tarifariosprocedimientos where "tiposTarifa_id" = 10;
select * from tarifarios_TarifariosDescripcion
select * from tarifarios_tipostarifa;
select * from tarifarios_tipostarifaProducto

select tarproc.id id, tiptar.nombre tipoTarifa, exa."codigoCups" cups, tarproc."codigoHomologado" codigoHomologado,
	exa.nombre exaNombre, tarproc."colValorBase", tarproc."colValor1", tarproc."colValor2" , tarproc."colValor3"  , 
	tarproc."colValor4"   , tarproc."colValor5"   , tarproc."colValor6"   , tarproc."colValor7"        ,
	tarproc."colValor8"   , tarproc."colValor9" , tarproc."colValor10" 
	from tarifarios_tipostarifaProducto tarprod, tarifarios_tipostarifa tiptar, tarifarios_TarifariosDescripcion tardes,
	tarifarios_tarifariosprocedimientos tarproc, clinico_examenes exa
	where tarprod.id = tiptar."tiposTarifaProducto_id" and tiptar.id = tardes."tiposTarifa_id" and
	tarproc."tiposTarifa_id" = tiptar.id and tardes.columna='colValorBase' and exa.id = tarproc."codigoCups_id" and
	tarproc."tiposTarifa_id" ='10'
 
update tarifarios_TarifariosDescripcion set columna = 'colValorBase' where id=36

SELECT histoexa.id examId ,'INGRESO' tipoIng, i.id||'-INGRESO' , tp.nombre tipoDoc,u.documento documento,
	u.nombre nombre,i.consec consec , i."fechaIngreso" , i."fechaSalida",ser.nombre servicioNombreIng, 
	dep.nombre camaNombreIng ,diag.nombre dxActual ,historia.fecha fechaExamen,tipoExa.nombre tipoExamen ,
	exam.nombre examen ,estadosExam.nombre estadoExamen ,histoexa.consecutivo consecutivo,histoexa."codigoCups" cups,
	histoexa.cantidad cantidad, histoexa.observaciones observa, historia.folio folio 
	FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,
	usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag ,
	sitios_serviciosSedes sd , clinico_tiposexamen tipoExa,  clinico_examenes exam, clinico_historiaexamenes histoexa, 
	clinico_historia historia, clinico_estadoexamenes estadosExam 
	WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and 
	i."sedesClinica_id" = dep."sedesClinica_id" AND i."sedesClinica_id" = '1' AND  deptip.id = dep."dependenciasTipo_id"
	and i."serviciosActual_id" = ser.id AND dep.disponibilidad = 'O' AND i."salidaDefinitiva" = 'N'
	and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and 
	diag.id = i."dxActual_id" and i."fechaSalida" is null and 
	dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id" 
	AND u."tipoDoc_id" = historia."tipoDoc_id" AND u.id = historia.documento_id AND historia.id = histoexa.historia_id AND
	i.consec = historia."consecAdmision" AND histoexa."tiposExamen_id" = tipoExa.id and 
	histoexa."tiposExamen_id" = exam."TiposExamen_id" and histoexa."codigoCups" = exam."codigoCups" AND
	histoexa."estadoExamenes_id" = estadosExam.id AND estadosExam.nombre != 'ORDENADO'
	
	UNION SELECT histoexa.id examId ,' + "'"  + str("TRIAGE") + "'" + ' tipoIng, t.id'  + "||" +"'" + '-TRIAGE' + "'," + '  tp.nombre tipoDoc,u.documento documento,u.nombre nombre,t.consec consec , t."fechaSolicita" , cast(' + "'" + str('0001-01-01 00:00:00') + "'" + ' as timestamp) fechaSalida,ser.nombre servicioNombreIng, dep.nombre camaNombreIng , ' + "''" + ' dxActual , historia.fecha fechaExamen,    tipoExa.nombre tipoExamen,exam.nombre examen,estadosExam.nombre estadoExamen,histoexa.consecutivo consecutivo,histoexa."codigoCups" cups, histoexa.cantidad cantidad, histoexa.observaciones observa , historia.folio folio  FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  ,sitios_serviciosSedes sd, clinico_servicios ser , clinico_tiposexamen tipoExa,  clinico_examenes exam, clinico_historiaexamenes histoexa,  clinico_historia historia, clinico_estadoexamenes estadosExam WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND t."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = ' + "'" + str('TRIAGE') + "'" + ' AND u."tipoDoc_id" = historia."tipoDoc_id" AND u.id = historia.documento_id AND historia.id = histoexa.historia_id AND t."consecAdmision" = historia."consecAdmision" AND histoexa."tiposExamen_id" = tipoExa.id and  histoexa."tiposExamen_id" = exam."TiposExamen_id" and histoexa."codigoCups" = exam."codigoCups" AND histoexa."estadoExamenes_id" = estadosExam.id AND estadosExam.nombre != ' + "'" + str('ORDENADO') +  "'"
    