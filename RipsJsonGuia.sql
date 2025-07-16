select * from tblrips_encabezado;

select * from tblfac_encabezado limit 250;

select * from tblfac_encabezado where num_factura = '443346';

select distinct prefijo, count(*) from tblfac_encabezado group by prefijo;

-- ruta joson factura tiene
{"rips":{"numDocumentoIdObligado":"830507718","numFactura":"CME443346","tipoNota":null,"numNota":null,
	"usuarios":[{"tipoDocumentoIdentificacion":"CC","numDocumentoIdentificacion":"52967982","tipoUsuario":"01","fechaNacimiento":"1984-04-16","codSexo":"F","codPaisResidencia":"170","codMunicipioResidencia":"11001","codZonaTerritorialResidencia":"02","incapacidad":"NO","consecutivo":1,"codPaisOrigen":"170",
	"servicios":
	{"consultas":[{"codPrestador":"110012215001","fechaInicioAtencion":"2025-02-14 17:53","numAutorizacion":null,"codConsulta":"890701","modalidadGrupoServicioTecSal":"01","grupoServicios":"05","codServicio":1102,"finalidadTecnologiaSalud":"15","causaMotivoAtencion":"38","codDiagnosticoPrincipal":"M773","codDiagnosticoRelacionado1":null,"codDiagnosticoRelacionado2":null,"codDiagnosticoRelacionado3":null,"tipoDiagnosticoPrincipal":"01","tipoDocumentoIdentificacion":"CC","numDocumentoIdentificacion":"1030697237","vrServicio":17706,"conceptoRecaudo":"05","valorPagoModerador":0,"numFEVPagoModerador":null,"consecutivo":1}],
	"urgencias":[{"codPrestador":"110012215001","fechaInicioAtencion":"2025-02-14 16:14","causaMotivoAtencion":"38","codDiagnosticoPrincipal":"M773","codDiagnosticoPrincipalE":"M773","codDiagnosticoRelacionadoE1":null,"codDiagnosticoRelacionadoE2":null,"codDiagnosticoRelacionadoE3":null,"condicionDestinoUsuarioEgreso":"01","codDiagnosticoCausaMuerte":null,"fechaEgreso":"2025-02-14 18:25","consecutivo":1}],
	"medicamentos":[{"codPrestador":"110012215001","numAutorizacion":null,"idMIPRES":null,"fechaDispensAdmon":"2025-02-14 17:52","codDiagnosticoPrincipal":"M773","codDiagnosticoRelacionado":"M773","tipoMedicamento":"01","codTecnologiaSalud":"19992190-03","nomTecnologiaSalud":"DICLOFENACO SODICO 75  mg / 3 ","concentracionMedicamento":0,"unidadMedida":0,"formaFarmaceutica":null,"unidadMinDispensa":1,"cantidadMedicamento":1,"diasTratamiento":1,"tipoDocumentoIdentificacion":"CC","numDocumentoIdentificacion":"1030697237","vrUnitMedicamento":898,"vrServicio":898,"valorPagoModerador":0,"numFEVPagoModerador":null,"consecutivo":1,"conceptoRecaudo":"05"}],
	"otrosServicios":[{"codPrestador":"110012215001","numAutorizacion":null,"idMIPRES":null,"fechaSuministroTecnologia":"2025-02-14 17:52","tipoOS":"01","codTecnologiaSalud":"JERI002","nomTecnologiaSalud":"JERINGA 10 ML ","cantidadOS":1,"tipoDocumentoIdentificacion":"CC","numDocumentoIdentificacion":"1030697237","vrUnitOS":2014,"vrServicio":2014,"valorPagoModerador":0,"numFEVPagoModerador":null,"consecutivo":1,"conceptoRecaudo":"05"}]}}]},

Respuesta 

{"ResultState":true,"ProcesoId":25785,"NumFactura":"CME443346",
	"CodigoUnicoValidacion":"7a4cf97c395e46032be834df7db8b2c644db744649229a900c0690691ee4a8f9daafecfccadc11e650e99439b9e2b5b8",
	"FechaRadicacion":"2025-02-16T07:38:58.9031792-05:00",
	"RutaArchivos":null,
	"ResultadosValidacion":[{"Clase":"NOTIFICACION","Codigo":"FED129","Descripcion":"[Interoperabilidad.Group.Collection.AdditionalInformation.NUMERO_CONTRATO.Value] El apartado
	no existe o no tiene valor en el XML del documento electrónico. Por favor verifique que la etiqueta Xml use mayúsculas y minúsculas según resolución","Observaciones":"",
	"PathFuente":"","Fuente":"FacturaElectronica"},{"Clase":"NOTIFICACION","Codigo":"FED131","Descripcion":"[Interoperabilidad.Group.Collection.AdditionalInformation.NUMERO_POLIZA.Value] 
	El apartado no existe o no tiene valor en el XML del documento electrónico. Por favor verifique que la etiqueta Xml use mayúsculas y minúsculas según resolución",
	"Observaciones":"","PathFuente":"","Fuente":"FacturaElectronica"},{"Clase":"NOTIFICACION","Codigo":"RVC017","Descripcion":
	"El código de CUPS puede ser validado que corresponda a la cobertura o plan de beneficios informada en la factura electrónica de venta.","Observaciones":"Verificar tabla de referencia Dato (890701)"
	,"PathFuente":"usuarios[0].servicios.consultas[0].codConsulta","Fuente":"Rips"},{"Clase":"NOTIFICACION","Codigo":"RVC019",
	"Descripcion":"El código de CUPS se puede validar con el diagnóstico principal.","Observaciones":"Verificar tabla de referencia Dato (890701)",
	"PathFuente":"usuarios[0].servicios.consultas[0].codConsulta","Fuente":"Rips"},{"Clase":"NOTIFICACION","Codigo":"RVC059",
	"Descripcion":"El código de CUPS puede ser validado con el grupo de servicio, servicio, finalidad o causa.",
	"Observaciones":"Verificar tabla de referencia CodConsulta (890701) - Finalidad (15)","PathFuente":"usuarios[0].servicios.consultas[0].codConsulta","Fuente":"Rips"},
	{"Clase":"NOTIFICACION","Codigo":"RVC086","Descripcion":"Se puede validar que el código de diagnóstico relacionado no sea igual al código de diagnóstico principal.",
	"Observaciones":"Codigo de diagnóstico repetido","PathFuente":"usuarios[0].servicios.medicamentos[0].codDiagnosticoRelacionado","Fuente":"Rips"},
	{"Clase":"NOTIFICACION","Codigo":"RVC063","Descripcion":"Se podrá validar la existencia del IUM o del CUM en el catálogo respectivo de SISPRO.",
	"Observaciones":"El código de la tecnología  [19992190-03] no es válido, por favor verificar tabla de referencia.",
	"PathFuente":"usuarios[0].servicios.medicamentos[0].codTecnologiaSalud","Fuente":"Rips"},{"Clase":"NOTIFICACION","Codigo":"RVC065",
	"Descripcion":"Para 01: Medicamento con uso según registro sanitario, 02: Medicamento con uso como vital no disponible definido por INVIMA o 04:
	Medicamento con uso no incluido en el registro sanitario(Listado UNIRS) puede informar null.","Observaciones":"Tenga en cuenta que no es necesario que informe dato para 
	el tipo de medicamento informado ya que el Ministerio de Salud y Protección Social obtiene los datos del medicamento informado a partir del código informado.",
	"PathFuente":"usuarios[0].servicios.medicamentos[0].nomTecnologiaSalud","Fuente":"Rips"},{"Clase":"NOTIFICACION","Codigo":"RVC065",
	"Descripcion":"Para 01: Medicamento con uso según registro sanitario, 02: Medicamento con uso como vital no disponible definido por INVIMA o 
	04: Medicamento con uso no incluido en el registro sanitario(Listado UNIRS) puede informar null.","Observaciones":"Tenga en cuenta que no es necesario que informe dato
	para el tipo de medicamento informado ya que el Ministerio de Salud y Protección Social obtiene los datos del medicamento informado a partir del 
	código informado.","PathFuente":"usuarios[0].servicios.medicamentos[0].concentracionMedicamento","Fuente":"Rips"},{"Clase":"NOTIFICACION","Codigo":"RVC065",
	"Descripcion":"Para 01: Medicamento con uso según registro sanitario, 02: Medicamento con uso como vital no disponible definido por INVIMA o 04: Medicamento con uso
	no incluido en el registro sanitario(Listado UNIRS) puede informar null.","Observaciones":"Tenga en cuenta que no es necesario que informe dato para el tipo de medicamento 
	informado ya que el Ministerio de Salud y Protección Social obtiene los datos del medicamento informado a partir del código informado.",
	"PathFuente":"usuarios[0].servicios.medicamentos[0].unidadMedida","Fuente":"Rips"},{"Clase":"NOTIFICACION","Codigo":"FED129",
	"Descripcion":"[Interoperabilidad.Group.Collection.AdditionalInformation.NUMERO_CONTRATO.Value] El apartado no existe o no tiene valor en el XML del documento electrónico.
	Por favor verifique que la etiqueta Xml use mayúsculas y minúsculas según resolución","Observaciones":"","PathFuente":"","Fuente":"FacturaElectronica"},
	{"Clase":"NOTIFICACION","Codigo":"FED131","Descripcion":"[Interoperabilidad.Group.Collection.AdditionalInformation.NUMERO_POLIZA.Value] 
	El apartado no existe o no tiene valor en el XML del documento electrónico. Por favor verifique que la etiqueta Xml use mayúsculas y minúsculas según resolución",
	"Observaciones":"","PathFuente":"","Fuente":"FacturaElectronica"}]}

Rips: esta en el zip

{
  "numDocumentoIdObligado": "830507718",
  "numFactura": "CME443346",
  "tipoNota": null,
  "numNota": null,
  "usuarios": [
    {
      "tipoDocumentoIdentificacion": "CC",
      "numDocumentoIdentificacion": "52967982",
      "tipoUsuario": "01",
      "fechaNacimiento": "1984-04-16",
      "codSexo": "F",
      "codPaisResidencia": "170",
      "codMunicipioResidencia": "11001",
      "codZonaTerritorialResidencia": "02",
      "incapacidad": "NO",
      "consecutivo": 1,
      "codPaisOrigen": "170",
      "servicios": {
        "consultas": [
          {
            "codPrestador": "110012215001",
            "fechaInicioAtencion": "2025-02-14 17:53",
            "numAutorizacion": null,
            "codConsulta": "890701",
            "modalidadGrupoServicioTecSal": "01",
            "grupoServicios": "05",
            "codServicio": 1102,
            "finalidadTecnologiaSalud": "15",
            "causaMotivoAtencion": "38",
            "codDiagnosticoPrincipal": "M773",
            "codDiagnosticoRelacionado1": null,
            "codDiagnosticoRelacionado2": null,
            "codDiagnosticoRelacionado3": null,
            "tipoDiagnosticoPrincipal": "01",
            "tipoDocumentoIdentificacion": "CC",
            "numDocumentoIdentificacion": "1030697237",
            "vrServicio": 17706,
            "conceptoRecaudo": "05",
            "valorPagoModerador": 0,
            "numFEVPagoModerador": null,
            "consecutivo": 1
          }
        ],
        "urgencias": [
          {
            "codPrestador": "110012215001",
            "fechaInicioAtencion": "2025-02-14 16:14",
            "causaMotivoAtencion": "38",
            "codDiagnosticoPrincipal": "M773",
            "codDiagnosticoPrincipalE": "M773",
            "codDiagnosticoRelacionadoE1": null,
            "codDiagnosticoRelacionadoE2": null,
            "codDiagnosticoRelacionadoE3": null,
            "condicionDestinoUsuarioEgreso": "01",
            "codDiagnosticoCausaMuerte": null,
            "fechaEgreso": "2025-02-14 18:25",
            "consecutivo": 1
          }
        ],
        "medicamentos": [
          {
            "codPrestador": "110012215001",
            "numAutorizacion": null,
            "idMIPRES": null,
            "fechaDispensAdmon": "2025-02-14 17:52",
            "codDiagnosticoPrincipal": "M773",
            "codDiagnosticoRelacionado": "M773",
            "tipoMedicamento": "01",
            "codTecnologiaSalud": "19992190-03",
            "nomTecnologiaSalud": "DICLOFENACO SODICO 75  mg / 3 ",
            "concentracionMedicamento": 0,
            "unidadMedida": 0,
            "formaFarmaceutica": null,
            "unidadMinDispensa": 1,
            "cantidadMedicamento": 1,
            "diasTratamiento": 1,
            "tipoDocumentoIdentificacion": "CC",
            "numDocumentoIdentificacion": "1030697237",
            "vrUnitMedicamento": 898,
            "vrServicio": 898,
            "valorPagoModerador": 0,
            "numFEVPagoModerador": null,
            "consecutivo": 1,
            "conceptoRecaudo": "05"
          }
        ],
        "otrosServicios": [
          {
            "codPrestador": "110012215001",
            "numAutorizacion": null,
            "idMIPRES": null,
            "fechaSuministroTecnologia": "2025-02-14 17:52",
            "tipoOS": "01",
            "codTecnologiaSalud": "JERI002",
            "nomTecnologiaSalud": "JERINGA 10 ML ",
            "cantidadOS": 1,
            "tipoDocumentoIdentificacion": "CC",
            "numDocumentoIdentificacion": "1030697237",
            "vrUnitOS": 2014,
            "vrServicio": 2014,
            "valorPagoModerador": 0,
            "numFEVPagoModerador": null,
            "consecutivo": 1,
            "conceptoRecaudo": "05"
          }
        ]
      }
    }
  ]
}
