select  u."tipoDoc_id" , tip.nombre tipnombre, u.documento documentoPaciente, u.nombre nombre, case when genero = 'M' then 'Masculino' when genero= 'F' then 'Femenino' end as genero, cast((date_part('year', now()) - date_part('year', u."fechaNacio" )) as text) edad,   reg.nombre regimen, convenio.nombre convenio , serv.nombre servicio, cast(now() as text) fecha from admisiones_ingresos adm INNER JOIN  usuarios_usuarios u ON (u."tipoDoc_id" = adm."tipoDoc_id" and u.id = adm.documento_id) INNER JOIN usuarios_tiposDocumento tip ON (tip.id = u."tipoDoc_id") INNER JOIN facturacion_conveniospacienteingresos  convIngreso ON (convIngreso."tipoDoc_id" = adm."tipoDoc_id" and convIngreso.documento_id = adm.documento_id and convIngreso."consecAdmision" = adm.consec) INNER JOIN contratacion_convenios convenio ON (convenio.id = convIngreso.convenio_id) INNER JOIN facturacion_empresas EMP on (emp.id =convenio.empresa_id ) INNER JOIN clinico_regimenes reg ON (reg.id=emp.regimen_id) INNER JOIN clinico_servicios serv ON (serv.id = adm."serviciosActual_id") WHERE  adm.documento_id= '19'  and convenio.id = 1

SELECT medicos."registroMedico", planta.nombre plantaNombre, usu."tipoDoc_id", usu.documento  
FROM clinico_historia historia
INNER JOIN planta_planta planta ON (planta.id = historia."usuarioRegistro_id") 
	INNER JOIN clinico_medicos medicos ON (medicos.planta_id = planta.id)
	INNER JOIN usuarios_usuarios usu ON (usu.id = historia."usuarioRegistro_id")       
	WHERE historia.id = '771'

select * from clinico_historia where id = 771;
select * from planta_planta;
select * from clinico_medicos;
select * from usuarios_usuarios; -- francisoc = 37