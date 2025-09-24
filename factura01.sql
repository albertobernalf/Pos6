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
select * from facturacion_facturaciondetalle where facturacion_id=96
select * from facturacion_conveniospacienteingresos;

select * from cartera_pagosFacturas;

select documento_id,* from sitios_dependencias order by documento_id desc
select * from sitios_historialdependencias;
