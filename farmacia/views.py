from django.shortcuts import render

# Create your views here.

from django.shortcuts import render
from django.shortcuts import render
import json
from django import forms
import cv2
import numpy as np
from django.core.serializers import serialize
from django.db.models.functions import Cast, Coalesce
from django.utils.timezone import now
from django.db.models import Avg, Max, Min, Sum
from django.contrib import messages
from django.shortcuts import render, get_object_or_404, redirect, HttpResponse, HttpResponseRedirect
from django.core.exceptions import ValidationError
from django.urls import reverse, reverse_lazy
# from django.core.urlresolvers import reverse_lazy
from django.views.generic import ListView, CreateView, TemplateView
from django.http import JsonResponse
#import MySQLdb
import pyodbc
import psycopg2
import json
#import datetime
from datetime import date, timedelta
import time
from decimal import Decimal
from admisiones.models import Ingresos
from facturacion.models import ConveniosPacienteIngresos, Liquidacion, LiquidacionDetalle, Facturacion, FacturacionDetalle, Conceptos
from clinico.models import Servicios, EspecialidadesMedicos
import io
import pandas as pd
from cirugia.models import EstadosCirugias, EstadosSalas, EstadosProgramacion, ProgramacionCirugias, Cirugias, ProgramacionCirugias
from contratacion.models import Convenios
from django.db.models import Min, Max, Avg
from django.db.models import F

# Create your views here.


def Load_dataFarmacia(request, data):
    print("Entre Load_dataFarmacia")

    context = {}
    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']

    nombreSede = d['nombreSede']
    print("sede:", sede)
    print("username:", username)
    print("username_id:", username_id)

    farmacia = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()


    detalle = 'select far.id id,origen.nombre origen, mov.nombre mov , serv.nombre servicio, far.historia_id historia, est.nombre estado, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, servicios.nombre servicio, dep.nombre cama FROM farmacia_farmacia far INNER JOIN enfermeria_enfermeriatipoorigen origen ON (origen.id =  far."tipoOrigen_id") INNER JOIN enfermeria_enfermeriatipomovimiento mov ON (mov.id= far."tipoMovimiento_id") INNER JOIN sitios_serviciosadministrativos serv ON (serv.id = far."serviciosAdministrativos_id") INNER JOIN farmacia_farmaciaEstados est ON (est.id=far.estado_id) INNER JOIN clinico_historia hist ON (hist.id = far.historia_id) INNER JOIN admisiones_ingresos adm ON (adm."tipoDoc_id" = hist."tipoDoc_id"  AND adm.documento_id = hist.documento_id AND adm.consec = hist."consecAdmision") INNER JOIN usuarios_usuarios usu ON (usu.id = adm.documento_id ) INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = adm."tipoDoc_id")	 INNER JOIN sitios_dependencias dep ON (dep.id=adm."dependenciasActual_id")  INNER JOIN clinico_servicios servicios ON servicios.id=adm."serviciosActual_id"  WHERE far."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' AND far."fechaRegistro" >= ' +  "'" +  str('2025-01-01') + "'" + ' ORDER BY far."fechaRegistro" desc'

    print(detalle)

    curx.execute(detalle)

    for id, origen, mov, servicio, historia,estado, tipoDoc, documento,paciente, servicio,cama  in curx.fetchall():
        farmacia.append(
            {"model": "farmacia.farmacia", "pk": id, "fields":
                {'id': id, 'origen': origen, 'mov':mov, 'servicio': servicio, 'historia': historia ,'estado':estado,'tipoDoc':tipoDoc,'documento':documento, 'paciente':paciente, 'servicio':servicio, 'cama':cama }})

    miConexionx.close()
    print(farmacia)

    serialized1 = json.dumps(farmacia, default=str)

    return HttpResponse(serialized1, content_type='application/json')


