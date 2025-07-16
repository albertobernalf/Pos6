from django.shortcuts import render

import json
from django import forms
import cv2
import numpy as np
import pyttsx3
import speech_recognition as sr
from django.core.serializers import serialize
from django.db.models.functions import Cast, Coalesce
from django.utils.timezone import now
from django.db.models import Avg, Max, Min
from datetime import datetime
from clinico.models import Historia, HistoriaExamenes, Examenes, TiposExamen, EspecialidadesMedicos, Medicos, Especialidades, TiposFolio, CausasExterna, EstadoExamenes, HistorialAntecedentes, HistorialDiagnosticos, HistorialInterconsultas, EstadosInterconsulta, HistorialIncapacidades,  HistoriaSignosVitales, HistoriaRevisionSistemas, HistoriaMedicamentos, HistoriaResultados
from sitios.models import Dependencias
from planta.models import Planta
#from contratacion.models import Procedimientos
from usuarios.models import Usuarios, TiposDocumento
from clinico.forms import  IncapacidadesForm, HistorialDiagnosticosCabezoteForm, HistoriaSignosVitalesForm
from django.db.models import Avg, Max, Min
from usuarios.models import Usuarios, TiposDocumento

from django.contrib import messages
from django.shortcuts import render, get_object_or_404, redirect, HttpResponse, HttpResponseRedirect
from django.core.exceptions import ValidationError
from django.urls import reverse, reverse_lazy
from django.views.generic import ListView, CreateView, TemplateView
from django.http import JsonResponse
import MySQLdb
import pyodbc
import psycopg2
import json 
import datetime 
from django.db.models import Avg, Max, Min



# Create your views here.

def serialize_datetime(obj):
    if isinstance(obj, datetime.datetime):
        return obj.isoformat()
    raise TypeError("Type not serializable")


