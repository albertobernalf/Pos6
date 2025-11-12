select "tipoDoc_id",* from usuarios_usuarios;

select * from clinico_diagnosticos;
select  "requiereAutorizacion",cums,* from facturacion_suministros order by "requiereAutorizacion" desc

select * from cirugia_cirugias;
select "estadoCirugia_id","estadoProgramacion_id", * from cirugia_cirugias;
select "estadoProgramacion_id",* from cirugia_programacioncirugias;
delete from cirugia_cirugias where id=41

select * from cirugia_estadoscirugias;
2	"PENDIENTE"
3	"CONFIRMADA"
4	"REALIZADA"
5	"FACTURADA"
6	"CANCELADA"
select * from cirugia_estadosprogramacion;
2	"Solicitud"
3	"Programada"
4	"Cancelada"
5	"Realizada"

	select * from facturacion_liquidaciondetalle
		select * from facturacion_liquidacion

	select * from facturacion_suministros where id = 34657

select * from cirugia_cirugiasmaterialqx

select matqx.suministro_id suministro, sum.nombre nomSuministro , tipos.nombre tipo ,matqx."valorLiquidacion" valorLiquidacionMat 
	from cirugia_cirugiasmaterialqx matqx, facturacion_suministros sum, facturacion_tipossuministro tipos where matqx.cirugia_id= '40'
	and matqx.suministro_id = sum.id and sum."tipoSuministro_id" = tipos.id  AND tipos.id != '10' AND matqx."hojaDegasto" = 'N'