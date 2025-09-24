SELECT facturas.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,	
	i.consec consec , i."fechaIngreso" fechaIngreso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida,
	dep.nombre camaNombreSalida , diag.nombre dxSalida , conv.nombre convenio, conv.id convenioId , 
	i."salidaClinica" salidaClinica, facturas."estadoReg" estadoReg 
	FROM admisiones_ingresos i 
	INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id" and sd.id = i."serviciosSalida_id") 
	INNER JOIN sitios_historialdependencias histdep ON ( histdep.dependencias_id = i."dependenciasSalida_id") 
	INNER JOIN sitios_dependencias dep ON (dep.id=histdep.dependencias_id) 	
	INNER JOIN sitios_dependenciastipo deptip  ON (deptip.id = dep."dependenciasTipo_id")
	INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" =  i."tipoDoc_id" AND u.id = i."documento_id" )
	INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") 
   	INNER JOIN clinico_servicios ser  ON ( ser.id  = sd.servicios_id )
	INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxSalida_id")
	INNER JOIN facturacion_facturacion facturas ON (facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and facturas."consecAdmision" = i.consec ) 
	inner JOIN contratacion_convenios conv  ON (conv.id = facturas.convenio_id )
	WHERE i."fechaSalida" between '2025-01-01 00:00:00' and '2025-12-31 00:00:00' AND i."sedesClinica_id" = '1'
	GROUP BY 	facturas.id  , facturas."fechaFactura" , tp.nombre ,u.documento ,u.nombre , i.consec , i."fechaIngreso"  ,
	i."fechaSalida" , ser.nombre ,	dep.nombre  , diag.nombre  , conv.nombre , conv.id  , 	i."salidaClinica" , 
	facturas."estadoReg"
UNION
SELECT facturas.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,	
	i.consec consec , i."fechaIngreso" fechaIngreso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida,
	dep.nombre camaNombreSalida , diag.nombre dxSalida , conv.nombre convenio, conv.id convenioId , 
	i."salidaClinica" salidaClinica, facturas."estadoReg" estadoReg 
	FROM admisiones_ingresos i 
	left JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id" and sd.id = i."serviciosSalida_id") 
	left JOIN sitios_historialdependencias histdep ON ( histdep.dependencias_id = i."dependenciasSalida_id") 
	left JOIN sitios_dependencias dep ON (dep.id=histdep.dependencias_id) 	
	left JOIN sitios_dependenciastipo deptip  ON (deptip.id = dep."dependenciasTipo_id")
	INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" =  i."tipoDoc_id" AND u.id = i."documento_id" )
	INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") 
   	inner JOIN clinico_servicios ser  ON ( ser.id  = sd.servicios_id )
	INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxSalida_id")
	INNER JOIN facturacion_facturacion facturas ON (facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and facturas."consecAdmision" = i.consec ) 
	inner JOIN contratacion_convenios conv  ON (conv.id = facturas.convenio_id )
	inner JOIN facturacion_conveniospacienteingresos convPac  ON (convPac.convenio_id = conv.id and  convPac.factura_id =facturas.id  )
	WHERE i."fechaSalida" is null AND i."sedesClinica_id" = '1'
	GROUP BY 	facturas.id  , facturas."fechaFactura" , tp.nombre ,u.documento ,u.nombre , i.consec , i."fechaIngreso"  ,
	i."fechaSalida" , ser.nombre ,	dep.nombre  , diag.nombre  , conv.nombre , conv.id  , 	i."salidaClinica" , 
	facturas."estadoReg"


