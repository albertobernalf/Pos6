select * from rips_ripsmedicamentos
select * from rips_ripsenvios;
 
SELECT * FROM RIPS_RIPSESTADOS;
select * from cartera_pagosfacturas;
delete from cartera_pagosfacturas where id in (58,59,60,61,62);
select * from cartera_pagos;
select * from cartera_caja;

select generaenvioripsjson(64,'FACTURA')
	select generafacturajson(64,137,'FACTURA')
	select generafacturajson(64,136,'FACTURA')

select "tipoDoc_id",* from usuarios_usuarios order by id desc;

select * from facturacion_facturaciondetalle where facturacion_id=136
	select "ripsUnidadUpr_id","unidadMedida_id", * from facturacion_suministros where id=27620

	update facturacion_suministros
	set  "ripsUnidadUpr_id" = null
	where id=27620
select * from rips_ripsumm

	select * from rips_ripsunidadupr

select * from admisiones_ingresos where documento_id=57 -- 510777

select * from facturacion_conveniospacienteingresos where documento_id=57;
select * from facturacion_liquidacion where documento_id=57;
select * from cartera_Pagos order by id desc

update facturacion_liquidacion set "valorApagar"  = 69000, anticipos=36000, "totalCopagos" = 0, "totalCuotaModeradora" = 0,"totalRecibido" = 36000  where documento_id=57;
select * from rips_RIPSTRANSACCION ORDER BY ID DESC
	select * from rips_ripsusuarios where "ripsTransaccion_id"=404
select * from rips_ripshospitalizacion where "ripsTransaccion_id"=404	
select * from rips_ripsurgenciasobservacion where "ripsTransaccion_id"=404
select * from rips_ripsmedicamentos where "ripsTransaccion_id">=407
		select substring(cast("fechaDispensAdmon" as text),1,16) ,* from rips_ripsmedicamentos where "ripsTransaccion_id">=407

