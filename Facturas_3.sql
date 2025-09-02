select documento_id, convenio_id,* from facturacion_facturacion;
select * from factutracion_facturaciondetalle;
select * from facturacion_refacturacion;

select * from facturacion_liquidacion where documento_id='43'
select * from facturacion_liquidaciondetalle where liquidacion_id=203
select * from admisiones_ingresos where documento_id='43'
SELECT * FROM USUARIOS_USUARIOS WHERE ID=43

	SELECT  * FROM sitios_serviciosSedes

SELECT i.id id, tp.nombre tipoDoc,  u.documento documento, u.nombre  nombre , i.consec consec , i."fechaIngreso" , 
	sd.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual, 
	(select count(*)  from facturacion_conveniospacienteingresos conv where conv."tipoDoc_id" = i."tipoDoc_id" and conv.documento_id=i.documento_id  and conv."consecAdmision"=i.consec) numConvenios,	
	(select count(*)  from cartera_pagos pag where pag."tipoDoc_id" = i."tipoDoc_id" and pag.documento_id=i.documento_id  and pag.consec=i.consec) numPagos,	empresa.nombre Empresa,
	date_part('YEAR',  AGE(CURRENT_DATE , U."fechaNacio")) edad, 
	i."salidaClinica" salidaClinica 
	FROM admisiones_ingresos i 
	inner join usuarios_usuarios u on ( u."tipoDoc_id" = i."tipoDoc_id"  and u.id = i."documento_id" )
	left join facturacion_empresas empresa on (empresa.id = i.empresa_id) 
	LEFT join sitios_dependencias dep on (dep.id = i."dependenciasActual_id" and dep."sedesClinica_id" =  i."sedesClinica_id" AND dep.disponibilidad = 'O')
	INNER join sitios_serviciosSedes sd on (sd."sedesClinica_id" = i."sedesClinica_id" and sd.id= dep."serviciosSedes_id" and sd.id  = i."serviciosActual_id") 
	LEFT join clinico_servicios ser on (ser.id = sd.servicios_id and ser.nombre != 'TRIAGE')
	inner join usuarios_tiposDocumento tp on (tp.id = u."tipoDoc_id") 
	LEFT join sitios_dependenciastipo deptip on ( deptip.id = dep."dependenciasTipo_id") 
	left join  clinico_Diagnosticos diag on (diag.id = i."dxActual_id") 
	WHERE  i."sedesClinica_id" = '1' AND i."salidaDefinitiva" IN ('N','R')  -- AND i."fechaSalida" is null 

	--  REFACTURADOS

	
SELECT i.id id, tp.nombre tipoDoc,  u.documento documento, u.nombre  nombre , i.consec consec , i."fechaIngreso" , 
	sd.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual, 
	(select count(*)  from facturacion_conveniospacienteingresos conv where conv."tipoDoc_id" = i."tipoDoc_id" and conv.documento_id=i.documento_id  and conv."consecAdmision"=i.consec) numConvenios,	
	(select count(*)  from cartera_pagos pag where pag."tipoDoc_id" = i."tipoDoc_id" and pag.documento_id=i.documento_id  and pag.consec=i.consec) numPagos,	empresa.nombre Empresa,
	date_part('YEAR',  AGE(CURRENT_DATE , U."fechaNacio")) edad, 
	i."salidaClinica" salidaClinica 
	FROM admisiones_ingresos i 
	inner join usuarios_usuarios u on ( u."tipoDoc_id" = i."tipoDoc_id"  and u.id = i."documento_id" )
	left join facturacion_empresas empresa on (empresa.id = i.empresa_id) 
	INNER join sitios_historialdependencias histdep on (u."tipoDoc_id" = histdep."tipoDoc_id" and u.id = histdep."documento_id")
	INNER join sitios_dependencias dep on (dep.id = histdep.dependencias_id)
	INNER join sitios_serviciosSedes sd on (sd."sedesClinica_id" = i."sedesClinica_id" and sd.id= dep."serviciosSedes_id" and sd.id  = i."serviciosActual_id") 
	LEFT join clinico_servicios ser on (ser.id = sd.servicios_id and ser.nombre != 'TRIAGE')
	inner join usuarios_tiposDocumento tp on (tp.id = u."tipoDoc_id") 
	INNER join sitios_dependenciastipo deptip on ( deptip.id = dep."dependenciasTipo_id") 
	left join  clinico_Diagnosticos diag on (diag.id = i."dxActual_id") 
	WHERE  i."sedesClinica_id" = '1' AND i."salidaDefinitiva" IN ('R')  
group by i.id, tipoDoc,u.documento,u.nombre,i.consec,i."fechaIngreso",servicioNombreIng	, 
		camaNombreIng,dxActual,numConvenios,numPagos,Empresa, edad, salidaClinica

SELECT * FROM SITIOS_HISTORIALDEPENDENCIAS WHERE documento_id='43';	
SELECT * FROM SITIOs_DEPENDENCIAS 

SELECT 'INGRESO'||'-'||i.id||'-'||conv.id  id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec ,
	i."fechaIngreso" , i."fechaSalida", sd.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual,
	conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica 
FROM admisiones_ingresos i
INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id" and sd.id  = i."serviciosActual_id") 
inner join clinico_servicios ser on (ser.id = sd.servicios_id)  
INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  i."sedesClinica_id" and dep.id = i."dependenciasActual_id" and dep."serviciosSedes_id" = sd.id   AND  (dep.disponibilidad= 'O' OR (dep.disponibilidad = 'L' -- AND ser.id=3
	)) AND dep."serviciosSedes_id" = sd.id )
INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") 
INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i."documento_id" )
INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id")
INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxActual_id")
LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and  fac."consecAdmision" = i.consec )  
LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) 
WHERE i."sedesClinica_id" =  '1' AND i."salidaDefinitiva" = 'R'



detalle =


	SELECT 'INGRESO'||'-'||i.id||'-'||conv.id  id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec ,
	i."fechaIngreso" , i."fechaSalida", sd.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual,
	conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica 
FROM admisiones_ingresos i
INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id" and sd.id  = i."serviciosActual_id") 
inner join clinico_servicios ser on (ser.id = sd.servicios_id)  
INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  i."sedesClinica_id" and dep.id = i."dependenciasActual_id" and dep."serviciosSedes_id" = sd.id   AND  (dep.disponibilidad= 'O' OR (dep.disponibilidad = 'L' -- AND ser.id=3
	)) AND dep."serviciosSedes_id" = sd.id )
INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") 
INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i."documento_id" )
INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id")
INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxActual_id")
LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and  fac."consecAdmision" = i.consec )  
LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) 
WHERE i."sedesClinica_id" =  '1' AND i."salidaDefinitiva" = 'R'




	
  

SELECT * FROM SITIOS_DEPENDENCIAS WHERE DOCUMENTO_ID=43;