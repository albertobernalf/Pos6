select * from usuarios_tiposdocumento;
select * from clinico_regimenes;
select * from admisiones_ingresos;
SELECT usu."primerNombre"  primerNombre, usu."segundoNombre"  segundoNombre, usu."primerApellido"  primerApellido,
	usu."segundoApellido" segundoApellido , usu."tipoDoc_id" tipoDoc ,usu.documento documento , 
	usu."fechaNacio" fechaNacimiento, usu.direccion direccion, usu.telefono telefono,  dep.nombre departamentoPaciente, 
	mun.nombre municipioPaciente, regimen.nombre regimen
	FROM admisiones_ingresos ing
	INNER JOIN usuarios_usuarios usu ON (usu."tipoDoc_id"=ing."tipoDoc_id" AND usu.id=ing.documento_id)
	INNER JOIN sitios_departamentos dep ON (dep.id=usu.departamentos_id)
	INNER JOIN sitios_municipios mun ON (mun.id = usu.municipio_id)
	INNER JOIN clinico_servicios servicios on ( servicios.id=ing."serviciosActual_id")
	LEFT JOIN clinico_regimenes regimen ON (regimen.id = ing.regimen_id)
	WHERE ing.id = '50177' AND servicios.NOMBRE LIKE ('%URGENC%') group by usu."primerNombre", usu."segundoNombre", usu."primerApellido", usu."segundoApellido", usu."tipoDoc_id",usu.documento, usu."fechaNacio" , usu.direccion , usu.telefono , dep.nombre , mun.nombre, regimen.nombre

select * from usuarios_usuarios;
select * from sitios_dependencias;
select * from clinico_regimenes;
select * from facturacion_regimenestipopago;
select * from facturacion_conveniospacienteingresos;
select * from facturacion_empresas;

SELECT date(ing."fechaIngreso") fechaIngreso, cast (ing."fechaIngreso" as time) horaIngreso, dep.numero cama, serv.nombre servIngreso,
	  ext.nombre causaExterna,ing."numManilla" manilla, usu.nombre nombrePaciente, tipDoc.nombre tipDoc, usu.documento documento,
	   ocupa.nombre ocupacion, estCivil.nombre estadoCivil, regimen.nombre regimen, mun.nombre municipio,
	   local.nombre localidad,usu.direccion direccion ,usu.telefono telefono,
	   usu.correo correo, diag.nombre diagnostico
FROM admisiones_ingresos ing
INNER JOIN sitios_dependencias dep ON (dep."tipoDoc_id" = ing."tipoDoc_id" AND dep.documento_id = ing.documento_id AND ing.consec=dep.consec)
INNER JOIN clinico_servicios serv ON (serv.id = ing."serviciosIng_id")
LEFT JOIN clinico_causasexterna ext ON (ext.id = ing."causasExterna_id")
INNER JOIN usuarios_usuarios usu ON (usu.id=ing.documento_id)
LEFT JOIN usuarios_tiposdocumento tipDoc ON (tipDoc.id = ing."tipoDoc_id")
LEFT JOIN basicas_ocupaciones ocupa ON (ocupa.id = usu.ocupacion_id)
LEFT JOIN basicas_estadocivil estCivil ON (estCivil.id = usu."estadoCivil_id")
LEFT JOIN clinico_regimenes regimen ON (regimen.id = ing.regimen_id)	
LEFT JOIN sitios_municipios mun ON (mun.id=usu.municipio_id)	
LEFT JOIN sitios_localidades local ON (local.id=usu.localidad_id)	
LEFT JOIN clinico_diagnosticos diag ON (diag.id=ing."dxIngreso_id")
WHERE ing.id = 50177