select dev.id, dev."fechaRegistro" fechaRegistro ,servDevuelve.nombre servicioDevuelve,plantaDevuelve.nombre usuarioDevuelve,
	servRecibe.nombre servicioRecibe,plantaRecibe.nombre usuarioRecibe 
	FROM farmacia_farmaciadevolucion dev
	INNER JOIN sitios_serviciosadministrativos servDevuelve ON (servDevuelve.id = dev."serviciosAdministrativosDevuelve_id") 
	LEFT JOIN 	sitios_serviciosadministrativos servRecibe ON (servRecibe.id = dev."serviciosAdministrativosRecibe_id" )
	INNER JOIN planta_planta plantaDevuelve  ON (plantaDevuelve.id = dev."usuarioDevuelve_id") 
	LEFT JOIN planta_planta plantaRecibe ON (plantaRecibe.id = dev."usuarioRecibe_id") 
	WHERE dev."fechaRegistro" >='2025-01-01 00:00:00'
	order by dev.id

select * from farmacia_farmaciadevolucion;
select * from farmacia_farmaciadevoluciondetalle; -- farmaciadevolucion_id  /7 farmaciadespachosdispensa_id
select * from farmacia_farmaciadespachosdispensa -- farmaciadetalle_id, despacho_id
	select * from farmacia_farmaciadespachos  -- id
	select * from farmacia_farmaciadetalle -- farmacia_id

 
select dev.id, dev."fechaRegistro" fechaRegistro ,servDevuelve.nombre servicioDevuelve,plantaDevuelve.nombre usuarioDevuelve,
	servRecibe.nombre servicioRecibe,plantaRecibe.nombre usuarioRecibe 
	FROM farmacia_farmaciadevolucion dev
	INNER JOIN farmacia_farmaciadevoluciondetalle devDetalle ON (devDetalle."farmaciaDevolucion_id" = dev.id)
	INNER JOIN farmacia_farmaciadespachosdispensa dispensa ON (dispensa.id = devDetalle."farmaciaDespachosDispensa_id")
	INNER JOIN farmacia_farmaciadespachos despacho ON (despacho.id = dispensa.despacho_id  )	
	INNER JOIN sitios_serviciosadministrativos servDevuelve ON (servDevuelve.id = dev."serviciosAdministrativosDevuelve_id") 
	LEFT JOIN 	sitios_serviciosadministrativos servRecibe ON (servRecibe.id = dev."serviciosAdministrativosRecibe_id" )
	INNER JOIN planta_planta plantaDevuelve  ON (plantaDevuelve.id = dev."usuarioDevuelve_id") 
	LEFT JOIN planta_planta plantaRecibe ON (plantaRecibe.id = dev."usuarioRecibe_id") 
	WHERE dev."fechaRegistro" >='2025-01-01 00:00:00' and despacho.id=98
	order by dev.id

detalle ='select dev.id, dev."fechaRegistro" fechaRegistro ,servDevuelve.nombre servicioDevuelve,plantaDevuelve.nombre usuarioDevuelve, servRecibe.nombre servicioRecibe,plantaRecibe.nombre usuarioRecibe FROM farmacia_farmaciadevolucion dev INNER JOIN farmacia_farmaciadevoluciondetalle devDetalle ON (devDetalle."farmaciaDevolucion_id" = dev.id) INNER JOIN farmacia_farmaciadespachosdispensa dispensa ON (dispensa.id = devDetalle."farmaciaDespachosDispensa_id") INNER JOIN farmacia_farmaciadespachos despacho ON (despacho.id = dispensa.despacho_id  ) INNER JOIN sitios_serviciosadministrativos servDevuelve ON (servDevuelve.id = dev."serviciosAdministrativosDevuelve_id") LEFT JOIN 	sitios_serviciosadministrativos servRecibe ON (servRecibe.id = dev."serviciosAdministrativosRecibe_id" ) INNER JOIN planta_planta plantaDevuelve  ON (plantaDevuelve.id = dev."usuarioDevuelve_id")  LEFT JOIN planta_planta plantaRecibe ON (plantaRecibe.id = dev."usuarioRecibe_id") WHERE  despacho.id=' + "'" + str(despachoId) + "'	order by dev.id"
select *	 from farmacia_farmaciaestados
SELECT * FROM FARMACIA_FARMACIA;	
