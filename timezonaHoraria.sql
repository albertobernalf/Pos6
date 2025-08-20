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
select * from sitios_dependencias;
 
    select dep.id id,sed.nombre, serv.nombre, subserv.nombre, dep.numero numero,  
	case when his.disponibilidad = 'L' then 'Libera' else 'Ocupa' end accion,
	case when his.disponibilidad ='O' then  his."fechaOcupacion" else  his."fechaLiberacion" end
	fecha, tp.nombre tipoDoc 	,	u.documento documento, 	u.nombre paciente 
	FROM sitios_dependencias dep, usuarios_usuarios u, usuarios_tiposdocumento tp,sitios_sedesclinica sed, 	
	sitios_serviciossedes serv, sitios_subserviciossedes subserv, sitios_historialdependencias his
	WHERE his.dependencias_id = dep.id AND dep."sedesClinica_id"  = '1'
	AND sed.id=dep."sedesClinica_id" AND sed.id = serv."sedesClinica_id" and
	 sed.id = subserv."sedesClinica_id" AND dep."serviciosSedes_id" = serv."sedesClinica_id" and
	 dep."subServiciosSedes_id" = subserv.id AND dep."tipoDoc_id" = u."tipoDoc_id" and dep.documento_id = u.id 
	and u."tipoDoc_id" = tp.id  
	ORDER By dep.numero, dep."fechaOcupacion"
