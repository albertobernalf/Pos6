select * from clinico_historiasignosvitales
select * from cirugia_cirugias;

select documento_id,* from triage_triage;
select * from cirugia_estadosprogramacion

select * from farmacia_farmacia;

select far.id id,origen.nombre origen, mov.nombre mov , serv.nombre servicio, far.historia_id historia,far."ingresoPaciente" ingreso,
	est.nombre estado, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, servicios.nombre servicio, dep.nombre cama
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
	WHERE far."sedesClinica_id" = '1' AND far."fechaRegistro" >= '2025-01-01' and far.estado_id <> '3' 
	UNION 
	select far.id id,origen.nombre origen, mov.nombre mov , serv.nombre servicio, far.historia_id historia,far."ingresoPaciente" ingreso,
	est.nombre estado, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, servicios.nombre servicio, dep.nombre cama 
	FROM farmacia_farmacia far 
	INNER JOIN enfermeria_enfermeriatipoorigen origen ON (origen.id =  far."tipoOrigen_id") 
	INNER JOIN enfermeria_enfermeriatipomovimiento mov ON (mov.id= far."tipoMovimiento_id")
	INNER JOIN sitios_serviciosadministrativos serv ON (serv.id = far."serviciosAdministrativos_id") 
	INNER JOIN farmacia_farmaciaEstados est ON (est.id=far.estado_id) 
	INNER JOIN admisiones_ingresos adm ON (adm.id= far."ingresoPaciente") 
	INNER JOIN usuarios_usuarios usu ON (usu.id = adm.documento_id ) 
	INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = adm."tipoDoc_id")  
	INNER JOIN sitios_dependencias dep ON (dep.id=adm."dependenciasActual_id") 
	INNER JOIN sitios_serviciossedes servicios ON servicios.id=adm."serviciosActual_id"  
	WHERE far."sedesClinica_id" = '1' AND far."fechaRegistro" >= '2025-01-01' and far.estado_id <> '3'
	ORDER BY 6 desc

select * from farmacia_farmaciaestados;
select * from triage_triage;
select "tipoDoc_id",* from clinico_historia;

select * from farmacia_farmacia;

select * from sitios_serviciossedes;

-- triage

+ ' UNION select far.id id,origen.nombre origen, mov.nombre mov , serv.nombre servicio, far.historia_id historia,far."ingresoPaciente" ingreso, est.nombre estado, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, servicios.nombre servicio, 'triage' cama FROM farmacia_farmacia far INNER JOIN enfermeria_enfermeriatipoorigen origen ON (origen.id =  far."tipoOrigen_id") INNER JOIN enfermeria_enfermeriatipomovimiento mov ON (mov.id= far."tipoMovimiento_id")  INNER JOIN sitios_serviciosadministrativos serv ON (serv.id = far."serviciosAdministrativos_id") INNER JOIN farmacia_farmaciaEstados est ON (est.id=far.estado_id) INNER JOIN clinico_historia hist ON (hist.id = far.historia_id) INNER JOIN triage_triage tri ON (tri."tipoDoc_id" = hist."tipoDoc_id"  AND tri.documento_id = hist.documento_id AND tri.consec = hist."consecAdmision") INNER JOIN usuarios_usuarios usu ON (usu.id = tri.documento_id ) INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = tri."tipoDoc_id")  INNER JOIN clinico_servicios servicios ON servicios.id=tri."serviciosSedes_id"  '
	
	WHERE far."sedesClinica_id" = '1' AND far."fechaRegistro" >= '2025-01-01' and far.estado_id <> '3'

select "tipoSuministro_id",* from facturacion_suministros  where nombre like ('%DURAPREP SURGICAL SOLUTION%')

select * from facturacion_tipossuministro;
SELECT * FROM FARMACIA_FARMACIA;
select * from clinico_historia where id=1390

select * from farmacia_farmaciadespachos;
select * from enfermeria_enfermeria;
select * from enfermeria_enfermeriadetalle;
select * from enfermeria_enfermeriarecibe;


