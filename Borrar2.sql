SELECT * FROM SITIOS_DEPENDENCIAS WHERE ID=21;
UPDATE SITIOS_DEPENDENCIAS SET DISPONIBILIDAD='L' WHERE ID=21;
select * from usuarios_usuarios;
SELECT d.id id, d.nombre  nombre FROM sitios_paises d

BEGIN TRANSACTION;
insert into usuarios_usuarios (nombre, documento, genero, "fechaNacio", pais_id,  departamentos_id, ciudades_id, direccion, telefono,
 contacto, "centrosC_id", "tipoDoc_id", "tiposUsuario_id", municipio_id, localidad_id, "estadoCivil_id", ocupacion_id, correo 
,"fechaRegistro", "estadoReg") 
values ('ALEJANDRO BERNAL' , '1212', 'M'  , '0001-01-01 00:00:01', '1', '1'  , '1'  , 'SASA', '21',
 '', '1', '3', '' , '2', '1', '', '', '', 
'2024-11-20 08:36:04.289314', 'A')

-- ROLLBACK;
-- COMMIT;

SELECT * FROM USUARIOS_USUARIOS;

select * from facturacion_liquidacion order by id; -- id 75
select * from facturacion_liquidaciondetalle order by id;

select * from facturacion_facturacion order by id
select * from facturacion_facturaciondetalle order by id

update facturacion_facturacion set convenio_id=3 where id=35;

select "serviciosIng_id", "serviciosActual_id",* from admisiones_ingresos order by id;
select * from clinico_servicios;

select * from sitios_dependencias;
select * from sitios_historialdependencias;
select "salidaClinica",* from admisiones_ingresos WHERE documento_id=25;

select * from facturacion_conveniospacienteingresos


SELECT 'INGRESO' tipoIng, i.id||'-INGRESO' id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , 
i."fechaIngreso" , i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual 
FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp ,
 sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd
 WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" 
AND i."sedesClinica_id" = '1' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND 
(dep.disponibilidad='O' OR (dep.disponibilidad = 'L' AND ser.id=3)) AND i."salidaDefinitiva" = 'N' and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and
 u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null and dep."serviciosSedes_id" = sd.id and 
dep.id = i."dependenciasActual_id" 
UNION 
SELECT 'TRIAGE' tipoIng, t.id||'-TRIAGE'  id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,t.consec consec , 
t."fechaSolicita" , cast('0001-01-01 00:00:00' as timestamp) fechaSalida,ser.nombre servicioNombreIng,
 dep.nombre camaNombreIng , ' + "''" + ' dxActual FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep ,
 usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  ,sitios_serviciosSedes sd, clinico_servicios ser 
WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" 
AND t."sedesClinica_id" = '1' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND 
t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and
 t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and
 dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and
 t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = 'TRIAGE'

(dep.disponibilidad= ' + "'" + str('O') + "'" + ' OR (dep.disponibilidad = ' + "'" + str('L') + "'" + ' AND ser.id=3))

-- origina quey en facturacioniquidacion
    detalle = 'SELECT ' + "'" + str("INGRESO") + "'" + "||'-'||" + ' i.id'  + "||" +"'" + "-'||case when conv.id != 0 then conv.id else " + "'" + str('00') + "'" + ' end id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" , i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual,conv.nombre convenio, conv.id convenioId FROM admisiones_ingresos i INNER JOIN clinico_servicios ser ON (ser.id = i."serviciosActual_id" ) INNER JOIN sitios_serviciosSedes sd ON (i."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id) INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  i."sedesClinica_id" and dep.id = i."dependenciasActual_id"  AND  dep.disponibilidad = ' + "'" + str('O') + "'" + ' AND dep."serviciosSedes_id" = sd.id ) INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxActual_id") LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and  fac."consecAdmision" = i.consec )  LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) WHERE i."sedesClinica_id" =  ' "'" + str(sede) + "'" + ' AND i."salidaDefinitiva" = ' + "'" + str('N') + "'" + ' and i."fechaSalida" is null UNION SELECT ' + "'"  + str("TRIAGE") + "'"+ "||'-'||"  + ' t.id'  + "||" +"'" + "-'||case when conv.id != 0 then conv.id else " + "'" + str('00') + "'" + ' end id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre, t.consec consec , t."fechaSolicita" , cast(' + "'" + str('0001-01-01 00:00:00') + "'" + ' as timestamp) fechaSalida,ser.nombre servicioNombreIng, dep.nombre camaNombreIng , ' + "' '" + ' dxActual , conv.nombre convenio, conv.id convenioId FROM triage_triage t INNER JOIN clinico_servicios ser ON ( ser.nombre = ' + "'" + str('TRIAGE') + "')" + ' INNER JOIN sitios_serviciosSedes sd ON (t."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id and sd.id = t."serviciosSedes_id" ) INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  t."sedesClinica_id" and dep.id = t.dependencias_id  AND dep.disponibilidad = ' + "'" + str('O') + "'" + ' AND dep."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and t."consecAdmision" = 0 and dep."documento_id" = t."documento_id") INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = t."tipoDoc_id" and fac.documento_id = t.documento_id and  fac."consecAdmision" = t.consec ) LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) WHERE  t."sedesClinica_id" = ' + "'" + str(sede) + "'"