comando ='SELECT date(ing."fechaIngreso") fechaIngreso, cast (ing."fechaIngreso" as time) horaIngreso, dep.numero cama, serv.nombre servIngreso, ext.nombre causaExterna,ing."numManilla" manilla, usu.nombre nombrePaciente, tipDoc.nombre tipDoc, usu.documento documento, ocupa.nombre ocupacion, estCivil.nombre estadoCivil, regimen.nombre regimen, mun.nombre municipio,  local.nombre localidad,usu.direccion direccion ,usu.telefono telefono, usu.correo correo, diag.nombre disgnostico FROM admisiones_ingresos ing INNER JOIN sitios_dependencias dep ON (dep."tipoDoc_id" = ing."tipoDoc_id" AND dep.documento_id = ing.documento_id AND ing.consec=dep.consec) INNER JOIN clinico_servicios serv ON (serv.id = ing."serviciosIng_id") LEFT JOIN clinico_causasexterna ext ON (ext.id = ing."causasExterna_id") INNER JOIN usuarios_usuarios usu ON (usu.id=ing.documento_id) LEFT JOIN usuarios_tiposdocumento tipDoc ON (tipDoc.id = ing."tipoDoc_id") LEFT JOIN basicas_ocupaciones ocupa ON (ocupa.id = usu.ocupacion_id) LEFT JOIN basicas_estadocivil estCivil ON (estCivil.id = usu."estadoCivil_id") LEFT JOIN clinico_regimenes regimen ON (regimen.id = ing.regimen_id)	LEFT JOIN sitios_municipios mun ON (mun.id=usu.municipio_id)	LEFT JOIN sitios_localidades local ON (local.id=usu.localidad_id) LEFT JOIN clinico_diagnosticos diag ON (diag.id=ing."dxIngreso_id") WHERE ing.id = ' + "'" + str(ingresoId) + "'" 

	SELECT * FROM facturacion_conveniospacienteingresos
	SELECT * FROM contratacion_convenios
	
-- Entidades repsonsable
comando = 'SELECT conv.nombre convenio FROM admisiones_ingresos ing LEFT JOIN facturacion_conveniospacienteingresos convPac ON (convPac."tipoDoc_id" = ing."tipoDoc_id" AND convPac.documento_id = ing.documento_id AND convPac."consecAdmision" = ing.consec) LEFT JOIN contratacion_convenios conv ON (conv.id = convPac.convenio_id) WHERE ing.id= ' + "'" + str(ingresoId) + "'"

-- Responsable Paciente
--"contactoResponsable_id"
	
	select * from basicas_tiposcontacto
	select * from admisiones_ingresos;
select * from usuarios_usuarioscontacto

comado = 'SELECT usuContacto.nombre, usuContacto.direccion,usuContacto.telefono,tiposFamilia.nombre FROM admisiones_ingresos ing LEFT JOIN usuarios_usuarioscontacto usuContacto ON (usuContacto.id = ing."contactoResponsable_id") LEFT JOIN basicas_tiposfamilia tiposFamilia ON (tiposFamilia.id = usuContacto."tiposFamilia_id") WHERE ing.id= ' + "'" + str(ingresoId) + "'" 


SELECT date(ing."fechaIngreso") fechaIngreso, cast (ing."fechaIngreso" as time) horaIngreso, dep.numero cama, serv.nombre servIngreso, ext.nombre causaExterna,ing."numManilla" manilla, usu.nombre nombrePaciente, tipDoc.nombre tipDoc, usu.documento documento, ocupa.nombre ocupacion, estCivil.nombre estadoCivil, regimen.nombre regimen, mun.nombre municipio,  local.nombre localidad,usu.direccion direccion ,usu.telefono telefono, usu.correo correo, diag.nombre diagnostico , usu."fechaNacio" nacio, (now() - usu."fechaNacio") edad, usu.genero sexo  FROM admisiones_ingresos ing INNER JOIN sitios_dependencias dep ON (dep."tipoDoc_id" = ing."tipoDoc_id" AND dep.documento_id = ing.documento_id AND ing.consec=dep.consec) INNER JOIN clinico_servicios serv ON (serv.id = ing."serviciosIng_id") LEFT JOIN clinico_causasexterna ext ON (ext.id = ing."causasExterna_id") INNER JOIN usuarios_usuarios usu ON (usu.id=ing.documento_id) LEFT JOIN usuarios_tiposdocumento tipDoc ON (tipDoc.id = ing."tipoDoc_id") LEFT JOIN basicas_ocupaciones ocupa ON (ocupa.id = usu.ocupacion_id) LEFT JOIN basicas_estadocivil estCivil ON (estCivil.id = usu."estadoCivil_id") LEFT JOIN clinico_regimenes regimen ON (regimen.id = ing.regimen_id)       LEFT JOIN sitios_municipios mun ON (mun.id=usu.municipio_id)    LEFT JOIN sitios_localidades local ON (local.id=usu.localidad_id) LEFT JOIN clinico_diagnosticos diag ON (diag.id=ing."dxIngreso_id") WHERE ing.id = '50177'	


