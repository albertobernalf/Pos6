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


def Load_dataPanelEnfermeria(request, data):
    print("Entre Load_dataPanelEnfermeria")

    context = {}
    d = json.loads(data)

    Sede = d['sede']
    print("sede = ", Sede)

    ingresos = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                       password="123456")
    curx = miConexionx.cursor()

    #detalle = 'SELECT i.id id, tp.nombre tipoDoc,  u.documento documento, u.nombre  nombre , i.consec consec , i."fechaIngreso" , ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual, (select count(*)  from facturacion_conveniospacienteingresos conv where conv."tipoDoc_id" = i."tipoDoc_id" and conv.documento_id=i.documento_id  and conv."consecAdmision"=i.consec) numConvenios,(select count(*)  from cartera_pagos pag where pag."tipoDoc_id" = i."tipoDoc_id" and pag.documento_id=i.documento_id  and pag.consec=i.consec) numPagos, empresa.nombre Empresa  FROM admisiones_ingresos i, usuarios_usuarios u, facturacion_empresas empresa , sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and empresa.id = i.empresa_id AND sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" AND i."sedesClinica_id" = ' + "'" + str(
    #        Sede) + "'" + ' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND dep.disponibilidad = ' + "'" + 'O' + "'" + ' AND i."salidaDefinitiva" = ' + "'" + 'N' + "'" + ' and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null and ser.nombre != ' + "'" + str('TRIAGE') + "'" + ' AND dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id"'
    detalle = 'SELECT i.id id, tp.nombre tipoDoc,  u.documento documento, u.nombre  nombre , i.consec consec , i."fechaIngreso" , ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual, (select count(*)  from facturacion_conveniospacienteingresos conv where conv."tipoDoc_id" = i."tipoDoc_id" and conv.documento_id=i.documento_id  and conv."consecAdmision"=i.consec) numConvenios,	(select count(*)  from cartera_pagos pag where pag."tipoDoc_id" = i."tipoDoc_id" and pag.documento_id=i.documento_id  and pag.consec=i.consec) numPagos,	empresa.nombre Empresa, date_part(' + "'" + str('YEAR') + "'" + ' ,  AGE(CURRENT_DATE , U."fechaNacio")) edad, i."salidaClinica" salidaClinica FROM admisiones_ingresos i inner join usuarios_usuarios u on ( u."tipoDoc_id" = i."tipoDoc_id"  and u.id = i."documento_id" ) left join facturacion_empresas empresa on (empresa.id = i.empresa_id) inner join sitios_dependencias dep on (dep.id = i."dependenciasActual_id" and dep."sedesClinica_id" =  i."sedesClinica_id" AND dep.disponibilidad = ' + "'" + str('O') + "')"  + ' inner join clinico_servicios ser on (ser.id = i."serviciosActual_id" and ser.nombre != ' + "'" + str('TRIAGE') + "')" + ' inner join usuarios_tiposDocumento tp on (tp.id = u."tipoDoc_id") inner join sitios_dependenciastipo deptip on ( deptip.id = dep."dependenciasTipo_id") left join  clinico_Diagnosticos diag on (diag.id = i."dxActual_id") inner join sitios_serviciosSedes sd on (sd."sedesClinica_id" = i."sedesClinica_id" and sd.id= dep."serviciosSedes_id" and sd.servicios_id  = ser.id) WHERE  i."sedesClinica_id" = ' + "'" + str(Sede) + "'" + ' AND i."salidaDefinitiva" = ' + "'" + str('N') + "'" + ' AND i."fechaSalida" is null '
    print(detalle)

    curx.execute(detalle)

    for id, tipoDoc, documento, nombre, consec, fechaIngreso,  servicioNombreIng, camaNombreIng, dxActual, numConvenios, numPagos, Empresa , edad, salidaClinica in curx.fetchall():
            ingresos.append({"model": "ingresos.ingresos", "pk": id, "fields":
                {'id': id, 'tipoDoc': tipoDoc, 'Documento': documento, 'Nombre': nombre,
                 'Consec': consec, 'FechaIngreso': fechaIngreso,   'servicioNombreIng': servicioNombreIng, 'camaNombreIng': camaNombreIng,
                   'DxActual': dxActual,'numConvenios':numConvenios,'numPagos':numPagos, 'Empresa':Empresa,'edad':edad, 'salidaClinica': salidaClinica}})

    miConexionx.close()
    print("ingresos = " , ingresos)
    context['Ingresos'] = ingresos


    serialized1 = json.dumps(ingresos, default=str)

    return HttpResponse(serialized1, content_type='application/json')



