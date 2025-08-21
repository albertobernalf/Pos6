SELECT documento_id,* FROM TRIAGE_TRIAGE;
select * from clinico_clasificaciontriage;
update sitios_dependencias set documento_id='1' where id = 14
select * from clinico_servicios;
select * from sitios_serviciosSedes;
select * from sitios_subserviciossedes
select "tipoDoc_id", * from usuarios_usuarios order by documento;
  
select * from admisiones_ingresos;
 
select * from sitios_dependencias where documento_id=18;;
select * from sitios_historialdependencias where documento_id=18;

SELECT sed.id id ,ser.nombre nombre
FROM sitios_serviciosSedes sed, clinico_servicios ser 
Where sed."sedesClinica_id" ='1' AND sed."servicios_id" = ser.id AND ser.nombre = 'TRIAGE'
update triage_triage set  "serviciosSedes_id" =4

delete from TRIAGE_TRIAGE where id=106;
SELECT * FROM TRIAGE_TRIAGE;

ALTER DATABASE your_database_name SET TIMEZONE = 'Europe/Berlin';
ALTER DATABASE vulner6 SET TIMEZONE = 'America/Bogota';
ALTER DATABASE vulner6 SET TIMEZONE = 'UTC';
SHOW TIMEZONE  -- ESTABA "America/Bogota"
	SELECT * FROM pg_timezone_names;
	
select * from sitios_dependencias;
select * from clinico_servicios;
select * from sitios_serviciosSedes;
select * from sitios_subserviciossedes
 
	-- OPS AQUI HAY ALGO DE FONDO VERIFICAR MAÑANA
 
	SELECT * FROM sitios_serviciossedes;
select * from sitios_dependencias where id in (10,50) order by id;
select * from sitios_historialdependencias
	select * from sitios_sedesclinica;
select * from sitios_serviciossedes;
select * from sitios_subserviciossedes

select * from facturacion_liquidacion
select * from facturacion_liquidaciondetalle;
select * from triage_triage;
select * from usuarios_usuarios;

SELECT ser.nombre, count(*) total 
FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd  
WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and i."sedesClinica_id" = dep."sedesClinica_id" AND i."sedesClinica_id" = '1' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND dep.disponibilidad = 'O' AND i."salidaDefinitiva" = 'N' and tp.id = u."tipoDoc_id" and  i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id"  
group by ser.nombre 
UNION
SELECT ser.nombre, count(*) total 
FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , 
	sitios_dependenciastipo deptip  , sitios_serviciosSedes sd, clinico_servicios ser 
	WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND
	t."sedesClinica_id" =  '1' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND 
	t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and 
	t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and 
	dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and 
	t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = 'TRIAGE' 
group by ser.nombre


select documento_id,* from admisiones_ingresos;

select * from clinico_medicos;
select * from clinico_especialidades; --dx, via de ingreso, medico no los muestra en editar admisiones, no muestra la ips
