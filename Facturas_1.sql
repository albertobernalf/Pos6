select * from cartera_pagosfacturas;
select * from cartera_pagos;

comando = 'SELECT "totalFactura" , ("totalRecibido"  - anticipos), anticipos, ' + "'" + str('0') + "'" + ' descuentos, "valorApagar" FROM facturacion_facturacion WHERE id= ' + "'" + str(factura) + "''

select "totalRecibido",* from facturacion_facturacion;
update facturacion_facturacion set "totalRecibido" = 400000 where id=62;

select id, obtienevlrletras(cast("totalFactura" as integer)) from facturacion_facturacion;
select * from facturacion_facturacion

update facturacion_facturacion set "valorAPagarLetras" = obtienevlrletras(cast("totalFactura" as integer))

select * from basicas_parametros;

UPDATE facturacion_facturacion set "cufeDefinitivo" = '6b7dd1910792ec82b16f5a30d83da5c8f10895b42e3a685a8ee0f0edfc9e32e087576ba23525a50091a6eeb5bd9a9c5e' where id=62
UPDATE facturacion_facturacion set "cufeDefinitivo" = '54cf76c8dbc1cdc1d21d0f7240691690ff77282e9568e2b9fa6c5336bba3b5f6257b6913ffff4aaea9d47d549b5acf58' where id=63


	update facturacion_facturacion set "codigoQr" = 'C:\EntornosPython\Pos6\JSONCLINICA\CodigosQr\Factura_1.png'

select * from facturacion_conveniospacienteingresos;
select * from contratacion_convenios

select * from triage_triage