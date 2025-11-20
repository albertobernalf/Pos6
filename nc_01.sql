select * from cartera_notascredito
select * from cartera_notascreditodetalle
	
update cartera_notascreditodetalle set "tiposNotasCredito_id" =1
select * from RIPS_RIPSDETALLE


select * from cartera_TiposNotasCredito


select "notasCredito",* from facturacion_facturacion 
SELECT * FROM RIPS_ripstiposnotas;
select * from rips_ripsenvios
	select * from rips_ripsdetalle where "ripsEnvios_id" = 75
select * from rips_ripsenvios

select * from facturacion_facturacion;
select * from rips_ripsdetalle
	select * from cartera_glosas
	select * from cartera_notascredito
	
SELECT det.id, det."notaCredito_id" item , ncDet.factura_id itemOtro from rips_ripsdetalle det left join cartera_notascredito nc on (nc."ripsEnvio_id" =det."ripsEnvios_id" and nc.id =det."notaCredito_id" )
	left join cartera_notascreditodetalle ncDet on (ncDet."notaCredito_id" =nc.id ) where det."ripsEnvios_id"  = '75'

detalle ='SELECT det.id, det."notaCredito_id" item , ncDet.factura_id itemOtro from rips_ripsdetalle det left join cartera_notascredito nc on (nc."ripsEnvio_id" =det."ripsEnvios_id" and nc.id =det."notaCredito_id" ) left join cartera_notascreditodetalle ncDet on (ncDet."notaCredito_id" =nc.id ) where det."ripsEnvios_id"  = ' + "'" + str(envioRipsId) + "'"

select * from rips_ripstransaccion
select * from rips_ripstiposnotas
	select * from cartera_notascredito
select * from cartera_notascreditodetalle
select * from rips_ripsenvios
	select * from rips_ripsdetalle where "ripsEnvios_id" = 75	

INSERT into rips_ripstransaccion ("numDocumentoIdObligado",  "numNota","fechaRegistro", "tipoNota_id","usuarioRegistro_id" ,"ripsEnvio_id","sedesClinica_id" ,"numFactura" ,"estadoReg") 
	
select substring(sed.nit,1,9) ,  nc.id, now(), tipnot.id, '1', e.id, sed.id , ncDet.factura_id , 	'A'
from sitios_sedesclinica sed, 
	cartera_notascredito nc, 
	cartera_notascreditodetalle ncDet, 	
	rips_ripsEnvios e  , rips_ripsdetalle det ,
	rips_ripstiposnotas tipnot 
where e.id = '75' and e."sedesClinica_id" = sed.id and nc."ripsEnvio_id" = e.id and 
	det."ripsEnvios_id" = e.id and e."ripsTiposNotas_id" = tipnot.id and tipnot.nombre='Nota Credito' AND
	nc.id = '2' and nc.id = ncDet."notaCredito_id"
                
    