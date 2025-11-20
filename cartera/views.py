from django.shortcuts import render
import json
from django import forms
import cv2
import numpy as np
from django.core.serializers import serialize
from django.db.models.functions import Cast, Coalesce
from django.utils.timezone import now
from django.db.models import Avg, Max, Min, Sum
from django.utils import timezone

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
import datetime
from decimal import Decimal
from admisiones.models import Ingresos
from facturacion.models import ConveniosPacienteIngresos, Liquidacion, LiquidacionDetalle, Facturacion, FacturacionDetalle
from cartera.models import TiposPagos, FormasPagos, Pagos, PagosFacturas, GlosasDetalle, NotasCredito, NotasCreditoDetalle
from triage.models import Triage
from clinico.models import Servicios
from rips.models  import RipsMedicamentos, RipsConsultas, RipsProcedimientos, RipsOtrosServicios
import pickle
from django.db import transaction, IntegrityError
from django.db.models import Sum


# Function to convert dictionary keys and values
def convert_keys_and_values(d):
    return {str(k) if isinstance(k, Decimal) else k: (float(v) if isinstance(v, Decimal) else v)
            for k, v in d.items()}


def decimal_serializer(obj):
    if isinstance(obj, Decimal):
        return str(obj)
    raise TypeError("Type not serializable")

def serialize_datetime(obj):
    if isinstance(obj, datetime.datetime):
        return obj.isoformat()
    raise TypeError("Type not serializable")


# Create your views here.
def load_dataGlosas(request, data):
    print("Entre load_data Glosas")

    context = {}
    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']

    nombreSede = d['nombreSede']
    print("sede:", sede)
    print("username:", username)
    print("username_id:", username_id)

    # Combo Indicadores

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT ser.nombre, count(*) total FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd  WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and i."sedesClinica_id" = dep."sedesClinica_id" AND i."sedesClinica_id" = ' + "'" + str(
        sede) + "'" + ' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND dep.disponibilidad = ' + "'" + str(
        'O') + "'" + ' AND i."salidaDefinitiva" = ' + "'" + str('N') + "'" + ' and tp.id = u."tipoDoc_id" and  i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id"  group by ser.nombre UNION SELECT ser.nombre, count(*) total FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , sitios_serviciosSedes sd, clinico_servicios ser WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND  t."sedesClinica_id" =  ' + "'" + str(sede) + "'" + ' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND  t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and  t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and  dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and  t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = ' + "'" + str(
        'TRIAGE') + "'" + ' group by ser.nombre'

    print("comando = ", comando)

    curt.execute(comando)
    print(comando)

    indicadores = []

    for id, nombre in curt.fetchall():
        indicadores.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(indicadores)

    context['Indicadores'] = indicadores

    # Fin combo Indicadores

    glosas = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    #detalle = 'SELECT glo.id, "fechaRecepcion", "saldoFactura", "totalSoportado", "totalAceptado", "totalGlosa",  "totalNotasCredito", observaciones, glo."fechaRegistro", glo."estadoReg", convenio_id,  conv.nombre nombreConvenio,glo."usuarioRegistro_id", factura_id, "fechaRespuesta", "tipoGlosa_id", tipglo.nombre nombreTipoGlosa,  "usuarioRecepcion_id", "usuarioRespuesta_id", "valorGlosa", "estadoRadicacion_id", "estadoRecepcion_id", estGlosa.nombre estadoGlosaRecepcion, glo."sedesClinica_id", "ripsEnvio_id" FROM public.cartera_glosas glo, cartera_estadosglosas estGlosa , contratacion_convenios conv, cartera_tiposglosas tipglo WHERE glo."sedesClinica_id" = ' + "'" + str(sede) + "'" + 'AND tipglo.id = glo."tipoGlosa_id"   AND  conv.id = glo.convenio_id AND estGlosa.id =  glo."estadoRecepcion_id" AND estGlosa.tipo = ' + "'" + str('RECEPCION') + "'"
    detalle = 'SELECT glo.id, "fechaRecepcion", "saldoFactura", "totalSoportado", "totalAceptado", "totalGlosa",  "totalNotasCredito", observaciones, glo."fechaRegistro", glo."estadoReg", convenio_id,  conv.nombre nombreConvenio,glo."usuarioRegistro_id", factura_id, "fechaRespuesta", "tipoGlosa_id", tipglo.nombre nombreTipoGlosa,  "usuarioRecepcion_id", "usuarioRespuesta_id", "estadoRadicacion_id", "estadoRecepcion_id", estGlosa.nombre estadoGlosaRecepcion, glo."sedesClinica_id", "ripsEnvio_id" FROM public.cartera_glosas glo, cartera_estadosglosas estGlosa , contratacion_convenios conv, cartera_tiposglosas tipglo WHERE glo."sedesClinica_id" = ' + "'" + str(sede) + "'" + 'AND tipglo.id = glo."tipoGlosa_id"   AND  conv.id = glo.convenio_id AND estGlosa.id =  glo."estadoRecepcion_id" AND estGlosa.tipo = ' + "'" + str('RECEPCION') + "' AND glo.id in (SELECT min(glo2.id) FROM cartera_glosas glo2 WHERE glo2.factura_id=glo.factura_id )"

    print(detalle)

    curx.execute(detalle)

    for id,  fechaRecepcion, saldoFactura, totalSoportado, totalAceptado,totalGlosa, totalNotasCredito, observaciones, fechaRegistro, estadoReg, convenio_id, nombreConvenio, usuarioRegistro_id, factura_id,  fechaRespuesta, tipoGlosa_id,nombreTipoGlosa, usuarioRecepcion_id, usuarioRespuesta_id,   estadoRadicacion_id , estadoRecepcion_id, estadoGlosaRecepcion,  sedesClinica_id, ripsEnvio_id in curx.fetchall():
        glosas.append(
            {"model": "cartera.glosas", "pk": id, "fields":
                {'id': id, 'fechaRecepcion': fechaRecepcion, 'saldoFactura': saldoFactura, 'totalSoportado': totalSoportado,'totalAceptado':totalAceptado,
                 'totalGlosa':totalGlosa,  'totalNotasCredito':totalNotasCredito, 'observaciones': observaciones, 'fechaRegistro': fechaRegistro,'estadoReg': estadoReg, 'convenio_id': convenio_id,'nombreConvenio':nombreConvenio, 'usuarioRegistro_id': usuarioRegistro_id, 'factura_id' : factura_id,
                 'factura_id': factura_id, 'fechaRespuesta': fechaRespuesta,
                 'tipoGlosa_id': tipoGlosa_id,'nombreTipoGlosa' :nombreTipoGlosa, 'usuarioRecepcion_id': usuarioRecepcion_id,'estadoGlosaRecepcion':estadoGlosaRecepcion, 'usuarioRespuesta_id': usuarioRespuesta_id,
                 'estadoRadicacion_id': estadoRadicacion_id, 'estadoRecepcion_id': estadoRecepcion_id,
                 'sedesClinica_id': sedesClinica_id,'ripsEnvio_id':ripsEnvio_id}})

    miConexionx.close()
    print("glosas "  , glosas)
    context['Glosas'] = glosas

    serialized1 = json.dumps(glosas,  default=str)

    return HttpResponse(serialized1, content_type='application/json')

def load_dataGlosasAdicionar(request, data):
    print("Entre load_data GlosasAdicionar")

    context = {}
    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']

    nombreSede = d['nombreSede']
    facturaId = d['facturaId']
    print("sede:", sede)
    print("username:", username)
    print("username_id:", username_id)

    # Combo Indicadores

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT ser.nombre, count(*) total FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd  WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and i."sedesClinica_id" = dep."sedesClinica_id" AND i."sedesClinica_id" = ' + "'" + str(
        sede) + "'" + ' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND dep.disponibilidad = ' + "'" + str(
        'O') + "'" + ' AND i."salidaDefinitiva" = ' + "'" + str('N') + "'" + ' and tp.id = u."tipoDoc_id" and  i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id"  group by ser.nombre UNION SELECT ser.nombre, count(*) total FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , sitios_serviciosSedes sd, clinico_servicios ser WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND  t."sedesClinica_id" =  ' + "'" + str(sede) + "'" + ' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND  t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and  t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and  dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and  t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = ' + "'" + str(
        'TRIAGE') + "'" + ' group by ser.nombre'

    print("comando = ", comando)

    curt.execute(comando)
    print(comando)

    indicadores = []

    for id, nombre in curt.fetchall():
        indicadores.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(indicadores)

    context['Indicadores'] = indicadores

    # Fin combo Indicadores

    glosasAdicionar = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT glo.id,  glo.factura_id,  "totalGlosa",  "fechaRecepcion", "saldoFactura", "totalSoportado", "totalAceptado",   "totalNotasCredito", conv.nombre nombreConvenio, "fechaRespuesta", "tipoGlosa_id", tipglo.nombre nombreTipoGlosa, "estadoRadicacion_id", "tipoGlosa_id" , "estadoRecepcion_id", convenio_id  FROM public.cartera_glosas glo, cartera_estadosglosas estGlosa , contratacion_convenios conv, cartera_tiposglosas tipglo WHERE glo."sedesClinica_id" = ' + "'" + str(sede) + "'" + 'AND tipglo.id = glo."tipoGlosa_id"   AND  conv.id = glo.convenio_id AND estGlosa.id =  glo."estadoRecepcion_id" AND estGlosa.tipo = ' + "'" + str('RECEPCION') + "' AND glo.factura_id = '" + str(facturaId) + "' ORDER BY glo.id"

    print(detalle)

    curx.execute(detalle)

    for id, factura_id,  totalGlosa,   fechaRecepcion, saldoFactura, totalSoportado, totalAceptado, totalNotasCredito, nombreConvenio,  fechaRespuesta, tipoGlosa_id,nombreTipoGlosa , estadoRadicacion_id, tipoGlosa_id , estadoRecepcion_id, convenio_id  in curx.fetchall():
        glosasAdicionar.append(
            {"model": "cartera.glosas", "pk": id, "fields":
                {'id': id, 'factura_id' : factura_id, 'totalGlosa':totalGlosa, 'fechaRecepcion': fechaRecepcion,'saldoFactura': saldoFactura,   'totalSoportado': totalSoportado,'totalAceptado':totalAceptado,
                   'totalNotasCredito':totalNotasCredito, 'nombreConvenio':nombreConvenio,  'fechaRespuesta': fechaRespuesta,
                 'tipoGlosa_id': tipoGlosa_id,'nombreTipoGlosa' :nombreTipoGlosa, 'estadoRadicacion_id':estadoRadicacion_id, 'tipoGlosa_id':tipoGlosa_id,'estadoRecepcion_id':estadoRecepcion_id, 'convenio_id ':convenio_id }})

    miConexionx.close()
    print("glosasAdicionar "  , glosasAdicionar)
    context['GlosasAdicionar'] = glosasAdicionar

    serialized1 = json.dumps(glosasAdicionar,  default=str)

    return HttpResponse(serialized1, content_type='application/json')


def GuardaGlosas(request):

    print ("Entre Guarda Glosas" )

    convenio_id = request.POST['convenio_id']
    print("convenio_id =", convenio_id)

    sedesClinica_id = request.POST['sedesClinica_id']
    print("sedesClinica_id =", sedesClinica_id)

    fechaRecepcion = request.POST["fechaRecepcion"]
    print("fechaRecepcion =", fechaRecepcion)


    observaciones = request.POST["observaciones"]
    print("observaciones =", observaciones)


    factura_id = request.POST['factura_id']
    print ("factura_id =", factura_id)

    fechaRespuesta = request.POST["fechaRespuesta"]
    print("fechaRespuesta =", fechaRespuesta)


    tipoGlosa_id = request.POST["tipoGlosa_id"]
    print ("tipoGlosa_id =", tipoGlosa_id)

    totalGlosa = request.POST['totalGlosa']
    print ("totalGlosa =", totalGlosa)

    estadoRecepcion_id = request.POST['estadoRecepcion_id']
    print ("estadoRecepcion_id =", estadoRecepcion_id)

    serviciosAdministrativos_id = request.POST['serviciosAdministrativos_id']
    print ("serviciosAdministrativos_id =", serviciosAdministrativos_id)


    usuarioRegistro_id = request.POST['usuarioRegistro_id']
    print ("usuarioRegistro_id =", usuarioRegistro_id)

    estadoReg = 'A'

    fechaRegistro = timezone.now()


    miConexion3 = None
    miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",  password="123456")
    cur3 = miConexion3.cursor()

    try:
        comando = 'INSERT INTO cartera_glosas ("fechaRecepcion", "saldoFactura", "totalNotasCredito", "totalGlosa" , "totalSoportado", "totalAceptado", observaciones, "fechaRegistro", "estadoReg", convenio_id, "usuarioRegistro_id", factura_id,  "tipoGlosa_id", "usuarioRecepcion_id",   "estadoRadicacion_id", "estadoRecepcion_id","sedesClinica_id", "ripsEnvio_id" ,"serviciosAdministrativos_id", anulado) VALUES (' + "'" + str(fechaRecepcion) + "'" + ', 0,0, ' +  str(totalGlosa) +  ',0,0,' + "'" + str(observaciones) + "','" + str(fechaRegistro) + "','" + str(estadoReg) + "','" + str(convenio_id) + "','"  + str(usuarioRegistro_id) + "', '" + str(factura_id) + "', '" + str(tipoGlosa_id) + "', '" + str(usuarioRegistro_id) +  "', null, '" + str(estadoRecepcion_id) + "', '" + str(sedesClinica_id)  + "',null,'" + str(serviciosAdministrativos_id) + "','N'" +  ')'

        print(comando)
        cur3.execute(comando)
        miConexion3.commit()
        cur3.close()
        miConexion3.close()

        return JsonResponse({'success': True, 'Mensajes': 'Glosa creada satisfactoriamente!'})

    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            miConexion3.rollback()

        message_error= str(error)
        return JsonResponse({'success': False, 'Mensajes': message_error})


    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()


