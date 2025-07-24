select * from enfermeria_enfermeriarecibe;

select * from enfermeria_enfermeriadetalle;

SELECT recibe.id id, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, hist.folio folio,
	fardet."consecutivoMedicamento" consecutivoMedicamento, recibe."dosisCantidad" dosis, recibe."cantidadDispensada" cantidad,
	medida.descripcion UnidadMedida, sum.nombre medicamento, via.nombre via , frec.descripcion frecuencia,
	enfdet."diasTratamiento"
FROM admisiones_ingresos ing
INNER JOIN clinico_historia hist ON (hist."tipoDoc_id" = ing."tipoDoc_id" AND hist.documento_id=ing.documento_id AND hist."consecAdmision" = ing.consec) 
INNER JOIN farmacia_farmacia far ON (far.historia_id= hist.id)
INNER JOIN farmacia_farmaciadetalle fardet ON (fardet.farmacia_id = far.id)
INNER JOIN	enfermeria_enfermeriarecibe recibe ON (recibe."farmaciaDetalle_id" = fardet.id)
INNER JOIN	enfermeria_enfermeriadetalle enfdet ON (enfdet.id = recibe."enfermeriaDetalle_id")
INNER JOIN facturacion_suministros sum ON (sum.id = recibe.suministro_id) 
INNER JOIN clinico_viasadministracion via ON (via.id = recibe."viaAdministracion_id")
INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = recibe."dosisUnidad_id") 
LEFT JOIN clinico_frecuenciasaplicacion frec ON (frec.id = enfdet."frecuencia_id") 
INNER JOIN usuarios_usuarios usu ON (usu.id = ing.documento_id) 
INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = usu."tipoDoc_id")
--WHERE ing.id='50133'
	
UNION
	SELECT recibe.id id, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, 0 folio, 
	fardet."consecutivoMedicamento" consecutivoMedicamento,recibe."dosisCantidad" dosis, recibe."cantidadDispensada" cantidad, 	 
	medida.descripcion UnidadMedida, sum.nombre medicamento, via.nombre via , frec.descripcion frecuencia,
	enfdet."diasTratamiento"  
FROM admisiones_ingresos ing 
INNER JOIN farmacia_farmacia far ON (far."ingresoPaciente_id"= ing.id)
INNER JOIN farmacia_farmaciadetalle fardet ON (fardet.farmacia_id = far.id) 
INNER JOIN enfermeria_enfermeriarecibe recibe ON (recibe."farmaciaDetalle_id" = fardet.id) 
INNER JOIN	enfermeria_enfermeriadetalle enfdet ON (enfdet.id = recibe."enfermeriaDetalle_id")  
INNER JOIN facturacion_suministros sum ON (sum.id = recibe.suministro_id) 
INNER JOIN clinico_viasadministracion via ON (via.id = recibe."viaAdministracion_id") 
INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = recibe."dosisUnidad_id")
LEFT JOIN clinico_frecuenciasaplicacion frec ON (frec.id = enfdet."frecuencia_id") 
INNER JOIN usuarios_usuarios usu ON (usu.id = ing.documento_id) 
INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = usu."tipoDoc_id")	
WHERE ing.id='50133' 
	ORDER BY 5,6

select * from clinico_unidadesdemedidadosis;
select  * from clinico_viasadministracion;
select * from enfermeria_enfermeriaplaneacion;

delete from enfermeria_enfermeriaplaneacion;
	select * from farmacia_farmaciadetalle where id=18;
		select * from farmacia_farmacia where id = 24;

select * from enfermeria_enfermeriadetalle where id=15
select * from enfermeria_enfermeriarecibe;

select * from enfermeria_enfermeriarecibe;

select * from enfermeria_enfermeria;
select * from enfermeria_enfermeriadetalle where enfermeria_id>=12;

select * from enfermeria_enfermeriaplaneacion order by suministro_id;

select pla.id id, pla."fechaPlanea" fechaPlanea, tipos1.nombre turnoPlanea, planta1.nombre enfermeraPlanea, 
	pla."cantidadPlaneada" cantidadPlaneada,    pla."fechaAplica" fechaAplica, tipos2.nombre turnoAplica,
	planta2.nombre enfermeraAplica,   pla."cantidadAplicada" cantidadAplicada,
         pla."dosisCantidad" dosis, medida.descripcion medida, sum.nombre suministro, vias.nombre via,
	frec.descripcion frecuencia,    pla."diasTratamiento" dias