SELECT i.id id, tp.nombre tipoDoc,  u.documento documento, u.nombre  nombre , i.consec consec , i."fechaIngreso" , ser.nombre servicioNombreIng, 
	dep.nombre camaNombreIng , diag.nombre dxActual, (select count(*) 
	from facturacion_conveniospacienteingresos conv where conv."tipoDoc_id" = i."tipoDoc_id" and conv.documento_id=i.documento_id  and conv."consecAdmision"=i.consec) numConvenios,   
	(select count(*)  from cartera_pagos pag where pag."tipoDoc_id" = i."tipoDoc_id" and pag.documento_id=i.documento_id  and pag.consec=i.consec) numPagos,        empresa.nombre Empresa, date_part('YEAR' ,  AGE(CURRENT_DATE , U."fechaNacio")) edad, i."salidaClinica" salidaClinica 
	FROM admisiones_ingresos i 
	inner join usuarios_usuarios u on ( u."tipoDoc_id" = i."tipoDoc_id"  and u.id = i."documento_id" )
	left join facturacion_empresas empresa on (empresa.id = i.empresa_id)
	inner join sitios_dependencias dep on (dep.id = i."dependenciasActual_id" and dep."sedesClinica_id" =  i."sedesClinica_id" AND dep.disponibilidad = 'O')
	
	inner join usuarios_tiposDocumento tp on (tp.id = u."tipoDoc_id") 
	inner join sitios_dependenciastipo deptip on ( deptip.id = dep."dependenciasTipo_id")
	left join  clinico_Diagnosticos diag on (diag.id = i."dxActual_id")
	inner join sitios_serviciosSedes sd on (sd."sedesClinica_id" = i."sedesClinica_id" and sd.id= dep."serviciosSedes_id" ) -- and sd.servicios_id  = ser.id)
    inner join clinico_servicios ser on (ser.id = sd.servicios_id ) 
	WHERE  i."sedesClinica_id" = '1' AND i."salidaDefinitiva" = 'N' AND i."fechaSalida" is null
union
SELECT tri.id id, tp.nombre tipoDoc,  u.documento documento, u.nombre  nombre , tri.consec consec , tri."fechaSolicita" , ser.nombre servicioNombreIng, 
	'TRIAGE' camaNombreIng , ''  dxActual, (select count(*) 
	from facturacion_conveniospacienteingresos conv where conv."tipoDoc_id" = tri."tipoDoc_id" and conv.documento_id=tri.documento_id  and conv."consecAdmision"=tri.consec) numConvenios,   
	(select count(*)  from cartera_pagos pag where pag."tipoDoc_id" = tri."tipoDoc_id" and pag.documento_id=tri.documento_id  and pag.consec=tri.consec) numPagos,        empresa.nombre Empresa, date_part('YEAR' ,  AGE(CURRENT_DATE , U."fechaNacio")) edad, 'N' salidaClinica 
	FROM triage_triage tri 
	inner join usuarios_usuarios u on ( u."tipoDoc_id" = tri."tipoDoc_id"  and u.id = tri."documento_id" )
	left join facturacion_empresas empresa on (empresa.id = tri.empresa_id)
	inner join usuarios_tiposDocumento tp on (tp.id = u."tipoDoc_id") 
	inner join sitios_serviciosSedes sd on (sd."sedesClinica_id" = tri."sedesClinica_id" and sd.id= tri."serviciosSedes_id" ) 
    inner join clinico_servicios ser on (ser.id = sd.servicios_id ) 
	WHERE  tri."sedesClinica_id" = '1' AND tri."salidaDefinitiva" = 'N' and tri."consecAdmision" = 0

select * from triage_triage;

select * from enfermeria_enfermeria;
select * from sitios_serviciossedes;
-- el de medicamentos

SELECT recibe.id id, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, hist.folio folio,  fardet."consecutivoMedicamento" consecutivoMedicamento,
	recibe."dosisCantidad" dosis, recibe."cantidadDispensada" cantidad,   medida.descripcion UnidadMedida, sum.nombre medicamento,
	via.nombre via , frec.descripcion frecuencia, enfdet."diasTratamiento" 
	FROM triage_triage tri 
	INNER JOIN clinico_historia hist ON (hist."tipoDoc_id" = tri."tipoDoc_id" AND hist.documento_id=tri.documento_id AND hist."consecAdmision" = tri.consec) 
	INNER JOIN farmacia_farmacia far ON (far.historia_id= hist.id) 
	INNER JOIN farmacia_farmaciadetalle fardet ON (fardet.farmacia_id = far.id) 
	INNER JOIN enfermeria_enfermeriarecibe recibe ON (recibe."farmaciaDetalle_id" = fardet.id)
	INNER JOIN      enfermeria_enfermeriadetalle enfdet ON (enfdet.id = recibe."enfermeriaDetalle_id")
	INNER JOIN facturacion_suministros sum ON (sum.id = recibe.suministro_id) 
	INNER JOIN clinico_viasadministracion via ON (via.id = recibe."viaAdministracion_id")
	INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = recibe."dosisUnidad_id") 
	LEFT JOIN clinico_frecuenciasaplicacion frec ON (frec.id = enfdet."frecuencia_id")
	INNER JOIN usuarios_usuarios usu ON (usu.id = tri.documento_id) 
	INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = usu."tipoDoc_id")      
	WHERE tri.id='136' 
	UNION  
	SELECT recibe.id id, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, 0 folio, 
	fardet."consecutivoMedicamento" consecutivoMedicamento, recibe."dosisCantidad" dosis,  recibe."cantidadDispensada" cantidad,  
	medida.descripcion UnidadMedida, sum.nombre medicamento, via.nombre via , frec.descripcion frecuencia, enfdet."diasTratamiento"  
	FROM triage_triage tri
	INNER JOIN farmacia_farmacia far ON (far."ingresoPaciente"= tri.id and far.historia_id is null)
	INNER JOIN farmacia_farmaciadetalle fardet ON (fardet.farmacia_id = far.id) 
	INNER JOIN enfermeria_enfermeriarecibe recibe ON (recibe."farmaciaDetalle_id" = fardet.id)
	INNER JOIN   enfermeria_enfermeriadetalle enfdet ON (enfdet.id = recibe."enfermeriaDetalle_id") 
	INNER JOIN facturacion_suministros sum ON (sum.id = recibe.suministro_id) 
	INNER JOIN clinico_viasadministracion via ON (via.id = recibe."viaAdministracion_id")
	INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = recibe."dosisUnidad_id")
	LEFT JOIN clinico_frecuenciasaplicacion frec ON (frec.id = enfdet."frecuencia_id") 
	INNER JOIN usuarios_usuarios usu ON (usu.id = tri.documento_id) 
	INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = usu."tipoDoc_id")      
	WHERE tri.id='136' ORDER BY 5,6

