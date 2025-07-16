select convenio_id,* from facturacion_liquidacion;
select convenio_id,* from facturacion_liquidacion where documento_id=16;
select * from facturacion_liquidacionDetalle where liquidacion_id= 143;
select * from facturacion_liquidacionDetalle where liquidacion_id= 138;

update facturacion_liquidacionDetalle set "estadoRegistro"= 'A' where liquidacion_id= 138;
select * from facturacion_liquidacionDetalle;
select * from usuarios_usuarios;
select * from usuarios_tiposdocumento
update facturacion_liquidacion
set "sedesClinica_id" = 1

select * from facturacion_liquidacionDetalle where liquidacion_id=141;
select dependencias_id, documento_id,* from triage_triage;

select * from sitios_dependencias;
select documento_id,* from admisiones_ingresos;
select documento_id,* from triage_triage;

select * from contratacion_convenios;

select * from cartera_pagos;
select * from tarifarios_tarifariosdescripcion;
select * from contratacion_convenios;

SELECT descrip.columna columnaProced 
FROM facturacion_liquidacion liq,contratacion_convenios conv,tarifarios_tarifariosdescripcion descrip 
where liq.id =      '143' AND liq.convenio_id = conv.id and descrip.id = conv."tarifariosDescripcionProc_id"

select * from sitios_dependencias;
select * from sitios_historialdependencias;

select documento_id,* from admisiones_ingresos;

select * from planta_planta;
select * from facturacion_empresas;

SELECT * FROM rips_ripsenvios;
select * from rips_ripstiposnotas;
select * from planta_planta;
select * from sitios_sedesclinica
	select * from rips_ripsestados;
SELECT * FROM rips_ripsdetalle;

/*
		data: {'tipoDoc':tipoDoc,
		       'documento':documento,
               'nombre':nombre,
               'genero':genero,
               'fechaNacio':fechaNacio,
		       'estadoCivil' : estadoCivil,
		       'departamentos':departamentos,
               'ciudades':ciudades,
               'direccion':direccion,
         	   'telefono':telefono,
     		   'contacto':contacto,
		       "centrosC":centrosC,
		       'tiposUsuario':tiposUsuario,
		       'municipios':municipios,
		       'localidades':localidades,
		       'estadoCivil':estadoCivil, 
		       'ocupaciones':ocupaciones, 
		       'correo':correo},*/


select * from facturacion_facturaciondetalle where facturacion_id=58;
select * from usuarios_usuarios;
select "sedesClinica_id",* from facturacion_facturacion; -- 56 factura camila ENVIO 50/ 58 factura lucho ENVIO 52

select * from rips_ripstransaccion; -- id 169 cami/ id 170 lucho
select "ripsTransaccion_id", * from rips_ripsmedicamentos; -- lucho

INSERT INTO rips_ripsmedicamentos ("codPrestador", "numAutorizacion", "idMIPRES", "fechaDispensAdmon", "nomTecnologiaSalud", "concentracionMedicamento",
	"cantidadMedicamento", 	"diasTratamiento",	"numDocumentoIdentificacion", "vrUnitMedicamento", "vrServicio", "valorPagoModerador", "numFEVPagoModerador",
	consecutivo, "fechaRegistro", "codDiagnosticoPrincipal_id", "codDiagnosticoRelacionado_id", "codTecnologiaSalud_id", "conceptoRecaudo_id", 
	"formaFarmaceutica_id", "tipoDocumentoIdentificacion_id", "tipoMedicamento_id", "unidadMedida_id", "unidadMinDispensa_id", "usuarioRegistro_id",
	"ripsDetalle_id", "itemFactura","ripsTipos_id", "ripsTransaccion_id") 

	select * from usuarios_usuarios;

select "sedesClinica_id",documento_id,*  from admisiones_ingresos where documento_id=27;

SELECT  t.id, tp.nombre tipoDoc,  u.documento documento, u.nombre  nombre , t.consec consec , dep.nombre camaNombre,t."fechaSolicita" solicita,t.motivo motivo, t."clasificacionTriage_id" triage FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  ,sitios_serviciosSedes sd, clinico_servicios ser  WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND t."sedesClinica_id" ='2' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and t."tipoDoc_id" = u."tipoDoc_id" and  u.id = t."documento_id"  and ser.id = sd.servicios_id and dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and dep."documento_id" = t."documento_id" and ser.nombre = 'TRIAGE'

select "sedesClinica_id",documento_id,* from triage_triage where documento_id=27;
select "sedesClinica_id",documento_id,* from facturacion_liquidacion where documento_id=26;
delete from facturacion_liquidacion where id = 152

	--delete from facturacion_liquidacion where documento_id=26;
select * from cartera_pagos where documento_id=26;

	--delete from cartera_pagos where documento_id=26;

select * from admisiones_ingresos;
select "sedesClinica_id", documento_id, convenio_id,* from facturacion_liquidacion;

select "sedesClinica_id",* from autorizaciones_autorizaciones;