def Load_dataPanelEnfermeria2(request, data):
    print("Entre Load_dataPanelEnfermeria2")

    context = {}
    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']

    nombreSede = d['nombreSede']
    print("sede:", sede)
    print("username:", username)
    print("username_id:", username_id)

    enfermeria = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()


    detalle = 'select far.id id,origen.nombre origen, mov.nombre mov , serv.nombre servicio, far.historia_id historia FROM enfermeria_enfermeria far INNER JOIN enfermeria_enfermeriatipoorigen origen ON (origen.id =  far."tipoOrigen_id") INNER JOIN enfermeria_enfermeriatipomovimiento mov ON (mov.id= far."tipoMovimiento_id") INNER JOIN sitios_serviciosadministrativos serv ON (serv.id = far."serviciosAdministrativos_id") WHERE far."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' AND far."fechaRegistro" >= ' +  "'" +  str('2025-01-01') + "'" + ' ORDER BY far."fechaRegistro" desc'

    print(detalle)

    curx.execute(detalle)

    for id, origen, mov, servicio, historia in curx.fetchall():
        enfermeria.append(
            {"model": "enfermeria.enfermeria", "pk": id, "fields":
                {'id': id, 'origen': origen, 'mov':mov, 'servicio': servicio, 'historia': historia  }})

    miConexionx.close()
    print(enfermeria)

    serialized1 = json.dumps(enfermeria, default=str)

    return HttpResponse(serialized1, content_type='application/json')

def Load_dataMedicamentosEnfermeria(request, data):
    print("Entre Load_dataMedicamentosEnfermeria")

    context = {}
    d = json.loads(data)

    ingresoId = d['ingresoId']

    print ("ingresoId =", ingresoId)


    medicamentosEnfermeria = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                       password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT recibe.id id, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, hist.folio folio, fardet."consecutivoMedicamento" consecutivoMedicamento, recibe."cantidadDispensada" cantidad, 	  medida.descripcion UnidadMedida, sum.nombre medicamento, via.nombre via FROM admisiones_ingresos ing INNER JOIN clinico_historia hist ON (hist."tipoDoc_id" = ing."tipoDoc_id" AND hist.documento_id=ing.documento_id AND hist."consecAdmision" = ing.consec) INNER JOIN farmacia_farmacia far ON (far.historia_id= hist.id) INNER JOIN farmacia_farmaciadetalle fardet ON (fardet.farmacia_id = far.id) INNER JOIN	enfermeria_enfermeriarecibe recibe ON (recibe."farmaciaDetalle_id" = fardet.id) INNER JOIN facturacion_suministros sum ON (sum.id = recibe.suministro_id) INNER JOIN clinico_viasadministracion via ON (via.id = recibe."viaAdministracion_id") INNER JOIN clinico_unidadesdemedidadosis medida ON (medida.id = recibe."dosisUnidad_id") INNER JOIN usuarios_usuarios usu ON (usu.id = ing.documento_id) INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = usu."tipoDoc_id")	WHERE ing.id=' + "'" + str(ingresoId) + "'" + ' order by hist.folio, fardet."consecutivoMedicamento"'

    print(detalle)

    curx.execute(detalle)

    for id, tipoDoc, documento, paciente, folio, consecutivoMedicamento, cantidad,  UnidadMedida, medicamento, via in curx.fetchall():
            medicamentosEnfermeria.append({"model": "ingresos.ingresos", "pk": id, "fields":
                {'id': id, 'tipoDoc': tipoDoc, 'Documento': documento, 'paciente': paciente,
                 'folio': folio, 'consecutivoMedicamento': consecutivoMedicamento,   'cantidad': cantidad, 'UnidadMedida': UnidadMedida,
                   'medicamento': medicamento}})

    miConexionx.close()
    print("medicamentosEnfermeria = " , medicamentosEnfermeria)


    serialized1 = json.dumps(medicamentosEnfermeria, default=str)

    return HttpResponse(serialized1, content_type='application/json')


