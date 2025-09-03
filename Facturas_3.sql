select documento_id, convenio_id,* from facturacion_facturacion;
select * from factutracion_facturaciondetalle;
select * from facturacion_refacturacion;
 
select * from facturacion_liquidacion where documento_id='43'
select * from facturacion_liquidaciondetalle where liquidacion_id=203

	update facturacion_liquidaciondetalle set "estadoRegistro" = 'A' where liquidacion_id=203
select * from admisiones_ingresos where documento_id='43'
SELECT * FROM USUARIOS_USUARIOS WHERE ID=43

	SELECT  * FROM sitios_serviciosSedes

select * from facturacion_liquidacion where documento_id='43'
	select * from facturacion_liquidaciondetalle where liquidacion_id=203
	select * from facturacion_facturacion where  documento_id='43'
	select * from facturacion_facturaciondetalle where  facturacion_id=62

select * from cartera_pagos where documento_id='43';
UPDATE cartera_pagos SET "valorEnCurso" = 150000  where id = 214
UPDATE cartera_pagos SET "valorEnCurso" = 100000  where id =210

	
select * from cartera_pagosfacturas;
select * from facturacion_liquidacion where documento_id='43'
select * from facturacion_refacturacion;
SELECT * FROM ADMISIONES_INGRESOS WHERE DOCUMENTO_ID='43'

SELECT * FROM FACTURACION_FACTURACION;

UPDATE FACTURACION_FACTURACION
SET "cufeDefinitivo" = '6b7dd1910792ec82b16f5a30d83da5c8f10895b42e3a685a8ee0f0edfc9e32e087576ba23525a50091a6eeb5bd9a9c5e' ,
     "codigoQr" = 'C:\EntornosPython\Pos6\JSONCLINICA\CodigosQr\Factura_1.png'
where id = 64

select * from sitios_historialdependencias where documento_id='43'