-- Pero SOAT
select * from tarifarios_tablahonorariossoat;
select "tipoHonorario_id",cums_id,examen_id,* from facturacion_facturaciondetalle where facturacion_id=150
	select "tipoHonorario_id",cums_id,examen_id,* from facturacion_facturaciondetalle where facturacion_id=149
select * from clinico_examenes;	
select * from clinico_examenes where

select tipHono.id,
(select 'Cod:'||' '||tarSoat."homologado" ||' $ '||sum(detFac."valorTotal") 	
	FROM facturacion_facturaciondetalle detFac
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  )
where detfac.facturacion_id= '149' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'
	and detFac.examen_id= '4021' and tarSoat."tiposHonorarios_id" = 1
group by tarSoat."homologado",exa.nombre) CIRUJANO,
(select 'Cod:'||' '||tarSoat."homologado" ||' $ '||sum(detFac."valorTotal") 	
	FROM facturacion_facturaciondetalle detFac
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  )
where detfac.facturacion_id= '149' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'
	and detFac.examen_id= '4021' and tarSoat."tiposHonorarios_id" = 2
group by tarSoat."homologado",exa.nombre) ANESTESIOLOGO,
(select 'Cod:'||' '||tarSoat."homologado" ||' $ '||sum(detFac."valorTotal") 	
	FROM facturacion_facturaciondetalle detFac
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id"  and tarSoat."grupoQx_id" = exa."grupoQx_id" )
where detfac.facturacion_id= '149' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'
	and detFac.examen_id= '4021' and tarSoat."tiposHonorarios_id" = 3
group by tarSoat."homologado",exa.nombre) AYUDANTE,
	(select 'Cod:'||' '||tarSoat."homologado" ||' $ '||sum(detFac."valorTotal") 	
	FROM facturacion_facturaciondetalle detFac
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
	INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id"  and tarSoat."grupoQx_id" = exa."grupoQx_id" )
where detfac.facturacion_id= '149' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3'
	and detFac.examen_id= '4021' and tarSoat."tiposHonorarios_id" = 5
group by tarSoat."homologado",exa.nombre) SALAS
FROM tarifarios_tiposhonorarios tipHono
WHERE tipHono.nombre in ('CIRUJANO')
ORDER BY tipHono.id


---

select tipHono.id idHonorario,(select 'Cod:'||' '|| tarSoat."homologado" ||' $ '||sum(detFac."valorTotal") FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id)  INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  ) where detfac.facturacion_id= '150' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3' and detFac.examen_id= '4021' and tarSoat."tiposHonorarios_id" = '1' group by tarSoat."homologado",exa.nombre) CIRUJANO, (select 'Cod:'||' '||tarSoat."homologado" ||' $ '|| sum(detFac."valorTotal") FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id)  INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  ) where detfac.facturacion_id= '150' AND (detfac.anulado ='N' or detfac.anulado='R') AND exa.concepto_id = '3' and detFac.examen_id= '4021' and tarSoat."tiposHonorarios_id" = '2' group by tarSoat."homologado",exa.nombre) ANESTESIOLOGO, (select 'Cod:'||' '||tarSoat."homologado" ||' $ '||sum(detFac."valorTotal") FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id)  INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tablahonorariossoat tarSoat ON (tarSoat."tiposHonorarios_id" = detFac."tipoHonorario_id" and tarSoat."grupoQx_id" = exa."grupoQx_id"  ) where detfac.facturacion_id= '150' AND (detfac.anulado ='N' or detfac.anulado='R') AND exa.concepto_id = '3' and detFac.examen_id= '4021' and tarSoat."tiposHonorarios_id" = '3' group by tarSoat."homologado",exa.nombre) AYUDANTE
	--,
FROM tarifarios_tiposhonorarios tipHono
WHERE tipHono.nombre in ('CIRUJANO')
ORDER BY tipHono.id

	select * from tarifarios_tablasalasdecirugiaiss;
update tarifarios_tablasalasdecirugia set "tipoHonorario_id" = 5
	
