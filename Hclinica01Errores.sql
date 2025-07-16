select * from clinico_historia;
select * from clinico_historiaexamenes;
SELECT * FROM clinico_historialdiagnosticos;
select * from facturacion_liquidacion;
select * from facturacion_liquidaciondetalle;

delete  from facturacion_liquidacion;
delete from facturacion_liquidaciondetalle;


delete  from clinico_historia;
delete from clinico_historiaexamenes;
delete FROM clinico_historialdiagnosticos;
select * from autorizaciones_autorizaciones;
select * from autorizaciones_autorizacionesdetalle;
--delete from autorizaciones_autorizaciones;
--delete from autorizaciones_autorizacionesdetalle;

INSERT INTO autorizaciones_autorizaciones ("estadoAutorizacion_id","fechaModifica", "fechaRegistro", "estadoReg",empresa_id, "plantaOrdena_id",
	"sedesClinica_id", 	"usuarioRegistro_id", historia_id ) 
	SELECT '1', now(), now(), 'A', conv.empresa_id,  '1','1','1','710'
	FROM facturacion_conveniospacienteingresos convIngreso, contratacion_convenios conv 
	WHERE conv.id = convIngreso.convenio_id AND convIngreso."tipoDoc_id" = '1' AND convIngreso.documento_id = '16'
	AND convIngreso."consecAdmision" = '1' and conv.id = 1

select * from autorizaciones_autorizaciones;
select * from contratacion_convenios;
select * from facturacion_conveniospacienteingresos;

select "requiereAutorizacion", * from clinico_examenes order by "requiereAutorizacion" desc;

select * from clinico_historialantecedentes;
SELECT * from clinico_historialinterconsultas
	select * from clinico_Historia;
select * from clinico_historialincapacidades;

select * from clinico_medicos;
select * from planta_planta;

INSERT INTO clinico_Historia ("sedesClinica_id", "tipoDoc_id" , documento_id , "consecAdmision", folio ,fecha , "tiposFolio_id" ,"causasExterna_id" ,
	"dependenciasRealizado_id" , especialidades_id ,planta_id, motivo ,
	subjetivo,objetivo, analisis ,plann, tratamiento ,                apache2,
	antibioticos, monitoreo, "movilidadLimitada", nauseas, "llenadoCapilar", neurologia, irritacion, pulsos, "retiroPuntos",
	inmovilizacion, "notaAclaratoria", "fecNotaAclaratoria", "examenFisico", "noQx", observaciones, "riesgoHemodinamico", riesgos,
	trombocitopenia, hipotension, "indiceMortalidad", "ingestaAlcohol", "inmovilizacionObservaciones", justificacion, leucopenia, "manejoQx",
	"fechaRegistro", "usuarioRegistro_id", "estadoReg" , mipres,"ordenMedicaLab","ordenMedicaRad","ordenMedicaTer","ordenMedicaMed","ordenMedicaOxi",
	"ordenMedicaInt")  
	VALUES('1','1','16','1','5','2025-04-22 12:26:39','1','1','1','2','1','21','12','12','12','21','21','21212','S','','S','S','S','','','','',
	'N','N','0001-01-01 00:00:00','','','','','','','','0','','','','','no','2025-04-22 12:26:39','1','A','21','','','','','','') RETURNING id ;

