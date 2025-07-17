select historia_id, consecutivo, "tiposExamen_id","codigoCups",  * from clinico_historiaexamenes order by historia_id, consecutivo;

select * from clinico_examenes where "codigoCups" in ('903402','906830','M19275');

select * from clinico_HistoriaMedicamentos; -- id=91 alli va


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
--INNER JOIN clinico_historiamedicamentos histmed ON (histmed.historia_id = hist.id)
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