SELECT to_char(ing."fechaIngreso",'YYYY-MM-DD') fechaIngreso, to_char (ing."fechaIngreso" , 'HH:MM:SS')  horaIngreso, dep.numero cama, serv.nombre servIngreso, ext.nombre causaExterna,ing."numManilla" manilla, usu.nombre nombrePaciente, tipDoc.nombre tipDoc, usu.documento documento, ocupa.nombre ocupacion, estCivil.nombre estadoCivil, regimen.nombre regimen, mun.nombre municipio,  local.nombre localidad,usu.direccion direccion ,usu.telefono telefono, usu.correo correo, diag.nombre diagnostico , to_char(usu."fechaNacio", 'YYYY-MM-DD') nacio, 
	(to_char(now(),'YYYY-MM-DD')  - to_char(usu."fechaNacio", 'YYYY-MM-DD'))  edad, usu.genero sexo 
	FROM admisiones_ingresos ing 
	INNER JOIN sitios_dependencias dep ON (dep."tipoDoc_id" = ing."tipoDoc_id" AND dep.documento_id = ing.documento_id AND ing.consec=dep.consec) 
	INNER JOIN clinico_servicios serv ON (serv.id = ing."serviciosIng_id") 
	LEFT JOIN clinico_causasexterna ext ON (ext.id = ing."causasExterna_id") 
	INNER JOIN usuarios_usuarios usu ON (usu.id=ing.documento_id)
	LEFT JOIN usuarios_tiposdocumento tipDoc ON (tipDoc.id = ing."tipoDoc_id") 
	LEFT JOIN basicas_ocupaciones ocupa ON (ocupa.id = usu.ocupacion_id) 
	LEFT JOIN basicas_estadocivil estCivil ON (estCivil.id = usu."estadoCivil_id")
	LEFT JOIN clinico_regimenes regimen ON (regimen.id = ing.regimen_id)       
	LEFT JOIN sitios_municipios mun ON (mun.id=usu.municipio_id)   
	LEFT JOIN sitios_localidades local ON (local.id=usu.localidad_id) 
	LEFT JOIN clinico_diagnosticos diag ON (diag.id=ing."dxIngreso_id")
	WHERE ing.id = '50177'


select usu."fechaNacio", (cast(now()  as date) - cast(usu."fechaNacio" as date))/365 edd
from usuarios_usuarios usu


SELECT to_char(ing."fechaIngreso",'YYYY-MM-DD') fechaIngreso, to_char (ing."fechaIngreso" , 'HH:MM:SS')  horaIngreso, dep.numero cama, serv.nombre servIngreso,
	ext.nombre causaExterna,ing."numManilla" manilla, usu.nombre nombrePaciente, tipDoc.nombre tipDoc, usu.documento documento,
	ocupa.nombre ocupacion, estCivil.nombre estadoCivil, regimen.nombre regimen, mun.nombre municipio, 
	local.nombre localidad,usu.direccion direccion ,usu.telefono telefono, usu.correo correo, diag.nombre diagnostico ,
	to_char(usu."fechaNacio", 'YYYY-MM-DD') nacio, cast((cast(now() as date)  - cast(usu."fechaNacio" as date)) as text) edad,
	usu.genero sexo  FROM admisiones_ingresos ing INNER JOIN sitios_dependencias dep ON (dep."tipoDoc_id" = ing."tipoDoc_id" AND dep.documento_id = ing.documento_id AND ing.consec=dep.consec) INNER JOIN clinico_servicios serv ON (serv.id = ing."serviciosIng_id") LEFT JOIN clinico_causasexterna ext ON (ext.id = ing."causasExterna_id") INNER JOIN usuarios_usuarios usu ON (usu.id=ing.documento_id) LEFT JOIN usuarios_tiposdocumento tipDoc ON (tipDoc.id = ing."tipoDoc_id") LEFT JOIN basicas_ocupaciones ocupa ON (ocupa.id = usu.ocupacion_id) LEFT JOIN basicas_estadocivil estCivil ON (estCivil.id = usu."estadoCivil_id") LEFT JOIN clinico_regimenes regimen ON (regimen.id = ing.regimen_id) LEFT JOIN sitios_municipios mun ON (mun.id=usu.municipio_id)
        LEFT JOIN sitios_localidades local ON (local.id=usu.localidad_id) LEFT JOIN clinico_diagnosticos diag ON (diag.id=ing."dxIngreso_id") WHERE ing.id = '50177'