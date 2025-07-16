select * from facturacion_facturacion;
select * from facturacion_liquidacion;
select * from facturacion_liquidacionDETALLE;
update facturacion_liquidacion set convenio_id = 1 where id=8

select * from contratacion_convenios;
SELECT * FROM CARTERA_PAGOS;

select * from usuarios_usuarios;
select * from admisiones_ingresos; -- 50084

select * from facturacion_conveniospacienteingresos;
insert into facturacion_conveniospacienteingresos ("consecAdmision","fechaRegistro", "estadoReg", convenio_id,documento_id,"tipoDoc_id", "usuarioRegistro_id") values (1,'2024-11-13 00:00:00','A',1,18,1,1)

select * from facturacion_liquidacion where documento_id=18


-- ESTE ES LA LIQUIDACION TOMADA D ELOS INGRESOS
SELECT 'INGRESO' tipoIng, i.id||'-'||conv.id id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec ,
 i."fechaIngreso" , i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual , 
conv.nombre convenio, conv.id convenioId 
FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , 
sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd , facturacion_conveniospacienteingresos fac,
contratacion_convenios conv 
WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" 
AND i."sedesClinica_id" = '1' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND
 dep.disponibilidad = 'O' AND i."salidaDefinitiva" = 'N' and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and
 u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null and dep."serviciosSedes_id" = sd.id and
 dep.id = i."dependenciasActual_id"  AND fac.documento_id = i.documento_id and fac."tipoDoc_id" = i."tipoDoc_id" and 
fac."consecAdmision" = i.consec and fac.convenio_id = conv.id 
UNION 
SELECT ' + "'"  + str("TRIAGE") + "'" + ' tipoIng, t.id'  + "||" +"'" + "-'||conv.id" + ' id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,t.consec consec , t."fechaSolicita" , cast(' + "'" + str('0001-01-01 00:00:00') + "'" + ' as timestamp) fechaSalida,ser.nombre servicioNombreIng, dep.nombre camaNombreIng , ' + "''" + ' dxActual , conv.nombre convenio, conv.id convenioId   FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  ,sitios_serviciosSedes sd, clinico_servicios ser , facturacion_conveniospacienteingresos fac,contratacion_convenios conv WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND t."sedesClinica_id" = ' "'" + str(sede) + "'" + ' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = ' + "'" + str('TRIAGE') + "'" + ' AND fac.documento_id = t.documento_id and fac."tipoDoc_id" = t."tipoDoc_id" and fac."consecAdmision" = t.consec and fac.convenio_id = conv.id'


-- Y ETE ES LA LIQUIDACION 

select liq.id id,  "consecAdmision",  fecha ,  "totalCopagos" ,  "totalCuotaModeradora" ,  "totalProcedimientos" ,"totalSuministros", 
"totalLiquidacion", "valorApagar", "fechaCorte", anticipos, "detalleAnulacion", "fechaAnulacion", observaciones,
 liq."fechaRegistro", "estadoRegistro", convenio_id, liq."tipoDoc_id" , liq.documento_id, liq."usuarioRegistro_id", 
"totalAbonos", conv.nombre nombreConvenio, usu.nombre paciente, adm.id ingresoId1, usu.documento documento, tip.nombre tipoDocumento 
FROM facturacion_liquidacion liq, contratacion_convenios conv, usuarios_usuarios usu, admisiones_ingresos adm,
 usuarios_tiposdocumento  tip where adm.id = 50084  AND  liq.convenio_id = conv.id and
 usu.id = liq.documento_id  and adm."tipoDoc_id" = liq."tipoDoc_id"   AND tip.id = adm."tipoDoc_id" AND
 adm.documento_id = liq.documento_id  AND adm.consec = liq."consecAdmision" AND conv.id = 1


-- LA FACTURACION

SELECT i.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" fechaIngreso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida, dep.nombre camaNombreSalida , diag.nombre dxSalida , conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica, estadosalida.nombre estadoSalida FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd , contratacion_convenios conv , facturacion_facturacion facturas, clinico_estadossalida estadoSalida WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" AND  i."sedesClinica_id" = '1' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosSalida_id" = ser.id AND i."salidaClinica" = 'S' and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and  u.id = i."documento_id" and diag.id = i."dxSalida_id" and i."fechaSalida" is not null and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasSalida_id" AND facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and facturas."consecAdmision" = i.consec and facturas.convenio_id = conv.id and estadosalida.id = i."salidaMotivo_id" and 
i."fechaSalida" between '2024-10-13 00:00:00'  and '2024-10-13 23:59:59'


-- error en liquidaciondetalle ,, ops falkta el consecutivo
INSERT INTO facturacion_liquidaciondetalle (consecutivo,fecha, cantidad, "valorUnitario", "valorTotal",cirugia,"fechaCrea", "fechaRegistro", "estadoRegistro", "codigoCups_id", cums_id,  "usuarioRegistro_id", liquidacion_id, "tipoRegistro", observaciones) VALUES (' None  ','2024-11-13 16:43:30.892079','1','1200','1200.0','N','2024-11-13 16:43:30.892079','2024-11-13 16:43:30.892079','A',2926,null,'1',8,'MANUAL','nada')