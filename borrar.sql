SELECT tp.nombre tipoDoc,  u.documento documento, u.nombre  paciente , ser.nombre servicioNombreIng, dep.nombre dependenciasIngreso , t.motivo,
t."examenFisico",t."frecCardiaca",t."frecRespiratoria",t."taSist",t."taDiast",t."taMedia",t.glasgow,t.peso,t.temperatura,t.estatura,
t.glucometria,t."escalaDolor",t."tipoIngreso",t.observaciones 
FROM triage_triage t 
inner join usuarios_usuarios u on (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" ) 
inner join sitios_dependencias dep on (dep."sedesClinica_id" = t."sedesClinica_id" and dep."tipoDoc_id" =  t."tipoDoc_id" and dep.documento_id =t."documento_id" ) -- and dep.consec = t.consec) 
inner join usuarios_tiposDocumento tp on (tp.id = u."tipoDoc_id") 
inner join sitios_dependenciastipo deptip on (deptip.id = dep."dependenciasTipo_id") 
inner join sitios_serviciosSedes sd on (sd."sedesClinica_id" = t."sedesClinica_id") 
inner join clinico_servicios ser  on (ser.id = sd.servicios_id  and ser.id = t."serviciosSedes_id" ) 
WHERE t."sedesClinica_id" = '1' and u."tipoDoc_id" = '1' and u.documento = '19465673' and t.consec= '0'

select * from triage_triage ;
select * from usuarios_usuarios;
select * from sitios_serviciosSedes;
select * from clinico_servicios;
select * from sitios_subServiciosSedes;
select * from sitios_dependencias;
 
SELECT tp.nombre tipoDoc,  u.documento documento, u.nombre  paciente , ser.nombre servicioNombreIng, dep.nombre dependenciasIngreso , t.motivo,
t."examenFisico",t."frecCardiaca",t."frecRespiratoria",t."taSist",t."taDiast",t."taMedia",t.glasgow,t.peso,t.temperatura,t.estatura,
t.glucometria,t."escalaDolor",t."tipoIngreso",t.observaciones 
FROM triage_triage t 
inner join usuarios_usuarios u on (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" ) 
inner join usuarios_tiposDocumento tp on (tp.id = u."tipoDoc_id") 
inner join clinico_servicios ser  on (  ser.id=1 ) 
inner join sitios_serviciosSedes sd on (sd."sedesClinica_id" = t."sedesClinica_id"  ) 
inner join sitios_subServiciosSedes sub on (sub."serviciosSedes_id" = sd.id) 
inner join sitios_dependencias dep on (dep."sedesClinica_id" = t."sedesClinica_id" and dep."serviciosSedes_id"=sd.id and dep."subServiciosSedes_id"= sub.id and					dep."tipoDoc_id" =  t."tipoDoc_id" and dep.documento_id =t."documento_id" ) -- and dep.consec = t.consec) 
inner join sitios_dependenciastipo deptip on (deptip.id = dep."dependenciasTipo_id") 
WHERE t."sedesClinica_id" = '1' and u."tipoDoc_id" = '1' and u.documento = '19465673' and t.consec= '0'