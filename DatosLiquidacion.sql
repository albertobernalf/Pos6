select * from tarifas_GruposQx;
select * from tarifas_liquidacionhonorarios order by "tipoTarifa_id", "grupoQx_id";
select * from tarifas_LiquidacionHonorariosIss;

select * from facturacion_suministros where id=616;
select * from facturacion_facturacion;
select * from cartera_tipospagos;
select * from cartera_pagos;
select * from usuarios_usuarios;
select * from cartera_formaspagos;
select * from facturacion_liquidacion;

-- Query de pagos


select fo.nombre, sum(pag.valor)
from cartera_formaspagos fo,  cartera_pagos pag
where pag.documento_id = 18 and pag."formaPago_id" = fo.id
group by fo.nombre

-- Sdo query

INSERT into facturacion_liquidacion (documento ,  consecAdmision , fecha ,  totalCopagos ,  totalCuotaModeradora ,  totalAbonos ,  
totalProcedimientos ,  totalSuministros , valorApagar ,  anulado , "fechaCorte" , anticipos, fechaRegistro ,  estadoRegistro  ,   convenio_id ,  tipoDoc_id ,  usuarioRegistro_id )
VALUES (documento,consecAdmision,fecha,totalCopagos, totalCuotaModeradora , totalAbonos,0,0,0,'N' ,'0001-01-01 00:00:00' , anticipos,fechaRegistro,'A', convenio, tipoDoc, usuarioRegistro)
 
 
-- 3er query
select * from facturacion_liquidaciondetalle;

INSERT into facturacion_liquidaciondetalle (  liquidacion ,  consecutivo, fecha ,codigoCups ,    cums ,    cantidad ,    valorUnitario ,    valorTotal ,
    cirugia ,    fechaCrea,     tipoRegistro,    tipoHonorario ,   observaciones,     usuarioRegistro ,    fechaRegistro ,    estadoRegistro 

) VALUES (
liquidacion ,  consecutivo, fecha ,codigoCups ,    cums ,    cantidad ,    valorUnitario ,    valorTotal ,
    cirugia ,    fechaCrea,     tipoRegistro,    tipoHonorario ,   observaciones,     usuarioRegistro ,    fechaRegistro ,    estadoRegistro 
)

-- 4 QUERY update a los totales de la liquidacion de acuerdo a los registros insertados


