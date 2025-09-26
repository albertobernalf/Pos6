select * from facturacion_empresas;
select * from autorizaciones_autorizaciones;
select "especialidadesMedicos_id",* from clinico_historia;

select * from clinico_especialidadesmedicos;
select * from planta_planta;
select * from clinico_medicos;
select * from autorizaciones_autorizacionesdetalle;
select * from clinico_examenes;
select * from facturacion_suministros;
select anulado,"estadoReg","fechaAnulacion",* from facturacion_facturacion;
select * from facturacion_refacturacion;
select * from facturacion_facturaciondetalle;
select * from facturacion_liquidacion;
select * from facturacion_liquidaciondetalle;
select anulado,"estadoReg",* from facturacion_facturacion;
select * from admisiones_ingresos;
select * from facturacion_facturaciondetalle where facturacion_id=95
select * from facturacion_conveniospacienteingresos;
select anulado,"estadoReg",* from facturacion_facturacion;
update facturacion_facturacion set "estadoReg" = 'A'  where id=95;
update facturacion_facturaciondetalle set "estadoRegistro" ='A' where facturacion_id=95
select * from cartera_pagosFacturas;
select * from admisiones_ingresos; --fechasalida = "2025-09-24 11:52:40.1977-05" NO TOCAR
select * from rips_ripstransaccion;
select * from rips_ripsmedicamentos;
select * from rips_ripsprocedimientos;
select * from rips_ripsusuarios;
select * from admisiones_ingresos;

 SELECT generaFacturaJSON(60,95,'FACTURA') dato

select * from facturacion_refacturacion;
select consec,"consecAdmision",* from triage_triage;
select * from facturacion_liquidacion;
select * from facturacion_liquidaciondetalle

	select * from usuarios_usuarios;
select * from triage_triage;

SELECT histExa.id id ,planta.nombre medico,hist.fecha fecha,hist.folio folio, tiposExa.nombre tipo ,histExa.consecutivo consecutivo, 
	histExa."codigoCups" cups,  exa.nombre examen, histExa.cantidad
	FROM clinico_historia hist 
	INNER JOIN 	clinico_historiaexamenes histExa ON (histExa.historia_id = hist.id)
	INNER JOIN 	clinico_tiposexamen tiposExa ON ( tiposExa.id = histExa."tiposExamen_id") 
	INNER JOIN clinico_examenes exa ON (exa."TiposExamen_id" = tiposExa.id and exa."codigoCups" = histExa."codigoCups") 
	INNER JOIN planta_planta planta on (planta.id=hist.planta_id) 
	WHERE hist."tipoDoc_id" = '1' AND hist.documento_id = 60 and hist."consecAdmision" = 0
	order by hist.fecha, hist.folio

SELECT histExa.id id ,planta.nombre medico,hist.fecha fecha,hist.folio folio, tiposExa.nombre tipo ,histExa.consecutivo consecutivo, 
	histExa."codigoCups" cups,  exa.nombre examen, histExa.cantidad
	FROM clinico_historia hist 
	INNER JOIN 	clinico_historiaexamenes histExa ON (histExa.historia_id = hist.id)
	INNER JOIN 	clinico_tiposexamen tiposExa ON ( tiposExa.id = histExa."tiposExamen_id") 
	INNER JOIN clinico_examenes exa ON (exa."TiposExamen_id" = tiposExa.id and exa."codigoCups" = histExa."codigoCups") 
	INNER JOIN planta_planta planta on (planta.id=hist.planta_id) 
	INNER JOIN triage_triage tri ON (tri."tipoDoc_id" = hist."tipoDoc_id"  AND  tri.documento_id = hist.documento_id 
	and tri.consec=0 and tri."consecAdmision"= 0 and tri."fechaSolicita" <= hist.fecha)
	WHERE hist."tipoDoc_id" = '1' AND hist.documento_id = 60 and hist."consecAdmision" = 0
	order by hist.fecha, hist.folio

select consec,"consecAdmision",* from triage_triage;

SELECT histoexa.id examId , historia.fecha fechaExamen,tipoExa.nombre tipoExamen ,exam.nombre examen , estadosExam.nombre estadoExamen ,
	histoexa.consecutivo consecutivo,histoexa."codigoCups" cups,  histoexa.cantidad cantidad, histoexa.observaciones observa, historia.folio folio
	FROM clinico_historia historia
	INNER JOIN clinico_historiaexamenes histoexa on (histoexa.historia_id = historia.id)
	INNER JOIN clinico_tiposexamen tipoExa ON (tipoExa.id = histoexa."tiposExamen_id" ) 
	INNER JOIN  clinico_examenes exam ON (exam."TiposExamen_id" = tipoExa.id  and  exam."TiposExamen_id" = histoexa."tiposExamen_id" AND  exam."codigoCups" =   Histoexa."codigoCups")
	INNER JOIN clinico_estadoexamenes estadosExam ON (estadosExam.id = histoexa."estadoExamenes_id" AND estadosExam.id != '1') 
	INNER JOIN triage_triage tri ON (tri."tipoDoc_id" = historia."tipoDoc_id"  AND  tri.documento_id = historia.documento_id and tri.consec=0 and tri."consecAdmision"= 0 and tri."fechaSolicita" <= historia.fecha) 
	WHERE  historia."sedesClinica_id" = '1' AND historia."tipoDoc_id" =  '1' AND historia.documento_id = '60' AND historia."consecAdmision" = '0'
	ORDER BY historia.folio
select * from clinico_historiaexamenes where historia_id in (1434,1435,1433);	

select * from clinico_historia order by id desc
select * from admisiones_ingresos;
select * from triage_triage;
select documento_id, convenio_id,* from facturacion_liquidacion;
select * from facturacion_liquidaciondetalle where liquidacion_id=244;

select * from facturacion_conveniospacienteingresos;
select * from farmacia_farmacia;

select * from clinico_historiamedicamentos;

select * from farmacia_farmacia;
select * from enfermeria_enfermeria;
SELECT * FROM FACTURACION_LIQUIDACIONDETALLE ORDER BY ID DESC
SELECT * FROM FACTURACION_SUMINISTROS WHERE  ID=15238
UPDATE FACTURACION_SUMINISTROS SET NOMBRE = 'VERAPAMILO2 TABLETAS 80 MG' WHERE  ID=15238

select * from clinico_historiaexamenes;
select * from clinico_historia where id=1436
select * from facturacion_suministros where id=807