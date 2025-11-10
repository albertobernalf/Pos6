select * from admisiones_ingresos
select * from cirugia_cirugias;

select "codigoHomologado",examen_id,* from facturacion_liquidaciondetalle
551
2148
	select concepto_id, * from clinico_examenes where id in (551,2148)
select "tiposTarifa_id","codigoHomologado",* from tarifarios_tarifariosprocedimientos where "codigoCups_id" in (551,2148);

select * from tarifarios_tipostarifa
update tarifarios_tarifariosprocedimientos  set "codigoHomologado"='hhhh' where id in (19201,20474,4969,3696)
-- la imporesion muestra
select * from facturacion_liquidacion where id = 298
	SELECT * FROM FACTURACION_SUMINISTROS

	select * from clinico_examenes;

select "requiereAutorizacion", cums, * from facturacion_suministros order by "requiereAutorizacion" desc
      -- mañana de nuvo 
"S"	"11837-6"	17664	"FLUCONAZOL 200 MG. CAPSULAS"  --> si requiere autoriz  17664
"N"	"19930138-5"	33006	"ATEPLAX"  --> No requiere autoriz 
	select "requiereAutorizacion", cums, * from facturacion_suministros where id in (24767,33006)
		select "requiereAutorizacion", cums, * from facturacion_suministros where id in (17664,33006)

select examen_id,cums_id, * from facturacion_liquidaciondetalle -- tiene sumionistro : 17664(mal), 33006 creo bien
																-- como asi que farmaciadetalle Ah no parece ser
																-- que farmaca despacho uno que requeria autorizacion OPS OPS OPS como CONTROLAR ESTO ??

	select sum("valorTotal") from facturacion_liquidaciondetalle where examen_id is not null and anulado != 'S' -- exa=1304230
	select sum("valorTotal") from facturacion_liquidaciondetalle where cums_id is not null and anulado != 'S' -- sumi=17454678
-- 17239233
   17239233
	select * from facturacion_liquidacion
	
	select * from farmacia_farmaciadetalle -- tiene 24767 (creo bien no requeir autorizacion cayo a farmacia), 33006 bien 'No autoriacion'
select * from enfermeria_enfermeriarecibe; --  enfermeria recibio el que le mando farmacia el que requeria autorizacion

	
	select * from facturacion_liquidacion
	select * from facturacion_liquidaciondetalle

select * from tarifarios_tarifariosprocedimientos  where id =7355

SELECT * FROM FACTURACION_SUMINISTROS
		SELECT * FROM FACTURACION_SUMINISTROS WHERE cums='VEND005'
	SELECT * FROM CARTERA_PAGOS;
select * from farmacia_farmaciadetalle

select * from facturacion_liquidacion
select * from tarifarios_tipostarifa;

select * from planta_planta
select * from contratacion_convenios where id=20 -- proc=3, sum=30
select * from tarifarios_tarifariosdescripcion 
select * from tarifarios_tarifariosdescripcion  where id=3
select * from tarifarios_tarifariosdescripcion  where id=30

SELECT convenio_id,* FROM CIRUGIA_CIRUGIAS;
SELECT * FROM CIRUGIA_PROGRAMACIONCIRUGIAS
update CIRUGIA_PROGRAMACIONCIRUGIAS set cirugia_id=39, convenio_id=20
	update CIRUGIA_CIRUGIAS set  convenio_id=20

-- vend005


