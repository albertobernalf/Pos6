SELECT salas.numero , prog."fechaProgramacionInicia", prog."fechaProgramacionFin", prog."horaProgramacionInicia", cast("horaProgramacionFin" as time) + interval '1 minute' ,
       (SELECT cast(cast(prog1."fechaProgramacionInicia" as character)||' '||prog1."horaProgramacionInicia" as time) + interval '1 minute'
			FROM cirugia_programacioncirugias prog1
         	WHERE prog1.id = (SELECT min(prog2.id) FROM cirugia_programacioncirugias prog2  WHERE  prog2.id > prog.id))
FROM cirugia_programacioncirugias prog, sitios_salas salas
WHERE prog.id =8 and prog.sala_id = salas.id

select "horaProgramacionFin", cast("horaProgramacionFin" as time) + interval '1 minute' ,* from cirugia_programacioncirugias

	select * from sitios_salas;
select * from admisiones_ingresos where documento_id= 16 order by id;

SELECT ing.id ingreso , usu."primerNombre"  primerNombre, usu."segundoNombre"  segundoNombre, usu."primerApellido"  primerApellido,
	usu."segundoApellido" segundoApellido , tipos.abreviatura abreviatura ,usu.documento documento ,
	round(cast(cast((cast(now() as date)  - cast(usu."fechaNacio" as date)) as text) as numeric)/365,0)   edad, ing."fechaIngreso" fechaIngreso,
	usu.direccion direccion, usu.telefono telefono,  ing."fechaSalida" fechaSalida, dep.nombre departamentoPaciente, 
	mun.nombre municipioPaciente, ing.factura, emp.nombre, emp.documento nit
	FROM admisiones_ingresos ing 
	INNER JOIN facturacion_facturacion fac ON (fac."tipoDoc_id" = ing."tipoDoc_id" AND fac.documento_id=ing.documento_id AND fac."consecAdmision" = ing.consec)
	INNER JOIN usuarios_usuarios usu ON (usu."tipoDoc_id"=ing."tipoDoc_id" AND usu.id=ing.documento_id) 
	INNER JOIN sitios_departamentos dep ON (dep.id=usu.departamentos_id)
	INNER JOIN sitios_municipios mun ON (mun.id = usu.municipio_id)
	INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id=ing."tipoDoc_id")
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id)
	INNER JOIN facturacion_empresas emp ON (emp.id=conv.empresa_id)
	WHERE ing.id = '50112'

comando = 'SELECT ing.id ingreso , usu."primerNombre"  primerNombre, usu."segundoNombre"  segundoNombre, usu."primerApellido"  primerApellido, usu."segundoApellido" segundoApellido , tipos.abreviatura abreviatura ,usu.documento documento , cast(cast((cast(now() as date)  - cast(usu."fechaNacio" as date)) as text) as numeric)/365   edad, ing."fechaIngreso" fechaIngreso, usu.direccion direccion, usu.telefono telefono,  ing."fechaSalida" fechaSalida, dep.nombre departamentoPaciente, mun.nombre municipioPaciente, ing.factura, conv.nombre, emp.documento nit 	FROM admisiones_ingresos ing  INNER JOIN facturacion_facturacion fac ON (fac."tipoDoc_id" = ing."tipoDoc_id" AND fac.documento_id=ing.documento_id AND fac."consecAdmision" = ing.consec) INNER JOIN usuarios_usuarios usu ON (usu."tipoDoc_id"=ing."tipoDoc_id" AND usu.id=ing.documento_id)  INNER JOIN sitios_departamentos dep ON (dep.id=usu.departamentos_id) INNER JOIN sitios_municipios mun ON (mun.id = usu.municipio_id) INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id=ing."tipoDoc_id") INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN facturacion_empresas emp ON (emp.id=conv.empresa_id) WHERE ing.id = ' + "'" + str(ingresoId) + "'"
	select * from facturacion_empresas
select * from facturacion_facturacion;
select * from contratacion_convenios;


select * from basicas_parametros;

select nombre from facturacion_conceptos;
select * from clinico_examenes;

select * from facturacion_facturaciondetalle where facturacion_id=57;

select exa."codigoCups" cups, exa.nombre  descripcion, detFac.cantidad cantidad, detFac."valorUnitario" valorUnitario,
	     detFac."valorTotal" valorTotal
FROM facturacion_facturaciondetalle detFac
INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
where detfac.facturacion_id=57;

select * from tarifarios_tarifariosprocedimientos;

select * from tarifarios_tipostarifa;
select * from facturacion_facturacion where id=57;
select * from contratacion_convenios where id=17 -- 20 tarifariosDescripcionProc_id
select  * from tarifarios_tarifariosdescripcion where id=20 -- tiposTarifa_id=2
select * from tarifarios_tarifariosprocedimientos where "tiposTarifa_id" =2;
select * from tarifarios_tarifariosprocedimientos where "tiposTarifa_id" =2 and "codigoCups_id"  in (1253,3392,1925);


select exa."codigoCups" cups,tarProc."codigoHomologado" homologado, exa.nombre  descripcion, detFac.cantidad cantidad, detFac."valorUnitario" valorUnitario,
	     detFac."valorTotal" valorTotal
FROM facturacion_facturaciondetalle detFac
INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id)	
INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id)	
INNER JOIN tarifarios_tarifariosdescripcion tarDesc ON (tarDesc.id=conv."tarifariosDescripcionProc_id")
INNER JOIN tarifarios_tarifariosprocedimientos tarProc ON (tarProc."tiposTarifa_id"=tarDesc."tiposTarifa_id" AND tarProc."codigoCups_id" = detFac.examen_id )
where detfac.facturacion_id=57;

comando ='select exa."codigoCups" cups,tarProc."codigoHomologado" homologado, exa.nombre  descripcion, detFac.cantidad cantidad, detFac."valorUnitario" valorUnitario, detFac."valorTotal" valorTotal FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tarifariosdescripcion tarDesc ON (tarDesc.id=conv."tarifariosDescripcionProc_id") INNER JOIN tarifarios_tarifariosprocedimientos tarProc ON (tarProc."tiposTarifa_id"=tarDesc."tiposTarifa_id" AND tarProc."codigoCups_id" = detFac.examen_id ) where detfac.facturacion_id= ' + "'" + str(factura) + "'"



