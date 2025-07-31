select * from clinico_historialinterconsultas;

select * from clinico_historialincapacidades;

select "tiposExamen_id",  * from clinico_historiaexamenes;
select * from clinico_historiaexamenes where historia_id = 772;
select documento_id,* from clinico_historia where id in (717,726,728,721) -- 16,26,28
select * from usuarios_usuarios; -- 37 francisco

select * from clinico_tiposexamenes;
select historia_id,* from clinico_historiamedicamentos;
select * from clinico_UnidadesDeMedidaDosis;
select * from clinico_UnidadesDeMedida;



select * from clinico_revisionsistemas;
select * from clinico_historiarevisionsistemas;

select * from usuarios_tiposUsuario;

select  u."tipoDoc_id" , tip.nombre tipnombre, documento documentoPaciente, u.nombre nombre, 
	case when genero = 'M' then 'Masculino' when genero= 'F' then 'Femenino' end as genero,
	cen.nombre as centro, tu.nombre as tipoUsuario,"fechaNacio", u.direccion direccion, u.telefono telefono 
	from usuarios_usuarios u, usuarios_tiposUsuario tu, sitios_centros cen, usuarios_tiposDocumento tip
	where tip.id = u."tipoDoc_id"  AND u."tipoDoc_id" = '1' and u.id = '16' 
	and u."tiposUsuario_id" = tu.id and u."centrosC_id" = cen.id

	select * from usuarios_usuarios;
      


select * from clinico_historialantecedentes
select * from clinico_tiposantecedente
select * from contratacion_convenios order by id;
select * from facturacion_empresas; -- regimen_id
select * from facturacion_conveniospacienteingresos where documento_id=16;
select * from admisiones_ingresos where documento_id=16;

select * from clinico_regimenes;
select * from usuarios_usuarios;
select * from clinico_servicios;

select * from sitios_dependencias; -- serviciosActual_id

select  u."tipoDoc_id" , tip.nombre tipnombre, u.documento documentoPaciente, u.nombre nombre, 
	case when genero = 'M' then 'Masculino' when genero= 'F' then 'Femenino' end as genero,
	(date_part('year', now()) - date_part('year', u."fechaNacio" )) edad,
 u.direccion direccion, u.telefono telefono , reg.nombre, convenio.nombre, serv.nombre
from admisiones_ingresos adm
INNER JOIN 	usuarios_usuarios u ON (u."tipoDoc_id" = adm."tipoDoc_id" and u.id = adm.documento_id)
INNER JOIN usuarios_tiposDocumento tip ON (tip.id = u."tipoDoc_id")
INNER JOIN facturacion_conveniospacienteingresos  convIngreso ON (convIngreso."tipoDoc_id" = adm."tipoDoc_id" and convIngreso.documento_id = adm.documento_id and convIngreso."consecAdmision" = adm.consec)
INNER JOIN contratacion_convenios convenio ON (convenio.id = convIngreso.convenio_id)
INNER JOIN facturacion_empresas EMP on (emp.id =convenio.empresa_id )
INNER JOIN clinico_regimenes reg ON (reg.id=emp.regimen_id)
INNER JOIN clinico_servicios serv ON (serv.id = adm."serviciosActual_id")	
WHERE adm."tipoDoc_id" = '1' AND adm.documento_id= '16' AND adm.consec = 1  and convenio.id = 	1

	comando =	'select  u."tipoDoc_id" , tip.nombre tipnombre, u.documento documentoPaciente, u.nombre nombre, case when genero = ' + "'" + str('M') + "'" + ' then '  + "'" + str('Masculino') +  "'" + ' when genero= ' + "'" + str('F') + "'" + ' then ' + "'" + str('Femenino') + "'" + ' end as genero, (date_part(' + "'" + str('year') + "'" + ', now()) - date_part(' + "'" + str('year') + "'" + ', u."fechaNacio" )) edad,  , reg.nombre, convenio.nombre, serv.nombre from admisiones_ingresos adm INNER JOIN 	usuarios_usuarios u ON (u."tipoDoc_id" = adm."tipoDoc_id" and u.id = adm.documento_id) INNER JOIN usuarios_tiposDocumento tip ON (tip.id = u."tipoDoc_id") INNER JOIN facturacion_conveniospacienteingresos  convIngreso ON (convIngreso."tipoDoc_id" = adm."tipoDoc_id" and convIngreso.documento_id = adm.documento_id and convIngreso."consecAdmision" = adm.consec) INNER JOIN contratacion_convenios convenio ON (convenio.id = convIngreso.convenio_id) INNER JOIN facturacion_empresas EMP on (emp.id =convenio.empresa_id ) INNER JOIN clinico_regimenes reg ON (reg.id=emp.regimen_id) INNER JOIN clinico_servicios serv ON (serv.id = adm."serviciosActual_id")	 WHERE adm."tipoDoc_id" = ' + "'" + str('1') + "'" + ' AND adm.documento_id= ' + "'" + str('16') + "'" + ' AND adm.consec = 1  and convenio.id = 1'

	

	
