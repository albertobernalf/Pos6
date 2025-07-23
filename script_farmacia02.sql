select historia_id, consecutivo, "tiposExamen_id","codigoCups",  * from clinico_historiaexamenes order by historia_id, consecutivo;

select * from clinico_examenes where "codigoCups" in ('903402','906830','M19275');
select  * from farmacia_farmacia;
select * from clinico_HistoriaMedicamentos; -- id=91 alli va

select * from farmacia_farmaciaestados WHERE nombre like ('%DESPA%');
select * from clinico_historia order by id

--delete from farmacia_farmacia;
select * from farmacia_farmacia;
select * from farmacia_farmaciadetalle;
select * from enfermeria_enfermeria;

select * from enfermeria_enfermeriadetalle;
select * from enfermeria_enfermeriarecibe;

select * from farmacia_farmaciadespachos;
delete from farmacia_farmaciadespachos where id=24;
select * from farmacia_farmaciadespachosdispensa;

select * from sitios_serviciosadministrativos;
select * from farmacia_farmaciaestados;

select * from farmacia_farmaciadetalle;

select * from enfermeria_enfermeriarecibe;
select * from admisiones_ingresos where id=50133;
select * from clinico_historia;
select * from clinico_historiamedicamentos;
select * from clinico_unidadesdemedidadosis;

SELECT recibe.id id, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, 
		hist.folio folio, fardet."consecutivoMedicamento" consecutivoMedicamento, recibe."cantidadDispensada" cantidad,
	  medida.descripcion UnidadMedida, sum.nombre medicamento, via.nombre via
FROM admisiones_ingresos ing
INNER JOIN clinico_historia hist ON (hist."tipoDoc_id" = ing."tipoDoc_id" AND hist.documento_id=ing.documento_id AND hist."consecAdmision" = ing.consec)
INNER JOIN farmacia_farmacia far ON (far.historia_id= hist.id)
INNER JOIN farmacia_farmaciadetalle fardet ON (fardet.farmacia_id = far.id)
INNER JOIN	enfermeria_enfermeriarecibe recibe ON (recibe."farmaciaDetalle_id" = fardet.id)
INNER JOIN facturacion_suministros sum ON (sum.id = recibe.suministro_id)
INNER JOIN clinico_viasadministracion via ON (via.id = recibe."viaAdministracion_id")
INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = recibe."dosisUnidad_id")
INNER JOIN usuarios_usuarios usu ON (usu.id = ing.documento_id)
INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = usu."tipoDoc_id")	
WHERE ing.id= 50133
order by hist.folio, fardet."consecutivoMedicamento"

detalle ='SELECT recibe.id id, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, hist.folio folio, fardet."consecutivoMedicamento" consecutivoMedicamento, recibe."cantidadDispensada" cantidad, 	  medida.descripcion UnidadMedida, sum.nombre medicamento, via.nombre via FROM admisiones_ingresos ing INNER JOIN clinico_historia hist ON (hist."tipoDoc_id" = ing."tipoDoc_id" AND hist.documento_id=ing.documento_id AND hist."consecAdmision" = ing.consec) INNER JOIN farmacia_farmacia far ON (far.historia_id= hist.id) INNER JOIN farmacia_farmaciadetalle fardet ON (fardet.farmacia_id = far.id) INNER JOIN	enfermeria_enfermeriarecibe recibe ON (recibe."farmaciaDetalle_id" = fardet.id) INNER JOIN facturacion_suministros sum ON (sum.id = recibe.suministro_id) INNER JOIN clinico_viasadministracion via ON (via.id = recibe."viaAdministracion_id") INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = recibe."dosisUnidad_id") INNER JOIN usuarios_usuarios usu ON (usu.id = ing.documento_id) INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = usu."tipoDoc_id")	WHERE ing.id=' + "'" + str(ingresoId) + "'" + ' order by hist.folio, fardet."consecutivoMedicamento"

select * from clinico_tiposexamen
select "tipoDoc_id", documento_id, "consecAdmision",* from clinico_historia where documento_id='1';

	select "tiposExamen_id",historia_id, * from clinico_historiaexamenes order by historia_id;
	
select  * from clinico_examenes;
	select  * from clinico_historiaexamenes;

	select documento_id,* from clinico_historia where documento_id='1' order by id
	
select a."tiposExamen_id", * 
from clinico_historiaexamenes a where a.historia_id in 
			(select b.id
			from clinico_historia b 
			where b."tipoDoc_id" = '1' AND b.documento_id ='1' AND b."consecAdmision"=1 and b.id=a.historia_id);
	
select * from facturacion_liquidaciondetalle;

	select * from clinico_historia;
	
select * from 	clinico_historiaexamenes 

	-- Consulta PARACLINICOS ENFREMERIA
	
	
SELECT planta.nombre,hist.fecha fecha,hist.folio folio, tiposExa.nombre tipo ,histExa.consecutivo consecutivo,   histExa."codigoCups" cups,  exa.nombre examen, 
	  histExa.cantidad