def Load_dataFarmaciaDetalle(request, data):
    print("Entre Load_dataFarmaciaDetalle")

    context = {}
    envioDatos = {}

    d = json.loads(data)

    farmaciaId = d['farmaciaId']

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']

    nombreSede = d['nombreSede']
    print("sede:", sede)
    print("username:", username)
    print("username_id:", username_id)

    # Combo Datos Paciente

    datosPaciente = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'select usu.id id,  hist."tipoDoc_id" tipoDoc, tipos.nombre nombreTipoDoc, usu.documento documento, usu.nombre paciente, hist."consecAdmision" consecutivoAdmision, serv.nombre servicio, dep.numero cama FROM farmacia_farmacia far INNER JOIN clinico_historia hist ON (hist.id = far.historia_id) INNER JOIN usuarios_usuarios usu ON (usu.id=hist.documento_id) INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id=hist."tipoDoc_id") INNER JOIN admisiones_ingresos ingreso ON (ingreso."tipoDoc_id" =hist."tipoDoc_id" and ingreso.documento_id=hist.documento_id and ingreso.consec = hist."consecAdmision")  INNER Join sitios_dependencias dep on (dep.id=ingreso."dependenciasActual_id") INNER Join clinico_servicios serv on (serv.id=ingreso."serviciosActual_id") where far.id= ' + "'" + str(farmaciaId) + "'"
    print(detalle)

    curx.execute(detalle)

    for id,tipoDoc,nombreTipoDoc, documento, paciente ,consecutivoAdmision, servicio, cama  in curx.fetchall():
        datosPaciente.append(
            {"model": "famacia.farmaciaDetalle1", "pk": id, "fields":
                {'id':id, 'tipoDoc': tipoDoc, 'nombreTipoDoc':nombreTipoDoc, 'documento': documento,'paciente':paciente,'consecutivoAdmision':consecutivoAdmision ,'servicio':servicio, 'cama':cama}})

    miConexionx.close()
    print(datosPaciente)


    # Fin Combo


    farmaciaDetalle = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'select  far.id id,estados.nombre estadoNombre ,origen.nombre origenNombre, mov.nombre movNombre, sum.nombre suministro, 	det."dosisCantidad" dosis, dosis.descripcion unidadDosis,   vias.nombre via,	det."cantidadOrdenada" cantidad, det."diasTratamiento" tratamiento , via.nombre viaAdministracion FROM farmacia_farmacia far INNER JOIN farmacia_farmaciadetalle det ON (det.farmacia_id = far.id) LEFT JOIN farmacia_farmaciaestados estados  ON (estados.id = far.estado_id) INNER JOIN enfermeria_enfermeriatipoorigen origen ON (origen.id = far."tipoOrigen_id") INNER JOIN enfermeria_enfermeriatipomovimiento mov ON (mov.id = far."tipoOrigen_id") INNER JOIN facturacion_suministros sum ON (sum.id= det.suministro_id) INNER JOIN clinico_viasadministracion vias ON (vias.id= det."viaAdministracion_id") INNER JOIN clinico_unidadesdemedidadosis dosis ON (dosis.id= det."dosisUnidad_id") INNER JOIN clinico_viasadministracion via ON (via.id= det."viaAdministracion_id")  where far.id ='  + "'" + str(farmaciaId) + "'"
    print(detalle)

    curx.execute(detalle)

    for id,estadoNombre, origenNombre,movNombre,suministro, dosis, unidadDosis, via, cantidad, tratamiento , viaAdministracion  in curx.fetchall():
        farmaciaDetalle.append(
            {"model": "famacia.farmaciaDetalle", "pk": id, "fields":
                {'id': id, 'estadoNombre':estadoNombre, 'origenNombre': origenNombre ,'movNombre':movNombre,'suministro':suministro,'dosis':dosis ,'unidadDosis':unidadDosis ,'cantidad':cantidad , 'tratamiento':tratamiento, 'viaAdministracion':viaAdministracion}})

    miConexionx.close()
    print(farmaciaDetalle)

    envioDatos['datosPaciente'] = datosPaciente
    envioDatos['farmaciaDetalle'] = farmaciaDetalle

    print("envioDatos = " , envioDatos)

    serialized1 = json.dumps(farmaciaDetalle, default=str)

    return HttpResponse(serialized1, content_type='application/json')


