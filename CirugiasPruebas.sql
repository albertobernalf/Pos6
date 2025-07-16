select * from admisiones_ingresos;
SELECT * FROM cirugia_programacioncirugias;
select * FROM USUARIOS_USUARIOS;
select * FROM CIRUGIA_ESTADOScIRUGIAS;
select * FROM CIRUGIA_ESTADOSPROGRAMACION;
select * From sitios_salas;
select * from cirugia_cirugias;
select * from cirugia_tiposanestesia;
select * from cirugia_tiposcirugia;
select * from clinico_diagnosticos;

select * from clinico_historia;

SELECT prog.id,  u."tipoDoc_id", u.documento, u.nombre paciente,estprog.nombre estado,sala.numero, sala.nombre sala,
	 prog."fechaProgramacionInicia" inicia, prog."horaProgramacionInicia" horaInicia, prog."fechaProgramacionFin" Termina, prog."horaProgramacionFin" horaTermina,
	 prog.cups1_id, exa1.nombre, prog.cups2_id,exa2.nombre, prog.cups3_id, exa3.nombre
FROM cirugia_programacioncirugias prog
INNER JOIN sitios_sedesclinica sed	on (sed.id = prog."sedesClinica_id")
INNER JOIN admisiones_ingresos i ON (i."tipoDoc_id" =prog."tipoDoc_id" AND i.documento_id =  prog.documento_id AND i.consec= prog."consecAdmision" )
INNER JOIN usuarios_usuarios u ON (u.id = i.documento_id )
INNER JOIN cirugia_estadosprogramacion estprog ON (estprog.id = prog."estadoProgramacion_id" )
INNER JOIN sitios_salas sala ON (sala.id =prog.sala_id )
LEFT JOIN CLINICO_EXAMENES exa1 ON (exa1.id= prog.cups1_id)
LEFT JOIN CLINICO_EXAMENES exa2 ON (exa2.id= prog.cups2_id)
LEFT JOIN CLINICO_EXAMENES exa3 ON (exa3.id= prog.cups3_id)
WHERE sed.id = '2' 
order by sala.numero, inicia
 
	select * from cirugia_estadossalas;
select * from sitios_salas;

SELECT prog.id id,  u."tipoDoc_id" tipoDoc_id , u.documento documento, i.consec consecutivo, u.nombre paciente,estprog.nombre estadoProg,sala.numero,
	sala.nombre sala, prog."fechaProgramacionInicia" inicia, prog."horaProgramacionInicia" horaInicia, prog."fechaProgramacionFin" Termina,
	prog."horaProgramacionFin" horaTermina 
	FROM cirugia_programacioncirugias prog 
	INNER JOIN sitios_sedesclinica sed	on (sed.id = prog."sedesClinica_id")
	INNER JOIN admisiones_ingresos i ON (i."tipoDoc_id" =prog."tipoDoc_id" AND i.documento_id =  prog.documento_id AND i.consec= prog."consecAdmision" ) 
	INNER JOIN usuarios_usuarios u ON (u.id = i.documento_id )
	INNER JOIN cirugia_estadosprogramacion estprog ON (estprog.id = prog."estadoProgramacion_id" )
	LEFT JOIN sitios_salas sala ON (sala.id =prog.sala_id ) 
	WHERE sed.id = '1' order by sala.numero, inicia

	select * from cirugia_programacioncirugias;


comando = 'SELECT prog.id,  u."tipoDoc_id", u.documento, u.nombre paciente,estprog.nombre estado,sala.numero, sala.nombre sala, prog."fechaProgramacionInicia" inicia, prog."horaProgramacionInicia" horaInicia, prog."fechaProgramacionFin" Termina, prog."horaProgramacionFin" horaTermina,prog.cups1_id, exa1.nombre, prog.cups2_id,exa2.nombre, prog.cups3_id, exa3.nombre FROM cirugia_programacioncirugias prog INNER JOIN sitios_sedesclinica sed	on (sed.id = prog."sedesClinica_id") INNER JOIN admisiones_ingresos i ON (i."tipoDoc_id" =prog."tipoDoc_id" AND i.documento_id =  prog.documento_id AND i.consec= prog."consecAdmision" ) INNER JOIN usuarios_usuarios u ON (u.id = i.documento_id ) INNER JOIN cirugia_estadosprogramacion estprog ON (estprog.id = prog."estadoProgramacion_id" ) INNER JOIN sitios_salas sala ON (sala.id =prog.sala_id ) LEFT JOIN CLINICO_EXAMENES exa1 ON (exa1.id= prog.cups1_id) LEFT JOIN CLINICO_EXAMENES exa2 ON (exa2.id= prog.cups2_id)  LEFT JOIN CLINICO_EXAMENES exa3 ON (exa3.id= prog.cups3_id) WHERE sed.id = ' + "'" + str(sede) + "'"

