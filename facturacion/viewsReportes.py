import json
from django import forms
import cv2
import numpy as np
from fpdf import FPDF
from PyPDF2 import PdfReader
import webbrowser
import psycopg2
import json
import datetime

# import onnx as onnx
# import onnxruntime as ort
import pyttsx3
import speech_recognition as sr
from django.core.serializers import serialize
from django.db.models.functions import Cast, Coalesce
from django.utils.timezone import now
from django.db.models import Avg, Max, Min
#from .forms import historiaForm, historiaExamenesForm
from datetime import datetime
from clinico.models import Historia, HistoriaExamenes, Examenes, TiposExamen, EspecialidadesMedicos, Medicos, Especialidades, TiposFolio, CausasExterna, EstadoExamenes, HistorialAntecedentes, HistorialDiagnosticos, HistorialInterconsultas, EstadosInterconsulta, HistorialIncapacidades,  HistoriaSignosVitales, HistoriaRevisionSistemas, HistoriaMedicamentos, Regimenes
from sitios.models import Dependencias
from planta.models import Planta
from facturacion.models import Liquidacion, LiquidacionDetalle, Suministros, TiposSuministro
#from contratacion.models import Procedimientos
from usuarios.models import Usuarios, TiposDocumento
from cartera.models  import Pagos
from autorizaciones.models import Autorizaciones,AutorizacionesDetalle, EstadosAutorizacion
from contratacion.models import Convenios
from cirugia.models import EstadosCirugias, EstadosProgramacion
from tarifarios.models import TarifariosDescripcion, TarifariosProcedimientos, TarifariosSuministros
from clinico.forms import  IncapacidadesForm, HistorialDiagnosticosCabezoteForm, HistoriaSignosVitalesForm
from django.db.models import Avg, Max, Min , Sum
from usuarios.models import Usuarios, TiposDocumento
from admisiones.models import Ingresos
from farmacia.models import Farmacia, FarmaciaDetalle, FarmaciaEstados
from enfermeria.models import Enfermeria, EnfermeriaDetalle
from facturacion.models import ConveniosPacienteIngresos, Facturacion
from basicas.models import Parametros
from django.contrib import messages
from django.shortcuts import render, get_object_or_404, redirect, HttpResponse, HttpResponseRedirect
from django.core.exceptions import ValidationError
from django.urls import reverse, reverse_lazy
# from django.core.urlresolvers import reverse_lazy
from django.views.generic import ListView, CreateView, TemplateView
from django.http import JsonResponse
import MySQLdb
import pyodbc
import psycopg2
import json
import datetime
import cgi

