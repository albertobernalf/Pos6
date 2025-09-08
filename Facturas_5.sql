select "requiereAutorizacion", * from facturacion_suministros order by "requiereAutorizacion" desc

select * from facturacion_tipossuministro;
 
select "requiereAutorizacion", * from facturacion_suministros where "tipoSuministro_id" = '1' order by "requiereAutorizacion" desc

	select * from usuarios_usuarios order by id
select documento_id,* from clinico_historia order by id desc --1239
select * from clinico_historiamedicamentos where historia_id=1239;
select * from autorizaciones_autorizaciones order by id desc
select "requiereAutorizacion", * from facturacion_suministros where nombre='BROQUIFENOL2'
update facturacion_suministros set nombre='BROQUIFENOL2' where id=4795
select * from autorizaciones_autorizacionesdetalle where autorizaciones_id=88
select * from clinico_historiamedicamentos where id=238;


select aut.id id,  aut."fechaSolicitud" fechaSolicitud ,aut."numeroAutorizacion" numeroAutorizacion,aut."fechaAutorizacion" fechaAutorizacion, est.nombre estado, emp.nombre empresa,det.examenes_id examen ,det.cums_id cums, det."valorAutorizado" valorAutorizado, det."numeroAutorizacion" autDetalle, sum.nombre nombreSuministro, exa.nombre nombreExamen from autorizaciones_autorizaciones aut  inner join clinico_historia his on (his.id = aut.historia_id)  left join autorizaciones_autorizacionesdetalle det on (det.autorizaciones_id = aut.id)  inner join autorizaciones_estadosautorizacion est on (est.id = aut."estadoAutorizacion_id" ) left join facturacion_empresas emp on (emp.id = aut.empresa_id) left join facturacion_suministros sum on (sum.id=det.cums_id) left join clinico_examenes exa on (exa.id = det.examenes_id) WHERE his."tipoDoc_id" = '1' AND his.documento_id ='18' AND his."consecAdmision" = '1'
select * from facturacion_facturacion order by id desc

select * from facturacion_facturacion where documento_id='37' order by id desc
select * from facturacion_liquidacion  where documento_id='37' order by id desc
select * from facturacion_liquidaciondetalle where liquidacion_id in ('208','209')

select * from clinico_especialidadesmedicos order by id desc;
select * from clinico_especialidades;

SELECT em.id ,e.nombre 
FROM clinico_Especialidades e, clinico_EspecialidadesMedicos em,planta_planta pl  
where em."especialidades_id" = e.id and em."planta_id" = pl.id AND pl.documento = '19465673' AND em."sedesClinica_id" = '1'


select espmed.id,esp.nombre
from clinico_especialidadesmedicos espmed
INNER JOIN clinico_especialidades esp ON (esp.id = espmed.especialidades_id)
GROUP BY 	espmed.id,esp.nombre
order by esp.nombre ;

SELECT med.id id, p.nombre nombre
FROM planta_planta p,clinico_medicos med, planta_tiposPlanta tp
WHERE p."sedesClinica_id" = '1' and p."tiposPlanta_id" = tp.id and tp.nombre = 'MEDICO' and med.planta_id = p.id

	select * from clinico_especialidadesmedicos;
SELECT med.id id, p.nombre nombre
FROM planta_planta p,clinico_medicos med, planta_tiposPlanta tp,  clinico_especialidadesmedicos espmed
WHERE p."sedesClinica_id" = '1' and p."tiposPlanta_id" = tp.id and tp.nombre = 'MEDICO' and med.planta_id = p.id and
	espmed.planta_id = med.planta_id   


SELECT m.id id, pla.nombre nombre,medesp.id
from clinico_medicos m, clinico_Especialidadesmedicos medesp,clinico_especialidades esp,sitios_sedesclinica sed,  planta_planta pla
where  pla.id=medesp.planta_id and  medesp.especialidades_id = esp.id and m.planta_id = pla.id and  esp.id = '5' and esp.id=medesp.especialidades_id 
	and pla."sedesClinica_id" = sed.id and pla.id = medesp.planta_id and pla."sedesClinica_id"='1'

select * from clinico_Especialidadesmedicos where especialidades_id=8

select  * from admisiones_ingresos order by id desc
select * from clinico_medicos;
select * from planta_planta ORDER BY ID DESC

select "usuarioRegistro_id",* from clinico_historia order by id desc

select * fROM CLINICO_ESPECIALIDADES;

SELECT "tipoDoc_id",* FROM PLANTA_PLANTA ORDER BY documento
update PLANTA_PLANTA set documento='12345Cambiado' where id ='5'
update PLANTA_PLANTA set documento='19465673-cambio' where id=7

select * from clinico_historia order by id desc
	
SELECT medicos."registroMedico", planta.nombre plantaNombre, planta."tipoDoc_id", planta.documento
FROM clinico_historia historia 
INNER JOIN planta_planta planta ON (planta.id = historia."usuarioRegistro_id")
INNER JOIN clinico_medicos medicos ON (medicos.planta_id = planta.id) 
--INNER JOIN usuarios_usuarios usu ON (usu.id = historia.documento_id)
WHERE historia.id = '1242'
select * from admisiones_ingresos order by id desc      

select * from usuarios_usuarios;
select * from facturacion_facturacion where documento_id='55'
select * from facturacion_facturaciondetalle where facturacion_id='85'
select * from facturacion_liquidacion where documento_id='55'
select * from facturacion_liquidaciondetalle where liquidacion_id in ('214')
select * from sitios_historialdependencias where documento_id='9'
select * from admisiones_ingresos where documento_id=55
select * from clinico_servicios

SELECT * FROM FACTURACION_CONVENIOSPACIENTEINGRESOS where documento_id='55'

select "requiereAutorizacion",* from facturacion_suministros order  by "requiereAutorizacion" desc;
select "requiereAutorizacion",* from clinico_examenes   order  by "requiereAutorizacion" desc;
