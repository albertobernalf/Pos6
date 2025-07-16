select * from rips_ripsmedicamentos;
select * from rips_ripsprocedimientos;
select * from rips_ripscums;
select * from rips_ripstransaccion;
select * from rips_ripshospitalizacion;
select * from facturacion_facturaciondetalle;
select  * from cartera_motivosglosas;
select * from clinico_examenes;
SELECT * FROM rips_ripsconsultas;
SELECT * FROM rips_ripsOTROSSERVICIOS;
select * from rips_ripstipos;
select * from cartera_glosas;
update cartera_glosas set "estadoRadicacion_id"=4 where id = 6;
select * from cartera_estadosglosas;

--Query para detalle de glosas basada en RIPS

select 'MEDICAMENTOS' tipo,med.id, med.consecutivo consec, med."itemFactura",med."nomTecnologiaSalud" codigo,cums.nombre nombre,med."vrServicio",
	 mot.nombre glosaNombre,
	 med."cantidadGlosada",med."cantidadAceptada",med."cantidadSoportado", med."valorGlosado", med."vAceptado", med."valorSoportado",med."notasCreditoGlosa"
FROM rips_ripstransaccion ripstra , rips_ripsmedicamentos med, rips_ripscums cums, facturacion_facturaciondetalle det, cartera_motivosglosas mot
where  cast(ripstra."numFactura" as float) = 40 and med."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and
	med."nomTecnologiaSalud" =  cums.cum and med."itemFactura" = det."consecutivoFactura" and mot.id = med."motivoGlosa_id"
UNION
select 'PROCEDIMIENTOS' tipo,proc.id, proc.consecutivo consec, proc."itemFactura",cast(proc."codProcedimiento_id" as text) codigo,exa.nombre nombre,proc."vrServicio",
	 mot.nombre glosaNombre,
	 proc."cantidadGlosada",proc."cantidadAceptada",proc."cantidadSoportado", proc."valorGlosado", proc."vAceptado", proc."valorSoportado",proc."notasCreditoGlosa"

FROM rips_ripstransaccion ripstra , rips_ripsprocedimientos proc, clinico_examenes exa, facturacion_facturaciondetalle det, cartera_motivosglosas mot
where  cast(ripstra."numFactura" as float) = 40 and proc."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and
	proc."codProcedimiento_id" =  exa.id and proc."itemFactura" = det."consecutivoFactura" and mot.id = proc."motivoGlosa_id"
UNION
select 'CONSULTAS' tipo,cons.id, cons.consecutivo consec, cons."itemFactura",cast(cons."codConsulta_id" as text) codigo ,exa.nombre nombre,cons."vrServicio",
	 mot.nombre glosaNombre,
	 cons."cantidadGlosada",cons."cantidadAceptada",cons."cantidadSoportado", cons."valorGlosado", cons."vAceptado", cons."valorSoportado",cons."notasCreditoGlosa"

FROM rips_ripstransaccion ripstra , rips_ripsconsultas cons, clinico_examenes exa, facturacion_facturaciondetalle det, cartera_motivosglosas mot
where  cast(ripstra."numFactura" as float) = 40 and cons."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and
	cons."codConsulta_id" =  exa.id and cons."itemFactura" = det."consecutivoFactura" and mot.id = cons."motivoGlosa_id"
UNION
select 'OTROS SERVICIOS' tipo,serv.id, serv.consecutivo consec, serv."itemFactura",serv."nomTecnologiaSalud" codigo,cums.nombre nombre,serv."vrServicio",
	 mot.nombre glosaNombre,
	 serv."cantidadGlosada",serv."cantidadAceptada",serv."cantidadSoportado", serv."valorGlosado", serv."vAceptado", serv."valorSoportado",serv."notasCreditoGlosa"
FROM rips_ripstransaccion ripstra , rips_ripsotrosservicios serv, rips_ripscums cums, facturacion_facturaciondetalle det, cartera_motivosglosas mot
where  cast(ripstra."numFactura" as float) = 40 and serv."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and
	serv."codTecnologiaSalud_id" =  cums.id and serv."itemFactura" = det."consecutivoFactura" and mot.id = serv."motivoGlosa_id"
order by 4


