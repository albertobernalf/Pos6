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
from clinico.models import Historia, HistoriaExamenes, Examenes, TiposExamen, EspecialidadesMedicos, Medicos, Especialidades, TiposFolio, CausasExterna, EstadoExamenes, HistorialAntecedentes, HistorialDiagnosticos, HistorialInterconsultas, EstadosInterconsulta, HistorialIncapacidades,  HistoriaSignosVitales, HistoriaRevisionSistemas, HistoriaMedicamentos
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
from facturacion.models import ConveniosPacienteIngresos

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


class PDFAtencionInicialUrgencias(FPDF):
    def __init__(self, tipoDocId, documentoId, consec,  *args, **kwargs):
    #def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.tipoDocId = tipoDocId
        self.documentoId = documentoId
        self.consec = consec


    def header(self):
        # Move to the right
        # self.cell(12)

        ## CURSOR PARA LEER ENCABEZADO
        #
        miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                       password="123456")

        curt = miConexiont.cursor()

        comando = 'select ' + "'" + str('Paciente en trauma') + "'" + ' seInforma, substring(cast(current_timestamp as text),1,10) fecha , substring(cast(current_time as text), 1,5) as time,emp.nombre nombreEmpresa, substring(sed.nit,1,9) nit, substring(sed.nit,9,1) nitVerificacion, sed."codigoHabilitacion" habilita,emp.direccion direccionPrestador, emp.telefono telefonoPrestador, dep.nombre departamentoPrestador, dep."departamentoCodigoDian" codigoDepartamentoPrestador, mun.nombre municipioPrestador FROM facturacion_empresas emp INNER JOIN sitios_sedesclinica sed ON (sed.id=1) INNER JOIN sitios_departamentos dep ON (dep.id=emp.departamento_id) INNER JOIN sitios_municipios mun ON (mun.id = emp.municipio_id) WHERE emp. nombre like (' + "'" + str('%MEDICAL%') + "')"

        curt.execute(comando)
        print(comando)

        historia = []

        for seInforma, fecha, time, nombreEmpresa, nit, nitVerificacion, habilita, direccionPrestador, telefonoPrestador, departamentoPrestador, codigoDepartamentoPrestador, municipioPrestador in curt.fetchall():
            historia.append(
                {'seInforma': seInforma, 'fecha': fecha, 'time': time, 'nombreEmpresa': nombreEmpresa,
                 'nit': nit, 'nitVerificacion': nitVerificacion, 'habilita': habilita,
                 'direccionPrestador': direccionPrestador, 'telefonoPrestador': telefonoPrestador,
                 'departamentoPrestador': departamentoPrestador,
                 'codigoDepartamentoPrestador': codigoDepartamentoPrestador, 'municipioPrestador': municipioPrestador})

        miConexiont.close()

        ## FIN CURSOR

        # Title
        #
        self.ln(4)
        self.set_font('Times', 'B', 7)
        self.cell(180, 1, 'ANEXO TECNICO No. 2345678', 0, 0, 'C')
        self.ln(1)
        self.cell(180, 11, 'INFORME DE LA ATENCION INICIAL DE URGENCIAS: ', 0, 0, 'C')
        self.set_font('Times', '', 7)

        # Define el ancho de línea
        self.set_line_width(0.4)
        # Dibuja el borde
        self.rect(5.0, 18.0, 200.0, 180.0)  # Coordenadas x, y, ancho, alto
        self.ln(3)
        # Logo
        self.image('C:/EntornosPython/Pos6/static/img/MedicalFinal.jpg', 7, 19, 11, 11)
        # Arial bold 15
        self.set_font('Times', 'B', 7)
        self.ln(3)
        self.cell(180, 11, 'MINISTERIO DE LA PROTECCION SOCIAL: ', 0, 0, 'C')
        self.ln(3)
        self.cell(180, 11, 'INFORME DE LA ATENCION INICIAL DE URGENCIAS: ', 0, 0, 'C')
        self.ln(6)
        self.set_font('Times', 'B', 7)
        self.cell(80, 11, 'INFORMACION DEL PRESTADOR: ', 0, 0, 'L')

        self.cell(45, 11, 'NUMERO DE ATENCION: ', 0, 0, 'L')
        self.set_font('Times', '', 7)
        self.set_line_width(0.3)
        self.rect(135.0, 29.0, 13.0, 3.0)  # Coordenadas x, y, ancho, alto
        self.cell(15, 11, '527733', 0, 0, 'L')
        self.set_font('Times', 'B', 7)
        self.cell(10, 11, 'Fecha: ', 0, 0, 'L')
        self.set_font('Times', '', 7)
        self.cell(25, 11, historia[0]['fecha'], 0, 0, 'L')
        self.set_font('Times', 'B', 7)
        self.cell(10, 11, 'Hora: ', 0, 0, 'L')
        self.set_font('Times', '', 7)
        self.cell(25, 11, historia[0]['time'], 0, 0, 'L')
        self.ln(1)
        self.set_line_width(0.3)
        self.rect(5.0, 36.0, 100.0, 3.0)  # Coordenadas x, y, ancho, alto
        self.cell(120, 23, historia[0]['nombreEmpresa'], 0, 0, 'L')
        self.cell(25, 23, 'Nit: ', 0, 0, 'L')
        self.cell(25, 23, 'X', 0, 0, 'L')
        self.cell(20, 23, historia[0]['nit'], 0, 0, 'L')
        self.cell(20, 23, historia[0]['nitVerificacion'], 0, 0, 'L')
        self.cell(25, 23, 'CC', 0, 0, 'L')
        self.cell(25, 23, 'Numero', 0, 0, 'L')
        self.cell(25, 23, 'DV', 0, 0, 'L')
        self.ln(3)
        self.set_line_width(0.3)
        self.rect(5.0, 39.0, 200.0, 6.0)  # Coordenadas x, y, ancho, alto

        self.cell(25, 23, 'Codigo:', 0, 0, 'L')
        self.cell(25, 23, historia[0]['habilita'], 0, 0, 'L')
        self.cell(25, 23, 'Direccion Prestador:', 0, 0, 'L')
        self.cell(25, 23, historia[0]['direccionPrestador'], 0, 0, 'L')
        self.ln(3)
        self.cell(25, 23, 'Telefono:', 0, 0, 'L')
        self.cell(25, 23, historia[0]['telefonoPrestador'], 0, 0, 'L')
        self.ln(3)
        self.set_line_width(0.3)
        self.rect(5.0, 45.0, 200.0, 3.0)  # Coordenadas x, y, ancho, alto
        self.cell(25, 23, 'Indicativo:', 0, 0, 'L')
        self.cell(25, 23, 'Numero:', 0, 0, 'L')
        self.cell(25, 23, 'Departamento:', 0, 0, 'L')
        self.cell(25, 23, historia[0]['departamentoPrestador'], 0, 0, 'L')
        self.cell(25, 23, historia[0]['codigoDepartamentoPrestador'], 0, 0, 'L')
        self.cell(25, 23, 'Municipio:', 0, 0, 'L')
        self.cell(25, 23, historia[0]['municipioPrestador'], 0, 0, 'L')
        self.ln(3)
        self.cell(85, 23, 'Entidad a ala que se le informa (Pagador):', 0, 0, 'L')
        self.cell(25, 23, historia[0]['seInforma'], 0, 0, 'L')
        self.cell(25, 23, 'Codigo):', 0, 0, 'L')
        self.ln(3)

        # Line break
        self.ln(10)