SELECT i.id id,i."tipoDoc_id" tipoDoc_id, u.documento documento,u.nombre paciente, i.consec consecutivo, u.genero, (now() - u."fechaNacio")/360 edad, u."fechaNacio" nacimiento, dep.nombre cama, u.telefono telefono, emp.nombre empresa FROM admisiones_ingresos i INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" =  i."tipoDoc_id" AND u.id =  i.documento_id) LEFT JOIN sitios_dependencias dep ON (dep."sedesClinica_id" = i."sedesClinica_id" AND dep.id = i."dependenciasActual_id") LEFT JOIN facturacion_empresas emp         ON (emp.id = i.empresa_id )  INNER JOIN sitios_serviciossedes servsed ON (servsed.id = dep."serviciosSedes_id") INNER JOIN clinico_servicios serv ON (serv.id = servsed.servicios_id AND (serv.nombre = 'HOSPITALIZACION' OR serv.nombre = 'URGENCIAS' OR serv.nombre = 'AMBULATORIO')) where i."sedesClinica_id" = '1' AND i."fechaSalida"  is null  AND (i."tipoDoc_id", i.documento_id, i.consec) not in (select cirx."tipoDoc_id", cirx.documento_id, cirx."consecAdmision" FROM cirugia_cirugias cirx WHERE cirx."tipoDoc_id" = i."tipoDoc_id" AND cirx.documento_id = i.documento_id AND cirx."consecAdmision" = i.consec AND cirx."estadoProgramacion_id" !=4) ORDER BY i."dependenciasActual_id"
update facturacion_liquidacion set "totalProcedimientos" =1304230,"totalSuministros"= 17454678, "totalLiquidacion"=18758908,"valorApagar" = 17240233

		select * from tarifarios_tiposhonorarios;
select * from facturacion_liquidacion
select anulado,cirugia_id,examen_id,cums_id,"codigoHomologado","tipoHonorario_id",* from facturacion_liquidaciondetalle -- 20 registros
-- veamos ppor que noimprime os ,materiales
select * from facturacion_conceptos

