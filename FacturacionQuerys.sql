select * from facturacion_facturacion;
select * from facturacion_liquidacion;
select * from admisiones_ingresos;

select * from rips_ripsservicios;

SELECT i.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec ,
 i."fechaIngreso" fechaIngrso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida, dep.nombre camaNombreSalida , diag.nombre dxSalida ,
 conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica, estadosalida.nombre estadoSalida
FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , 
clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag ,
 sitios_serviciosSedes sd , contratacion_convenios conv ,
facturacion_facturacion facturas, clinico_estadossalida estadoSalida
WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" AND
 i."sedesClinica_id" = '1' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosSalida_id" = ser.id AND 
i."salidaDefinitiva" = 'S' and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and
 u.id = i."documento_id" and diag.id = i."dxSalida_id" and i."fechaSalida" is not null and dep."serviciosSedes_id" = sd.id and
 dep.id = i."dependenciasSalida_id" AND facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and 
facturas."consecAdmision" = i.consec and facturas.convenio_id = conv.id and estadosalida.id = i."salidaMotivo_id" and 
i."fechaSalida" between '2024-11-01 00:00:00' and '2024-12-31 23:59:59'

select "salidaClinica", "salidaMotivo_id","salidaDefinitiva",* from admisiones_ingresos;
select * from clinico_estadossalida; -- 'ALTA MEDICA', 'VOLUNTARIA' , 'FUGA'


SELECT i.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec ,
 i."fechaIngreso" fechaIngrso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida, dep.nombre camaNombreSalida , diag.nombre dxSalida ,
 conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica, estadosalida.nombre estadoSalida
FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , 
clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag ,
 sitios_serviciosSedes sd , contratacion_convenios conv ,
facturacion_facturacion facturas, clinico_estadossalida estadoSalida
WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" AND
 i."sedesClinica_id" = '1' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosSalida_id" = ser.id AND 
i."salidaDefinitiva" = 'S' and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and
 u.id = i."documento_id" and diag.id = i."dxSalida_id" and i."fechaSalida" is not null and dep."serviciosSedes_id" = sd.id and
 dep.id = i."dependenciasSalida_id" AND facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and 
facturas."consecAdmision" = i.consec and facturas.convenio_id = conv.id and estadosalida.id = i."salidaMotivo_id"
 and i.factura >= 1 and i.factura <= 10


-- Primero por fecha

detalle = 'SELECT i.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" fechaIngrso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida, dep.nombre camaNombreSalida , diag.nombre dxSalida , conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica, estadosalida.nombre estadoSalida FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd , contratacion_convenios conv , facturacion_facturacion facturas, clinico_estadossalida estadoSalida WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" AND  i."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosSalida_id" = ser.id AND i."salidaDefinitiva" = 'S' and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and  u.id = i."documento_id" and diag.id = i."dxSalida_id" and i."fechaSalida" is not null and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasSalida_id" AND facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and facturas."consecAdmision" = i.consec and facturas.convenio_id = conv.id and estadosalida.id = i."salidaMotivo_id" and i."fechaSalida" between ' + "'" + str(desdeFecha) + "' and '" + str(hastaFecha) + "'" 