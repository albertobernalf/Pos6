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
import datetime
from decimal import Decimal
from admisiones.models import Ingresos
from autorizaciones.models import AutorizacionesDetalle, Autorizaciones
import io
from clinico.models import Historia, HistoriaMedicamentos
from facturacion.models import Liquidacion, LiquidacionDetalle



def decimal_serializer(obj):
    if isinstance(obj, Decimal):
        return str(obj)
    raise TypeError("Type not serializable")

def serialize_datetime(obj):
    if isinstance(obj, datetime.datetime):
        return obj.isoformat()
    raise TypeError("Type not serializable")



# Create your views here.

# Create your views here.
def load_dataAutorizaciones(request, data):
    print("Entre load_dataAutorizaciones")

    print("llegue bien01")

    context = {}
    d = json.loads(data)

    print("llegue bien02")

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']

    nombreSede = d['nombreSede']
    print("sede:", sede)
    print("username:", username)
    print("username_id:", username_id)

    # Combo Indicadores

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT ser.nombre, count(*) total FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd  WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and i."sedesClinica_id" = dep."sedesClinica_id" AND i."sedesClinica_id" = ' + "'" + str(
        sede) + "'" + ' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND dep.disponibilidad = ' + "'" + str(
        'O') + "'" + ' AND i."salidaDefinitiva" = ' + "'" + str(
        'N') + "'" + ' and tp.id = u."tipoDoc_id" and  i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id"  group by ser.nombre UNION SELECT ser.nombre, count(*) total FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , sitios_serviciosSedes sd, clinico_servicios ser WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND  t."sedesClinica_id" =  ' + "'" + str(
        sede) + "'" + ' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND  t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and  t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and  dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and  t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = ' + "'" + str(
        'TRIAGE') + "'" + ' group by ser.nombre'

    curt.execute(comando)
    print(comando)

    indicadores = []

    for id, nombre in curt.fetchall():
        indicadores.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(indicadores)

    context['Indicadores'] = indicadores

    # Fin combo Indicadores

    autorizaciones = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()


    detalle = 'select aut.id id ,aut."sedesClinica_id" ,sed.nombre sede,usu.nombre paciente,historia_id folio,"fechaSolicitud",aut.justificacion,"numeroAutorizacion","fechaAutorizacion", pla.nombre medico, aut.observaciones, estado.nombre estadoAutorizacion, "numeroSolicitud", "fechaVigencia", empresa_id, emp.nombre empresaNombre, "plantaOrdena_id", aut."usuarioRegistro_id" FROM autorizaciones_autorizaciones aut, sitios_sedesClinica sed, facturacion_empresas emp, clinico_historia historia, usuarios_usuarios usu, planta_planta pla , autorizaciones_estadosAutorizacion estado  where historia.id = aut.historia_id and sed.id = aut."sedesClinica_id" and emp.id = aut.empresa_id and usu."tipoDoc_id" = historia."tipoDoc_id" and usu.id = historia.documento_id and pla.id = aut."plantaOrdena_id" and estado.id = aut."estadoAutorizacion_id"          '


    print(detalle)

    curx.execute(detalle)

    for id ,sedesClinica_id,sede,paciente,folio,fechaSolicitud,justificacion,numeroAutorizacion,fechaAutorizacion, medico,observaciones,estadoAutorizacion,numeroSolicitud,fechaVigencia,empresa_id, empresaNombre,plantaOrdena_id,usuarioRegistro_id in curx.fetchall():
        autorizaciones.append(
            {"model": "autorizaciones_autorizaciones", "pk": id, "fields":
                {'id': id, 'sedesClinica_id': sedesClinica_id, 'sede': sede,'paciente': paciente,'folio': folio,'fechaSolicitud': fechaSolicitud,'justificacion':justificacion,   'numeroAutorizacion':numeroAutorizacion,'fechaAutorizacion':fechaAutorizacion,
                   'numeroAutorizacion': numeroAutorizacion, 'fechaAutorizacion':fechaAutorizacion,  'medico': medico, 'observaciones': observaciones,'estadoAutorizacion':estadoAutorizacion, 'numeroSolicitud':numeroSolicitud,
                 'fechaVigencia': fechaVigencia, 'empresa_id':empresa_id, 'empresaNombre':empresaNombre, 'plantaOrdena_id':plantaOrdena_id,'usuarioRegistro_id':usuarioRegistro_id}})
    miConexionx.close()
    print("autorizaciones "  , autorizaciones)
    context['Autorizaciones'] = autorizaciones

    serialized1 = json.dumps(autorizaciones, default=serialize_datetime)

    return HttpResponse(serialized1, content_type='application/json')


