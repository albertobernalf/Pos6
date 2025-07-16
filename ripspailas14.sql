select * from rips_ripsenvios; -- 47
select * from rips_ripsdetalle; -- glosaId = 12 // factura 42 // id de detalle = 76
select id,consecutivo, "itemFactura", * from rips_ripsprocedimientos where glosa_id=12; -- id= 529
select * from rips_ripsProcedimientos;
select * from rips_ripstipos;
select * from cartera_glosas;
select * from rips_ripstransaccion; -- 148
select * from rips_ripsusuarios;
select * from usuarios_tiposdocumento;

select * from cartera_glosas;
select * from rips_ripshospitalizacion;

begin transaction;
delete from rips_ripsProcedimientos where glosa_id = '12' and "notasCreditoGlosa" is null;
select * FROM rips_ripsProcedimientos 	 where "ripsTransaccion_id" = 141  order by consecutivo
-- rollback;
-- commit;
select * from rips_ripsprocedimientos WHERE "ripsTransaccion_id" = 141;


begin transaction;
delete from rips_ripsprocedimientos where glosa_id = 12 and "ripsTransaccion_id" = 152;
update rips_ripsprocedimientos set "ripsTransaccion_id" = 152 where glosa_id = 12 and "ripsTransaccion_id" = 141; 
select * from rips_ripsprocedimientos where glosa_id = 12;
-- rollback;
-- commit;

 INSERT INTO rips_ripsreciennacido ("codPrestador", "numDocumentoIdentificacion", "fechaNacimiento", "edadGestacional", "numConsultasCPrenatal","codSexoBiologico", 
	 peso,"fechaEgreso", consecutivo, "fechaRegistro", "codDiagnosticoCausaMuerte_id", "codDiagnosticoPrincipal_id","condicionDestinoUsuarioEgreso_id",
	 "tipoDocumentoIdentificacion_id","usuarioRegistro_id", "ripsDetalle_id", "ripsTipos_id", "ripsTransaccion_id")
	 SELECT "codPrestador", "numDocumentoIdentificacion", "fechaNacimiento", "edadGestacional", "numConsultasCPrenatal","codSexoBiologico", peso,"fechaEgreso", consecutivo,
	 ripsnac."fechaRegistro", "codDiagnosticoCausaMuerte_id", "codDiagnosticoPrincipal_id","condicionDestinoUsuarioEgreso_id","tipoDocumentoIdentificacion_id",
	 ripsnac."usuarioRegistro_id",'76', "ripsTipos_id", '155'
	 FROM rips_ripsreciennacido ripsnac, rips_ripsdetalle det, rips_ripstransaccion ripstra 
	 where ripstra."ripsEnvio_id" = det."ripsEnvios_id" and ripsnac."ripsTransaccion_id" = ripstra.id and ripsnac."ripsDetalle_id" = det.id and
	 cast(ripstra."numFactura" as float) =  det."numeroFactura_id" and cast(ripstra."numFactura" as float) = '42'