def GuardaNotasCredito(request):

    print ("Entre GuardaNotasCredito" )

    sedesClinica_id = request.POST['sedesClinica_id']
    print("sedesClinica_id =", sedesClinica_id)

    fechaNota = request.POST["fechaNota"]
    print("fechaNota =", fechaNota)

    valorNota = request.POST["valorNota"]
    print("valorNota =", valorNota)

    descripcion = request.POST["descripcion"]
    print("descripcion =", descripcion)

    serviciosAdministrativos_id = request.POST['serviciosAdministrativos_id']
    print ("serviciosAdministrativos_id =", serviciosAdministrativos_id)

    usuarioRegistro_id = request.POST['usuarioRegistro_id']
    print ("usuarioRegistro_id =", usuarioRegistro_id)

    estadoReg = 'A'

    fechaRegistro = timezone.now()


    miConexion3 = None
    miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",  password="123456")
    cur3 = miConexion3.cursor()

    try:
        comando = 'INSERT INTO cartera_notascredito ("fechaNota",  "fechaRegistro", "estadoReg", "valorNota",  "usuarioRegistro_id", "sedesClinica_id", "serviciosAdministrativos_id", descripcion, anulado) VALUES (' + "'" + str(fechaNota) + "','" + str(fechaRegistro) + "','A','"   +  str(valorNota) + "','" + str(usuarioRegistro_id) +  "','" + str(sedesClinica_id)  + "','" + str(serviciosAdministrativos_id) + "','" + str(descripcion) +   "','N')"

        print(comando)
        cur3.execute(comando)
        miConexion3.commit()
        cur3.close()
        miConexion3.close()

        return JsonResponse({'success': True, 'Mensajes': 'Nota credito  creada satisfactoriamente!'})

    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            miConexion3.rollback()

        message_error= str(error)
        return JsonResponse({'success': False, 'Mensajes': message_error})


    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()


def GuardaNotasCreditoDetalle(request):

    print ("Entre GuardaNotasCreditoDetalle" )

    sedesClinica_id = request.POST['sedesClinica_id']
    print("sedesClinica_id =", sedesClinica_id)

    factura = request.POST['factura']
    print ("factura = ", factura)

    valorNota = request.POST['valorNota']
    print ("valorNota = ", valorNota)

    tipoNotaCredito = request.POST['tipoNotaCredito']
    print ("tipoNotaCredito = ", tipoNotaCredito)


    notaCredito = request.POST['notaCredito']
    print ("notaCredito  = ", notaCredito )


    username_id = request.POST['username_id']
    print ("username_id =", username_id)

    notasCreditoId = NotasCredito.objects.get(id=notaCredito)
    print("notasCreditoId =" , notasCreditoId.valorNota)
    totalNota = NotasCreditoDetalle.objects.filter(notaCredito_id=notaCredito).aggregate(Sum('valorNota'))

    print("totalNota =", totalNota)

    if (totalNota['valorNota__sum'] == None):
        totalNota1=0
    else:
        totalNota1 =totalNota['valorNota__sum']

    print("totalNota1 =" , totalNota1)

    if ((float(totalNota1) + float(valorNota)) >  float(notasCreditoId.valorNota)):

        return JsonResponse({'success': False, 'Mensajes': 'Valor supera el total de la nota credito'})



    #Validacion
    try:
        with transaction.atomic():
            facturaId = Facturacion.objects.get(id=factura)

    except Exception as e:
        # Aquí ya se hizo rollback automáticamente
        print("Se hizo rollback INGRESO por:", e)

        return JsonResponse({'success': False, 'Mensajes': 'Factura No existe'})

    finally:
        print("Finally")

    if (facturaId.notasCredito == None):
        notasCreditox=0
    else:
        notasCreditox = facturaId.notasCredito


    if ((float(facturaId.valorApagar) - float(notasCreditox)) < float(valorNota)):

        return JsonResponse({'success': False, 'Mensajes': 'Valor de factura menor que el total de Notas credito'})


    estadoReg = 'A'

    fechaRegistro = timezone.now()


    miConexion3 = None
    miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",  password="123456")
    cur3 = miConexion3.cursor()

    try:
        comando = 'INSERT INTO cartera_notascreditodetalle ("notaCredito_id", "factura_id","valorNota",   "fechaRegistro",   "usuarioRegistro_id", "estadoReg", anulado,"tiposNotasCredito_id") VALUES (' + "'" + str(notaCredito) + "','"   + str(factura) + "','" + str(valorNota) + "','"  + str(fechaRegistro) + "','" + str(username_id) +  "','A','N','" + str(tipoNotaCredito) + "'" + ')'

        print(comando)
        cur3.execute(comando)

        if (facturaId.notasCredito == None):
            valorNot=0
        else:
            valorNot=facturaId.notasCredito

        actualizoValorNota =  float(valorNot) +  float(valorNota)

        comando = 'UPDATE facturacion_facturacion SET "notasCredito" =  ' + "'" + str(actualizoValorNota) + "'"  + ' WHERE id = ' + "'" + str(factura) + "'"

        print(comando)
        cur3.execute(comando)


        miConexion3.commit()
        cur3.close()
        miConexion3.close()

        return JsonResponse({'success': True, 'Mensajes': 'Nota credito Detalle  creada satisfactoriamente!'})

    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            miConexion3.rollback()

        message_error= str(error)
        return JsonResponse({'success': False, 'Mensajes': message_error})


    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()



def GuardaGlosasAdicionar(request):

    print ("Entre Guarda Glosas Adicionar" )

    convenio_id = request.POST['convenio_id']
    print("convenio_id =", convenio_id)

    sedesClinica_id = request.POST['sedesClinica_id']
    print("sedesClinica_id =", sedesClinica_id)

    fechaRecepcion = request.POST["fechaRecepcion"]
    print("fechaRecepcion =", fechaRecepcion)


    observaciones = request.POST["observaciones"]
    print("observaciones =", observaciones)


    factura_id = request.POST['factura_id']
    print ("factura_id =", factura_id)

    fechaRespuesta = request.POST["fechaRespuesta"]
    print("fechaRespuesta =", fechaRespuesta)

    tipoGlosa_id = request.POST["tipoGlosa_id"]
    print ("tipoGlosa_id =", tipoGlosa_id)

    totalGlosa = request.POST['totalGlosa']
    print ("totalGlosa =", totalGlosa)

    estadoRecepcion_id = request.POST['estadoRecepcion_id']
    print ("estadoRecepcion_id =", estadoRecepcion_id)

    serviciosAdministrativos_id = request.POST['serviciosAdministrativos_id']
    print ("serviciosAdministrativos_id =", serviciosAdministrativos_id)


    usuarioRegistro_id = request.POST['usuarioRegistro_id']
    print ("usuarioRegistro_id =", usuarioRegistro_id)

    estadoReg = 'A'

    fechaRegistro = timezone.now()


    miConexion3 = None
    miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",  password="123456")
    cur3 = miConexion3.cursor()

    try:
        comando = 'INSERT INTO cartera_glosas ("fechaRecepcion", "saldoFactura", "totalNotasCredito", "totalGlosa" , "totalSoportado", "totalAceptado", observaciones, "fechaRegistro", "estadoReg", convenio_id, "usuarioRegistro_id", factura_id,  "tipoGlosa_id", "usuarioRecepcion_id",  "estadoRadicacion_id", "estadoRecepcion_id","sedesClinica_id", "ripsEnvio_id" ,"serviciosAdministrativos_id", anulado) VALUES (' + "'" + str(fechaRecepcion) + "'" + ', 0,0,' + "'" + str(totalGlosa) + "'" + ',0,0,' + "'" + str(observaciones) + "','" + str(fechaRegistro) + "','" + str(estadoReg) + "','" + str(convenio_id) + "','"  + str(usuarioRegistro_id) + "', '" + str(factura_id) + "', '" + str(tipoGlosa_id) + "', '" + str(usuarioRegistro_id) + "',null,'" + str(estadoRecepcion_id) + "', '" + str(sedesClinica_id)  + "',null,'" + str(serviciosAdministrativos_id) + "','N'" +  ')'

        print(comando)
        cur3.execute(comando)
        miConexion3.commit()
        cur3.close()
        miConexion3.close()

        return JsonResponse({'success': True, 'Mensajes': 'Glosa creada satisfactoriamente!'})

    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            miConexion3.rollback()

        message_error= str(error)
        return JsonResponse({'success': False, 'Mensajes': message_error})


    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()


def Load_tablaGlosasProcedimientos(request, data):

    print("Entre load_data Procedimientos Glosas")

    context = {}
    d = json.loads(data)

    sedesClinica_id = d['sedesClinica_id']
    print("sedesClinica_id = ", sedesClinica_id)

    facturaId = d['facturaId']
    print("facturaId = ", facturaId)

    procedimientosRips = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT  ripsproc.id id, "codPrestador", cast(cast("fechaInicioAtencion" as date)  as text), "idMIPRES", "numAutorizacion", ripsproc."numDocumentoIdentificacion", "vrServicio", "valorPagoModerador", ripsproc.consecutivo, ripsproc."fechaRegistro", "codComplicacion_id", "codDiagnosticoPrincipal_id", "codDiagnosticoRelacionado_id", "codProcedimiento_id", "codServicio_id", "conceptoRecaudo_id", "finalidadTecnologiaSalud_id", "grupoServicios_id", "modalidadGrupoServicioTecSal_id", ripsproc."tipoDocumentoIdentificacion_id", ripsproc."usuarioRegistro_id", "viaIngresoServicioSalud_id", ripsproc."ripsDetalle_id", "itemFactura", ripsproc."ripsTipos_id", "tipoPagoModerador_id", ripsproc."ripsTransaccion_id"  FROM public.rips_ripstransaccion ripstra, public.rips_ripsprocedimientos ripsproc WHERE  ripstra."sedesClinica_id" = ' + "'" + str(sedesClinica_id) + "'" + ' AND ripstra.id = ripsproc."ripsTransaccion_id"  AND cast(ripstra."numFactura" as numeric) = ' +  str(facturaId)

    print ("detalle = ", detalle)

    curx.execute(detalle)

    for id,  codPrestador, fechaInicioAtencion, idMIPRES,numAutorizacion, numDocumentoIdentificacion,  vrServicio,  valorPagoModerador,  consecutivo , fechaRegistro,  codComplicacion_id, codDiagnosticoPrincipal_id, codDiagnosticoRelacionado_id, codProcedimiento_id, codServicio_id, conceptoRecaudo_id, finalidadTecnologiaSalud_id, grupoServicios_id, modalidadGrupoServicioTecSal_id, tipoDocumentoIdentificacion_id, usuarioRegistro_id, viaIngresoServicioSalud_id, ripsDetalle_id, itemFactura, ripsTipos_id, tipoPagoModerador_id, ripsTransaccion_id in curx.fetchall():
        procedimientosRips.append(
            {"model": "rips.RipsProcedimientos", "pk": id, "fields":
                {'id': id, 'codPrestador': codPrestador , 'fechaInicioAtencion': fechaInicioAtencion, 'idMIPRES': idMIPRES, 'numAutorizacion':numAutorizacion,
                 'numDocumentoIdentificacion':numDocumentoIdentificacion, 'vrServicio':vrServicio, 'valorPagoModerador':valorPagoModerador,
                 consecutivo:consecutivo, 'fechaRegistro':fechaRegistro, 'codComplicacion_id':codComplicacion_id, 'codDiagnosticoPrincipal_id':codDiagnosticoPrincipal_id,
                 'codDiagnosticoRelacionado_id':codDiagnosticoRelacionado_id, 'codProcedimiento_id':codProcedimiento_id,'codServicio_id':codServicio_id,
                 'conceptoRecaudo_id':conceptoRecaudo_id,'finalidadTecnologiaSalud_id':finalidadTecnologiaSalud_id, 'grupoServicios_id':grupoServicios_id,
                 'modalidadGrupoServicioTecSal_id':modalidadGrupoServicioTecSal_id,'tipoDocumentoIdentificacion_id':tipoDocumentoIdentificacion_id,
                 'usuarioRegistro_id':usuarioRegistro_id,'viaIngresoServicioSalud_id':viaIngresoServicioSalud_id,'ripsDetalle_id':ripsDetalle_id,
                 'itemFactura': itemFactura,'ripsTipos_id ':ripsTipos_id,'tipoPagoModerador_id':tipoPagoModerador_id , 'ripsTransaccion_id':ripsTransaccion_id
                 }})



    miConexionx.close()
    print("procedimientosRips "  , procedimientosRips)

    procedimientosRips_converted = [convert_keys_and_values(d) for d in procedimientosRips]

    serialized1 = json.dumps(procedimientosRips_converted, default=str)
    #serialized1 = json.dumps(procedimientosRips_converted)

    return HttpResponse(serialized1, content_type='application/json')



