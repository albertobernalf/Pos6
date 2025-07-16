select * from clinico_historia order by id; -- 237
select * from clinico_historiaexamenes order by id;
select * from clinico_historiaRESULTADOS order by id;

select * from admisiones_ingresos;

SELECT i.id id, tp.nombre tipoDoc,  u.documento documento, u.nombre  nombre , i.consec consec , i."fechaIngreso" , 
i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual 
FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp ,
 sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd
 WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" AND
 i."sedesClinica_id" = '1'
 AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND dep.disponibilidad = 'O' AND i."salidaDefinitiva" = 'N'
 and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and
 i."fechaSalida" is null
     

-- ojo triledupolicado aquip pero en pantalla nop por que  ???
SELECT i.id id, tp.nombre tipoDoc,  u.documento documento, u.nombre  nombre , i.consec consec , i."fechaIngreso" ,
 i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual 
FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp ,
 sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd 
WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id"
 AND i."sedesClinica_id" = '1' 
AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND dep.disponibilidad = 'O' AND i."salidaDefinitiva" = 'N'
and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and
 i."fechaSalida" is null
     
select * from sitios_serviciosSedes;
select * from sitios_dependencias where "sedesClinica_id" = '1' and disponibilidad = 'O';
-- ojo esta admision no salep
-- paciente: "194656737";"nuevo7777777"
-- por que
select * from usuarios_usuarios where id =14;

SELECT 'INGRESO' tipoIng, i.id||'-INGRESO'  id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,
i.consec consec , i."fechaIngreso" , i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual 
FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp ,
 sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd 
WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" 
AND i."sedesClinica_id" = '1' AND  deptip.id = dep."dependenciasTipo_id" and 
i."serviciosActual_id" = ser.id AND dep.disponibilidad = 'O' AND i."salidaDefinitiva" = 'N' and tp.id = u."tipoDoc_id" and 
i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null 
and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id" 
UNION
 SELECT 'TRIAGE' tipoIng, t.id||'-TRIAGE'  id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,t.consec consec ,
 t."fechaSolicita" , cast('0001-01-01 00:00:00' as timestamp) fechaSalida,ser.nombre servicioNombreIng, dep.nombre camaNombreIng ,
 ' ' dxActual 
FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  ,
sitios_serviciosSedes sd, clinico_servicios ser 
WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND 
t."sedesClinica_id" = '1' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND 
t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and
 t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and 
dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and
 t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = 'TRIAGE'

 
--  Este es el query la cosa es cpomop sacar cada dato de la matriz
-- Pero yo se que si se puede:

SELECT ser.nombre, count(*)
FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp ,
 sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd 
WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" 
AND i."sedesClinica_id" = '1' AND  deptip.id = dep."dependenciasTipo_id" and 
i."serviciosActual_id" = ser.id AND dep.disponibilidad = 'O' AND i."salidaDefinitiva" = 'N' and tp.id = u."tipoDoc_id" and 
i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null 
and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id" 
group by ser.nombre
UNION
 SELECT ser.nombre, count(*) 
FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  ,
sitios_serviciosSedes sd, clinico_servicios ser 
WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND 
t."sedesClinica_id" = '1' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND 
t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and
 t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and 
dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and
 t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = 'TRIAGE'
group by ser.nombre
order by 2 desc



select * from clinico_servicios;