SELECT antecedente.nombre antecedente, histAntecedente.descripcion descripcion
FROM clinico_historialantecedentes histAntecedente
INNER JOIN clinico_tiposantecedente antecedente  ON (antecedente.id = histAntecedente."tiposAntecedente_id")
WHERE histAntecedente.historia_id in (717)

comando = 'SELECT antecedente.nombre antecedente, histAntecedente.descripcion descripcion FROM clinico_historialantecedentes histAntecedente INNER JOIN clinico_tiposantecedente antecedente  ON (antecedente.id = histAntecedente."tiposAntecedente_id") WHERE histAntecedente.historia_id = '


select * from clinico_historiasignosvitales;

SELECT signos.fecha,signos."frecCardiaca", signos."frecRespiratoria", signos."tensionADiastolica", signos."tensionASistolica",
	signos."tensionAMedia", signos.temperatura, signos.saturacion, signos.glucometria, signos.glasgow, signos.apache, signos.pvc, 
	signos.cuna, signos.ic, signos."glasgowOcular", signos."glasgowVerbal", signos."glasgowMotora", signos.observacion
FROM clinico_historiasignosvitales  signos
WHERE signos.historia_id in (717)

comando='SELECT signos.fecha,signos."frecCardiaca", signos."frecRespiratoria", signos."tensionADiastolica", signos."tensionASistolica", 	signos."tensionAMedia", signos.temperatura, signos.saturacion, signos.glucometria, signos.glasgow, signos.apache, signos.pvc, 	signos.cuna, signos.ic, signos."glasgowOcular", signos."glasgowVerbal", signos."glasgowMotora", signos.observacion FROM clinico_historiasignosvitales  signos WHERE signos.historia_id = '

select documento_id, * from clinico_historia;
update clinico_historia set apache2=0,"notaAclaratoria" = null, tratamiento=null where id=723;
	
	


select historia.id, historia.documento_id, historia.folio,historia.antibioticos, historia.apache2,historia."examenFisico", historia.hipotension,historia."ingestaAlcohol",
	historia.irritacion, historia.justificacion, historia.leucopenia, historia."llenadoCapilar", historia.monitoreo,
	historia."movilidadLimitada",historia.nauseas, historia.neurologia, historia."notaAclaratoria", historia.pulsos, historia."retiroPuntos",
	historia."riesgoHemodinamico", historia."riesgoVentilatorio", historia.riesgos, historia."textoNotaAclaratoria",
	historia.tratamiento, historia."trombocitopenia", historia.vomito
FROm clinico_historia historia
WHERE historia.documento_id in (16)

comando = 'select historia.antibioticos, historia.apache2,historia."examenFisico", historia.hipotension,historia."ingestaAlcohol", 	historia.irritacion, historia.justificacion, historia.leucopenia, historia."llenadoCapilar", historia.monitoreo, 	historia."movilidadLimitada",historia.nauseas, historia.neurologia, historia."notaAclaratoria", historia.pulsos, historia."retiroPuntos", 	historia."riesgoHemodinamico", historia."riesgoVentilatorio", historia.riesgos, historia."textoNotaAclaratoria", 	historia.tratamiento, historia."trombocitopenia", historia.vomito FROm clinico_historia historia WHERE historia.id = '

select  u."tipoDoc_id" , tip.nombre tipnombre, u.documento documentoPaciente, u.nombre nombre, case when genero = 'M' then 'Masculino' when genero= 'F' then 'Femenino' end as genero, trunc(date_part('year', now()) - date_part('year', u."fechaNacio" )) edad,   reg.nombre regimen, convenio.nombre convenio , serv.nombre servicio from admisiones_ingresos adm INNER JOIN     usuarios_usuarios u ON (u."tipoDoc_id" = adm."tipoDoc_id" and u.id = adm.documento_id) INNER JOIN usuarios_tiposDocumento tip ON (tip.id = u."tipoDoc_id") INNER JOIN facturacion_conveniospacienteingresos  convIngreso ON (convIngreso."tipoDoc_id" = adm."tipoDoc_id" and convIngreso.documento_id = adm.documento_id and convIngreso."consecAdmision" = adm.consec) INNER JOIN contratacion_convenios convenio ON (convenio.id = convIngreso.convenio_id) INNER JOIN facturacion_empresas EMP on (emp.id =convenio.empresa_id ) INNER JOIN clinico_regimenes reg ON (reg.id=emp.regimen_id) INNER JOIN clinico_servicios serv ON (serv.id = adm."serviciosActual_id")         WHERE adm."tipoDoc_id" = '1' AND adm.documento_id= '16' AND adm.consec = 1  and convenio.id = 1

SELECT tipo.nombre tipo, diag.nombre diagnostico, inca."desdeFecha" desdeFecha, inca."hastaFecha" hastaFecha, inca."numDias" dias, inca.descripcion descripcion FROM clinico_historialincapacidades inca INNER JOIN clinico_historia historia ON (historia.id=inca.historia_id) INNER JOIN clinico_TiposIncapacidad tipo  ON (tipo.id = inca."tiposIncapacidad_id") INNER JOIN clinico_Diagnosticos diag ON (diag.id = inca."diagnosticosIncapacidad_id") WHERE inca.historia_id = 721
select * from clinico_historialincapacidades;
select * from clinico_historia where id=721;
select * from clinico_medicos;
select * from usuarios_usuarios;


