select * from mae_especialidad;
--"890402"
"890201"

"Medicina General"
"890201";"CONSULTA DE PRIMERA VEZ POR MEDICINA GENERAL"
"890402";"INTERCONSULTA POR OTRAS ESPECIALIDADES MEDICAS"



select * from mae_cups where codreg_cups in ('890201','890402');
select * from tbladm_citas where fec_cita >= '2025-05-19' order by fec_cita,hora_cita;
"80820980" -- saul andres benavidex
1509914
1509919
1509925


select * from tbladm_pacientes where num_ide = '80820980'; limit 10;
select * from tbladm_admisiones where num_ide = '80820980' order by num_admision;

select * from tblfac_encabezado where num_admision in (1253432,1253433,1253438)
select * from tblfac_cargos where num_admision in (1253432,1253433,1253438)
select * from tblfac_detalle where num_admision in (1253432,1253433,1253438)
select * from tbladm_citas where num_admision in (1253432,1253433,1253438) order by fec_cita;
select * from mae_especialidad where especialidad like ('%Lase%')

select * from tblfac_terapia where num_admision in (1253432,1253433,1253438);

"Terapia Fisica - Laser";"N";"N";"S";"N";"S";"930900-04";"";"930900-04";"N";"<ul>
