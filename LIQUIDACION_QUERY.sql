select convenio_id,* from facturacion_facturacion;
update facturacion_facturacion set convenio_id=null where id = 34;

select * from contratacion_conveniosprocedimientos;
select * from contratacion_conveniossuministros;




SELECT 'INGRESO' tipoIng, i.id||'-'||conv.id id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,
i.consec consec , i."fechaIngreso" , i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual , 
conv.nombre convenio, conv.id convenioId FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , 
clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag ,
 sitios_serviciosSedes sd , facturacion_conveniospacienteingresos fac,contratacion_convenios conv 
WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" AND
 i."sedesClinica_id" = '1' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND
 dep.disponibilidad = 'O' AND i."salidaDefinitiva" = 'N' and tp.id = u."tipoDoc_id" and 
i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null and 
dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id"  AND fac.documento_id = i.documento_id and 
fac."tipoDoc_id" = i."tipoDoc_id" and fac."consecAdmision" = i.consec and fac.convenio_id = conv.id 
UNION 
SELECT ' + "'"  + str("TRIAGE") + "'" + ' tipoIng, t.id'  + "||" +"'" + "-'||conv.id" + ' id, tp.nombre tipoDoc,u.documento documento,
u.nombre nombre,t.consec consec , t."fechaSolicita" , cast(' + "'" + str('0001-01-01 00:00:00') + "'" + ' as timestamp) fechaSalida,
ser.nombre servicioNombreIng, dep.nombre camaNombreIng , ' + "''" + ' dxActual , conv.nombre convenio, conv.id convenioId  
 FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  ,
sitios_serviciosSedes sd, clinico_servicios ser , facturacion_conveniospacienteingresos fac,contratacion_convenios conv 
WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND 
t."sedesClinica_id" = ' "'" + str(sede) + "'" + ' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND
 dep.id = t.dependencias_id AND t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  
tp.id = u."tipoDoc_id" and t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and 
dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and
 t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = ' + "'" + str('TRIAGE') + "'" + ' AND
 fac.documento_id = t.documento_id and fac."tipoDoc_id" = t."tipoDoc_id" and fac."consecAdmision" = t.consec and
 fac.convenio_id = conv.id'


-- Este es el superquery

SELECT 'INGRESO' tipoIng, i.id||'-'||conv.id id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,
i.consec consec , i."fechaIngreso" , i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual , 
conv.nombre convenio, conv.id convenioId 
FROM admisiones_ingresos i
 INNER JOIN clinico_servicios ser ON (ser.id = i."serviciosActual_id" )
 INNER JOIN sitios_serviciosSedes sd ON (i."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id)
 INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  i."sedesClinica_id" and dep.id = i."dependenciasActual_id"  AND dep.disponibilidad = 'O' AND dep."serviciosSedes_id" = sd.id )
 INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id")
 INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i."documento_id" )
 INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id")
 INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxActual_id")
 LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and 
 fac."consecAdmision" = i.consec )
 LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) 
WHERE  i."sedesClinica_id" =  '1'  AND i."salidaDefinitiva" = 'N' and   i."fechaSalida" is null 
UNION
SELECT 'INGRESO' tipoIng, t.id||'-'||conv.id id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,
t.consec consec , t."fechaSolicita"  , cast('0001-01-01 00:00:00' as timestamp) fechaSalida, ser.nombre servicioNombreIng, dep.nombre camaNombreIng , ' ' dxActual , 
conv.nombre convenio, conv.id convenioId 
FROM triage_triage t
 INNER JOIN clinico_servicios ser ON ( ser.nombre = 'TRIAGE')
 INNER JOIN sitios_serviciosSedes sd ON (t."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id and sd.id = t."serviciosSedes_id" )
 INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  t."sedesClinica_id" and dep.id = t.dependencias_id  AND dep.disponibilidad = 'O' AND dep."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and
 t."consecAdmision" = 0 and dep."documento_id" = t."documento_id")
 INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id")
 INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" )
 INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id")
 -- INNER JOIN clinico_Diagnosticos diag ON (diag.id = t."dxActual_id")
 LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = t."tipoDoc_id" and fac.documento_id = t.documento_id and 
 fac."consecAdmision" = t.consec )
 LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) 
WHERE  t."sedesClinica_id" =  '1' 

-- QUERY PARA PYCHARM