detalle = 'select ' + "'" + str('MEDICAMENTOS') +  "'" + ' tipo,med.id, med.consecutivo consec, med."itemFactura",med."nomTecnologiaSalud" codigo,cums.nombre nombre,med."vrServicio",mot.nombre glosaNombre, med."cantidadGlosada",med."cantidadAceptada",med."cantidadSoportado", med."valorGlosado", med."vAceptado", med."valorSoportado",med."notasCreditoGlosa"FROM rips_ripstransaccion ripstra , rips_ripsmedicamentos med, rips_ripscums cums, facturacion_facturaciondetalle det, cartera_motivosglosas mot where  cast(ripstra."numFactura" as float) = ' + str(facturaId) + ' and med."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and med."nomTecnologiaSalud" =  cums.cum and med."itemFactura" = det."consecutivoFactura" and mot.id = med."motivoGlosa_id" UNION select ' + "'" + str('PROCEDIMIENTOS') + "'" +  tipo,proc.id, proc.consecutivo consec, proc."itemFactura",cast(proc."codProcedimiento_id" as text) codigo,exa.nombre nombre,proc."vrServicio",  mot.nombre glosaNombre, proc."cantidadGlosada",proc."cantidadAceptada",proc."cantidadSoportado", proc."valorGlosado", proc."vAceptado", proc."valorSoportado",proc."notasCreditoGlosa" FROM rips_ripstransaccion ripstra , rips_ripsprocedimientos proc, clinico_examenes exa, facturacion_facturaciondetalle det, cartera_motivosglosas mot where  cast(ripstra."numFactura" as float) = ' str(facturaId) + ' and proc."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and proc."codProcedimiento_id" =  exa.id and proc."itemFactura" = det."consecutivoFactura" and mot.id = proc."motivoGlosa_id" UNION select ' + "'"  + str('CONSULTAS') + "'" + ' tipo,cons.id, cons.consecutivo consec, cons."itemFactura",cast(cons."codConsulta_id" as text) codigo ,exa.nombre nombre,cons."vrServicio", 	 mot.nombre glosaNombre, cons."cantidadGlosada",cons."cantidadAceptada",cons."cantidadSoportado", cons."valorGlosado", cons."vAceptado", cons."valorSoportado",cons."notasCreditoGlosa" FROM rips_ripstransaccion ripstra , rips_ripsconsultas cons, clinico_examenes exa, facturacion_facturaciondetalle det, cartera_motivosglosas mot where  cast(ripstra."numFactura" as float) = ' str(facturaId) + ' and cons."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and cons."codConsulta_id" =  exa.id and cons."itemFactura" = det."consecutivoFactura" and mot.id = cons."motivoGlosa_id" UNION select '+ "'" + str('OTROS SERVICIOS') + "'" + ' tipo,serv.id, serv.consecutivo consec, serv."itemFactura",serv."nomTecnologiaSalud" codigo,cums.nombre nombre,serv."vrServicio", 	 mot.nombre glosaNombre, serv."cantidadGlosada",serv."cantidadAceptada",serv."cantidadSoportado", serv."valorGlosado", serv."vAceptado", serv."valorSoportado",serv."notasCreditoGlosa" FROM rips_ripstransaccion ripstra , rips_ripsotrosservicios serv, rips_ripscums cums, facturacion_facturaciondetalle det, cartera_motivosglosas mot where  cast(ripstra."numFactura" as float) = ' + str(facturaId) + ' and serv."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and serv."codTecnologiaSalud_id" =  cums.id and serv."itemFactura" = det."consecutivoFactura" and mot.id = serv."motivoGlosa_id" order by 4'


select * from cartera_glosas;

select * from rips_ripstransaccion;
select * from rips_ripsprocedimientos where "ripsTransaccion_id" = 95;
	select * from clinico_examenes where id in (251,2006,487)