def load_dataAutorizacionesDetalle(request, data):
    print("Entre load_dataAutorizacionesDetalle")

    print("llegue bien01")

    context = {}
    d = json.loads(data)

    print("llegue bien02")

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']

    nombreSede = d['nombreSede']
    print("sede:", sede)
    print("username:", username)
    print("username_id:", username_id)

    autorizacionId = d['autorizacionId']
    print("autorizacionId:", autorizacionId)




    # Combo Indicadores

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT ser.nombre, count(*) total FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd  WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and i."sedesClinica_id" = dep."sedesClinica_id" AND i."sedesClinica_id" = ' + "'" + str(
        sede) + "'" + ' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND dep.disponibilidad = ' + "'" + str(
        'O') + "'" + ' AND i."salidaDefinitiva" = ' + "'" + str(
        'N') + "'" + ' and tp.id = u."tipoDoc_id" and  i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id"  group by ser.nombre UNION SELECT ser.nombre, count(*) total FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , sitios_serviciosSedes sd, clinico_servicios ser WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND  t."sedesClinica_id" =  ' + "'" + str(
        sede) + "'" + ' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND  t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and  t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and  dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and  t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = ' + "'" + str(
        'TRIAGE') + "'" + ' group by ser.nombre'

    curt.execute(comando)
    print(comando)

    indicadores = []

    for id, nombre in curt.fetchall():
        indicadores.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(indicadores)

    context['Indicadores'] = indicadores

    # Fin combo Indicadores

    autorizacionesDetalle = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()


    detalle = 'select ' + "'" + str('CUPS') + "'" + ' tipoTipoExamen, autdet.id id ,tipoexa.nombre tipoExamen,autdet.examenes_id examenId, exa.nombre examen,autdet."cantidadSolicitada", autdet."cantidadAutorizada",autdet."valorSolicitado", autdet."valorAutorizado", estado.nombre autorizado , autdet."usuarioRegistro_id" from autorizaciones_autorizacionesdetalle autdet, clinico_tiposexamen tipoexa, clinico_examenes exa , autorizaciones_estadosAutorizacion estado where autdet.autorizaciones_id = ' + "'" + str(autorizacionId) + "'" + ' and autdet."tiposExamen_id" = tipoexa.id and autdet.examenes_id = exa.id and autdet.examenes_id is not null and estado.id=autdet."estadoAutorizacion_id" union select ' + "'" + str('SUMINISTRO') + "'" + ' tipoTipoExamen, autdet.id id, tiposum.nombre tiposum, autdet.cums_id examenId, sum.nombre suministro, autdet."cantidadSolicitada", autdet."cantidadAutorizada", autdet."valorSolicitado", autdet."valorAutorizado" , estado.nombre ,autdet."usuarioRegistro_id"  from autorizaciones_autorizacionesdetalle autdet, facturacion_tipossuministro tiposum, facturacion_suministros sum , autorizaciones_estadosAutorizacion estado where autdet.autorizaciones_id = ' + "'" + str(autorizacionId) + "'" + ' and autdet."tipoSuministro_id" = tiposum.id and autdet.cums_id = sum.id and autdet.cums_id is not null and estado.id=autdet."estadoAutorizacion_id" '

    print(detalle)

    curx.execute(detalle)

    for tipoTipoExamen, id , tipoExamen, examenId, examen,cantidadSolicitada, cantidadAutorizada, valorSolicitado,valorAutorizado,autorizado , usuarioRegistro_id in curx.fetchall():
        autorizacionesDetalle.append(
            {"model": "autorizaciones_autorizacionesDetalle", "pk": id, "fields":
                {'tipoTipoExamen': tipoTipoExamen, 'id': id, 'tipoExamen': tipoExamen, 'examenId':examenId,'examen': examen,'cantidadSolicitada': cantidadSolicitada,'cantidadAutorizada': cantidadAutorizada,'valorSolicitado': valorSolicitado,'valorAutorizado':valorAutorizado,
                 'autorizado':autorizado,'usuarioRegistro_id':usuarioRegistro_id}})
    miConexionx.close()
    print("autorizacionesDetalle "  , autorizacionesDetalle)

    serialized1 = json.dumps(autorizacionesDetalle, default=str)

    return HttpResponse(serialized1, content_type='application/json')