def load_dataApoyoTerapeutico(request, data):
    print ("Entre load_data ApoyoTerapeutico")

    context = {}
    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']

    nombreSede = d['nombreSede']
    print ("sede:", sede)
    print ("username:", username)
    print ("username_id:", username_id)
    
    # Combo RazgosExamenes

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                      password="123456")
    curt = miConexiont.cursor()

    comando = "SELECT t.id id, t.nombre  nombre FROM clinico_examenesrasgos t"

    curt.execute(comando)
    print(comando)

    rasgosClinicos = []
    rasgosClinicos.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
        rasgosClinicos.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(rasgosClinicos)

    context['RasgosClinicos'] = rasgosClinicos

    # Fin combo rASGOSeXAMENES

    # Combo medicoInterpretacion1

    # miConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                       password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT med.id id, med.nombre nombre FROM clinico_medicos med order by med.nombre'

    curt.execute(comando)
    print(comando)

    medicoInterpretacion1 = []
    medicoInterpretacion1.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
           medicoInterpretacion1.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(medicoInterpretacion1)

    context['MedicoInterpretacion1'] = medicoInterpretacion1

    # Fin combo medicoInterpretacion1


    # Combo medicoInterpretacion2

    # miConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                       password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT med.id id, med.nombre nombre FROM clinico_medicos med order by med.nombre'

    curt.execute(comando)
    print(comando)

    medicoInterpretacion2 = []
    medicoInterpretacion2.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
           medicoInterpretacion2.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(medicoInterpretacion2)

    context['MedicoInterpretacion2'] = medicoInterpretacion2

    # Fin combo medicoInterpretacion2

    # Combo medicoReporte

    # miConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                       password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT med.id id, med.nombre nombre FROM clinico_medicos med order by med.nombre'

    curt.execute(comando)
    print(comando)

    medicoReporte = []
    medicoReporte.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
           medicoReporte.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(medicoReporte)

    context['MedicoReporte'] = medicoReporte

    # Fin combo medicoInterpretacion2


    # Combo Dependencias

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                       password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT d.id id, d.nombre nombre FROM sitios_dependencias d where "dependenciasTipo_id" = 5'

    curt.execute(comando)
    print(comando)

    dependenciasRealizado = []
    dependenciasRealizado.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
         dependenciasRealizado.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(dependenciasRealizado)



    # Fin Combo DependenciasRealizado


 


    ingresos1 = []


    # miConexionx = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",     password="123456")
    curx = miConexionx.cursor()
   
    detalle = 'SELECT histoexa.id examId ,' + "'" + str("INGRESO") + "'" +  ' tipoIng, i.id'  + "||" +"'" + '-INGRESO' + "'," + '  tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" , i."fechaSalida",ser.nombre servicioNombreIng, dep.nombre camaNombreIng ,diag.nombre dxActual ,historia.fecha fechaExamen,tipoExa.nombre tipoExamen ,exam.nombre examen ,estadosExam.nombre estadoExamen ,histoexa.consecutivo consecutivo,histoexa."codigoCups" cups, histoexa.cantidad cantidad, histoexa.observaciones observa, historia.folio folio FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd , clinico_tiposexamen tipoExa,  clinico_examenes exam, clinico_historiaexamenes histoexa, clinico_historia historia, clinico_estadoexamenes estadosExam WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" AND i."sedesClinica_id" = ' + "'" + str(sede) + "'" +' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND dep.disponibilidad = ' + "'" + str('O') + "'" + ' AND i."salidaDefinitiva" = '  + "'" + str('N') + "'" + '  and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id" AND u."tipoDoc_id" = historia."tipoDoc_id" AND u.id = historia.documento_id AND historia.id = histoexa.historia_id AND i.consec = historia."consecAdmision" AND histoexa."tiposExamen_id" = tipoExa.id and  histoexa."tiposExamen_id" = exam."TiposExamen_id" and histoexa."codigoCups" = exam."codigoCups" AND histoexa."estadoExamenes_id" = estadosExam.id AND estadosExam.nombre = ' + "'" + str('ORDENADO') + "'" + ' UNION SELECT histoexa.id examId ,' + "'"  + str("TRIAGE") + "'" + ' tipoIng, t.id'  + "||" +"'" + '-TRIAGE' + "'," + '  tp.nombre tipoDoc,u.documento documento,u.nombre nombre,t.consec consec , t."fechaSolicita" , cast(' + "'" + str('0001-01-01 00:00:00') + "'" + ' as timestamp) fechaSalida,ser.nombre servicioNombreIng, dep.nombre camaNombreIng , ' + "''" + ' dxActual , historia.fecha fechaExamen,    tipoExa.nombre tipoExamen,exam.nombre examen,estadosExam.nombre estadoExamen,histoexa.consecutivo consecutivo,histoexa."codigoCups" cups, histoexa.cantidad cantidad, histoexa.observaciones observa , historia.folio folio  FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  ,sitios_serviciosSedes sd, clinico_servicios ser , clinico_tiposexamen tipoExa,  clinico_examenes exam, clinico_historiaexamenes histoexa,  clinico_historia historia, clinico_estadoexamenes estadosExam WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND t."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = ' + "'" + str('TRIAGE') + "'" + ' AND u."tipoDoc_id" = historia."tipoDoc_id" AND u.id = historia.documento_id AND historia.id = histoexa.historia_id AND t."consecAdmision" = historia."consecAdmision" AND histoexa."tiposExamen_id" = tipoExa.id and  histoexa."tiposExamen_id" = exam."TiposExamen_id" and histoexa."codigoCups" = exam."codigoCups" AND histoexa."estadoExamenes_id" = estadosExam.id AND estadosExam.nombre = ' + "'" + str('ORDENADO') +  "'"
    print(detalle)

    curx.execute(detalle)

    for examId, tipoIng, id, tipoDoc, documento, nombre, consec, fechaIngreso, fechaSalida, servicioNombreIng, camaNombreIng, dxActual, fechaExamen, tipoExamen , examen , estadoExamen , consecutivo, cups, cantidad,  observa, folio in curx.fetchall():
        ingresos1.append(
		{"model":"terapeutico.ingresos","pk":examId,"fields":
			{'examId':examId, 'tipoIng':tipoIng, 'id':id, 'tipoDoc': tipoDoc, 'documento': documento, 'nombre': nombre, 'consec': consec,
                         'fechaIngreso': fechaIngreso, 'fechaSalida': fechaSalida,
                         'servicioNombreIng': servicioNombreIng, 'camaNombreIng': camaNombreIng,
                         'dxActual': dxActual,'fechaExamen':fechaExamen,'tipoExamen':tipoExamen,'examen':examen,'estadoExamen':estadoExamen,'consecutivo': consecutivo,'cups':cups,'cantidad':cantidad,'observa':observa,'folio':folio}})

    miConexionx.close()
    print(ingresos1)
    context['Ingresos'] = ingresos1

    envio = []
    envio.append({'Ingresos':ingresos1})
    envio.append({'RasgosClinicos':rasgosClinicos})
    envio.append({'MedicoInterpretacion1':medicoInterpretacion1})
    envio.append({'MedicoInterpretacion2':medicoInterpretacion1})
    envio.append({'MedicoReporte':medicoReporte})
    envio.append({'DependenciasRealizado':dependenciasRealizado})


    print("Estos son los ingresos EMPACADOS =  ")
    print("Estos son los ingresos EMPACADOS =  ")

    print("Estos son los ingresos EMPACADOS =  ", ingresos1)

    serialized1 = json.dumps(ingresos1, default=serialize_datetime)

    return HttpResponse(serialized1,   content_type='application/json')
    #return JsonResponse(json.dumps(serialized1),  safe=False)


