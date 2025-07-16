select * from facturacion_facturacion;


select * from facturacion_liquidacion;
SELECT (cast(max(p.consecutivo) as integer) + 1) cons FROM facturacion_liquidaciondetalle p WHERE liquidacion_id = 8
SELECT COALESCE(max(p.consecutivo),0) + 1 cons FROM facturacion_liquidaciondetalle p WHERE liquidacion_id = 8

select liquidacion_id,* from facturacion_liquidaciondetalle;


select liq.id id,  "consecAdmision",  fecha ,  "totalCopagos" ,  "totalCuotaModeradora" ,  "totalProcedimientos" ,"totalSuministros", 
"totalLiquidacion", "valorApagar", "fechaCorte", anticipos, "detalleAnulacion", "fechaAnulacion", observaciones, liq."fechaRegistro",
 "estadoRegistro", convenio_id, liq."tipoDoc_id" , liq.documento_id, liq."usuarioRegistro_id", "totalAbonos",
 conv.nombre nombreConvenio, usu.nombre paciente, adm.id ingresoId1, usu.documento documento, tip.nombre tipoDocumento 
FROM facturacion_liquidacion liq, contratacion_convenios conv, usuarios_usuarios usu, admisiones_ingresos adm,
 usuarios_tiposdocumento  tip where adm.id = 50084  AND  liq.convenio_id = conv.id and usu.id = liq.documento_id  and 
adm."tipoDoc_id" = liq."tipoDoc_id"   AND tip.id = adm."tipoDoc_id" AND adm.documento_id = liq.documento_id  AND 
adm.consec = liq."consecAdmision" AND conv.id = 1

SELECT id FROM facturacion_liquidacion WHERE "tipoDoc_id" = '1' AND documento_id = 18 AND "consecAdmision" = 1 and convenio_id = 1;

begin transaction;
INSERT INTO facturacion_facturacion (documento_id, "consecAdmision", "fechaFactura", "totalCopagos", "totalCuotaModeradora", 
"totalSuministros", "totalFactura", "valorApagar", anulado, anticipos, "fechaRegistro", "estadoReg", "fechaAnulacion", 
observaciones, "fechaCorte",convenio_id, "tipoDoc_id","usuarioAnula_id","usuarioRegistro_id") 
SELECT documento_id, "consecAdmision", fecha, "totalCopagos", "totalCuotaModeradora", "totalSuministros", 
"totalLiquidacion", "valorApagar", anulado, anticipos, "fechaRegistro", "estadoRegistro", "fechaAnulacion", observaciones, 
"fechaCorte",convenio_id, "tipoDoc_id","usuarioAnula_id","usuarioRegistro_id" FROM facturacion_liquidacion 
WHERE id =  8
 select * from facturacion_facturacion;
-- rollback;

delete from facturacion_facturacion where documento_id=18


select * from facturacion_liquidacion;
delete from facturacion_liquidacion where id in (11);

delete from facturacion_liquidaciondetalle;
select * from facturacion_liquidaciondetalle;

select * from admisiones_ingresos;

SELECT * FROM FACTURACION_FACTURACION;

SELECT * FROM FACTURACION_FACTURACIONdetalle;
delete  FROM FACTURACION_FACTURACION where id  in (18,19);


select * from sitios_dependencias where documento_id=18;
select * from sitios_dependenciastipo;

select * from sitios_historialdependencias;
select * from sitios_serviciosSedes;
select * from clinico_servicios;


select * from clinico_Diagnosticos order by id
select * from facturacion_liquidacion;
select * from facturacion_liquidaciondetalle;
select * from admisiones_ingresos -- serviciosalida_id, dxsalida_id// diagnosticos , , medicoSalida_id//plantaId.id  y especialidaddesmedicosalida//espMedico en HC/salidaclinica
                                   -- dependenciasSalida_id//dependenciasActual_id

SELECT i.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , 
i."fechaIngreso" fechaIngreso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida, dep.nombre camaNombreSalida , 
diag.nombre dxSalida , conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica--, estadosalida.nombre estadoSalida
 FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp ,
 sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd , contratacion_convenios conv ,
 facturacion_facturacion facturas--, clinico_estadossalida estadoSalida 
WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and 
sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" AND  i."sedesClinica_id" = '1' AND 
 deptip.id = dep."dependenciasTipo_id" and i."serviciosSalida_id" = ser.id AND i."salidaClinica" = 'S' and 
tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and  u.id = i."documento_id" and diag.id = i."dxSalida_id" and i."fechaSalida" is not null 
and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasSalida_id" 
AND facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and facturas."consecAdmision" = i.consec 
and facturas.convenio_id = conv.id   and i."fechaSalida"  -- and estadosalida.id = i."salidaMotivo_id"
 between cast ('2024-11-14 00:00:00' as timestamp)  and cast( '2024-11-14 23:59:59' as timestamp)

-- ojo que pasa con la fecha ''


update admisiones_ingresos set "salidaClinica" = 'S' , "dependenciasSalida_id" = 17,"dxSalida_id" = 11,"especialidadesMedicosSalida_id"=3, "serviciosSalida_id" = 2  where id= 50084;