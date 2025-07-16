select * from cirugia_cirugias;
select * from cirugia_estadosprogramacion;

select * from clinico_historiaexamenes;
select * from usuarios_usuarios;

select "tipoDoc_id", documento_id, "consecAdmision",* from cirugia_programacioncirugias where documento_id=27 and "consecAdmision" = 1;;
select "tipoDoc_id", documento_id, "consecAdmision",* from cirugia_cirugias where documento_id=27 and "consecAdmision" = 1;

select * from tarifarios_tarifariosprocedimientoshonorarios;
select * from tarifarios_tiposhonorarios;
select * from tarifarios_tipostarifa;
select * from tarifarios_tipostarifaproducto;

select * from tarifarios_tarifariosdescripcion;


select * from tarifas_gruposqx;
insert into tarifarios_gruposqx select * from  tarifas_gruposqx;


select * from clinico_examenes where "codigoCups"='07142';
select * from clinico_examenes where nombre like ('%DRENAJE%PERITO%');
select * from tarifarios_tarifariosdescripcion;
select * from tarifarios_tipostarifa;
select "codigoCups", concepto_id, "grupoQx_id","cantidadUvr",* from clinico_examenes;

select * from tarifarios_tiposhonorarios;
select * from cirugia_cirugiasprocedimientos;


SELECT * FROM CONTRATACION_CONVENIOS;
select * from cirugia_viasdeacceso;
select * from cirugia_regionesoperatorias;
select * from cirugia_cirugiasmaterialqx;
select * from cirugia_cirugiasparticipantes;
SELECT p.id id, p.nombre nombre FROM  cirugia_estadoscirugias  p


UPDATE contratacion_Convenios 
	SET nombre = 'CLINICA MEDICAL 2024 ISS 2001',"vigenciaDesde" = '2025-01-01',"vigenciaHasta" = '2025-12-31',"porcTarifario" = null,
	"porcSuministros" = null,"valorOxigeno" = null,"porcEsterilizacion" = null,"porcMaterial" = null,"hospitalario" = '',"urgencias" = '',
	"ambulatorio" = '',"consultaExterna" = '',"copago" = '',"moderadora" = '',"tipofactura" = '',"facturacionSuministros" = '',"facturacionCups" = '',
	"cuentaContable" = '',"requisitos" = '',"empresa_id" = '3',"usuarioRegistro_id" = '1',
	"tarifariosDescripcionProc_id" = 2,"tarifariosDescripcionSum_id" = null, descripcion = 'TARIFAS ISS2001',
	"tarifariosDescripcionHono_id" = 2,"serviciosAdministrativos"= 3 
	WHERE id = '6'