select * from clinico_historia order by id; -- 526
select * from usuarios_usuarios; -- 24 lui erne
select * from clinico_historiaexamenes order by id; -- historia = 526 cups=876222

select * from facturacion_liquidacion order by id; -- ops hay dos que paso papaberol
select * from facturacion_liquidaciondetalle order by id

select * from clinico_examenes where "codigoCups" ='908201' -- id = 76

select * from clinico_examenes where  id = 2250  -- "876222" / "882307"
select * from facturacion_liquidaciondetalle where liquidacion_id  =77
select * from facturacion_liquidaciondetalle order by id
select * from facturacion_liquidacion order by id


delete from facturacion_liquidacion where id in ( 80,81) 
select * from facturacion_facturaciondetalle order by id
select * from facturacion_facturacion order by id
select * from admisiones_ingresos order by id
select * from facturacion_conveniospacienteingresos;
insert into facturacion_conveniospacienteingresos ("consecAdmision","fechaRegistro","estadoReg", convenio_id,documento_id,"tipoDoc_id","usuarioRegistro_id")
 values (1,'2024-11-20 14:00:00','A',3,24,1,1)
update facturacion_facturacion set convenio_id=3 where id=36
delete from facturacion_conveniospacienteingresos where id=63;
--------
------------

SELECT facturas.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,
i.consec consec , i."fechaIngreso" fechaIngreso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida, 
dep.nombre camaNombreSalida , diag.nombre dxSalida , conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica 
FROM admisiones_ingresos i 
INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id")
 INNER JOIN sitios_dependencias dep ON (dep."sedesClinica_id" = i."sedesClinica_id" AND dep."serviciosSedes_id" = sd.id AND
 dep.id = i."dependenciasSalida_id")  INNER JOIN sitios_dependenciastipo deptip  ON (deptip.id = dep."dependenciasTipo_id") 
INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" =  i."tipoDoc_id" AND u.id = i."documento_id" ) 
INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") 
INNER JOIN clinico_servicios ser  ON ( ser.id  = i."serviciosSalida_id")  
INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxSalida_id") 
INNER JOIN facturacion_facturacion facturas ON (facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and
 facturas."consecAdmision" = i.consec ) 
LEFT JOIN contratacion_convenios conv  ON (conv.id = facturas.convenio_id ) 
WHERE i."fechaSalida" between '2024-11-01 00:00:00'  and '2024-12-01 00:00:00' AND i."sedesClinica_id" = '1' AND 
--i."salidaClinica" = ' + "'" + str('S') + "'" + ' AND 
i."fechaSalida" is not null 
  
select * from clinico_historialincapacidades;


function RefrescarPantalla() {
	
		 var data2 =  {}   ;
   	          	data2['username'] = username;
		        data2['sedeSeleccionada'] = sedeSeleccionada;
		        data2['nombreSede'] = nombreSede;
		        data2['sede'] = sede;
		        data2['username_id'] = username_id;
		        var valor = document.getElementById("liquidacionId").value;
		        data2['valor'] = valor;	
		        data2['liquidacionId'] = valor;	
		        data2 = JSON.stringify(data2);
			let fecha = new Date();

	ano = fecha.getFullYear();
	mes = fecha.getMonth() + 1;
	dia = fecha.getDate();
        diaDesde = '01'

        desdeFecha = ano + '-' + mes + '-' + diaDesde + ' 00:00:00'
        hastaFecha = ano + '-' + mes + '-' + dia + ' 23:59:59'

        desdeFactura=0;
        hastaFactura=0;


	data2['desdeFecha'] = desdeFecha;
	data2['hastaFecha'] = hastaFecha;
	data2['desdeFactura'] = desdeFactura;
	data2['hastaFactura'] = hastaFactura;
	data2['bandera'] = 'Por Fecha';

        data2 = JSON.stringify(data2);

  tableF= $("#tablaFacturacion").dataTable().fnDestroy();	
	          initTableFacturacion(data2);
		 

}