def PostConsultaApoyoTerapeutico(request):

    print ("Entre PostConsultaApoyoTerapeutico ")


    Post_id = request.POST["post_id"]

    print("id = ", Post_id)
    llave = Post_id.split('-')
    print ("llave = " ,llave)
    print ("primero=" ,llave[0])

    # Combo estadosExamenes

    # miConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT e.id id, e.nombre nombre FROM clinico_estadoexamenes e order by e.id'

    curt.execute(comando)
    print(comando)

    estadosExamenes = []
    estadosExamenes.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
        estadosExamenes.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(estadosExamenes)

      # Fin combo estadosExamenes



    # Combo RazgosExamenes

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                      password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT t.id id, t.nombre  nombre FROM clinico_examenesrasgos t, clinico_historiaexamenes exa where exa.id= ' + "'" + str(llave[0].strip()) + "'" + ' and exa."tiposExamen_id" = t."tiposExamen_id"  and exa."codigoCups" = t."codigoCups"'

    curt.execute(comando)
    print(comando)

    rasgosClinicos = []
    rasgosClinicos.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
        rasgosClinicos.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(rasgosClinicos)

    #context['RasgosClinicos'] = rasgosClinicos

    # Fin combo rASGOSeXAMENES

    # Combo medicoInterpretacion1

    # miConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                       password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT med.id id, med.nombre nombre FROM clinico_medicos med order by med.nombre'

    curt.execute(comando)
    print(comando)

    medicoInt1 = []
    medicoInt1.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
           medicoInt1.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print("medicoInt1 = OBSERVERLA ", medicoInt1)

    #context['MedicoInterpretacion1'] = medicoInterpretacion1

    # Fin combo medicoInterpretacion1


    # Combo medicoInterpretacion2

    # miConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                       password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT med.id id, med.nombre nombre FROM clinico_medicos med order by med.nombre'

    curt.execute(comando)
    print(comando)

    medicoInt2 = []
    medicoInt2.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
           medicoInt2.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(medicoInt2)

    #context['MedicoInterpretacion2'] = medicoInterpretacion2

    # Fin combo medicoInterpretacion2

    # Combo medicoReporte

    # miConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                       password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT med.id id, med.nombre nombre FROM clinico_medicos med order by med.nombre'

    curt.execute(comando)
    print(comando)

    medicoRep = []
    medicoRep.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
           medicoRep.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(medicoRep)

    #context['MedicoReporte'] = medicoReporte

    # Fin combo medicoReporte

    # Combo DependenciasRealizado

    # miConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT d.id id, d.nombre nombre FROM sitios_dependencias d WHERE "dependenciasTipo_id" = 5 order by d.nombre'

    curt.execute(comando)
    print(comando)

    dependenciasRealizado = []
    dependenciasRealizado.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
        dependenciasRealizado.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(dependenciasRealizado)


    # Fin combo dependenciasRealizado


    if request.method == 'POST':

        tipoExamenId=request.POST["tipoExamenId"]
        tipoExamen=request.POST["tipoExamen"]
        CupsId =  request.POST["CupsId"]
        nombreExamen =  request.POST["nombreExamen"]
        cantidad =  request.POST["cantidad"]
        observaciones =  request.POST["observaciones"]
        estadoExamen =  request.POST["estadoExamen"]
        folio =  request.POST["folio"]
        interpretacion1 =  request.POST["interpretacion1"]
        medicoInterpretacion1 =  request.POST["medicoInterpretacion1"]
        interpretacion2 =  request.POST["interpretacion2"]
        medicoInterpretacion2 =  request.POST["medicoInterpretacion2"]
        medicoReporte =  request.POST["medicoReporte"]
        rutaImagen =  request.POST["rutaImagen"]
        rutaVideo =  request.POST["rutaVideo"]


        # Abro Conexion

        miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",password="123456")
        cur = miConexionx.cursor()

    
        #comando = 'SELECT i.id id, i."tipoDoc_id" tipoDocId,td.nombre nombreTipoDoc, i.documento_id documentoId, u.documento documento , i.consec consec FROM admisiones_ingresos i, usuarios_usuarios u, usuarios_tiposDocumento td where i.id=' + "'" +  str(llave[0].strip()) + "'" + ' and i."tipoDoc_id" =td.id and i.documento_id=u.id'
        comando = 'select exam.id examId,  exam."tiposExamen_id" tipoExamenId, tip.nombre tipoExamen, exam."codigoCups" CupsId , examenes.nombre nombreExamen,exam.cantidad cantidad, exam.observaciones observaciones, exam."estadoExamenes_id" estado,historia.folio folio,exam.interpretacion1 interpretacion1,exam.interpretacion2 interpretacion2, exam."medicoInterpretacion1_id" medicoInterpretacion1,exam."medicoInterpretacion2_id" medicoInterpretacion2,exam."medicoReporte_id" medicoReporte, exam."rutaImagen" rutaImagen, exam."rutaVideo" rutaVideo , est.nombre estadoNombre, exam."dependenciasRealizado_id" dependencias  from clinico_historiaexamenes exam, clinico_historia historia, clinico_tiposexamen tip, clinico_examenes examenes , clinico_estadoexamenes est where historia.id= exam.historia_id and exam.id = '  + "'" +  str(llave[0].strip()) + "'" + ' and  tip.id=exam."tiposExamen_id" and exam."tiposExamen_id" = examenes."TiposExamen_id"  And exam."codigoCups" = examenes."codigoCups" and est.id = exam."estadoExamenes_id"'


        print(comando)

        cur.execute(comando)

        resultadoApoyoTerapeutico = []

        for examId,  tipoExamenId, tipoExamen,  CupsId ,  nombreExamen, cantidad, observaciones,  estado, folio,interpretacion1, interpretacion2,  medicoInterpretacion1,medicoInterpretacion2, medicoReporte,  rutaImagen, rutaVideo, estadoNombre, dependencias in cur.fetchall():
            resultadoApoyoTerapeutico.append( {"examId": examId,
                     "tipoExamenId": tipoExamenId,
                     "tipoExamen": tipoExamen,
                     "CupsId": CupsId, "nombreExamen": nombreExamen,
                     "cantidad": cantidad, "observaciones":observaciones, "estado":estado,"folio":folio, "interpretacion1":interpretacion1, "interpretacion2":interpretacion2,"medicoInterpretacion1":medicoInterpretacion1,
                     "medicoInterpretacion2":medicoInterpretacion2,"medicoReporte":medicoReporte, "rutaImagen":rutaImagen,"rutaVideo":rutaVideo , "estadoNombre":estadoNombre, "dependencias":dependencias})

        miConexionx.close()
        print(resultadoApoyoTerapeutico)

        # Cierro Conexion

        envio = []

        envio.append({'ResultadoApoyoTerapeutico': resultadoApoyoTerapeutico})

        envio.append({'RasgosClinicos':rasgosClinicos})

        envio.append({'MedicoInterpretacion1':medicoInt1})

        envio.append({'MedicoInterpretacion2':medicoInt2})

        envio.append({'MedicoReporte':medicoRep})
        envio.append({'DependenciasRealizado': dependenciasRealizado})
        envio.append({'EstadosExamenes': estadosExamenes})


        print ("ENVIO FINAL =", envio)

        serialized1 = json.dumps(envio, default=serialize_datetime)

        return HttpResponse(serialized1,   content_type='application/json')

        #return JsonResponse({'pk':resultadoApoyoTerapeutico[0]['examId'],'tipoExamenId':resultadoApoyoTerapeutico[0]['tipoExamenId'],'tipoExamen':resultadoApoyoTerapeutico[0]['tipoExamen'],
        #                     'CupsId':resultadoApoyoTerapeutico[0]['CupsId'],  'nombreExamen': resultadoApoyoTerapeutico[0]['nombreExamen'],
	#			'cantidad': resultadoApoyoTerapeutico[0]['cantidad'],
	#			'observaciones': resultadoApoyoTerapeutico[0]['observaciones'],
	#			'estado': resultadoApoyoTerapeutico[0]['estado'],
	#			'folio': resultadoApoyoTerapeutico[0]['folio'],
	#			'interpretacion1': resultadoApoyoTerapeutico[0]['interpretacion1'],
	#			'interpretacion2': resultadoApoyoTerapeutico[0]['interpretacion2'],
	#			'medicoInterpretacion1': resultadoApoyoTerapeutico[0]['medicoInterpretacion1'],
	#			'medicoInterpretacion2': resultadoApoyoTerapeutico[0]['medicoInterpretacion2'],
	#			'medicoReporte': resultadoApoyoTerapeutico[0]['medicoReporte'],
	#			'rutaImagen': resultadoApoyoTerapeutico[0]['rutaImagen'],
        #                     'rutaVideo': resultadoApoyoTerapeutico[0]['rutaVideo']})

    else:
        return JsonResponse({'errors':'Something went wrong!'})


    # Desdde aqui lo nuevo conulta respuesta


