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

select "requiereAutorizacion", cums, * from facturacion_suministros order by "requiereAutorizacion" desc
      -- mañana de nuvo 
"S"	"11837-6"	17664	"FLUCONAZOL 200 MG. CAPSULAS"  --> si requiere autoriz
"N"	"19930138-5"	33006	"ATEPLAX"  --> No requiere autoriz 