-------------- nueva
-------------------------
--------------------------
select 'MEDICAMENTOS' tipo,med.id, med.consecutivo consec, med."itemFactura",med."nomTecnologiaSalud" codigo,cums.nombre nombre,med."vrServicio",mot.nombre glosaNombre,
	med."cantidadGlosada",med."cantidadAceptada",med."cantidadSoportado", med."valorGlosado", med."vAceptado", med."valorSoportado",med."notasCreditoGlosa" 
	FROM rips_ripstransaccion ripstra , rips_ripsmedicamentos med, rips_ripscums cums, facturacion_facturaciondetalle det, cartera_motivosglosas mot
	where  cast(ripstra."numFactura" as float) = 48 and med."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and
	med."nomTecnologiaSalud" =  cums.cum and med."itemFactura" = det."consecutivoFactura" and mot.id = med."motivoGlosa_id" 
	UNION 
	select 'PROCEDIMIENTOS' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", cast(proc."codProcedimiento_id" as text) codigo, exa.nombre nombre,
	proc."vrServicio", mot.nombre glosaNombre, proc."cantidadGlosada", proc."cantidadAceptada", proc."cantidadSoportado", proc."valorGlosado", proc."vAceptado",
	proc."valorSoportado", proc."notasCreditoGlosa"  FROM  rips_ripstransaccion ripstra, rips_ripsprocedimientos proc, clinico_examenes exa, 
	facturacion_facturaciondetalle det, cartera_motivosglosas mot where cast(ripstra."numFactura" as float) = 48 and 
	proc."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and proc."codProcedimiento_id" = exa.id and 
	proc."itemFactura" = det."consecutivoFactura" and mot.id = proc."motivoGlosa_id"  
	UNION
	select 'CONSULTAS' tipo, cons.id, cons.consecutivo consec,
	cons."itemFactura", cast(cons."codConsulta_id" as text) codigo, exa.nombre nombre, cons."vrServicio", mot.nombre glosaNombre, cons."cantidadGlosada",
	cons."cantidadAceptada", cons."cantidadSoportado", cons."valorGlosado", cons."vAceptado", cons."valorSoportado", cons."notasCreditoGlosa" 
	FROM rips_ripstransaccion  ripstra, rips_ripsconsultas cons, clinico_examenes exa, facturacion_facturaciondetalle det, cartera_motivosglosas mot
	where cast(ripstra."numFactura" as float) = 48 and cons."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and cons. "codConsulta_id" = exa.id and cons."itemFactura" = det."consecutivoFactura" and mot.id = cons."motivoGlosa_id" UNION select 'OTROS SERVICIOS' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, cums.nombre nombre, serv."vrServicio", mot.nombre glosaNombre, serv."cantidadGlosada", serv."cantidadAceptada", serv."cantidadSoportado", serv."valorGlosado", serv."vAceptado", serv."valorSoportado", serv."notasCreditoGlosa" FROM rips_ripstransaccion ripstra, rips_ripsotrosservicios serv, rips_ripscums cums, facturacion_facturaciondetalle  det, cartera_motivosglosas  mot where cast(ripstra."numFactura" as float) = 48 and serv."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and serv."codTecnologiaSalud_id" = cums.id and serv."itemFactura" = det."consecutivoFactura" and mot.id = serv."motivoGlosa_id"  order by 4



select 'PROCEDIMIENTOS' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", cast(proc."codProcedimiento_id" as text) codigo, exa.nombre nombre,
	proc."vrServicio", mot.nombre glosaNombre, proc."cantidadGlosada", proc."cantidadAceptada", proc."cantidadSoportado", proc."valorGlosado", proc."vAceptado",
	proc."valorSoportado", proc."notasCreditoGlosa" 
	FROM  rips_ripstransaccion ripstra inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = proc."itemFactura") left join cartera_motivosglosas mot on (mot.id = proc."motivoGlosa_id")
	where cast(ripstra."numFactura" as float) = 48 

	SELECT proc.id, "itemFactura", proc."codProcedimiento_id" , exa.nombre exa, "vrServicio",	consecutivo,  "cantidadGlosada", "cantidadAceptada", "cantidadSoportado","valorGlosado","vAceptado","valorSoportado","motivoGlosa_id", "notasCreditoGlosa"FROM public.rips_ripsprocedimientos proc, public.clinico_examenes exa 
	where proc.id=223 and proc."codProcedimiento_id" = exa.id

	select * from rips_ripsconsultas;


     SELECT cons.id, "itemFactura", cons."codConsulta_id" , exa.nombre exa, "vrServicio",	consecutivo,  "cantidadGlosada", "cantidadAceptada", "cantidadSoportado","valorGlosado","vAceptado","valorSoportado","motivoGlosa_id", "notasCreditoGlosa" FROM public.rips_ripsconsultas cons, public.clinico_examenes exa   
	where cons.id= 223 and cons."codConsulta_id" = exa.id

SELECT serv.id,"itemFactura",serv."nomTecnologiaSalud", cums.nombre cums, "vrServicio",	consecutivo,  "cantidadGlosada", "cantidadAceptada", "cantidadSoportado","valorGlosado","vAceptado","valorSoportado","motivoGlosa_id", "notasCreditoGlosa" FROM public.rips_ripsotrosservicios serv, public.rips_ripscums cums 
	where serv.id= 133 and serv."codTecnologiaSalud_id" =  cums.id