def Load_dataFarmaciaDespachosDispensa(request, data):
    print("Entre Load_dataFarmaciaDespachosDispensa")

    context = {}
    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']
    farmaciaDetalleId = d['farmaciaDetalleId']

    nombreSede = d['nombreSede']
    print("sede:", sede)
    print("username:", username)
    print("username_id:", username_id)
    print("farmaciaDetalleId:", farmaciaDetalleId)

    farmaciaDespachosDispensa = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'select dispensa.id id, dispensa.despacho_id despacho , sum.nombre suministro, 	dispensa."dosisCantidad" dosis, dosis.descripcion unidadDosis,   vias.nombre via,	dispensa."cantidadOrdenada" cantidad, dispensa."diasTratamiento" tratamiento FROM farmacia_farmaciadespachosdispensa dispensa INNER JOIN farmacia_farmaciaDetalle detalle ON (detalle.id = dispensa."farmaciaDetalle_id") INNER JOIN facturacion_suministros sum ON (sum.id= dispensa.suministro_id) INNER JOIN clinico_viasadministracion vias ON (vias.id= dispensa."viaAdministracion_id") INNER JOIN clinico_unidadesdemedidadosis dosis ON (dosis.id= dispensa."dosisUnidad_id") WHERE detalle.FARMACIA_ID=' + "'" + str(farmaciaDetalleId) + "'"

    print(detalle)

    curx.execute(detalle)

    for id,despacho, suministro, dosis, unidadDosis, via, cantidad, tratamiento in curx.fetchall():
        farmaciaDespachosDispensa.append(
            {"model": "famacia.farmaciadespachosDispensa", "pk": id, "fields":
                {'id': id, 'despacho':despacho, 'suministro': suministro ,'unidadDosis':unidadDosis, 'via':via, 'cantidad':cantidad,'tratamiento':tratamiento  }})

    miConexionx.close()
    print(farmaciaDespachosDispensa)

    serialized1 = json.dumps(farmaciaDespachosDispensa, default=str)

    return HttpResponse(serialized1, content_type='application/json')


def BuscaDatosPaciente(request):
    print("Entre BuscaDatosPaciente")


    farmaciaId = request.POST['farmaciaId']
    print ("farmaciaId =", farmaciaId)


    # Combo Datos Paciente

    datosPaciente = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'select usu.id id,  hist."tipoDoc_id" tipoDoc, tipos.nombre nombreTipoDoc, usu.documento documento, usu.nombre paciente, hist."consecAdmision" consecutivoAdmision, serv.nombre servicio, dep.numero cama FROM farmacia_farmacia far INNER JOIN clinico_historia hist ON (hist.id = far.historia_id) INNER JOIN usuarios_usuarios usu ON (usu.id=hist.documento_id) INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id=hist."tipoDoc_id") INNER JOIN admisiones_ingresos ingreso ON (ingreso."tipoDoc_id" =hist."tipoDoc_id" and ingreso.documento_id=hist.documento_id and ingreso.consec = hist."consecAdmision")  INNER Join sitios_dependencias dep on (dep.id=ingreso."dependenciasActual_id") INNER Join clinico_servicios serv on (serv.id=ingreso."serviciosActual_id") where far.id= ' + "'" + str(farmaciaId) + "'"
    print(detalle)

    curx.execute(detalle)

    for id,tipoDoc,nombreTipoDoc, documento, paciente ,consecutivoAdmision, servicio, cama  in curx.fetchall():
        datosPaciente.append(
            {"model": "datosPaciente", "pk": id, "fields":
                {'id':id, 'tipoDoc': tipoDoc, 'nombreTipoDoc':nombreTipoDoc, 'documento': documento,'paciente':paciente,'consecutivoAdmision':consecutivoAdmision ,'servicio':servicio, 'cama':cama}})

    miConexionx.close()
    print(datosPaciente)


    # Fin Combo

    serialized1 = json.dumps(datosPaciente, default=str)

    return HttpResponse(serialized1, content_type='application/json')