def ImprimirAtencionInicialUrgencias(ingresoId2):
    # Instantiation of inherited class
    print("Entre ImprimirAtencionInicialUrgencias ", ingresoId2)


    #ingresoId = request.POST["ingresoId"]
    print("ingresoId2 = ", ingresoId2)
    ingresoId = ingresoId2

    ingresoPaciente = Ingresos.objects.get(id=ingresoId)
    tipoDocId = ingresoPaciente.tipoDoc_id
    print("tipoDocId = ", tipoDocId)
    documentoId = ingresoPaciente.documento_id
    print("documentoId = ", documentoId)
    consec =  ingresoPaciente.consec
    print ("consec = ",consec)
    pacienteId = Usuarios.objects.get(id=documentoId)
    print("documentoPaciente = ", pacienteId.documento)

    pdf = PDFAtencionInicialUrgencias(tipoDocId, documentoId, consec)
    #pdf = PDFAtencionInicialUrgencias()
    pdf.alias_nb_pages()
    pdf.set_margins(left=10, top=5, right=5)
    pdf.add_page()
    pdf.set_font('Times', '', 8)
    pdf.ln(1)
    linea = 7

    # El propgrama debe preguntar desde que Folio hasta cual Y/O desde que fecha y hasta cual fecha

    # Cursor recorre Laboratorios

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    # comando ='SELECT substring(usu.nombre,1,(position(' + "' '" +  ' in usu.nombre))) primerNombre,substring(usu.nombre, position(' + "' '" +  ' in usu.nombre),10) segundoNombre, 0  primerApellido, 0  segundoApellido , usu."tipoDoc_id" tipoDoc ,usu.documento documento , usu."fechaNacio" fechaNacimiento, usu.direccion direccion, usu.telefono telefono,  dep.nombre departamentoPaciente, mun.nombre municipioPaciente FROM clinico_historia his INNER JOIN admisiones_ingresos ing ON (ing."tipoDoc_id"=his."tipoDoc_id" AND ing.documento_id=his.documento_id and ing.consec=his."consecAdmision") INNER JOIN usuarios_usuarios usu ON (usu."tipoDoc_id"=his."tipoDoc_id" AND usu.id=his.documento_id) INNER JOIN sitios_departamentos dep ON (dep.id=usu.departamentos_id) INNER JOIN sitios_municipios mun ON (mun.id = usu.municipio_id) INNER JOIN clinico_servicios servicios on ( servicios.id=ing."serviciosActual_id") WHERE ing.id = ' + "'" + str(50137) + "'" + ' AND servicios.NOMBRE LIKE (' + "'" + str('%URGENC%') + "')" + ' group by primerNombre, segundoNombre, usu."tipoDoc_id",usu.documento, usu."fechaNacio" , usu.direccion , usu.telefono , dep.nombre , mun.nombre'

    comando = 'SELECT usu."primerNombre"  primerNombre, usu."segundoNombre"  segundoNombre, usu."primerApellido"  primerApellido, usu."segundoApellido" segundoApellido , usu."tipoDoc_id" tipoDoc ,usu.documento documento , usu."fechaNacio" fechaNacimiento, usu.direccion direccion, usu.telefono telefono,  dep.nombre departamentoPaciente, mun.nombre municipioPaciente FROM admisiones_ingresos ing INNER JOIN usuarios_usuarios usu ON (usu."tipoDoc_id"=ing."tipoDoc_id" AND usu.id=ing.documento_id) INNER JOIN sitios_departamentos dep ON (dep.id=usu.departamentos_id) INNER JOIN sitios_municipios mun ON (mun.id = usu.municipio_id) INNER JOIN clinico_servicios servicios on ( servicios.id=ing."serviciosActual_id") WHERE ing.id = ' + "'" + str(ingresoId) + "'" + ' AND servicios.NOMBRE LIKE (' + "'" + str('%URGENC%') + "')" + ' group by usu."primerNombre", usu."segundoNombre", usu."primerApellido", usu."segundoApellido", usu."tipoDoc_id",usu.documento, usu."fechaNacio" , usu.direccion , usu.telefono , dep.nombre , mun.nombre'

    curt.execute(comando)

    print(comando)

    atencionUrgencias = []

    for primerNombre, segundoNombre, primerApellido, segundoApellido, tipoDoc, documento, fechaNacimiento, direccion, telefono, departamentoPaciente, municipioPaciente in curt.fetchall():
        atencionUrgencias.append(
            {'primerNombre': primerNombre, 'segundoNombre': segundoNombre, 'primerApellido': primerApellido,
             'segundoApellido': segundoApellido, 'tipoDoc': tipoDoc, 'documento': documento,
             'fechaNacimiento': fechaNacimiento, 'direccion': direccion, 'telefono': telefono,
             'departamentoPaciente': departamentoPaciente, 'municipioPaciente': municipioPaciente})
    miConexiont.close()

    print("atencionUrgencias = ", atencionUrgencias)
    pdf.set_line_width(0.3)
    pdf.rect(5.0, 55.0, 200.0, 3.0)  # Coordenadas x, y, ancho, alto

    pdf.set_font('Times', 'B', 7)
    pdf.cell(180, 9, 'DATOS DEL PACIENTE:', 0, 0, 'C')
    pdf.set_font('Times', '', 7)
    pdf.ln(3)
    print("pase_1 con data", atencionUrgencias[0]['primerApellido'])
    pdf.set_line_width(0.3)
    pdf.rect(5.0, 58.0, 50.0, 4.0)  # Coordenadas x, y, ancho, alto
    pdf.cell(50, 11, str(atencionUrgencias[0]['primerApellido']), 0, 0, 'L')
    pdf.rect(50.0, 58.0, 50.0, 4.0)  # Coordenadas x, y, ancho, alto
    pdf.cell(50, 11, str(atencionUrgencias[0]['segundoApellido']), 0, 0, 'L')
    pdf.rect(100.0, 58.0, 50.0, 4.0)  # Coordenadas x, y, ancho, alto
    pdf.cell(50, 11, str(atencionUrgencias[0]['primerNombre']), 0, 0, 'L')
    pdf.rect(150.0, 58.0, 55.0, 4.0)  # Coordenadas x, y, ancho, alto
    pdf.cell(50, 11, str(atencionUrgencias[0]['segundoNombre']), 0, 0, 'L')

    pdf.ln(3)
    pdf.cell(50, 12, 'primerApellido', 0, 0, 'L')
    pdf.cell(50, 12, 'segundorApellido', 0, 0, 'L')
    pdf.cell(50, 12, 'primerNombre', 0, 0, 'L')
    pdf.cell(50, 12, 'segundoNombre', 0, 0, 'L')
    pdf.ln(4)
    pdf.cell(25, 13, 'Tipo Documento Identificacion', 0, 0, 'L')
    pdf.ln(3)
    pdf.cell(25, 14, 'Registro Civil', 0, 0, 'L')
    pdf.cell(25, 14, 'Pasaporte', 0, 0, 'L')
    pdf.cell(25, 15, 'Tarjeta de Identidad', 0, 0, 'L')
    pdf.cell(35, 15, 'Adulto sin Identificacion', 0, 0, 'L')
    pdf.cell(25, 14, 'Numero de Documento de Identificacion', 0, 0, 'L')
    pdf.ln(3)
    pdf.cell(25, 16, 'Cedula de ciudadania', 0, 0, 'L')
    pdf.cell(25, 16, 'Menor sin identificacion', 0, 0, 'L')
    pdf.ln(3)
    pdf.cell(120, 17, 'Cedula de extranjeria', 0, 0, 'L')
    pdf.cell(25, 17, 'Fecha de nacimiento', 0, 0, 'L')
    pdf.cell(25, 17, str(atencionUrgencias[0]['fechaNacimiento']), 0, 0, 'L')
    pdf.ln(3)

    pdf.cell(60, 18, 'Direccion de residencia habitual', 0, 0, 'L')
    pdf.cell(25, 18, str(atencionUrgencias[0]['direccion']), 0, 0, 'L')
    pdf.cell(25, 18, 'Direccion de residencia habitual', 0, 0, 'L')
    pdf.cell(25, 19, str(atencionUrgencias[0]['telefono']), 0, 0, 'L')
    pdf.ln(3)
    pdf.cell(60, 20, 'Departamento', 0, 0, 'L')
    pdf.cell(25, 20, str(atencionUrgencias[0]['departamentoPaciente']), 0, 0, 'L')
    pdf.cell(25, 20, 'Municipio', 0, 0, 'L')
    pdf.cell(25, 20, str(atencionUrgencias[0]['municipioPaciente']), 0, 0, 'L')
    pdf.ln(3)
    pdf.set_line_width(0.3)
    pdf.rect(5.0, 90.0, 200.0, 8.0)  # Coordenadas x, y, ancho, alto

    pdf.cell(35, 22, 'Cobertura en salud', 0, 0, 'L')
    pdf.ln(1)
    pdf.cell(35, 23, 'Regimen Contributtivo', 0, 0, 'L')
    pdf.cell(35, 23, 'Regimen subsidiado parcial', 0, 0, 'L')
    pdf.cell(45, 23, 'Poblacion pobre No asegurada con sisben', 0, 0, 'L')
    pdf.cell(35, 23, 'Plan adicional en salud', 0, 0, 'L')
    pdf.ln(3)
    pdf.cell(35, 24, 'Regimen subsidiado total', 0, 0, 'L')
    pdf.cell(35, 24, 'Poblacion pobre No asegurada sin sisben', 0, 0, 'L')
    pdf.cell(45, 24, 'Desplazado', 0, 0, 'L')
    pdf.cell(35, 24, 'Otro', 0, 0, 'L')
    pdf.ln(3)
    pdf.set_line_width(0.3)
    pdf.rect(5.0, 98.0, 200.0, 3.0)  # Coordenadas x, y, ancho, alto
    pdf.set_font('Times', 'B', 7)

    #miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
    #                               password="123456")
    #curt = miConexiont.cursor()

    #comando = 'select ext.id id ,ext.nombre causa from admisiones_ingresos ing inner join clinico_historia his ON (his."tipoDoc_id" = ing."tipoDoc_id" and his.documento_id = ing.documento_id and his."consecAdmision" = ing.consec) inner join clinico_causasexterna ext on (ext.id=his."causasExterna_id") where ing.id= ' + "'" + str(
    #    ingresoId2) + "'" + ' AND his.id = ' + "'" + str(historiaId) + "'"

    #curt.execute(comando)

    #print(comando)

    #externaUrgencias = []

    #for id, causa in curt.fetchall():
    #    externaUrgencias.append(
    #        {'id': id, 'causa': causa})
    #miConexiont.close()

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'select tri.id id ,tri."clasificacionTriage_id" triage from triage_triage tri WHERE tri."tipoDoc_id" = ' + "'" + str(tipoDocId) + "'" + ' and tri.documento_id = ' + "'" + str(documentoId) + "'" + ' and tri."consecAdmision" = ' + "'" + str(consec) + "'"

    curt.execute(comando)

    print(comando)

    triageUrgencias = []

    for id, triage in curt.fetchall():
        triageUrgencias.append(
            {'id': id, 'triage': triage})
    miConexiont.close()

    pdf.cell(200, 25, 'INFORMACION DE LA ATENCION', 0, 0, 'C')
    pdf.set_font('Times', '', 7)
    pdf.ln(3)
    pdf.rect(5.0, 102.0, 200.0, 30.0)  # Coordenadas x, y, ancho, alto
    pdf.set_font('Times', 'B', 7)
    pdf.cell(25, 26, 'Origen de la atencion', 0, 0, 'L')
    pdf.ln(2)
    pdf.set_font('Times', '', 7)
    pdf.cell(25, 27, 'Enfermedad General', 0, 0, 'L')
    #if externaUrgencias[0]['causa'] == 'ENFERMEDAD GENERAL':
    #    pdf.cell(27, 27, 'X', 0, 0, 'L')
    #if externaUrgencias[0]['causa'] == 'ACCIDENTE DE TRABAJO':
    #    pdf.cell(27, 27, 'X', 0, 0, 'L')
    #pdf.cell(25, 27, 'Accidente de trabajo', 0, 0, 'L')
    #if externaUrgencias[0]['causa'] == 'EVENTO CATASTROFICO':
    #    pdf.cell(27, 27, 'X', 0, 0, 'L')
    #pdf.cell(30, 27, 'Evento Catastrofico', 0, 0, 'L')
    if triageUrgencias[0]['triage'] == '1':
        pdf.cell(5, 27, 'X', 0, 0, 'L')
    pdf.cell(40, 27, '', 0, 0, 'L')
    pdf.cell(15, 27, '1. Rojo', 0, 0, 'L')
    pdf.ln(3)

    pdf.cell(25, 28, 'Enfermedad Profesional', 0, 0, 'L')
    #if externaUrgencias[0]['causa'] == 'ENFERMEDAD PROFESIONAL':
    #    pdf.cell(25, 28, 'X', 0, 0, 'L')

    pdf.cell(25, 28, 'Accidente de transito', 0, 0, 'L')
    #if externaUrgencias[0]['causa'] == 'ACCIDENTE DE TRANSITO':
    #    pdf.cell(27, 28, 'X', 0, 0, 'L')

    #if externaUrgencias[0]['causa'] == 'OTROS':
    #    pdf.cell(27, 28, 'X', 0, 0, 'L')
    pdf.ln(1)
    pdf.cell(70, 28, 'Otro tipo de accidente', 0, 0, 'L')

    pdf.cell(40, 30, '', 0, 0, 'L')
    pdf.cell(15, 28, '2. Naranja', 0, 0, 'L')
    if triageUrgencias[0]['triage'] == '2':
        pdf.cell(137, 28, 'X', 0, 0, 'L')
    pdf.ln(1)
    pdf.cell(70, 29, '', 0, 0, 'L')
    pdf.cell(40, 29, 'Clasificacion Triage', 0, 0, 'L')
    pdf.cell(10, 29, '3. Amarillo', 0, 0, 'L')
    if triageUrgencias[0]['triage'] == '3':
        pdf.cell(137, 29, 'X', 0, 0, 'L')
    pdf.ln(1)
    pdf.cell(120, 30, '', 0, 0, 'L')
    pdf.cell(15, 30, '4. Verde', 0, 0, 'L')
    if triageUrgencias[0]['triage'] == '4':
        pdf.cell(137, 30, 'X', 0, 0, 'L')
    pdf.ln(1)
    pdf.cell(120, 31, '', 0, 0, 'L')
    pdf.cell(15, 31, '5. Azul', 0, 0, 'L')
    if triageUrgencias[0]['triage'] == '5':
        pdf.cell(137, 31, 'X', 0, 0, 'L')

    pdf.set_line_width(0.3)
    pdf.rect(5.0, 105.0, 200.0, 3.0)  # Coordenadas x, y, ancho, alto
    pdf.ln(10)
    pdf.cell(35, 33, 'Ingreso a Urgencias', 0, 0, 'L')
    pdf.cell(15, 34, 'Fecha', 0, 0, 'L')
    pdf.cell(10, 34, 'Hora', 0, 0, 'L')
    pdf.cell(35, 34, 'Paciente viene Remitido', 0, 0, 'L')
    pdf.cell(5, 34, 'Si', 0, 0, 'L')
    pdf.cell(35, 34, 'Paciente viene Remitido', 0, 0, 'L')
    pdf.ln(3)
    pdf.set_line_width(0.3)
    pdf.rect(5.0, 107.0, 200.0, 3.0)  # Coordenadas x, y, ancho, alto
    pdf.cell(5, 35, 'Nombre del prestador de servicios que remite:', 0, 0, 'L')
    pdf.ln(3)
    pdf.set_line_width(0.3)
    pdf.rect(5.0, 109.0, 200.0, 3.0)  # Coordenadas x, y, ancho, alto
    pdf.cell(200, 36, 'Motivo de consulta', 0, 0, 'C')
    pdf.set_line_width(0.3)
    pdf.rect(5.0, 112.0, 200.0, 3.0)  # Coordenadas x, y, ancho, alto
    pdf.ln(4)
    pdf.cell(200, 37, 'Examen Fisico', 0, 0, 'C')
    pdf.ln(2)
    pdf.cell(20, 38, 'Signos Vitales', 0, 0, 'L')
    pdf.cell(5, 38, 'FC', 0, 0, 'L')
    pdf.cell(15, 38, 'FR', 0, 0, 'L')
    pdf.cell(15, 38, 'TA', 0, 0, 'L')
    pdf.cell(15, 38, 'TA', 0, 0, 'L')
    pdf.cell(15, 38, 'Glasgow', 0, 0, 'L')
    pdf.cell(15, 38, 'Temp:', 0, 0, 'L')
    pdf.cell(15, 38, 'Peso:', 0, 0, 'L')
    pdf.ln(3)
    pdf.set_line_width(0.3)
    pdf.rect(5.0, 105.0, 200.0, 20.0)  # Coordenadas x, y, ancho, alto
    pdf.ln(3)
    pdf.cell(35, 40, 'Impresion Diagnostica', 0, 0, 'L')
    pdf.cell(15, 40, 'Codigo', 0, 0, 'L')
    pdf.cell(25, 40, 'Descripcion', 0, 0, 'L')
    pdf.ln(2)
    pdf.cell(15, 41, 'Diagnostico Principal', 0, 0, 'L')
    pdf.ln(2)
    pdf.cell(15, 42, 'Relacionado 1', 0, 0, 'L')
    pdf.ln(2)
    pdf.cell(15, 43, 'Relacionado 2', 0, 0, 'L')
    pdf.ln(2)
    pdf.cell(15, 44, 'Relacionado 3', 0, 0, 'L')
    pdf.set_line_width(0.3)
    pdf.rect(5.0, 143.0, 200.0, 8.0)  # Coordenadas x, y, ancho, alto
    pdf.ln(3)

    pdf.cell(15, 46, 'Destino del paciente', 0, 0, 'L')
    pdf.set_font('Times', '', 7)
    pdf.ln(2)
    pdf.cell(45, 47, 'Domicilio', 0, 0, 'L')
    pdf.cell(45, 47, 'Internacion', 0, 0, 'L')
    pdf.cell(45, 47, 'ContraRemision', 0, 0, 'L')
    pdf.ln(2)
    pdf.cell(45, 48, 'Observacion', 0, 0, 'L')
    pdf.cell(45, 48, 'Remision', 0, 0, 'L')
    pdf.cell(45, 48, 'Otro', 0, 0, 'L')
    pdf.set_line_width(0.3)
    pdf.rect(5.0, 125.0, 200.0, 10.0)  # Coordenadas x, y, ancho, alto
    pdf.ln(3)
    pdf.set_font('Times', 'B', 7)
    pdf.cell(200, 50, 'INFORMACION DE LA PERSONA QUE INFORMA', 0, 0, 'C')
    pdf.set_font('Times', '', 7)
    pdf.ln(3)
    pdf.cell(75, 51, 'Nombre de quien informa', 0, 0, 'L')
    pdf.cell(35, 51, 'Telefono', 0, 0, 'L')
    pdf.ln(2)
    pdf.cell(35, 52, 'Indicativo', 0, 0, 'L')
    pdf.cell(35, 52, 'Numero', 0, 0, 'L')
    pdf.cell(35, 52, 'Extension', 0, 0, 'L')
    pdf.cell(35, 53, 'Cargo o Actividad', 0, 0, 'L')
    pdf.cell(35, 53, 'Telefono Celular', 0, 0, 'L')

    pdf.output('C:/EntornosPython/temporal/temporal/atencionInicialUrgencias.pdf', 'F')

    linea = linea + 3
    pdf.ln(3)

    carpeta = 'C:\EntornosPython\Pos6\JSONCLINICA\HistoriasClinicas/'
    print("carpeta = ", carpeta)

    archivo = carpeta + '' + str(pacienteId.documento) + '_' + 'AtencionInicialUrgencias.pdf'
    print("archivo =", archivo)

    pdf.output(archivo, 'F')

    try:
        # Intenta abrir el archivo directamente
        webbrowser.open(archivo)
    except FileNotFoundError:
        print(f"Error: Archivo no encontrado en {archivo}")
    except Exception as e:
        print(f"Error al abrir el archivo: {e}")

    return JsonResponse({'success': True, 'message': 'Atencion Inicial de Urgencias impresa!'})

