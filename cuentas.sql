select * from facturacion_liquidaciondetalle order by id desc;
select * from facturacion_liquidacion order by id desc

select * from clinico_tiposexamen;
select * from clinico_examenes where "TiposExamen_id" =3
select * from clinico_examenes where id in ('1255','273');
select * from clinico_examenes where id in ('2112');

select * from facturacion_suministros where nombre like ('%ACETAMINO%');

select "tiposTarifa_id",* from tarifarios_tarifariosprocedimientos where "codigoCups_id" = 2112; -- 35000
update tarifarios_tarifariosprocedimientos set "colValorBase"=445000 where id=32724
select  "tiposTarifa_id",* from tarifarios_tarifariosprocedimientos where "codigoCups_id" = 273; -- 35000
select  "tiposTarifa_id",* from tarifarios_tarifariosprocedimientos where "codigoCups_id" = 1254; 


select * from tarifarios_tarifariosprocedimientos where "codigoCups_id" = 1255; -- 35000
select * from tarifarios_tarifariosprocedimientos where "codigoCups_id" = 273; -- 35000
select * from tarifarios_tarifariosprocedimientos where "codigoCups_id" = 1254; 
update tarifarios_tarifariosprocedimientos set "colValorBase"=36000 where id=19027

select * from facturacion_empresas;
select * from contratacion_convenios;
select * from usuarios_usuarios order by id desc;

select * from facturacion_conveniospacienteingresos order by id desc;
update facturacion_conveniospacienteingresos set "consecAdmision"=1 where id=187;

select * from tarifarios_tipostarifa;
delete from facturacion_liquidacion where id = 196

select  u."tipoDoc_id" , tip.nombre tipnombre, u.documento documentoPaciente, u.nombre nombre, case when genero = 'M' then 'Masculino' when genero= 'F' then 'Femenino' end as genero, cast((date_part('year', now()) - date_part('year', u."fechaNacio" )) as text) edad,   reg.nombre regimen, convenio.nombre convenio , serv.nombre servicio, cast(now() as text) fecha
	from admisiones_ingresos adm
	INNER JOIN         usuarios_usuarios u ON (u."tipoDoc_id" = adm."tipoDoc_id" and u.id = adm.documento_id) 
	INNER JOIN usuarios_tiposDocumento tip ON (tip.id = u."tipoDoc_id")
	INNER JOIN facturacion_conveniospacienteingresos  convIngreso ON (convIngreso."tipoDoc_id" = adm."tipoDoc_id" and convIngreso.documento_id = adm.documento_id and convIngreso."consecAdmision" = adm.consec) 
	INNER JOIN contratacion_convenios convenio ON (convenio.id = convIngreso.convenio_id)
	INNER JOIN facturacion_empresas EMP on (emp.id =convenio.empresa_id )
	INNER JOIN clinico_regimenes reg ON (reg.id=emp.regimen_id) 
	INNER JOIN sitios_serviciossedes serv ON (serv.id = adm."serviciosActual_id")       
wHERE adm."tipoDoc_id" = '1' AND adm.documento_id= '55' AND adm.consec = '1' and convenio.id = '8'