def PostConsultaApoyoTerapeuticoConsulta(request):

    print ("Entre PostConsultaApoyoTerapeuticoConsulta ")


    Post_id = request.POST["post_id"]

    print("id = ", Post_id)
    llave = Post_id.split('-')
    print ("llave = " ,llave)
    print ("primero=" ,llave[0])

    # Combo estadosExamenes

    # miConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT e.id id, e.nombre nombre FROM clinico_estadoexamenes e order by e.id'

    curt.execute(comando)
    print(comando)

    estadosExamenes = []
    estadosExamenes.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
        estadosExamenes.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(estadosExamenes)

      # Fin combo estadosExamenes



    # Combo RazgosExamenes

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                      password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT t.id id, t.nombre  nombre FROM clinico_examenesrasgos t, clinico_historiaexamenes exa where exa.id= ' + "'" + str(llave[0].strip()) + "'" + ' and exa."tiposExamen_id" = t."tiposExamen_id"  and exa."codigoCups" = t."codigoCups"'

    curt.execute(comando)
    print(comando)

    rasgosClinicos = []
    rasgosClinicos.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
        rasgosClinicos.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(rasgosClinicos)

    #context['RasgosClinicos'] = rasgosClinicos

    # Fin combo rASGOSeXAMENES

    # Combo medicoInterpretacion1

    # miConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                       password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT med.id id, med.nombre nombre FROM clinico_medicos med order by med.nombre'

    curt.execute(comando)
    print(comando)

    medicoInt1 = []
    medicoInt1.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
           medicoInt1.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print("medicoInt1 = OBSERVERLA ", medicoInt1)

    #context['MedicoInterpretacion1'] = medicoInterpretacion1

    # Fin combo medicoInterpretacion1


    # Combo medicoInterpretacion2

    # miConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                       password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT med.id id, med.nombre nombre FROM clinico_medicos med order by med.nombre'

    curt.execute(comando)
    print(comando)

    medicoInt2 = []
    medicoInt2.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
           medicoInt2.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(medicoInt2)

    #context['MedicoInterpretacion2'] = medicoInterpretacion2

    # Fin combo medicoInterpretacion2

    # Combo medicoReporte

    # miConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                       password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT med.id id, med.nombre nombre FROM clinico_medicos med order by med.nombre'

    curt.execute(comando)
    print(comando)

    medicoRep = []
    medicoRep.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
           medicoRep.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(medicoRep)

    #context['MedicoReporte'] = medicoReporte

    # Fin combo medicoReporte

    # Combo DependenciasRealizado

    # miConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT d.id id, d.nombre nombre FROM sitios_dependencias d WHERE "dependenciasTipo_id" = 5 order by d.nombre'

    curt.execute(comando)
    print(comando)

    dependenciasRealizado = []
    dependenciasRealizado.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
        dependenciasRealizado.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(dependenciasRealizado)


    # Fin combo dependenciasRealizado


    if request.method == 'POST':

        tipoExamenId=request.POST["tipoExamenId"]
        tipoExamen=request.POST["tipoExamen"]
        CupsId =  request.POST["CupsId"]
        nombreExamen =  request.POST["nombreExamen"]
        cantidad =  request.POST["cantidad"]
        observaciones =  request.POST["observaciones"]
        estadoExamen =  request.POST["estadoExamen"]
        folio =  request.POST["folio"]
        interpretacion1 =  request.POST["interpretacion1"]
        medicoInterpretacion1 =  request.POST["medicoInterpretacion1"]
        interpretacion2 =  request.POST["interpretacion2"]
        medicoInterpretacion2 =  request.POST["medicoInterpretacion2"]
        medicoReporte =  request.POST["medicoReporte"]
        rutaImagen =  request.POST["rutaImagen"]
        rutaVideo =  request.POST["rutaVideo"]


        # Abro Conexion

        miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",password="123456")
        cur = miConexionx.cursor()

    
        #comando = 'SELECT i.id id, i."tipoDoc_id" tipoDocId,td.nombre nombreTipoDoc, i.documento_id documentoId, u.documento documento , i.consec consec FROM admisiones_ingresos i, usuarios_usuarios u, usuarios_tiposDocumento td where i.id=' + "'" +  str(llave[0].strip()) + "'" + ' and i."tipoDoc_id" =td.id and i.documento_id=u.id'
        comando = 'select exam.id examId,  exam."tiposExamen_id" tipoExamenId, tip.nombre tipoExamen, exam."codigoCups" CupsId , examenes.nombre nombreExamen,exam.cantidad cantidad, exam.observaciones observaciones, exam."estadoExamenes_id" estado,historia.folio folio,exam.interpretacion1 interpretacion1,exam.interpretacion2 interpretacion2, exam."medicoInterpretacion1_id" medicoInterpretacion1,exam."medicoInterpretacion2_id" medicoInterpretacion2,exam."medicoReporte_id" medicoReporte, exam."rutaImagen" rutaImagen, exam."rutaVideo" rutaVideo , est.nombre estadoNombre, exam."dependenciasRealizado_id" dependencias  from clinico_historiaexamenes exam, clinico_historia historia, clinico_tiposexamen tip, clinico_examenes examenes , clinico_estadoexamenes est where historia.id= exam.historia_id and exam.id = '  + "'" +  str(llave[0].strip()) + "'" + ' and  tip.id=exam."tiposExamen_id" and exam."tiposExamen_id" = examenes."TiposExamen_id"  And exam."codigoCups" = examenes."codigoCups" and est.id = exam."estadoExamenes_id"'


        print(comando)

        cur.execute(comando)

        zresultadoApoyoTerapeutico = []

        for examId,  tipoExamenId, tipoExamen,  CupsId ,  nombreExamen, cantidad, observaciones,  estado, folio,interpretacion1, interpretacion2,  medicoInterpretacion1,medicoInterpretacion2, medicoReporte,  rutaImagen, rutaVideo, estadoNombre, dependencias in cur.fetchall():
            zresultadoApoyoTerapeutico.append( {"examId": examId,
                     "tipoExamenId": tipoExamenId,
                     "tipoExamen": tipoExamen,
                     "CupsId": CupsId, "nombreExamen": nombreExamen,
                     "cantidad": cantidad, "observaciones":observaciones, "estado":estado,"folio":folio, "interpretacion1":interpretacion1, "interpretacion2":interpretacion2,"medicoInterpretacion1":medicoInterpretacion1,
                     "medicoInterpretacion2":medicoInterpretacion2,"medicoReporte":medicoReporte, "rutaImagen":rutaImagen,"rutaVideo":rutaVideo , "estadoNombre":estadoNombre, "dependencias":dependencias})

        miConexionx.close()
        print(zresultadoApoyoTerapeutico)

        # Cierro Conexion

        envio = []

        envio.append({'ResultadoApoyoTerapeutico': zresultadoApoyoTerapeutico})

        envio.append({'RasgosClinicos':rasgosClinicos})

        envio.append({'MedicoInterpretacion1':medicoInt1})

        envio.append({'MedicoInterpretacion2':medicoInt2})

        envio.append({'MedicoReporte':medicoRep})
        envio.append({'DependenciasRealizado': dependenciasRealizado})
        envio.append({'EstadosExamenes': estadosExamenes})


        print ("ENVIO FINAL =", envio)

        serialized1 = json.dumps(envio, default=serialize_datetime)

        return HttpResponse(serialized1,   content_type='application/json')

        #return JsonResponse({'pk':resultadoApoyoTerapeutico[0]['examId'],'tipoExamenId':resultadoApoyoTerapeutico[0]['tipoExamenId'],'tipoExamen':resultadoApoyoTerapeutico[0]['tipoExamen'],
        #                     'CupsId':resultadoApoyoTerapeutico[0]['CupsId'],  'nombreExamen': resultadoApoyoTerapeutico[0]['nombreExamen'],
	#			'cantidad': resultadoApoyoTerapeutico[0]['cantidad'],
	#			'observaciones': resultadoApoyoTerapeutico[0]['observaciones'],
	#			'estado': resultadoApoyoTerapeutico[0]['estado'],
	#			'folio': resultadoApoyoTerapeutico[0]['folio'],
	#			'interpretacion1': resultadoApoyoTerapeutico[0]['interpretacion1'],
	#			'interpretacion2': resultadoApoyoTerapeutico[0]['interpretacion2'],
	#			'medicoInterpretacion1': resultadoApoyoTerapeutico[0]['medicoInterpretacion1'],
	#			'medicoInterpretacion2': resultadoApoyoTerapeutico[0]['medicoInterpretacion2'],
	#			'medicoReporte': resultadoApoyoTerapeutico[0]['medicoReporte'],
	#			'rutaImagen': resultadoApoyoTerapeutico[0]['rutaImagen'],
        #                     'rutaVideo': resultadoApoyoTerapeutico[0]['rutaVideo']})

    else:
        return JsonResponse({'errors':'Something went wrong!'})

    # hasta quip
	




