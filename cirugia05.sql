select * from cirugia_cirugiasmaterialqx
	
select cirmaterial.id id, cirmaterial.suministro_id suministro_id, suministros.nombre suministro , tipo.nombre tipoSuministro , 
	cirmaterial.unitario unitario , cirmaterial.cantidad cantidad , cirmaterial."valorLiquidacion" valorLiquidacion, exa.nombre cupsNombre
	FROM cirugia_cirugiasMaterialQx cirmaterial 
	INNER JOIN cirugia_cirugiasprocedimientos cirProc ON ( cirProc.id = cirmaterial."cirugiaProcedimiento_id") 
	INNER JOIN facturacion_suministros suministros ON ( suministros.id = cirmaterial.suministro_id)
	INNER JOIN facturacion_tipossuministro tipo ON (tipo.id = suministros."tipoSuministro_id") 
	INNER JOIN clinico_examenes exa ON ( exa.id = cirProc.cups_id) 
	WHERE cirmaterial.cirugia_id = '39'

select cirmaterial.id id, cirmaterial.suministro_id suministro_id, suministros.nombre suministro , exa1."codigoCups" cupsCodigo, exa1.nombre cups,tipo.nombre tipoSuministro , 
	cirmaterial.unitario unitario , cirmaterial.cantidad cantidad , cirmaterial."valorLiquidacion" valorLiquidacion, exa.nombre cupsNombre
	FROM cirugia_cirugiasMaterialQx cirmaterial 
	INNER JOIN cirugia_cirugiasprocedimientos cirProc ON ( cirProc.id = cirmaterial."cirugiaProcedimiento_id") 
	LEFT JOIN facturacion_suministros suministros ON ( suministros.id = cirmaterial.suministro_id)
	LEFT JOIN facturacion_tipossuministro tipo ON (tipo.id = suministros."tipoSuministro_id") 
	LEFT JOIN clinico_examenes exa ON ( exa.id = cirProc.cups_id) 
	LEFT JOIN clinico_examenes exa1 ON (exa1.id =cirmaterial.cups_id )
	WHERE cirmaterial.cirugia_id = '39'
 
select "tipoHonorario_id",concepto_id,* from  clinico_examenes order by  "tipoHonorario_id" desc;

select * from facturacion_conceptos;
select * from tarifarios_tiposhonorarios

select "tipoHonorario_id",cums_id, examen_id,* from facturacion_facturaciondetalle where "tipoHonorario_id" = 7
select * from facturacion_suministros where "tipoHonorario_id" = 7
select * from clinico_tiposexamen
	select "tipoHonorario_id",* from facturacion_suministros  ORDER BY "tipoHonorario_id" asc
select * from facturacion_tipossuministro	
select * from facturacion_suministros where "tipoSuministro_id" = 10 
	select * from cirugia_cirugiasmaterialqx;

select matqx.suministro_id suministro, sum.nombre nomSuministro , tipos.nombre tipo ,matqx."valorLiquidacion" valorLiquidacionMat
	from cirugia_cirugiasmaterialqx matqx, facturacion_suministros sum, facturacion_tipossuministro tipos
	where matqx.cirugia_id= '39' and matqx.suministro_id = sum.id and sum."tipoSuministro_id" = tipos.id 
	AND tipos.id != '10'


	
	select * from facturacion_tipossuministro ;
	
select "tipoHonorario_id",concepto_id,* from facturacion_suministros where id in (34656,34654,34655,34652)
select * from facturacion_suministros where  cums = 'AGUJ006'
select * from facturacion_suministros where CUMS LIKE ('%AGU%')

SELECT * FROM FACTURACION_LIQUIDACIONDETALLE
	SELECT "tipoHonorario_id",* FROM FACTURACION_facturaciondetalle

SELECT * FROM RIPS_RIPSCUMS --> SE DEBE CARGAR LA TABLA REFERNECIA CATALOGOCUMS QUE TIENE COMO 10000 CUMS