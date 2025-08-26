select * from contratacion_convenios;
select * from usuarios_usuarios;

select "codigoCups_id", count(*) 
	from tarifarios_tarifariosprocedimientos
group by "codigoCups_id" order by count(*) desc	;

select * from clinico_tiposexamen;

select "TiposExamen_id",* from clinico_examenes where id in ('1489','273','3936','2574','951','2614')

1	273	"Campylobacter spp CULTIVO"
select "tiposTarifa_id",* from 	 tarifarios_tarifariosprocedimientos where "codigoCups_id" in ('273')
select * from contratacion_convenios;
	
select * from tarifarios_tipostarifa order by id;
select * from facturacion_conveniospacienteingresos;
select * from triage_triage;

update tarifarios_tarifariosprocedimientos set "colValorBase" = 7777 where id=30905
	
SELECT conv1.id id ,exa."codigoCups" cups, proc."colValorBase" valor
FROM  tarifarios_tarifariosdescripcion des,
	tarifarios_tarifariosprocedimientos proc, clinico_examenes exa, contratacion_convenios conv1 ,
	tarifarios_tipostarifa tiptar 
WHERE  conv1.id = '8' and des.id = conv1."tarifariosDescripcionProc_id" AND proc."codigoCups_id" = exa.id  And exa.id = '273'
	AND des."tiposTarifa_id" = tiptar.id and proc."tiposTarifa_id" = tiptar.id

select * from facturacion_liquidaciondetalle;
select * from facturacion_liquidacion;