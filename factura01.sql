select * from facturacion_empresas;
select * from autorizaciones_autorizaciones;
select "especialidadesMedicos_id",* from clinico_historia;

select * from clinico_especialidadesmedicos;
select * from planta_planta;
select * from clinico_medicos;
select * from autorizaciones_autorizacionesdetalle;
select * from clinico_examenes;
select * from facturacion_suministros;
select anulado,"estadoReg","fechaAnulacion",* from facturacion_facturacion;
select * from facturacion_refacturacion;
select * from facturacion_facturaciondetalle;
select * from facturacion_liquidacion;
select * from facturacion_liquidaciondetalle;
select anulado,"estadoReg",* from facturacion_facturacion;
select * from admisiones_ingresos;
select * from facturacion_facturaciondetalle where facturacion_id=95
select * from facturacion_conveniospacienteingresos;
select anulado,"estadoReg",* from facturacion_facturacion;
update facturacion_facturacion set "estadoReg" = 'A'  where id=95;
update facturacion_facturaciondetalle set "estadoRegistro" ='A' where facturacion_id=95
select * from cartera_pagosFacturas;
select * from admisiones_ingresos; --fechasalida = "2025-09-24 11:52:40.1977-05" NO TOCAR
select * from rips_ripstransaccion;
select * from rips_ripsmedicamentos;
select * from rips_ripsprocedimientos;
select * from rips_ripsusuarios;
select * from admisiones_ingresos;

 SELECT generaFacturaJSON(60,95,'FACTURA') dato

select * from facturacion_refacturacion;