(select 'Cod:'||' '|| detFac."codigoHomologado" ||' $ '|| sum(detFac."valorTotal")        
FROM facturacion_facturaciondetalle detFac
INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
INNER JOIN tarifarios_tablasalasdecirugia tarSala ON (tarSala."tipoHonorario_id" = detFac."tipoHonorario_id" and tarSala."grupoQx_id" = exa."grupoQx_id"  )  
where detfac.facturacion_id= '150' AND (detfac.anulado ='N' or detfac.anulado='R')  AND exa.concepto_id = '3' and detFac.examen_id= '4021' 
and tarSala."tipoHonorario_id" = '5'
GROUP BY   detFac."codigoHomologado",exa.nombre) SALAS
	
FROM tarifarios_tiposhonorarios tipHono
WHERE tipHono.nombre in ('CIRUJANO')
ORDER BY tipHono.id

select * from admisiones_ingresos where id = 50361

SELECT ing.id ingreso , usu.nombre, usu."primerNombre"  primerNombre, usu."segundoNombre"  segundoNombre, usu."primerApellido"  primerApellido,
	usu."segundoApellido" segundoApellido , tipos.abreviatura abreviatura ,usu.documento documento , 
	round(cast(cast((cast(now() as date)  - cast(usu."fechaNacio" as date)) as text) as numeric)/365,0)   edad, 
	ing."fechaIngreso" fechaIngreso, usu.direccion direccion, usu.telefono telefono,  ing."fechaSalida" fechaSalida, 
	dep.nombre departamentoPaciente, mun.nombre municipioPaciente, ing.factura, emp.nombre nombreEmpresa, emp.documento nit 
	FROM admisiones_ingresos ing  
	INNER JOIN facturacion_liquidacion fac ON (fac."tipoDoc_id" = ing."tipoDoc_id" AND fac.documento_id=ing.documento_id AND 
	select * from facturacion_liquidacion order by id desc

	select * from clinico_examenes where id=4021
	SELECT anulado,"tipoHonorario_id", cirugia_id,examen_id, cums_id,* FROM facturacion_liquidaciondetalle where liquidacion_id=296 and "tipoHonorario_id"=1

	SELECT * FROM CIRUGIA_CIRUGIASPROCEDIMIeNTOS where cirugia_id=37
select * from facturacion_conveniospacienteingresos where 	 documento_id =49
	select * from contratacion_convenios where id=20

	select concepto_id,"grupoQx_id",* from clinico_examenes where id in (4021,1551,2790,1909) --12,5
update clinico_examenes set concepto_id=3  where id in (4021,1551,2790,1909)
select * from usuarios_usuarios;	
select * from tarifarios_tarifariosprocedimientos where "codigoCups_id" in  (4021,1551,2790,1909) and "tiposTarifa_id" = 2;
 	
-- proced soat
select exa.id idCups, exa."codigoCups" cups,tarProc."codigoHomologado" homologado, exa.nombre  descripcion, 1 cantidad,
	sum(detFac."valorUnitario") valorUnitario, sum(detFac."valorTotal") valorTotal 
	FROM facturacion_liquidaciondetalle detFac 
	INNER JOIN facturacion_liquidacion fac ON (fac.id=detFac.liquidacion_id)
	INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id)
	INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id)
	LEFT JOIN tarifarios_tarifariosdescripcion tarDesc ON (tarDesc.id=conv."tarifariosDescripcionProc_id") 
	LEFT JOIN tarifarios_tarifariosprocedimientos tarProc ON (tarProc."tiposTarifa_id"=tarDesc."tiposTarifa_id" 
	AND tarProc."codigoCups_id" = detFac.examen_id ) 
	where detfac.liquidacion_id= '296' AND (detfac.anulado = 'N' or detfac.anulado='R')
	AND exa.concepto_id = 3 and detFac."tipoHonorario_id" is not null
	group by exa.id,  exa."codigoCups", tarProc."codigoHomologado",exa.nombre, cantidad
	ORDER BY 2,1

select * from facturacion_facturacion where id=150;	