def ActualizarAutorizacionDetalle(request):

    print ("Entre ActualizarAutorizacionDetalle" )

    autorizacionDetalleId = request.POST['autorizacionDetalleId']
    print("autorizacionDetalleId =", autorizacionDetalleId)

    estadoAutorizacion = request.POST['estadoAutorizacion']
    print("estadoAutorizacion =", estadoAutorizacion)

    numeroAutorizacion = request.POST['numeroAutorizacion']
    print("numeroAutorizacion =", numeroAutorizacion)

    examenId =request.POST['examenes_id']
    print("examenId:", examenId)

    tipoTipoExamen = request.POST['tipoTipoExamen']
    print("tipoTipoExamen:", tipoTipoExamen)


    cantidadAutorizada = request.POST['cantidadAutorizada']
    print("cantidadAutorizada =", cantidadAutorizada)

    valorAutorizado = request.POST['valorAutorizado']
    print("valorAutorizado =", valorAutorizado)

    now = datetime.datetime.now()
    dnow = now.strftime("%Y-%m-%d %H:%M:%S")
    print("NOW  = ", dnow)

    fechaRegistro = dnow
    print("fechaRegistro = ", fechaRegistro)

    estadoReg = 'A'
    usuarioRegistro_id = request.POST['usuarioRegistro2_id']

    print ("usuarioRegistro_id", usuarioRegistro_id)
    # ACTUALIZA DETALLE AUTORIZACION

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'UPDATE autorizaciones_autorizacionesdetalle SET  "estadoAutorizacion_id" =   ' + "'" + str(estadoAutorizacion) + "'," + ' "numeroAutorizacion" = '   + "'" + str(numeroAutorizacion) + "'," + ' "valorAutorizado" = ' + "'" + str(valorAutorizado) + "'," +   ' "fechaRegistro" = ' + "'" + str(fechaRegistro) + "',"  + ' "cantidadAutorizada" = ' + "'" + str(cantidadAutorizada) +  "'" +  ' WHERE id = ' + "'" + str(autorizacionDetalleId) + "'"

    print("detalle = ", detalle)

    curx.execute(detalle)
    miConexionx.commit()
    miConexionx.close()

    # RUTINA SI ESTA AUTORIZADO DEBE CREAR EN FACTURACONDETALLE, OPS CON TARIFA ?????? o el valor lo trae de la autoprizacion mejor

    datosAut1 = AutorizacionesDetalle.objects.get(id = autorizacionDetalleId)
    datosAut = Autorizaciones.objects.get(id=datosAut1.autorizaciones_id)


    print ("Historia = ", datosAut.historia_id)		

    datosHc = Historia.objects.get(id=datosAut.historia_id)
    print ("TipoDoc Paciente = ", datosHc.tipoDoc_id)
    print ("Paciente Cedula= ", datosHc.documento_id)
    print ("Paciente Ingreso= ", datosHc.consecAdmision)


    datosliq = Liquidacion.objects.get(tipoDoc_id =datosHc.tipoDoc.id, documento_id = datosHc.documento_id, consecAdmision= datosHc.consecAdmision)
    liquidacionId = datosliq.id
 
    ## si no existe hay que crear cabezote

    if (datosliq == ''):

	# CREA CABEZOTE

        # Si no existe liquidacion CABEZOTE se debe crear con los totales, abonos, anticipos, procedimiento, suministros etc
        miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432",                               user="postgres", password="123456")
        curt = miConexiont.cursor()
        comando = 'INSERT INTO facturacion_liquidacion ("sedesClinica_id", "tipoDoc_id", documento_id, "consecAdmision", fecha, "totalCopagos", "totalCuotaModeradora", "totalProcedimientos" , "totalSuministros" , "totalLiquidacion", "valorApagar", anticipos, "fechaRegistro", "estadoRegistro", convenio_id,  "usuarioRegistro_id", "totalAbonos") VALUES (' + "'" + str(sede) + "'," +  "'" + str(datosHc.tipoDoc_id) + "','" + str(datosHc.documento_id) + "','" + str(datosHc.consecAdmision) + "','" + str(fechaRegistro) + "'," + '0,0,0,0,0,0,0,' + "'" + str(fechaRegistro) + "','" + str(estadoReg) + "'," + str(null) + ',' + "'" + str(usuarioRegistro) + "',0) RETURNING id"
        curt.execute(comando)
        liquidacionId   = curt.fetchone()[0]
        miConexiont.commit()
        miConexiont.close()


    consecLiquidacionU = LiquidacionDetalle.objects.filter(liquidacion_id=liquidacionId).aggregate(maximo=Coalesce(Max('consecutivo'), 0))
    consecLiquidacion = (consecLiquidacionU['maximo']) + 1


    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                  password="123456")
    curt = miConexiont.cursor()

    if (tipoTipoExamen == 'SUMINISTROS'):
    
    ## Crear rutina para conseguir el id de historiaMedicamentosId

	    datosMed = HistoriaMedicamentos.objects.get(historia_id=datosAut.historia_id)
	    print ("El id de Medicamento es = ", datosMed.id)	


    if (tipoTipoExamen == 'CUPS'):
	
	    comando = 'INSERT INTO facturacion_liquidaciondetalle (consecutivo,fecha, cantidad, "valorUnitario", "valorTotal",cirugia,"fechaCrea", "fechaRegistro", "estadoRegistro", "examen_id",  "usuarioRegistro_id", liquidacion_id, "tipoRegistro") VALUES (' + "'" + str(consecLiquidacion) + "','" + str(fechaRegistro) + "','" + str(cantidadAutorizada) + "','" + str(valorAutorizado) + "','" + str(valorAutorizado) + "','" + str('N') + "','" + str(fechaRegistro) + "','" + str(fechaRegistro) + "','" + str(estadoReg) + "','" + str(examenId) + "','" + str(usuarioRegistro_id) + "','" + str(liquidacionId) + "','" + str('SISTEMA') + "'" + ')'
    else:

	    comando = 'INSERT INTO facturacion_liquidaciondetalle (consecutivo,fecha, cantidad, "valorUnitario", "valorTotal",cirugia,"fechaCrea", "fechaRegistro", "estadoRegistro", "cums_id",  "usuarioRegistro_id", liquidacion_id, "tipoRegistro","historiaMedicamento_id") VALUES (' + "'" + str(
	        consecLiquidacion) + "','" + str(fechaRegistro) + "','" + str(cantidadAutorizada) + "','" + str(
        	valorAutorizado) + "','" + str(valorAutorizado) + "','" + str('N') + "','" + str(fechaRegistro) + "','" + str(
	        fechaRegistro) + "','" + str(estadoReg) + "','" + str(examenId) + "','" + str(usuarioRegistro_id) + "','" + str(liquidacionId) + "'"  + ",'SISTEMA'," + "'" + str(datosMed.id) + "')"

    print ("comando = " , comando)

    curt.execute(comando)
    miConexiont.commit()
    miConexiont.close()

    # FIN FACTURACIONDETALLE


    return JsonResponse({'success': True, 'message': 'Detalle de Autorizacion actualizado satisfactoriamente!'})