SELECT tipo.nombre tipo, diag.nombre diagnostico, inca."desdeFecha" desdeFecha, inca."hastaFecha" hastaFecha,
	inca."numDias" dias, inca.descripcion descripcion, medicos."registroMedico", planta.nombre , usu."tipoDoc_id", usu.documento
	FROM clinico_historialincapacidades inca
	INNER JOIN clinico_historia historia ON (historia.id=inca.historia_id)
	INNER JOIN clinico_TiposIncapacidad tipo  ON (tipo.id = inca."tiposIncapacidad_id")
	INNER JOIN clinico_Diagnosticos diag ON (diag.id = inca."diagnosticosIncapacidad_id")
    INNER JOIN planta_planta planta ON (planta.id = historia."usuarioRegistro_id")	
	INNER JOIN clinico_medicos medicos ON (medicos.id = historia."usuarioRegistro_id")	
	INNER JOIN usuarios_usuarios usu ON (usu.id = historia."usuarioRegistro_id")	
	WHERE inca.historia_id = 721

comando = 'SELECT tipo.nombre tipo, diag.nombre diagnostico, inca."desdeFecha" desdeFecha, inca."hastaFecha" hastaFecha,	inca."numDias" dias, inca.descripcion descripcion, medicos."registroMedico", planta.nombre , usu."tipoDoc_id", usu.documento 	FROM clinico_historialincapacidades inca 	INNER JOIN clinico_historia historia ON (historia.id=inca.historia_id) 	INNER JOIN clinico_TiposIncapacidad tipo  ON (tipo.id = inca."tiposIncapacidad_id") INNER JOIN clinico_Diagnosticos diag ON (diag.id = inca."diagnosticosIncapacidad_id") INNER JOIN planta_planta planta ON (planta.id = historia."usuarioRegistro_id")	 INNER JOIN clinico_medicos medicos ON (medicos.id = historia."usuarioRegistro_id") INNER JOIN usuarios_usuarios usu ON (usu.id = historia.documento_id)	WHERE inca.historia_id = 721'

SELECT  medicos."registroMedico", planta.nombre plantaNombre, usu."tipoDoc_id", usu.documento 
	FROM clinico_historiaexamenes exa 
	INNER JOIN clinico_historia historia ON (historia.id=exa.historia_id) 
	INNER JOIN planta_planta planta ON (planta.id = historia."usuarioRegistro_id")	 
	INNER JOIN clinico_medicos medicos ON (medicos.id = historia."usuarioRegistro_id") 
	INNER JOIN usuarios_usuarios usu ON (usu.id = historia."usuarioRegistro_id")	
	WHERE exa.historia_id in (717) 

select documento_id, * from clinico_historia WHERE id in (717,726,728,721) 
select * from clinico_historiaexamenes WHERE historia_id in (717,726,728,721) 

comando = 'SELECT  medicos."registroMedico", planta.nombre plantaNombre, usu."tipoDoc_id", usu.documento FROM clinico_historiaexamenes exa INNER JOIN clinico_historia historia ON (historia.id=exa.historia_id) INNER JOIN planta_planta planta ON (planta.id = historia."usuarioRegistro_id")	INNER JOIN clinico_medicos medicos ON (medicos.id = historia."usuarioRegistro_id") INNER JOIN usuarios_usuarios usu ON (usu.id = historia."usuarioRegistro_id") WHERE exa.historia_id = '

SELECT  medicos."registroMedico", planta.nombre plantaNombre, usu."tipoDoc_id", usu.documento 
FROM clinico_historiaexamenes exa
INNER JOIN clinico_historia historia ON (historia.id=exa.historia_id) 
INNER JOIN planta_planta planta ON (planta.id = historia."usuarioRegistro_id")      
INNER JOIN clinico_medicos medicos ON (medicos.id = historia."usuarioRegistro_id")
INNER JOIN usuarios_usuarios usu ON (usu.id = historia."usuarioRegistro_id")
WHERE exa.historia_id = 728

SELECT  medicos."registroMedico", planta.nombre plantaNombre, planta."tipoDoc_id", planta.documento 
FROM clinico_historiaexamenes exa 
	INNER JOIN clinico_historia historia ON (historia.id=exa.historia_id)
	INNER JOIN planta_planta planta ON (planta.id = historia."usuarioRegistro_id")   
	INNER JOIN clinico_medicos medicos ON (medicos.planta_id = historia."usuarioRegistro_id")
--	INNER JOIN usuarios_usuarios usu ON (usu.id = historia."usuarioRegistro_id")
	WHERE exa.historia_id = 728
	group by "registroMedico", plantaNombre, planta."tipoDoc_id", documento

select * from clinico_medicos;
select * from planta_planta;