FROM clinico_historia hist
INNER JOIN 	clinico_historiaexamenes histExa ON (histExa.historia_id = hist.id)
INNER JOIN 	clinico_tiposexamen tiposExa ON ( tiposExa.id = histExa."tiposExamen_id")
INNER JOIN clinico_examenes exa ON (exa."TiposExamen_id" = tiposExa.id and exa."codigoCups" = histExa."codigoCups")
INNER JOIN planta_planta planta on (planta.id=hist.planta_id)
WHERE hist."tipoDoc_id" = '1' AND hist.documento_id='1' and hist."consecAdmision" =1
order by hist.fecha, hist.folio


detalle = 'SELECT planta.nombre,hist.fecha fecha,hist.folio folio, tiposExa.nombre tipo ,histExa.consecutivo consecutivo,   histExa."codigoCups" cups,  exa.nombre examen, histExa.cantidad FROM clinico_historia hist INNER JOIN 	clinico_historiaexamenes histExa ON (histExa.historia_id = hist.id) INNER JOIN 	clinico_tiposexamen tiposExa ON ( tiposExa.id = histExa."tiposExamen_id") INNER JOIN clinico_examenes exa ON (exa."TiposExamen_id" = tiposExa.id and exa."codigoCups" = histExa."codigoCups") INNER JOIN planta_planta planta on (planta.id=hist.planta_id) WHERE hist."tipoDoc_id" = '1' AND hist.documento_id='1' and hist."consecAdmision" =1 order by hist.fecha, hist.folio'
	
select * from enfermeria_enfermeria;	
select * from enfermeria_enfermeriadetalle;
select * from enfermeria_enfermeriarecibe;

	
	select enf.id id,origen.nombre origen, mov.nombre mov , serv.nombre servicio, 
	tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, serv.nombre servicio
	FROM enfermeria_enfermeria enf
	INNER JOIN enfermeria_enfermeriatipoorigen origen ON (origen.id =  enf."tipoOrigen_id") 
	INNER JOIN enfermeria_enfermeriatipomovimiento mov ON (mov.id= enf."tipoMovimiento_id") 
	INNER JOIN sitios_serviciosadministrativos serv ON (serv.id = enf."serviciosAdministrativos_id") 
	INNER JOIN admisiones_ingresos adm ON (adm."tipoDoc_id" = '1'  AND adm.documento_id = '1'AND adm.consec = 1) 
	INNER JOIN usuarios_usuarios usu ON (usu.id = adm.documento_id ) 
	INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = adm."tipoDoc_id")	
	WHERE enf."sedesClinica_id" = '1' AND enf."fechaRegistro" >= '2025-01-01' AND mov.nombre='PEDIDO'
	ORDER BY enf."fechaRegistro" desc


	detalle = '	select enf.id id,origen.nombre origen, mov.nombre mov , serv.nombre servicio, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, serv.nombre servicio FROM enfermeria_enfermeria enf INNER JOIN enfermeria_enfermeriatipoorigen origen ON (origen.id =  enf."tipoOrigen_id") INNER JOIN enfermeria_enfermeriatipomovimiento mov ON (mov.id= enf."tipoMovimiento_id")  INNER JOIN sitios_serviciosadministrativos serv ON (serv.id = enf."serviciosAdministrativos_id") INNER JOIN admisiones_ingresos adm ON (adm."tipoDoc_id" = '1'  AND adm.documento_id = '1'AND adm.consec = 1) INNER JOIN usuarios_usuarios usu ON (usu.id = adm.documento_id ) INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = adm."tipoDoc_id") WHERE enf."sedesClinica_id" = '1' AND enf."fechaRegistro" >= '2025-01-01' AND mov.nombre='PEDIDO' ORDER BY enf."fechaRegistro" desc'

	select * from enfermeria_turnosenfermeria
	select * from enfermeria_TiposTurnosEnfermeria;
	select * from enfermeria_enfermeria
	select * from enfermeria_enfermeriadetalle;
	select * from farmacia_farmaciadetalle;
	select * from enfermeria_enfermeriaRECIBE;
	
SELECT recibe.id id, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, hist.folio folio,
	now() desde, 0 cuantas,
	fardet."consecutivoMedicamento" consecutivoMedicamento, recibe."cantidadDispensada" cantidad, 	  
	medida.descripcion UnidadMedida, sum.nombre medicamento, via.nombre via 
