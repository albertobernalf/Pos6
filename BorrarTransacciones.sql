
-- delete from clinico_historiaresultados; -- ok
-- delete from clinico_historiaexamenes;  -- ok 64

-- delete from facturacion_refacturacion; -- ok 2
-- delete from facturacion_facturaciondetalle; -- ok 65
-- delete from facturacion_liquidaciondetalle; -- ok 52
 -- delete from facturacion_liquidacion; -- ok 8





-- delete from clinico_historialantecedentes; -- ok 4
-- delete from clinico_historialdiagnosticos; -- ok 129
-- delete from clinico_historialincapacidades; -- ok 1
-- delete from clinico_historialinterconsultas; -- ok 0
-- delete from clinico_historiamedicamentos; -- ok 29
-- delete from clinico_historiaoxigeno; -- ok 0
-- delete from clinico_historiarevisionsistemas; --ok 0
-- delete from clinico_historiasignosvitales; --ok 0
-- delete from clinico_historiarevisionsistemas; --ok 0

delete from autorizaciones_autorizaciones; -- ok 7
delete from autorizaciones_autorizacionesdetalle;  -- ok 7
-- delete from clinico_historia; --ok 98
-- delete from sitios_historialdependencias; --ok 16

-- update sitios_dependencias set "tipoDoc_id" = null, documento_id=null,consec = null,"fechaLiberacion"=null,"fechaOcupacion"=null,disponibilidad='L' --ok
delete from cartera_pagosfacturas;  -- ok 7
-- delete from cartera_pagos; --ok 14
 
-- delete from admisiones_furips; --ok 0
-- delete from admisiones_ingresos; -- ok 10
-- delete from triage_triage - ok 1
-- delete from facturacion_conveniospacienteingresos; -- ok 11
delete from facturacion_liquidaciondetalle;
delete from facturacion_liquidacion;
delete from facturacion_refacturacion; -- ok 0

delete from rips_ripsprocedimientos;  -- ok 15
delete from rips_ripshospitalizacion; -- ok 0


delete from rips_ripsmedicamentos; -- ok 4
delete from rips_ripsotrosservicios; -- ok 0
delete from rips_ripsreciennacido; -- ok 2
delete from rips_ripsurgenciasobservacion; -- ok 2
delete from rips_ripsusuarios; -- ok 2

delete from rips_ripsdetalle; -- ok 2

delete from cartera_glosas; -- ok 1
delete from facturacion_facturacion; -- ok 11
delete from rips_ripstransaccion; -- ok 2
delete from rips_ripsenvios; -- ok 2
delete from triage_triage; -- ok 2
delete from clinico_historialinterconsultas; -- ok 0
delete from clinico_historiamedicamentos;  -- ok 0
delete from clinico_historiarevisionsistemas; -- ok 0
delete from clinico_historiasignosvitales; -- ok 0


select * from sitios_dependencias;

UPDATE sitios_dependencias
set disponibilidad='L', documento_id=null,"fechaLiberacion" = null, "fechaOcupacion"=null,"tipoDoc_id" = null;

