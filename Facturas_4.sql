select * from clinico_servicios;
select * from sitios_serviciossedes;

select "estadoReg","estadoSalida_id","salidaMotivo_id",* from admisiones_ingresos where documento_id='19'; -- "estadoSalida_id"
select * from triage_triage;

select * from facturacion_liquidaciondetalle

SELECT * FROM CLINICO_SERVICIOS;
select * from cirugia_estadoscirugias;
SELECT * FROM SITIOS_DEPENDENCIAS;

SELECT "estadoCirugia_id",* FROM CIRUGIA_CIRUGIAS
select * from facturacion_liquidacion

select * from usuarios_usuarios ;

select * from clinico_tipossalidas;

select convenio_id,* from facturacion_facturacion where documento_id='19'
select convenio_id,* from facturacion_liquidacion where documento_id='19'
select "estadoReg","estadoSalida_id","salidaMotivo_id",* from admisiones_ingresos where documento_id='19'; -- "estadoSalida_id"
update facturacion_facturacion set "cufeDefinitivo" = '6b7dd1910792ec82b16f5a30d83da5c8f10895b42e3a685a8ee0f0edfc9e32e087576ba23525a50091a6eeb5bd9a9c5e',
        "codigoQr" = 'C:\EntornosPython\Pos6\JSONCLINICA\CodigosQr\Factura_1.png'
where id=77

select * from facturacion_facturaciondetalle where facturacion_id=77;

delete from facturacion_facturaciondetalle where id =218

select * from facturacion_liquidaciondetalle
select * from admisiones_ingresos where documento_id='19'
UPDATE admisiones_ingresos  set "fechaSalida" = null where documento_id='19'

select * from cartera_pagos where documento_id='19'
select * from cartera_pagosfacturas where "facturaAplicada_id" = 80
	
SELECT * FROM facturacion_conveniospacienteingresos WHERE DOCUMENTO_ID='19'
select * from sitios_dependencias  where documento_id='19'

	select * from facturacion_conveniospacienteingresos WHERE DOCUMENTO_ID='19'
	update facturacion_conveniospacienteingresos set factura_id=77 where id=183
select * from sitios_dependencias  where id=12

update 	sitios_dependencias set documento_id='19', "tipoDoc_id"=1,consec=1, disponibilidad= 'O' where id=12
select * from sitios_historialdependencias  where documento_id='19'
select * from sitios_dependencias 	where documento_id='19'
select * from admisiones_ingresos where documento_id='19'	

select * from cartera_pagos where documento_id='19'
select * from cartera_pagosfacturas where "facturaAplicada_id" = 77
select * from facturacion_refacturacion;


	
	
	UNION
	SELECT ' + "'" + str('TRIAGE') + "'" + "||'-'||" + ' t.id' + "||" + "'" + "-'||case when conv.id != 0 then conv.id else " + "'" + str('00') + "'" + ' end id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre, t.consec consec , t."fechaSolicita" , cast(' + "'" + str('0001-01-01 00:00:00') + "'" + ' as timestamp) fechaSalida,sd.nombre servicioNombreIng, dep.nombre camaNombreIng , ' + "' '" + ' dxActual , conv.nombre convenio, conv.id convenioId , ' + "'" + str('N') + "'" + ' salidaClinica  FROM triage_triage t   INNER JOIN sitios_serviciosSedes sd ON (t."sedesClinica_id" = sd."sedesClinica_id" AND sd.id = t."serviciosSedes_id" )  INNER JOIN clinico_servicios ser ON ( ser.id = sd.servicios_id AND ser.nombre = ' + "'" + str('TRIAGE') + "')" + '  INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  t."sedesClinica_id" and dep.id = t.dependencias_id  AND dep.disponibilidad = ' + "'" + str('O') + "'" + ' AND dep."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and t."consecAdmision" = 0 and dep."documento_id" = t."documento_id") INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = t."tipoDoc_id" and fac.documento_id = t.documento_id and  fac."consecAdmision" = t.consec ) LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) WHERE  t."sedesClinica_id" = ' + "'" + str(sede) + 
		"' UNION "  +
		
select * from facturacion_conveniospacienteingresos where documento_id ='19'	
select * from facturacion_conveniospacienteingresos where documento_id ='43'	
update 		facturacion_conveniospacienteingresos set factura_id=62 where id= 181
		select * from usuarios_usuarios;
	
SELECT 'INGRESO'||'-'||i.id||'-'||case when conv.id != 0 then conv.id else '00' end id, tp.nombre tipoDoc,
u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" , i."fechaSalida", sd.nombre servicioNombreIng,
	dep.nombre camaNombreIng , diag.nombre dxActual,conv.nombre convenio, conv.id convenioId , 
	i."salidaClinica" salidaClinica 
FROM admisiones_ingresos i 
INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id" and sd.id  = i."serviciosActual_id")  
inner join clinico_servicios ser on (ser.id = sd.servicios_id)  
INNER join sitios_historialdependencias histdep on (i."tipoDoc_id" = histdep."tipoDoc_id" and i.documento_id = histdep."documento_id" and i.consec=histdep.consec)  
INNER JOIN  sitios_dependencias dep  ON (dep.id =  histdep.dependencias_id)
INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id")
INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i.documento_id ) 
INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") 
INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxActual_id")
inner JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and  fac."consecAdmision" = i.consec ) 
inner JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) 
inner join facturacion_refacturacion refact on (cast(refact."facturaAnulada" as integer)  = fac.factura_id)	
WHERE i."sedesClinica_id" =  '1' AND ((i."salidaDefinitiva" = 'R')) and (histdep.id = (select max(histdep1.id) from sitios_historialdependencias histdep1 where histdep1."tipoDoc_id" = histdep."tipoDoc_id" and histdep1.documento_id = histdep.documento_id and histdep1.consec = histdep.consec))

		select * from facturacion_refacturacion;
select * from usuarios_usuarios where id=58;		

select documento_id,* from clinico_historia order by id desc;
select * from clinico_historiaexamenes where historia_id = 1203
select * from clinico_examenes where "codigoCups"		= '999200'
		select * from clinico_examenes where "codigoCups"		= '904101'
select convenio_id,* from facturacion_liquidacion where documento_id='58'
select * from facturacion_liquidaciondetalle where liquidacion_id=204
		
select * from facturacion_liquidaciondetalle where liquidacion_id>=204