class PDFFacturacion(FPDF):
    def __init__(self, tipoDocId, documentoId, consec, ingresoId, factura, *args, **kwargs):
    #def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.tipoDocId = tipoDocId
        self.documentoId = documentoId
        self.consec = consec
        self.ingresoId = ingresoId
        self.factura = factura


    def header(self):

        ## CURSOR PARA EMPRESA
        #
        miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                       password="123456")

        curt = miConexiont.cursor()

        comando = 'select ' + "'" + str('Paciente en trauma') + "'" + ' seInforma, substring(cast(current_timestamp as text),1,10) fecha , substring(cast(current_time as text), 1,5) as time,emp.nombre nombreEmpresa, substring(sed.nit,1,9) nit, substring(sed.nit,9,1) nitVerificacion, sed."codigoHabilitacion" habilita,emp.direccion direccionPrestador, emp.telefono telefonoPrestador, dep.nombre departamentoPrestador, dep."departamentoCodigoDian" codigoDepartamentoPrestador, mun.nombre municipioPrestador FROM facturacion_empresas emp INNER JOIN sitios_sedesclinica sed ON (sed.id=1) INNER JOIN sitios_departamentos dep ON (dep.id=emp.departamento_id) INNER JOIN sitios_municipios mun ON (mun.id = emp.municipio_id) WHERE emp. nombre like (' + "'" + str('%MEDICAL%') + "')"

        print(comando)
        curt.execute(comando)


        empresa = []

        for seInforma, fecha, time, nombreEmpresa, nit, nitVerificacion, habilita, direccionPrestador, telefonoPrestador, departamentoPrestador, codigoDepartamentoPrestador, municipioPrestador in curt.fetchall():
            empresa.append(
                {'seInforma': seInforma, 'fecha': fecha, 'time': time, 'nombreEmpresa': nombreEmpresa,
                 'nit': nit, 'nitVerificacion': nitVerificacion, 'habilita': habilita,
                 'direccionPrestador': direccionPrestador, 'telefonoPrestador': telefonoPrestador,
                 'departamentoPrestador': departamentoPrestador,
                 'codigoDepartamentoPrestador': codigoDepartamentoPrestador, 'municipioPrestador': municipioPrestador})

        miConexiont.close()

        ## FIN CURSOR


        self.ln(4)
        self.set_font('Times', 'B', 8)
        self.cell(180, 1, empresa[0]['nombreEmpresa'], 0, 0, 'C')
        self.ln(1)
        self.cell(80, 11, '', 0, 0, 'L')
        self.cell(10, 11, 'N.I.T: ', 0, 0, 'C')
        self.cell(13, 11, empresa[0]['nit'], 0, 0, 'L')
        self.cell(20, 11, empresa[0]['nitVerificacion'], 0, 0, 'L')

        self.ln(5)
        self.cell(70, 11, '', 0, 0, 'L')
        self.cell(30, 12, empresa[0]['direccionPrestador'], 0, 0, 'C')
        self.cell(5, 11, 'Tel:', 0, 0, 'L')
        self.cell(25, 12, empresa[0]['telefonoPrestador'], 0, 0, 'C')
        self.set_font('Times', '', 7)
        # Define el ancho de línea
        self.set_line_width(0.4)
        # Dibuja el borde

        self.rect(5.0, 46.0, 200.0, 220.0)  # Coordenadas x, y, ancho, alto
        self.ln(3)
        # Logo
        self.image('C:/EntornosPython/Pos6/static/img/MedicalFinal.jpg', 7, 5, 30, 17)
        # Arial bold 15
        self.set_font('Times', 'B', 7)
        self.ln(3)
        self.cell(120, 13, 'Cufe : 6b7dd1910792ec82b16f5a30d83da5c8f10895b42e3a685a8ee0f0edfc9e32e087576ba23525a50091a6eeb5bd9a9c5e ', 0, 0, 'L')
        self.ln(3)
        self.cell(30, 14, 'FACTURA DE VENTA:', 0, 0, 'L')
        self.cell(25, 14, str(self.factura), 0, 0, 'L')
        self.cell(60, 14, '', 0, 0, 'L')
        parametro1 = Parametros.objects.get(nombre='Factura_1')
        self.cell(70, 14, str(parametro1.parametro1), 0, 0, 'L')
        #self.cell(70, 14, 'AUTORETENEDOR EN RENTA RESOLUCION 151 DEL 14-01-2016', 0, 0, 'L')
        self.ln(3)
        self.cell(40, 11, '', 0, 0, 'L')
        parametro2 = Parametros.objects.get(nombre='Factura_2')
        self.cell(60, 14, str(parametro2.parametro1), 0, 0, 'L')
        #self.cell(60, 14, 'Gran Contribuyente Res. 0012220 de 26-12-2022 - Actividad económica 8610', 0, 0, 'L')
        self.ln(3)
        self.cell(30, 15, '', 0, 0, 'L')
        fechaExpedicion = datetime.datetime.now()
        self.cell(25, 15, 'Fecha de Expedición:', 0, 0, 'L')
        self.cell(30, 15, str(fechaExpedicion), 0, 0, 'L')

        self.cell(50, 15, 'Fecha de Vencimiento (Cartera):', 0, 0, 'L')
        #self.cell(30, 15, 'Pagina 1 de 4', 0, 0, 'L')
        self.cell(30, 15, 'Pagina ' + str(self.page_no()) + '/{nb}', 0, 0, 'C')
        self.ln(3)
        self.cell(30, 16, '', 0, 0, 'C')
        parametro3 = Parametros.objects.get(nombre='Factura_3')
        self.cell(100, 16, str(parametro3.parametro1), 0, 0, 'L')
        #self.cell(100, 16, 'Favor NO efectuar retención de Industria y Comercio e IVA - Somos agentes retenedores de IVA', 0, 0, 'L')
        self.ln(3)
        self.cell(30, 17, '', 0, 0, 'L')
        parametro4 = Parametros.objects.get(nombre='Factura_2')
        self.cell(100, 17, str(parametro4.parametro1), 0, 0, 'L')
        #self.cell(100, 17, 'Resolución DIAN # 18764069407849 del 22/04/2024 al 22/10/2025 de la CME342.410,00 a la CME500.000,00', 0, 0, 'L')
        self.set_line_width(0.4)
        # Dibuja el borde
        self.rect(5.0,46.0, 200.0, 18.0)  # Coordenadas x, y, ancho, alto
        self.ln(3)

        ## CURSOR PARA PACIENTE
        #
        miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
        curt = miConexiont.cursor()

        comando = 'SELECT ing.id ingreso , usu.nombre, usu."primerNombre"  primerNombre, usu."segundoNombre"  segundoNombre, usu."primerApellido"  primerApellido, usu."segundoApellido" segundoApellido , tipos.abreviatura abreviatura ,usu.documento documento , round(cast(cast((cast(now() as date)  - cast(usu."fechaNacio" as date)) as text) as numeric)/365,0)   edad, ing."fechaIngreso" fechaIngreso, usu.direccion direccion, usu.telefono telefono,  ing."fechaSalida" fechaSalida, dep.nombre departamentoPaciente, mun.nombre municipioPaciente, ing.factura, emp.nombre nombreEmpresa, emp.documento nit 	FROM admisiones_ingresos ing  INNER JOIN facturacion_facturacion fac ON (fac."tipoDoc_id" = ing."tipoDoc_id" AND fac.documento_id=ing.documento_id AND fac."consecAdmision" = ing.consec) INNER JOIN usuarios_usuarios usu ON (usu."tipoDoc_id"=ing."tipoDoc_id" AND usu.id=ing.documento_id)  INNER JOIN sitios_departamentos dep ON (dep.id=usu.departamentos_id) INNER JOIN sitios_municipios mun ON (mun.id = usu.municipio_id) INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id=ing."tipoDoc_id") INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN facturacion_empresas emp ON (emp.id=conv.empresa_id) WHERE ing.id = ' + "'" + str(self.ingresoId) + "'"

        curt.execute(comando)

        print(comando)

        paciente = []

        for ingreso, nombre,primerNombre, segundoNombre, primerApellido, segundoApellido, abreviatura,  documento, edad, fechaIngreso, direccion, telefono,fechaSalida , departamentoPaciente, municipioPaciente, factura, nombreEmpresa, nit in curt.fetchall():
          paciente.append(
            {'ingreso':ingreso,'nombre':nombre,  'primerNombre': primerNombre, 'segundoNombre': segundoNombre, 'primerApellido': primerApellido,
             'segundoApellido': segundoApellido, 'abreviatura': abreviatura, 'documento': documento,'edad':edad,
             'fechaIngreso': fechaIngreso, 'direccion': direccion, 'telefono': telefono,'fechaSalida':fechaSalida,
             'departamentoPaciente': departamentoPaciente, 'municipioPaciente': municipioPaciente, 'factura':factura,'nombreEmpresa':nombreEmpresa, 'nit':nit})

        miConexiont.close()

        ## FIN CURSOR
        self.cell(25, 20, 'Nombre del Paciente:', 0, 0, 'L')
        self.set_font('Times', '', 9)

        self.cell(30, 20, paciente[0]['nombre'], 0, 0, 'C')
        self.set_font('Times', 'B', 7)
        self.cell(25, 20, 'Admision:', 0, 0, 'L')
        self.set_font('Times', '', 9)
        self.cell(20, 20, str(paciente[0]['ingreso']), 0, 0, 'C')
        self.ln(3)
        self.set_font('Times', 'B', 7)
        self.cell(25, 21, 'Identificación:', 0, 0, 'L')
        self.set_font('Times', '', 9)
        self.cell(5, 21, paciente[0]['abreviatura'], 0, 0, 'C')
        self.cell(30, 21, paciente[0]['documento'], 0, 0, 'C')
        self.set_font('Times', 'B', 7)
        self.cell(15, 21, 'Edad:', 0, 0, 'L')
        self.cell(25, 21, str(paciente[0]['edad']), 0, 0, 'C')
        self.cell(20, 21, 'Fec. Ingreso:', 0, 0, 'L')
        self.cell(20, 21, str(paciente[0]['fechaIngreso']), 0, 0, 'C')
        self.ln(3)
        self.cell(25, 22, 'Dirección:', 0, 0, 'L')
        self.cell(50, 22, paciente[0]['direccion'], 0, 0, 'C')
        self.cell(10, 22, 'Teléfono:', 0, 0, 'L')
        self.cell(20, 22, paciente[0]['telefono'], 0, 0, 'C')
        self.cell(20, 22, 'Fec. Egreso:', 0, 0, 'L')
        self.cell(20, 22, str(paciente[0]['fechaSalida']), 0, 0, 'C')
        self.ln(3)
        self.cell(25, 23, 'Municipio:', 0, 0, 'L')
        self.cell(5, 23, paciente[0]['municipioPaciente'], 0, 0, 'C')
        self.ln(3)
        self.cell(25, 23, 'Responsable:', 0, 0, 'L')
        self.cell(60, 24, paciente[0]['nombreEmpresa'], 0, 0, 'C')
        self.cell(8, 24, 'Nit:', 0, 0, 'L')
        self.cell(15, 24, paciente[0]['nit'], 0, 0, 'C')
        self.set_line_width(0.4)
        # Dibuja el borde
        self.rect(5.0,64.0, 200.0, 5.0)  # Coordenadas x, y, ancho, alto
        self.ln(3)
        self.cell(10, 25, 'CUPS', 0, 0, 'L')
        self.cell(20, 25, 'Cod.Tarifa', 0, 0, 'L')
        self.cell(80, 25, 'Descripcion', 0, 0, 'L')
        self.cell(35, 25, 'Cantidad', 0, 0, 'L')
        self.cell(30, 25, 'Vr.Unitario', 0, 0, 'L')
        self.cell(30, 25, 'Vr.Total', 0, 0, 'L')
        self.ln(4)
        self.cell(30, 26, 'Detallado de la Factura', 0, 0, 'L')
        self.ln(4)
        self.set_line_width(0.4)
        # Dibuja el borde
        self.rect(5.0, 74.0, 200.0, 192.5)  # Coordenadas x, y, ancho, alto