SELECT sal.id id, sal.numero numero, sal.nombre nombre, ubi.nombre ubicacion, serv.nombre servicio, est.nombre estado
FROM sitios_salas sal, sitios_ubicaciones ubi, cirugia_estadossalas est, sitios_serviciosadministrativos serv
WHERE sal."sedesClinica_id" = 1 AND sal."serviciosAdministrativos_id" = serv.id AND ubi.id = sal.ubicaciones_id AND sal."estadoSala_id" = est.id

detalle = 'SELECT sal.id id, sal.numero numero, sal.nombre nombre, ubi.nombre ubicacion, serv.nombre servicio, est.nombre estado FROM sitios_salas sal, sitios_ubicaciones ubi, cirugia_estadossalas est, sitios_serviciosadministrativos serv WHERE sal."sedesClinica_id" = ' + "'" + str(sede) + "'" +' AND sal."serviciosAdministrativos_id" = serv.id AND ubi.id = sal.ubicaciones_id AND sal."estadoSala_id" = est.id ORDER BY sal.numero'

-- Query de solicitud cirugia
select * from admisiones_ingresos;
select * from cirugia_cirugias;
select * from sitios_dependencias;
select * from usuarios_usuarios;
select * FROM CIRUGIA_ESTADOScIRUGIAS;
select * FROM CIRUGIA_ESTADOSPROGRAMACION;
select * from cirugia_tiposanestesia;
select * from clinico_especialidadesmedicos;

SELECT i."sedesClinica_id",cir.id cirugia, u."tipoDoc_id" tipoDoc, u.documento documento, u.nombre paciente , u."fechaNacio" nacimiento,u.genero genero, (now() - u."fechaNacio" ) edad, 
	i.id ingreso, cir."fechaSolicita" solicita, dep.nombre cama,	emp.nombre empresa	, u.telefono,
	cir."solicitaSangre", cir."describeSangre", "cantidadSangre","solicitaCamaUci",cir."solicitaMicroscopio","solicitaRx","solicitaAutoSutura","solicitaOsteosintesis",
	"solicitaBiopsia", cir"solicitaMalla", cir"solicitaOtros", estprog.nombre,tiposAnes.nombre anestesia
FROM admisiones_ingresos i
INNER JOIN  usuarios_usuarios u ON ( u."tipoDoc_id" = i."tipoDoc_id" and  u.id = i.documento_id )
INNER JOIN  cirugia_cirugias cir ON (cir."sedesClinica_id" = i."sedesClinica_id" and cir."tipoDoc_id"=i."tipoDoc_id" AND cir.documento_id = i.documento_id AND cir."consecAdmision"= i.consec)
INNER JOIN sitios_dependencias dep ON (dep.id =  i."dependenciasActual_id")
LEFT JOIN  facturacion_empresas emp ON (emp.id = i.empresa_id )
LEFT JOIN  sitios_serviciosadministrativos serv ON (serv.id = cir."serviciosAdministrativos_id" )
LEFT JOIN  cirugia_estadosprogramacion estprog ON (estprog.id = cir."estadoProgramacion_id" )
LEFT JOIN  cirugia_tiposanestesia tiposAnes ON (tiposAnes.id = cir.anestesia_id )
LEFT JOIN  cirugia_tiposcirugia tiposCiru ON (tiposCiru.id = cir."tiposCirugia_id")
WHERE i."sedesClinica_id" = 1


