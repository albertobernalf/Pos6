select * from facturacion_liquidacion;
select * from facturacion_liquidaciondetalle;
SELECT facturas.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" fechaIngreso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida, dep.nombre camaNombreSalida , diag.nombre dxSalida , conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd , contratacion_convenios conv , facturacion_facturacion facturas WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" AND  i."sedesClinica_id" = '1' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosSalida_id" = ser.id AND i."salidaClinica" = 'S' and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and  u.id = i."documento_id" and diag.id = i."dxSalida_id" and i."fechaSalida" is not null and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasSalida_id" AND facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and facturas."consecAdmision" = i.consec and facturas.convenio_id = conv.id  and i."fechaSalida" between '2024-11-14 00:00:00'  and '2024-11-15 23:59:59'

delete from facturacion_liquidacion where id=16;
delete from facturacion_liquidaciondetalle where liquidacion_id=16

delete from facturacion_facturacion where id  in (29)
select * from facturacion_facturaciondetalle where facturacion_id in (29)

select * from clinico_historia order by id;
select "salidaClinica",* from admisiones_ingresos; -- 50083

select * from clinico_historialdiagnosticos;
select * from usuarios_usuarios;

delete from facturacion_facturacion where id=29;
delete from facturacion_facturaciondetalle where facturacion_id=29

select * from facturacion_facturacion
select * from facturacion_facturaciondetalle

select * from sitios_dependencias where documento_id=1;
-- 10;"203";"hab 203";"hab 203";"2024-09-18 11:35:21.609235-05";"A";1;1;1;2;"O";1;1;"";"2024-09-18 11:35:21.609235-05";1
select * from sitios_historialdependencias  where documento_id=1;
-- 79;1;"2024-09-18 06:29:31.322974-05";"2024-09-18 06:29:31.35565-05";"2024-09-18 06:29:31.322974-05";"A";3;1;1;1;"O"
-- 83;1;"2024-09-18 06:29:31.322974-05";"2024-09-18 11:35:21.609235-05";"2024-09-18 11:35:21.609235-05";"A";3;1;1;;"L"

select consec, "fechaRegistro",'fechaRegistro','A',id,documento_id,"tipoDoc_id",'ursuario','L'
from sitios_dependencias
where documento_id=1;


comando = 'INSERT INTO sitios_historialdependencias SELECT consec,' + "'" + str(fechaRegistro) + "'," + "'" + str(fechaRegistro) + "'," + 'A' + "', id" + "'" + str(ingresoId.documento_id) + "'," + "'" + str(ingresoId.tipoDoc_id) + "'," + "'" +str(username_id) + "'" + "'" + str('L') + "'" +  ' from sitios_dependencias where "tipoDoc_id" = + "'" + str(ingresoId.tipoDoc_id) + "' AND documento_id = "  + "'" + str(ingresoId.documento_id) + "' AND consec = " + "'" + str(ingresoId.consec) + "'"




