select * from rips_ripsprocedimientos order by  "vAceptado" asc
select * from cartera_glosas;

select * from rips_ripstransaccion order by id desc
select * from rips_ripsprocedimientos where "ripsTransaccion_id" = 745
select * from rips_ripsusuarios where "ripsTransaccion_id" = 740	
select * from rips_ripsmedicamentos where "ripsTransaccion_id" = 739
select * from rips_ripshospitalizacion where "ripsTransaccion_id" = 739
	select * from rips_ripshospitalizacion order by id desc
select generaFacturaJSON('64','136','FACTURA') valorJson
select examen_id, cums_id,* from facturacion_facturaciondetalle where facturacion_id=136
select * from rips_ripsusuarios order by id desc
	select glosa_id,"ripsTransaccion_id",* from rips_ripsprocedimientos where id in (3106,3126,3127,3129,3130)
DELETE from rips_ripsprocedimientos u 
	update rips_ripsprocedimientos set glosa_id=null where id= 3126


select * from rips_ripstransaccion where "ripsEnvio_id" = '70'
	
	select * from rips_ripsprocedimientos u
where u."ripsTransaccion_id" in (select id from rips_ripstransaccion ripstra
					where ripstra."ripsEnvio_id" = '70')
       
	
	select * from rips_ripsdetalle where "ripsEnvios_id" = 64;
	select * from rips_ripsdetalle where "numeroFactura_id" = '136'
select * from rips_ripscums;	
select * from rips_ripstransaccion

	SELECT generaFacturaJSON(70,27,'GLOSA') dato
,"cantidadAceptada", "cantidadGlosada", "cantidadSoportado", "motivoGlosa_id", "notasCreditoGlosa", "notasCreditoOtras","notasDebito","vAceptado","valorGlosado","valorSoportado"
	
SELECT tipdoc."tipoDocRips_id", tipousu.codigo, cast(u."fechaNacio" as date) , u.genero,u."ripsZonaTerritorial_id",   (select i.incapacidad from admisiones_ingresos i WHERE i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id=fac.documento_id and i.consec=fac."consecAdmision")      , row_number() OVER(ORDER BY det.id) AS consecutivo, now(), muni.id,  case when pais.id is null then '1' else pais.id end, case when pais.id is null then '1' else pais.id end, '1',u.documento, det.id, '735','A','50292'from rips_ripsenvios e
        inner join rips_ripsdetalle det on (det."ripsEnvios_id"  = e.id)  inner join  facturacion_facturacion fac on (fac.id = det."numeroFactura_id" ) inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id"  and i.documento_id = fac.documento_id  and i.consec = fac."consecAdmision") inner join usuarios_tiposdocumento tipdoc on ( tipdoc.id=i."tipoDoc_id" )  inner join usuarios_usuarios u on (u."tipoDoc_id"=i."tipoDoc_id" and u.id = i.documento_id) left join sitios_paises  pais on (pais.id= u.pais_id)  left join sitios_municipios muni on ( muni.id = u.municipio_id) left join rips_ripstipousuario tipousu on (tipousu.id = i."ripsTipoUsuario_id") where  e.id= '70' AND det.glosa_id = '27'