detalle = 'SELECT i."sedesClinica_id",cir.id cirugia, u."tipoDoc_id" tipoDoc, u.documento documento, u.nombre paciente , u."fechaNacio" nacimiento,u.genero genero, (now() - u."fechaNacio" ) edad, i.id ingreso, cir."fechaSolicita" solicita, dep.nombre cama,	emp.nombre empresa	, u.telefono,cir."solicitaSangre", cir."describeSangre", "cantidadSangre","solicitaCamaUci",cir."solicitaMicroscopio","solicitaRx","solicitaAutoSutura","solicitaOsteosintesis",	"solicitaBiopsia", cir"solicitaMalla", cir"solicitaOtros", estprog.nombre,tiposAnes.nombre anestesia FROM admisiones_ingresos i INNER JOIN  usuarios_usuarios u ON ( u."tipoDoc_id" = i."tipoDoc_id" and  u.id = i.documento_id ) INNER JOIN  cirugia_cirugias cir ON (cir."sedesClinica_id" = i."sedesClinica_id" and cir."tipoDoc_id"=i."tipoDoc_id" AND cir.documento_id = i.documento_id AND cir."consecAdmision"= i.consec) INNER JOIN sitios_dependencias dep ON (dep.id =  i."dependenciasActual_id") LEFT JOIN  facturacion_empresas emp ON (emp.id = i.empresa_id ) LEFT JOIN  sitios_serviciosadministrativos serv ON (serv.id = cir."serviciosAdministrativos_id" ) LEFT JOIN  cirugia_estadosprogramacion estprog ON (estprog.id = cir."estadoProgramacion_id" ) LEFT JOIN  cirugia_tiposanestesia tiposAnes ON (tiposAnes.id = cir.anestesia_id ) LEFT JOIN  cirugia_tiposcirugia tiposCiru ON (tiposCiru.id = cir."tiposCirugia_id") WHERE i."sedesClinica_id" = ' + "'" + str(sede) + "'"

detalle = 'SELECT i."tipoDoc_id" tipoDoc_id, u.documento documento,u.nombre paciente, i.consec consecutivo, u.genero, (now() - u."fechaNacio")/360 edad, u."fechaNacio", dep.nombre, u.telefono telefono, emp.nombre FROM admisiones_ingresos i INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" =  i."tipoDoc_id" AND u.id =  i.documento_id) LEFT JOIN sitios_dependencias dep ON (dep.id = i."dependenciasActual_id") LEFT JOIN facturacion_empresas emp	 ON (emp.id = i.empresa_id ) where i."sedesClinica_id" = 1 ORDER BY i."dependenciasActual_id"'

	SELECT i.id id,  i."tipoDoc_id"||' '|| u.documento||' '||u.nombre||' '||i.consec||' '||u.genero||' '||((now() - u."fechaNacio")/360)||' '||u."fechaNacio"||' '||dep.nombre||' '||cast(u.telefono as text)||' ' ||emp.nombre PACIENTE
	FROM admisiones_ingresos i INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" =  i."tipoDoc_id" AND u.id =  i.documento_id) LEFT JOIN sitios_dependencias dep ON (dep.id = i."dependenciasActual_id") LEFT JOIN facturacion_empresas emp	 ON (emp.id = i.empresa_id ) where i."sedesClinica_id" = 1 ORDER BY i."dependenciasActual_id"

INSERT INTO cirugia_cirugia ("consecAdmision", "fechaSolicita", "solicitaHospitalizacion", "solicitaAyudante", "solicitaTiempoQx", "solicitatipoQx", "solicitaAnestesia", "solicitaSangre", "describeSangre", "cantidadSangre", 
"solicitaCamaUci", "solicitaMicroscopio", "solicitaRx", "solicitaAutoSutura", "solicitaOsteosintesis", "solicitaSoporte", "solicitaBiopsia", "solicitaMalla", "solicitaOtros", "describeOtros", "tiempoMaxQx", "fechaRegistro", "estadoReg", anestesia_id, documento_id,  "dxPreQx_id", "dxPrinc_id", "dxRel1_id", "dxRel2_id", "dxRel3_id", especialidad_id, "sedesClinica_id", "tipoDoc_id", "usuarioRegistro_id",
 "usuarioSolicita_id", "serviciosAdministrativos_id", "estadoProgramacion_id", "tiposCirugia_id") VALUES

select * from clinico_especialidadesmedicos;
select * from cirugia_cirugiasprocedimientos;
select * from cirugia_cirugiasparticipantes;
select * from cirugia_finalidadcirugia;
select * from tarifarios_tiposhonorarios;
clinico_especialidades
	select * from clinico_especialidades;

select * from clinico_especialidadesmedicos;

SELECT * FROM cirugia_cirugias;
select * from cirugia_finalidadcirugia;
select * from clinico_examenes;


select cirproc.id id, cirproc.cirugia_id cirugiaId, cirproc.cups_id, exa.nombre, final.nombre
FROM cirugia_cirugiasprocedimientos cirproc, clinico_examenes exa, cirugia_finalidadcirugia final
WHERE cirproc.cirugia_id = 1 and cirproc.cups_id = exa.id and final.id = cirproc.finalidad_id