def Load_tablaGlosasTransaccion(request, data):
    print("Entre load_data Transaccion Glosas")

    context = {}
    d = json.loads(data)


    sedesClinica_id = d['sedesClinica_id']
    print("sedesClinica_id = ", sedesClinica_id)

    facturaId = d['facturaId']
    print("facturaId = ", facturaId)


    transaccionRips = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT id, "numDocumentoIdObligado", "numNota","fechaRegistro", "tipoNota_id","usuarioRegistro_id"  , "ripsEnvio_id", "sedesClinica_id"  FROM public.rips_ripstransaccion ripstra WHERE  cast(ripstra."numFactura" as integer) =' +  str(facturaId)
    print(detalle)

    curx.execute(detalle)

    for id,  numDocumentoIdObligado, numNota, fechaRegistro,tipoNota_id, usuarioRegistro_id,  ripsEnvio_id,  sedesClinica_id in curx.fetchall():
        transaccionRips.append(
            {"model": "rips.RipsTransaccion", "pk": id, "fields":
                {'id': id, 'numDocumentoIdObligado': numDocumentoIdObligado , 'numNota': numNota, 'fechaRegistro': fechaRegistro, 'tipoNota_id':tipoNota_id, 'usuarioRegistro_id':usuarioRegistro_id,
                   'ripsEnvio_id': ripsEnvio_id, 'sedesClinica_id' :sedesClinica_id}})



    miConexionx.close()
    print("transaccionRips "  , transaccionRips)
    #context['TransaccionRips'] = transaccionRips

    serialized1 = json.dumps(transaccionRips, default=str)

    return HttpResponse(serialized1, content_type='application/json')

def Load_tablaGlosasUsuarios(request, data):
    print("Entre load_data Usuarios Glosas")

    context = {}
    d = json.loads(data)


    sedesClinica_id = d['sedesClinica_id']
    print("sedesClinica_id = ", sedesClinica_id)

    facturaId = d['facturaId']
    print("facturaId = ", facturaId)


    usuariosRips = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT  ripsu.id, ripsu."tipoDocumentoIdentificacion", ripsu."tipoUsuario", ripsu."fechaNacimiento", ripsu."codSexo", ripsu."codZonaTerritorialResidencia_id", ripsu.incapacidad, ripsu.consecutivo, ripsu."fechaRegistro", ripsu."codMunicipioResidencia_id", ripsu."codPaisOrigen_id",ripsu."codPaisResidencia_id", ripsu."usuarioRegistro_id", ripsu."numDocumentoIdentificacion", ripsu."ripsDetalle_id", ripsu."ripsTransaccion_id"  FROM public.rips_ripsusuarios ripsu, public.rips_ripstransaccion ripstra  WHERE ripstra.id = ripsu."ripsTransaccion_id" and cast(ripstra."numFactura" as integer) =' + "'" + str(facturaId) + "'"

    print(detalle)

    curx.execute(detalle)

    for id,  tipoDocumentoIdentificacion, tipoUsuario, fechaNacimiento,codSexo, codZonaTerritorialResidencia,  incapacidad,  consecutivo, fechaRegistro, codMunicipioResidencia_id , codPaisOrigen_id, codPaisResidencia_id, usuarioRegistro_id , numDocumentoIdentificacion,ripsDetalle_id, ripsTransaccion_id in curx.fetchall():
        usuariosRips.append(
            {"model": "rips.RipsTransaccion", "pk": id, "fields":
                {'id': id, 'tipoDocumentoIdentificacion': tipoDocumentoIdentificacion , 'tipoUsuario': tipoUsuario, 'fechaNacimiento': fechaNacimiento, 'codSexo':codSexo, 'codZonaTerritorialResidencia':codZonaTerritorialResidencia,
                   'incapacidad': incapacidad, 'consecutivo' :consecutivo ,'fechaRegistro':fechaRegistro, 'codMunicipioResidencia_id':codMunicipioResidencia_id,'codPaisOrigen_id':codPaisOrigen_id,'codPaisResidencia_id':codPaisResidencia_id,'usuarioRegistro_id':usuarioRegistro_id ,'numDocumentoIdentificacion':numDocumentoIdentificacion,
                    'ripsDetalle_id':ripsDetalle_id,'ripsTransaccion_id':ripsTransaccion_id
                 }})



    miConexionx.close()
    print("usuariosRips "  , usuariosRips)
    #context['usuariosRips'] = usuariosRips

    serialized1 = json.dumps(usuariosRips, default=str)

    return HttpResponse(serialized1, content_type='application/json')


def Load_tablaGlosasMedicamentos(request, data):
    print("Entre  Load_tablaGlosasMedicamentos Glosas")

    context = {}
    d = json.loads(data)


    sedesClinica_id = d['sedesClinica_id']
    print("sedesClinica_id = ", sedesClinica_id)

    facturaId = d['facturaId']
    print("facturaId = ", facturaId)


    medicamentosRips = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT  GloDet.id id,"itemFactura", "nomTecnologiaSalud", GloDet."idMIPRES",  cums.nombre cums,"concentracionMedicamento", "cantidadMedicamento",  "vrUnitMedicamento", "vrServicio",  consecutivo,  "tipoMedicamento_id", "unidadMedida_id", "cantidadGlosada", "cantidadAceptada", "cantidadSoportado", "valorGlosado","vAceptado",	 "valorSoportado","motivoGlosa_id", "notasCreditoGlosa", "notasCreditoOtras", "notasDebito" FROM public.rips_ripstransaccion ripstra , public.rips_ripsmedicamentos GloDet , public.rips_ripscums cums  WHERE   ripstra.id = GloDet."ripsTransaccion_id" AND cums.id = Glodet."codTecnologiaSalud_id" and cast(ripstra."numFactura" as integer) =' +  str(facturaId)

    print(detalle)

    curx.execute(detalle)

    for  id, itemFactura, nomTecnologiaSalud, idMIPRES, cums, concentracionMedicamento, cantidadMedicamento, vrUnitMedicamento, vrServicio,  consecutivo, tipoMedicamento_id, unidadMedida_id, cantidadGlosada, cantidadAceptada, cantidadSoportado, valorGlosado,vAceptado, valorSoportado , motivoGlosa_id, notasCreditoGlosa, notasCreditoOtras, notasDebito in curx.fetchall():
        medicamentosRips.append(
            {"model": "rips.GloDeticamentos", "pk": id, "fields":
                {'id': id, 'itemFactura': itemFactura , 'nomTecnologiaSalud': nomTecnologiaSalud, 'idMIPRES' :idMIPRES, 'cums':cums,'concentracionMedicamento':concentracionMedicamento,'cantidadMedicamento':cantidadMedicamento,
		 'vrUnitMedicamento':vrUnitMedicamento, 'vrServicio':vrServicio, 'consecutivo':consecutivo,'tipoMedicamento_id':tipoMedicamento_id,'unidadMedida_id':unidadMedida_id,'cantidadGlosada':cantidadGlosada,'cantidadAceptada':cantidadAceptada,'cantidadSoportado':cantidadSoportado,'valorGlosado':valorGlosado,'vAceptado':vAceptado,'valorSoportado':valorSoportado,'motivoGlosa_id':motivoGlosa_id,'notasCreditoGlosa':notasCreditoGlosa, 'notasCreditoOtras':notasCreditoOtras, 'notasDebito':notasDebito
                 }})



    miConexionx.close()
    print("medicamentosRips "  , medicamentosRips)


    serialized1 = json.dumps(medicamentosRips,  default=str)

    return HttpResponse(serialized1, content_type='application/json')


