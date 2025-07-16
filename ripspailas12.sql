select * from rips_ripsdetalle;
select * from contratacion_convenios;
delete from rips_ripsdetalle where id=67;
select * from facturacion_facturacion;
select * from cartera_glosas;
update cartera_glosas set "ripsEnvio_id" = null where id=6;
 

SELECT f.id,  f.id factura,0 glosaId, f."fechaFactura", u.nombre paciente , f."totalFactura", f.estado  
	FROM public.facturacion_facturacion f, admisiones_ingresos i, usuarios_usuarios u  , contratacion_convenios c 
	WHERE  i."tipoDoc_id" = f."tipoDoc_id" AND i.documento_id = f.documento_id AND f.convenio_id =  c.id AND   c.empresa_id = 1
	AND f."ripsEnvio_id" IS NULL AND i."tipoDoc_id" = u."tipoDoc_id" AND i.documento_id = u.id AND i.consec = f."consecAdmision"
 

SELECT f.id,  f.id factura,glo.id glosaId, f."fechaFactura", u.nombre paciente , f."totalFactura", f.estado  
	FROM public.cartera_glosas glo ,public.facturacion_facturacion f, admisiones_ingresos i, usuarios_usuarios u  , contratacion_convenios c 
	WHERE  i."tipoDoc_id" = f."tipoDoc_id" AND i.documento_id = f.documento_id AND f.convenio_id =  c.id AND   c.empresa_id = 1
	AND glo."ripsEnvio_id" IS NULL AND i."tipoDoc_id" = u."tipoDoc_id" AND i.documento_id = u.id AND i.consec = f."consecAdmision"
	and glo.factura_id = f.id and glo."valorGlosa" > 0

SELECT g.id,  g.factura_id factura,g.id glosaId, g."fechaRecepcion" fechaFactura, u.nombre paciente , g."valorGlosa" totalFactura, g."estadoRecepcion_id" estado 
	FROM public.cartera_glosas g, facturacion_facturacion f , admisiones_ingresos i, usuarios_usuarios u  , contratacion_convenios c 
	WHERE  g.factura_id  =  f.id and i."tipoDoc_id" = f."tipoDoc_id" AND i.documento_id = f.documento_id AND f.convenio_id =  c.id AND   c.empresa_id = '1'
	AND g."ripsEnvio_id" IS NULL AND i."tipoDoc_id" = u."tipoDoc_id" AND i.documento_id = u.id AND i.consec = f."consecAdmision" and g."valorGlosa" >0


	-- hacer pruebas el dia martes 25
	-- upddate faturacion_facturacion ripsenvios_id
	-- upddate cartera_glosas ripsenvios_id

select * from rips_ripsenvios;
	
select * from rips_ripsdetalle;
select * from rips_ripsprocedimientos;
select * from rips_ripsmedicamentos;
select * from rips_ripshospitalizacion;
select * from rips_ripsurgenciasobservacion;
select * from rips_ripsreciennacido;
select * from rips_ripsconsultas;
select * from rips_ripsusuarios;
select * from rips_ripstransaccion;


delete from rips_ripsprocedimientos;
delete from rips_ripsmedicamentos;
delete from rips_ripshospitalizacion;
delete from rips_ripsurgenciasobservacion;
delete from rips_ripsreciennacido;
delete from rips_ripsotrosservicios;
delete from rips_ripsconsultas;
delete from rips_ripsusuarios;
delete from rips_ripstransaccion;
update facturacion_facturacion set "ripsEnvio_id" =null;
update cartera_glosas set "ripsEnvio_id" =null;
delete from rips_ripsdetalle;
delete from rips_ripsenvios;
DELETE FROM cartera_glosas;
 
select id,convenio_id,* from facturacion_facturacion;
select * from facturacion_facturaciondetalle;
select * from contratacion_convenios;
select * from facturacion_empresas;
select "tipoDoc_id", documento_id, consec,"dependenciasSalida_id",* from admisiones_ingresos;
select * from sitios_dependencias;
-- Querys violentos para hacer TEST DE datos
select * from sitios_sedesclinica;
select * from sitios_serviciossedes;
select * from clinico_servicios;
select * from usuarios_usuarios;
 
 
select fac.id idFact, fac.convenio_id, conv.id idConvenio, conv.nombre, emp.nombre empresa, emp.id idempresa
from facturacion_facturacion fac, contratacion_convenios conv, facturacion_empresas emp
where  fac.convenio_id = conv.id and conv.empresa_id = emp.id

	-- QUERY DURAZO PARA SET DE PRUEBAS FACTURACION
	
select fac.id idFact, fac.convenio_id, conv.id idConvenio, conv.nombre, emp.nombre empresa, emp.id idempresa, dep.numero,dep.nombre, serv.nombre, usu.nombre
from facturacion_facturacion fac, contratacion_convenios conv, facturacion_empresas emp, admisiones_ingresos i, sitios_dependencias dep,
	  sitios_sedesclinica  sed, sitios_serviciossedes servsed , clinico_servicios serv, usuarios_usuarios usu
where  fac.convenio_id = conv.id and conv.empresa_id = emp.id and  fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and 
	fac."consecAdmision" = i.consec and i."dependenciasSalida_id" = dep.id and sed.id = dep."sedesClinica_id" and dep."serviciosSedes_id" = servsed.id and
	servsed.servicios_id = serv.id and fac."tipoDoc_id" = usu."tipoDoc_id" and fac.documento_id = usu.id

	
-- QUERY DURAZO PARA SET DE PRUEBAS GLOSAS - PROCEDIMIENTOS
	

select ripstra.id transaccion,glo.id idGlo, glo.convenio_id, conv.id idConvenio, conv.nombre,emp.nombre empresa, emp.id idempresa, fac.id factura, glo."saldoFactura", ripsproc.consecutivo,ripsproc."vrServicio",
	ripsproc."valorGlosado", ripsproc."vAceptado", ripsproc."notasCreditoGlosa", glo."ripsEnvio_id", glo."valorGlosa"
from cartera_glosas glo , facturacion_facturacion fac, contratacion_convenios conv, rips_ripsprocedimientos ripsproc,  rips_ripstransaccion ripstra ,
		facturacion_empresas emp
where  glo.convenio_id = conv.id and glo.factura_id = fac.id and conv.empresa_id = emp.id and cast(ripstra."numFactura" as float) = fac.id and ripsproc."ripsTransaccion_id" = ripstra.id
order by ripsproc.consecutivo
	
delete from cartera_glosas;

SELECT generaFacturaJSON(49,13,'GLOSA')
	
select * from rips_ripshospitalizacion;
select * from rips_ripsurgenciasobservacion;
select * from rips_ripsenvios;
select * from rips_ripsdetalle;
select * from cartera_glosas;
select * from rips_ripsprocedimientos;
select * from rips_ripstransaccion;
select * from rips_ripsusuarios;