SELECT p.id id, p.nombre  nombre FROM  clinico_examenes  p ORDER BY nombre


select * from cirugia_cirugiasparticipantes;

	
select cirpart.id id, cirpart.cirugia_id cirugiaId, hon.nombre, med.nombre, esp.nombre FROM cirugia_cirugiasparticipantes cirpart, tarifarios_tiposhonorarios hon, clinico_especialidadesmedicos med, clinico_especialidades esp
WHERE cirpart.cirugia_id = 1 and cirpart."tipoHonorarios_id" = hon.id  and cirpart.medico_id = med.id and med.especialidades_id = esp.id

comando = 'select cirpart.id id, cirpart.cirugia_id cirugiaId, hon.nombre, med.nombre, esp.nombre FROM cirugia_cirugiasparticipantes cirpart, tarifarios_tiposhonorarios hon, clinico_especialidadesmedicos med, clinico_especialidades esp WHERE cirpart.cirugia_id = ' + "'" + str(cirugiaId) + "'" + ' and cirpart."tipoHonorarios_id" = hon.id  and cirpart.medico_id = med.id and med.especialidades_id = esp.id'

SELECT * FROM cirugia_cirugiasprocedimientos;

select cirproc.id id, cirproc.cirugia_id cirugiaId, cirproc.cups_id cups_id, exa.nombre exaNombre, final.nombre finalNombre 
FROM cirugia_cirugiasprocedimientos cirproc
INNER JOIN clinico_examenes exa ON ( exa.id = cirproc.cups_id)
LEFT JOIN	cirugia_finalidadcirugia final ON (final.id = cirproc.finalidad_id)
WHERE cirproc.cirugia_id = '10' 
select * FROM CIRUGIA_ESTADOScIRUGIAS;
select * FROM CIRUGIA_ESTADOSPROGRAMACION;
update cirugia_cirugias set "estadoCirugia_id"=1;
select "estadoProgramacion_id","estadoCirugia_id",* from cirugia_cirugias;
select "estadoProgramacion_id",* from cirugia_programacioncirugias;

select * from cirugia_cirugias;
select * from sitios_salas;
select * from sitios_serviciosAdministrativos;

select * from facturacion_tipossuministro;
select * from facturacion_suministros;
select * from cirugia_CirugiasMaterialQx;
select * from tarifarios_tiposhonorarios;
select * from cirugia_cirugiasparticipantes;

select cirpart.id id, cirpart.cirugia_id cirugiaId, hon.nombre honNombre, med.nombre medicoNombre, esp.nombre especialidadNombre
	FROM cirugia_cirugiasparticipantes cirpart, tarifarios_tiposhonorarios hon, clinico_especialidadesmedicos med, clinico_especialidades esp 
	WHERE cirpart.cirugia_id = '10' and cirpart."tipoHonorarios_id" = hon.id  and cirpart.medico_id = med.id and med.especialidades_id = esp.id

select * from sitios_salas;
select * from cirugia_programacioncirugias;


detalle ='SELECT prog.id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,prog."horaProgramacionInicia", prog."horaProgramacionFin" FROM cirugia_programacioncirugias prog LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id ) WHERE salas."sedesClinica_id" = ' + "'" + str(sede) + "'"

comando = 'SELECT id FROM cirugia_programacioncirugias cir where sala_id =  ' + "'" + str(sala) + "'" + '' AND ' "'" + str(fechaPrgramacionInicia) + "'" + ' BETWEEN  "fechaProgramacionInicia" AND  "fechaProgramacionFin" AND ' + "'" + str(horaProgramacionInicia") + "'" + ' BETWEEN  "horaProgramacionInicia" and "horaProgramacionFin"'

SELECT count(*)d FROM cirugia_programacioncirugias cir where sala_id =  '1' AND '2025-05-08' BETWEEN "fechaProgramacionInicia" AND "fechaProgramacionFin" AND '07:05' 
	BETWEEN  "horaProgramacionInicia" and "horaProgramacionFin" 

select * from sitios_dependencias;
select * from sitios_sedesclinica;
select * from sitios_serviciossedes;

select * from clinico_servicios;
select * from sitios_salas;

select * from cirugia_cirugiamateriaesqx;

SELECT count(*) id 
FROM cirugia_programacioncirugias cir 
	where sala_id =  '2' AND '2025-05-09' BETWEEN "fechaProgramacionInicia" AND "fechaProgramacionFin"
	AND '07:10' BETWEEN  "horaProgramacionInicia" and "horaProgramacionFin" --  AND cir.id != '4'