FROM admisiones_ingresos ing 
INNER JOIN clinico_historia hist ON (hist."tipoDoc_id" = ing."tipoDoc_id" AND hist.documento_id=ing.documento_id AND hist."consecAdmision" = ing.consec) 
INNER JOIN farmacia_farmacia far ON (far.historia_id= hist.id) 
INNER JOIN farmacia_farmaciadetalle fardet ON (fardet.farmacia_id = far.id) 
INNER JOIN	enfermeria_enfermeriarecibe recibe ON (recibe."farmaciaDetalle_id" = fardet.id)
INNER JOIN facturacion_suministros sum ON (sum.id = recibe.suministro_id) 
INNER JOIN clinico_viasadministracion via ON (via.id = recibe."viaAdministracion_id")
INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = recibe."dosisUnidad_id") 
INNER JOIN usuarios_usuarios usu ON (usu.id = ing.documento_id) 
INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = usu."tipoDoc_id")	
WHERE ing.id='50133' 
UNION 
SELECT recibe.id id, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, 0 folio,
	now() desde, 0 cuantas,
	fardet."consecutivoMedicamento" consecutivoMedicamento, recibe."cantidadDispensada" cantidad,
	medida.descripcion UnidadMedida, sum.nombre medicamento, via.nombre via
	FROM admisiones_ingresos ing 
	INNER JOIN farmacia_farmacia far ON (far."ingresoPaciente_id"= ing.id)
	INNER JOIN farmacia_farmaciadetalle fardet ON (fardet.farmacia_id = far.id) 
	INNER JOIN	enfermeria_enfermeriarecibe recibe ON (recibe."farmaciaDetalle_id" = fardet.id) 
	INNER JOIN facturacion_suministros sum ON (sum.id = recibe.suministro_id) 
	INNER JOIN clinico_viasadministracion via ON (via.id = recibe."viaAdministracion_id") 
	INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = recibe."dosisUnidad_id")
	INNER JOIN usuarios_usuarios usu ON (usu.id = ing.documento_id) 
	INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = usu."tipoDoc_id")
	WHERE ing.id='50133' 
	ORDER BY 5,6


select * from enfermeria_enfermeriaplaneacion;
SELECT * FROM enfermeria_enfermeriarecibe;
SELECT * FROM farmacia_farmaciadetalle;
	SELECT * FROM enfermeria_enfermeriadetalle;
select * from enfermeria_turnosenfermeria;
select * from enfermeria_tiposturnosenfermeria;
	select * from clinico_unidadesdemedidadosis;

select * from enfermeria_enfermeriaplaneacion;
	select * from clinico_frecuenciasaplicacion;

select pla.id id,pla."fechaPlanea" fechaPlanea, tipos1.nombre turnoPlanea, planta1.nombre enfermeraPlanea, pla."cantidadPlaneada" cantidadPlaneada,
	 pla."fechaAplica" fechaAplica, tipos2.nombre turnoAplica, planta2.nombre enfermeraAplica,   pla."cantidadAplicada" cantidadAplicada,
	 pla."dosisCantidad" dosis, medida.descripcion medida, sum.nombre suministro, vias.nombre via, frec.descripcion frecuencia,
	pla."diasTratamiento"	dias	
FROM enfermeria_enfermeriaplaneacion pla
INNER JOIN enfermeria_enfermeria enf ON (enf.id=pla.enfermeria_id)	
INNER JOIN planta_planta planta1 ON (planta1.id = pla."enfermeraPlanea_id")
INNER JOIN planta_planta planta2 ON (planta2.id = pla."enfermeraAplica_id")
INNER JOIN clinico_viasadministracion vias ON (vias.id = pla."viaAdministracion_id")
INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = pla."dosisUnidad_id")
INNER JOIN clinico_frecuenciasaplicacion frec ON (medida.id = pla.frecuencia_id)
INNER JOIN facturacion_suministros sum	ON (sum.id = pla.suministro_id)
INNER JOIN enfermeria_tiposturnosenfermeria tipos1 ON ( tipos1.id = pla."turnoEnfermeriaPlanea_id")
INNER JOIN enfermeria_tiposturnosenfermeria tipos2 ON ( tipos2.id = pla."turnoEnfermeriaAplica_id")
WHERE enf."sedesClinica_id" = '1' AND enf.historia_id = 1

detalle ='select pla.id id, pla."fechaPlanea" fechaPlanea, tipos1.nombre turnoPlanea, planta1.nombre enfermeraPlanea, pla."cantidadPlaneada" cantidadPlaneada, 	 pla."fechaAplica" fechaAplica, tipos2.nombre turnoAplica, planta2.nombre enfermeraAplica,   pla."cantidadAplicada" cantidadAplicada,	 pla."dosisCantidad" dosis, medida.descripcion medida, sum.nombre suministro, vias.nombre via, frec.descripcion frecuencia,	pla."diasTratamiento" dias FROM enfermeria_enfermeriaplaneacion pla INNER JOIN enfermeria_enfermeria enf ON (enf.id=pla.enfermeria_id)	 INNER JOIN planta_planta planta1 ON (planta1.id = pla."enfermeraPlanea_id") INNER JOIN planta_planta planta2 ON (planta2.id = pla."enfermeraAplica_id") INNER JOIN clinico_viasadministracion vias ON (vias.id = pla."viaAdministracion_id") INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = pla."dosisUnidad_id") INNER JOIN clinico_frecuenciasaplicacion frec ON (medida.id = pla.frecuencia_id) INNER JOIN facturacion_suministros sum	ON (sum.id = pla.suministro_id) INNER JOIN enfermeria_tiposturnosenfermeria tipos1 ON ( tipos1.id = pla."turnoEnfermeriaPlanea_id") INNER JOIN enfermeria_tiposturnosenfermeria tipos2 ON ( tipos2.id = pla."turnoEnfermeriaAplica_id") WHERE enf."sedesClinica_id" = ' + "'" + str(sede) + ' AND enf.historia_id = ' + "'" + str(historiaId) +  "'"
