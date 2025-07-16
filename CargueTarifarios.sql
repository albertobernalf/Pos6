select * from tarifas_tarifassuministros where "tipoTarifa_id"=5;
update tarifas_tarifassuministros set concepto_id =6 where "tipoTarifa_id"=5;
select * from contratacion_conveniossuministros;
select * from contratacion_convenioSPROCEDIMIENTOS

select * from facturacion_suministros where id =  616;
select * from facturacion_conceptos

select * from contratacion_conveniossumnistros;

SELECT * FROM TARIFAS_TIPOSTARIFA;
select * from contratacion_convenios

-- honor

select id,"tipoHonorario_id", "tipoSalas_id",descripcion,"minUvr", "maxUvr", valor, *
from tarifas_honorariosiss 
order by "tipoHonorario_id";




select "codigoCups", nombre, "cantidadUvr", "uvrAño_id","grupoQx_id",  * from clinico_examenes  where id <=  1600 order by "codigoCups" ;

update clinico_examenes set "grupoQx_id" = 5 , "uvrAño_id" = 1 where nombre <= 'C';

update clinico_examenes set "grupoQx_id" = 12 , "uvrAño_id" = 1   where nombre > 'C' and nombre <= 'H';

update clinico_examenes set "grupoQx_id" = 17 , "uvrAño_id" = 1   where nombre > 'I' and nombre <= 'M';

update clinico_examenes set "grupoQx_id" = 23 , "uvrAño_id" = 1  where nombre > 'M' and nombre <= 'Z'

select * from tarifas_GruposQx;

select * from tarifas_liquidaciontarifashonorarios;

update tarifas_honorariosiss set "tipoSalas_id" = 10  WHERE id in (15);

select * from tarifas_tipossalas;
select * from tarifas_tiposHonorarios;

select * from tarifas_liquidaciontarifashonorarios;

select id,"grupoQx_id", "tipoHonorario_id", "tipoSalas_id",descripcion, valor, *
from tarifas_HonorariosSoat 
order by "tipoHonorario_id", "grupoQx_id";

select "codigoCups", nombre, "cantidadUvr", "uvrAño_id","grupoQx_id",  * from clinico_examenes order by "grupoQx_id" --  where id <=  1600 order by "codigoCups" ;
-- 3876 / 9787


select * from contratacion_liquidaciontarifashonorarios ;
-- Carque SOAT

INSERT INTO tarifas_liquidaciontarifashonorarios ("codigoHomologado",descripcion,valor,"fechaRegistro","estadoReg", "codigoCups_id", "codigoSuministro_id",
               "tipoHonorario_id", "tipoTarifa_id","usuarioRegistro_id")
select 'yyyy',exa.nombre,soat.valor,'2024-10-30 00:00:00','A',exa.id,null,soat."tipoHonorario_id",1,1
from clinico_examenes exa,tarifas_HonorariosSoat soat
where exa."grupoQx_id" = soat."grupoQx_id" and soat."tipoHonorario_id"=1 -- 3482
order by exa.nombre
-- group by exa.nombre,soat.valor,exa.id,soat."tipoHonorario_id"

-- Carque ISS
select id,"tipoHonorario_id", "tipoSalas_id",descripcion,"minUvr", "maxUvr", valor, *
from tarifas_honorariosiss 
order by "tipoHonorario_id";

select "codigoCups", nombre, "cantidadUvr", "uvrAño_id","grupoQx_id",  * from clinico_examenes order by "cantidadUvr"

update clinico_examenes set "cantidadUvr" = 31 , "uvrAño_id" = 1 where nombre <= 'C';
update clinico_examenes set "cantidadUvr" = 42 , "uvrAño_id" = 1   where nombre > 'C' and nombre <= 'H';
update clinico_examenes set "cantidadUvr" = 18 , "uvrAño_id" = 1   where nombre > 'I' and nombre <= 'M';
update clinico_examenes set "cantidadUvr" = 25 , "uvrAño_id" = 1  where nombre > 'M' and nombre <= 'Z'



INSERT INTO tarifas_liquidaciontarifashonorarios ("codigoHomologado",descripcion,valor,"fechaRegistro","estadoReg", "codigoCups_id", "codigoSuministro_id",
               "tipoHonorario_id", "tipoTarifa_id","usuarioRegistro_id")
select 'hhhh',exa.nombre,iss.valor,'2024-10-30 00:00:00','A',exa.id,null,iss."tipoHonorario_id",5,1
from clinico_examenes exa,tarifas_honorariosiss iss
where iss."tipoTarifa_id"=5  and "tipoHonorario_id" <= 3 and exa.id in (2073,2074,2075,2115,1601,1602,1603,1604,1605,1606,1607)-- 3482
order by exa.nombre -- 6030 registros


select * from tarifas_honorariosiss; 
select * from tarifas_liquidaciontarifashonorarios where "tipoTarifa_id" = 1 order by "tipoHonorario_id"

