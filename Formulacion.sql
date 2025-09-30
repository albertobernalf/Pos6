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

 

		
select his.id id,his.folio folio, his.fecha fechaRegistro, hisMed."dosisCantidad"||' '||dosis.descripcion||' '||
	sum.nombre||' '||frec.descripcion||' '||via.nombre||' '||hisMed."cantidadOrdenada",  hisMed."diasTratamiento"
	
select * from enfermeria_enfermeriaplaneacion; -- enfermeriarecibe_id, enfermeria_id
select * from enfermeria_enfermeriarecibe; -- enfermeriadetalle_id
select * from enfermeria_enfermeriadetalle; -- historiamedicamentos_id
	
	
	
	WHERE his.documento_id = ' + "'" + str(
        documentoId.id) + "'" + ' AND his."tipoDoc_id" = ' + "'" + str(
        tipodocId.id) + "'" + ' And his."consecAdmision"= ' + "'" + str(consec) + "' ORDER BY  his.folio desc"
