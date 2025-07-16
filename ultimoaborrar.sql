insert into usuarios_usuarios (nombre, documento, genero, "fechaNacio",  departamentos_id, ciudades_id, direccion, telefono, contacto, "centrosC_id", "tipoDoc_id", "tiposUsuario_id", "fechaRegistro", "estadoReg") values ('eumelia' , '51872242', 'F'  , '2024-07-28T10:23', '1'  , '1'  , 'Cr 21 N° 169 15/25 Bodega 2', '7442565', 'ALBERTO', '1', '1', '2' , 2024-08-06 10:24:03.511038', 'A')


select * from triage_triage;
select * from usuarios_usuarios;

update usuarios_usuarios set nombre = 'eumelia', direccion  = 'Cr 21 N° 169 15/25 Bodega 2', genero = 'F', "fechaNacio" = '', telefono= '7442565', contacto= 'ALBERTO', "centrosC_id"= '2', "tiposUsuario_id" = '2' ,  municipio_id = '0', localidad_id = '0', "estadoCivil_id"= '0', ocupacion_id = '0', correo = '0' WHERE "tipoDoc_id" = 1 AND documento = '51872242'



select m.id id, m.nombre nombre , m.nomenclatura nomenclatura, m.logo logo, modeledef.nombre nombreOpcion ,elemen.nombre nombreElemento from seguridad_modulos m, seguridad_perfilesgralusu gral, planta_planta planta, seguridad_perfilesclinica perfcli, seguridad_perfilesclinicaopciones perfopc, seguridad_perfilesusu perfdet, seguridad_moduloselementosdef modeledef, seguridad_moduloselementos elemen 
where planta.id= 1 and  planta.id = gral."plantaId_id" and gral."perfilesClinicaId_id" = perfcli.id and perfcli."modulosId_id" = m.id and gral.id = perfdet."plantaId_id" and perfdet."perfilesClinicaOpcionesId_id" = perfopc.id and perfopc."perfilesClinicaId_id" =perfcli.id and  perfopc."modulosElementosDefId_id" = modeledef.id and elemen.id = modeledef."modulosElementosId_id"  and planta.documento = '19465673'

select * from sitios_dependencias;


SELECT tp.nombre tipoDoc,  u.documento documento, u.nombre  paciente , ser.nombre servicioNombreIng, dep.nombre dependenciasIngreso , 
t.motivo,t."examenFisico",t."frecCardiaca",t."frecRespiratoria",t."taSist",t."taDiast",t."taMedia",t.glasgow,t.peso,t.temperatura,
t.estatura,t.glucometria,t."escalaDolor",t."tipoIngreso",t.observaciones 
FROM triage_triage t 
inner join usuarios_usuarios u on (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" )
inner join sitios_dependencias dep on (dep."sedesClinica_id" = t."sedesClinica_id" and dep."tipoDoc_id" =  t."tipoDoc_id" and dep.documento_id =t."documento_id" ) 
inner join usuarios_tiposDocumento tp on (tp.id = u."tipoDoc_id") 
inner join sitios_dependenciastipo deptip on (deptip.id = dep."dependenciasTipo_id") 
inner join sitios_serviciosSedes sd on (sd."sedesClinica_id" = t."sedesClinica_id" and sd.id = dep."serviciosSedes_id" and sd.id = t."serviciosSedes_id" ) 
inner join sitios_subServiciosSedes sub on (sub."serviciosSedes_id" = sd.id and   sub."serviciosSedes_id"= dep."serviciosSedes_id"  and sub.id = t."subServiciosSedes_id" and sub."serviciosSedes_id" = dep."serviciosSedes_id"  and sub.id = dep."subServiciosSedes_id" ) 
inner join clinico_servicios ser  on (ser.id = sd.servicios_id   )
WHERE t."sedesClinica_id" = '1' and u."tipoDoc_id" = '1' and u.documento = '19465673' and t.consec= 0
 
select * from triage_triage;
delete from triage_triage where id=13;
select * from usuarios_usuarios;
select * from sitios_dependencias where documento_id=1;;
update sitios_dependencias set "serviciosSedes_id" = 4, "subServiciosSedes_id" = 3  where documento_id=1;;

comando = 'SELECT tp.nombre tipoDoc,  u.documento documento, u.nombre  paciente , ser.nombre servicioNombreIng, dep.nombre dependenciasIngreso , t.motivo,t."examenFisico",t."frecCardiaca",t."frecRespiratoria",t."taSist",t."taDiast",t."taMedia",t.glasgow,t.peso,t.temperatura,t.estatura,t.glucometria,t."escalaDolor",t."tipoIngreso",t.observaciones FROM triage_triage t inner join usuarios_usuarios u on (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" ) inner join sitios_dependencias dep on (dep."sedesClinica_id" = t."sedesClinica_id" and dep."tipoDoc_id" =  t."tipoDoc_id" and dep.documento_id =t."documento_id" ) inner join usuarios_tiposDocumento tp on (tp.id = u."tipoDoc_id") inner join sitios_dependenciastipo deptip on (deptip.id = dep."dependenciasTipo_id") inner join sitios_serviciosSedes sd on (sd."sedesClinica_id" = t."sedesClinica_id" and sd.id = dep."serviciosSedes_id" and sd.id = t."serviciosSedes_id" ) inner join sitios_subServiciosSedes sub on (sub."serviciosSedes_id" = sd.id and   sub."serviciosSedes_id"= dep."serviciosSedes_id"  and sub.id = t."subServiciosSedes_id" and sub."serviciosSedes_id" = dep."serviciosSedes_id"  and sub.id = dep."subServiciosSedes_id" ) inner join clinico_servicios ser  on (ser.id = sd.servicios_id   ) WHERE t."sedesClinica_id" = ' + "'" + str(Sede) + "'" + ' and u."tipoDoc_id" = ' + "'" + str(tipoDoc) + "'"' + ' and u.documento = ' + "'"' + str(documento) + "'" + ' and t.consec= 0'


SELECT sd.id servicioSedes, sub.id subServiciosSedes, dep.id dependencias,
tp.nombre tipoDoc,  u.documento documento, u.nombre  paciente , dep.nombre dependenciasIngreso , t.motivo,t."examenFisico",t."frecCardiaca",t."frecRespiratoria",t."taSist",t."taDiast",t."taMedia",t.glasgow,t.peso,t.temperatura,t.estatura,t.glucometria,t."escalaDolor",t."tipoIngreso",t.observaciones FROM triage_triage t inner join usuarios_usuarios u on (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" ) inner join sitios_dependencias dep on (dep."sedesClinica_id" = t."sedesClinica_id" and dep."tipoDoc_id" =  t."tipoDoc_id" and dep.documento_id =t."documento_id" ) inner join usuarios_tiposDocumento tp on (tp.id = u."tipoDoc_id") inner join sitios_dependenciastipo deptip on (deptip.id = dep."dependenciasTipo_id") inner join sitios_serviciosSedes sd on (sd."sedesClinica_id" = t."sedesClinica_id" and sd.id = dep."serviciosSedes_id" and sd.id = t."serviciosSedes_id" ) inner join sitios_subServiciosSedes sub on (sub."serviciosSedes_id" = sd.id and   sub."serviciosSedes_id"= dep."serviciosSedes_id"  and sub.id = t."subServiciosSedes_id" and sub."serviciosSedes_id" = dep."serviciosSedes_id"  and sub.id = dep."subServiciosSedes_id" ) inner join clinico_servicios ser  on (ser.id = sd.servicios_id   ) WHERE t."sedesClinica_id" = '1' and u."tipoDoc_id" = '1' and u.documento = '19465673' and t.consec = 0