def load_dataRasgos(request, data):
    print ("Entre load_data Rasgos ... ")

    context = {}
    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']
    valor = d['valor']

    nombreSede = d['nombreSede']
    print ("sede:", sede)
    print ("username:", username)
    print ("username_id:", username_id)
    #valor = 127

    rasgos = []


    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",     password="123456")
    curx = miConexionx.cursor()
   
 
    detalle = 'select resul.id rasgosId, exam.id examId,  exam."tiposExamen_id" tipoExamenId, tip.nombre tipoExamen, exam."codigoCups" codigoCups,examenes.nombre nombreExamen,exam.cantidad cantidad,rasgos.unidad unidad, exam.observaciones observaciones, exam."estadoExamenes_id" estado,resul.valor valorResultado,rasgos.nombre nombreRasgo, rasgos.minimo minimo, rasgos.maximo maximo, resul.observaciones observa from clinico_historiaexamenes exam, clinico_tiposexamen tip, clinico_examenes examenes, clinico_historiaresultados resul, clinico_examenesrasgos rasgos where resul."historiaExamenes_id" = exam.id and exam.id =' + "'" + str(valor) + "'" + ' and tip.id=exam."tiposExamen_id" and exam."tiposExamen_id" = examenes."TiposExamen_id" And exam."codigoCups" = examenes."codigoCups" AND resul."examenesRasgos_id" = rasgos.id  And exam."codigoCups" = rasgos."codigoCups"'
    print(detalle)

    curx.execute(detalle)

    for rasgosId, examId,  tipoExamenId, tipoExamen,  codigoCups,  nombreExamen,  cantidad, unidad, observaciones,  estado,  valorResultado, nombreRasgo, minimo, maximo , observa in curx.fetchall():
        rasgos.append(
		{"model":"examenesrasgos.riesgos","pk":rasgosId,"fields":
			{'rasgosId':rasgosId, 'examId':examId, 'tipoExamenId':tipoExamenId, 'tipoExamen':tipoExamen, 'codigoCups': codigoCups, 'nombreExamen': nombreExamen, 'cantidad': cantidad, 'observaciones': observaciones,
                         'unidad':unidad, 'observaciones': observaciones, 'estado': estado,
                         'valorResultado': valorResultado, 'nombreRasgo': nombreRasgo,
                         'minimo': minimo,'maximo':maximo, 'observa':observa}})

    miConexionx.close()
    print(rasgos)
    context['Rasgos'] = rasgos

    print("Rasgos  =  ", rasgos)

    serialized1 = json.dumps(rasgos, default=serialize_datetime)

    return HttpResponse(serialized1,   content_type='application/json')
    #return JsonResponse(json.dumps(serialized1),  safe=False)



