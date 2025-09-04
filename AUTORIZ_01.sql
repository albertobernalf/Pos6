select * from farmacia_farmacia;
select * from farmacia_farmaciadetalle;
select * from enfermeria_enfermeria
select * from enfermeria_enfermeriadetalle
select * from autorizaciones_autorizaciones;
select * from autorizaciones_autorizacionesdetalle;
select * from clinico_historia ORDER BY ID DESC;
select * from clinico_HistoriaMedicamentos where id in ('226','227');

select * from clinico_examenes where "codigoCups" = '999200'
	select * from clinico_examenes where "codigoCups" = '904101'

		select * from clinico_examenes where "TiposExamen_id" = 3
	
	update clinico_examenes set "requiereAutorizacion" = 'S' where "codigoCups" = '904101'

	select * from clinico_tiposexamen;

select cums, "requiereAutorizacion",* from facturacion_suministros order by "requiereAutorizacion" desc

  INSERT INTO autorizaciones_autorizacionesdetalle ("estadoAutorizacion_id", "cantidadSolicitada", "cantidadAutorizada", "fechaRegistro", "estadoReg", autorizaciones_id, "usuarioRegistro_id", "examenes_id", cums_id)
	VALUES ('1','1' ,0, now(),'A','74','1','2692',null)

select * from autorizaciones_autorizaciones order by id desc
select * from autorizaciones_autorizacionesdetalle
SELECT * FROM CLINICO_TIPOSEXAMEN	
	  select * from usuarios_usuarios;

select cums,"requiereAutorizacion",* from facturacion_suministros where cums='17147-1'
	update facturacion_suministros  set "requiereAutorizacion" = 'S' where cums='17147-1'

	begin transaction;
INSERT INTO autorizaciones_autorizaciones ("estadoAutorizacion_id","fechaModifica", "fechaRegistro", "estadoReg",empresa_id, "plantaOrdena_id", "sedesClinica_id", "usuarioRegistro_id", historia_id, convenio_id )  
	
	SELECT '1', now(), now(), 'A', conv.empresa_id,  '1','1','1','1236', conv.id
	FROM facturacion_conveniospacienteingresos convIngreso,  contratacion_convenios conv
	WHERE conv.id = '20' AND conv.id = convIngreso.convenio_id AND convIngreso."tipoDoc_id" = '1'
	AND convIngreso.documento_id = '18' AND convIngreso."consecAdmision" = '1' AND conv.id = '8' 
	RETURNING id
ROLLBACK;	

select * from facturacion_liquidacion where documento_id='18'


INSERT INTO autorizaciones_autorizacionesdetalle ("estadoAutorizacion_id", "cantidadSolicitada", "cantidadAutorizada",
	"fechaRegistro", "estadoReg", autorizaciones_id, "usuarioRegistro_id", "examenes_id", cums_id, "tiposExamen_id",
	"valorSolicitado", "valorAutorizado") 
	VALUES ('1','2' ,0, now(),'A','78','1','2692',null,'2','42000.0000')

select 'SUMINISTROS' tipoTipoExamen, det.id, "cantidadSolicitada", "cantidadAutorizada", det."fechaRegistro", det."estadoReg", autorizaciones_id, det."usuarioRegistro_id",  tipsum.nombre tipNombre, exa.nombre exaNombre,  cums_id, "valorAutorizado", "valorSolicitado", "tiposExamen_id", det."tipoSuministro_id", det."estadoAutorizacion_id", det."numeroAutorizacion" , est.nombre estadoNombre,aut.convenio_id convenioId FROM autorizaciones_autorizacionesdetalle det, autorizaciones_estadosautorizacion est, facturacion_tipossuministro tipsum, facturacion_suministros exa  WHERE aut.id = det."autorizaciones_id" det.id ='48'AND tipsum.id = det."tipoSuministro_id"  AND exa.id = det.cums_id AND  est.id = det."estadoAutorizacion_id"