FROM enfermeria_enfermeriaplaneacion pla 
INNER JOIN enfermeria_enfermeria enf ON (enf.id=pla.enfermeria_id) 
	LEFT JOIN planta_planta planta1 ON (planta1.id = pla."enfermeraPlanea_id")
	LEFT JOIN planta_planta planta2 ON (planta2.id = pla."enfermeraAplica_id")
	INNER JOIN clinico_viasadministracion vias ON (vias.id = pla."viaAdministracion_id")
	INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = pla."dosisUnidad_id")
	INNER JOIN clinico_frecuenciasaplicacion frec ON (frec.id = pla.frecuencia_id) 
	INNER JOIN facturacion_suministros sum        ON (sum.id = pla.suministro_id)
	LEFT JOIN enfermeria_tiposturnosenfermeria tipos1 ON ( tipos1.id = pla."turnoEnfermeriaPlanea_id")
	LEFT JOIN enfermeria_tiposturnosenfermeria tipos2 ON ( tipos2.id = pla."turnoEnfermeriaAplica_id")	
	WHERE enf."sedesClinica_id" = '1' AND enf."ingresoPaciente_id" = '50133'

SELECT * FROM FACTURACION_SUMINISTROS WHEre nombre like ('%VANCOCI%') -- 9210 -- 9443

UPDATE FACTURACION_SUMINISTROS SET NOMBRE='VANCOCIN  CP no INYECTABLE' WHERE id = 9493;

update enfermeria_enfermeria set "ingresoPaciente_id" = 50133 where id=8;
select * from enfermeria_enfermeriaplaneacion;

select * from enfermeria_enfermeriarecibe where id=33
update enfermeria_enfermeriaplaneacion set "enfermeriaRecibe_id" = 33 where  id<= 28;
update enfermeria_enfermeriaplaneacion set "enfermeriaRecibe_id" =9 where  id >= 29;

select * from facturacion_suministros where nombre like ('%VANCO%');
select * from facturacion_suministros where ID = 1823;
SELECT * FROM ENFERMERIA_ENFERMERIADETALLE
	update enfermeria_enfermeria set "ingresoPaciente_id" = 50133 where id=4;

UPDATE facturacion_suministros SET nombre = 'VANCOMICINA 500 MG INYECTABLE INTRAVENOSO UnI' where id=6835;

select * from enfermeria_enfermeriaplaneacion;
 
select pla.id id, pla."fechaPlanea" fechaPlanea, tipos1.nombre turnoPlanea, planta1.nombre enfermeraPlanea, 
	pla."cantidadPlaneada" cantidadPlaneada,    pla."fechaAplica" fechaAplica, tipos2.nombre turnoAplica,
	planta2.nombre enfermeraAplica,   pla."cantidadAplicada" cantidadAplicada,
         pla."dosisCantidad" dosis, medida.descripcion medida, sum.nombre suministro, vias.nombre via, 
	frec.descripcion frecuencia,    pla."diasTratamiento" dias
	FROM enfermeria_enfermeriaplaneacion pla 
	INNER JOIN enfermeria_enfermeria enf ON (enf.id=pla.enfermeria_id) 
	LEFT JOIN planta_planta planta1 ON (planta1.id = pla."enfermeraPlanea_id") 
	LEFT JOIN planta_planta planta2 ON (planta2.id = pla."enfermeraAplica_id") 
	INNER JOIN clinico_viasadministracion vias ON (vias.id = pla."viaAdministracion_id")
	INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = pla."dosisUnidad_id")
	INNER JOIN clinico_frecuenciasaplicacion frec ON (frec.id = pla.frecuencia_id) 
	INNER JOIN facturacion_suministros sum    ON (sum.id = pla.suministro_id) 
	LEFT JOIN enfermeria_tiposturnosenfermeria tipos1 ON ( tipos1.id = pla."turnoEnfermeriaPlanea_id")
	LEFT JOIN enfermeria_tiposturnosenfermeria tipos2 ON ( tipos2.id = pla."turnoEnfermeriaAplica_id") 
	WHERE enf."sedesClinica_id" = '1' AND enf."ingresoPaciente_id" = '50133' AND pla."enfermeriaRecibe_id" = '7'

-- ojop cuando fui a aplicar medicamento no tenia el enfermeriaRecibe para cargar el load_dataplaneacionEnfermeria