select * from rips_ripstransaccion;
select * from rips_ripsprocedimientos;
select * from rips_ripsusuarios;
select * from facturacion_facturacion;
select * from contratacion_convenios ;
select * from rips_ripsmedicamentos;

select * from rips_ripscums;
select * from rips_ripsumm;

select * from rips_ripsmedicamentos;
select * from rips_ripsdetalle where id = 56; -- 40
select * from rips_ripstransaccion;

SELECT  ripsproc.id id, "codPrestador", cast("fechaInicioAtencion" as date), "idMIPRES", "numAutorizacion", ripsproc."numDocumentoIdentificacion", "vrServicio",
	"valorPagoModerador",  ripsproc.consecutivo, ripsproc."fechaRegistro", "codComplicacion_id", "codDiagnosticoPrincipal_id", "codDiagnosticoRelacionado_id", 
	"codProcedimiento_id", "codServicio_id", "conceptoRecaudo_id", "finalidadTecnologiaSalud_id", "grupoServicios_id", "modalidadGrupoServicioTecSal_id", 
	ripsproc."tipoDocumentoIdentificacion_id", ripsproc."usuarioRegistro_id", "viaIngresoServicioSalud_id", ripsproc."ripsDetalle_id", "itemFactura",
	ripsproc."ripsTipos_id", "tipoPagoModerador_id", ripsproc."ripsTransaccion_id" 
	FROM public.rips_ripstransaccion ripstra, public.rips_ripsprocedimientos ripsproc 
	WHERE  ripstra.id = ripsproc."ripsTransaccion_id" and cast( ripstra."numFactura" as integer)  =48

-- query glosas

select * from cartera_glosas;	

select id, factura_id,"fechaRecepcion","valorGlosa",  "totalSoportado", "totalAceptado","saldoFactura", observaciones, "fechaRegistro",
	"estadoReg", convenio_id, "usuarioRegistro_id", 
	"fechaRespuesta", "tipoGlosa_id", "usuarioRecepcion_id", "usuarioRespuesta_id",  "estadoRadicacion_id", "estadoRecepcion_id"
from cartera_glosas;		
	
select * from rips_ripscums WHERE cum='19903543-2';

-- query medicamentos
SELECT med.id,"itemFactura", "nomTecnologiaSalud", cums.nombre,"concentracionMedicamento", "cantidadMedicamento",  "vrUnitMedicamento", "vrServicio",  consecutivo,  "tipoMedicamento_id", "unidadMedida_id",
	   "cantidadGlosada", "cantidadAceptada", "cantidadSoportado", 
	"valorGlosado","vAceptado",	 "valorSoportado","motivoGlosa_id", "notasCreditoGlosa", "notasCreditoOtras", "notasDebito"
	FROM public.rips_ripsmedicamentos med, public.rips_ripscums cums 
	where med.id=13 and cum ="nomTecnologiaSalud" ;


SELECT med.id,"itemFactura", "nomTecnologiaSalud", cums.nombre,"concentracionMedicamento", "cantidadMedicamento",  "vrUnitMedicamento", "vrServicio",  consecutivo,  "tipoMedicamento_id", "unidadMedida_id", "cantidadGlosada", "cantidadAceptada", "cantidadSoportado", "valorGlosado","vAceptado",	 "valorSoportado","motivoGlosa_id", "notasCreditoGlosa", "notasCreditoOtras", "notasDebito" FROM public.rips_ripsmedicamentos med, public.rips_ripscums cums where med.id=13 and cum ="nomTecnologiaSalud"

	
	

-- query glosas

select * from cartera_glosasdetalle;	