def LeerDetalleAutorizacion(request):

    autorizacionDetalleId = request.POST['autorizacionDetalleId']
    print("autorizacionDetalleId =", autorizacionDetalleId)


    tipotipoExamen = AutorizacionesDetalle.objects.get(id=autorizacionDetalleId)

    print (" tipotipoExamen = ",tipotipoExamen.examenes_id )

    #Lee detalle Autorizacion

    context = {}

    autorizacionDetalle = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    if (tipotipoExamen.examenes_id != ''):

        print ("entre cups")

        detalle = 'select ' + "'" + str('CUPS') + "' tipoTipoExamen," + ' det.id, "cantidadSolicitada", "cantidadAutorizada", det."fechaRegistro", det."estadoReg", autorizaciones_id, det."usuarioRegistro_id", tipexa.nombre tipNombre  , exa.nombre exaNombre,  examenes_id, "valorAutorizado", "valorSolicitado", "tiposExamen_id", "tipoSuministro_id", "estadoAutorizacion_id", "numeroAutorizacion" , est.nombre estadoNombre FROM autorizaciones_autorizacionesdetalle det, autorizaciones_estadosautorizacion est, clinico_tiposexamen tipexa, clinico_examenes exa  WHERE det.id =' + "'" + str(autorizacionDetalleId) + "'" + ' AND tipexa.id = det."tiposExamen_id" AND exa.id = det.examenes_id AND est.id = det."estadoAutorizacion_id"'

    if (tipotipoExamen.cums_id == ''):
        print("entre suministros")

        detalle = 'select ' + "'" + str('SUMINISTROS') + "' tipoTipoExamen," + ' det.id, "cantidadSolicitada", "cantidadAutorizada", det."fechaRegistro", det."estadoReg", autorizaciones_id, det."usuarioRegistro_id",  tipsum.nombre tipNombre, exa.nombre exaNombre,  cums_id, "valorAutorizado", "valorSolicitado", "tiposExamen_id", det."tipoSuministro_id", "estadoAutorizacion_id", "numeroAutorizacion" , est.nombre estadoNombre FROM autorizaciones_autorizacionesdetalle det, autorizaciones_estadosautorizacion est, facturacion_tipossuministro tipsum, facturacion_suministros exa  WHERE det.id =' + "'" + str(autorizacionDetalleId) + "'" + 'AND tipsum.id = det."tipoSuministro_id"  AND exa.id = det.cums_id AND  est.id = det."estadoAutorizacion_id"'


    print(detalle)

    curx.execute(detalle)

    for tipoTipoExamen,id, cantidadSolicitada, cantidadAutorizada, fechaRegistro, estadoReg, autorizaciones_id, usuarioRegistro_id, tipNombre, exaNombre, examenes_id,  valorAutorizado,	valorSolicitado, tiposExamen_id, tipoSuministro_id, estadoAutorizacion_id, numeroAutorizacion, estadoNombre in curx.fetchall():
        autorizacionDetalle.append(
            {"model": "autorizaciones_autorizacionesdetalle", "pk": id, "fields":
                {'tipoTipoExamen':tipoTipoExamen, 'id':id, 'cantidadSolicitada':cantidadSolicitada,'cantidadAutorizada':cantidadAutorizada,'fechaRegistro':fechaRegistro,'estadoReg':estadoReg,
                 'autorizaciones_id':autorizaciones_id,'usuarioRegistro_id':usuarioRegistro_id,'tipNombre':tipNombre, 'exaNombre':exaNombre, 'examenes_id':examenes_id,'valorAutorizado':valorAutorizado,
                 'valorSolicitado':valorSolicitado,'tiposExamen_id':tiposExamen_id,'tipoSuministro_id':tipoSuministro_id,'estadoAutorizacion_id':estadoAutorizacion_id,'numeroAutorizacion':id,'numeroAutorizacion':numeroAutorizacion,'estadoNombre':estadoNombre}})

    miConexionx.close()
    print("autorizacionDetalle ", autorizacionDetalle)


    serialized1 = json.dumps(autorizacionDetalle, default=str)

    return HttpResponse(serialized1, content_type='application/json')