select * from contratacion_conveniosliquidaciontarifashonorarios
update tarifas_liquidaciontarifashonorarios SET concepto_id =3 where id in (3542,3541,3540,65,66,67,68,69);
select * from facturacion_conceptos;

select convHon.id sumId, conv.id id, convHon."codigoHomologado" codigoHomologado, convHon.valor valor,  convHon.suministro_id suministroId ,exa.nombre suministroNombre, tipostar.nombre tarifa 
FROM contratacion_convenios conv , contratacion_ConveniosLiquidacionTarifasHonorarios convHon, tarifas_tipostarifa tipostar, facturacion_suministros exa 
WHERE conv.id = convHon.convenio_id and convHon."tipoTarifa_id" = tipostar.id and convHon.suministro_id = exa.id and conv.id = '10'


select * from facturacion_conveniospacienteingresos;
select * from contratacion_conveniosprocedimientos where convenio_id in (10);
select * from contratacion_convenios;

select * from clinico_examenes where id = 238;
select * from usuarios_usuarios;
       
SELECT conv.convenio_id convenio ,proc.cups_id cups, proc.valor tarifaValor
 FROM facturacion_conveniospacienteingresos conv, contratacion_conveniosprocedimientos proc 
WHERE conv."tipoDoc_id" = '1' AND conv.documento_id = '19' AND conv."consecAdmision" = 1 AND
 conv.convenio_id = proc.convenio_id AND proc.cups_id = 238

select * from facturacion_conveniospacienteingresos CONV WHERE conv."tipoDoc_id" = '1' AND conv.documento_id = '19' AND conv."consecAdmision" = 1

SELECT conv.convenio_id convenio ,proc.cups_id cups, proc.valor tarifaValor
 FROM facturacion_conveniospacienteingresos conv, contratacion_conveniosprocedimientos proc 
WHERE conv."tipoDoc_id" = '1' AND conv.documento_id = '19' AND conv."consecAdmision" = 1 AND
 conv.convenio_id = proc.convenio_id AND proc.cups_id = 238 and conv.convenio_id in (select min(c.id) from contratacion_convenios c )


