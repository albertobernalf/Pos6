select * from  farmacia_farmaciaDespachos;
select * from  farmacia_farmaciaDespachosdispensa;

select * from  farmacia_farmacia;
select * from  farmacia_farmaciaDetalle;

select * from enfermeria_enfermeria;
select * from enfermeria_enfermeriadetalle;
update enfermeria_enfermeriadetalle set "farmaciaDetalle_id" = 6;
select * from enfermeria_enfermeriarecibe;

select * from clinico_historia;
select * from clinico_unidadesdemedidadosis;
select * from enfermeria_enfermeriarecibe;

delete from enfermeria_enfermeria;
delete from enfermeria_enfermeriadetalle;
delete from enfermeria_enfermeriarecibe;
delete from farmacia_farmaciaDespachosdispensa
delete from farmacia_farmaciaDespachos
delete from farmacia_farmaciadetalle


-- update farmacia_farmacia set estado_id=2;
select hist."tipoDoc_id" tipoDoc, usu.documento documento, usu.nombre paciente, hist."consecAdmision" aonsecutivo,
	  estados.nombre,origen.nombre, mov.nombre, sum.nombre,det."dosisCantidad" dosis, dosis.descripcion dosis,   vias.nombre,
	det."cantidadOrdenada" cantidad, det."diasTratamiento" tratamiento
FROM farmacia_farmacia far
INNER JOIN farmacia_farmaciadetalle det ON (det.farmacia_id = far.id)
LEFT JOIN farmacia_farmaciaestados estados  ON (estados.id = far.estado_id)
INNER JOIN clinico_historia hist ON (hist.id = far.historia_id)
INNER JOIN usuarios_usuarios usu ON (usu.id=hist.documento_id)
INNER JOIN enfermeria_enfermeriatipoorigen origen ON (origen.id = far."tipoOrigen_id")
INNER JOIN enfermeria_enfermeriatipomovimiento mov ON (mov.id = far."tipoOrigen_id")
INNER JOIN facturacion_suministros sum ON (sum.id= det.suministro_id)
INNER JOIN clinico_viasadministracion vias ON (vias.id= det."viaAdministracion_id")
INNER JOIN clinico_unidadesdemedidadosis dosis ON (dosis.id= det."dosisUnidad_id")
where far.id=11

	select * from admisiones_ingresos;
select * from sitios_dependencias;

detalle = 
	
	select hist."tipoDoc_id" tipoDoc, tipos.nombre nombreTipoDoc, usu.documento documento, usu.nombre paciente, hist."consecAdmision" consecutivoAdmision ,
	serv.nombre servicio, dep.numero cama
	FROM farmacia_farmacia far 
	INNER JOIN clinico_historia hist ON (hist.id = far.historia_id) 
	INNER JOIN usuarios_usuarios usu ON (usu.id=hist.documento_id)
	INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id=hist."tipoDoc_id") 
	INNER JOIN admisiones_ingresos ingreso ON (ingreso."tipoDoc_id" =hist."tipoDoc_id" and ingreso.documento_id=hist.documento_id and ingreso.consec = hist."consecAdmision") 
    INNER Join sitios_dependencias dep on (dep.id=ingreso."dependenciasActual_id")
	INNER Join clinico_servicios serv on (serv.id=ingreso."serviciosActual_id")
	where far.id= 11

    INNER Join sitios_dependencias dep on (dep.id=ingreso."dependenciasActual_id") INNER Join clinico_servicios serv on (serv.id=ingreso."serviciosActual_id")
	
select usu.id id,  hist."tipoDoc_id" tipoDoc, tipos.nombre nombreTipoDoc, usu.documento documento, usu.nombre paciente, hist."consecAdmision" consecutivoAdmision, serv.nombre servicio, dep.numero cama FROM farmacia_farmacia far INNER JOIN clinico_historia hist ON (hist.id = far.historia_id) INNER JOIN usuarios_usuarios usu ON (usu.id=hist.documento_id) INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id=hist."tipoDoc_id") INNER Join sitios_dependencias dep on (dep.id=ingreso."dependenciasActual_id") INNER Join clinico_servicios serv on (serv.id=ingreso."serviciosActual_id") where far.id= '11'
detalle ='select  far.id id,estados.nombre estadoNombre ,origen.nombre origenNombre, mov.nombre movNombre, sum.nombre suministro, 	det."dosisCantidad" dosis, dosis.descripcion unidadDosis,   vias.nombre,	det."cantidadOrdenada" cantidad, det."diasTratamiento" tratamiento FROM farmacia_farmacia far INNER JOIN farmacia_farmaciadetalle det ON (det.farmacia_id = far.id) LEFT JOIN farmacia_farmaciaestados estados  ON (estados.id = far.estado_id) INNER JOIN enfermeria_enfermeriatipoorigen origen ON (origen.id = far."tipoOrigen_id") INNER JOIN enfermeria_enfermeriatipomovimiento mov ON (mov.id = far."tipoOrigen_id") INNER JOIN facturacion_suministros sum ON (sum.id= det.suministro_id) INNER JOIN clinico_viasadministracion vias ON (vias.id= det."viaAdministracion_id") INNER JOIN clinico_unidadesdemedidadosis dosis ON (dosis.id= det."dosisUnidad_id") where far.id= + "'" + str(farmaciaId) + "'"

