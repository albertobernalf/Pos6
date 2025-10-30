select * from tblfac_encabezado 
where fec_factura >= '2025-10-20'
order by num_factura;

select * from tblhcl_cirugias --limit 100
where fecha_qx >= '2025-10-01'
order by fecha_qx

select * from tblfac_encabezado where  num_admision in
(1360370,1358649,1360190,1360195)

-- facturas : 513204
514130
514128
514129
513941
--Datos Factura NO 514129:
-- xml
"\\192.168.0.2\FacturacionElectronicaDIAN\nit_830507718\Facturas\CME514129\Generado\fv8305077180002202575386.xml"
-- pdf

-- Datos fgactura 514128
-- pdf
"\\192.168.0.2\FacturacionElectronicaDIAN\nit_830507718\Facturas\CME514128\fv0830507718CME514128.pdf"
-- xml
"\\192.168.0.2\FacturacionElectronicaDIAN\nit_830507718\Facturas\CME514128\Generado\fv8305077180002202567249.xml"