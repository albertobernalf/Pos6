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


SELECT * FROM RIPS_RIPSTRANSACCION order by id desc
	select * from rips_ripsusuarios where "ripsTransaccion_id" =440

select generafacturajson(68,148,'FACTURA')
	select generafacturajson(68,142,'FACTURA')

	
select * from rips_ripsprocedimientos;	
select * from rips_RipsGrupoServicios;
select * from rips_ripsviasingresosalud
	select * from rips_ripsservicios
select * from rips_ripsfinalidadconsulta
	select * from rips_RipsConceptoRecaudo
	

	select * from cartera_formaspagos;
select "codigoCups",* from clinico_examenes order by "codigoCups" -- where "codigoCups" = '010100'	

select * from rips_ripsusuarios order by id desc	
select * from rips_ripsusuarios where "ripsTransaccion_id" = 446 order by id desc	
select * from rips_ripstransaccion order by id desc	
	select * from rips_ripsdetalle where "ripsEnvios_id" =68
	select * from facturacion_facturacion where id=142

select * from rips_ripsmunicipios;
SELECT * FROM RIPS_RIPSPROCEDIMIENTOS;
select * from rips_ripsurgenciasobservacion
select * from admisiones_ingresos where factura in (138)
select * from sitios_dependencias where id in (37)
select * from facturacion_facturaciondetalle where facturacion_id = 138
	
	
	select * from rips_ripshospitalizacion where "ripsTransaccion_id" = 488
	select * from rips_ripshospitalizacion where "ripsTransaccion_id" = 487
	

SELECT * FROM cartera_tiposnotas;
select * from rips_ripstransaccion order by id desc
select * from rips_ripsdetalle where "ripsEnvios_id"= 63
	SELECT * FROM RIPS_RIPSENVIOS WHERE ID = 63
SELECT * FROM rips_ripsurgenciasobservacion


	SELECT sed."codigoHabilitacion", cast(i."fechaIngreso" as date) ,cast(i."fechaSalida" as date),
	row_number() OVER(ORDER BY i.id) AS consecutivo  ,now() ,i."ripsCausaMotivoAtencion_id", 
	(select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxComplicacion_id"), 
	(select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxIngreso_id"), 
	(select diag1.id from clinico_diagnosticos diag1 where  diag1.id = i."dxSalida_id"), 
	(select max(diag1.id)  from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1 , clinico_historia his where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '2' and histdiag1.diagnosticos_id = diag1.id and his."tipoDoc_id" = fac."tipoDoc_id" and his.documento_id = fac.documento_id AND his."consecAdmision" = fac."consecAdmision") , 
	(select max(diag1.id)  from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1, clinico_historia his  where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '3'  and histdiag1.diagnosticos_id = diag1.id  and his."tipoDoc_id" = fac."tipoDoc_id" and his.documento_id = fac.documento_id AND his."consecAdmision" =fac."consecAdmision"),
	(select max(diag1.id) from clinico_historialdiagnosticos histdiag1, clinico_diagnosticos diag1, clinico_historia his where histdiag1.historia_id = his.id and histdiag1."tiposDiagnostico_id" = '4' and histdiag1.diagnosticos_id = diag1.id  and his."tipoDoc_id" = fac."tipoDoc_id" and his.documento_id = fac.documento_id AND his."consecAdmision" =fac."consecAdmision" )
	,i."ripsCondicionDestinoUsuarioEgreso_id", '1' ,det.id,env."ripsEstados_id", 
	ripstra.id, 'A', '1002'
	FROM sitios_sedesclinica sed 
	inner join facturacion_facturacion fac ON (fac."sedesClinica_id" = sed.id)
	inner join admisiones_ingresos i ON (i."sedesClinica_id" = sed.id and i."tipoDoc_id" =fac."tipoDoc_id" and i.documento_id = fac.documento_id AND i.consec =fac."consecAdmision")
	inner join rips_ripsenvios env ON (env."sedesClinica_id" = sed.id) inner join rips_ripsdetalle det ON ( det."ripsEnvios_id" = env.id and  det."ripsEnvios_id" = fac."ripsEnvio_id" and det."numeroFactura_id" = fac.id )
	inner join rips_ripstransaccion ripstra ON ( ripstra."sedesClinica_id" = sed.id and ripstra."ripsEnvio_id" = env.id and ripstra."numFactura" = cast(fac.id as text)) 
	left join autorizaciones_autorizaciones aut  on (aut.id = i.autorizaciones_id)  
	inner join 	clinico_servicios serv on (serv.nombre = 'URGENCIAS')
	inner join 	sitios_dependencias dep on (dep.id = i."dependenciasSalida_id" ) 
	inner join 	sitios_serviciossedes servsedes on (servsedes.id = dep."serviciosSedes_id" and servsedes.servicios_id= serv.id) 
	where sed.id = '1' AND env.id = '63' and fac.id = 138
