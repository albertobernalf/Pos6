delete from clinico_historiaresultados; 
delete from clinico_historiaexamenes;   
delete from facturacion_refacturacion;  
delete from facturacion_facturaciondetalle;  
delete from facturacion_liquidaciondetalle;  
delete from facturacion_liquidacion;  
delete from clinico_historialantecedentes;  
delete from clinico_historialdiagnosticos;  
delete from clinico_historialincapacidades;  
delete from clinico_historialinterconsultas;  
delete from clinico_historiamedicamentos;  
delete from clinico_historiaoxigeno;  
delete from clinico_historiarevisionsistemas;  
delete from clinico_historiasignosvitales;  
delete from clinico_historiarevisionsistemas;  
delete from autorizaciones_autorizaciones;  
delete from autorizaciones_autorizacionesdetalle;   
delete from clinico_historia;  
delete from sitios_historialdependencias;  
update sitios_dependencias set "tipoDoc_id" = null, documento_id=null,consec = null,"fechaLiberacion"=null,"fechaOcupacion"=null,disponibilidad='L' 
delete from cartera_pagosfacturas;   
delete from cartera_pagos;  
delete from admisiones_furips;  
delete from admisiones_ingresos;  
delete from triage_triage - ok 
delete from autorizaciones_autorizacionesdetalle;
delete from autorizaciones_autorizacionescirugias;
delete from autorizaciones_autorizaciones;
delete from cartera_
delete from cartera_
delete from cartera_
delete from cartera_
delete from cartera_
delete from facturacion_conveniospacienteingresos;  
delete from facturacion_liquidaciondetalle;
delete from facturacion_liquidacion;
delete from facturacion_refacturacion;  
delete from rips_ripsprocedimientos;   
delete from rips_ripshospitalizacion;  
delete from rips_ripsmedicamentos;  
delete from rips_ripsotrosservicios;  
delete from rips_ripsreciennacido;  
delete from rips_ripsurgenciasobservacion;  
delete from rips_ripsusuarios;  
delete from rips_ripsdetalle;  
delete from cartera_glosas;  
delete from facturacion_facturacion;  
delete from rips_ripstransaccion;  
delete from rips_ripsenvios;  
delete from triage_triage;  
delete from clinico_historialinterconsultas;  
delete from clinico_historiamedicamentos;   
delete from clinico_historiarevisionsistemas;  
delete from clinico_historiasignosvitales;  
delete from cirugia_cirugiasmaterialqx;
delete from cirugia_cirugiasparticipantes;
delete from cirugia_cirugiasprocedimientos;
delete from cirugia_programacioncirugias;
delete from enfermeria_enfermeriarecibe;
delete from enfermeria_enfermeriadetalle;
delete from enfermeria_enfermeriadevolucion;
delete from enfermeria_enfermeriadevoluciondetalle;
delete from enfermeria_notasenfermeria;
delete from enfermeria_signosenfermeria;
delete from enfermeria_turnosenfermeria;
delete from farmacia_detalle;
delete from farmacia_despachosdispensa;
delete from farmacia_devoluciondetalle;
delete from farmacia_devolucion;
delete from farmacia_farmaciadespachos;
delete from farmacia_famacia;
select * from sitios_dependencias;

UPDATE sitios_dependencias
set disponibilidad='L', documento_id=null,"fechaLiberacion" = null, "fechaOcupacion"=null,"tipoDoc_id" = null;

