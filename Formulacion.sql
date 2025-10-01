select his.id id,his.folio folio, his.fecha Fecha, hisExa."fechaToma" fechaTomado, hisExa."fechaReporte",  exa.nombre examen , hisExa.resultado resultado, hisExa.interpretacion1 interpretacion , hisExa."fechaInterpretacion1" fechaInterpretacion , est.nombre estado FROM clinico_historia his INNER JOIN clinico_historiaexamenes hisExa ON (hisExa.historia_id = his.id) INNER JOIN clinico_examenes exa ON (exa."codigoCups" = hisExa."codigoCups") LEFT JOIN clinico_historiaresultados resul ON (resul."historiaExamenes_id" = hisExa.id) LEFT JOIN clinico_estadoexamenes est ON (est.id=hisExa."estadoExamenes_id") INNER JOIN clinico_tiposexamen tip on (tip.id = hisExa."tiposExamen_id" AND  tip.nombre='RADIOLOGIA') WHERE his.documento_id = '60' AND his."tipoDoc_id" = '1' And his."consecAdmision"= '1' ORDER BY  his.folio

select historia_id,* from clinico_historiasignosvitales
select * from clinico_historia order by id desc
select * from clinico_historialenfermedades;
select * from clinico_enfermedades

select "fechaToma",resultado,* from clinico_historiaexamenes order by historia_id desc;

select "fechaToma",resultado,* from clinico_historiaexamenes order by id desc
select * from clinico_tiposexamen;
select his.id id,his.folio folio, his.fecha Fecha, hisExa."fechaToma" fechaTomado, hisExa."fechaReporte",  exa.nombre examen , hisExa.resultado resultado, hisExa.interpretacion1 interpretacion , hisExa."fechaInterpretacion1" fechaInterpretacion , est.nombre estado FROM clinico_historia his INNER JOIN clinico_historiaexamenes hisExa ON (hisExa.historia_id = his.id) INNER JOIN clinico_examenes exa ON (exa."codigoCups" = hisExa."codigoCups") LEFT JOIN clinico_historiaresultados resul ON (resul."historiaExamenes_id" = hisExa.id) LEFT JOIN clinico_estadoexamenes est ON (est.id=hisExa."estadoExamenes_id") INNER JOIN clinico_tiposexamen tip on (tip.id = hisExa."tiposExamen_id" AND  tip.nombre='RADIOLOGIA') WHERE his.documento_id = '60' AND his."tipoDoc_id" = '1' And his."consecAdmision"= '1' ORDER BY  his.folio desc
select * from clinico_historialNotasenfermeria;
select * from clinico_historialantecedentes;
select * from clinico_tiposantecedente;
select * from clinico_unidadesdemedidadosis;

select * from clinico_historiaMedicamentos;
select * from clinico_frecuenciasaplicacion

	 
select * from enfermeria_enfermeriaplaneacion; -- enfermeriarecibe_id, enfermeria_id
select * from enfermeria_enfermeriarecibe; -- enfermeriadetalle_id
select * from enfermeria_enfermeriadetalle; -- historiamedicamentos_id



select his.id id,his.folio folio, his.fecha fechaRegistro, hisMed."dosisCantidad" ,dosis.descripcion,
	sum.nombre, frec.descripcion frec, via.nombre, hisMed."cantidadOrdenada",  hisMed."diasTratamiento"
FROM clinico_historia his
INNER JOIN clinico_historiaMedicamentos hisMed ON (hisMed.historia_id = his.id) 
LEFT JOIN clinico_viasadministracion via on (via.id = hisMed."viaAdministracion_id") 	
INNER JOIN facturacion_suministros sum on (sum.id =hisMed.suministro_id)	
LEFT JOIN clinico_frecuenciasaplicacion frec on (frec.id = hisMed.frecuencia_id)
LEFT JOIN clinico_unidadesdemedidadosis dosis on (dosis.id=hisMed."dosisUnidad_id")
WHERE his.documento_id = '60' AND his."tipoDoc_id" = '1' And his."consecAdmision"= '1'
	order by his.folio desc
-- aqui con planeacion
   
	
select enfPla.ID ,enfPla."consecutivoPlaneacion",  enfPla."fechaPlanea", enfPla."fechaAplica", enfPla."cantidadAplicada",his.id id,his.folio folio, his.fecha fechaRegistro, hisMed."dosisCantidad" ,dosis.descripcion,
	sum.nombre, frec.descripcion frec, via.nombre, hisMed."cantidadOrdenada",  hisMed."diasTratamiento"