SELECT * FROM TARIFARIOS_TIPOSHONORARIOS
comando = 'select tipHono.id idHonorario,(select ' + "'" + str('Cod:') + "'" + '||' + "' '||" + ' tarSoat."homologado" ||' + "' $ '||" + 'sum(detFac."valorTotal") FROM facturacion_liquidaciondetalle detFac INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id) INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id)  INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  ) where detfac.liquidacion_id= ' + "'" + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') + "')" + '  AND exa.concepto_id = ' + "'" + str(salvoConcepto) + "'" + ' and detFac.examen_id= ' + "'" + str(idCups) + "'" + ' and tarSoat."tiposHonorarios_id" = ' + "'" + str(tipoCirujano.id) + "'" + ' group by tarSoat."homologado",exa.nombre) CIRUJANO, (select ' + "'" + str('Cod:') + "'||' '||" + 'tarSoat."homologado" ||' + "'" + " $ '||" + ' sum(detFac."valorTotal") FROM facturacion_liquidaciondetalle detFac INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id) 	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  ) where detfac.liquidacion_id= ' + "'" + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') + "')" + ' AND exa.concepto_id = ' + "'" + str(salvoConcepto) + "'" + ' and detFac.examen_id= ' + "'" + str(idCups) + "'" + ' and tarSoat."tiposHonorarios_id" = ' + "'" + str(tipoAnestesiologo.id) + "'" + ' group by tarSoat."homologado",exa.nombre) ANESTESIOLOGO, (select ' + "'" + str('Cod:') + "'" + "||' '||" + 'tarSoat."homologado" ||' + "' $ '||" + 'sum(detFac."valorTotal") FROM facturacion_liquidaciondetalle detFac INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id)  INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  ) where detfac.liquidacion_id= ' + "'" + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') + "')" + ' AND exa.concepto_id = ' + "'" + str(salvoConcepto) + "'" + ' and detFac.examen_id= ' + "'" + str(idCups) + "'" + ' and tarSoat."tiposHonorarios_id" = ' + "'" + str(tipoAyudante.id) + "'" + ' group by tarSoat."homologado",exa.nombre) AYUDANTE,
	
	(select 'Cod:'||' '||detFac."codigoHomologado" ||'$'||sum(detFac."valorTotal") 
	FROM facturacion_liquidaciondetalle detFac
	INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id)
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) 
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	INNER JOIN tarifarios_tablasalasdecirugia tarSala ON (tarSala."tipoHonorario_id" = detFac."tipoHonorario_id" and tarSala."grupoQx_id" = exa."grupoQx_id"  ) 
	where detfac.liquidacion_id= '298' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'
	and detFac.examen_id= 4021 and tarSala."tipoHonorario_id" = '5' 
	GROUP BY   detFac."codigoHomologado",exa.nombre) SALAS
	
	
	
	FROM tarifarios_tiposhonorarios tipHono WHERE tipHono.nombre in (' + "'" + str('CIRUJANO') + "')" + ' ORDER BY tipHono.id'

-- iss
                    comando = 'select tipHono.id idHonorario,(select ' + "'" + str('Cod:') + "'" + '||' + "' '||" + ' tarIss."homologado" ||' + "' $ '||" + 'sum(detFac."valorTotal") FROM facturacion_liquidaciondetalle detFac INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id) INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id)  INNER JOIN tarifarios_tablahonorariosiss tarIss ON (tarIss."tiposHonorarios_id" = detFac."tipoHonorario_id" ) where detfac.liquidacion_id= ' + "'" + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') + "')" + '  AND exa.concepto_id = ' + "'" + str(salvoConcepto) + "'" + ' and detFac.examen_id= ' + "'" + str(idCups) + "'" + ' and tarIss."tiposHonorarios_id" = ' + "'" + str(tipoCirujano.id) + "'" + ' group by tarIss."homologado",exa.nombre) CIRUJANO, (select ' + "'" + str('Cod:') + "'||' '||" + 'tarIss."homologado" ||' + "'" + " $ '||" + ' sum(detFac."valorTotal") FROM facturacion_liquidaciondetalle detFac INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id) 	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 	INNER JOIN tarifarios_tablahonorariosiss tarIss ON (tarIss."tiposHonorarios_id" = detFac."tipoHonorario_id" ) where detfac.liquidacion_id= ' + "'" + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') + "')" + ' AND exa.concepto_id = ' + "'" + str(salvoConcepto) + "'" + ' and detFac.examen_id= ' + "'" + str(idCups) + "'" + ' and tarIss."tiposHonorarios_id" = ' + "'" + str(tipoAnestesiologo.id) + "'" + ' group by tarIss."homologado",exa.nombre) ANESTESIOLOGO, (select ' + "'" + str('Cod:') + "'" + "||' '||" + 'tarIss."homologado" ||' + "' $ '||" + 'sum(detFac."valorTotal") FROM facturacion_liquidaciondetalle detFac INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id)  INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablahonorariosiss tarIss ON (tarIss."tiposHonorarios_id" = detFac."tipoHonorario_id" ) where detfac.liquidacion_id= ' + "'" + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') + "')" + ' AND exa.concepto_id = ' + "'" + str(salvoConcepto) + "'" + ' and detFac.examen_id= ' + "'" + str(idCups) + "'" + ' and tarIss."tiposHonorarios_id" = ' + "'" + str(tipoAyudante.id) + "'" + ' group by tarIss."homologado",exa.nombre) AYUDANTE,	(select ' + "'" + str('Cod:') + "'" + "||' '||" + ' detFac."codigoHomologado" ||' + "' $ '||" + ' sum(detFac."valorTotal") 	FROM facturacion_liquidaciondetalle detFac INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id) INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablasalasdecirugiaiss tarSala ON (tarSala."tipoHonorario_id" = detFac."tipoHonorario_id" ) where detfac.liquidacion_id= ' + "'" + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') + "')" + '  AND exa.concepto_id = ' + "'" + str(salvoConcepto) + "'" + ' and detFac.examen_id= ' + "'" + str(idCups) + "'" + ' and tarSala."tipoHonorario_id" = ' + "'" + str(tipoDerechosSala.id) + "'" + ' GROUP BY   detFac."codigoHomologado",exa.nombre) SALAS FROM tarifarios_tiposhonorarios tipHono WHERE tipHono.nombre in (' + "'" + str('CIRUJANO') + "')" + ' ORDER BY tipHono.id'

