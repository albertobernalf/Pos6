SELECT distinct con.id, con.nombre nombreConcepto
from facturacion_conceptos con
INNER JOIN 	 clinico_examenes exa ON (exa.concepto_id = con.id) 
where exa.id in (select facdet.examen_id from facturacion_facturaciondetalle facdet
where facdet.facturacion_id = '62')
union
SELECT distinct con.id, con.nombre nombreConcepto
from facturacion_conceptos con
INNER JOIN 	 facturacion_suministros sum ON (sum.concepto_id = con.id) 
where sum.id in (select facdet.cums_id from facturacion_facturaciondetalle facdet
where facdet.facturacion_id = '62')
	order by 1 desc

union SELECT distinct con.id, con.nombre nombreConcepto from facturacion_conceptos con INNER JOIN facturacion_suministros sum ON (sum.concepto_id = con.id) 
where sum.id in (select facdet.cums_id from facturacion_facturaciondetalle facdet where facdet.facturacion_id = '62')

select * from facturacion_conceptos;

select exa."codigoCups" cups,tarProc."codigoHomologado" homologado, exa.nombre  descripcion,
	detFac.cantidad cantidad, 	detFac."valorUnitario" valorUnitario, detFac."valorTotal" valorTotal
FROM facturacion_facturaciondetalle detFac 
INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id)
INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) 
INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
INNER JOIN tarifarios_tarifariosdescripcion tarDesc ON (tarDesc.id=conv."tarifariosDescripcionProc_id") 
INNER JOIN tarifarios_tarifariosprocedimientos tarProc ON (tarProc."tiposTarifa_id"=tarDesc."tiposTarifa_id" AND tarProc."codigoCups_id" = detFac.examen_id ) 
where detfac.facturacion_id= '62' AND exa.concepto_id = '14'


	select * from tarifarios_tarifariossuministros;
select * from facturacion_suministros;
select * from facturacion_facturacion;

update facturacion_suministros set concepto_id=6


select sum.cums cums,tarSum."codigoHomologado" homologado, sum.nombre  descripcion,
	detFac.cantidad cantidad, 	detFac."valorUnitario" valorUnitario, detFac."valorTotal" valorTotal
FROM facturacion_facturaciondetalle detFac 
INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id)
INNER JOIN facturacion_suministros sum on (sum.id=detFac.cums_id) 
INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) 
INNER JOIN tarifarios_tarifariosdescripcion tarDesc ON (tarDesc.id=conv."tarifariosDescripcionSum_id") 
INNER JOIN tarifarios_tarifariossuministros tarSum ON (tarSum."tiposTarifa_id"=tarDesc."tiposTarifa_id" AND tarSum.id = detFac.cums_id ) 
where detfac.facturacion_id= '63' AND sum.concepto_id = '6'


comando = 'select sum.cums cums,tarSum."codigoHomologado" homologado, sum.nombre  descripcion, detFac.cantidad cantidad, 	detFac."valorUnitario" valorUnitario, detFac."valorTotal" valorTotal FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) INNER JOIN facturacion_suministros sum on (sum.id=detFac.cums_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id)  INNER JOIN tarifarios_tarifariosdescripcion tarDesc ON (tarDesc.id=conv."tarifariosDescripcionSum_id") INNER JOIN tarifarios_tarifariossuministros tarSum ON (tarSum."tiposTarifa_id"=tarDesc."tiposTarifa_id" AND tarSum.id = detFac.cums_id ) where detfac.facturacion_id= ' + "'" + str(factura) + "'" + ' AND sum.concepto_id = ' + "'" + str(id) + "'"
SELECT distinct con.id, con.nombre nombreConcepto from facturacion_conceptos con INNER JOIN      clinico_examenes exa ON (exa.concepto_id = con.id) where exa.id in (select facdet.examen_id from facturacion_facturaciondetalle facdet where facdet.facturacion_id = '62') union SELECT distinct con.id, con.nombre nombreConcepto from facturacion_conceptos con INNER JOIN facturacion_suministros sum ON (sum.concepto_id = con.id) where sum.id in (select facdet.cums_id from facturacion_facturaciondetalle facdet where facdet.facturacion_id = '62') order by 1 desc

