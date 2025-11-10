select * from cirugia_estadoscirugias
select * from cirugia_estadosprogramacion
select * from cirugia_cirugias;
-- Cuando se crea o cuando viene de hc --> PENDIENTE y solicitud de programacion .. ok
--> luegfo programada el estado de prpoghramacion ,, 
--> luego se confirma la cirugia
--> Luego Realizada, tanto en programacion como en la cirugia misma

--> Luego la generacion de la liquidacion
--> cuando se factura , facturada

select "tipoHonorario_id",* from facturacion_facturaciondetalle order by "consecutivoFactura"

select * from rips_ripsprocedimientos -- 3
	select * from rips_ripsmedicamentos -- 8
	-- por honorarios = 4
	-- por otros insumos = 5 (CREO estos los pasamos por otrosIngresos RIPS)
	
select * from clinico_examenes where id in (551,2148,4021)

