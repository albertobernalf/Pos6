delete from clinico_historiaresultados;  -- 1
delete from clinico_historiaexamenes;   --149
delete from facturacion_refacturacion;   -- 4
delete from facturacion_facturaciondetalle;   -12
delete from facturacion_liquidaciondetalle;  --198
delete from facturacion_liquidacion;   --20
delete from clinico_historialantecedentes;   -- 2
delete from clinico_historialdiagnosticos;  --241
delete from clinico_historialincapacidades;   --28
delete from clinico_historialinterconsultas;   -- 1
delete from enfermeria_enfermeriaplaneacion; -- 4
delete from enfermeria_enfermeriadevoluciondetalle; -- 2
delete from enfermeria_enfermeriadevolucion;-- 2
delete from enfermeria_enfermeriarecibe; -- 1
delete from enfermeria_enfermeriadetalle; -- 124
delete from farmacia_farmaciadevoluciondetalle; -- 2
delete from farmacia_farmaciadevolucion; --2
delete from farmacia_farmaciadespachosdispensa; --1
delete from farmacia_farmaciadetalle; --124
delete from farmacia_farmaciadespachos; --1
delete from farmacia_farmacia; --62

delete from clinico_historiamedicamentos;   -- 156
delete from clinico_historiaoxigeno;   -- 0
delete from clinico_historiarevisionsistemas;   -- 0
delete from clinico_historiasignosvitales;   -- 3
delete from autorizaciones_autorizacionesdetalle;   -- 5
delete from autorizaciones_autorizaciones;   -- 5
delete from clinico_historialdietas; -- 9
delete from clinico_historialnotasenfermeria; -- 8
delete from enfermeria_notasenfermeria; -- 0
delete from enfermeria_signosenfermeria; - 0
delete from enfermeria_turnosenfermeria; -- 3
delete from enfermeria_enfermeria; -- 62
delete from clinico_historia;   -- 275
 
delete from sitios_historialdependencias;   -- 94
update sitios_dependencias set "tipoDoc_id" = null, documento_id=null,consec = null,"fechaLiberacion"=null,"fechaOcupacion"=null,disponibilidad='L'  -- 44
delete from cartera_pagosfacturas;    -- 5
delete from cartera_pagos;   -- 8
delete from admisiones_furips;   -- 0
delete from admisiones_ingresos;   -- 86
delete from triage_triage  - 26
delete from autorizaciones_autorizacionesdetalle; -- 0
delete from autorizaciones_autorizacionescirugias; -- 0
delete from autorizaciones_autorizaciones; -- 0
delete from facturacion_conveniospacienteingresos;   -- 18

delete from rips_ripsprocedimientos;    -- 4
delete from rips_ripshospitalizacion;  --1
delete from rips_ripsmedicamentos;   --3
delete from rips_ripsotrosservicios;   --0
delete from rips_ripsreciennacido;   --4
delete from rips_ripsurgenciasobservacion;   --3
delete from rips_ripsusuarios;   --4
delete from rips_ripsdetalle;   ---4
delete from cartera_glosas;   --2
delete from facturacion_facturacion;  -- 4
delete from rips_ripstransaccion;   -- 4
delete from rips_ripsenvios;  -- 9
delete from clinico_historialinterconsultas;   -- 0
delete from cirugia_cirugiasmaterialqx; -- 20
delete from cirugia_cirugiasparticipantes; --18
delete from cirugia_cirugiasprocedimientos;--21
delete from cirugia_programacioncirugias; -- 9

select * from sitios_dependencias;
  