def load_dataRasgosConsulta(request, data):
    print ("Entre load_data Rasgos Consulta... ")

    context = {}
    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']
    valor = d['valor']

    nombreSede = d['nombreSede']
    print ("sede:", sede)
    print ("username:", username)
    print ("username_id:", username_id)
    #valor = 127

    rasgos = []


    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",     password="123456")
    curx = miConexionx.cursor()
   
 
    detalle = 'select resul.id rasgosId, exam.id examId,  exam."tiposExamen_id" tipoExamenId, tip.nombre tipoExamen, exam."codigoCups" codigoCups,examenes.nombre nombreExamen,exam.cantidad cantidad,rasgos.unidad unidad, exam.observaciones observaciones, exam."estadoExamenes_id" estado,resul.valor valorResultado,rasgos.nombre nombreRasgo, rasgos.minimo minimo, rasgos.maximo maximo, resul.observaciones observa from clinico_historiaexamenes exam, clinico_tiposexamen tip, clinico_examenes examenes, clinico_historiaresultados resul, clinico_examenesrasgos rasgos where resul."historiaExamenes_id" = exam.id and exam.id =' + "'" + str(valor) + "'" + ' and tip.id=exam."tiposExamen_id" and exam."tiposExamen_id" = examenes."TiposExamen_id" And exam."codigoCups" = examenes."codigoCups" AND resul."examenesRasgos_id" = rasgos.id  And exam."codigoCups" = rasgos."codigoCups"'
    print(detalle)

    curx.execute(detalle)

    for rasgosId, examId,  tipoExamenId, tipoExamen,  codigoCups,  nombreExamen,  cantidad, unidad, observaciones,  estado,  valorResultado, nombreRasgo, minimo, maximo , observa in curx.fetchall():
        rasgos.append(
		{"model":"examenesrasgos.riesgos","pk":rasgosId,"fields":
			{'rasgosId':rasgosId, 'examId':examId, 'tipoExamenId':tipoExamenId, 'tipoExamen':tipoExamen, 'codigoCups': codigoCups, 'nombreExamen': nombreExamen, 'cantidad': cantidad, 'observaciones': observaciones,
                         'unidad':unidad, 'observaciones': observaciones, 'estado': estado,
                         'valorResultado': valorResultado, 'nombreRasgo': nombreRasgo,
                         'minimo': minimo,'maximo':maximo, 'observa':observa}})

    miConexionx.close()
    print(rasgos)
    context['Rasgos'] = rasgos

    print("Rasgos  =  ", rasgos)

    serialized1 = json.dumps(rasgos, default=serialize_datetime)

    return HttpResponse(serialized1,   content_type='application/json')
    #return JsonResponse(json.dumps(serialized1),  safe=False)