select * from triage_triage;
select * from farmacia_farmacia;


--

detalle = 'SELECT recibe.id id, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, hist.folio folio,  fardet."consecutivoMedicamento" consecutivoMedicamento, recibe."dosisCantidad" dosis, recibe."cantidadDispensada" cantidad,   medida.descripcion UnidadMedida, sum.nombre medicamento,via.nombre via , frec.descripcion frecuencia, enfdet."diasTratamiento"  FROM triage_triage tri 	INNER JOIN clinico_historia hist ON (hist."tipoDoc_id" = tri."tipoDoc_id" AND hist.documento_id=tri.documento_id AND hist."consecAdmision" = tri.consec) INNER JOIN farmacia_farmacia far ON (far.historia_id= hist.id) INNER JOIN farmacia_farmaciadetalle fardet ON (fardet.farmacia_id = far.id) INNER JOIN enfermeria_enfermeriarecibe recibe ON (recibe."farmaciaDetalle_id" = fardet.id) INNER JOIN      enfermeria_enfermeriadetalle enfdet ON (enfdet.id = recibe."enfermeriaDetalle_id") INNER JOIN facturacion_suministros sum ON (sum.id = recibe.suministro_id) 	INNER JOIN clinico_viasadministracion via ON (via.id = recibe."viaAdministracion_id") INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = recibe."dosisUnidad_id") LEFT JOIN clinico_frecuenciasaplicacion frec ON (frec.id = enfdet."frecuencia_id") INNER JOIN usuarios_usuarios usu ON (usu.id = tri.documento_id) INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = usu."tipoDoc_id") WHERE tri.id=' + "'" + str(triageId.id) + "'" + ' UNION  SELECT recibe.id id, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, 0 folio, fardet."consecutivoMedicamento" consecutivoMedicamento, recibe."dosisCantidad" dosis,  recibe."cantidadDispensada" cantidad,  medida.descripcion UnidadMedida, sum.nombre medicamento, via.nombre via , frec.descripcion frecuencia, enfdet."diasTratamiento"  FROM triage_triage tri INNER JOIN farmacia_farmacia far ON (far."ingresoPaciente"= tri.id and far.historia_id is null) INNER JOIN farmacia_farmaciadetalle fardet ON (fardet.farmacia_id = far.id) INNER JOIN enfermeria_enfermeriarecibe recibe ON (recibe."farmaciaDetalle_id" = fardet.id) INNER JOIN   enfermeria_enfermeriadetalle enfdet ON (enfdet.id = recibe."enfermeriaDetalle_id") INNER JOIN facturacion_suministros sum ON (sum.id = recibe.suministro_id) 	INNER JOIN clinico_viasadministracion via ON (via.id = recibe."viaAdministracion_id") INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = recibe."dosisUnidad_id") 	LEFT JOIN clinico_frecuenciasaplicacion frec ON (frec.id = enfdet."frecuencia_id") INNER JOIN usuarios_usuarios usu ON (usu.id = tri.documento_id) INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = usu."tipoDoc_id") WHERE tri.id=' + "'" + str(triageId.id) + "'" + ' ORDER BY 5,6'

select * from clinico_historialdietas;
select * from clinico_historia order by id desc