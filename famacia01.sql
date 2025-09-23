select * from enfermeria_enfermeriadevolucion
select * from enfermeria_enfermeriadevoluciondetalle
select * from farmacia_farmaciadevolucion
select * from farmacia_farmaciadevoluciondetalle

select * from planta_planta
select * from enfermeria_turnosenfermeria;
select * from clinico_historiamedicamentos;
select * from facturacion_suministros where id = 9130;
update facturacion_suministros set nombre = '5-FLUOROURACIL 5% GEL PROPIO ' where id = 9130;
select * from facturacion_suministros where nombre like('%FLUOROURAC%%')
select * from enfermeria_enfermeriaplaneacion; -- est
select * from enfermeria_enfermeria -- ingresoPaciente estaba en 141
update 	enfermeria_enfermeria set "ingresoPaciente" = 50277 where id=132

select * from enfermeria_enfermeriadevolucion;
select * from clinico_historiamedicamentos;
select * from facturacion_liquidacion;
select * from enfermeria_enfermeriarecibe;
select * from admisiones_ingresos;
select * from triage_triage;

select * from farmacia_farmacia;
select * from farmacia_farmaciadetalle;
select * from farmacia_farmaciadespachos
	select * from farmacia_farmaciadespachosdispensa
select * from farmacia_farmaciadevolucion;
select * from farmacia_farmaciadevoluciondetalle;

SELECT recibe.id id, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, hist.folio folio, 
	fardet."consecutivoMedicamento" consecutivoMedicamento, recibe."dosisCantidad" dosis, 
	recibe."cantidadDispensada" cantidad, 	  medida.descripcion UnidadMedida, sum.nombre medicamento, via.nombre via , 
	frec.descripcion frecuencia, enfdet."diasTratamiento" , dev."cantidadDevuelta"
FROM admisiones_ingresos ing 
INNER JOIN clinico_historia hist ON (hist."tipoDoc_id" = ing."tipoDoc_id" AND hist.documento_id=ing.documento_id AND hist."consecAdmision" = ing.consec) 
INNER JOIN farmacia_farmacia far ON (far.historia_id= hist.id) 
INNER JOIN farmacia_farmaciadetalle fardet ON (fardet.farmacia_id = far.id)
INNER JOIN	enfermeria_enfermeriarecibe recibe ON (recibe."farmaciaDetalle_id" = fardet.id) 
INNER JOIN	enfermeria_enfermeriadetalle enfdet ON (enfdet.id = recibe."enfermeriaDetalle_id") 
INNER JOIN facturacion_suministros sum ON (sum.id = recibe.suministro_id) 
INNER JOIN clinico_viasadministracion via ON (via.id = recibe."viaAdministracion_id")
INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = recibe."dosisUnidad_id")
LEFT JOIN clinico_frecuenciasaplicacion frec ON (frec.id = enfdet."frecuencia_id")
INNER JOIN usuarios_usuarios usu ON (usu.id = ing.documento_id) 
INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = usu."tipoDoc_id")	
LEFT JOIN enfermeria_enfermeriadevoluciondetalle dev ON (dev."enfermeriaRecibe_id" = recibe.id )
WHERE ing.id='50277'
UNION
SELECT recibe.id id, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, 0 folio,  
fardet."consecutivoMedicamento" consecutivoMedicamento, recibe."dosisCantidad" dosis,  recibe."cantidadDispensada" cantidad,
medida.descripcion UnidadMedida, sum.nombre medicamento, via.nombre via , frec.descripcion frecuencia,
enfdet."diasTratamiento" , dev."cantidadDevuelta"
FROM admisiones_ingresos ing 
INNER JOIN farmacia_farmacia far ON (far."ingresoPaciente"= ing.id)
INNER JOIN farmacia_farmaciadetalle fardet ON (fardet.farmacia_id = far.id) 
INNER JOIN enfermeria_enfermeriarecibe recibe ON (recibe."farmaciaDetalle_id" = fardet.id)
INNER JOIN	enfermeria_enfermeriadetalle enfdet ON (enfdet.id = recibe."enfermeriaDetalle_id") 
INNER JOIN	enfermeria_enfermeria enf ON (enf.id = enfdet.enfermeria_id and enf.historia_id is null) 
	
INNER JOIN facturacion_suministros sum ON (sum.id = recibe.suministro_id) 
INNER JOIN clinico_viasadministracion via ON (via.id = recibe."viaAdministracion_id") 
INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = recibe."dosisUnidad_id") 
LEFT JOIN clinico_frecuenciasaplicacion frec ON (frec.id = enfdet."frecuencia_id") 
INNER JOIN usuarios_usuarios usu ON (usu.id = ing.documento_id)
INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = usu."tipoDoc_id")
LEFT JOIN enfermeria_enfermeriadevoluciondetalle dev ON (dev."enfermeriaRecibe_id" = recibe.id )
WHERE ing.id='50277' ORDER BY 5,6

select * from enfermeria_enfermeria;
	select * from enfermeria_enfermeriarecibe;
	select * from enfermeria_enfermeriadetalle;
select * from enfermeria_enfermeriadevolucion;
select * from enfermeria_enfermeriadevoluciondetalle;
select * from farmacia_farmaciadevolucion;
select * from farmacia_farmaciadevoluciondetalle;

select * from admisiones_ingresos;