INSERT INTO facturacion_liquidacion ("tipoDoc_id", documento, "consecAdmision", fecha, "totalCopagos", 
"totalCuotaModeradora", "totalProcedimientos" , "totalSuministros" , "totalLiquidacion", "valorApagar", 
anticipos, "fechaRegistro", "estadoRegistro", convenio_id,  "usuarioRegistro_id", "totalAbonos") 
VALUES (' + "'" +  str(tipoDocId.id)  + "','" + str(documentoId.id) + "','" + str(ingresoPaciente) + "','" + str(fechaRegistro) + "'" + '0,0,0,0,0,0,0,' +
 str(fechaRegistro) + "','" + str(estadoReg) + "'," + convenioId + ',' + "'" + str(usuarioRegistro) + "',0)"

select * from facturacion_liquidacion
select * from facturacion_liquidaciondetalle
select * from clinico_historia order by id;
select * from clinico_historiaexamenes order by id;

INSERT INTO facturacion_liquidaciondetalle (consecutivo,fecha, cantidad, "valorUnitario", "valorTotal",cirugia,"fechaCrea", 
"fechaRegistro", "estadoRegistro", "codigoCups_id",  "usuarioRegistro_id", liquidacion_id, "tipoRegistro") 
VALUES (' + "'" +  str(consecutivo)  + "','" + str(fechaRegistro) + "','" + str(cantidad) + "','" + str(fechaRegistro) +
"','" + str(tarifaValor) + "','" + str(tarifaValor)  + "','" + str('N') + "','" + str(fechaRegistro) + "'," + "'" + str(fechaRegistro) + 
"','" + str(estadoReg) + "','" + str(codigoCupsId[0].id) + "','" + str(usuarioRegistro) + "'," + liquidacionId, + ",'" + str(usuarioRegistro) + "')"



select * from cartera_tipospagos;
select * from cartera_formaspagos;
select * from cartera_pagos
--anticipos
select sum(pagOS.valor) 
from cartera_pagos pagos, cartera_formaspagos formas
where pagos."tipoDoc_id" = '1' and pagos.documento_id =18 and pagos.consec=1 and pagos."formaPago_id" = formas.id and
     formas.nombre like ('%ANTICIPO%');

-- abonos

select sum(pagOS.valor) 
from cartera_pagos pagos, cartera_formaspagos formas
where pagos."tipoDoc_id" = '1' and pagos.documento_id =18 and pagos.consec=1 and pagos."formaPago_id" = formas.id and
     formas.nombre like ('%ABONOS%');

-- moderadora

select sum(pagOS.valor) 
from cartera_pagos pagos, cartera_formaspagos formas
where pagos."tipoDoc_id" = '1' and pagos.documento_id =18 and pagos.consec=1 and pagos."formaPago_id" = formas.id and
     formas.nombre like ('%MODERA%');

-- copago

select sum(pagOS.valor) 
from cartera_pagos pagos, cartera_formaspagos formas
where pagos."tipoDoc_id" = '1' and pagos.documento_id =18 and pagos.consec=1 and pagos."formaPago_id" = formas.id and
     formas.nombre like ('%COPA%');


select * from facturacion_liquidaciondetalle;
select * from facturacion_liquidacion;

--  Total Procedimientos

select sum(liq."valorTotal") 
from facturacion_liquidacion fac , facturacion_liquidaciondetalle liq
where fac."tipoDoc_id" = '1' and fac.documento ='19' and fac."consecAdmision"=1 and fac.id = liq.liquidacion_id and
       liq."codigoCups_id" is not null

--  Total Suministros

select sum(liq."valorTotal") 
from facturacion_liquidacion fac , facturacion_liquidaciondetalle liq
where fac."tipoDoc_id" = '1' and fac.documento ='19' and fac."consecAdmision"=1 and fac.id = liq.liquidacion_id and
       liq.cums_id is not null

-- Model.objects.all().aggregate(Sum('number'))
-- FinalProduct_out.objects.filter(entry_date=fecha).aggregate(Sum("dried_lsn_exit_amount"), Sum("frass_exit_amount"))


SELECT (max(p.consecutivo) + 1) cons 
FROM facturacion_liquidaciondetalle p 
WHERE liquidacion_id = 2

select * from facturacion_liquidaciondetalle
select * from usuarios_usuarios;



select liq.id id,consecutivo ,  fecha ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia ,  "fechaCrea" , 
liq.observaciones ,  "estadoRegistro" ,  "codigoCups_id" ,  cums_id , 
case when liq."codigoCups_id" <> null then exa.nombre when liq.cums_id <> null then sum.nombre end nombreExamen ,  
liquidacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro"  
FROM facturacion_liquidaciondetalle liq 
left join clinico_examenes exa on (exa.id = liq."codigoCups_id") 
left join facturacion_suministros sum on (sum.id = liq.cums_id) 
where liquidacion_id= 2 order by consecutivo

select * from clinico_examenes where id=238


select liq.id id,consecutivo ,  fecha ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia ,  "fechaCrea" , 
liq.observaciones ,  "estadoRegistro" ,  "codigoCups_id" ,  cums_id , 
exa.nombre  nombreExamen ,  
liquidacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro"  
FROM facturacion_liquidaciondetalle liq 
inner join clinico_examenes exa on (exa.id = liq."codigoCups_id") 
where liquidacion_id= 2
union
select liq.id id,consecutivo ,  fecha ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia ,  "fechaCrea" , 
liq.observaciones ,  "estadoRegistro" ,  "codigoCups_id" ,  cums_id , 
sum.nombre  nombreExamen ,  
liquidacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro"  
FROM facturacion_liquidaciondetalle liq 
inner join facturacion_suministros sum on (sum.id = liq.cums_id) 
where liquidacion_id= 2 
order by 1

select liq.id id,consecutivo ,  cast(date(fecha) as text)||' '||cast(time(fecha) as text) ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia ,  "fechaCrea" , 
liq.observaciones ,  "estadoRegistro" ,  "codigoCups_id" ,  cums_id , 
exa.nombre  nombreExamen ,  
liquidacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro"  
FROM facturacion_liquidaciondetalle liq 
inner join clinico_examenes exa on (exa.id = liq."codigoCups_id") 
where liquidacion_id= 2
union
select liq.id id,consecutivo ,  cast(date(fecha) as text)||' '||cast(time(fecha) as text) ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia ,  "fechaCrea" , 
liq.observaciones ,  "estadoRegistro" ,  "codigoCups_id" ,  cums_id , 
sum.nombre  nombreExamen ,  
liquidacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro"  
FROM facturacion_liquidaciondetalle liq 
inner join facturacion_suministros sum on (sum.id = liq.cums_id) 
where liquidacion_id= 2 
order by 1
 

             
select * from facturacion_liquidaciondetalle
select * from facturacion_liquidacion
select * from clinico_historiaexamenes order by id
select * from clinico_historia order by id


select liq.id id,  "consecAdmision",  fecha ,  "totalCopagos" ,  "totalCuotaModeradora" ,  "totalProcedimientos" ,
"totalSuministros", "totalLiquidacion", "valorApagar", "fechaCorte", anticipos, "detalleAnulacion", "fechaAnulacion", 
observaciones, liq."fechaRegistro", "estadoRegistro", convenio_id, liq."tipoDoc_id" , liq.documento_id, liq."usuarioRegistro_id", 
"totalAbonos", conv.nombre nombreConvenio, usu.nombre paciente 
FROM facturacion_liquidacion liq, contratacion_convenios conv, usuarios_usuarios usu, admisiones_ingresos adm 
where adm.id = '50083'  AND  liq.convenio_id = conv.id and usu.id = liq.documento_id  and 
adm."tipoDoc_id" = liq."tipoDoc_id" AND adm.documento_id = liq.documento_id  AND adm.consec = liq."consecAdmision"


select *