-- soatl
                    comando = 'select tipHono.id idHonorario,(select ' + "'" + str('Cod:') + "'" + '||' + "' '||" + ' tarSoat."homologado" ||' + "' $ '||" + 'sum(detFac."valorTotal") FROM facturacion_liquidaciondetalle detFac INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id) INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id)  INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  ) where detfac.liquidacion_id= ' + "'" + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') + "')" + '  AND exa.concepto_id = ' + "'" + str(salvoConcepto) + "'" + ' and detFac.examen_id= ' + "'" + str(idCups) + "'" + ' and tarSoat."tiposHonorarios_id" = ' + "'" + str(tipoCirujano.id) + "'" + ' group by tarSoat."homologado",exa.nombre) CIRUJANO, (select ' + "'" + str('Cod:') + "'||' '||" + 'tarSoat."homologado" ||' + "'" + " $ '||" + ' sum(detFac."valorTotal") FROM facturacion_liquidaciondetalle detFac INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id) 	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  ) where detfac.liquidacion_id= ' + "'" + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') + "')" + ' AND exa.concepto_id = ' + "'" + str(salvoConcepto) + "'" + ' and detFac.examen_id= ' + "'" + str(idCups) + "'" + ' and tarSoat."tiposHonorarios_id" = ' + "'" + str(tipoAnestesiologo.id) + "'" + ' group by tarSoat."homologado",exa.nombre) ANESTESIOLOGO, (select ' + "'" + str('Cod:') + "'" + "||' '||" + 'tarSoat."homologado" ||' + "' $ '||" + 'sum(detFac."valorTotal") FROM facturacion_liquidaciondetalle detFac INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id)  INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  ) where detfac.liquidacion_id= ' + "'" + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') + "')" + ' AND exa.concepto_id = ' + "'" + str(salvoConcepto) + "'" + ' and detFac.examen_id= ' + "'" + str(idCups) + "'" + ' and tarSoat."tiposHonorarios_id" = ' + "'" + str(tipoAyudante.id) + "'" + ' group by tarSoat."homologado",exa.nombre) AYUDANTE,	(select ' + "'" + str('Cod:') + "'" + "||' '||" + ' detFac."codigoHomologado" ||' + "' $ '||" + ' sum(detFac."valorTotal") 	FROM facturacion_liquidaciondetalle detFac INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id) INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablasalasdecirugia tarSala ON (tarSala."tipoHonorario_id" = detFac."tipoHonorario_id" and tarSala."grupoQx_id" = exa."grupoQx_id"  )    where detfac.liquidacion_id= ' + "'" + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') + "')" + '  AND exa.concepto_id = ' + "'" + str(salvoConcepto) + "'" + ' and detFac.examen_id= ' + "'" + str(idCups) + "'" + ' and tarSala."tipoHonorario_id" = ' + "'" + str(tipoDerechosSala.id) + "'" + ' GROUP BY   detFac."codigoHomologado",exa.nombre) SALAS FROM tarifarios_tiposhonorarios tipHono WHERE tipHono.nombre in (' + "'" + str('CIRUJANO') + "')" + ' ORDER BY tipHono.id'

	SELECT * FROM tarifarios_tablamaterialsuturacuracion
	update tarifarios_tablamaterialsuturacuracion set "tipoHonorario_id" = 7

	
	(select 'Cod:'||' '||detFac."codigoHomologado" ||'$'||sum(detFac."valorTotal") 
	FROM facturacion_liquidaciondetalle detFac
	INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id)
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) 
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	INNER JOIN tarifarios_tablamaterialsuturacuracion tarMat ON (tarMat."tipoHonorario_id" = detFac."tipoHonorario_id" and tarMat."grupoQx_id" = exa."grupoQx_id"  ) 
	where detfac.liquidacion_id= '298' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'
	and detFac.examen_id= 4021 and tarMat."tipoHonorario_id" = '7' 
	GROUP BY   detFac."codigoHomologado",exa.nombre) MATERIALES

-- seria AGREGAR: ANTES DEL FROM

,(select ' + "'" + str('Cod:') + "'||' '||" + ' detFac."codigoHomologado" ||' + "'" + str('$') + "'||" + ' sum(detFac."valorTotal") FROM facturacion_liquidaciondetalle detFac INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id) INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablamaterialsuturacuracion tarMat ON (tarMat."tipoHonorario_id" = detFac."tipoHonorario_id" and tarMat."grupoQx_id" = exa."grupoQx_id"  ) where detfac.liquidacion_id= ' + "'" + str(factura) + "'" + ' AND (detfac.anulado =' + "'" + str('N') + "'" + ' or detfac.anulado=' + "'" + str('R') + "')" + '  AND exa.concepto_id = ' + "'" +  str(salvoConcepto) + "'" + ' and detFac.examen_id= ' + "'" + str(idCups) + "'" + ' and tarMat."tipoHonorario_id" = tipoDerechosMateriales.id GROUP BY detFac."codigoHomologado",exa.nombre) MATERIALES

	SELECT * FROM FACTURACION_LIQUIDACION;
