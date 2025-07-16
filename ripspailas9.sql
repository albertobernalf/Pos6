SELECT med.id,"itemFactura", "nomTecnologiaSalud", cums.nombre cums,"concentracionMedicamento", "cantidadMedicamento",  "vrUnitMedicamento", "vrServicio",  consecutivo,
	"tipoMedicamento_id", "unidadMedida_id", "cantidadGlosada", "cantidadAceptada", "cantidadSoportado", "valorGlosado","vAceptado",   
	"valorSoportado","motivoGlosa_id", "notasCreditoGlosa", "notasCreditoOtras", "notasDebito"
	FROM public.rips_ripsmedicamentos med, public.rips_ripscums cums where med.id= '6' and cum ="nomTecnologiaSalud"

select * 	FROM public.rips_ripsmedicamentos;


UPDATE rips_ripsmedicamentos SET "cantidadGlosada"= '0', "cantidadAceptada" = '0',"cantidadSoportado" = '0',"valorGlosado"= '15000',"vAceptado" = '15000',
	"valorSoportado" = '0',"notasCreditoGlosa" = '0',
	"notasCreditoOtras "= '0',"notasDebito" = '0' 
	WHERE id = 13

select * from cartera_glosas;
select * from cartera_motivosglosas;

    totalAceptadoServ = RipsProcedimientos.objects.all().filter(glosa_id=glosaId).aggregate(totalA=Coalesce(Sum('vAceptado'), 0))
    totalSoportadoServ = RipsProcedimientos.objects.all().filter(glosa_id=glosaId).aggregate(totalS=Coalesce(Sum('valorSoportado'), 0))
    totalGlosadoServ = RipsProcedimientos.objects.all().filter(glosa_id=glosaId).aggregate(totalG=Coalesce(Sum('valorGlosado'), 0))
 


select * from rips_ripstransaccion;
select  sum("valorGlosado"), sum("valorSoportado") , sum("vAceptado") 	FROM public.rips_ripsmedicamentos ripsmed,rips_ripstransaccion ripstra where ripstra.id = ripsmed."ripsTransaccion_id" AND cast(ripstra."numFactura" as float)  = 40 ;
select * 	FROM public.rips_ripsprocedimientos ripsproc ,rips_ripstransaccion ripstra where ripstra.id = ripsproc."ripsTransaccion_id" AND cast(ripstra."numFactura" as float)  = 40 ;;
select * 	FROM public.rips_ripsotrosservicios ripsserv ,rips_ripstransaccion ripstra where ripstra.id = ripsserv."ripsTransaccion_id" AND cast(ripstra."numFactura" as float)  = 40 ;;


select * 	FROM public.rips_ripsmedicamentos;

select  sum("valorGlosado"), sum("valorSoportado") , sum("vAceptado") 	FROM public.rips_ripsmedicamentos ripsmed where  ripsmed.glosa_id = 6 ;

select sum("valorGlosado"), sum("valorSoportado") , sum("vAceptado") FROM public.rips_ripsprocedimientos ripsproc  where  ripsproc.glosa_id = 6 ;
select sum("valorGlosado"), sum("valorSoportado") , sum("vAceptado") 	FROM public.rips_ripsotrosservicios ripsserv 	 where  ripsserv.glosa_id = 6 ;


select * from rips_ripsconsultas;
select * from rips_ripsotrosservicios;