select * from farmacia_farmaciadespachos;
select * from farmacia_farmaciadespachosdispensa;
	
select dispensa.id id, dispensa.despacho_id despacho , sum.nombre suministro, 	dispensa."dosisCantidad" dosis, dosis.descripcion unidadDosis,   vias.nombre via,	dispensa."cantidadOrdenada" cantidad, dispensa."diasTratamiento" tratamiento
FROM farmacia_farmaciadespachosdispensa dispensa
INNER JOIN farmacia_farmaciaDetalle detalle ON (detalle.id = dispensa."farmaciaDetalle_id")
INNER JOIN facturacion_suministros sum ON (sum.id= dispensa.suministro_id)
INNER JOIN clinico_viasadministracion vias ON (vias.id= dispensa."viaAdministracion_id") 
	INNER JOIN clinico_unidadesdemedidadosis dosis ON (dosis.id= dispensa."dosisUnidad_id")
	WHERE DETALLE.FARMACIA_ID=11;	

	
select dispensa.id id, dispensa.despacho_id despacho , sum.nombre suministro, 	dispensa."dosisCantidad" dosis, dosis.descripcion unidadDosis,   vias.nombre via,	dispensa."cantidadOrdenada" cantidad, dispensa."diasTratamiento" tratamiento
FROM farmacia_farmaciadespachosdispensa dispensa
INNER JOIN farmacia_farmaciaDetalle detalle ON (detalle.id = dispensa."farmaciaDetalle_id")
INNER JOIN facturacion_suministros sum ON (sum.id= dispensa.suministro_id)
INNER JOIN clinico_viasadministracion vias ON (vias.id= dispensa."viaAdministracion_id") 
	INNER JOIN clinico_unidadesdemedidadosis dosis ON (dosis.id= dispensa."dosisUnidad_id")
	WHERE detalle.FARMACIA_ID=11;

detalle = 'select dispensa.id id, dispensa.despacho_id despacho , sum.nombre suministro, 	dispensa."dosisCantidad" dosis, dosis.descripcion unidadDosis,   vias.nombre via,	dispensa."cantidadOrdenada" cantidad, dispensa."diasTratamiento" tratamiento FROM farmacia_farmaciadespachosdispensa dispensa INNER JOIN farmacia_farmaciaDetalle detalle ON (detalle.id = dispensa."farmaciaDetalle_id") INNER JOIN facturacion_suministros sum ON (sum.id= dispensa.suministro_id) INNER JOIN clinico_viasadministracion vias ON (vias.id= dispensa."viaAdministracion_id") INNER JOIN clinico_unidadesdemedidadosis dosis ON (dosis.id= dispensa."dosisUnidad_id") WHERE detalle.FARMACIA_ID=' + "'" + str(farmaciaDetalleId) + "'"
	
select * from farmacia_farmacia;
select * from usuarios_usuarios;
	select * from admisiones_ingresos;
	select * from clinico_historia;

select far.id id,origen.nombre origen, mov.nombre mov , serv.nombre servicio, far.historia_id historia, est.nombre estado,
tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, servicios.nombre servicio, dep.nombre cama	
FROM farmacia_farmacia far
INNER JOIN enfermeria_enfermeriatipoorigen origen ON (origen.id =  far."tipoOrigen_id")
	INNER JOIN enfermeria_enfermeriatipomovimiento mov ON (mov.id= far."tipoMovimiento_id") 
	INNER JOIN sitios_serviciosadministrativos serv ON (serv.id = far."serviciosAdministrativos_id") 
	INNER JOIN farmacia_farmaciaEstados est ON (est.id=far.estado_id)
	INNER JOIN clinico_historia hist ON (hist.id = far.historia_id)	
	INNER JOIN admisiones_ingresos adm ON (adm."tipoDoc_id" = hist."tipoDoc_id"  AND adm.documento_id = hist.documento_id AND adm.consec = hist."consecAdmision")
	INNER JOIN usuarios_usuarios usu ON (usu.id = adm.documento_id )
	INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = adm."tipoDoc_id")	
	INNER JOIN sitios_dependencias dep ON (dep.id=adm."dependenciasActual_id") 
	INNER JOIN clinico_servicios servicios ON servicios.id=adm."serviciosActual_id"
	WHERE far."sedesClinica_id" = '1' AND far."fechaRegistro" >= '2025-01-01' 
	ORDER BY far."fechaRegistro" desc

	
INSERT INTO farmacia_farmaciadespachos ("fechaRegistro", "estadoReg",farmacia_id, "serviciosAdministrativosEntrega_id",
	"usuarioEntrega_id", "usuarioRegistro_id","serviciosAdministrativosRecibe_id" , "usuarioRecibe_id")
	VALUES ('2025-07-16 12:14:18.866042','A',11,'11','4','15','4')