def Load_tablaGlosasDetalle(request, data):
    print("Entre  Load_tablaGlosasDetalle")

    context = {}
    d = json.loads(data)


    sedesClinica_id = d['sedesClinica_id']
    print("sedesClinica_id = ", sedesClinica_id)

    facturaId = d['facturaId']
    print("facturaId = ", facturaId)

    glosaId = d['glosaId']
    print("glosaId = ", glosaId)


    glosasDetalle = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()



    #detalle = 'select ' + "'" + str('MEDICAMENTOS') + "'" + ' tipo,med.id, med.consecutivo consec, med."itemFactura",med."nomTecnologiaSalud" codigo,cums.nombre nombre,med."vrServicio",mot.nombre glosaNombre, med."cantidadGlosada",med."cantidadAceptada",med."cantidadSoportado", med."valorGlosado", med."vAceptado", med."valorSoportado",med."notasCreditoGlosa" FROM rips_ripstransaccion ripstra inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id) inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) left join cartera_motivosglosas mot on (mot.id = med."motivoGlosa_id")   where  cast(ripstra."numFactura" as float) = ' + str(facturaId) + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'" + str('PROCEDIMIENTOS') + "'" + ' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", cast(proc."codProcedimiento_id" as text) codigo, exa.nombre nombre, proc."vrServicio", mot.nombre glosaNombre, proc."cantidadGlosada", proc."cantidadAceptada", proc."cantidadSoportado", proc."valorGlosado", proc."vAceptado", proc."valorSoportado", proc."notasCreditoGlosa"  FROM  rips_ripstransaccion ripstra inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = proc."itemFactura") left join cartera_motivosglosas mot on (mot.id = proc."motivoGlosa_id")  where cast(ripstra."numFactura" as float) = ' +  str(facturaId) +  ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'"  + str('CONSULTAS') + "'" + ' tipo, cons.id, cons.consecutivo consec, cons."itemFactura", cast(cons."codConsulta_id" as text) codigo, exa.nombre nombre, cons."vrServicio", mot.nombre glosaNombre, cons."cantidadGlosada", cons."cantidadAceptada", cons."cantidadSoportado", cons."valorGlosado", cons."vAceptado", cons."valorSoportado", cons."notasCreditoGlosa" FROM rips_ripstransaccion  ripstra, rips_ripsconsultas cons, clinico_examenes exa, facturacion_facturaciondetalle det, cartera_motivosglosas mot  where cast(ripstra."numFactura" as float) = ' + str(facturaId) + ' and cons."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and cons. "codConsulta_id" = exa.id and cons."itemFactura" = det."consecutivoFactura" and mot.id = cons."motivoGlosa_id" UNION select '+ "'" + str('OTROS SERVICIOS') + "'" + ' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, cums.nombre nombre, serv."vrServicio", mot.nombre glosaNombre, serv."cantidadGlosada", serv."cantidadAceptada", serv."cantidadSoportado", serv."valorGlosado", serv."vAceptado", serv."valorSoportado", serv."notasCreditoGlosa" FROM rips_ripstransaccion ripstra, rips_ripsotrosservicios serv, rips_ripscums cums, facturacion_facturaciondetalle  det, cartera_motivosglosas  mot where cast(ripstra."numFactura" as float) = ' + "'" +  str(facturaId) + "'" + ' and serv."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and serv."codTecnologiaSalud_id" = cums.id and serv."itemFactura" = det."consecutivoFactura" and mot.id = serv."motivoGlosa_id"  order by 1,4'

    #detalle = 'select ' + "'" + str('MEDICAMENTOS') + "'" + ' tipo,med.id, med.consecutivo consec, med."itemFactura",cums.cum codigo,cums.nombre nombre,substring(mot.nombre,1,10) glosaNombre,med."vrServicio",  med."valorGlosado",	med."vAceptado", med."valorSoportado",med."notasCreditoGlosa",	detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"	FROM rips_ripstransaccion ripstra 	inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id) 	inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) left join cartera_motivosglosas mot on (mot.id = med."motivoGlosa_id")  left join cartera_glosasdetalle detGlo on (detGlo.glosa_id = ' + "'" + str(glosaId) + "' AND " + '  detGlo."ripsMedicamentos_id" = med.id)	where  cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'" + str('PROCEDIMIENTOS') + "'" + ' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", exa."codigoCups" codigo,	exa.nombre nombre,  substring(mot.nombre,1,10)  glosaNombre,proc."vrServicio",proc."valorGlosado", proc."vAceptado", proc."valorSoportado", proc."notasCreditoGlosa" ,detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito" FROM  rips_ripstransaccion ripstra inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = proc."itemFactura") left join cartera_motivosglosas mot on (mot.id = proc."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo.glosa_id = ' + "'" + str(glosaId) + "' AND " + 'detGlo."ripsProcedimientos_id" = proc.id) where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'" + str('CONSULTAS') + "'" + ' tipo, cons.id, cons.consecutivo consec, cons."itemFactura", exa."codigoCups" codigo,	exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre,cons."vrServicio",cons."valorGlosado", cons."vAceptado", cons."valorSoportado", cons."notasCreditoGlosa" ,	detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"	FROM rips_ripstransaccion  ripstra inner join  rips_ripsconsultas cons on (cons."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =cons."codConsulta_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = cons."itemFactura") left join cartera_motivosglosas mot on (mot.id = cons."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo.glosa_id = ' + "'" + str(glosaId) + "' AND " + ' detGlo."ripsConsultas_id" = cons.id)	 where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION	select ' + "'" + str('OTROS SERVICIOS') + "'" + ' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre, serv."vrServicio", serv."valorGlosado", serv."vAceptado", serv."valorSoportado", serv."notasCreditoGlosa" ,	detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"	FROM rips_ripstransaccion  ripstra inner join  rips_ripsotrosservicios serv on (serv."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =serv."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = serv."itemFactura") left join cartera_motivosglosas mot on (mot.id = serv."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo.glosa_id = ' + "'" + str(glosaId) + "' AND " + ' detGlo."ripsOtrosServicios_id" = serv.id)	where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' order by 1,4'

    detalle = 'select ' + "'" + str('MEDICAMENTOS') + "'" + ' tipo,med.id, med.consecutivo consec, med."itemFactura",cums.cum codigo,cums.nombre nombre,substring(mot.nombre,1,10) glosaNombre,med."vrServicio",  detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito" , detGlo.id detGloId, detGlo.glosa_id glosaId	FROM rips_ripstransaccion ripstra inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id) 	inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) left join cartera_motivosglosas mot on (mot.id = med."motivoGlosa_id")  left join cartera_glosasdetalle detGlo on (detGlo.glosa_id = ' + "'" + str(glosaId) + "' AND " + '  detGlo."ripsMedicamentos_id" = med.id)	where  cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'" + str('PROCEDIMIENTOS') + "'" + ' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", exa."codigoCups" codigo,	exa.nombre nombre,  substring(mot.nombre,1,10)  glosaNombre,proc."vrServicio",detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito" , detGlo.id detGloId , detGlo.glosa_id glosaId  FROM  rips_ripstransaccion ripstra inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = proc."itemFactura") left join cartera_motivosglosas mot on (mot.id = proc."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo.glosa_id = ' + "'" + str(glosaId) + "' AND " + 'detGlo."ripsProcedimientos_id" = proc.id) where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'" + str('CONSULTAS') + "'" + ' tipo, cons.id, cons.consecutivo consec, cons."itemFactura", exa."codigoCups" codigo,	exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre,cons."vrServicio",	detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito", detGlo.id detGloId , detGlo.glosa_id glosaId 	FROM rips_ripstransaccion  ripstra inner join  rips_ripsconsultas cons on (cons."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =cons."codConsulta_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = cons."itemFactura") left join cartera_motivosglosas mot on (mot.id = cons."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo.glosa_id = ' + "'" + str(glosaId) + "' AND " + ' detGlo."ripsConsultas_id" = cons.id)	 where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION	select ' + "'" + str('OTROS SERVICIOS') + "'" + ' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre, serv."vrServicio",	detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito", detGlo.id detGloId  , detGlo.glosa_id glosaId FROM rips_ripstransaccion  ripstra inner join  rips_ripsotrosservicios serv on (serv."ripsTransaccion_id" = ripstra.id) left join clinico_examenes exa on ( exa.id =serv."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = serv."itemFactura") left join cartera_motivosglosas mot on (mot.id = serv."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo.glosa_id = ' + "'" + str(glosaId) + "' AND " + ' detGlo."ripsOtrosServicios_id" = serv.id)	where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' order by 1,4'


    print(detalle)

    curx.execute(detalle)

    #for  tipo, id, consec, itemFactura, codigo, nombre,   glosaNombre,vrServicio,  valorGlosado,vAceptado, valorSoportado , notasCreditoGlosa , valorGlosa, valorSoportado2 , valorAceptado, valorNotasCredito in curx.fetchall():
    for tipo, id, consec, itemFactura, codigo, nombre, glosaNombre, vrServicio, valorGlosa, valorSoportado2, valorAceptado, valorNotasCredito , detGloId , glosaId in curx.fetchall():
        glosasDetalle.append(
            {"model": "rips.GlosasDetalle", "pk": id, "fields":
                {'tipo':tipo, 'id': id, 'consec':consec,  'itemFactura': itemFactura ,'codigo': codigo, 'nombre': nombre,'glosaNombre':glosaNombre,'vrServicio':vrServicio,
                 'valorGlosa': valorGlosa, 'valorSoportado2': valorSoportado2,   'valorAceptado': valorAceptado,
                 'valorNotasCredito': valorNotasCredito,'detGloId':detGloId,'glosaId':glosaId }})

    miConexionx.close()


    serialized1 = json.dumps(glosasDetalle,  default=str)

    print("glosasDetalle = ", serialized1)

    return HttpResponse(serialized1, content_type='application/json')



def ConsultaGlosasDetalle(request):
    
    print("Entre consultaGlosasDetalle")

    id  = request.POST['id']
    print("id  =", id )

    tipo  = request.POST["tipo"]
    print("tipo  =", tipo )


    medicamentosRipsUnRegistro = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    if (tipo == 'MEDICAMENTOS'):

        #detalle = 'SELECT ' + "'" + str('MEDICAMENTOS') + "'" + ' tipo, med.id,"itemFactura", "nomTecnologiaSalud" codigo, cums.nombre nombre, "vrServicio",	consecutivo,  "cantidadGlosada", "cantidadAceptada", "cantidadSoportado", "valorGlosado","vAceptado","valorSoportado","motivoGlosa_id", "notasCreditoGlosa" FROM public.rips_ripsmedicamentos med, public.rips_ripscums cums where med.id= ' + "'" + str(id) + "'" + ' and cums.id ="codTecnologiaSalud_id"'
        detalle = 'SELECT ' + "'" + str('MEDICAMENTOS') + "'" + ' tipo, med.id,med."itemFactura", med."nomTecnologiaSalud" codigo, cums.nombre nombre, med."vrServicio",	med.consecutivo,  detGlo."valorGlosa",detGlo."valorAceptado",detGlo."valorSoportado",  detGlo."motivoGlosa_id",   mot.nombre motivo,	detGlo."valorNotasCredito" 	FROM public.rips_ripsmedicamentos med inner join public.rips_ripscums cums  on (cums.id =med."codTecnologiaSalud_id") left join cartera_glosasdetalle detGlo on (detGlo."ripsMedicamentos_id" =med.id) left join cartera_motivosglosas mot on (mot.id = detGlo."motivoGlosa_id" ) where med.id= ' + "'" + str(id) + "'"

    if (tipo == 'PROCEDIMIENTOS'):


        detalle = 'SELECT ' + "'" + str('PROCEDIMIENTOS') + "'" + ' tipo, proc.id,proc."itemFactura", proc."codProcedimiento_id" codigo, exa.nombre nombre, proc."vrServicio",	proc.consecutivo,  detGlo."valorGlosa",detGlo."valorAceptado",detGlo."valorSoportado",  detGlo."motivoGlosa_id",   mot.nombre motivo,	detGlo."valorNotasCredito" 	FROM public.rips_ripsprocedimientos proc inner join clinico_examenes exa  on (exa.id =proc."codProcedimiento_id") left join cartera_glosasdetalle detGlo on (detGlo."ripsProcedimientos_id" =proc.id) left join cartera_motivosglosas mot on (mot.id = detGlo."motivoGlosa_id" ) where proc.id= ' + "'" + str(id) + "'"

    if (tipo == 'CONSULTAS'):

        detalle = 'SELECT ' + "'" + str('CONSULTAS') + "'" + ' tipo, med.id,med."itemFactura", med."nomTecnologiaSalud" codigo, cums.nombre nombre, med."vrServicio",	med.consecutivo,  detGlo."valorGlosa",detGlo."valorAceptado",detGlo."valorSoportado",  detGlo."motivoGlosa_id",   mot.nombre motivo,	detGlo."valorNotasCredito" 	FROM public.rips_ripsconsultas med inner join public.rips_ripscums cums  on (cums.id =med."codTecnologiaSalud_id") left join cartera_glosasdetalle detGlo on (detGlo."ripsConsultas_id" =med.id) left join cartera_motivosglosas mot on (mot.id = detGlo."motivoGlosa_id" ) where med.id= ' + "'" + str(id) + "'"

    if (tipo == 'OTROS SERVICIOS'):


        detalle = 'SELECT ' + "'" + str('OTROS SERVICIOS') + "'" + ' tipo, med.id,med."itemFactura", med."nomTecnologiaSalud" codigo, cums.nombre nombre, med."vrServicio",	med.consecutivo,  detGlo."valorGlosa",detGlo."valorAceptado",detGlo."valorSoportado",  detGlo."motivoGlosa_id",   mot.nombre motivo,	detGlo."valorNotasCredito" 	FROM public.rips_ripsotrosservicios med inner join public.rips_ripscums cums  on (cums.id =med."codTecnologiaSalud_id") left join cartera_glosasdetalle detGlo on (detGlo."ripsOtrosServicios_id" =med.id) left join cartera_motivosglosas mot on (mot.id = detGlo."motivoGlosa_id" ) where med.id= ' + "'" + str(id) + "'"


    print(detalle)

    curx.execute(detalle)

    for tipo, id, itemFactura, codigo, nombre,  vrServicio,  consecutivo, valorGlosa,valorAceptado, valorSoportado , motivoGlosa_id, motivo,  valorNotasCredito   in curx.fetchall():
     medicamentosRipsUnRegistro.append(
            {"model": "rips.ripsmedicamentos", "pk": id, "fields":
                {'tipo':tipo, 'id': id, 'itemFactura': itemFactura , 'codigo': codigo,  'nombre':nombre,
		  'vrServicio':vrServicio,'consecutivo':consecutivo,'valorGlosa':valorGlosa,'valorAceptado':valorAceptado,
                 'valorSoportado':valorSoportado,'motivoGlosa_id':motivoGlosa_id,'motivo':motivo, 'valorNotasCredito':valorNotasCredito
                 }})


    miConexionx.close()
    print("medicamentosRipsUnRegistro "  , medicamentosRipsUnRegistro)
    
    serialized1 = json.dumps(medicamentosRipsUnRegistro, default=str)

    return HttpResponse(serialized1, content_type='application/json')



def GuardarGlosasDetalle(request):

    print ("Entre Guardar Glosas Detalle" )

    tipoGloDet = request.POST["tipoGloDet"]
    print("tipoGloDet =", tipoGloDet)

    ripsId = request.POST['glosaGloDet']
    print ("ripsId =", ripsId)

    glosaId = request.POST['post_idGlo']
    print ("glosaId =", glosaId)


    motivoGlosa_id= request.POST["motivoGlosa_idGloDet"]
    print ("motivoGlosa_id =", motivoGlosa_id)


    valorGlosado = request.POST['valorGlosadoGloDet']
    #valorGlosado = float(valorGlosado)

    if (valorGlosado==''):
        valorGlosado=0.0

    print ("valorGlosado =", valorGlosado)

    if (valorGlosado==''):
        valorGlosado=0.0

    vAceptado = float(request.POST['vAceptadoGloDet'])
    print ("vAceptado =", vAceptado)

    if (vAceptado==''):
        vAceptado=0.0

    valorSoportado = request.POST['valorSoportadoGloDet']
    print ("valorSoportado=",valorSoportado)

    if (valorSoportado==''):
        valorSoportado=0.0

    notasCreditoGlosa = request.POST['notasCreditoGlosaGloDet']
    print ("notasCreditoGlosa=",notasCreditoGlosa)

    if (notasCreditoGlosa==''):
        notasCreditoGlosa=0.0

    itemFacturaGloDet = request.POST['itemFacturaGloDet']
    print ("itemFacturaGloDet=", itemFacturaGloDet)

    vrServicioGloDet = request.POST['vrServicioGloDet']
    print ("vrServicioGloDet=", vrServicioGloDet)


    observacionesGloDet = request.POST['observacionesGloDet']
    print ("observacionesGloDet=", observacionesGloDet)

    username_id = request.POST['username_id']
    print ("username_id=", username_id)

    estadoReg = 'A'

    fechaRegistro = timezone.now()

    if ( float(valorGlosado) > float(vrServicioGloDet) ):
        print ("Entre 1")
        print("valorGlosado=", valorGlosado)
        print("vrServicioGloDet=", vrServicioGloDet)
        return JsonResponse({'success': False, 'Error' :'Si', 'Mensajes': 'Valor Glosa mayor que el valor del servicio!'})

    if ( float(valorSoportado) > float(vrServicioGloDet) ):
        print ("Entre 4")
        return JsonResponse({'success': False, 'Error' :'Si','Mensajes': 'Valor Soportado mayor que el valor del servicio!'})

    if ( float(vAceptado) > float(vrServicioGloDet) ):
        print ("Entre 5")
        return JsonResponse({'success': False, 'Error' :'Si','Mensajes': 'Valor aceptado mayor que el valor del servicio!'})


    if (float(vrServicioGloDet) < float(vAceptado)):
        print("Entre 3")
        return JsonResponse(
            {'success': False, 'Error': 'Si', 'Mensajes': 'Valor aceptado no puede ser mayor que el valor glosado!'})

    if (float(notasCreditoGlosa) > float(valorGlosado)):
        print("Entre 3")
        return JsonResponse(
            {'success': False, 'Error': 'Si', 'Mensajes': 'La nota credito no puede ser mayor que el valor glosado!'})



    if ( float((float(vAceptado) + float(valorSoportado))) > float(vrServicioGloDet) ):
        print ("Entre 3")
        return JsonResponse({'success': False, 'Error' :'Si','Mensajes': 'Valor soportado mas valor aceptado mayor que el valor del servicio!'})



    miConexion3 = None
    try:

            miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",  password="123456")
            cur3 = miConexion3.cursor()

            hayRegistro = 0

            try:
                with transaction.atomic():

                    existeRegistro = GlosasDetalle.objects.get(glosa_id=glosaId, itemFactura=itemFacturaGloDet)
                    hayRegistro = existeRegistro.id

            except Exception as e:
                    # Aquí ya se hizo rollback automáticamente
                    print("Se hizo rollback por PRONO SE HACE NADA:", e)
                    hayRegistro=0

            finally:
                    print("No haga nada")


            if tipoGloDet == 'MEDICAMENTOS' :

                if (hayRegistro == 0):

	                comando = 'INSERT INTO cartera_glosasdetalle ( "itemFactura", "valorServicio", "valorGlosa", "valorSoportado", "valorAceptado","valorNotasCredito", observaciones, "estadoReg", glosa_id, "motivoGlosa_id", "usuarioRegistro_id", "fechaRegistro", "ripsId",  anulado, "ripsMedicamentos_id"	) VALUES ( ' +  "'" + str(itemFacturaGloDet) + "','" + str(vrServicioGloDet) + "','" + str(valorGlosado)  + "','" + str(valorSoportado) + "','" + str(vAceptado) + "','" + str(notasCreditoGlosa) + "','" + str(observacionesGloDet) + "','A','" + str(glosaId) + "','" + str(motivoGlosa_id) + "','" + str(username_id) + "','" + str(fechaRegistro) + "','" + str(ripsId) + "','N','" + str(ripsId) + "')"

                else:

                    comando = 'UPDATE cartera_glosasdetalle SET "itemFactura" = ' +  "'" + str(itemFacturaGloDet) + "'," + ' "valorServicio"  = ' + "'"  + str(vrServicioGloDet) + "'," + ' "valorGlosa" = ' + "'" + str(valorGlosado) + "'," + ' "valorSoportado" = ' + "'" + str(valorSoportado) + "'," + ' "valorAceptado" = ' + "'" + str(vAceptado) + "', " + ' "valorNotasCredito" = ' + "'" + str(notasCreditoGlosa) + "'," + ' observaciones = ' + "'" + str(observacionesGloDet) + "'," + '"estadoReg" = ' + "'A'," + ' "motivoGlosa_id" = ' + "'" + str(motivoGlosa_id) + "'," + ' "usuarioRegistro_id" = ' + "'" + str(username_id) + "'," + ' "fechaRegistro" = ' + "'" + str(fechaRegistro) + "'," + '"ripsId" = ' + "'" + str(ripsId) + "'," + ' anulado = ' + "'N'," + ' "ripsMedicamentos_id" = ' + "'" + str(ripsId) + "' WHERE glosa_id = " + "'" + str(glosaId) + "'" + ' AND "itemFactura" = ' + "'" + str(itemFacturaGloDet) + "'"


            if tipoGloDet == 'PROCEDIMIENTOS' :

                if (hayRegistro == 0):

                    comando = 'INSERT INTO cartera_glosasdetalle ( "itemFactura", "valorServicio", "valorGlosa", "valorSoportado", "valorAceptado","valorNotasCredito", observaciones, "estadoReg", glosa_id, "motivoGlosa_id", "usuarioRegistro_id", "fechaRegistro", "ripsId",  anulado, "ripsProcedimientos_id"	) VALUES ( ' +  "'" + str(itemFacturaGloDet) + "','" + str(vrServicioGloDet) + "','" + str(valorGlosado)  + "','" + str(valorSoportado) + "','" + str(vAceptado) + "','" + str(notasCreditoGlosa) + "','" + str(observacionesGloDet) + "','A','" + str(glosaId) + "','" + str(motivoGlosa_id) + "','" + str(username_id) + "','" + str(fechaRegistro) + "','" + str(ripsId) + "','N','" + str(ripsId) + "')"

                else:

                    comando = 'UPDATE cartera_glosasdetalle SET "itemFactura" = ' +  "'" + str(itemFacturaGloDet) + "'," + ' "valorServicio"  = ' + "'"  + str(vrServicioGloDet) + "'," + ' "valorGlosa" = ' + "'" + str(valorGlosado) + "'," + ' "valorSoportado" = ' + "'" + str(valorSoportado) + "'," + ' "valorAceptado" = ' + "'" + str(vAceptado) + "', " + ' "valorNotasCredito" = ' + "'" + str(notasCreditoGlosa) + "'," + ' observaciones = ' + "'" + str(observacionesGloDet) + "'," + '"estadoReg" = ' + "'A'," + ' "motivoGlosa_id" = ' + "'" + str(motivoGlosa_id) + "'," + ' "usuarioRegistro_id" = ' + "'" + str(username_id) + "'," + ' "fechaRegistro" = ' + "'" + str(fechaRegistro) + "'," + '"ripsId" = ' + "'" + str(ripsId) + "'," + ' anulado = ' + "'N'," + ' "ripsProcedimientos_id" = ' + "'" + str(ripsId) + "' WHERE glosa_id = " + "'" + str(glosaId) + "'" + ' AND "itemFactura" = ' + "'" + str(itemFacturaGloDet) + "'"

	
            if tipoGloDet == 'CONSULTAS' :

                if (hayRegistro == 0):


	                comando = 'INSERT INTO cartera_glosasdetalle ( "itemFactura", "valorServicio", "valorGlosa", "valorSoportado", "valorAceptado","valorNotasCredito", observaciones, "estadoReg", glosa_id, "motivoGlosa_id", "usuarioRegistro_id", "fechaRegistro", "ripsId",  anulado, "ripsConsultas_id"	) VALUES ( ' +  "'" + str(itemFacturaGloDet) + "','" + str(vrServicioGloDet) + "','" + str(valorGlosado)  + "','" + str(valorSoportado) + "','" + str(vAceptado) + "','" + str(notasCreditoGlosa) + "','" + str(observacionesGloDet) + "','A','" + str(glosaId) + "','" + str(motivoGlosa_id) + "','" + str(username_id) + "','" + str(fechaRegistro) + "','" + str(ripsId) + "','N','" + str(ripsId) + "')"

                else:

                    comando = 'UPDATE cartera_glosasdetalle SET "itemFactura" = ' +  "'" + str(itemFacturaGloDet) + "'," + ' "valorServicio"  = ' + "'"  + str(vrServicioGloDet) + "'," + ' "valorGlosa" = ' + "'" + str(valorGlosado) + "'," + ' "valorSoportado" = ' + "'" + str(valorSoportado) + "'," + ' "valorAceptado" = ' + "'" + str(vAceptado) + "', " + ' "valorNotasCredito" = ' + "'" + str(notasCreditoGlosa) + "'," + ' observaciones = ' + "'" + str(observacionesGloDet) + "'," + '"estadoReg" = ' + "'A'," + ' "motivoGlosa_id" = ' + "'" + str(motivoGlosa_id) + "'," + ' "usuarioRegistro_id" = ' + "'" + str(username_id) + "'," + ' "fechaRegistro" = ' + "'" + str(fechaRegistro) + "'," + '"ripsId" = ' + "'" + str(ripsId) + "'," + ' anulado = ' + "'N'," + ' "ripsConsultas_id" = ' + "'" + str(ripsId) + "' WHERE glosa_id = " + "'" + str(glosaId) + "'" + ' AND "itemFactura" = ' + "'" + str(itemFacturaGloDet) + "'"



            if tipoGloDet == 'OTROS SERVICIOS' :

                if (hayRegistro == 0):

	                comando = 'INSERT INTO cartera_glosasdetalle ( "itemFactura", "valorServicio", "valorGlosa", "valorSoportado", "valorAceptado","valorNotasCredito", observaciones, "estadoReg", glosa_id, "motivoGlosa_id", "usuarioRegistro_id", "fechaRegistro", "ripsId",  anulado, "ripsOtrosServicios_id"	) VALUES ( ' +  "'" + str(itemFacturaGloDet) + "','" + str(vrServicioGloDet) + "','" + str(valorGlosado)  + "','" + str(valorSoportado) + "','" + str(vAceptado) + "','" + str(notasCreditoGlosa) + "','" + str(observacionesGloDet) + "','A','" + str(glosaId) + "','" + str(motivoGlosa_id) + "','" + str(username_id) + "','" + str(fechaRegistro) + "','" + str(ripsId) + "','N','" + str(ripsId) + "')"

                else:

                    comando = 'UPDATE cartera_glosasdetalle SET "itemFactura" = ' +  "'" + str(itemFacturaGloDet) + "'," + ' "valorServicio"  = ' + "'"  + str(vrServicioGloDet) + "'," + ' "valorGlosa" = ' + "'" + str(valorGlosado) + "'," + ' "valorSoportado" = ' + "'" + str(valorSoportado) + "'," + ' "valorAceptado" = ' + "'" + str(vAceptado) + "', " + ' "valorNotasCredito" = ' + "'" + str(notasCreditoGlosa) + "'," + ' observaciones = ' + "'" + str(observacionesGloDet) + "'," + '"estadoReg" = ' + "'A'," + ' "motivoGlosa_id" = ' + "'" + str(motivoGlosa_id) + "'," + ' "usuarioRegistro_id" = ' + "'" + str(username_id) + "'," + ' "fechaRegistro" = ' + "'" + str(fechaRegistro) + "'," + '"ripsId" = ' + "'" + str(ripsId) + "'," + ' anulado = ' + "'N'," + ' "ripsOtrosServicios_id" = ' + "'" + str(ripsId) + "' WHERE glosa_id = " + "'" + str(glosaId) + "'" + ' AND "itemFactura" = ' + "'" + str(itemFacturaGloDet) + "'"


            print(comando)
            cur3.execute(comando)


            #TOTALES NOTAS CREDITO

            # TOTALES MEDICAMENTOS

            #comando2 = 'SELECT sum("valorAceptado")  vAceptado, sum("valorSoportado") valorSoportado, sum("valorGlosa") valorGlosado , sum("valorGlosa") totalGlosa , sum("valorNotasCredito") totalNotasCredito  FROM cartera_glosasdetalle WHERE glosa_id = ' + "'" + str(glosaId) + "' AND " + '"ripsMedicamentos_id" = ' + "'" + str(ripsId) + "'"
            comando2 = 'SELECT sum("valorAceptado")  vAceptado, sum("valorSoportado") valorSoportado, sum("valorGlosa") valorGlosado , sum("valorGlosa") totalGlosa , sum("valorNotasCredito") totalNotasCredito  FROM cartera_glosasdetalle WHERE glosa_id = ' + "'" + str(glosaId) + "'"
            print(comando2)
            cur3.execute(comando2)

            traeSum = []

            for vAceptado, valorSoportado, valorGlosado, totalGlosa, totalNotasCredito  in cur3.fetchall():
                traeSum.append({'vAceptado':vAceptado,'valorSoportado':valorSoportado,'valorGlosado':valorGlosado,'totalGlosa':totalGlosa,'totalNotasCredito':totalNotasCredito})

            totalAceptadoMed = traeSum[0]['vAceptado']
            totalAceptadoMed = str(totalAceptadoMed)
            totalAceptadoMed = totalAceptadoMed.replace("(", ' ')
            totalAceptadoMed = totalAceptadoMed.replace(")", ' ')
            totalAceptadoMed = totalAceptadoMed.replace(",", ' ')
            totalAceptadoMed = totalAceptadoMed.replace("'", ' ')
            totalAceptadoMed = totalAceptadoMed.replace("Decimal", ' ')

            totalSoportadoMed = traeSum[0]['valorSoportado']
            totalSoportadoMed = str(totalSoportadoMed)
            totalSoportadoMed = totalSoportadoMed.replace("(", ' ')
            totalSoportadoMed = totalSoportadoMed.replace(")", ' ')
            totalSoportadoMed = totalSoportadoMed.replace(",", ' ')
            totalSoportadoMed = totalSoportadoMed.replace("'", ' ')
            totalSoportadoMed = totalSoportadoMed.replace("Decimal", ' ')

            totalGlosadoMed = traeSum[0]['valorGlosado']
            totalGlosadoMed = str(totalGlosadoMed)
            totalGlosadoMed = totalGlosadoMed.replace("(", ' ')
            totalGlosadoMed = totalGlosadoMed.replace(")", ' ')
            totalGlosadoMed = totalGlosadoMed.replace(",", ' ')
            totalGlosadoMed = totalGlosadoMed.replace("'", ' ')
            totalGlosadoMed = totalGlosadoMed.replace("Decimal", ' ')

            totalGlosaMed = traeSum[0]['totalGlosa']
            totalGlosaMed = str(totalGlosaMed)
            totalGlosaMed = totalGlosaMed.replace("(", ' ')
            totalGlosaMed = totalGlosaMed.replace(")", ' ')
            totalGlosaMed = totalGlosaMed.replace(",", ' ')
            totalGlosaMed = totalGlosaMed.replace("'", ' ')
            totalGlosaMed = totalGlosaMed.replace("Decimal", ' ')

            totalNotasCreditoMed = traeSum[0]['totalNotasCredito']
            totalNotasCreditoMed = str(totalNotasCreditoMed)
            totalNotasCreditoMed = totalNotasCreditoMed.replace("(", ' ')
            totalNotasCreditoMed = totalNotasCreditoMed.replace(")", ' ')
            totalNotasCreditoMed = totalNotasCreditoMed.replace(",", ' ')
            totalNotasCreditoMed = totalNotasCreditoMed.replace("'", ' ')
            totalNotasCreditoMed = totalNotasCreditoMed.replace("Decimal", ' ')

            print("totalAceptadoMed = ", totalAceptadoMed)
            print("totalSoportadoMed = ", totalSoportadoMed)
            print("totalGlosadoMed = ", totalGlosadoMed)
            print("totalNotasCreditoMed = ", totalNotasCreditoMed)


            if (totalAceptadoMed == '' or totalAceptadoMed=='None'):
                totalAceptadoMed = 0.0

            if (totalSoportadoMed == '' or totalSoportadoMed=='None'):
                totalSoportadoMed = 0.0

            if (totalGlosadoMed == '' or totalGlosadoMed=='None'):
                totalGlosadoMed = 0.0

            if (totalGlosaMed == '' or totalGlosaMed=='None'):
                totalGlosaMed = 0.0

            if (totalNotasCreditoMed == '' or totalNotasCreditoMed == 'None'):
                totalNotasCreditoMed = 0.0

            totalAceptado = float(totalAceptadoMed)
            totalSoportado = float(totalSoportadoMed)
            totalGlosado = float(totalGlosadoMed)
            totalGlosa = float(totalGlosaMed)
            totalNotasCredito = float(totalNotasCreditoMed)

            print ("totalAceptado = ",totalAceptado)
            print("totalSoportado = ", totalSoportado)
            print("totalGlosado = ", totalGlosado)

            saldoFactura = 0
            # AQUI FALTA ACTUALIZAR EL SALDO DE LA FACTURA

            # TIENE QUE ACTUALIZAR CARTERA_GLOSAS LOS TOTALES / PENDIENTE SALDO FACTURA

            comando6 = 'UPDATE cartera_glosas SET "totalSoportado"= ' +"'" + str(totalSoportado) + "'," + '"totalGlosa" = ' + "'" + str(totalGlosado) + "'," + ' "totalAceptado" = ' + "'" +str(totalAceptado) + "'," + '"saldoFactura" = ' + "'" + str(saldoFactura) + "'," +  '"totalNotasCredito" = ' + "'" + str(totalNotasCredito) + "'"   +  ' WHERE id = ' + str(glosaId)

            print(comando6)
            cur3.execute(comando6)

            miConexion3.commit()
            cur3.close()
            miConexion3.close()

            return JsonResponse({'success': True, 'Mensajes': 'Glosa Detalle actualizada !'})

            ## AQUI FALTA EL INSERT A LA TABLA GLOSASDETALLE


    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            miConexion3.rollback()
        message_error= str(error)
        return JsonResponse({'success': False, 'Mensajes': message_error})

    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()


    # TIENE QUE ACTUALIZAR CARTERA_GLOSASDETALLE INSERTAR O UPDATE, NO VOY A METER MAS SIMPOLEMENTE UN QUERY ENTRE TABÑAS
    # RIPS Y LA FACTURACION PARA MOSTRAR EL NITIDO DETALLE GLOSADO



    # TIENE QUE ACTUALIZAR FACTURACION_FACTURACIONDETALLE INSERTAR O UPDATE DE PRONOT OPCIOPNAL ??

    # CREO NO MAS ??


    # Aqui voya leer el dato guardado

    glosa = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT id, "totalGlosa", "totalSoportado", "totalAceptado", "saldoFactura", "tipoGlosa_id", "estadoRadicacion_id" , "estadoRecepcion_id"  FROM public.cartera_glosas where id= ' + "'" + str(glosaId) + "'"

    print(detalle)

    curx.execute(detalle)

    for id, valorGlosa, totalSoportado, totalAceptado, saldoFactura, tipoGlosa_id, estadoRadicacion_id, estadoRecepcion_id in curx.fetchall():
        glosa.append(
            {"model": "cartera_glosas", "pk": id, "fields":
                {'id': id, 'valorGlosa': valorGlosa, 'totalSoportado': totalSoportado, 'totalAceptado': totalAceptado,
                 'saldoFactura': saldoFactura, 'tipoGlosa_id': tipoGlosa_id,
                 'estadoRadicacion_id': estadoRadicacion_id, 'estadoRecepcion_id': estadoRecepcion_id   }})

    miConexionx.close()
    print("glosa ", glosa)

    response_data = {}
    response_data['Data'] = glosa
    response_data['Error'] = 'No'
    response_data['success'] = True
    response_data['message'] = 'Glosa Actualizado satisfactoriamente!'

    print("response_data" ,response_data )

    # serialized1 = json.dumps(medicamentosRipsUnRegistro, default=str)
    # return HttpResponse(serialized1, content_type='application/json')


    return HttpResponse(json.dumps(response_data, default=str))

    #return JsonResponse({'success': True, 'Error' :'No', 'message': 'Glosa Actualizado satisfactoriamente!'})


def GuardaGlosasEstados(request):

    print ("Entre Guarda Glosas Estados" )

    glosaId = request.POST.get('post_idGlo')
    print ("id =", glosaId)

    tipoGlosa = request.POST["tipoGlosa_idGlo"]
    print ("tipoGlosa =", tipoGlosa)

    estadoRadicacion = request.POST["estadoRadicacion_idGlo"]
    print ("estadoRadicacion =", estadoRadicacion)

    estadoRecepcion = request.POST["estadoRecepcion_idGlo"]
    print ("estadoRecepcion =", estadoRecepcion)

    sedesClinica_id = request.POST["sedesClinica_idGlo"]
    print("sedesClinica_id =", sedesClinica_id)

    miConexion3 = None
    try:

        miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",  password="123456")
        cur3 = miConexion3.cursor()

        comando = 'UPDATE cartera_glosas SET "tipoGlosa_id"= ' +"'" + str(tipoGlosa) + "'," + ' "estadoRadicacion_id" = ' + "'" +str(estadoRadicacion) + "'," + '"estadoRecepcion_id" = ' + "'" + str(estadoRecepcion) + "'" + '   WHERE id = ' + str(glosaId)

        print(comando)
        cur3.execute(comando)
        miConexion3.commit()
        cur3.close()
        miConexion3.close()

        return JsonResponse({'success': True, 'Mensajes': 'Glosa Actualizada satisfactoriamente!'})


    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            miConexion3.rollback()
        message_error= str(error)
        return JsonResponse({'success': False, 'Mensajes': message_error})

    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()


def Load_tablaGlosasHospitalizacion(request, data):
    print("Entre load_data Hospitalizacion Rips")

    context = {}
    d = json.loads(data)

    sedesClinica_id = d['sedesClinica_id']
    print("sedesClinica_id = ", sedesClinica_id)

    facturaId = d['facturaId']
    print("facturaId = ", facturaId)

    hospitalizacionGlosas = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT  ripshosp.id id, "codPrestador", "fechaInicioAtencion", "numAutorizacion", "fechaEgreso", consecutivo, ripshosp."fechaRegistro", "causaMotivoAtencion_id", "codComplicacion_id", "codDiagnosticoCausaMuerte_id", "codDiagnosticoPrincipal_id", "codDiagnosticoPrincipalE_id", "codDiagnosticoRelacionadoE1_id", "codDiagnosticoRelacionadoE2_id", "codDiagnosticoRelacionadoE3_id", "condicionDestinoUsuarioEgreso_id", ripshosp."usuarioRegistro_id" usuarioRegistro_id, "viaIngresoServicioSalud_id", "ripsDetalle_id",ripshosp."ripsTipos_id", ripshosp."ripsTransaccion_id"  FROM public.rips_ripstransaccion ripstra , public.rips_ripshospitalizacion ripshosp  WHERE ripstra.id = ripshosp."ripsTransaccion_id" and cast(ripstra."numFactura" as integer) =' + "'" + str(facturaId) + "'"

    print(detalle)

    curx.execute(detalle)

    for id,  codPrestador, fechaInicioAtencion, numAutorizacion, fechaEgreso, consecutivo, fechaRegistro,  causaMotivoAtencion_id,  codComplicacion_id, codDiagnosticoCausaMuerte_id, codDiagnosticoPrincipal_id , codDiagnosticoPrincipalE_id,  codDiagnosticoRelacionadoE1_id, codDiagnosticoRelacionadoE2_id,        codDiagnosticoRelacionadoE3_id, condicionDestinoUsuarioEgreso_id, usuarioRegistro_id,  viaIngresoServicioSalud_id, ripsDetalle_id, ripsTipos_id, ripsTransaccion_id in curx.fetchall():
        hospitalizacionGlosas.append(
            {"model": "rips.RipsHopitalizacion", "pk": id, "fields":
                {'id': id, 'codPrestador': codPrestador , 'fechaInicioAtencion': fechaInicioAtencion,  'numAutorizacion':numAutorizacion, 'fechaEgreso':fechaEgreso,'consecutivo':consecutivo,'fechaRegistro':fechaRegistro,'causaMotivoAtencion_id':causaMotivoAtencion_id,
		'codComplicacion_id':codComplicacion_id, 'codDiagnosticoCausaMuerte_id':codDiagnosticoCausaMuerte_id, 'codDiagnosticoPrincipal_id':codDiagnosticoPrincipal_id, 'codDiagnosticoPrincipalE_id':codDiagnosticoPrincipalE_id,'codDiagnosticoRelacionadoE1_id':codDiagnosticoRelacionadoE1_id,'codDiagnosticoRelacionadoE2_id':codDiagnosticoRelacionadoE2_id,'codDiagnosticoRelacionadoE3_id':codDiagnosticoRelacionadoE3_id,
                 'condicionDestinoUsuarioEgreso_id':condicionDestinoUsuarioEgreso_id, 'usuarioRegistro_id':usuarioRegistro_id, 'viaIngresoServicioSalud_id':viaIngresoServicioSalud_id, 'ripsDetalle_id':ripsDetalle_id, 'ripsTipos_id':ripsTipos_id,'ripsTransaccion_id':ripsTransaccion_id
                 }})



    miConexionx.close()
    print("hospitalizacionGlosas "  , hospitalizacionGlosas)
    #context['usuariosRips'] = usuariosRips

    serialized1 = json.dumps(hospitalizacionGlosas,  default=str)

    return HttpResponse(serialized1, content_type='application/json')


def Load_tablaGlosasUrgencias(request, data):
    print("Entre load_data Urgencias Rips")

    context = {}
    d = json.loads(data)

    sedesClinica_id = d['sedesClinica_id']
    print("sedesClinica_id = ", sedesClinica_id)

    facturaId = d['facturaId']
    print("facturaId = ", facturaId)

    urgenciasGlosas = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT  ripsurg.id, "codPrestador","fechaInicioAtencion","fechaEgreso",consecutivo,ripsurg."fechaRegistro","causaMotivoAtencion_id","codDiagnosticoCausaMuerte_id", "codDiagnosticoPrincipal_id","codDiagnosticoPrincipalE_id", "codDiagnosticoRelacionadoE1_id","codDiagnosticoRelacionadoE2_id","codDiagnosticoRelacionadoE3_id","condicionDestinoUsuarioEgreso_id", ripsurg."usuarioRegistro_id","ripsDetalle_id","ripsTipos_id"  FROM public.rips_ripsurgenciasobservacion ripsurg , public.rips_ripstransaccion ripstra WHERE ripstra.id = ripsurg."ripsTransaccion_id" and cast(ripstra."numFactura" as integer) =' + "'" + str(facturaId) + "'"

    print(detalle)

    curx.execute(detalle)

    for id,  codPrestador, fechaInicioAtencion, fechaEgreso, consecutivo, fechaRegistro,  causaMotivoAtencion_id,   codDiagnosticoCausaMuerte_id, codDiagnosticoPrincipal_id , codDiagnosticoPrincipalE_id,  codDiagnosticoRelacionadoE1_id, codDiagnosticoRelacionadoE2_id,        codDiagnosticoRelacionadoE3_id, condicionDestinoUsuarioEgreso_id, usuarioRegistro_id,  viaIngresoServicioSalud_id, ripsDetalle_id, ripsTipos_id in curx.fetchall():
        urgenciasGlosas.append(
            {"model": "rips.RipsUrgenciasObservacion", "pk": id, "fields":
                {'id': id, 'codPrestador': codPrestador , 'fechaInicioAtencion': fechaInicioAtencion,   'fechaEgreso':fechaEgreso,'consecutivo':consecutivo,'fechaRegistro':fechaRegistro,'causaMotivoAtencion_id':causaMotivoAtencion_id,
		 'codDiagnosticoCausaMuerte_id':codDiagnosticoCausaMuerte_id, 'codDiagnosticoPrincipal_id':codDiagnosticoPrincipal_id, 'codDiagnosticoPrincipalE_id':codDiagnosticoPrincipalE_id,'codDiagnosticoRelacionadoE1_id':codDiagnosticoRelacionadoE1_id,'codDiagnosticoRelacionadoE2_id':codDiagnosticoRelacionadoE2_id,'codDiagnosticoRelacionadoE3_id':codDiagnosticoRelacionadoE3_id,
                 'condicionDestinoUsuarioEgreso_id':condicionDestinoUsuarioEgreso_id, 'usuarioRegistro_id':usuarioRegistro_id, 'viaIngresoServicioSalud_id':viaIngresoServicioSalud_id, 'ripsDetalle_id':ripsDetalle_id, 'ripsTipos_id':ripsTipos_id
                 }})



    miConexionx.close()
    print("urgenciasGlosas "  , urgenciasGlosas)
    #context['usuariosRips'] = usuariosRips

    serialized1 = json.dumps(urgenciasGlosas,  default=str)

    return HttpResponse(serialized1, content_type='application/json')


def GuardarCaja(request):

    print ("Entre GuardarCaja" )

    cajaId = request.POST.get('cajaId')
    print ("cajaId =", cajaId)

    serviciosAdministrativos = request.POST["serviciosAdministrativos_id"]
    print("serviciosAdministrativos =", serviciosAdministrativos)
    fecha = request.POST["fecha"]
    print("fecha =", fecha)
    usuarioEntrega = request.POST["usuarioEntrega_id"]
    print("usuarioEntrega =", usuarioEntrega)
    usuarioRecibe = request.POST["usuarioRecibe_id"]
    print("usuarioRecibe =", usuarioRecibe)
    usuarioSuperviza = request.POST["usuarioSuperviza_id"]
    print("usuarioSuperviza =", usuarioSuperviza)
    totalEfectivo = request.POST["totalEfectivo"]
    print("totalEfectivo =", totalEfectivo)
    totalTarjetasDebito = request.POST["totalTarjetasDebito"]
    print("totalTarjetasDebito =", totalTarjetasDebito)

    totalTarjetasCredito = request.POST["totalTarjetasCredito"]
    print("totalTarjetasCredito =", totalTarjetasCredito)
    totalCheques = request.POST["totalCheques"]
    print("totalCheques =", totalCheques)
    total = request.POST["total"]
    print("total =", total)
    estadoCaja = request.POST["estadoCaja"]
    print("estadoCaja =", estadoCaja)

    username = request.POST["username_idC"]
    print("username =", username)

    sede = request.POST["sedeC"]
    print("sede =", sede)

    fechaRegistro = timezone.now()


    miConexion3 = None
    try:

        miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",  password="123456")
        cur3 = miConexion3.cursor()

        comando = 'UPDATE cartera_caja SET "fechaRegistro"= ' +"'" + str(fechaRegistro) + "'," + ' "totalEfectivo" = ' + "'" +str(totalEfectivo) + "'," + '"totalTarjetasDebito" = ' + "'" + str(totalTarjetasDebito) + "',"  + '"totalTarjetasCredito" = ' + "'" + str(totalTarjetasCredito) + "',"  + '"totalCheques" = ' + "'" + str(totalCheques) + "'," + '"total" = ' + "'" + str(total) + "',"   + '"usuarioEntrega_id" = ' + "'" + str(usuarioEntrega) + "'," + '"usuarioRecibe_id" = ' + "'" + str(usuarioRecibe) + "'," + '"usuarioSuperviza_id" = ' + "'" + str(usuarioSuperviza) + "',"  + '"estadoCaja" = ' + "'" + str(estadoCaja) + "'," + '"serviciosAdministrativos_id" = ' + "'" + str(serviciosAdministrativos) + "'," + '"estadoReg" = ' + "'" + str('A') + "'"  + '   WHERE id = ' + str(cajaId)

        print(comando)
        cur3.execute(comando)
        miConexion3.commit()
        cur3.close()
        miConexion3.close()

        return JsonResponse({'success': True, 'Mensajes': 'Caja actualizada satisfactoriamente!'})

    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            #miConexion3.rollback()

        message_error= str(error)
        return JsonResponse({'success': False, 'Mensajes': message_error})

    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()


def EditarCaja(request):
    
    print("Entre EditarCaja")

    cajaId  = request.POST['cajaId']
    print("cajaId  =", cajaId)

    caja = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()
	
    detalle = 'SELECT id, fecha, "totalEfectivo", "totalTarjetasDebito", "totalTarjetasCredito", "totalCheques", total, "serviciosAdministrativos_id", "usuarioEntrega_id", "usuarioRecibe_id", "usuarioSuperviza_id", "estadoCaja" , "totalEfectivoEsperado", "totalTarjetasDebitoEsperado", "totalTarjetasCreditoEsperado", "totalChequesEsperado", "totalEsperado"   FROM cartera_caja WHERE id =  ' + "'" + str(cajaId) + "'"

    print(detalle)

    curx.execute(detalle)

    for  id, fecha, totalEfectivo, totalTarjetasDebito,totalTarjetasCredito,totalCheques, total, serviciosAdministrativos_id, usuarioEntrega_id, usuarioRecibe_id,  usuarioSuperviza_id, estadoCaja,   totalEfectivoEsperado, totalTarjetasDebitoEsperado,totalTarjetasCreditoEsperado,totalChequesEsperado, totalEsperado  in curx.fetchall():
     caja.append(
            {"model": "cartera.caja", "pk": id, "fields":
                {'id': id, 'fecha': fecha , 'totalEfectivo': totalEfectivo,  'totalTarjetasDebito':totalTarjetasDebito,
		  'totalTarjetasCredito':totalTarjetasCredito,'totalCheques':totalCheques,'total':total,'serviciosAdministrativos_id':serviciosAdministrativos_id,'usuarioEntrega_id':usuarioEntrega_id,'usuarioRecibe_id':usuarioRecibe_id,'usuarioSuperviza_id':usuarioSuperviza_id,'estadoCaja':estadoCaja,
                 'totalEfectivoEsperado': totalEfectivoEsperado, 'totalTarjetasDebitoEsperado': totalTarjetasDebitoEsperado,
                 'totalTarjetasCreditoEsperado': totalTarjetasCreditoEsperado, 'totalChequesEsperado': totalChequesEsperado, 'totalEsperado': totalEsperado
                 }})

    miConexionx.close()
    print("caja = "  , caja)
    
    serialized1 = json.dumps(caja, default=str)

    return HttpResponse(serialized1, content_type='application/json')


def Load_dataCaja(request, data):

    print("Entre load_data Load_dataCaja")

    context = {}
    d = json.loads(data)

    sedesClinica_id = d['sedesClinica_id']
    print("sedesClinica_id = ", sedesClinica_id)

    caja = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT caj.id, fecha, "totalEfectivo", "totalTarjetasDebito", "totalTarjetasCredito", "totalCheques", total, caj."fechaRegistro", caj."estadoReg", "serviciosAdministrativos_id", pla1.nombre usuarioEntrega_id, pla2.nombre usuarioRecibe_id, "usuarioRegistro_id", pla3.nombre usuarioSuperviza_id, "estadoCaja", caj."sedesClinica_id", "totalChequesEsperado", "totalEfectivoEsperado", "totalEsperado", "totalTarjetasCreditoEsperado", "totalTarjetasDebitoEsperado"  FROM cartera_caja caj LEFT JOIN planta_planta pla1 ON (pla1.id = caj."usuarioEntrega_id") LEFT JOIN planta_planta pla2 ON (pla2.id = caj."usuarioRecibe_id") LEFT JOIN planta_planta pla3 ON (pla3.id = caj."usuarioSuperviza_id")  WHERE caj."sedesClinica_id" = ' + "'" + str(sedesClinica_id) + "'"

    print ("detalle = ", detalle)

    curx.execute(detalle)

    for id,  fecha, totalEfectivo, totalTarjetasDebito,totalTarjetasCredito, totalCheques,  total,  fechaRegistro,  estadoReg , serviciosAdministrativos_id,  usuarioEntrega_id, usuarioRecibe_id, usuarioRegistro_id, usuarioSuperviza_id, estadoCaja, sedesClinica_id, totalChequesEsperado, totalEfectivoEsperado, totalEsperado, totalTarjetasCreditoEsperado, totalTarjetasDebitoEsperado in curx.fetchall():
        caja.append(
            {"model": "cartera.caja", "pk": id, "fields":
                {'id': id, 'fecha': fecha , 'totalEfectivo': totalEfectivo, 'totalTarjetasDebito': totalTarjetasDebito, 'totalTarjetasCredito':totalTarjetasCredito,
                 'totalCheques':totalCheques, 'total':total, 'fechaRegistro':fechaRegistro,
                 estadoReg:estadoReg, 'serviciosAdministrativos_id':serviciosAdministrativos_id, 'usuarioEntrega_id':usuarioEntrega_id, 'usuarioRecibe_id':usuarioRecibe_id,
                 'usuarioRegistro_id':usuarioRegistro_id, 'usuarioSuperviza_id':usuarioSuperviza_id,'estadoCaja':estadoCaja,'sedesClinica_id':sedesClinica_id,
                 'totalChequesEsperado':totalChequesEsperado,'totalEfectivoEsperado':totalEfectivoEsperado, 'totalEsperado':totalEsperado,
                 'totalTarjetasCreditoEsperado':totalTarjetasCreditoEsperado,'totalTarjetasDebitoEsperado':totalTarjetasDebitoEsperado
                 }})



    miConexionx.close()
    print("caja "  , caja)

    serialized1 = json.dumps(caja, default=str)

    return HttpResponse(serialized1, content_type='application/json')



def Load_tablaGlosasTotalesDetalle(request, data):
    print("Entre  Load_tablaGlosasTotalesDetalle")

    context = {}
    d = json.loads(data)


    sedesClinica_id = d['sedesClinica_id']
    print("sedesClinica_id = ", sedesClinica_id)

    facturaId = d['facturaId']
    print("facturaId = ", facturaId)

    glosaId = d['glosaId']
    print("glosaId = ", glosaId)


    glosasTotalesDetalle = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()



    #detalle = 'select ' + "'" + str('MEDICAMENTOS') + "'" + ' tipo,med.id, med.consecutivo consec, med."itemFactura",med."nomTecnologiaSalud" codigo,cums.nombre nombre,med."vrServicio",mot.nombre glosaNombre, med."cantidadGlosada",med."cantidadAceptada",med."cantidadSoportado", med."valorGlosado", med."vAceptado", med."valorSoportado",med."notasCreditoGlosa" FROM rips_ripstransaccion ripstra inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id) inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) left join cartera_motivosglosas mot on (mot.id = med."motivoGlosa_id")   where  cast(ripstra."numFactura" as float) = ' + str(facturaId) + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'" + str('PROCEDIMIENTOS') + "'" + ' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", cast(proc."codProcedimiento_id" as text) codigo, exa.nombre nombre, proc."vrServicio", mot.nombre glosaNombre, proc."cantidadGlosada", proc."cantidadAceptada", proc."cantidadSoportado", proc."valorGlosado", proc."vAceptado", proc."valorSoportado", proc."notasCreditoGlosa"  FROM  rips_ripstransaccion ripstra inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = proc."itemFactura") left join cartera_motivosglosas mot on (mot.id = proc."motivoGlosa_id")  where cast(ripstra."numFactura" as float) = ' +  str(facturaId) +  ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'"  + str('CONSULTAS') + "'" + ' tipo, cons.id, cons.consecutivo consec, cons."itemFactura", cast(cons."codConsulta_id" as text) codigo, exa.nombre nombre, cons."vrServicio", mot.nombre glosaNombre, cons."cantidadGlosada", cons."cantidadAceptada", cons."cantidadSoportado", cons."valorGlosado", cons."vAceptado", cons."valorSoportado", cons."notasCreditoGlosa" FROM rips_ripstransaccion  ripstra, rips_ripsconsultas cons, clinico_examenes exa, facturacion_facturaciondetalle det, cartera_motivosglosas mot  where cast(ripstra."numFactura" as float) = ' + str(facturaId) + ' and cons."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and cons. "codConsulta_id" = exa.id and cons."itemFactura" = det."consecutivoFactura" and mot.id = cons."motivoGlosa_id" UNION select '+ "'" + str('OTROS SERVICIOS') + "'" + ' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, cums.nombre nombre, serv."vrServicio", mot.nombre glosaNombre, serv."cantidadGlosada", serv."cantidadAceptada", serv."cantidadSoportado", serv."valorGlosado", serv."vAceptado", serv."valorSoportado", serv."notasCreditoGlosa" FROM rips_ripstransaccion ripstra, rips_ripsotrosservicios serv, rips_ripscums cums, facturacion_facturaciondetalle  det, cartera_motivosglosas  mot where cast(ripstra."numFactura" as float) = ' + "'" +  str(facturaId) + "'" + ' and serv."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and serv."codTecnologiaSalud_id" = cums.id and serv."itemFactura" = det."consecutivoFactura" and mot.id = serv."motivoGlosa_id"  order by 1,4'

    #detalle = 'select ' + "'" + str('MEDICAMENTOS') + "'" + ' tipo,med.id, med.consecutivo consec, med."itemFactura",cums.cum codigo,cums.nombre nombre,substring(mot.nombre,1,10) glosaNombre,med."vrServicio",  med."valorGlosado",	med."vAceptado", med."valorSoportado",med."notasCreditoGlosa",	detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"	FROM rips_ripstransaccion ripstra 	inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id) 	inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) left join cartera_motivosglosas mot on (mot.id = med."motivoGlosa_id")  left join cartera_glosasdetalle detGlo on (detGlo.glosa_id = ' + "'" + str(glosaId) + "' AND " + '  detGlo."ripsMedicamentos_id" = med.id)	where  cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'" + str('PROCEDIMIENTOS') + "'" + ' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", exa."codigoCups" codigo,	exa.nombre nombre,  substring(mot.nombre,1,10)  glosaNombre,proc."vrServicio",proc."valorGlosado", proc."vAceptado", proc."valorSoportado", proc."notasCreditoGlosa" ,detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito" FROM  rips_ripstransaccion ripstra inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = proc."itemFactura") left join cartera_motivosglosas mot on (mot.id = proc."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo.glosa_id = ' + "'" + str(glosaId) + "' AND " + 'detGlo."ripsProcedimientos_id" = proc.id) where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'" + str('CONSULTAS') + "'" + ' tipo, cons.id, cons.consecutivo consec, cons."itemFactura", exa."codigoCups" codigo,	exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre,cons."vrServicio",cons."valorGlosado", cons."vAceptado", cons."valorSoportado", cons."notasCreditoGlosa" ,	detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"	FROM rips_ripstransaccion  ripstra inner join  rips_ripsconsultas cons on (cons."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =cons."codConsulta_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = cons."itemFactura") left join cartera_motivosglosas mot on (mot.id = cons."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo.glosa_id = ' + "'" + str(glosaId) + "' AND " + ' detGlo."ripsConsultas_id" = cons.id)	 where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION	select ' + "'" + str('OTROS SERVICIOS') + "'" + ' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre, serv."vrServicio", serv."valorGlosado", serv."vAceptado", serv."valorSoportado", serv."notasCreditoGlosa" ,	detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"	FROM rips_ripstransaccion  ripstra inner join  rips_ripsotrosservicios serv on (serv."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =serv."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = serv."itemFactura") left join cartera_motivosglosas mot on (mot.id = serv."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo.glosa_id = ' + "'" + str(glosaId) + "' AND " + ' detGlo."ripsOtrosServicios_id" = serv.id)	where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' order by 1,4'

    detalle = 'select ' + "'" + str('MEDICAMENTOS') + "'" + ' tipo,med.id, med.consecutivo consec, med."itemFactura",cums.cum codigo,cums.nombre nombre,substring(mot.nombre,1,10) glosaNombre,med."vrServicio",  detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"	FROM rips_ripstransaccion ripstra 	inner join rips_ripsmedicamentos med on (med."ripsTransaccion_id" = ripstra.id) 	inner join  rips_ripscums cums on (cums.id =med."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id =cast(ripstra."numFactura" as float) and  det."consecutivoFactura" = med."itemFactura" ) left join cartera_motivosglosas mot on (mot.id = med."motivoGlosa_id")  left join cartera_glosasdetalle detGlo on (detGlo."ripsMedicamentos_id" = med.id)	where  cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'" + str('PROCEDIMIENTOS') + "'" + ' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", exa."codigoCups" codigo,	exa.nombre nombre,  substring(mot.nombre,1,10)  glosaNombre,proc."vrServicio",detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito" FROM  rips_ripstransaccion ripstra inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = proc."itemFactura") left join cartera_motivosglosas mot on (mot.id = proc."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo."ripsProcedimientos_id" = proc.id) where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'" + str('CONSULTAS') + "'" + ' tipo, cons.id, cons.consecutivo consec, cons."itemFactura", exa."codigoCups" codigo,	exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre,cons."vrServicio",	detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"	FROM rips_ripstransaccion  ripstra inner join  rips_ripsconsultas cons on (cons."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =cons."codConsulta_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = cons."itemFactura") left join cartera_motivosglosas mot on (mot.id = cons."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo."ripsConsultas_id" = cons.id)	 where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION	select ' + "'" + str('OTROS SERVICIOS') + "'" + ' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, exa.nombre nombre, substring(mot.nombre,1,10)  glosaNombre, serv."vrServicio",	detGlo."valorGlosa",    detGlo."valorSoportado" valosSoportado2,   detGlo."valorAceptado" ,    detGlo."valorNotasCredito"	FROM rips_ripstransaccion  ripstra inner join  rips_ripsotrosservicios serv on (serv."ripsTransaccion_id" = ripstra.id) left join clinico_examenes exa on ( exa.id =serv."codTecnologiaSalud_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = serv."itemFactura") left join cartera_motivosglosas mot on (mot.id = serv."motivoGlosa_id") left join cartera_glosasdetalle detGlo on (detGlo."ripsOtrosServicios_id" = serv.id)	where cast(ripstra."numFactura" as float) = ' + "'" + str(facturaId) + "'" + ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' order by 1,4'


    print(detalle)

    curx.execute(detalle)

    #for  tipo, id, consec, itemFactura, codigo, nombre,   glosaNombre,vrServicio,  valorGlosado,vAceptado, valorSoportado , notasCreditoGlosa , valorGlosa, valorSoportado2 , valorAceptado, valorNotasCredito in curx.fetchall():
    for tipo, id, consec, itemFactura, codigo, nombre, glosaNombre, vrServicio, valorGlosa, valorSoportado2, valorAceptado, valorNotasCredito in curx.fetchall():
        glosasTotalesDetalle.append(
            {"model": "rips.GlosasDetalle", "pk": id, "fields":
                {'tipo':tipo, 'id': id, 'consec':consec,  'itemFactura': itemFactura ,'codigo': codigo, 'nombre': nombre,'glosaNombre':glosaNombre,'vrServicio':vrServicio,
                 'valorGlosa': valorGlosa, 'valorSoportado2': valorSoportado2,   'valorAceptado': valorAceptado,
                 'valorNotasCredito': valorNotasCredito }})

    miConexionx.close()


    serialized1 = json.dumps(glosasTotalesDetalle,  default=str)

    print("glosasTotalesDetalle = ", serialized1)

    return HttpResponse(serialized1, content_type='application/json')


def BorraGlosasDetalle(request):
    
    print("Entre BorraGlosasDetalle")

    detGloId  = request.POST['detGloId']
    print("detGloId  =", detGloId)

    ripsId= request.POST['ripsId']
    print("ripsId  =", ripsId)

    glosaId= request.POST['glosaId']
    print("glosaId  =", glosaId)

    miConexion3 = None
    try:

        miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                       password="123456")
        cur3 = miConexion3.cursor()

        detalle = 'DELETE FROM cartera_glosasdetalle where id = ' + "'" + str(detGloId) + "'"

        print(detalle)
        cur3.execute(detalle)

        comando2 = 'SELECT sum("valorAceptado")  vAceptado, sum("valorSoportado") valorSoportado, sum("valorGlosa") valorGlosado , sum("valorGlosa") totalGlosa , sum("valorNotasCredito") totalNotasCredito  FROM cartera_glosasdetalle WHERE glosa_id = ' + "'" + str(glosaId) + "'"
        print(comando2)
        cur3.execute(comando2)

        traeSum = []

        for vAceptado, valorSoportado, valorGlosado, totalGlosa, totalNotasCredito  in cur3.fetchall():
            traeSum.append({'vAceptado':vAceptado,'valorSoportado':valorSoportado,'valorGlosado':valorGlosado,'totalGlosa':totalGlosa,'totalNotasCredito':totalNotasCredito})

        totalAceptadoMed = traeSum[0]['vAceptado']
        totalAceptadoMed = str(totalAceptadoMed)
        totalAceptadoMed = totalAceptadoMed.replace("(", ' ')
        totalAceptadoMed = totalAceptadoMed.replace(")", ' ')
        totalAceptadoMed = totalAceptadoMed.replace(",", ' ')
        totalAceptadoMed = totalAceptadoMed.replace("'", ' ')
        totalAceptadoMed = totalAceptadoMed.replace("Decimal", ' ')

        totalSoportadoMed = traeSum[0]['valorSoportado']
        totalSoportadoMed = str(totalSoportadoMed)
        totalSoportadoMed = totalSoportadoMed.replace("(", ' ')
        totalSoportadoMed = totalSoportadoMed.replace(")", ' ')
        totalSoportadoMed = totalSoportadoMed.replace(",", ' ')
        totalSoportadoMed = totalSoportadoMed.replace("'", ' ')
        totalSoportadoMed = totalSoportadoMed.replace("Decimal", ' ')

        totalGlosadoMed = traeSum[0]['valorGlosado']
        totalGlosadoMed = str(totalGlosadoMed)
        totalGlosadoMed = totalGlosadoMed.replace("(", ' ')
        totalGlosadoMed = totalGlosadoMed.replace(")", ' ')
        totalGlosadoMed = totalGlosadoMed.replace(",", ' ')
        totalGlosadoMed = totalGlosadoMed.replace("'", ' ')
        totalGlosadoMed = totalGlosadoMed.replace("Decimal", ' ')

        totalGlosaMed = traeSum[0]['totalGlosa']
        totalGlosaMed = str(totalGlosaMed)
        totalGlosaMed = totalGlosaMed.replace("(", ' ')
        totalGlosaMed = totalGlosaMed.replace(")", ' ')
        totalGlosaMed = totalGlosaMed.replace(",", ' ')
        totalGlosaMed = totalGlosaMed.replace("'", ' ')
        totalGlosaMed = totalGlosaMed.replace("Decimal", ' ')

        totalNotasCreditoMed = traeSum[0]['totalNotasCredito']
        totalNotasCreditoMed = str(totalNotasCreditoMed)
        totalNotasCreditoMed = totalNotasCreditoMed.replace("(", ' ')
        totalNotasCreditoMed = totalNotasCreditoMed.replace(")", ' ')
        totalNotasCreditoMed = totalNotasCreditoMed.replace(",", ' ')
        totalNotasCreditoMed = totalNotasCreditoMed.replace("'", ' ')
        totalNotasCreditoMed = totalNotasCreditoMed.replace("Decimal", ' ')

        print("totalAceptadoMed = ", totalAceptadoMed)
        print("totalSoportadoMed = ", totalSoportadoMed)
        print("totalGlosadoMed = ", totalGlosadoMed)
        print("totalNotasCreditoMed = ", totalNotasCreditoMed)


        if (totalAceptadoMed == '' or totalAceptadoMed=='None'):
            totalAceptadoMed = 0.0

        if (totalSoportadoMed == '' or totalSoportadoMed=='None'):
            totalSoportadoMed = 0.0

        if (totalGlosadoMed == '' or totalGlosadoMed=='None'):
            totalGlosadoMed = 0.0

        if (totalGlosaMed == '' or totalGlosaMed=='None'):
            totalGlosaMed = 0.0

        if (totalNotasCreditoMed == '' or totalNotasCreditoMed == 'None'):
            totalNotasCreditoMed = 0.0

        totalAceptado = float(totalAceptadoMed)
        totalSoportado = float(totalSoportadoMed)
        totalGlosado = float(totalGlosadoMed)
        totalGlosa = float(totalGlosaMed)
        totalNotasCredito = float(totalNotasCreditoMed)

        print ("totalAceptado = ",totalAceptado)
        print("totalSoportado = ", totalSoportado)
        print("totalGlosado = ", totalGlosado)

        saldoFactura = 0
        # AQUI FALTA ACTUALIZAR EL SALDO DE LA FACTURA

        # TIENE QUE ACTUALIZAR CARTERA_GLOSAS LOS TOTALES / PENDIENTE SALDO FACTURA

        comando6 = 'UPDATE cartera_glosas SET "totalSoportado"= ' +"'" + str(totalSoportado) + "'," + '"totalGlosa" = ' + "'" + str(totalGlosado) + "'," + ' "totalAceptado" = ' + "'" +str(totalAceptado) + "'," + '"saldoFactura" = ' + "'" + str(saldoFactura) + "'," +  '"totalNotasCredito" = ' + "'" + str(totalNotasCredito) + "'"   +  ' WHERE id = ' + str(glosaId)

        print(comando6)
        cur3.execute(comando6)

        miConexion3.commit()
        cur3.close()
        miConexion3.close()

        return JsonResponse({'success': True, 'Mensajes': 'Glosa Detalle eliminada !'})

    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            #miConexion3.rollback()

        message_error= str(error)
        return JsonResponse({'success': False, 'Mensajes': message_error})

    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()



