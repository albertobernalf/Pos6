select * from autorizaciones_autorizaciones;
select * from autorizaciones_autorizacionesdetalle;

 
select * from rips_ripsenvios;
select * from rips_ripsdetalle;
select * from facturacion_facturacion;
update facturacion_facturacion set "ripsEnvio_id" = null where id=47;

select * from rips_ripstransaccion;
SELECT facturas.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" fechaIngreso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida, dep.nombre camaNombreSalida , diag.nombre dxSalida , conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica, facturas."estadoReg" estadoReg FROM admisiones_ingresos i INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id") INNER JOIN sitios_dependencias dep ON (dep."sedesClinica_id" = i."sedesClinica_id" AND dep."serviciosSedes_id" = sd.id AND dep.id = i."dependenciasSalida_id")  INNER JOIN sitios_dependenciastipo deptip  ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" =  i."tipoDoc_id" AND u.id = i."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") INNER JOIN clinico_servicios ser  ON ( ser.id  = i."serviciosSalida_id")  INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxSalida_id") INNER JOIN facturacion_facturacion facturas ON (facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and facturas."consecAdmision" = i.consec ) LEFT JOIN contratacion_convenios conv  ON (conv.id = facturas.convenio_id )
	WHERE i."fechaSalida" between '2025-02-01 00:00:00'  and '2025-03-03 23:59:59' AND i."sedesClinica_id" = '1' AND i."fechaSalida" is not null 

delete from rips_ripsdetalle where id=49;
update rips_ripsenvios set "ripsTiposNotas_id" = 4 where id=36;

select * from rips_ripstransaccion; -- tipoNota_id
select * from rips_ripsusuarios;
select * from rips_ripsprocedimientos;  -- mipres y autporizacion
select * from rips_ripshospitaliZacion; -- autprizacion , complicacion, dx de muerte
select * from rips_RipsTiposNotas;
select * from rips_ripsmedicamentos;  -- autporiacion, mipres