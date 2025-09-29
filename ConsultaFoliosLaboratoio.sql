select * from clinico_historiaoxigeno;
select * from clinico_tipooxigenacion

	SELECT "fecNotaAclaratoria","notaAclaratoria",* FROM CLINICO_HISTORIA;

select * from clinico_enfermedades;
select anulado,convenio_id,* from facturacion_facturacion;
SELECT distinct con.id, con.nombre nombreConcepto from facturacion_conceptos con INNER JOIN          clinico_examenes exa ON (exa.concepto_id = con.id) where exa.id in (select facdet.examen_id from facturacion_facturaciondetalle facdet where facdet.facturacion_id = '107') union SELECT distinct con.id, con.nombre nombreConcepto from facturacion_conceptos con INNER JOIN facturacion_suministros sum ON (sum.concepto_id = con.id) where sum.id in (select facdet.cums_id from facturacion_facturaciondetalle facdet where facdet.facturacion_id = '107') order by 1 desc

select sum.cums cups,tarSum."codigoHomologado" homologado, sum.nombre  descripcion, detFac.cantidad cantidad, 
	detFac."valorUnitario" valorUnitario, detFac."valorTotal" valorTotal 
	FROM facturacion_facturaciondetalle detFac 
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN facturacion_suministros sum on (sum.id=detFac.cums_id) 
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	LEFT JOIN tarifarios_tarifariosdescripcion tarDesc ON (tarDesc.id=conv."tarifariosDescripcionSum_id") 
	LEFT JOIN tarifarios_tarifariossuministros tarSum ON (tarSum."tiposTarifa_id"=tarDesc."tiposTarifa_id" AND
	tarSum.id = detFac.cums_id )
	where detfac.facturacion_id= '107' AND sum.concepto_id = '6'


select * from tarifarios_tarifariosdescripcion where id=
select * from contratacion_convenios;
select convenio_id,* from facturacion_facturacion where id=107
select* from facturacion_facturaciondetalle where facturacion_id=107
select * from facturacion_suministros where id=29869

select * from autorizaciones_estadosautorizacion;
select * from autorizaciones_autorizacionesdetalle;
select * from clinico_enfermedades;
select * from clinico_historialenfermedades;
select *  from triage_triage;
select * from facturacion_refacturacion;
select * from clinico_historiaresultados;
select * from clinico_historiaexamenes;
select documento_id,* from clinico_historia;
select * from clinico_estadoexamenes;
select * from clinico_tiposexamen;


select his.fecha Fecha, hisExa."fechaToma" fechaTomado, hisExa."fechReporte",  exa.nombre ,
	 hisExa.interpretacion1, hisExa."fechInterpretacion1", est.nombre estado
FROM clinico_historia his
INNER JOIN clinico_historiaexamenes hisExa ON (hisExa.historia_id = his.id)
INNER JOIN clinico_examenes exa ON (exa."codigoCups" = hisExa."codigoCups")
LEFT JOIN clinico_historiaresultados resul ON (resul."historiaExamenes_id" = hisExa.id)
LEFT JOIN clinico_estadoexamenes est ON 8est.id=histExa."estadoExamenes_id"
INNER JOIN 	clinico_tiposexamen TIP on (tip.id = hisExa."tiposExamen_id")
WHERE his.documento_id = 60  AND his."tipoDoc_id" = '1'   And his."consecAdmision=" 1