select his.id id,his.folio folio, his.fecha fechaRegistro, hisMed."dosisCantidad"||' '||dosis.descripcion||' '||
	sum.nombre||' '||frec.descripcion||' '||via.nombre||' cantidad: '||hisMed."cantidadOrdenada"||' dias:'||hisMed."diasTratamiento" formulado,
	'SuministroAplicado',
	enfPla."consecutivoPlaneacion",  enfPla."fechaPlanea", enfPla."fechaAplica", enfPla."cantidadAplicada"
	FROM clinico_historia his
INNER JOIN clinico_historiaMedicamentos hisMed ON (hisMed.historia_id = his.id) 
LEFT JOIN clinico_viasadministracion via on (via.id = hisMed."viaAdministracion_id") 	
INNER JOIN facturacion_suministros sum on (sum.id =hisMed.suministro_id)	
LEFT JOIN clinico_frecuenciasaplicacion frec on (frec.id = hisMed.frecuencia_id)
LEFT JOIN clinico_unidadesdemedidadosis dosis on (dosis.id=hisMed."dosisUnidad_id")
INNER JOIN 	enfermeria_enfermeriadetalle enfDet ON (enfDet."historiaMedicamentos_id" = hisMed.id)
INNER JOIN 	enfermeria_enfermeriarecibe enfRec ON (enfRec."enfermeriaDetalle_id" = enfDet.id)
INNER JOIN 	enfermeria_enfermeriaplaneacion enfPla ON (enfPla."enfermeriaRecibe_id" = enfRec.id)
WHERE his.documento_id = '60' AND his."tipoDoc_id" = '1' And his."consecAdmision"= '1'
order by his.folio desc, enfPla."consecutivoPlaneacion" asc


select * from clinico_historialinterconsultas;
select * from clinico_tiposinterconsulta;
select * from planta_planta;
select * from clinico_medicos;

select * from clinico_historiasignosvitales;

select examen_id,cums_id,* from facturacion_liquidaciondetalle;
select * from clinico_examenes where id=572

select liq.id id,consecutivo ,    liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia_id cirugia ,  
	liq.observaciones ,  "estadoRegistro" ,  examen_id ,  cums_id , exa.nombre  nombreExamen  ,  liquidacion_id , 
	liq."tipoHonorario_id" ,  "tipoRegistro" 
	FROM facturacion_liquidaciondetalle liq 
	inner join clinico_examenes exa on (exa.id = liq.examen_id)  
	where liq.id= 1468
	UNION
	select liq.id id,consecutivo , liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia_id cirugia , 
	liq.observaciones ,  "estadoRegistro" ,  examen_id ,  cums_id , sum.nombre  nombreExamen  ,  liquidacion_id ,
	liq."tipoHonorario_id" ,  "tipoRegistro" 
	FROM facturacion_liquidaciondetalle liq 
	inner join facturacion_suministros sum on (sum.id = liq.cums_id) 
	where liq.id= '1468'



	select liq.id id,consecutivo ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia_id cirugia ,    liq.observaciones ,  "estadoRegistro" ,  examen_id ,  cums_id , exa.nombre  nombreExamen  ,  liquidacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro"  FROM facturacion_liquidaciondetalle liq inner join clinico_examenes exa on (exa.id = liq.examen_id)  where liq.id= 1468 UNION select liq.id id,consecutivo , liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia_id cirugia ,   liq.observaciones ,  "estadoRegistro" ,  "examen_id" ,  cums_id , sum.nombre  nombreExamen  ,  liquidacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro"  FROM facturacion_liquidaciondetalle liq inner join facturacion_suministros sum on (sum.id = liq.cums_id)  where liq.id= 1468


select liq.id id,consecutivo ,  fecha::timestamp fecha  ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia_id cirugia ,  "fechaCrea"::timestamp fechaCrea , liq.observaciones ,  "estadoRegistro" ,  "examen_id" ,  cums_id , exa.nombre  nombreExamen  ,  liquidacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro"  FROM facturacion_liquidaciondetalle liq left join clinico_examenes exa on (exa.id = liq."examen_id")  where liq.liquidacion_id= 1468 UNION select liq.id id,consecutivo , fecha::timestamp fecha  ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia_id cirugia ,  "fechaCrea"::timestamp  fechaCrea , liq.observaciones ,  "estadoRegistro" ,  "examen_id" ,  cums_id , sum.nombre  nombreExamen  ,  liquidacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro"  FROM facturacion_liquidaciondetalle liq left join facturacion_suministros sum on (sum.id = liq.cums_id)  where liq.id= 1468