def GuardarResultadoRasgo ( request):

    print ("Entre guardar resultado rasgo")

    if request.method == 'POST':

        examId = request.POST["examId"]
        rasgo = request.POST["rasgo"]
        valor = request.POST["valor"]
        observaciones = request.POST["observa"]
        estadoReg= 'A'
        #dependenciasRealizado_id= 1
        ultConsec = HistoriaResultados.objects.all().filter(historiaExamenes_id=examId).aggregate(maximo=Coalesce(Max('consecResultado'),0))
        consecResultado = (ultConsec['maximo']) + 1
        fechaResultado = datetime.datetime.now()

        ## falta usuarioRegistro_id
        miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",  password="123456")
        curt = miConexiont.cursor()
        comando = 'INSERT INTO clinico_historiaresultados ("estadoReg",  "consecResultado","examenesRasgos_id", "fechaResultado", "fechaServicio", "historiaExamenes_id", observaciones, valor) values (' + "'" + str(estadoReg) + "'," +   "'" + str(consecResultado) + "'," + "'" + str(rasgo) + "'," + "'" +  str(fechaResultado) + "'," + "'" + str(fechaResultado) + "'," + "'" + str(examId) + "'," + "'" + str(observaciones) + "'," + "'" + str(valor) + "')"

        print(comando)
        curt.execute(comando)
        miConexiont.commit()
        miConexiont.close()



        return JsonResponse({'success': True, 'message': 'Responsable Actualizado satisfactoriamente!'})


def PostDeleteExamenesRasgos(request):

    print ("Entre PostDeleteExamenesRasgos" )
   

    id = request.POST["id"]
    print ("el id es = ", id)


    post = HistoriaResultados.objects.get(id=id)
    post.delete()
    
    print( "voy para el JSONresponse")
    #return HttpResponseRedirect(reverse('index'))	
    return JsonResponse({'success': True, 'message': 'Resultado borrado!'})
    #return JsonResponse({'message':'Resultado borrado!'})



def GuardarResultado ( request):

    if request.method == 'POST':

        examId = request.POST["examId"]
        observaciones = request.POST["observaciones"]
        interpretacion1 = request.POST["interpretacion1"]
        medicoInterpretacion1 = request.POST["medicoInterpretacion1"]
        interpretacion2 = request.POST["interpretacion2"]
        medicoInterpretacion2 = request.POST["medicoInterpretacion2"]
        medicoReporte = request.POST["medicoReporte"]
        rutaImagen = request.POST["rutaImagen"]
        rutaVideo = request.POST["rutaVideo"]
        estadoExamen = request.POST["estadoExamen"]
        dependenciasRealizado = request.POST["dependenciasRealizado"]

        if dependenciasRealizado == '':
           dependenciasRealizado="null"

        if medicoReporte == '':
            medicoReporte ="null"


        estadoReg= 'A'
        usuarioToma = request.POST["usuarioToma"]
        fechaReporte = datetime.datetime.now()
        fechaInterpretacion1 = datetime.datetime.now()
        fechaInterpretacion2 = datetime.datetime.now()

        print ("examId =", examId)

        miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",  password="123456")
        curt = miConexiont.cursor()
        comando = 'UPDATE clinico_historiaexamenes set interpretacion1 = ' + "'" +str(interpretacion1) + "'," +  '"fechaInterpretacion1" = '  + "'" + str(fechaInterpretacion1) + "'," + ' "medicoInterpretacion1_id" = ' + "'" + str(medicoInterpretacion1) + "',"  + '"medicoReporte_id" = ' + str(medicoReporte) + ","  + '  interpretacion2 = '  + "'" +str(interpretacion2) + "'," + '"fechaInterpretacion2"  = '   + "'" + str(fechaInterpretacion2) + "'," + ' "medicoInterpretacion2_id" = ' + "'" + str(medicoInterpretacion2) + "',"  + ' observaciones = ' + "'" + str(observaciones) + "'," + '"rutaImagen" = ' + "'" + str(rutaImagen) +  "'" + ',"rutaVideo" = ' + "'" + str(rutaVideo) + "'," +  '"fechaReporte" = ' + "'" + str(fechaReporte) + "'," + ' "usuarioToma_id" = ' + "'" + str(usuarioToma) + "'," + '"dependenciasRealizado_id" = ' + str(dependenciasRealizado) + "," + '"estadoExamenes_id" = ' + "'" + str(estadoExamen) + "'" + ' WHERE id = ' + "'" + str(examId) + "'"

        print(comando)
        curt.execute(comando)
        miConexiont.commit()
        miConexiont.close()



        return JsonResponse({'success': True, 'message': 'Responsable Actualizado satisfactoriamente!'})