select dispensa.id id, dispensa.despacho_id despacho , sum.nombre suministro,   dispensa."dosisCantidad" dosis, dosis.descripcion unidadDosis,   vias.nombre via,     dispensa."cantidadOrdenada" cantidad, dispensa."diasTratamiento" tratamiento FROM farmacia_farmaciadespachosdispensa dispensa INNER JOIN farmacia_farmaciaDetalle detalle ON (detalle.id = dispensa."farmaciaDetalle_id") INNER JOIN facturacion_suministros sum ON (sum.id= dispensa.suministro_id) INNER JOIN clinico_viasadministracion vias ON (vias.id= dispensa."viaAdministracion_id") INNER JOIN clinico_unidadesdemedidadosis dosis ON (dosis.id= dispensa."dosisUnidad_id") WHERE detalle.FARMACIA_ID='6'


INSERT INTO farmacia_farmaciadespachos ("fechaRegistro", "estadoReg",farmacia_id, "serviciosAdministrativosEntrega_id","usuarioEntrega_id", "usuarioRegistro_id","serviciosAdministrativosRecibe_id" , "usuarioRecibe_id") VALUES ('2025-07-16 14:44:34.173563','A',11,'6','3','1','13','4') RETURNING id ;	

delete from farmacia_farmaciaDespachos;

select * from clinico_UnidadesDeMedidaDosis;
select * from clinico_viasAdministracion

select dispensa.id id, dispensa.despacho_id despacho , sum.nombre suministro,   dispensa."dosisCantidad" dosis, 
	dosis.descripcion unidadDosis,   vias.nombre via,    dispensa."cantidadOrdenada" cantidad
	FROM farmacia_farmaciadespachosdispensa dispensa 
	INNER JOIN farmacia_farmaciaDetalle detalle ON (detalle.id = dispensa."farmaciaDetalle_id")
	INNER JOIN facturacion_suministros sum ON (sum.id= dispensa.suministro_id)
	INNER JOIN clinico_viasadministracion vias ON (vias.id= dispensa."viaAdministracion_id") 
	INNER JOIN clinico_unidadesdemedidadosis dosis ON (dosis.id= dispensa."dosisUnidad_id")
	WHERE detalle.farmacia_id='11'

select * from  farmacia_farmaciaDespachos;
select * from  farmacia_farmaciaDespachosdispensa;

select * from  farmacia_farmacia;
select * from  farmacia_farmaciaDetalle;


select dispensa.id id, dispensa.despacho_id despacho , sum.nombre suministro, 	dispensa."dosisCantidad" dosis,
	dosis.descripcion unidadDosis,   vias.nombre via,	dispensa."cantidadOrdenada" cantidad 
	FROM farmacia_farmaciadespachosdispensa dispensa
	INNER JOIN farmacia_farmaciaDetalle detalle ON (detalle.id = dispensa."farmaciaDetalle_id") 
	INNER JOIN facturacion_suministros sum ON (sum.id= dispensa.suministro_id) 
	INNER JOIN clinico_viasadministracion vias ON (vias.id= dispensa."viaAdministracion_id") 
	INNER JOIN clinico_unidadesdemedidadosis dosis ON (dosis.id= dispensa."dosisUnidad_id") 
	WHERE detalle.FARMACIA_ID= 11


select far.id id,origen.nombre origen, mov.nombre mov , serv.nombre servicio, far.historia_id historia,
	est.nombre estado, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, servicios.nombre servicio, 
	dep.nombre cama 
	FROM farmacia_farmacia far 
	INNER JOIN enfermeria_enfermeriatipoorigen origen ON (origen.id =  far."tipoOrigen_id")
	INNER JOIN enfermeria_enfermeriatipomovimiento mov ON (mov.id= far."tipoMovimiento_id") 
	INNER JOIN sitios_serviciosadministrativos serv ON (serv.id = far."serviciosAdministrativos_id") 
	INNER JOIN farmacia_farmaciaEstados est ON (est.id=far.estado_id) 
	INNER JOIN clinico_historia hist ON (hist.id = far.historia_id) 
	INNER JOIN admisiones_ingresos adm ON (adm."tipoDoc_id" = hist."tipoDoc_id"  AND adm.documento_id = hist.documento_id AND adm.consec = hist."consecAdmision") 
	INNER JOIN usuarios_usuarios usu ON (usu.id = adm.documento_id )
	INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = adm."tipoDoc_id")  
	INNER JOIN sitios_dependencias dep ON (dep.id=adm."dependenciasActual_id") 
	INNER JOIN clinico_servicios servicios ON servicios.id=adm."serviciosActual_id" 
	WHERE far."sedesClinica_id" = '1' AND far."fechaRegistro" >= '2025-01-01' 
	ORDER BY far."fechaRegistro" desc