select * from rips_ripstransaccion order by id desc
select * from rips_ripsprocedimientos order by id desc
select * from rips_ripsmedicamentos order by id desc


	 
 SELECT tipdoc."tipoDocRips_id", tipousu.codigo, cast(u."fechaNacio" as date) , u.genero,u."ripsZonaTerritorial_id",   (select i.incapacidad from admisiones_ingresos i WHERE i."tipoDoc_id" = fac."tipoDoc_id" and i.documento_id=fac.documento_id and i.consec=fac."consecAdmision")      , row_number() OVER(ORDER BY det.id) AS consecutivo, now(), muni.id,  case when pais.id is null then '1' else pais.id end, case when pais.id is null then '1' else pais.id end, '1',u.documento, det.id, '615','A','50292'from rips_ripsenvios e       inner join rips_ripsdetalle det on (det."ripsEnvios_id"  = e.id)  inner join  facturacion_facturacion fac on (fac.id = det."numeroFactura_id" ) inner join admisiones_ingresos i on (i."tipoDoc_id" = fac."tipoDoc_id"  and i.documento_id = fac.documento_id  and i.consec = fac."consecAdmision") inner join usuarios_tiposdocumento tipdoc on ( tipdoc.id=i."tipoDoc_id" )  inner join usuarios_usuarios u on (u."tipoDoc_id"=i."tipoDoc_id" and u.id = i.documento_id) left join sitios_paises  pais on (pais.id= u.pais_id)  left join sitios_municipios muni on ( muni.id = u.municipio_id) left join rips_ripstipousuario tipousu on (tipousu.id = i."ripsTipoUsuario_id") where  e.id= '64' AND det."numeroFactura_id"  = '137'

	SELECT sed."codigoHabilitacion", aut."numeroAutorizacion", historia.mipres, facdet.fecha , null, histmed."concentracionMedicamento",
	histmed."cantidadOrdenada", histmed."diasTratamiento",planta.documento, facdet."valorUnitario", facdet."valorTotal", 0,  
	fac.id, row_number() OVER(ORDER BY histmed.id), now(), diag1.id, diag2.id, ripscums.id, 
	(select min(ripsRecaudo.id)
	FROM cartera_pagos pagos 
	INNER JOIN cartera_formaspagos carteraFormasPago ON (carteraFormasPago.id =pagos."formaPago_id" )
	INNER JOIN rips_ripsconceptorecaudo ripsRecaudo ON (ripsRecaudo.id = cast(carteraFormasPago."codigoRips" as integer)) 
	WHERE pagos.documento_id=fac.documento_id and pagos."tipoDoc_id" = fac."tipoDoc_id" and pagos.consec=fac."consecAdmision") recaudo,
	ripsfarma.id, ripstipdoc.id, tipmed.id, ripsumm.id, ripsupr.id, '1' , det.id, facdet."consecutivoFactura",'8' ,
	rips_ripstransaccion.id , 'A','50292'  
	from rips_ripstransaccion 
	inner join rips_ripsenvios env on(env."sedesClinica_id" = rips_ripstransaccion."sedesClinica_id" and env.id = rips_ripstransaccion."ripsEnvio_id" )
	inner join sitios_sedesclinica sed on (sed.id = env."sedesClinica_id" ) 
	inner join rips_ripsdetalle det on (det."ripsEnvios_id" = env.id and det."numeroFactura_id" = cast(rips_ripstransaccion."numFactura" as numeric)) 
	inner join facturacion_facturacion fac on (fac.id = det."numeroFactura_id" ) 
	inner join facturacion_facturaciondetalle facdet on (facdet."facturacion_id" = fac.id and facdet."cums_id" is not null and (facdet.anulado = 'N' or facdet.anulado = 'R')  AND facDet."tipoRegistro" = 'SISTEMA' )
	inner join clinico_historiamedicamentos histmed on (histmed.id = facdet."historiaMedicamento_id")
	left join autorizaciones_autorizacionesDetalle  aut on (aut.id = histmed.autorizacion_id) 
	inner join facturacion_suministros sum on (sum.id = facdet.cums_id)
	left join rips_ripstipomedicamento tipmed on (tipmed.id = sum."ripsTipoMedicamento_id" ) 
	inner join rips_ripscums ripscums  on (ripscums.cum = sum."cums") 
	left join rips_ripsumm ripsumm on (ripsumm.id = sum."ripsUnidadMedida_id")
	left join rips_RipsFormaFarmaceutica ripsfarma on (ripsfarma.id = sum."ripsFormaFarmaceutica_id")  
	left join rips_ripsunidadupr ripsupr on (ripsupr.id = sum."ripsUnidadUpr_id")
	inner join clinico_historia historia on (historia.id = histmed.historia_id) 
	inner join planta_planta planta on (planta.id = historia."usuarioRegistro_id") 
	left join usuarios_tiposdocumento usutipdoc on (usutipdoc.id = planta."tipoDoc_id") 
	left join rips_ripstiposdocumento ripstipdoc on (ripstipdoc.id = usutipdoc."tipoDocRips_id") 
	left join clinico_historialdiagnosticos histdiag1 on (histdiag1.historia_id = historia.id and histdiag1."tiposDiagnostico_id" = '1') left join clinico_historialdiagnosticos histdiag2 on (histdiag2.historia_id = historia.id and histdiag2."tiposDiagnostico_id" = '2') left join clinico_diagnosticos diag1 on (diag1.id = histdiag1.diagnosticos_id) left join clinico_diagnosticos diag2 on (diag2.id = histdiag2.diagnosticos_id) 
	where env.id =  '64' and rips_ripstransaccion."ripsEnvio_id" = env.id  and cast(rips_ripstransaccion."numFactura" as numeric) = fac.id  and fac.id = '137'

	
	SELECT * FROM rips_ripsusuarios;
SELECT * FROM FACTURACION_FACTURACIONDETALLE WHERE FACTURACION_ID=137
