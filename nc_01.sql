select * from cartera_notascredito
select * from cartera_notascreditodetalle
	
update cartera_notascreditodetalle set "tiposNotasCredito_id" =1



select * from cartera_TiposNotasCredito

SELECT ncDet.id , nc.id notaCredito, ncDet."valorNota", ncDet."tiposNotasCredito_id" tipoNota, tip.nombre nombreTipoNota,
	ncDet."ripsProcedimientos_id" ripsProcedimientos,ncDet."ripsMedicamentos_id" ripsMedicamentos,ncDet."ripsConsultas_id" ripsConsultas,
	ncDet."ripsOtrosServicios_id" ripsOtrosServicios,  ncDet."fechaRegistro",  ncDet."usuarioRegistro_id" 
FROM public.cartera_notascredito nc, cartera_notascreditodetalle ncDet, cartera_tiposnotasCredito tip 
WHERE ncDet."notaCredito_id" = '3' AND ncDet."notaCredito_id" = nc.id AND nc."sedesClinica_id" = '1' AND
	ncDet."tiposNotasCredito_id"  = tip.id

select "notasCredito",* from facturacion_facturacion 