def Load_dataParaClinicosEnfermeria(request, data):
    print("Entre Load_dataParaClinicosEnfermeria")

    context = {}
    d = json.loads(data)

    ingresoId = d['ingresoId']

    print ("ingresoId =", ingresoId)

    ingresoAdmision = Ingresos.objects.get(id=ingresoId)


    paraClinicosEnfermeria = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                       password="123456")
    curx = miConexionx.cursor()


    detalle = 'SELECT histExa.id id ,planta.nombre medico,hist.fecha fecha,hist.folio folio, tiposExa.nombre tipo ,histExa.consecutivo consecutivo,   histExa."codigoCups" cups,  exa.nombre examen, histExa.cantidad FROM clinico_historia hist INNER JOIN 	clinico_historiaexamenes histExa ON (histExa.historia_id = hist.id) INNER JOIN 	clinico_tiposexamen tiposExa ON ( tiposExa.id = histExa."tiposExamen_id") INNER JOIN clinico_examenes exa ON (exa."TiposExamen_id" = tiposExa.id and exa."codigoCups" = histExa."codigoCups") INNER JOIN planta_planta planta on (planta.id=hist.planta_id) WHERE hist."tipoDoc_id" = ' + "'" + str(ingresoAdmision.tipoDoc_id) + "' AND hist.documento_id = " + "'" + str(ingresoAdmision.documento_id) + "'" + ' and hist."consecAdmision" = ' + "'" + str(ingresoAdmision.consec) + "'" + ' order by hist.fecha, hist.folio'

    print(detalle)

    curx.execute(detalle)

    for id, medico, fecha, folio, tipo, consecutivo, cups, examen,  cantidad  in curx.fetchall():
            paraClinicosEnfermeria.append({"model": "paraclinicos", "pk": id, "fields":
                {'id': id, 'medico': medico, 'fecha': fecha, 'folio' : folio,  'tipo': tipo,
                 'consecutivo': consecutivo, 'cups': cups,   'examen': examen, 'cantidad': cantidad}})

    miConexionx.close()
    print("paraClinicosEnfermeria = " , paraClinicosEnfermeria)


    serialized1 = json.dumps(paraClinicosEnfermeria, default=str)

    return HttpResponse(serialized1, content_type='application/json')


def Load_dataPedidosEnfermeria(request, data):
    print("Entre Load_PedidosEnfermeria")

    context = {}
    d = json.loads(data)

    ingresoId = d['ingresoId']

    print ("ingresoId =", ingresoId)

    ingresoAdmision = Ingresos.objects.get(id=ingresoId)


    username = d['username']
    sede = d['sede']
    username_id = d['username_id']

    nombreSede = d['nombreSede']
    print("sede:", sede)
    print("username:", username)
    print("username_id:", username_id)

    enfermeria = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()



    detalle = '	select enf.id id,origen.nombre origen, mov.nombre mov , serv.nombre servicio, tipos.nombre tipoDoc, usu.documento documento, usu.nombre paciente, serv.nombre servicio FROM enfermeria_enfermeria enf INNER JOIN enfermeria_enfermeriatipoorigen origen ON (origen.id =  enf."tipoOrigen_id") INNER JOIN enfermeria_enfermeriatipomovimiento mov ON (mov.id= enf."tipoMovimiento_id")  INNER JOIN sitios_serviciosadministrativos serv ON (serv.id = enf."serviciosAdministrativos_id") INNER JOIN admisiones_ingresos adm ON (adm."tipoDoc_id" = '  + "'" + str(ingresoAdmision.tipoDoc_id ) + "'" + '  AND adm.documento_id = ' + "'" + str(ingresoAdmision.documento_id) + "'" + ' AND adm.consec = ' + "'" + str(ingresoAdmision.consec) + "'" + ' ) INNER JOIN usuarios_usuarios usu ON (usu.id = adm.documento_id ) INNER JOIN usuarios_tiposdocumento tipos ON (tipos.id = adm."tipoDoc_id") WHERE enf."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' AND enf."fechaRegistro" >= ' + "'" + str('2025 - 01 - 01') + "'"  + ' AND mov.nombre='  + "'" + str('PEDIDO') + "'" + ' ORDER BY enf."fechaRegistro" desc'


    print(detalle)

    curx.execute(detalle)

    for id, origen, mov, servicio, tipoDoc, documento,paciente, servicio  in curx.fetchall():
        enfermeria.append(
            {"model": "enfermeria.enfermeria", "pk": id, "fields":
                {'id': id, 'origen': origen, 'mov':mov, 'servicio': servicio, 'tipoDoc':tipoDoc,'documento':documento, 'paciente':paciente, 'servicio':servicio }})

    miConexionx.close()
    print(enfermeria)

    serialized1 = json.dumps(enfermeria, default=str)

    return HttpResponse(serialized1, content_type='application/json')


def Load_dataPedidosEnfermeriaDetalle(request, data):
    print("Entre Load_PedidosEnfermeria")
    pass