SELECT * FROM FACTURACION_facturacion;
select * from facturacion_liquidaciondetalle
select cirugia_id,examen_id,cums_id,"tipoHonorario_id",* from facturacion_facturaciondetalle

select * from cartera_pagos
select * from cartera_pagosfacturas -- ojop No guardo la sede
select * from facturacion_refacturacion
select * from facturacion_conveniospacienteingresos
select * from admisiones_ingresos

select "estadoCirugia_id", * from cirugia_cirugias; --- 4

select * from cirugia_estadoscirugias;
update FACTURACION_facturacion set "totalCuotaModeradora" = 1200, "totalRecibido" = 1200, "valorApagar" = 18758908 - 1200;

select tipHono.id idHonorario,(select 'Cod:'||' '|| tarSoat."homologado" ||' $ '||sum(detFac."valorTotal") FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id)  INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  ) where detfac.facturacion_id= '151' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3' and detFac.examen_id= '4021' and tarSoat."tiposHonorarios_id" = '1' group by tarSoat."homologado",exa.nombre) CIRUJANO, (select 'Cod:'||' '||tarSoat."homologado" ||' $ '|| sum(detFac."valorTotal") FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id)   INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  ) where detfac.facturacion_id= '151' AND (detfac.anulado ='N' or detfac.anulado='R') AND exa.concepto_id = '3' and detFac.examen_id= '4021' and tarSoat."tiposHonorarios_id" = '2' group by tarSoat."homologado",exa.nombre) ANESTESIOLOGO, (select 'Cod:'||' '||tarSoat."homologado" ||' $ '||sum(detFac."valorTotal") FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id)  INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  ) where detfac.facturacion_id= '151' AND (detfac.anulado ='N' or detfac.anulado='R') AND exa.concepto_id = '3' and detFac.examen_id= '4021' and tarSoat."tiposHonorarios_id" = '3' group by tarSoat."homologado",exa.nombre) AYUDANTE,    (select 'Cod:'||' '|| detFac."codigoHomologado" ||' $ '|| sum(detFac."valorTotal")   FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablasalasdecirugia tarSala ON (tarSala."tipoHonorario_id" = detFac."tipoHonorario_id" and tarSala."grupoQx_id" = exa."grupoQx_id"  )    where detfac.facturacion_id= '151' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3' and detFac.examen_id= '4021' and tarSala."tipoHonorario_id" = '5' GROUP BY   detFac."codigoHomologado",exa.nombre) SALAS   ,

	-- Ojo aquip no salen los materiales

	select cirugia_id,examen_id,cums_id,"tipoHonorario_id",* from facturacion_facturaciondetalle where "tipoHonorario_id" = '7' 
	 
	(select 'Cod:'||' '|| detFac."codigoHomologado" ||'$'|| sum(detFac."valorTotal") 
	FROM facturacion_facturaciondetalle detFac 
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id)
	INNER JOIN tarifarios_tablamaterialsuturacuracion tarMat ON (tarMat."tipoHonorario_id" = detFac."tipoHonorario_id" and tarMat."grupoQx_id" = exa."grupoQx_id"  ) 
	where detfac.facturacion_id= '151' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3' and 
	detFac.examen_id= '4021' and tarMat."tipoHonorario_id" = '7' 
	GROUP BY detFac."codigoHomologado",exa.nombre) MATERIALES 
	FROM tarifarios_tiposhonorarios tipHono 
	WHERE tipHono.nombre in ('CIRUJANO')
	ORDER BY tipHono.id

	select "codigoCups","grupoQx_id", * from clinico_examenes where id=4021
	select * from tarifarios_tablamaterialsuturacuracion

	SELECT * FROM CLINICO_EXAMENES
	select * from facturacion_suministros
update cirugia_cirugias set "estadoCirugia_id" =5

select * from cirugia_estadoscirugias