def load_dataTerapeuticoConsulta(request, data):
    print ("Entre load_data TerapeuticoConsulta")

    context = {}
    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']

    nombreSede = d['nombreSede']
    print ("sede:", sede)
    print ("username:", username)
    print ("username_id:", username_id)
    



    ingresos1 = []


    # miConexionx = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",     password="123456")
    curx = miConexionx.cursor()
   
    detalle = 'SELECT histoexa.id examId ,' + "'" + str("INGRESO") + "'" +  ' tipoIng, i.id'  + "||" +"'" + '-INGRESO' + "'," + '  tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" , i."fechaSalida",ser.nombre servicioNombreIng, dep.nombre camaNombreIng ,diag.nombre dxActual ,historia.fecha fechaExamen,tipoExa.nombre tipoExamen ,exam.nombre examen ,estadosExam.nombre estadoExamen ,histoexa.consecutivo consecutivo,histoexa."codigoCups" cups, histoexa.cantidad cantidad, histoexa.observaciones observa, historia.folio folio FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd , clinico_tiposexamen tipoExa,  clinico_examenes exam, clinico_historiaexamenes histoexa, clinico_historia historia, clinico_estadoexamenes estadosExam WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" AND i."sedesClinica_id" = ' + "'" + str(sede) + "'" +' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND dep.disponibilidad = ' + "'" + str('O') + "'" + ' AND i."salidaDefinitiva" = '  + "'" + str('N') + "'" + '  and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id" AND u."tipoDoc_id" = historia."tipoDoc_id" AND u.id = historia.documento_id AND historia.id = histoexa.historia_id AND i.consec = historia."consecAdmision" AND histoexa."tiposExamen_id" = tipoExa.id and  histoexa."tiposExamen_id" = exam."TiposExamen_id" and histoexa."codigoCups" = exam."codigoCups" AND histoexa."estadoExamenes_id" = estadosExam.id AND estadosExam.nombre != ' + "'" + str('ORDENADO') + "'" + ' UNION SELECT histoexa.id examId ,' + "'"  + str("TRIAGE") + "'" + ' tipoIng, t.id'  + "||" +"'" + '-TRIAGE' + "'," + '  tp.nombre tipoDoc,u.documento documento,u.nombre nombre,t.consec consec , t."fechaSolicita" , cast(' + "'" + str('0001-01-01 00:00:00') + "'" + ' as timestamp) fechaSalida,ser.nombre servicioNombreIng, dep.nombre camaNombreIng , ' + "''" + ' dxActual , historia.fecha fechaExamen,    tipoExa.nombre tipoExamen,exam.nombre examen,estadosExam.nombre estadoExamen,histoexa.consecutivo consecutivo,histoexa."codigoCups" cups, histoexa.cantidad cantidad, histoexa.observaciones observa , historia.folio folio  FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  ,sitios_serviciosSedes sd, clinico_servicios ser , clinico_tiposexamen tipoExa,  clinico_examenes exam, clinico_historiaexamenes histoexa,  clinico_historia historia, clinico_estadoexamenes estadosExam WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND t."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = ' + "'" + str('TRIAGE') + "'" + ' AND u."tipoDoc_id" = historia."tipoDoc_id" AND u.id = historia.documento_id AND historia.id = histoexa.historia_id AND t."consecAdmision" = historia."consecAdmision" AND histoexa."tiposExamen_id" = tipoExa.id and  histoexa."tiposExamen_id" = exam."TiposExamen_id" and histoexa."codigoCups" = exam."codigoCups" AND histoexa."estadoExamenes_id" = estadosExam.id AND estadosExam.nombre != ' + "'" + str('ORDENADO') +  "'"
    print(detalle)

    curx.execute(detalle)

    for examId, tipoIng, id, tipoDoc, documento, nombre, consec, fechaIngreso, fechaSalida, servicioNombreIng, camaNombreIng, dxActual, fechaExamen, tipoExamen , examen , estadoExamen , consecutivo, cups, cantidad,  observa, folio in curx.fetchall():
        ingresos1.append(
		{"model":"terapeutico.ingresos","pk":examId,"fields":
			{'examId':examId, 'tipoIng':tipoIng, 'id':id, 'tipoDoc': tipoDoc, 'documento': documento, 'nombre': nombre, 'consec': consec,
                         'fechaIngreso': fechaIngreso, 'fechaSalida': fechaSalida,
                         'servicioNombreIng': servicioNombreIng, 'camaNombreIng': camaNombreIng,
                         'dxActual': dxActual,'fechaExamen':fechaExamen,'tipoExamen':tipoExamen,'examen':examen,'estadoExamen':estadoExamen,'consecutivo': consecutivo,'cups':cups,'cantidad':cantidad,'observa':observa,'folio':folio}})

    miConexionx.close()
    print(ingresos1)
    context['Ingresos'] = ingresos1

    envio = []
    envio.append({'Ingresos':ingresos1})

    print("Estos son los ingresos EMPACADOS =  ", ingresos1)

    serialized1 = json.dumps(ingresos1, default=serialize_datetime)

    return HttpResponse(serialized1,   content_type='application/json')
    #return JsonResponse(json.dumps(serialized1),  safe=False)