def load_dataNotasCredito(request, data):
    print("load_dataNotasCredito")

    context = {}
    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']

    nombreSede = d['nombreSede']
    print("sede:", sede)
    print("username:", username)
    print("username_id:", username_id)

    notasCredito = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT nc.id,  nc."fechaNota", nc."valorNota", nc."fechaRegistro", nc."usuarioRegistro_id", nc.descripcion FROM public.cartera_notascredito nc, facturacion_liquidacion fac ,contratacion_convenios conv WHERE nc."sedesClinica_id" = ' + "'" + str(sede) + "'" + 'AND fac.convenio_id  = conv.id '

    print(detalle)

    curx.execute(detalle)

    for id,  fechaNota, valorNota, fechaRegistro,  usuarioRegistro_id, descripcion  in curx.fetchall():
        notasCredito.append(
            {"model": "cartera.notasCredito", "pk": id, "fields":
                {'id': id, 'valorNota':valorNota, 'fechaRegistro': fechaRegistro, 'usuarioRegistro_id': usuarioRegistro_id,'descripcion':descripcion}})

    miConexionx.close()
    print("notasCredito "  , notasCredito)
    context['NotasCredito'] = notasCredito

    serialized1 = json.dumps(notasCredito,  default=str)

    return HttpResponse(serialized1, content_type='application/json')

    


