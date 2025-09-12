select * from clinico_examenes
where "codigoCups" in ('834930','770501','808051','836001')

SELECT * FROM planta_planta;

select "requiereAutorizacion",* from clinico_examenes where nombre like ('%POTASIO%')
select "requiereAutorizacion",* from clinico_examenes where nombre like ('%INSERCI%CATE%') -- 389105
select "requiereAutorizacion",* from clinico_examenes where nombre like ('%RADIOGRAFIA DE TORAX%') -- "871121"
	"RADIOGRAFIA DE TORAX (P.A. O A.P. Y LATERAL, DECUBITO LATERAL, OBLICUAS O LATERAL) CON BARIO"
select "requiereAutorizacion",* from clinico_examenes where nombre like ('%HEMOGRAMA%') -- ""902207""
"HEMOGRAMA I (HEMOGLOBINA HEMATOCRITO Y LEUCOGRAMA) MANUAL"	

	update clinico_examenes set "requiereAutorizacion"='S' WHERE "codigoCups" IN ('871121','902207');
	RADIOGRAFIA DE TORAX (AP PA o LATERAL)

select * from autorizaciones_autorizaciones;
select * from contratacion_convenios;

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

	
	select * from clinico_estadoexamenes

select * from clinico_historiaexamenes;
select * from autorizaciones_autorizaciones;
select * from autorizaciones_autorizacionesdetalle;

select * from facturacion_liquidacion
select * from facturacion_liquidaciondetalle
select * from admisiones_ingresos;

select * from clinico_especialidadesmedicos;
select * from planta_planta

	select * from clinico_medicos;
select * from planta_planta

select * from sitios_serviciossedes;