def ImprimirFactura(request):

    # Instantiation of inherited class
    ingresoId1 = request.POST["ingresoId"]
    print ("Entre ImprimirFactura")

    llave = ingresoId1.split('-')
    print("llave = ", llave)
    print("primero=", llave[0])
    #print("segundo = ", llave[1])
    #print("tercero o convenio  = ", llave[2])
    factura=llave[0]

    print("factura = ", factura)
    facturaPaciente= Facturacion.objects.get(id=factura)

    # ingresoId = request.POST["ingresoId"]

    ingresoPaciente = Ingresos.objects.get(tipoDoc_id=facturaPaciente.tipoDoc_id, documento_id=facturaPaciente.documento_id, consec=facturaPaciente.consecAdmision)
    ingresoId=ingresoPaciente.id
    print("ingresoId = ", ingresoId)
    tipoDocId = ingresoPaciente.tipoDoc_id
    print("tipoDocId = ", tipoDocId)
    documentoId = ingresoPaciente.documento_id
    print("documentoId = ", documentoId)
    consec = ingresoPaciente.consec
    print("consec = ", consec)
    pacienteId = Usuarios.objects.get(id=documentoId)
    print("documentoPaciente = ", pacienteId.documento)

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")


    curt = miConexiont.cursor()

    comando = 'SELECT tipo.abreviatura abrev, usu.documento documento, usu."primerNombre",usu."segundoNombre",usu."primerApellido", usu."segundoApellido", cast((cast(now() as date)  - cast(usu."fechaNacio" as date)) as text)   edad , usu.genero sexo, ing."fechaIngreso" fechaIngreso FROM admisiones_ingresos ing INNER JOIN usuarios_usuarios usu ON (usu.id=ing.documento_id) INNER JOIN usuarios_tiposdocumento tipo ON (tipo.id = usu."tipoDoc_id") WHERE ing.id= ' + "'" + str(
        ingresoId) + "'"
    print(comando)

    curt.execute(comando)

    print(comando)

    manilla = []

    for abrev, documento, primerNombre, segundoNombre, primerApellido, segundoApellido, edad, sexo, fechaIngreso in curt.fetchall():
        manilla.append(
            {'abrev': abrev, 'documento': documento, 'primerNombre': primerNombre, 'segundoNombre': segundoNombre,
             'primerApellido': primerApellido, 'segundoApellido': segundoApellido,
             'edad': edad, 'sexo': sexo, "fechaIngreso": fechaIngreso})

    miConexiont.close()
    print("manilla = ", manilla)

    pdf = PDFFacturacion(tipoDocId, documentoId, consec, ingresoId, factura ,format="letter")
    pdf.alias_nb_pages()
    pdf.set_margins(left=10, top=5, right=5)
    pdf.add_page()
    pdf.set_font('Times', '', 8)
    pdf.ln(1)
    linea = 7

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    #comando = 'SELECT id, nombre nombreConcepto from facturacion_conceptos '
    comando = 'SELECT distinct con.id, con.nombre nombreConcepto from facturacion_conceptos con INNER JOIN 	 clinico_examenes exa ON (exa.concepto_id = con.id) where exa.id in (select facdet.examen_id from facturacion_facturaciondetalle facdet where facdet.facturacion_id = ' + "'" + str(factura) + "')"

    curt.execute(comando)

    print(comando)
    lineaConcepto=1
    conceptos = []


    for id, nombreConcepto in curt.fetchall():
        conceptos.append(
            {'id': id, 'nombreConcepto': nombreConcepto})

        #pdf.cell(40, 26 + lineaConcepto, str(conceptos[0]['nombreConcepto']), 0, 0, 'C')
        pdf.ln(1)
        pdf.set_font('Times', 'B', 7)
        pdf.cell(200, 22 + lineaConcepto, str(nombreConcepto), 0, 0, 'C')
        pdf.set_font('Times', '', 7)

        pdf.ln(5)

        ## AQUI VIENE EL CURSOR DEL DETALLE DE LA FACTURA

        miConexiony = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                       password="123456")
        cury = miConexiony.cursor()

        comando = 'select exa."codigoCups" cups,tarProc."codigoHomologado" homologado, exa.nombre  descripcion, detFac.cantidad cantidad, detFac."valorUnitario" valorUnitario, detFac."valorTotal" valorTotal FROM facturacion_facturaciondetalle detFac INNER JOIN facturacion_facturacion fac ON (fac.id=detFac.facturacion_id) INNER JOIN clinico_examenes exa on (exa.id=detFac.examen_id) INNER JOIN contratacion_convenios conv ON (conv.id=fac.convenio_id) INNER JOIN tarifarios_tarifariosdescripcion tarDesc ON (tarDesc.id=conv."tarifariosDescripcionProc_id") INNER JOIN tarifarios_tarifariosprocedimientos tarProc ON (tarProc."tiposTarifa_id"=tarDesc."tiposTarifa_id" AND tarProc."codigoCups_id" = detFac.examen_id ) where detfac.facturacion_id= ' + "'" + str(factura) + "' AND exa.concepto_id = " +"'" + str(id) + "'"

        cury.execute(comando)

        detalleFacturacion = []
        lineaDetalle = 1

        for cups, homologado, descripcion, cantidad, valorUnitario, valorTotal  in cury.fetchall():
            detalleFacturacion.append(
                {'cups': cups, 'homologado': homologado,'descripcion':descripcion, 'cantidad':cantidad,'valorUnitario':valorUnitario, 'valorTotal':valorTotal })

            pdf.cell(15, 26 + lineaConcepto + lineaDetalle, str(cups), 0, 0, 'L')
            pdf.cell(15, 26 + lineaConcepto + lineaDetalle, str(homologado), 0, 0, 'L')
            pdf.cell(85, 26 + lineaConcepto + lineaDetalle, str(descripcion), 0, 0, 'L')
            #pdf.multi_cell(w=100, h=10, txt=str(descripcion),  align='J')
            #pdf.multi_cell(w=85, h=3, txt=str(descripcion), align='L' )

            pdf.cell(30, 26 + lineaConcepto + lineaDetalle, str(cantidad), 0, 0, 'L')
            pdf.cell(30, 26 + lineaConcepto + lineaDetalle, str(valorUnitario), 0, 0, 'L')
            pdf.cell(30, 26 + lineaConcepto + lineaDetalle, str(valorTotal), 0, 0, 'L')

            lineaDetalle=lineaDetalle +1

            pdf.ln(3)

        ## FIN CURSOR DETALLE FACTURA

        pdf.ln(4)
        lineaConcepto = lineaConcepto + 1
        pdf.ln(3)


    miConexiont.close()

    ## Aquip totales
    pdf.ln(4)
    pdf.cell(30, 26, 'Valor en letras', 0, 0, 'L')
    pdf.ln(4)

    carpeta = 'C:\EntornosPython\Pos6\JSONCLINICA\HistoriasClinicas/'
    print("carpeta = ", carpeta)

    archivo = carpeta + '' + str(pacienteId.documento) + '_' + 'Factura.pdf'
    print("archivo =", archivo)

    pdf.output(archivo, 'F')

    try:
        # Intenta abrir el archivo directamente
        webbrowser.open(archivo)
    except FileNotFoundError:
        print(f"Error: Archivo no encontrado en {archivo}")
    except Exception as e:
        print(f"Error al abrir el archivo: {e}")

    return JsonResponse({'success': True, 'message': 'Factura impresa!'})



