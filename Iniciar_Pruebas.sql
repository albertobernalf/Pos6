select * from triage_triage;
delete from triage_triage;
select * from admisiones_ingresos;
delete from admisiones_ingresos;
select * from sitios_dependencias;
update sitios_dependencias set disponibilidad='L',consec=null,documento_id=null,"tipoDoc_id"=null, "fechaOcupacion"=null,"fechaLiberacion"=null;
select * from sitios_historialdependencias;
delete from sitios_historialdependencias
select * from usuarios_USUARIOS;
delete from clinico_historia
delete from clinico_historiaExamenes;
delete from clinico_historiaMedicamentos;
delete from clinico_historiarevisionsistemas
delete from clinico_historialdiagnosticos;
delete from clinico_historialantecedentes;
delete from clinico_historiasignosvitales;