select "sedesClinica_id",documento_id,* from clinico_historia;

select * from rips_ripstransaccion;
select * from rips_ripsusuarios;

select * from sitios_sedesclinica;
select * from sitios_serviciossedes;
select * from sitios_subserviciossedes;

select * from sitios_dependencias;

-- Query Censo 

select sed.nombre sede, serv.nombre servicio, subserv.nombre subservicio, dep.nombre nombre, tp.nombre tipoDoc ,
	u.documento documento,  u.nombre paciente, dep."fechaOcupacion" ocupa,  dep.disponibilidad accion
FROM sitios_dependencias dep, usuarios_usuarios u, usuarios_tiposdocumento tp,sitios_sedesclinica sed,
		sitios_serviciossedes serv, sitios_subserviciossedes subserv
WHERE dep."sedesClinica_id"  = 2 AND sed.id=dep."sedesClinica_id" AND sed.id = serv."sedesClinica_id" AND sed.id = subserv."sedesClinica_id" AND
	 dep."serviciosSedes_id" = serv.id and dep."subServiciosSedes_id" = subserv.id AND
	dep."tipoDoc_id" = u."tipoDoc_id" and dep.documento_id = u.id and u."tipoDoc_id" = tp.id and dep.disponibilidad = 'O'
ORDER By dep.numero, dep."fechaOcupacion";


-- Query Historial deHabitaciones 

select * from sitios_historialdependencias;
select * from usuarios_usuarios;
 

select sed.nombre, serv.nombre, subserv.nombre, dep.numero numero,   case when his.disponibilidad ='L' then 'Libera' else 'Ocupa' end accion,  case when his.disponibilidad ='O' then  his."fechaOcupacion" else  his."fechaLiberacion" end  fecha,
 tp.nombre tipoDoc 	,	u.documento documento, 	u.nombre paciente
FROM sitios_dependencias dep, usuarios_usuarios u, usuarios_tiposdocumento tp,sitios_sedesclinica sed,
		sitios_serviciossedes serv, sitios_subserviciossedes subserv, sitios_historialdependencias his
WHERE his.dependencias_id = dep.id AND dep."sedesClinica_id"  = 2 AND sed.id=dep."sedesClinica_id" AND sed.id = serv."sedesClinica_id" AND sed.id = subserv."sedesClinica_id" AND
	 dep."serviciosSedes_id" = serv.id and dep."subServiciosSedes_id" = subserv.id AND
	dep."tipoDoc_id" = u."tipoDoc_id" and dep.documento_id = u.id and u."tipoDoc_id" = tp.id 
ORDER By dep.numero, dep."fechaOcupacion";

detalle ='select sed.nombre, serv.nombre, subserv.nombre, dep.numero numero,   case when his.disponibilidad = ' + "'" + str('L') + "'" + ' then ' + "'" +  str('Libera') + "'" + ' else ' + "'" + str('Ocupa') + "'" + ' end accion,  case when his.disponibilidad =' + "'" + str('O') + "'" + ' then  his."fechaOcupacion" else  his."fechaLiberacion" end  fecha, tp.nombre tipoDoc 	,	u.documento documento, 	u.nombre paciente FROM sitios_dependencias dep, usuarios_usuarios u, usuarios_tiposdocumento tp,sitios_sedesclinica sed, 	sitios_serviciossedes serv, sitios_subserviciossedes subserv, sitios_historialdependencias his WHERE his.dependencias_id = dep.id AND dep."sedesClinica_id"  = ' + "'" + str(sede) + "'" + ' AND sed.id=dep."sedesClinica_id" AND sed.id = serv."sedesClinica_id" AND sed.id = subserv."sedesClinica_id" AND dep."serviciosSedes_id" = serv.id and dep."subServiciosSedes_id" = subserv.id AND dep."tipoDoc_id" = u."tipoDoc_id" and dep.documento_id = u.id and u."tipoDoc_id" = tp.id  ORDER By dep.numero, dep."fechaOcupacion'
select * from usuarios_usuarios

select "sedesClinica_id",documento_id,* from triage_triage where documento_id=27;
select "sedesClinica_id",documento_id,* from facturacion_liquidacion where documento_id=27;

select * from clinico_historia where documento_id=38;
select * from clinico_historiaexamenes where historia_id in (727,728);

select * from facturacion_liquidacion where documento_id=19;
delete  from facturacion_liquidacion where id=166;
SELECT id FROM facturacion_liquidacion WHERE "tipoDoc_id" = 1 AND documento_id = 38 AND "consecAdmision" = 1 and convenio_id = '1'
SELECT id, convenio_id  FROM facturacion_liquidacion WHERE "tipoDoc_id" = 1 AND documento_id = 38 AND "consecAdmision" = 1 and convenio_id = '1'

select * from admisiones_ingresos;
select * from facturacion_conveniospacienteingresos where documento_id=38; ;
update facturacion_liquidacion set convenio_id=1 where documento_id=38;