detalle = 'SELECT 'INGRESO' tipoIng, i.id||'-'||conv.id id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" , i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual,conv.nombre convenio, conv.id convenioId FROM admisiones_ingresos i INNER JOIN clinico_servicios ser ON (ser.id = i."serviciosActual_id" ) INNER JOIN sitios_serviciosSedes sd ON (i."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id) INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  i."sedesClinica_id" and dep.id = i."dependenciasActual_id"  AND dep.disponibilidad = 'O' AND dep."serviciosSedes_id" = sd.id ) INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxActual_id") LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and  fac."consecAdmision" = i.consec )  LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) WHERE i."sedesClinica_id" =  ' "'" + str(sede) + "'" + ' AND i."salidaDefinitiva" = ' + "'" + str('N') + "'" + ' and i."fechaSalida" is null UNION SELECT ' + "'"  + str("TRIAGE") + "'" + ' tipoIng, t.id'  + "||" +"'" + "-'||conv.id" + ' id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre, t.consec consec , t."fechaSolicita" , cast(' + "'" + str('0001-01-01 00:00:00') + "'" + ' as timestamp) fechaSalida,ser.nombre servicioNombreIng, dep.nombre camaNombreIng , ' ' dxActual , conv.nombre convenio, conv.id convenioId FROM triage_triage t INNER JOIN clinico_servicios ser ON ( ser.nombre = ' + "'" + str('TRIAGE') + "'" + ' INNER JOIN sitios_serviciosSedes sd ON (t."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id and sd.id = t."serviciosSedes_id" ) INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  t."sedesClinica_id" and dep.id = t.dependencias_id  AND dep.disponibilidad = 'O' AND dep."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and t."consecAdmision" = 0 and dep."documento_id" = t."documento_id") INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = t."tipoDoc_id" and fac.documento_id = t.documento_id and  fac."consecAdmision" = t.consec ) LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) WHERE  t."sedesClinica_id" = ' + "'" + str(sede) + "'"



-- esta quedop
detalle = 'SELECT 'INGRESO' tipoIng, i.id||'-'||conv.id id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" , i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual,conv.nombre convenio, conv.id convenioId FROM admisiones_ingresos i INNER JOIN clinico_servicios ser ON (ser.id = i."serviciosActual_id" ) INNER JOIN sitios_serviciosSedes sd ON (i."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id) INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  i."sedesClinica_id" and dep.id = i."dependenciasActual_id"  AND dep.disponibilidad = ' + "'" + str('O') + "'" + ' AND dep."serviciosSedes_id" = sd.id ) INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxActual_id") LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and  fac."consecAdmision" = i.consec )  LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) WHERE i."sedesClinica_id" =  ' "'" + str(sede) + "'" + ' AND i."salidaDefinitiva" = ' + "'" + str('N') + "'" + ' and i."fechaSalida" is null UNION SELECT ' + "'"  + str("TRIAGE") + "'" + ' tipoIng, t.id'  + "||" +"'" + "-'||conv.id" + ' id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre, t.consec consec , t."fechaSolicita" , cast(' + "'" + str('0001-01-01 00:00:00') + "'" + ' as timestamp) fechaSalida,ser.nombre servicioNombreIng, dep.nombre camaNombreIng , ' + "' '" + ' dxActual , conv.nombre convenio, conv.id convenioId FROM triage_triage t INNER JOIN clinico_servicios ser ON ( ser.nombre = ' + "'" + str('TRIAGE') + "'" + ' INNER JOIN sitios_serviciosSedes sd ON (t."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id and sd.id = t."serviciosSedes_id" ) INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  t."sedesClinica_id" and dep.id = t.dependencias_id  AND dep.disponibilidad = ' + "'" + str('O') + "'" + ' AND dep."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and t."consecAdmision" = 0 and dep."documento_id" = t."documento_id") INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = t."tipoDoc_id" and fac.documento_id = t.documento_id and  fac."consecAdmision" = t.consec ) LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) WHERE  t."sedesClinica_id" = ' + "'" + str(sede) + "'"


SELECT (max(p.consecutivo) + 1) cons FROM facturacion_liquidaciondetalle p WHERE liquidacion_id = 20


select * from facturacion_liquidacion order by id -- 20
select * from usuarios_usuarios -- nuevo6

select * from facturacion_liquidaciondetalle;
select * from facturacion_suministros where id=634
select * from facturacion_liquidaciondetalle order by id

 select * from triage_triage;

SELECT 'INGRESO' tipoIng, i.id||'-'||case when conv.id != 0 then conv.id else '00' end  id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,
i.consec consec , i."fechaIngreso" , i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual,
conv.nombre convenio, conv.id convenioId
 FROM admisiones_ingresos i 
INNER JOIN clinico_servicios ser ON (ser.id = i."serviciosActual_id" ) 
INNER JOIN sitios_serviciosSedes sd ON (i."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id) 
INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  i."sedesClinica_id" and dep.id = i."dependenciasActual_id"  AND
 dep.disponibilidad = 'O' AND dep."serviciosSedes_id" = sd.id ) 
INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") 
INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i."documento_id" ) 
INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id")
INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxActual_id") 
LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and
  fac."consecAdmision" = i.consec )  
LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id)
WHERE i."sedesClinica_id" =  '1' AND i."salidaDefinitiva" = 'N' and i."fechaSalida" is null 
UNION 
SELECT 'TRIAGE' tipoIng, t.id||'-'||case when conv.id != 0 then conv.id else '00' end id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre, t.consec consec ,
 t."fechaSolicita" , cast('0001-01-01 00:00:00' as timestamp) fechaSalida,ser.nombre servicioNombreIng, dep.nombre camaNombreIng ,
 ' ' dxActual , conv.nombre convenio, conv.id convenioId 
FROM triage_triage t 
INNER JOIN clinico_servicios ser ON ( ser.nombre = 'TRIAGE')
INNER JOIN sitios_serviciosSedes sd ON (t."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id and sd.id = t."serviciosSedes_id" ) 
INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  t."sedesClinica_id" and dep.id = t.dependencias_id  AND dep.disponibilidad = 'O' AND dep."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and t."consecAdmision" = 0 and dep."documento_id" = t."documento_id") 
INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") 


select * from facturacion_liquidaciondetalle;
update facturacion_liquidaciondetalle set "codigoCups_id" = null, cums_id=634
INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" ) 
INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") 
LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = t."tipoDoc_id" and fac.documento_id = t.documento_id and  fac."consecAdmision" = t.consec ) 
LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) 
WHERE  t."sedesClinica_id" = '1'
    

select liq.id id,  tri."consecAdmision",  fecha ,  "totalCopagos" ,  "totalCuotaModeradora" ,  "totalProcedimientos" ,"totalSuministros", "totalLiquidacion", "valorApagar", "fechaCorte", anticipos, "detalleAnulacion", "fechaAnulacion", tri.observaciones, liq."fechaRegistro", "estadoRegistro", convenio_id, liq."tipoDoc_id" , liq.documento_id, liq."usuarioRegistro_id", "totalAbonos", conv.nombre nombreConvenio, usu.nombre paciente, tri.id ingresoId1, usu.documento documento, tip.nombre tipoDocumento FROM facturacion_liquidacion liq, contratacion_convenios conv, usuarios_usuarios usu, triage_triage tri, usuarios_tiposdocumento  tip where tri.id = '33'  AND  liq.convenio_id = conv.id and usu.id = liq.documento_id  and tri."tipoDoc_id" = liq."tipoDoc_id"   AND tip.id = tri."tipoDoc_id" AND tri.documento_id = liq.documento_id  AND tri.consec = liq."consecAdmision" AND conv.id = null

select * from facturacion_liquidacion order by id;
select * from facturacion_liquidaciondetalle order by id;

select liq.id id,  tri."consecAdmision",  fecha ,  "totalCopagos" ,  "totalCuotaModeradora" ,  "totalProcedimientos" ,
"totalSuministros", "totalLiquidacion", "valorApagar", "fechaCorte", anticipos, "detalleAnulacion", "fechaAnulacion",
 tri.observaciones, liq."fechaRegistro", "estadoRegistro", convenio_id, liq."tipoDoc_id" , liq.documento_id,
 liq."usuarioRegistro_id", "totalAbonos", conv.nombre nombreConvenio, usu.nombre paciente, tri.id ingresoId1, usu.documento documento,
 tip.nombre tipoDocumento
 FROM facturacion_liquidacion liq
inner join  triage_triage tri on (tri."tipoDoc_id" = liq."tipoDoc_id"  and tri.documento_id = liq.documento_id  AND tri.consec = liq."consecAdmision" )
left join  contratacion_convenios conv on (conv.id = liq.convenio_id)
inner join  usuarios_usuarios usu on (usu."tipoDoc_id" = liq."tipoDoc_id" AND usu.id = liq.documento_id)
inner join usuarios_tiposdocumento  tip on (tip.id = usu."tipoDoc_id")
where tri.id = '33'  

select * from usuarios_usuarios;
select * from admisiones_ingresos WHERE documento_id=13;
select *  from facturacion_liquidacion where id >= 35;
select *  from facturacion_liquidaciondetalle
select *  from facturacion_liquidacion where id=73;

UPDATE facturacion_liquidaciondetalle set "valorUnitario"=10000, "valorTotal" = cantidad*"valorUnitario" where id = 98
UPDATE facturacion_liquidaciondetalle set "valorUnitario"=20000, "valorTotal" = cantidad*"valorUnitario" where id = 99


UPDATE facturacion_liquidaciondetalle set  "valorTotal" = cantidad*"valorUnitario" where id = 98
UPDATE facturacion_liquidaciondetalle set "valorTotal" = cantidad*"valorUnitario" where id = 99
select * from cartera_pagos;
SELECT * FROM CARTERA_TIPOSPAGOS;
SELECT * FROM CARTERA_FORMASPAGOS;

select * from admisiones_ingresos; -- ripsDestinoUsuarioEgresoRecienNacido
select * from usuarios_usuarios;
