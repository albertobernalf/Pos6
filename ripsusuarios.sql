 SELECT tipdoc.abreviatura, tipousu.codigo, u."fechaNacio" , u.genero, local.id, 	'NO'
, row_number() OVER(ORDER BY det.id) AS consecutivo, now(), muni.id, pais.id, pais.id, '1', u.documento, det.id, '1001',
	 'A','ingreso'
	 from rips_ripsenvios e	
	 inner join rips_ripsdetalle det on (det."ripsEnvios_id"  = e.id) 
	 inner join usuarios_tiposdocumento tipdoc on (1=1) 
	 inner join usuarios_usuarios u on (1 =1 ) 
	 left join sitios_paises  pais on (pais.id= u.pais_id) 
	 left join sitios_municipios muni on ( muni.id = u.municipio_id)
	 left join  sitios_localidades local on (local.id = u.localidad_id)
	 left join  facturacion_facturacion fac on (fac.id = det."numeroFactura_id" and fac."tipoDoc_id" = u."tipoDoc_id" and fac.documento_id = u.id and fac."tipoDoc_id" = tipdoc.id ) 
	 inner join admisiones_ingresos i on (i."tipoDoc_id" = u."tipoDoc_id" and i.documento_id = u.id and i.consec = fac."consecAdmision"  )
	 left join rips_ripstipousuario tipousu on (tipousu.id = i."ripsTipoUsuario_id") 
	 where  e.id= '68' AND det."numeroFactura_id"  = '148'

select * from rips_ripstransaccion order by id desc

 SELECT tipdoc."tipoDocRips_id", tipousu.codigo, cast(u."fechaNacio" as date) , u.genero,u."ripsZonaTerritorial_id", 
	 case when incap.id is null then 'NO' else 'SI' END	 
, row_number() OVER(ORDER BY det.id) AS consecutivo, now(), muni.id, 
	 case when pais.id is null then '1' else pais.id end, case when pais.id is null then '1' else pais.id end, '1', 
	 u.documento, det.id, '1001', 'A','ingreso'
	 from rips_ripsenvios e	
	 inner join rips_ripsdetalle det on (det."ripsEnvios_id"  = e.id) 
	 inner join  facturacion_facturacion fac on (fac.id = det."numeroFactura_id" ) 
	 inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id"  and i.documento_id = fac.documento_id  and i.consec = fac."consecAdmision"  )
	 inner join usuarios_tiposdocumento tipdoc on ( tipdoc.id=i."tipoDoc_id" ) 
	 inner join usuarios_usuarios u on (u."tipoDoc_id"=i."tipoDoc_id" and u.id = i.documento_id) 
	 left join sitios_paises  pais on (pais.id= u.pais_id) 
 	 left join sitios_municipios muni on ( muni.id = u.municipio_id)
	 left join rips_ripstipousuario tipousu on (tipousu.id = i."ripsTipoUsuario_id") 
	 left join clinico_historia historia on (historia."tipoDoc_id" = i."tipoDoc_id" and historia.documento_id=i.documento_id and historia."consecAdmision" = i.consec)
	 left join clinico_historialincapacidades incap on (incap.historia_id = historia.id)
	 where  e.id= '68' AND det."numeroFactura_id"  = '148'

	 
	 detalle ='INSERT INTO rips_ripsusuarios ("tipoDocumentoIdentificacion", "tipoUsuario", "fechaNacimiento", "codSexo", "codZonaTerritorialResidencia", incapacidad, consecutivo, "fechaRegistro", "codMunicipioResidencia_id", "codPaisOrigen_id", "codPaisResidencia_id", "usuarioRegistro_id", "numDocumentoIdentificacion", "ripsDetalle_id", "ripsTransaccion_id","estadoReg", ingreso_id) SELECT tipdoc."tipoDocRips_id", tipousu.codigo, cast(u."fechaNacio" as date) , u.genero,u."ripsZonaTerritorial_id", case when incap.id is null then ' + "'" + str('NO') + "'" + ' else ' + "'" + str('SI') + "'" + '"END , row_number() OVER(ORDER BY det.id) AS consecutivo, now(), muni.id,  case when pais.id is null then ' + "'" + str('1') + "'" + ' else pais.id end, case when pais.id is null then ' + "'" + str('1') + "'" + ' else pais.id end, ' + "'" + str(username_id) + "'" + ',u.documento, det.id, ' + "'" + str(transaccionId) + "'," + "'" + str(ingresoId.id) + "'" + 'from rips_ripsenvios e	inner join rips_ripsdetalle det on (det."ripsEnvios_id"  = e.id)  inner join  facturacion_facturacion fac on (fac.id = det."numeroFactura_id" ) inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id"  and i.documento_id = fac.documento_id  and i.consec = fac."consecAdmision") inner join usuarios_tiposdocumento tipdoc on ( tipdoc.id=i."tipoDoc_id" )  inner join usuarios_usuarios u on (u."tipoDoc_id"=i."tipoDoc_id" and u.id = i.documento_id) left join sitios_paises  pais on (pais.id= u.pais_id)  left join sitios_municipios muni on ( muni.id = u.municipio_id) left join rips_ripstipousuario tipousu on (tipousu.id = i."ripsTipoUsuario_id")  left join clinico_historia historia on (historia."tipoDoc_id" = i."tipoDoc_id" and historia.documento_id=i.documento_id and historia."consecAdmision" = i.consec) left join clinico_historialincapacidades incap on (incap.historia_id = historia.id) where  e.id= ' + "'" + str(envioRipsId) + "'" + ' AND det."numeroFactura_id"  = ' + "'" + str(elemento) + "'"
	 