select sum.cums cups,tarSum."codigoHomologado" homologado, sum.nombre  descripcion, detFac.cantidad cantidad,   
	detFac."valorUnitario" valorUnitario, detFac."valorTotal" valorTotal 
	FROM facturacion_facturaciondetalle detFac
	INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) 
INNER JOIN facturacion_suministros sum on (sum.id=detFac.cums_id) 
INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id)  
INNER JOIN tarifarios_tarifariosdescripcion tarDesc ON (tarDesc.id=conv."tarifariosDescripcionSum_id")
INNER JOIN tarifarios_tarifariossuministros tarSum ON (tarSum."tiposTarifa_id"=tarDesc."tiposTarifa_id" AND tarSum.id = detFac.cums_id ) where detfac.facturacion_id= '62' AND sum.concepto_id = '14'

	
select convenio_id,* from facturacion_liquidacion where documento_id='1'; -- ,, 186,200
update facturacion_liquidacion set "totalProcedimientos"=0,"totalSuministros" = 0, "totalLiquidacion" = 0, "valorApagar"=0
	where id=187
select * from facturacion_liquidaciondetalle where liquidacion_id=202
select * from facturacion_liquidaciondetalle where liquidacion_id=187
update facturacion_liquidacion set convenio_id=8 where id = 187
	
--delete from facturacion_liquidaciondetalle where liquidacion_id=187
--delete from facturacion_liquidacion where id=201
update facturacion_liquidaciondetalle set "estadoRegistro" = 'A' where liquidacion_id=186
update facturacion_liquidacion set "estadoRegistro" = 'A' where id=186

select * from contratacion_convenios;
select * from facturacion_conveniospacienteingresos where documento_id='1';

select * from tarifarios_tarifariosProcedimientos;

INSERT INTO facturacion_liquidaciondetalle 
( consecutivo, fecha, cantidad, "valorUnitario", "valorTotal", cirugia_id, "fechaCrea", "fechaModifica", observaciones,
"fechaRegistro", "estadoRegistro",examen_id,  "usuarioModifica_id", "usuarioRegistro_id", liquidacion_id,
"tipoHonorario_id", "tipoRegistro", "historiaMedicamento_id") 
select  det.consecutivo, liq.fecha, cantidad, proc."colValorBase", proc."colValorBase" * cantidad, cirugia_id, "fechaCrea", "fechaModifica", liq.observaciones, liq."fechaRegistro", liq."estadoRegistro", examen_id, "usuarioModifica_id",
		liq."usuarioRegistro_id",'187' , "tipoHonorario_id",	"tipoRegistro", "historiaMedicamento_id"
from facturacion_liquidacion liq  , facturacion_liquidaciondetalle det, contratacion_convenios conv,	 
	tarifarios_tarifariosdescripcion descrip, tarifarios_tipostarifa tiptar, tarifarios_tarifariosProcedimientos proc 
where det.liquidacion_id = liq.id and det.liquidacion_id = '186' and conv.id = '8' 
	and det."estadoRegistro" = 'A' and descrip.id = conv."tarifariosDescripcionProc_id" and 
	tiptar.id = descrip."tiposTarifa_id" and tiptar.id = proc."tiposTarifa_id"
	and proc."codigoCups_id" = det.examen_id

 
SELECT descrip.columna columnaSuminist
FROM facturacion_liquidacion liq,contratacion_convenios conv,tarifarios_tarifariosdescripcion descrip 
where liq.id =  '202' AND liq.convenio_id = conv.id and descrip.id = conv."tarifariosDescripcionSum_id"

select "estadoReg",* from facturacion_facturacion;
select * from facturacion_facturaciondetalle;

select * from cartera_pagosfacturas;
select * from cartera_pagos;