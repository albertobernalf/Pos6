SELECT sub.id id ,sub.nombre nombre 
FROM sitios_serviciosSedes sed ,sitios_subserviciossedes sub , clinico_servicios serv 
Where sed."sedesClinica_id" = '1' and sed."sedesClinica_id" = sub."sedesClinica_id" and sed.id = sub."serviciosSedes_id"  
 and sed.id= '4' and sed.servicios_id=serv.id AND serv.nombre = 'TRIAGE'

select * from sitios_serviciosSedes;
select * from sitios_dependencias;
select * from usuarios_usuarios;
select * from clinico_servicios;
 
-- Query paciente ocupa
 
select dep.id, dep.numero, dep.nombre, dep."sedesClinica_id" , dep."serviciosSedes_id", dep."subServiciosSedes_id",
   dep."tipoDoc_id", dep.documento_id, dep."fechaRegistro", dep.disponibilidad,dep.consec,dep."fechaOcupacion"
from sitios_dependencias dep, sitios_serviciosSedes sd, sitios_subServiciosSedes sub
where dep."sedesClinica_id" = '1' and dep."tipoDoc_id"='1' and dep.documento_id=17 and dep.disponibilidad = 'O' and
      sub."serviciosSedes_id" = sd.id and sd.id=dep."serviciosSedes_id" and sub.id= dep."subServiciosSedes_id"



comando = 'select dep.id, dep.numero, dep.nombre, dep."sedesClinica_id" , dep."serviciosSedes_id", dep."subServiciosSedes_id",   dep."tipoDoc_id", dep.documento_id, dep."fechaRegistro", dep.disponibilidad,dep.consec,dep."fechaOcupacion" from sitios_dependencias dep, sitios_serviciosSedes sd, sitios_subServiciosSedes sub where dep."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' and dep."tipoDoc_id"=' + "'" + str(tipoDoc) + "'" + ' and dep.documento_id=' + "'" + str(documento) + "'" + ' and dep.disponibilidad = ' + "'" + str('O') + "'" + ' and sub."serviciosSedes_id" = sd.id and sd.id=dep."serviciosSedes_id" and sub.id= dep."subServiciosSedes_id"'




-- Query paciente caules puede ocupar:

if (dep."serviciosSedes_id" = Hospitalizacion)

select dep.id, dep.numero, dep.nombre,dep."sedesClinica_id", dep."serviciosSedes_id", dep."subServiciosSedes_id",dep."tipoDoc_id", dep.documento_id, 
     dep."fechaRegistro",dep."serviciosSedes_id", dep."subServiciosSedes_id",
	dep.disponibilidad,dep.consec,dep."fechaOcupacion", ser.nombre
from sitios_dependencias dep, sitios_serviciosSedes sd, clinico_servicios ser
where dep."sedesClinica_id" = '1' and dep.disponibilidad = 'L' and dep."serviciosSedes_id" = sd.id   and ser.id=sd.servicios_id and
        ser.nombre='HOSPITALIZACION'

if (dep."serviciosSedes_id" = urgencias)

select dep.id, dep.numero, dep.nombre,dep."sedesClinica_id", dep."serviciosSedes_id", dep."subServiciosSedes_id",dep."tipoDoc_id", dep.documento_id, 
     dep."fechaRegistro",dep."serviciosSedes_id", dep."subServiciosSedes_id",
	dep.disponibilidad,dep.consec,dep."fechaOcupacion", ser.nombre
from sitios_dependencias dep, sitios_serviciosSedes sd, clinico_servicios ser
where dep."sedesClinica_id" = '1' and dep.disponibilidad = 'L' and dep."serviciosSedes_id" = sd.id   and ser.id=sd.servicios_id and
        ser.nombre='URGENCIAS'

if (dep."serviciosSedes_id" = urgencias)

select dep.id, dep.numero, dep.nombre,dep."sedesClinica_id", dep."serviciosSedes_id", dep."subServiciosSedes_id",dep."tipoDoc_id", dep.documento_id, 
     dep."fechaRegistro",dep."serviciosSedes_id", dep."subServiciosSedes_id",
	dep.disponibilidad,dep.consec,dep."fechaOcupacion", ser.nombre
from sitios_dependencias dep, sitios_serviciosSedes sd, clinico_servicios ser
where dep."sedesClinica_id" = '1' and dep.disponibilidad = 'L' and dep."serviciosSedes_id" = sd.id   and ser.id=sd.servicios_id and
        ser.nombre='AMBULATORIO'

select * from sitios_dependencias;
select * from sitios_serviciosSedes;

SELECT dep.id ,dep.nombre 
FROM sitios_dependencias dep, sitios_dependenciasTipo tip , sitios_serviciosSedes sd, clinico_servicios ser
where dep."sedesClinica_id" = '1' AND tip.nombre='HABITACIONES' and dep."dependenciasTipo_id" = tip.id AND
      dep.disponibilidad = 'L' AND sd.id=dep."serviciosSedes_id" AND ser.id = sd."servicios_id" and ser.nombre in ('HOSPITALIZACION','URGENCIAS')

SELECT dep.id ,dep.nombre FROM sitios_dependencias dep, sitios_dependenciasTipo tip , sitios_serviciosSedes sd, clinico_servicios ser 
where dep."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' AND tip.nombre=' + "'" + str('HABITACIONES') + "'" + ' and dep."dependenciasTipo_id" = tip.id AND       dep.disponibilidad = 'L' AND sd.id=dep."serviciosSedes_id" AND ser.id = sd."servicios_id" and ser.nombre in (' + str('HOSPITALIZACION') + "'," + "'" + str('URGENCIAS') + "')"

select dep.id id , dep.numero numero , dep.nombre depNombre, sd.nombre servicio, sub.nombre subServicio,  
 dep."tipoDoc_id" tipoDocId, dep.documento_id documentoId, dep."fechaRegistro" fechaRegistro, dep.disponibilidad dispo,dep.consec consec ,
dep."fechaOcupacion" ocupacion from sitios_dependencias dep, sitios_serviciosSedes sd, sitios_subServiciosSedes sub
 where dep."sedesClinica_id" = '1' and dep."tipoDoc_id"='1' and dep.documento_id='19465673' and dep.consec = 6  
and dep.disponibilidad = 'O' and sub."serviciosSedes_id" = sd.id and sd.id=dep."serviciosSedes_id" and sub.id= dep."subServiciosSedes_id"