select * from rips_ripsusuarios order by id desc
select "ripsTipoUsuario_id",* from admisiones_ingresos where id=50360
select * from sitios_paises;
select * from sitios_municipios;
select * from rips_ripsmunicipios;
select * from rips_ripstipousuario;
select * from rips_ripspaises;
select * from sitios_sedesclinica;
select * from rips_ripstiposnotas
select * from cartera_tiposnotas;
select * from rips_ripstiposdocumento;
select * from usuarios_tiposdocumento;
select * from usuarios_usuarios;
select * from rips_ripszonaterritorial


- query para glosas

 SELECT tipdoc."tipoDocRips_id", tipousu.codigo, cast(u."fechaNacio" as date) , u.genero,u."ripsZonaTerritorial_id", 
	 case when incap.id is null then 'NO' else 'SI' END	 
, row_number() OVER(ORDER BY det.id) AS consecutivo, now(), muni.id, 
	 case when pais.id is null then '1' else pais.id end, case when pais.id is null then '1' else pais.id end, '1', 
	 u.documento, det.id, '1001', 'A','ingreso'
	 from rips_ripsenvios e	
	 inner join rips_ripsdetalle det on (det."ripsEnvios_id"  = e.id) 
	 inner join  facturacion_facturacion fac on (fac.id = det."numeroFactura_id" ) 
	 inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id"  and i.documento_id = fac.documento_id  and i.consec = fac."consecAdmision"  )
	 inner join usuarios_tiposdocumento tipdoc on ( tipdoc.id=i."tipoDoc_id" ) 
	 inner join usuarios_usuarios u on (u."tipoDoc_id"=i."tipoDoc_id" and u.id = i.documento_id) 
	 left join sitios_paises  pais on (pais.id= u.pais_id) 
 	 left join sitios_municipios muni on ( muni.id = u.municipio_id)
	 left join rips_ripstipousuario tipousu on (tipousu.id = i."ripsTipoUsuario_id") 
	 left join clinico_historia historia on (historia."tipoDoc_id" = i."tipoDoc_id" and historia.documento_id=i.documento_id and historia."consecAdmision" = i.consec)
	 left join clinico_historialincapacidades incap on (incap.historia_id = historia.id)
	 where  e.id= '68' AND det."numeroFactura_id"  = '148'