def load_dataNotasCreditoDetalle(request, data):
    print("load_dataNotasCreditoDetalle")

    context = {}
    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']
    notaCredito = d['notaCredito']
    nombreSede = d['nombreSede']
    print("sede:", sede)
    print("username:", username)
    print("username_id:", username_id)
    print("notaCredito:", notaCredito)



    notasCreditoDetalle = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner6", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT ncDet.id , nc.id notaCredito, ncDet.factura_id , ncDet."valorNota", ncDet."tiposNotasCredito_id" tipoNota, tip.nombre nombreTipoNota, ncDet."ripsProcedimientos_id" ripsProcedimientos,ncDet."ripsMedicamentos_id" ripsMedicamentos,ncDet."ripsConsultas_id" ripsConsultas, ncDet."ripsOtrosServicios_id" ripsOtrosServicios,  ncDet."fechaRegistro",  ncDet."usuarioRegistro_id" FROM public.cartera_notascredito nc, cartera_notascreditodetalle ncDet, cartera_tiposnotasCredito tip WHERE ncDet."notaCredito_id" = ' + "'" + str(notaCredito) + "'" + ' AND ncDet."notaCredito_id" = nc.id AND nc."sedesClinica_id" = ' + "'" + str(sede) + "'" + 'AND ncDet."tiposNotasCredito_id"  = tip.id '

    print(detalle)

    curx.execute(detalle)

    for id,  notaCredito,factura_id, valorNota, tipoNota, nombreTipoNota, ripsProcedimientos,  ripsMedicamentos, ripsConsultas,ripsOtrosServicios, fechaRegistro, usuarioRegistro_id in curx.fetchall():
        notasCreditoDetalle.append(
            {"model": "cartera.notasCreditoDetalle", "pk": id, "fields":
                {'id': id, 'notaCredito':notaCredito,'factura_id':factura_id, 'valorNota':valorNota,'tipoNota':tipoNota, 'nombreTipoNota':nombreTipoNota,
		'ripsProcedimientos':ripsProcedimientos, 'ripsMedicamentos':ripsMedicamentos, 'ripsConsultas':ripsConsultas, 'ripsOtrosServicios':ripsOtrosServicios,
		'fechaRegistro': fechaRegistro, 'usuarioRegistro_id': usuarioRegistro_id}})

    miConexionx.close()
    print("notasCreditoDetalle = "  , notasCreditoDetalle)
    context['NotasCreditoDetalle'] = notasCreditoDetalle

    serialized1 = json.dumps(notasCreditoDetalle,  default=str)

    return HttpResponse(serialized1, content_type='application/json')

    

