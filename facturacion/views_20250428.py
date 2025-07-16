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
from facturacion.models import ConveniosPacienteIngresos, Liquidacion, LiquidacionDetalle, Facturacion, FacturacionDetalle
from cartera.models import TiposPagos, FormasPagos, Pagos, PagosFacturas
from triage.models import Triage
from clinico.models import Servicios
import pickle
from django.db.models import Q
from django.db import transaction, IntegrityError
from django.db.models import F

def decimal_serializer(obj):
    if isinstance(obj, Decimal):
        return str(obj)
    raise TypeError("Type not serializable")

def serialize_datetime(obj):
    if isinstance(obj, datetime.datetime): 
        return obj.isoformat() 
    raise TypeError("Type not serializable") 



# Create your views here.
def load_dataLiquidacion(request, data):
    print ("Entre load_data Liquidacion")

    context = {}
    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']

    nombreSede = d['nombreSede']
    print ("sede:", sede)
    print ("username:", username)
    print ("username_id:", username_id)
    

    # Combo Indicadores

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                       password="123456")
    curt = miConexiont.cursor()


    comando = 'SELECT ser.nombre, count(*) total FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd  WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and i."sedesClinica_id" = dep."sedesClinica_id" AND i."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND dep.disponibilidad = ' + "'" + str('O') + "'" + ' AND i."salidaDefinitiva" = ' + "'" + str('N') + "'" + ' and tp.id = u."tipoDoc_id" and  i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id"  group by ser.nombre UNION SELECT ser.nombre, count(*) total FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , sitios_serviciosSedes sd, clinico_servicios ser WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND  t."sedesClinica_id" =  ' + "'" + str(sede) + "'" + ' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND  t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and  t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and  dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and  t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = '  + "'" + str('TRIAGE') + "'" + ' group by ser.nombre'

    curt.execute(comando)
    print(comando)

    indicadores = []

    for id, nombre in curt.fetchall():
            indicadores.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(indicadores)

    context['Indicadores'] = indicadores

    # Fin combo Indicadores


    liquidacion = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",     password="123456")
    curx = miConexionx.cursor()
   

    #detalle = 'SELECT ' + "'" + str("INGRESO") + "'||" +  ' tipoIng, i.id'  + "||" +"'" + "-'||case when conv.id != 0 then conv.id else '00' end" + ' id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" , i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual , conv.nombre convenio, conv.id convenioId FROM admisiones_ingresos i, usuarios_usuarios u, sitios_dependencias dep , clinico_servicios ser ,usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  , clinico_Diagnosticos diag , sitios_serviciosSedes sd , facturacion_conveniospacienteingresos fac,contratacion_convenios conv WHERE sd."sedesClinica_id" = i."sedesClinica_id"  and sd.servicios_id  = ser.id and  i."sedesClinica_id" = dep."sedesClinica_id" AND i."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' AND  deptip.id = dep."dependenciasTipo_id" and i."serviciosActual_id" = ser.id AND dep.disponibilidad = ' + "'" + 'O' + "'" + ' AND i."salidaDefinitiva" = ' + "'" + 'N' + "'" + ' and tp.id = u."tipoDoc_id" and i."tipoDoc_id" = u."tipoDoc_id" and u.id = i."documento_id" and diag.id = i."dxActual_id" and i."fechaSalida" is null and dep."serviciosSedes_id" = sd.id and dep.id = i."dependenciasActual_id"  AND fac.documento_id = i.documento_id and fac."tipoDoc_id" = i."tipoDoc_id" and fac."consecAdmision" = i.consec and fac.convenio_id = conv.id UNION SELECT ' + "'"  + str("TRIAGE") + "'" + ' tipoIng, t.id'  + "||" +"'" + "-'||conv.id" + ' id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,t.consec consec , t."fechaSolicita" , cast(' + "'" + str('0001-01-01 00:00:00') + "'" + ' as timestamp) fechaSalida,ser.nombre servicioNombreIng, dep.nombre camaNombreIng , ' + "''" + ' dxActual , conv.nombre convenio, conv.id convenioId   FROM triage_triage t, usuarios_usuarios u, sitios_dependencias dep , usuarios_tiposDocumento tp , sitios_dependenciastipo deptip  ,sitios_serviciosSedes sd, clinico_servicios ser , facturacion_conveniospacienteingresos fac,contratacion_convenios conv WHERE sd."sedesClinica_id" = t."sedesClinica_id"  and t."sedesClinica_id" = dep."sedesClinica_id" AND t."sedesClinica_id" = ' "'" + str(sede) + "'" + ' AND dep."sedesClinica_id" =  sd."sedesClinica_id" AND dep.id = t.dependencias_id AND t."serviciosSedes_id" = sd.id  AND deptip.id = dep."dependenciasTipo_id" and  tp.id = u."tipoDoc_id" and t."tipoDoc_id" = u."tipoDoc_id" and u.id = t."documento_id"  and ser.id = sd.servicios_id and dep."serviciosSedes_id" = sd.id and t."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and t."consecAdmision" = 0 and dep."documento_id" = t."documento_id" and ser.nombre = ' + "'" + str('TRIAGE') + "'" + ' AND fac.documento_id = t.documento_id and fac."tipoDoc_id" = t."tipoDoc_id" and fac."consecAdmision" = t.consec and fac.convenio_id = conv.id'
    #detalle = 'SELECT ' + "'" + str("INGRESO") + "'" + "||'-'||" + ' i.id'  + "||" +"'" + "-'||case when conv.id != 0 then conv.id else " + "'" + str('00') + "'" + ' end id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" , i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual,conv.nombre convenio, conv.id convenioId FROM admisiones_ingresos i INNER JOIN clinico_servicios ser ON (ser.id = i."serviciosActual_id" ) INNER JOIN sitios_serviciosSedes sd ON (i."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id) INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  i."sedesClinica_id" and dep.id = i."dependenciasActual_id"  AND  (dep.disponibilidad= ' + "'" + str('O') + "'" + ' OR (dep.disponibilidad = ' + "'" + str('L') + "'" + ' AND ser.id=3)) AND dep."serviciosSedes_id" = sd.id ) INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxActual_id") LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and  fac."consecAdmision" = i.consec )  LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) WHERE i."sedesClinica_id" =  ' "'" + str(sede) + "'" + ' AND i."salidaDefinitiva" = ' + "'" + str('N') + "'" + ' and i."fechaSalida" is null UNION SELECT ' + "'"  + str("TRIAGE") + "'"+ "||'-'||"  + ' t.id'  + "||" +"'" + "-'||case when conv.id != 0 then conv.id else " + "'" + str('00') + "'" + ' end id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre, t.consec consec , t."fechaSolicita" , cast(' + "'" + str('0001-01-01 00:00:00') + "'" + ' as timestamp) fechaSalida,ser.nombre servicioNombreIng, dep.nombre camaNombreIng , ' + "' '" + ' dxActual , conv.nombre convenio, conv.id convenioId FROM triage_triage t INNER JOIN clinico_servicios ser ON ( ser.nombre = ' + "'" + str('TRIAGE') + "')" + ' INNER JOIN sitios_serviciosSedes sd ON (t."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id and sd.id = t."serviciosSedes_id" ) INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  t."sedesClinica_id" and dep.id = t.dependencias_id  AND dep.disponibilidad = ' + "'" + str('O') + "'" + ' AND dep."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and t."consecAdmision" = 0 and dep."documento_id" = t."documento_id") INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = t."tipoDoc_id" and fac.documento_id = t.documento_id and  fac."consecAdmision" = t.consec ) LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) WHERE  t."sedesClinica_id" = ' + "'" + str(sede) + "'"

    detalle = 'SELECT ' + "'" + str("INGRESO") + "'" + "||'-'||" + ' i.id'  + "||" +"'" + "-'||case when conv.id != 0 then conv.id else " + "'" + str('00') + "'" + ' end id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" , i."fechaSalida", ser.nombre servicioNombreIng, dep.nombre camaNombreIng , diag.nombre dxActual,conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica FROM admisiones_ingresos i INNER JOIN clinico_servicios ser ON (ser.id = i."serviciosActual_id" ) INNER JOIN sitios_serviciosSedes sd ON (i."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id) INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  i."sedesClinica_id" and dep.id = i."dependenciasActual_id"  AND  (dep.disponibilidad= ' + "'" + str('O') + "'" + ' OR (dep.disponibilidad = ' + "'" + str('L') + "'" + ' AND ser.id=3)) AND dep."serviciosSedes_id" = sd.id ) INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = i."tipoDoc_id" and u.id = i."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxActual_id") LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = i."tipoDoc_id" and fac.documento_id = i.documento_id and  fac."consecAdmision" = i.consec )  LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) WHERE i."sedesClinica_id" =  ' "'" + str(sede) + "'" + ' AND ((i."salidaDefinitiva" = ' + "'" + str('N') + "'" + ' and i."fechaSalida" is null)  or  (i."fechaSalida" is not null and i."salidaDefinitiva"=' + "'" + str('R') + "'" + ' ))   UNION SELECT ' + "'"  + str("TRIAGE") + "'"+ "||'-'||"  + ' t.id'  + "||" +"'" + "-'||case when conv.id != 0 then conv.id else " + "'" + str('00') + "'" + ' end id, tp.nombre tipoDoc,u.documento documento,u.nombre nombre, t.consec consec , t."fechaSolicita" , cast(' + "'" + str('0001-01-01 00:00:00') + "'" + ' as timestamp) fechaSalida,ser.nombre servicioNombreIng, dep.nombre camaNombreIng , ' + "' '" + ' dxActual , conv.nombre convenio, conv.id convenioId , ' + "'" + str('N') + "'" + ' salidaClinica  FROM triage_triage t INNER JOIN clinico_servicios ser ON ( ser.nombre = ' + "'" + str('TRIAGE') + "')" + ' INNER JOIN sitios_serviciosSedes sd ON (t."sedesClinica_id" = sd."sedesClinica_id" AND sd.servicios_id  = ser.id and sd.id = t."serviciosSedes_id" ) INNER JOIN  sitios_dependencias dep  ON (dep."sedesClinica_id" =  t."sedesClinica_id" and dep.id = t.dependencias_id  AND dep.disponibilidad = ' + "'" + str('O') + "'" + ' AND dep."serviciosSedes_id" = sd.id and dep."tipoDoc_id" = t."tipoDoc_id" and t."consecAdmision" = 0 and dep."documento_id" = t."documento_id") INNER JOIN sitios_dependenciastipo deptip ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" = t."tipoDoc_id" and u.id = t."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") LEFT JOIN facturacion_conveniospacienteingresos fac ON ( fac."tipoDoc_id" = t."tipoDoc_id" and fac.documento_id = t.documento_id and  fac."consecAdmision" = t.consec ) LEFT JOIN contratacion_convenios conv ON (conv.id  = fac.convenio_id) WHERE  t."sedesClinica_id" = ' + "'" + str(sede) + "'"

    print(detalle)

    curx.execute(detalle)

    for id, tipoDoc, documento, nombre, consec, fechaIngreso, fechaSalida, servicioNombreIng, camaNombreIng, dxActual , convenio, convenioId, salidaClinica in curx.fetchall():
        liquidacion.append(
		{"model":"ingresos.ingresos","pk":id,"fields":
			{ 'id':id, 'tipoDoc': tipoDoc, 'documento': documento, 'nombre': nombre, 'consec': consec,
                         'fechaIngreso': fechaIngreso, 'fechaSalida': fechaSalida,
                         'servicioNombreIng': servicioNombreIng, 'camaNombreIng': camaNombreIng,
                         'dxActual': dxActual,'convenio':convenio, 'convenioId':convenioId,'salidaClinica':salidaClinica }})

    miConexionx.close()
    print(liquidacion)
    context['Liquidacion'] = liquidacion

    serialized1 = json.dumps(liquidacion, default=serialize_datetime)

    return HttpResponse(serialized1, content_type='application/json')


def PostConsultaLiquidacion(request):
    print ("Entre PostConsultaLiquidacion ")

    Post_id = request.POST["post_id"]
    username_id = request.POST["username_id"]
    sede = request.POST["sede"]


    print("id = ", Post_id)
    llave = Post_id.split('-')
    print ("llave = " ,llave)
    print ("primero=" ,llave[0])
    print("segundo = " ,llave[1])
    print("tercero o convenio  = " ,llave[2])

    # Combo TiposPagos

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT c.id id,c.nombre nombre FROM cartera_tiposPagos c order by c.nombre'

    curt.execute(comando)
    print(comando)

    tiposPagos = []

    #tiposPagos.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
        tiposPagos.append({'id': id,  'nombre': nombre})

    miConexiont.close()
    print(tiposPagos)

    #context['TiposPagos'] = tiposPagos

    # Fin combo tiposPagos


    # Combo FormasPago

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT c.id id,c.nombre nombre FROM cartera_formasPagos c order by c.nombre'

    curt.execute(comando)
    print(comando)

    formasPagos = []

    #formasPagos.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
        formasPagos.append({'id': id,  'nombre': nombre})

    miConexiont.close()
    print(formasPagos)


    # Fin combo formasPagos

    # Combo Cups

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT c.id id,c.nombre ||' + "'" + str(' ') + "'" +  '||c."codigoCups" nombre FROM clinico_examenes c order by c.nombre'

    curt.execute(comando)
    print(comando)

    cups = []

    cups.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
        cups.append({'id': id,  'nombre': nombre})

    miConexiont.close()
    print(cups)


    # Fin combo Cups


    # Combo Suministros

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    #comando = 'SELECT c.id id, c.nombre||' + "' '" +  '||c.cums nombre FROM facturacion_suministros c order by c.nombre'
    comando = 'SELECT c.id id, c.nombre nombre FROM facturacion_suministros c order by c.nombre'

    curt.execute(comando)
    print(comando)

    suministros = []

    suministros.append({'id': '', 'nombre': ''})

    for id,  nombre in curt.fetchall():
        suministros.append({'id': id,  'nombre': nombre})

    miConexiont.close()
    print(suministros)

    # Fin combo suministros

    convenioId = llave[2]
    convenioId = convenioId.strip()

    print("Convenio despues de strip = ", convenioId)

    #if (convenioId == '0'):
    #    print("convenioId = ", convenioId)
    #    convenioId = ""

    print("convenioId FINAL= ", convenioId)


    if llave[0] == 'INGRESO':
        ingresoId = Ingresos.objects.get(id=llave[1])
        print ("ingresoId = ", ingresoId)
        print ("tipodDoc_id =" ,ingresoId.tipoDoc_id)
        print("documento_id =", ingresoId.documento_id)
        print("consec =", ingresoId.consec)
    else:
        triageId = Triage.objects.get(id=llave[1])
        print ("triageId = ", triageId.id)
        print ("tipodDoc_id =" ,triageId.tipoDoc_id)
        print("documento_id =", triageId.documento_id)
        print("consec =", triageId.consec)


    if llave[0] == 'INGRESO':
       # Combo Convenios Paciente
       #
       miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",   password="123456")
       curt = miConexiont.cursor()
       comando = 'SELECT ing.convenio_id id, conv.nombre nombre FROM facturacion_conveniospacienteingresos ing,contratacion_convenios conv where ing.convenio_id = conv.id and ing."tipoDoc_id" = ' + "'" + str(ingresoId.tipoDoc_id) + "'" + ' and ing.documento_id = ' + "'" + str(ingresoId.documento_id) + "'" + ' AND ing."consecAdmision" = ' + "'" + str(ingresoId.consec) + "'" + ' ORDER BY ing."tipoDoc_id", ing.documento_id '
       curt.execute(comando)
       print(comando)

       conveniosPaciente = []
       conveniosPaciente.append({'id': '', 'nombre': ''})

       for id,  nombre in curt.fetchall():
           conveniosPaciente.append({'id': id,  'nombre': nombre})

       miConexiont.close()
       print(conveniosPaciente)
       #context['ConveniosPaciente'] = conveniosPaciente
	   # Fin combo convenios Paciente
	
       # Combo Convenios PacienteHacia
       #
       miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",   password="123456")
       curt = miConexiont.cursor()
       comando = 'SELECT ing.convenio_id id, conv.nombre nombre FROM facturacion_conveniospacienteingresos ing,contratacion_convenios conv where ing.convenio_id = conv.id and ing."tipoDoc_id" = ' + "'" + str(ingresoId.tipoDoc_id) + "'" + ' and ing.documento_id = ' + "'" + str(ingresoId.documento_id) + "'" + ' AND ing."consecAdmision" = ' + "'" + str(ingresoId.consec) + "'" + ' ORDER BY ing."tipoDoc_id", ing.documento_id '
       curt.execute(comando)
       print(comando)

       conveniosPacienteHacia = []
       conveniosPacienteHacia.append({'id': '', 'nombre': ''})

       for id,  nombre in curt.fetchall():
           conveniosPacienteHacia.append({'id': id,  'nombre': nombre})

       miConexiont.close()
       print(conveniosPacienteHacia)
       #context['ConveniosPacienteHacia'] = conveniosPacienteHacia
	   # Fin combo convenios Paciente


    else:

	   # Combo Convenios Paciente
       #
       miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",   password="123456")
       curt = miConexiont.cursor()

       comando = 'SELECT ing.convenio_id id, conv.nombre nombre FROM facturacion_conveniospacienteingresos ing,contratacion_convenios conv where ing.convenio_id = conv.id and ing."tipoDoc_id" = ' + "'" + str(triageId.tipoDoc_id) + "'" + ' and ing.documento_id = ' + "'" + str(triageId.documento_id) + "'" + ' AND ing."consecAdmision" = ' + "'" + str(triageId.consec) + "'" + ' ORDER BY ing."tipoDoc_id", ing.documento_id '
       curt.execute(comando)
       print(comando)

       conveniosPaciente = []
       conveniosPaciente.append({'id': '', 'nombre': ''})

       for id,  nombre in curt.fetchall():

           conveniosPaciente.append({'id': id,  'nombre': nombre})

       miConexiont.close()
       print(conveniosPaciente)

	   #context['ConveniosPaciente'] = conveniosPaciente
	   # Fin combo convenios Paciente


    estadoReg= 'A'
    now = datetime.datetime.now()
    print("NOW  = ", now)
    fechaRegistro = now
    usuarioRegistro = ''

    # Primero colocamos el convenio en la tabla facturacion_facturacionliquidacion

    ##Liquidacion.objects.filter(tipoDoc_id=str(ingresoId.tipoDoc_id),documento_id=str(ingresoId.documento_id),consecAdmision = str(ingresoId.consec)).update(convenio_id=convenioId)

    # Validacion si existe o No existe CABEZOTE

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres", password="123456")

    curt = miConexiont.cursor()

    if llave[0] == 'INGRESO':
        if (convenioId == '0' or  convenioId == ''):

            print ("Entre Convenio=0 o Null");
            comando = 'SELECT id FROM facturacion_liquidacion WHERE "tipoDoc_id" = ' + str(ingresoId.tipoDoc_id) + ' AND documento_id = ' + str(ingresoId.documento_id) + ' AND "consecAdmision" = ' + str(ingresoId.consec) + ' and convenio_id is null'

        else:

            print ("Entre Convenio = " , convenioId);
            comando = 'SELECT id FROM facturacion_liquidacion WHERE "tipoDoc_id" = ' + str(ingresoId.tipoDoc_id) + ' AND documento_id = ' + str(ingresoId.documento_id) + ' AND "consecAdmision" = ' + str(ingresoId.consec) + ' and convenio_id = ' + "'" + str(convenioId) + "'"

    else:
        if (convenioId == '0' or  convenioId == ''):
            comando = 'SELECT id FROM facturacion_liquidacion WHERE "tipoDoc_id" = ' + str(triageId.tipoDoc_id) + ' AND documento_id = ' + str(triageId.documento_id) + ' AND "consecAdmision" = ' + str(triageId.consec) + ' and convenio_id is null'
        else:
            comando = 'SELECT id FROM facturacion_liquidacion WHERE "tipoDoc_id" = ' + str(triageId.tipoDoc_id) + ' AND documento_id = ' + str(triageId.documento_id) + ' AND "consecAdmision" = ' + str(triageId.consec) + ' and convenio_id = ' + "'" + str(convenioId) + "'"

    curt.execute(comando)
    print(comando)
    cabezoteLiquidacion = []

    for id in curt.fetchall():
        cabezoteLiquidacion.append({'id': id})

    miConexiont.close()

    print ("OJOOOOO cabezoteLiquidacion"  , cabezoteLiquidacion[0])

    miConexiont = None
    try:

      if (cabezoteLiquidacion[0] == []):
                print ("OJOOOOOO ENTRE AL CABEZOTE LIQUIDACION")
                # Si no existe liquidacion CABEZOTE se debe crear con los totales, abonos, anticipos, procedimiento, suministros etc


                miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432",       user="postgres", password="123456")
                curt = miConexiont.cursor()

                if (llave[0] == 'INGRESO'  and convenioId == '0') :

                        comando = 'INSERT INTO facturacion_liquidacion ("tipoDoc_id", documento_id, "consecAdmision", fecha, "totalCopagos", "totalCuotaModeradora", "totalProcedimientos" , "totalSuministros" , "totalLiquidacion", "valorApagar", anticipos, "fechaRegistro", "estadoRegistro", convenio_id,  "usuarioRegistro_id", "totalAbonos" , "totalRecibido" , "sedesClinica_id" ) VALUES (' + str(ingresoId.tipoDoc_id)  + ',' +  str(ingresoId.documento_id) + ',' + str(ingresoId.consec) + ',' +  "'" +  str(fechaRegistro) + "'," + '0,0,0,0,0,0,0,' + "'" + str(fechaRegistro) + "','" + str(estadoReg) + "', null"  + ',' + "'" + str(username_id) + "',0,0," + "'" + str(sede) + "') RETURNING id"
                        print ("Entre1")

                if (llave[0] == 'INGRESO' and convenioId != '0'):

                        comando = 'INSERT INTO facturacion_liquidacion ("tipoDoc_id", documento_id, "consecAdmision", fecha, "totalCopagos", "totalCuotaModeradora", "totalProcedimientos" , "totalSuministros" , "totalLiquidacion", "valorApagar", anticipos, "fechaRegistro", "estadoRegistro", convenio_id,  "usuarioRegistro_id", "totalAbonos" , "totalRecibido" , "sedesClinica_id" ) VALUES (' + str(ingresoId.tipoDoc_id)  + ',' +  str(ingresoId.documento_id) + ',' + str(ingresoId.consec) + ',' +  "'" +  str(fechaRegistro) + "'," + '0,0,0,0,0,0,0,' + "'" + str(fechaRegistro) + "','" + str(estadoReg) + "'," + str(convenioId) + ',' + "'" + str(username_id) + "',0,0," + "'" + str(sede) + "') RETURNING id"
                        print("Entre2")

                if (llave[0] == 'TRIAGE' and  convenioId == '0'):

                        comando = 'INSERT INTO facturacion_liquidacion ("tipoDoc_id", documento_id, "consecAdmision", fecha, "totalCopagos", "totalCuotaModeradora", "totalProcedimientos" , "totalSuministros" , "totalLiquidacion", "valorApagar", anticipos, "fechaRegistro", "estadoRegistro", convenio_id,  "usuarioRegistro_id", "totalAbonos" , "totalRecibido" , "sedesClinica_id" ) VALUES (' + str(triageId.tipoDoc_id)  + ',' +  str(triageId.documento_id) + ',' + str('0') + ',' +  "'" +  str(fechaRegistro) + "'," + '0,0,0,0,0,0,0,' + "'" + str(fechaRegistro) + "','" + str(estadoReg) + "', null" + ',' + "'" + str(username_id) + "',0,0," + "'" + str(sede) + "') RETURNING id"
                        print("Entre3")

                if (llave[0] == 'TRIAGE' and  convenioId != '0'):

                        comando = 'INSERT INTO facturacion_liquidacion ("tipoDoc_id", documento_id, "consecAdmision", fecha, "totalCopagos", "totalCuotaModeradora", "totalProcedimientos" , "totalSuministros" , "totalLiquidacion", "valorApagar", anticipos, "fechaRegistro", "estadoRegistro", convenio_id,  "usuarioRegistro_id", "totalAbonos" , "totalRecibido" , "sedesClinica_id" ) VALUES (' + str(triageId.tipoDoc_id)  + ',' +  str(triageId.documento_id) + ',' + str('0') + ',' +  "'" +  str(fechaRegistro) + "'," + '0,0,0,0,0,0,0,' + "'" + str(fechaRegistro) + "','" + str(estadoReg) + "'," + str(convenioId) + ',' + "'" + str(username_id) + "',0,0," + "'" + str(sede) + "') RETURNING id"
                        print("Entre4")

                curt.execute(comando)
                liquidacionId = curt.fetchone()[0]
                print("liquidacionId PARCIAL = ", liquidacionId)
                miConexiont.commit()
                curt.close()
                miConexiont.close()

      else:
                print("Por qui no entro")
                liquidacionId = cabezoteLiquidacion[0]['id']
                liquidacionId = str(liquidacionId)
                print("liquidacionId = ", liquidacionId)
                liquidacionId = str(liquidacionId)
                liquidacionId = liquidacionId.replace("(", ' ')
                liquidacionId = liquidacionId.replace(")", ' ')
                liquidacionId = liquidacionId.replace(",", ' ')

      print("liquidacionId FINAL = ", liquidacionId)


    except psycopg2.DatabaseError as error:
        print("Entre por rollback", error)
        if miConexiont:
            print("Entro ha hacer el Rollback")
            miConexiont.rollback()

            print("Voy a hacer el jsonresponde")
            return JsonResponse({'success': False, 'Mensaje': error})

    finally:
        if miConexiont:
            curt.close()
            miConexiont.close()


    # Fin validacion de Liquidacion cabezote

    if request.method == 'POST':

        # Abro Conexion

        miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",password="123456")
        cur = miConexionx.cursor()

        if llave[0] == 'INGRESO':	

            #comando = 'select ' + "'"  + str('INGRESO') + "'" + '  tipo, liq.id id,  "consecAdmision",  fecha ,  "totalCopagos" ,  "totalCuotaModeradora" ,  "totalProcedimientos" ,"totalSuministros", "totalLiquidacion", "valorApagar", "fechaCorte", anticipos, "detalleAnulacion", "fechaAnulacion", observaciones, liq."fechaRegistro", "estadoRegistro", convenio_id, liq."tipoDoc_id" , liq.documento_id, liq."usuarioRegistro_id", "totalAbonos", conv.nombre nombreConvenio, usu.nombre paciente, adm.id ingresoId1, usu.documento documento, tip.nombre tipoDocumento FROM facturacion_liquidacion liq, contratacion_convenios conv, usuarios_usuarios usu, admisiones_ingresos adm, usuarios_tiposdocumento  tip where adm.id = ' + "'" + str(llave[1]) + "'" + '  AND  liq.convenio_id = conv.id and usu.id = liq.documento_id  and adm."tipoDoc_id" = liq."tipoDoc_id"   AND tip.id = adm."tipoDoc_id" AND adm.documento_id = liq.documento_id  AND adm.consec = liq."consecAdmision" AND conv.id = ' + str(convenioId)
            comando =  'select ' + "'"  + str('INGRESO') + "'" + '  tipo, liq.id id, dep.nombre dependenciaNombre, serv.nombre servicioNombre , "consecAdmision",  fecha ,  "totalCopagos" ,  "totalCuotaModeradora" ,  "totalProcedimientos" ,"totalSuministros", "totalLiquidacion", "valorApagar", "fechaCorte", anticipos, "detalleAnulacion", "fechaAnulacion", observaciones,  liq."fechaRegistro", "estadoRegistro", convenio_id, liq."tipoDoc_id" , liq.documento_id, liq."usuarioRegistro_id", "totalAbonos",  conv.nombre nombreConvenio, usu.nombre paciente, adm.id ingresoId1, usu.documento documento, tip.nombre tipoDocumento , adm."salidaClinica" salidaClinica FROM facturacion_liquidacion liq INNER JOIN usuarios_usuarios usu ON (usu."tipoDoc_id" = liq."tipoDoc_id" AND usu.id = liq.documento_id) INNER JOIN admisiones_ingresos adm ON (adm."tipoDoc_id" = liq."tipoDoc_id"  AND adm.documento_id = liq.documento_id  AND adm.consec = liq."consecAdmision"  ) INNER JOIN usuarios_tiposdocumento  tip ON (tip.id = adm."tipoDoc_id") LEFT JOIN clinico_servicios serv ON (serv.id = adm."serviciosActual_id") LEFT JOIN sitios_dependencias dep on (dep.id =adm."dependenciasActual_id") LEFT JOIN  contratacion_convenios conv ON (conv.id = liq.convenio_id) where liq.id = ' + "'" +  str(liquidacionId) + "'" + ' AND adm.id = ' + "'" + str(llave[1]) + "'"
        else:

            #comando = 'select ' + "'"  + str('TRIAGE') + "'" + ' tipo, liq.id id,  tri."consecAdmision" consecAdmision,  fecha ,  "totalCopagos" ,  "totalCuotaModeradora" ,  "totalProcedimientos" ,"totalSuministros", "totalLiquidacion", "valorApagar", "fechaCorte", anticipos, "detalleAnulacion", "fechaAnulacion", tri.observaciones, liq."fechaRegistro", "estadoRegistro", convenio_id, liq."tipoDoc_id" , liq.documento_id, liq."usuarioRegistro_id", "totalAbonos", conv.nombre nombreConvenio, usu.nombre paciente, tri.id triageId1, usu.documento documento, tip.nombre tipoDocumento FROM facturacion_liquidacion liq, contratacion_convenios conv, usuarios_usuarios usu, triage_triage tri, usuarios_tiposdocumento  tip where tri.id = ' + "'" + str(llave[1]) + "'" + '  AND  liq.convenio_id = conv.id and usu.id = liq.documento_id  and tri."tipoDoc_id" = liq."tipoDoc_id"   AND tip.id = tri."tipoDoc_id" AND tri.documento_id = liq.documento_id  AND tri.consec = liq."consecAdmision" AND conv.id = ' + str(convenioId)
            comando =  'select ' + "'"  + str('TRIAGE') + "'" + ' tipo, liq.id id, ' + "'" + str('Triage') + "'" + ' dependenciaNombre, ' + "'" + str('TRIAGE') + "'" + '  servicioNombre, tri."consecAdmision",  fecha ,  "totalCopagos" ,  "totalCuotaModeradora" ,  "totalProcedimientos" ,"totalSuministros", "totalLiquidacion", "valorApagar", "fechaCorte", anticipos, "detalleAnulacion", "fechaAnulacion", tri.observaciones, liq."fechaRegistro", "estadoRegistro", convenio_id, liq."tipoDoc_id" , liq.documento_id, liq."usuarioRegistro_id", "totalAbonos", conv.nombre nombreConvenio, usu.nombre paciente, tri.id triageId1, usu.documento documento, tip.nombre tipoDocumento, ' + "'N'" + ' salidaClinica  FROM facturacion_liquidacion liq inner join  triage_triage tri on (tri."tipoDoc_id" = liq."tipoDoc_id"  and tri.documento_id = liq.documento_id  AND tri.consec = liq."consecAdmision" ) left join  contratacion_convenios conv on (conv.id = liq.convenio_id) inner join  usuarios_usuarios usu on (usu."tipoDoc_id" = liq."tipoDoc_id" AND usu.id = liq.documento_id) inner join usuarios_tiposdocumento  tip on (tip.id = usu."tipoDoc_id") where liq.id = ' + "'" +  str(liquidacionId) + "'" + ' AND tri.id = ' + "'" + str(llave[1]) + "'"
            print(comando)

        cur.execute(comando)

        liquidacion = []

        if llave[0] == 'INGRESO':

          for tipo, id, dependenciaNombre, servicioNombre, consecAdmision,fecha ,totalCopagos,totalCuotaModeradora,totalProcedimientos ,totalSuministros, totalLiquidacion, valorApagar, fechaCorte, anticipos, detalleAnulacion, fechaAnulacion, observaciones, fechaRegistro, estadoRegistro, convenio_id, tipoDoc_id , documento_id, usuarioRegistro_id, totalAbonos, nombreConvenio , paciente, ingresoId1 , documento, tipoDocumento, salidaClinica in cur.fetchall():
            liquidacion.append( {"tipo":tipo, "id": id, "dependenciaNombre":dependenciaNombre,"servicioNombre":servicioNombre,
                     "consecAdmision": consecAdmision,
                     "fecha": fecha,
                     "totalCopagos": totalCopagos, "totalCuotaModeradora": totalCuotaModeradora,
                     "totalProcedimientos": totalProcedimientos,
                                 "totalSuministros": totalSuministros,
                                 "totalLiquidacion": totalLiquidacion, "valorApagar": valorApagar,
                                 "fechaCorte": fechaCorte,  "anticipos": anticipos,
                                 "detalleAnulacion": detalleAnulacion,  "fechaAnulacion": fechaAnulacion,  "observaciones": observaciones,
                                 "fechaRegistro": fechaRegistro, "estadoRegistro": estadoRegistro, "convenio_id": convenio_id,
            "tipoDoc_id": tipoDoc_id, "documento_id":documento_id,  "usuarioRegistro_id": usuarioRegistro_id,
            "totalAbonos": totalAbonos, "nombreConvenio": nombreConvenio,   "paciente": paciente,
            "ingresoId1": ingresoId1, "documento": documento, "tipoDocumento": tipoDocumento, "salidaClinica":salidaClinica
                                 })
        else:
          for tipo, id, dependenciaNombre, servicioNombre, consecAdmision,fecha ,totalCopagos,totalCuotaModeradora,totalProcedimientos ,totalSuministros, totalLiquidacion, valorApagar, fechaCorte, anticipos, detalleAnulacion, fechaAnulacion, observaciones, fechaRegistro, estadoRegistro, convenio_id, tipoDoc_id , documento_id, usuarioRegistro_id, totalAbonos, nombreConvenio , paciente, triageId1 , documento, tipoDocumento , salidaClinica in cur.fetchall():
            liquidacion.append( { "tipo":tipo, "id": id, "dependenciaNombre":dependenciaNombre,"servicioNombre":servicioNombre,
                     "consecAdmision": consecAdmision,
                     "fecha": fecha,
                     "totalCopagos": totalCopagos, "totalCuotaModeradora": totalCuotaModeradora,
                     "totalProcedimientos": totalProcedimientos,
                                 "totalSuministros": totalSuministros,
                                 "totalLiquidacion": totalLiquidacion, "valorApagar": valorApagar,
                                 "fechaCorte": fechaCorte,  "anticipos": anticipos,
                                 "detalleAnulacion": detalleAnulacion,  "fechaAnulacion": fechaAnulacion,  "observaciones": observaciones,
                                 "fechaRegistro": fechaRegistro, "estadoRegistro": estadoRegistro, "convenio_id": convenio_id,
            "tipoDoc_id": tipoDoc_id, "documento_id":documento_id,  "usuarioRegistro_id": usuarioRegistro_id,
            "totalAbonos": totalAbonos, "nombreConvenio": nombreConvenio,   "paciente": paciente,
            "triageId1": triageId1, "documento": documento, "tipoDocumento": tipoDocumento, "salidaClinica":salidaClinica
                                 })

        miConexionx.close()
        print(liquidacion)

        # Cierro Conexion

        if llave[0] == 'INGRESO':	

           totalSuministros = LiquidacionDetalle.objects.all().filter(liquidacion_id=liquidacionId).filter(examen_id = None).exclude(estadoRegistro='N').aggregate(totalS=Coalesce(Sum('valorTotal'), 0))
           totalSuministros = (totalSuministros['totalS']) + 0
           print("totalSuministros", totalSuministros)
           totalProcedimientos = LiquidacionDetalle.objects.all().filter(liquidacion_id=liquidacionId).filter(cums_id = None).exclude(estadoRegistro='N').aggregate(totalP=Coalesce(Sum('valorTotal'), 0))
           totalProcedimientos = (totalProcedimientos['totalP']) + 0
           print("totalProcedimientos", totalProcedimientos)
           registroPago = Liquidacion.objects.get(id=liquidacionId)
           totalCopagos = registroPago.totalCopagos
           totalCuotaModeradora = registroPago.totalCuotaModeradora
           totalAnticipos = registroPago.anticipos
           totalAbonos = registroPago.totalAbonos
           totalRecibido = registroPago.totalRecibido
           totalAnticipos = registroPago.anticipos
           valorApagar = registroPago.valorApagar
           totalLiquidacion = registroPago.totalLiquidacion


        else:

           totalSuministros = LiquidacionDetalle.objects.all().filter(liquidacion_id=liquidacionId).filter(examen_id = None).exclude(estadoRegistro='N').aggregate(totalS=Coalesce(Sum('valorTotal'), 0))
           totalSuministros = (totalSuministros['totalS']) + 0
           print("totalSuministros", totalSuministros)
           totalProcedimientos = LiquidacionDetalle.objects.all().filter(liquidacion_id=liquidacionId).filter(cums_id = None).exclude(estadoRegistro='N').aggregate(totalP=Coalesce(Sum('valorTotal'), 0))
           totalProcedimientos = (totalProcedimientos['totalP']) + 0
           registroPago = Liquidacion.objects.get(id=liquidacionId)
           totalCopagos = registroPago.totalCopagos
           totalCuotaModeradora = registroPago.totalCuotaModeradora
           totalAnticipos = registroPago.anticipos
           totalAbonos = registroPago.totalAbonos
           totalRecibido = registroPago.totalRecibido
           totalAnticipos = registroPago.anticipos
           valorApagar = registroPago.valorApagar
           totalLiquidacion = registroPago.totalLiquidacion


        if llave[0] == 'INGRESO':

            return JsonResponse({'pk':liquidacion[0]['id'],'tipo':liquidacion[0]['tipo'], 'id':liquidacion[0]['id'],  "dependenciaNombre":liquidacion[0]['dependenciaNombre'] ,"servicioNombre":liquidacion[0]['servicioNombre'],'consecAdmision':liquidacion[0]['consecAdmision'],'fecha':liquidacion[0]['fecha'],
                             'totalCopagos':liquidacion[0]['totalCopagos'],  'totalCuotaModeradora': liquidacion[0]['totalCuotaModeradora'],
                             'totalProcedimientos': liquidacion[0]['totalProcedimientos'],
                             'totalSuministros': liquidacion[0]['totalSuministros'],
                             'totalLiquidacion': liquidacion[0]['totalLiquidacion'],
                             'fechaCorte': liquidacion[0]['fechaCorte'],
                             'valorApagar': liquidacion[0]['valorApagar'],
                             'anticipos': liquidacion[0]['anticipos'],
                             'detalleAnulacion': liquidacion[0]['detalleAnulacion'],
                             'fechaAnulacion': liquidacion[0]['fechaAnulacion'],
                             'observaciones': liquidacion[0]['observaciones'],
                             'fechaRegistro': liquidacion[0]['fechaRegistro'],
                             'estadoRegistro': liquidacion[0]['estadoRegistro'],
                             'convenio_id': liquidacion[0]['convenio_id'],
                             'tipoDoc_id': liquidacion[0]['tipoDoc_id'],
                             'documento_id': liquidacion[0]['documento_id'],
                             'usuarioRegistro_id': liquidacion[0]['usuarioRegistro_id'],
                             'totalAbonos': liquidacion[0]['totalAbonos'],
                             'nombreConvenio': liquidacion[0]['nombreConvenio'],
                             'paciente': liquidacion[0]['paciente'], 'Suministros':suministros, 'Cups':cups,
			     'totalSuministros':totalSuministros,'totalProcedimientos':totalProcedimientos,'totalCopagos':totalCopagos,
			     'totalCuotaModeradora':totalCuotaModeradora,'totalAnticipos':totalAnticipos, 'totalAbonos':totalAbonos,
			     'totalLiquidacion':totalLiquidacion, 'totalRecibido':totalRecibido , 'totalAPagar':valorApagar, 'TiposPagos':tiposPagos, 'FormasPagos':formasPagos,
			     'ingresoId1': ingresoId1, 'documento': documento, 'tipoDocumento': tipoDocumento, 'ConveniosPaciente':conveniosPaciente,
                                'salidaClinica':salidaClinica

            })
        else:
            return JsonResponse(
                {'pk': liquidacion[0]['id'], 'tipo':liquidacion[0]['tipo'], 'id':liquidacion[0]['id'] ,"dependenciaNombre":liquidacion[0]['dependenciaNombre'] ,"servicioNombre":liquidacion[0]['servicioNombre'],  'consecAdmision': liquidacion[0]['consecAdmision'],
                 'fecha': liquidacion[0]['fecha'],
                 'totalCopagos': liquidacion[0]['totalCopagos'],
                 'totalCuotaModeradora': liquidacion[0]['totalCuotaModeradora'],
                 'totalProcedimientos': liquidacion[0]['totalProcedimientos'],
                 'totalSuministros': liquidacion[0]['totalSuministros'],
                 'totalLiquidacion': liquidacion[0]['totalLiquidacion'],
                 'fechaCorte': liquidacion[0]['fechaCorte'],
                 'valorApagar': liquidacion[0]['valorApagar'],
                 'anticipos': liquidacion[0]['anticipos'],
                 'detalleAnulacion': liquidacion[0]['detalleAnulacion'],
                 'fechaAnulacion': liquidacion[0]['fechaAnulacion'],
                 'observaciones': liquidacion[0]['observaciones'],
                 'fechaRegistro': liquidacion[0]['fechaRegistro'],
                 'estadoRegistro': liquidacion[0]['estadoRegistro'],
                 'convenio_id': liquidacion[0]['convenio_id'],
                 'tipoDoc_id': liquidacion[0]['tipoDoc_id'],
                 'documento_id': liquidacion[0]['documento_id'],
                 'usuarioRegistro_id': liquidacion[0]['usuarioRegistro_id'],
                 'totalAbonos': liquidacion[0]['totalAbonos'],
                 'nombreConvenio': liquidacion[0]['nombreConvenio'],
                 'paciente': liquidacion[0]['paciente'], 'Suministros': suministros, 'Cups': cups,
                 'totalSuministros': totalSuministros, 'totalProcedimientos': totalProcedimientos,
                 'totalCopagos': totalCopagos,
                 'totalCuotaModeradora': totalCuotaModeradora, 'totalAnticipos': totalAnticipos,
                 'totalAbonos': totalAbonos,
                 'totalLiquidacion': totalLiquidacion, 'totalRecibido':totalRecibido , 'totalAPagar': valorApagar, 'TiposPagos': tiposPagos,
                 'FormasPagos': formasPagos,
                 'triageId1': triageId1, 'documento': documento, 'tipoDocumento': tipoDocumento , 'ConveniosPaciente':conveniosPaciente,
                 'salidaClinica': salidaClinica

                 })

    else:
        return JsonResponse({'errors':'Something went wrong!'})

def load_dataLiquidacionDetalle(request, data):
    print("Entre load_data LiquidacionDetalle")

    context = {}

    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']
    #valor = d['valor']
    liquidacionId = d['liquidacionId']

    nombreSede = d['nombreSede']
    print("sede:", sede)
    print("username:", username)
    print("username_id:", username_id)
    print("liquidacionId:",liquidacionId)


    # Abro Conexion para la Liquidacion Detalle

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    cur = miConexionx.cursor()

    comando = 'select liq.id id,consecutivo ,  cast(date(fecha)||\' \'||to_char(fecha, \'HH:MI:SS\') as text) fecha  ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia ,  cast(date("fechaCrea")||\' \'||to_char("fechaCrea", \'HH:MI:SS\') as text)  fechaCrea , liq.observaciones ,  "estadoRegistro" ,  "examen_id" ,  cums_id , exa.nombre  nombreExamen  ,  liquidacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro" , liq."estadoRegistro" estadoReg FROM facturacion_liquidaciondetalle liq inner join clinico_examenes exa on (exa.id = liq."examen_id")  where liquidacion_id= ' + "'" +  str(liquidacionId) + "'" +  ' UNION select liq.id id,consecutivo , cast(date(fecha)||\' \'||to_char(fecha, \'HH:MI:SS\') as text) fecha  ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia ,  cast(date("fechaCrea")||\' \'||to_char("fechaCrea", \'HH:MI:SS\') as text)  fechaCrea , liq.observaciones ,  "estadoRegistro" ,  "examen_id" ,  cums_id , sum.nombre  nombreExamen  ,  liquidacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro" , liq."estadoRegistro" estadoReg FROM facturacion_liquidaciondetalle liq inner join facturacion_suministros sum on (sum.id = liq.cums_id)  where liquidacion_id= '  + "'" +  str(liquidacionId) + "'" + ' order by consecutivo'

    print(comando)

    cur.execute(comando)

    liquidacionDetalle = []

    for id, consecutivo, fecha, cantidad, valorUnitario, valorTotal, cirugia, fechaCrea, observaciones, estadoRegistro, examen_id, cums_id, nombreExamen, liquidacion_id, tipoHonorario_id, tipoRegistro, estadoReg in cur.fetchall():
        liquidacionDetalle.append(
            {"model": "liquidacionDetalle.liquidacionDetalle", "pk": id, "fields":
                {"id": id, "consecutivo": consecutivo,
                 "fecha": fecha,
                 "cantidad": cantidad,
                 "valorUnitario": valorUnitario, "valorTotal": valorTotal,
                 "cirugia": cirugia,
                 #"fechaCrea": fechaCrea,
                 "observaciones": observaciones,
                 "estadoRegistro": estadoRegistro, "examen_id": examen_id,
                 "cums_id": cums_id, "nombreExamen": nombreExamen,
                 "liquidacion_id": liquidacion_id, "tipoHonorario_id": tipoHonorario_id,
                 "tipoRegistro": tipoRegistro, "estadoReg":estadoReg}})

    miConexionx.close()
    print(liquidacionDetalle)

    # Cierro Conexion

    #Ojo probar estop
    #serializedPrueba = pickle.dumps(liquidacionDetalle)
    serialized1 = json.dumps(liquidacionDetalle, default=decimal_serializer)
    #serialized1 = json.dumps(liquidacionDetalle, default=serialize_datetime)

    return HttpResponse(serialized1, content_type='application/json')


def PostConsultaLiquidacionDetalle(request):
    print ("Entre PostConsultaLiquidacionDetalle ")
    post_id =  request.POST["post_id"]

    # Combo Cups

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT c.id id,c.nombre ||' + "'" + str(' ') + "'" +  '||c."codigoCups" nombre FROM clinico_examenes c order by c.nombre'

    curt.execute(comando)
    print(comando)

    cups = []

    cups.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
        cups.append({'id': id,  'nombre': nombre})

    miConexiont.close()
    print(cups)


    # Fin combo Cups


    # Combo Suministros

    # iConexiont = MySQLdb.connect(host='CMKSISTEPC07', user='sa', passwd='75AAbb??', db='vulnerable')
    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()


    comando = 'SELECT c.id id, c.nombre nombre FROM facturacion_suministros c order by c.nombre'

    curt.execute(comando)
    print(comando)

    suministros = []

    suministros.append({'id': '', 'nombre': ''})

    for id,  nombre in curt.fetchall():
        suministros.append({'id': id,  'nombre': nombre})

    miConexiont.close()
    print(suministros)

    # Fin combo suministros

    # Aqui RUTINA Leer el registro liquidacionDetalle


    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    cur = miConexionx.cursor()

    comando = 'select liq.id id,consecutivo ,  cast(date(fecha)||\' \'||to_char(fecha, \'HH:MI:SS\') as text) fecha  ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia ,  cast(date("fechaCrea")||\' \'||to_char("fechaCrea", \'HH:MI:SS\') as text)  fechaCrea , liq.observaciones ,  "estadoRegistro" ,  "examen_id" ,  cums_id , exa.nombre  nombreExamen  ,  liquidacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro"  FROM facturacion_liquidaciondetalle liq left join clinico_examenes exa on (exa.id = liq."examen_id")  where liq.liquidacion_id= ' + str(post_id)  +  ' UNION select liq.id id,consecutivo , cast(date(fecha)||\' \'||to_char(fecha, \'HH:MI:SS\') as text) fecha  ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia ,  cast(date("fechaCrea")||\' \'||to_char("fechaCrea", \'HH:MI:SS\') as text)  fechaCrea , liq.observaciones ,  "estadoRegistro" ,  "examen_id" ,  cums_id , sum.nombre  nombreExamen  ,  liquidacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro"  FROM facturacion_liquidaciondetalle liq left join facturacion_suministros sum on (sum.id = liq.cums_id)  where liq.id= '  + str(post_id)

    print(comando)

    cur.execute(comando)

    liquidacionDetalleU = []

    for id, consecutivo, fecha, cantidad, valorUnitario, valorTotal, cirugia, fechaCrea, observaciones, estadoRegistro, examen_id, cums_id, nombreExamen, liquidacion_id, tipoHonorario_id, tipoRegistro in cur.fetchall():
        liquidacionDetalleU.append(
              {"id": id, "consecutivo": consecutivo,
                 #"fecha": fecha,
                 "cantidad": cantidad,
                 "valorUnitario": valorUnitario, "valorTotal": valorTotal,
                 "cirugia": cirugia,
                 #"fechaCrea": fechaCrea,
                 "observaciones": observaciones,
                 "estadoRegistro": estadoRegistro, "examen_id": examen_id,
                 "cums_id": cums_id, "nombreExamen": nombreExamen,
                 "liquidacion_id": liquidacion_id, "tipoHonorario_id": tipoHonorario_id,
                 "tipoRegistro": tipoRegistro, "cups": cups, "suministros":suministros})

    miConexionx.close()
    print(liquidacionDetalleU)

    # Cierro Conexion
    #

    return JsonResponse({'pk':liquidacionDetalleU[0]['id'], 'id':liquidacionDetalleU[0]['id'], 'consecutivo':liquidacionDetalleU[0]['consecutivo'],'cantidad':liquidacionDetalleU[0]['cantidad'],
                             'valorUnitario':liquidacionDetalleU[0]['valorUnitario'],  'valorTotal': liquidacionDetalleU[0]['valorTotal'],
                             'cirugia': liquidacionDetalleU[0]['cirugia'],
                             'observaciones': liquidacionDetalleU[0]['observaciones'],
                             'estadoRegistro': liquidacionDetalleU[0]['estadoRegistro'],
                             'examen_id': liquidacionDetalleU[0]['examen_id'],
                             'cums_id': liquidacionDetalleU[0]['cums_id'],
                             'liquidacion_id': liquidacionDetalleU[0]['liquidacion_id'],
                             'tipoHonorario_id': liquidacionDetalleU[0]['tipoHonorario_id'],
                             'tipoRegistro': liquidacionDetalleU[0]['tipoRegistro'],
                             'Cups': cups, 'Suministros': suministros
                                                        })


    #serialized1 = json.dumps(liquidacionDetalleU, default=decimal_serializer)
    #serialized1 = json.dumps(liquidacionDetalleU, default=serialize_datetime)


def GuardaAbonosFacturacion(request):

    print ("Entre GuardaAbonosFacturacion" )

    liquidacionId = request.POST['liquidacionId2']
    print("liquidacionId =", liquidacionId)
    #sede = request.POST['sede']
    tipoPago = request.POST['tipoPago']
    print ("tipoPago =", tipoPago)

    formaPago = request.POST['formaPago']
    print ("formaPago =", formaPago)
    valor = request.POST['valorAbono']
    descripcion = request.POST['descripcionAbono']
    print ("liquidacionId  = ", liquidacionId )
    # print("sede = ", sede)

    fechaRegistro = datetime.datetime.now()

    registroId = Liquidacion.objects.get(id=liquidacionId)
    print  ("registroId documento =" , registroId.documento_id)
    print  ("registroId tipoDoc =" , registroId.tipoDoc_id)
    print  ("registroId consec =" , registroId.consecAdmision)

    ## falta usuarioRegistro_id

    miConexion3 = None
    try:

            miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",  password="123456")
            cur3 = miConexion3.cursor()
            comando = 'insert into cartera_Pagos ("fecha", "tipoDoc_id" , documento_id, consec,  "tipoPago_id" , "formaPago_id", valor, descripcion ,"fechaRegistro","estadoReg", saldo, "totalAplicado", "valorEnCurso") values ('  + "'" + str(fechaRegistro) + "'," +  "'" + str(registroId.tipoDoc_id) + "'" + ' , ' + "'" + str(registroId.documento_id) + "'" + ', ' + "'" + str(registroId.consecAdmision) + "'" + '  , ' + "'" + str(tipoPago) + "'" + '  , ' + "'" + str(formaPago) + "'" + ', ' + "'" + str(valor) + "',"   + "'" + str(descripcion) + "','"   + str(fechaRegistro) + "'," + "'" +  str("A") +  "','" + str(valor) + "',0,0);"
            print(comando)
            cur3.execute(comando)
            miConexion3.commit()
            miConexion3.close()


            # Actualizo el total recibido

            miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                           password="123456")
            cur3 = miConexion3.cursor()
            comando = 'UPDATE  facturacion_liquidacion SET "totalRecibido" = "anticipos" +  "totalAbonos" + "totalCuotaModeradora" +  "totalCopagos"  WHERE id = ' + "'" + str(liquidacionId) + "'"

            print(comando)
            cur3.execute(comando)
            miConexion3.commit()
            miConexion3.close()

            return JsonResponse({'success': True, 'message': 'Abono Actualizado satisfactoriamente!'})

    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            miConexion3.rollback()

        print ("Voy a hacer el jsonresponde")
        return JsonResponse({'success': False, 'Mensaje': error})

    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()

def PostDeleteAbonosFacturacion(request):

    print ("Entre PostDeleteAbonosFacturacion" )

    id = request.POST["id"]
    print ("el id es = ", id)

    ## Se debe verificar antes que no haya valor aplicado en PagosFacturas

    valorSaldo = PagosFacturas.objects.get(pago_id=id, estadoReg='A')
    print ("Saldo = ", valorSaldo.saldo)

    if (valorSaldo.saldo > 0):

        return JsonResponse({'success': False, 'message': 'No se puede anular Abono con Facturas relacionadas!'})

    miConexion3 = None
    try:



        miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",  password="123456")
        cur3 = miConexion3.cursor()

        comando = 'UPDATE cartera_Pagos SET "estadoReg" = ' + "'" + str('N') + "' WHERE id =  " + id
        print(comando)
        cur3.execute(comando)
        miConexion3.commit()
        cur3.close()
        miConexion3.close()

        return JsonResponse({'success': True, 'message': 'Abono Cancelado!'})

    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            miConexion3.rollback()

        print ("Voy a hacer el jsonresponde")
        return JsonResponse({'success': False, 'Mensaje': error})

    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()


def GuardarLiquidacionDetalle(request):

    print ("Entre GuardarLiquidacionDetalle" )

    liquidacionId = request.POST["liquidacionId"]
    cups = request.POST["cups"]
    suministros = request.POST["suministros"]
    cantidad = request.POST["cantidad"]
    valorUnitario = request.POST['valorUnitario']
    valorTotal =  float(cantidad)  * float(valorUnitario)
    observaciones = request.POST['observaciones']
    username_id = request.POST['username_id']
    print ("liquidacionId  = ", liquidacionId )
    print ("observaciones" , observaciones)
    estadoReg= 'A'

    inicialSuministros=0.0
    inicialCups=0.0

    if cups == '':
           cups="null"
           inicialSuministros =  valorTotal

    if suministros == '':
           suministros="null"
           inicialCups = valorTotal

 
    fechaRegistro = datetime.datetime.now()

    registroId = Liquidacion.objects.get(id=liquidacionId)
    print  ("registroId documento =" , registroId.documento_id)
    print  ("registroId tipoDoc =" , registroId.tipoDoc_id)
    print  ("registroId consec =" , registroId.consecAdmision)

    # Aqui RUTINA busca consecutivo de liquidacion


    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",        password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT COALESCE(max(p.consecutivo),0) + 1 cons FROM facturacion_liquidaciondetalle p WHERE liquidacion_id = ' + liquidacionId
    curt.execute(comando)

    print(comando)

    consecLiquidacion = []

    for cons in curt.fetchall():
         consecLiquidacion.append({'cons': cons})

    miConexiont.close()
    print("consecLiquidacion = ", consecLiquidacion[0])

    consecLiquidacion = consecLiquidacion[0]['cons']
    consecLiquidacion = str(consecLiquidacion)
    print ("consecLiquidacion = ", consecLiquidacion)

    consecLiquidacion = consecLiquidacion.replace("(",' ')
    consecLiquidacion = consecLiquidacion.replace(")", ' ')
    consecLiquidacion = consecLiquidacion.replace(",", ' ')

    # Fin RUTINA busca consecutivo de liquidacion

    miConexion3 = None
    try:

        miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",  password="123456")
        cur3 = miConexion3.cursor()

        comando = 'INSERT INTO facturacion_liquidaciondetalle (consecutivo,fecha, cantidad, "valorUnitario", "valorTotal",cirugia,"fechaCrea", "fechaRegistro", "estadoRegistro", "examen_id", cums_id,  "usuarioRegistro_id", liquidacion_id, "tipoRegistro", observaciones) VALUES (' + "'" +  str(consecLiquidacion)  + "','" + str(fechaRegistro) + "','" + str(cantidad) + "','"  + str(valorUnitario) + "','" + str(valorTotal)  + "','" + str('N') + "','" +  str(fechaRegistro) + "','" +  str(fechaRegistro) + "','" + str(estadoReg) + "'," + str(cups) + "," + str(suministros) +   ",'"  + str(username_id) + "'," + liquidacionId + ",'MANUAL'," + "'"  + str(observaciones) + "')"
        print(comando)
        cur3.execute(comando)

        # Falta la RUTINA que actualica los cabezotes de la liquidacion

        totalSuministros = LiquidacionDetalle.objects.all().filter(liquidacion_id=liquidacionId).filter(examen_id = None).exclude(estadoRegistro='N').aggregate(totalS=Coalesce(Sum('valorTotal'), 0))
        totalSuministros = (totalSuministros['totalS']) + 0

        print("totalSuministros", totalSuministros)
        totalProcedimientos = LiquidacionDetalle.objects.all().filter(liquidacion_id=liquidacionId).filter(cums_id = None).exclude(estadoRegistro='N').aggregate(totalP=Coalesce(Sum('valorTotal'), 0))
        totalProcedimientos = (totalProcedimientos['totalP']) + 0

        print("totalProcedimientos", totalProcedimientos)

        # Si en otra pantalla estan actualizando abonos pues se veri reflejadop

        registroPago = Liquidacion.objects.get(id=liquidacionId)
        totalCopagos = registroPago.totalCopagos
        totalCuotaModeradora = registroPago.totalCuotaModeradora
        totalAnticipos = registroPago.anticipos
        totalAbonos = registroPago.totalAbonos
        #valorEnCurso = registroPago.valorEnCurso
        totalRecibido = registroPago.totalRecibido
        totalAnticipos = registroPago.anticipos
        totalLiquidacion = 0.0


        if (totalSuministros==None):
            totalSuministros=0.0
        if (totalProcedimientos==None):
            totalProcedimientos=0.0

        if (totalRecibido==None):
            totalRecibido=0.0
        if (totalLiquidacion==None):
            totalLiquidacion=0.0
        if (totalAnticipos == None):
            totalAnticipos = 0.0

        if (totalAbonos==None):
            totalAbonos=0.0

        if (totalCuotaModeradora==None):
            totalCuotaModeradora=0.0

        if (totalCopagos==None):
            totalCopagos=0.0

        totalSuministros = float(totalSuministros) + float(inicialSuministros)
        totalProcedimientos = float(totalProcedimientos) + float(inicialCups)
        totalLiquidacion = float(totalSuministros) + float(totalProcedimientos)
        print("totalSuministros FINAL", totalSuministros)
        print("totalProcedimientos FINAL", totalProcedimientos)
        print("totalLiquidacion FINAL= ", totalLiquidacion)
        print("totalRecibido FINAL= ", totalRecibido)


        valorApagar = float(totalLiquidacion) -  float(totalRecibido)


        # Rutina Guarda en cabezote los totales

        print ("Voy a grabar el cabezote")

        comando1 = 'UPDATE facturacion_liquidacion SET "totalSuministros" = ' + str(totalSuministros) + ',"totalProcedimientos" = ' + str(totalProcedimientos) + ', "totalCopagos" = ' + str(totalCopagos) + ' , "totalCuotaModeradora" = ' + str(totalCuotaModeradora) + ', anticipos = ' +  str(totalAnticipos) + ' ,"totalAbonos" = ' + str(totalAbonos) + ', "totalLiquidacion" = ' + str(totalLiquidacion) + ', "valorApagar" = ' + str(valorApagar) +  ', "totalRecibido" = ' + str(totalRecibido) + ' WHERE id =' + str(liquidacionId)
        cur3.execute(comando1)
        miConexion3.commit()
        cur3.close()
        miConexion3.close()

        return JsonResponse({'success': True, 'message': 'Registro Guardado satisfactoriamente!'})

    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            miConexion3.rollback()

        print ("Voy a hacer el jsonresponde")
        return JsonResponse({'success': False, 'Mensaje': error})

    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()


    ## Fin rutina actualiza cabezotes

def PostDeleteLiquidacionDetalle(request):

    print ("Entre PostDeleteLiquidacionDetalle" )

    id = request.POST["id"]
    print ("el id es = ", id)
    liquidacionId = id
    #post = LiquidacionDetalle.objects.get(id=id)
    #post.delete()

    miConexion3 = None
    try:

        miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",  password="123456")
        cur3 = miConexion3.cursor()

        comando = 'UPDATE facturacion_liquidaciondetalle SET "estadoRegistro" = ' + "'" + str('N') + "' WHERE id =  " + id
        print(comando)
        cur3.execute(comando)


    # Ops falta rutina actualiza TOTALES
    # Falta la RUTINA que actualica los cabezotes de la liquidacion

        totalSuministros = LiquidacionDetalle.objects.all().filter(liquidacion_id=liquidacionId).filter(examen_id = None).exclude(estadoRegistro='N').aggregate(totalS=Coalesce(Sum('valorTotal'), 0))
        totalSuministros = (totalSuministros['totalS']) + 0
        print("totalSuministros", totalSuministros)
        totalProcedimientos = LiquidacionDetalle.objects.all().filter(liquidacion_id=liquidacionId).filter(cums_id = None).exclude(estadoRegistro='N').aggregate(totalP=Coalesce(Sum('valorTotal'), 0))
        totalProcedimientos = (totalProcedimientos['totalP']) + 0
        print("totalProcedimientos", totalProcedimientos)

        # Si en otra pantalla estan actualizando abonos pues se veri reflejadop
        antesDe = LiquidacionDetalle.objects.get(id=liquidacionId)
        luegoLiquidacionId = antesDe.liquidacion_id
        registroPago = Liquidacion.objects.get(id=luegoLiquidacionId)
        totalCopagos = registroPago.totalCopagos
        totalCuotaModeradora = registroPago.totalCuotaModeradora
        totalAnticipos = registroPago.anticipos
        totalAbonos = registroPago.totalAbonos
        #valorEnCurso = registroPago.valorEnCurso
        totalRecibido = registroPago.totalRecibido
        totalAnticipos = registroPago.anticipos
        totalLiquidacion = totalSuministros + totalProcedimientos

        if totalRecibido == None:
            totalRecibido=0

        print ("totalRecibido = ",totalRecibido )
        print("totalLiquidacion = ",totalLiquidacion )

        valorApagar = totalLiquidacion -  totalRecibido


        # Rutina Guarda en cabezote los totales

        print ("Voy a grabar el cabezote")

        comando1 = 'UPDATE facturacion_liquidacion SET "totalSuministros" = ' + str(totalSuministros) + ',"totalProcedimientos" = ' + str(totalProcedimientos) + ', "totalCopagos" = ' + str(totalCopagos) + ' , "totalCuotaModeradora" = ' + str(totalCuotaModeradora) + ', anticipos = ' +  str(totalAnticipos) + ' ,"totalAbonos" = ' + str(totalAbonos) + ', "totalLiquidacion" = ' + str(totalLiquidacion) + ', "valorApagar" = ' + str(valorApagar) +  ', "totalRecibido" = ' + str(totalRecibido) +  ' WHERE id =' + str(liquidacionId)
        cur3.execute(comando1)
        miConexion3.commit()
        cur3.close()
        miConexion3.close()

    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            miConexion3.rollback()

        print ("Voy a hacer el jsonresponde")
        return JsonResponse({'success': False, 'Mensaje': error})

    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()


    ## Fin rutina actualiza cabezotes

    return JsonResponse({'success': True, 'message': 'Registro de Liquidacion Anulado!'})


def EditarGuardarLiquidacionDetalle(request):

    print ("Entre EditarGuardarLiquidacionDetalle" )

    liquidacionDetalleId = request.POST['liquidacionDetalleId']

    print ("liquidacionDetalleId =", liquidacionDetalleId)

    cups = request.POST["ldcups"]
    suministros = request.POST["ldsuministros"]
    cantidad = request.POST['ldcantidad']
    valorUnitario = request.POST['ldvalorUnitario']
    valorTotal = request.POST['ldvalorTotal']
    observaciones = request.POST['ldobservaciones']
    username_id = request.POST['username_id2']
    print ("liquidacionDetalleId  = ", liquidacionDetalleId )
    tipoRegistro = request.POST['ldtipoRegistro']
    print ("tipoRegistro  = ", tipoRegistro )
    estadoReg='A'

    if cups == '':
           cups="null"

    if suministros == '':
           suministros="null"


    fechaRegistro = datetime.datetime.now()

    registroId = LiquidacionDetalle.objects.get(id=liquidacionDetalleId)
    print  ("liquiacion_id =" , registroId.liquidacion_id)

    miConexion3 = None
    try:


        miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",  password="123456")
        cur3 = miConexion3.cursor()
        #comando = 'insert into facturacion_liquidacionDetalle ("fecha", "tipoDoc_id" , documento_id, consec,  "tipoPago_id" , "formaPago_id", valor, descripcion ,"fechaRegistro","estadoReg") values ('  + "'" + str(fechaRegistro) + "'," +  "'" + str(registroId.tipoDoc_id) + "'" + ' , ' + "'" + str(registroId.documento_id) + "'" + ', ' + "'" + str(registroId.consec) + "'" + '  , ' + "'" + str(tipoPago) + "'" + '  , ' + "'" + str(formaPago) + "'" + ', ' + "'" + str(valor) + "',"   + "'" + str(descripcion) + "','"   + str(fechaRegistro) + "'," + "'" +  str("A") + "');"
        comando = 'UPDATE facturacion_liquidaciondetalle SET fecha = ' + "'" + str(fechaRegistro) + "', observaciones = " + "'" +  str(observaciones) + "', cantidad = "  + str(cantidad) +  ',"valorUnitario" = ' + str(valorUnitario) + ', "valorTotal" = '  +      str(valorTotal) + ',"fechaCrea" = '  + "'" + str(fechaRegistro) + "'" + ',"estadoRegistro" = ' + "'" + str(estadoReg) + "'" + ',"examen_id" = ' + str(cups) +  ', cums_id = ' + str(suministros) +  ', "usuarioRegistro_id" = ' + "'" + str(username_id) + "', liquidacion_id = " + str(registroId.liquidacion_id) + ', "tipoRegistro" = ' + "'" + str(tipoRegistro) + "' WHERE id = " + str(liquidacionDetalleId)
        print(comando)
        cur3.execute(comando)

        # Falta la RUTINA que actualica los cabezotes de la liquidacion

        totalSuministros = LiquidacionDetalle.objects.all().filter(liquidacion_id=registroId.liquidacion_id).filter(examen_id = None).exclude(estadoRegistro='N').aggregate(totalS=Coalesce(Sum('valorTotal'), 0))
        totalSuministros = (totalSuministros['totalS']) + 0
        print("totalSuministros", totalSuministros)
        totalProcedimientos = LiquidacionDetalle.objects.all().filter(liquidacion_id=registroId.liquidacion_id).filter(cums_id = None).exclude(estadoRegistro='N').aggregate(totalP=Coalesce(Sum('valorTotal'), 0))
        totalProcedimientos = (totalProcedimientos['totalP']) + 0
        print("totalProcedimientos", totalProcedimientos)
        registroPago = Liquidacion.objects.get(id=registroId.liquidacion_id)
        totalCopagos = registroPago.totalCopagos
        totalCuotaModeradora = registroPago.totalCuotaModeradora
        totalAnticipos = registroPago.anticipos
        totalAbonos = registroPago.totalAbonos
        #valorEnCurso = registroPago.valorEnCurso
        totalRecibido = registroPago.totalRecibido
        if totalRecibido == None:
               totalRecibido=0

        print ("totalRecibido", totalRecibido )
        totalAnticipos = registroPago.anticipos
        totalLiquidacion = totalSuministros + totalProcedimientos
        print("totalLiquidacion", totalLiquidacion)
        valorApagar = totalLiquidacion -  totalRecibido
        print("valorApagar", valorApagar)


        # Rutina Guarda en cabezote los totales

        print ("Voy a grabar el cabezote")

        comando1 = 'UPDATE facturacion_liquidacion SET "totalSuministros" = ' + str(totalSuministros) + ',"totalProcedimientos" = ' + str(totalProcedimientos) + ', "totalCopagos" = ' + str(totalCopagos) + ' , "totalCuotaModeradora" = ' + str(totalCuotaModeradora) + ', anticipos = ' +  str(totalAnticipos) + ' ,"totalAbonos" = ' + str(totalAbonos) + ', "totalLiquidacion" = ' + str(totalLiquidacion) + ', "valorApagar" = ' + str(valorApagar) +  ', "totalRecibido" = ' + str(totalRecibido) +  ' WHERE id =' + str(registroId.liquidacion_id)
        cur3.execute(comando1)
        miConexion3.commit()
        cur3.close()
        miConexion3.close()

        return JsonResponse({'success': True, 'message': 'Registro Actualizado satisfactoriamente!'})

    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            miConexion3.rollback()

        print ("Voy a hacer el jsonresponde")
        return JsonResponse({'success': False, 'Mensaje': error})

    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()

def load_dataAbonosFacturacion(request, data):
    print("Entre  load_dataAbonosFacturacion")

    context = {}
    d = json.loads(data)
    
    tipoIngreso = d['tipoIngreso']
    liquidacion = d['liquidacionId']
    liquidacionId = Liquidacion.objects.get(id=liquidacion)

    if tipoIngreso == 'INGRESO':

       print("ingresoIdPilas:", liquidacionId)
    else:

       print("triageId Pilos:", liquidacionId)

    sede = d['sede']

    print("sede:", sede)

    convenio = liquidacionId.convenio_id

    if convenio == '':
           convenio="null"

    # print("data = ", request.GET('data'))

    abonos  = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    if tipoIngreso == 'INGRESO':
      detalle = 'SELECT pag.id id , i."tipoDoc_id" tipoDoc , i.documento_id documentoId ,u.documento documento,u.nombre nombre,i."consecAdmision" consec , tipdoc.nombre nombreDocumento , cast(date(pag.fecha) as text)  fecha, pag."tipoPago_id" tipoPago , pag."formaPago_id" formaPago, pag.valor valor, pag.descripcion descripcion ,tip.nombre tipoPagoNombre,forma.nombre formaPagoNombre, pag."totalAplicado" totalAplicado, pag.saldo saldo , pag."estadoReg" estadoReg, pag."valorEnCurso"  valorEnCurso FROM facturacion_liquidacion i, cartera_pagos pag ,usuarios_usuarios u ,usuarios_tiposdocumento tipdoc, cartera_tiposPagos tip, cartera_formasPagos forma WHERE i.id = ' + "'" + str(liquidacionId.id) + "'" + ' and i.documento_id = u.id and i."tipoDoc_id" = pag."tipoDoc_id" and i.documento_id  = pag.documento_id and  i."consecAdmision" = pag.consec AND tipdoc.id = i."tipoDoc_id" and pag."tipoPago_id" = tip.id and pag."formaPago_id" = forma.id  and pag.convenio_id = i.convenio_id and i.convenio_id = ' + str(convenio)  + ' ORDER BY pag.fecha desc'
    else:
      detalle = 'SELECT pag.id id , t."tipoDoc_id" tipoDoc , t.documento_id documentoId ,u.documento documento,u.nombre nombre,t."consecAdmision" consec , tipdoc.nombre nombreDocumento , cast(date(pag.fecha) as text)  fecha, pag."tipoPago_id" tipoPago , pag."formaPago_id" formaPago, pag.valor valor, pag.descripcion descripcion ,tip.nombre tipoPagoNombre,forma.nombre formaPagoNombre, pag."totalAplicado" totalAplicado, pag.saldo saldo , pag."estadoReg" estadoReg , pag."valorEnCurso"  valorEnCurso FROM facturacion_liquidacion t, cartera_pagos pag ,usuarios_usuarios u ,usuarios_tiposdocumento tipdoc, cartera_tiposPagos tip, cartera_formasPagos forma WHERE t.id = ' + "'" + str(liquidacionId.id) + "'" + ' and t.documento_id = u.id and t."tipoDoc_id" = pag."tipoDoc_id" and t.documento_id  = pag.documento_id and  t."consecAdmision" = pag.consec AND tipdoc.id = t."tipoDoc_id" and pag."tipoPago_id" = tip.id and pag."formaPago_id" = forma.id and pag.convenio_id = t.convenio_id and t.convenio_id = '  + str(convenio)  + ' ORDER BY pag.fecha desc'

    print(detalle)

    curx.execute(detalle)

    for id, tipoDoc, documentoId, documento, nombre, consec, nombreDocumento , fecha, tipoPago, formaPago, valor, descripcion, tipoPagoNombre,formaPagoNombre,totalAplicado, saldo, estadoReg , valorEnCurso in curx.fetchall():
        abonos.append(
            {"model": "cartera_pagos.cartera_pagos", "pk": id, "fields":
                {'id': id, 'tipoDoc': tipoDoc, 'documentoId': documentoId, 'nombre':nombre,'consec':consec,  'nombreDocumento': nombreDocumento,
                 'fecha': fecha, 'tipoPago': tipoPago, 'formaPago': formaPago, 'valor':valor, 'descripcion':descripcion,'tipoPagoNombre': tipoPagoNombre, 'formaPagoNombre': formaPagoNombre, 'totalAplicado':totalAplicado, 'saldo':saldo , 'estadoReg': estadoReg, 'valorEnCurso': valorEnCurso}})

    miConexionx.close()
    print(abonos)
    context['Abonos '] = abonos

    serialized2 = json.dumps(abonos,  default=decimal_serializer)

    print("Envio = ", serialized2)

    return HttpResponse(serialized2, content_type='application/json')


def FacturarCuenta(request):

    print ("Entre FacturarCuenta" )

    liquidacionId = request.POST["liquidacionId"]
    print ("liquidacionId = ", liquidacionId)
    username_id = request.POST["username_id"]
    sede = request.POST["sede"]
    print("sede = ", sede)
    tipoFactura = request.POST["tipoFactura"]

    usuarioId = Liquidacion.objects.get(id=liquidacionId)
    print ("Usuario", usuarioId.documento_id)
    print ("TipoDoc", usuarioId.tipoDoc_id)
    print ("Consec", usuarioId.consecAdmision)

    now = datetime.datetime.now()
    print("NOW  = ", now)
    fechaRegistro = now
	
    liquidacionDatos = Liquidacion.objects.get(id=liquidacionId)
    print("convenio de la liquidacion = " , liquidacionDatos.convenio_id);

    if (liquidacionDatos.convenio_id =='' and tipoFactura == 'FACTURA'):
            print("ENTRE convenio de la liquidacion = " + liquidacionDatos.convenio_id)
            return JsonResponse({'success': True, 'message': 'Favor ingresar Convenio a Facturar !', 'Factura' : 0 })


    servicioAmb = Servicios.objects.get(nombre='AMBULATORIO')
    #ingresoId = Ingresos.objects.all().filter(tipoDoc_id=usuarioId.documento_id).filter(documento_id=usuarioId.tipoDoc_id).filter(consec=usuarioId.consecAdmision)
    ingresoId = Ingresos.objects.get(tipoDoc_id=usuarioId.tipoDoc_id , documento_id=usuarioId.documento_id ,consec=usuarioId.consecAdmision)
    print ("ingresoId = ", ingresoId.id)

    if (ingresoId.salidaClinica=='N' and ingresoId.serviciosIng_id != servicioAmb.id  ):
	    return JsonResponse({'success': True, 'message': 'Paciente NO tiene Salida Clinica. Consultar medico tratante !', 'Factura' : 0 })

    # RUTINA ACUMULAR ABONOS RECIBIDOS

    # FIN RUTINA

    #OJO SI SE REFACTURA NO REALIZA LOS SIGTES 3 QUERYS Y continua con los de insercion de cabezote/detalle en facturacion_facturacion

    ## RUTINA ACTUALIZA DX, SERV , MEDIODE AMBULATORIOS


    miConexion3 = None
    try:
        miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",   password="123456")
        cur3 = miConexion3.cursor()

        if (ingresoId.serviciosIng_id != servicioAmb.id and tipoFactura == 'FACTURA') :


               print ("Acumulo Ambulatorio")
               comando = 'UPDATE admisiones_ingresos SET  "dxSalida_id"= "dxActual_id", "medicoSalida_id" = "medicoActual_id",  "serviciosSalida_id" = "serviciosActual_id"  WHERE id =  ' + "'" +  str(ingresoId.id) + "'"
               print(comando)
               cur3.execute(comando)

               ## AQUI RUTINA HISATORICO CAMA-DEPENDENCIA

               comando1 = 'INSERT INTO sitios_historialdependencias (consec,"fechaLiberacion","fechaRegistro","estadoReg", dependencias_id,documento_id,"tipoDoc_id","usuarioRegistro_id",disponibilidad)  SELECT consec,' + "'" + str(fechaRegistro) + "'," + "'" + str(fechaRegistro) + "'," + "'" + str('A') + "'" + ", id" + ",'" + str(ingresoId.documento_id) + "'," + "'" + str(ingresoId.tipoDoc_id) + "'," + "'" + str(username_id) + "'," + "'" + str('L') + "'" +  ' from sitios_dependencias where "tipoDoc_id" = ' + "'" + str(ingresoId.tipoDoc_id) + "' AND documento_id = "  + "'" + str(ingresoId.documento_id) + "' AND consec = " + "'" + str(ingresoId.consec) + "'"
               print(comando1)
               cur3.execute(comando1)


               ## FIN HISTORICO CAMAA-DEPENDENCIA


               ## AQUI RUTINA DESOCUPAR CAMA-DEPENDENCIA

               comando2 = 'UPDATE sitios_dependencias SET disponibilidad = ' + "'" + str('L') + "'," + ' "tipoDoc_id" = null , documento_id = null,  consec= null, "fechaLiberacion" = ' + "'" + str(fechaRegistro) + "'"  + ' WHERE "tipoDoc_id" = ' + "'" + str(ingresoId.tipoDoc_id) + "'" + ' AND documento_id = ' + "'" + str(ingresoId.documento_id) + "'" + ' AND consec = ' + str(ingresoId.consec)
               print(comando2)
               cur3.execute(comando2)



               ## FIN DESOCUPAR CAMA-DEPENDENCIA

            ## DESDE AQUI S AMBOS tipoFactura: FACTURA/REFACTURA

            # PRIMERO EL CABEZOTE

        comando3 = 'INSERT INTO facturacion_facturacion ("sedesClinica_id", documento_id, "consecAdmision", "fechaFactura", "totalCopagos", "totalCuotaModeradora","totalProcedimientos",   "totalSuministros", "totalFactura", "valorApagar", anulado, anticipos, "fechaRegistro", "estadoReg", "fechaAnulacion", observaciones, "fechaCorte",convenio_id, "tipoDoc_id","usuarioAnula_id","usuarioRegistro_id") SELECT ' "'" + str(sede) + "'" + ', documento_id, "consecAdmision", ' + "'" + str(fechaRegistro) + "'" + ' , "totalCopagos", "totalCuotaModeradora", "totalProcedimientos",  "totalSuministros", "totalLiquidacion", "valorApagar", anulado, anticipos, ' + "'" + str(fechaRegistro) + "'" + ' ,  ' + "'" + str('A') + "'" + ' , "fechaAnulacion", observaciones, "fechaCorte",convenio_id, "tipoDoc_id","usuarioAnula_id", ' + "'" + str(username_id) + "'" + ' FROM facturacion_liquidacion WHERE id =  ' + liquidacionId + ' RETURNING id  '

        print(comando3)
        cur3.execute(comando3)
        facturacionId = cur3.fetchone()[0]

        # AQUI CONSEGUIR EL ID DE LA FACTURA RECIEN CREADA
        # LO MEJOR ES conseguir el id en el mismo insert


        print ("facturacionId = ", facturacionId)

        ## COLOCAR EN LA TABLA INGRESOS , LA FECHA DE EGRESO Y EL NUMERO DE LA FACTURA GENERADO SI SE FACTURA

        if (tipoFactura == 'FACTURA'):

                comando4 = 'UPDATE admisiones_ingresos SET "fechaSalida" = ' + "'" +  str(fechaRegistro) + "'" + ', factura = ' + str(facturacionId)  +  ', "dependenciasSalida_id" = "dependenciasActual_id" ' +  ' WHERE id =' + str(ingresoId.id)
                cur3.execute(comando4)


        # AHORA EL DETALLE

        comando5 = 'INSERT INTO facturacion_facturaciondetalle ("consecutivoFactura", fecha, cantidad, "valorUnitario", "valorTotal",  cirugia, "fechaCrea", "fechaModifica", observaciones, "fechaRegistro", "estadoRegistro", "examen_id", cums_id, "usuarioModifica_id", "usuarioRegistro_id", facturacion_id, "tipoHonorario_id", "tipoRegistro") SELECT  consecutivo, fecha, cantidad, "valorUnitario", "valorTotal",  cirUgia, "fechaCrea", "fechaModifica", observaciones, "fechaRegistro", "estadoRegistro", "examen_id", cums_id, "usuarioModifica_id", "usuarioRegistro_id", ' + str(facturacionId) + ', "tipoHonorario_id", "tipoRegistro" FROM facturacion_liquidaciondetalle WHERE liquidacion_id =  ' + liquidacionId
        print(comando5)
        cur3.execute(comando5)

        #AQUI ACTUALIZAMOS LOS PAGOS DEL PACIENTE


        if (tipoFactura == 'FACTURA'):


                comando6 = 'INSERT INTO cartera_pagosFacturas ("valorAplicado", "fechaRegistro","estadoReg", "facturaAplicada_id",pago_id) SELECT "valorEnCurso", ' + "'" + str(fechaRegistro) + "','A'," + str(facturacionId) + ', id FROM cartera_pagos WHERE documento_id = ' + "'" + str(usuarioId.documento_id) + "'" + ' AND "tipoDoc_id" = ' + "'" + str(usuarioId.tipoDoc_id) + "'" + ' AND consec = ' + "'" + str(usuarioId.consecAdmision) + "'"

                print(comando6)
                cur3.execute(comando6)

                comando7 = 'UPDATE cartera_pagos SET "totalAplicado" =  "totalAplicado" + "valorEnCurso", saldo  = valor - "totalAplicado", "valorEnCurso" = 0 ' + ' WHERE documento_id = ' + "'" + str(usuarioId.documento_id) + "'" + ' AND "tipoDoc_id" = ' + "'" + str(usuarioId.tipoDoc_id) + "'" + ' AND consec = ' + "'" + str(usuarioId.consecAdmision) + "'"

                print(comando7)
                cur3.execute(comando7)

        ## AQUI BORRAMOS EL DETALLE DE LA LIQUIDACION


        comando8 = 'DELETE FROM facturacion_liquidaciondetalle WHERE liquidacion_id =  ' + liquidacionId
        print(comando8)
        cur3.execute(comando8)


        ## AQUI BORRAMOS EL CABEZOTE DE LA LIQUIDACION


        comando9 = 'DElETE FROM facturacion_liquidacion WHERE id =  ' + liquidacionId

        print(comando9)
        cur3.execute(comando9)
        miConexion3.commit()
        cur3.close()
        miConexion3.close()

        return JsonResponse({'success': True, 'message': 'Factura Elaborada!', 'Factura' : facturacionId})

    except psycopg2.DatabaseError as error:

            print("Entre por rollback", error)
            if miConexion3:
                print("Entro ha hacer el Rollback")
                miConexion3.rollback()

            print("Voy a hacer el jsonresponde")
            return JsonResponse({'success': False, 'Mensaje': error})

    finally:
            if miConexion3:
                cur3.close()
                miConexion3.close()


def LeerTotales(request):

    print ("Entre Leer Totales" )
    liquidacionId = request.POST["liquidacionId"]
    print ("liquidacionId = ", liquidacionId)

    liquidacionId1 = Liquidacion.objects.get(id=liquidacionId)

    totalSuministros = LiquidacionDetalle.objects.all().filter(liquidacion_id=liquidacionId).filter(examen_id = None).exclude(estadoRegistro='N').aggregate(totalS=Coalesce(Sum('valorTotal'), 0))
    totalSuministros = (totalSuministros['totalS']) + 0
    print("totalSuministros", totalSuministros)
    totalProcedimientos = LiquidacionDetalle.objects.all().filter(liquidacion_id=liquidacionId).filter(cums_id = None).exclude(estadoRegistro='N').aggregate(totalP=Coalesce(Sum('valorTotal'), 0))
    totalProcedimientos = (totalProcedimientos['totalP']) + 0
    print("totalProcedimientos", totalProcedimientos)
    registroPago = Liquidacion.objects.get(id=liquidacionId)
    totalCopagos = registroPago.totalCopagos
    totalCuotaModeradora = registroPago.totalCuotaModeradora
    totalAnticipos = registroPago.anticipos
    totalAbonos = registroPago.totalAbonos
    totalRecibido = registroPago.totalRecibido
    totalAnticipos = registroPago.anticipos
    valorApagar = registroPago.valorApagar
    totalLiquidacion = registroPago.totalLiquidacion


    return JsonResponse({'totalSuministros':totalSuministros,'totalProcedimientos':totalProcedimientos,'totalCopagos':totalCopagos,
			     'totalCuotaModeradora':totalCuotaModeradora,'totalAnticipos':totalAnticipos, 'totalAbonos':totalAbonos, 'totalRecibido':totalRecibido, 'totalLiquidacion':totalLiquidacion, 'totalAPagar':valorApagar})



# Create your views here.
def load_dataFacturacion(request, data):
    print ("Entre load_data Facturacion")
    context = {}
    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']

    nombreSede = d['nombreSede']
    print ("sede:", sede)
    print ("username:", username)
    print ("username_id:", username_id)

    desdeFecha = d['desdeFecha']
    hastaFecha = d['hastaFecha']
    desdeFactura = d['desdeFactura']
    hastaFactura = d['hastaFactura']
    bandera = d['bandera']

    # Combo Indicadores

    # Fin combo Indicadores

    facturacion = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",     password="123456")
    curx = miConexionx.cursor()

    print ("bandera = " , bandera)
   
    if bandera == "Por Fecha":

       print ("Entre por Fecha")
       detalle = 'SELECT facturas.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" fechaIngreso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida, dep.nombre camaNombreSalida , diag.nombre dxSalida , conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica, facturas."estadoReg" estadoReg FROM admisiones_ingresos i INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id") INNER JOIN sitios_dependencias dep ON (dep."sedesClinica_id" = i."sedesClinica_id" AND dep."serviciosSedes_id" = sd.id AND dep.id = i."dependenciasSalida_id")  INNER JOIN sitios_dependenciastipo deptip  ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" =  i."tipoDoc_id" AND u.id = i."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") INNER JOIN clinico_servicios ser  ON ( ser.id  = i."serviciosSalida_id")  INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxSalida_id") INNER JOIN facturacion_facturacion facturas ON (facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and facturas."consecAdmision" = i.consec ) LEFT JOIN contratacion_convenios conv  ON (conv.id = facturas.convenio_id ) WHERE i."fechaSalida" between ' + "'" + str(desdeFecha) + "'" + '  and ' + "'" + str(hastaFecha) + "'" + ' AND i."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' AND i."fechaSalida" is not null '

    else:

        print ("Entre por Factura")
        detalle = 'SELECT facturas.id id , facturas."fechaFactura" fechaFactura, tp.nombre tipoDoc,u.documento documento,u.nombre nombre,i.consec consec , i."fechaIngreso" fechaIngreso , i."fechaSalida" fechaSalida, ser.nombre servicioNombreSalida, dep.nombre camaNombreSalida , diag.nombre dxSalida , conv.nombre convenio, conv.id convenioId , i."salidaClinica" salidaClinica, facturas."estadoReg" estadoReg FROM admisiones_ingresos i INNER JOIN sitios_serviciosSedes sd ON (sd."sedesClinica_id" = i."sedesClinica_id") INNER JOIN sitios_dependencias dep ON (dep."sedesClinica_id" = i."sedesClinica_id" AND dep."serviciosSedes_id" = sd.id AND dep.id = i."dependenciasSalida_id")  INNER JOIN sitios_dependenciastipo deptip  ON (deptip.id = dep."dependenciasTipo_id") INNER JOIN usuarios_usuarios u ON (u."tipoDoc_id" =  i."tipoDoc_id" AND u.id = i."documento_id" ) INNER JOIN usuarios_tiposDocumento tp ON (tp.id = u."tipoDoc_id") INNER JOIN clinico_servicios ser  ON ( ser.id  = i."serviciosSalida_id")  INNER JOIN clinico_Diagnosticos diag ON (diag.id = i."dxSalida_id") INNER JOIN facturacion_facturacion facturas ON (facturas.documento_id = i.documento_id and facturas."tipoDoc_id" = i."tipoDoc_id" and facturas."consecAdmision" = i.consec ) LEFT JOIN contratacion_convenios conv  ON (conv.id = facturas.convenio_id ) WHERE facturas.id between ' + "'" + str(desdeFactura) + "'" + '  and ' + "'" + str(hastaFactura) + "'" + ' AND i."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' i."fechaSalida" is not null '

    print(detalle)

    curx.execute(detalle)

    for id ,fechaFactura, tipoDoc, documento, nombre, consec , fechaIngreso , fechaSalida, servicioNombreSalida, camaNombreSalida , dxSalida , convenio, convenioId , salidaClinica , estadoReg in curx.fetchall():
        facturacion.append(
		{"model":"facturacion.facturacion","pk":id,"fields":
			{'id':id, 'fechaFactura':fechaFactura, 'tipoDoc': tipoDoc, 'documento': documento, 'nombre': nombre, 'consec': consec,
                         'fechaIngreso': fechaIngreso, 'fechaSalida': fechaSalida,
                         'servicioNombreSalida': servicioNombreSalida, 'camaNombreSalida': camaNombreSalida,
                         'dxSalida': dxSalida,'convenio':convenio, 'convenioId':convenioId, 'salidaClinica':salidaClinica, 'estadoReg' : estadoReg}})

    miConexionx.close()
    print(facturacion)


    serialized1 = json.dumps(facturacion, default=serialize_datetime)

    return HttpResponse(serialized1, content_type='application/json')



def PostConsultaFacturacion(request):
    print ("Entre PostConsultaFacturacion")

    Post_id = request.POST["post_id"]
    username_id = request.POST["username_id"]

    # Abro Conexion

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",password="123456")
    cur = miConexionx.cursor()

    comando = 'select fac.id id, fac.id factura, fac."fechaFactura" fechaFactura, tip.nombre tipoDoc, documento_id documento, usu.nombre paciente, fac."consecAdmision" consecAdmision, conv.nombre nombreConvenio FROM facturacion_facturacion fac, contratacion_convenios conv, usuarios_usuarios usu, usuarios_tiposdocumento tip where fac.id = ' + "'" + str(Post_id) + "'" + '  AND  fac.convenio_id = conv.id and usu.id = fac.documento_id  and fac."tipoDoc_id" = usu."tipoDoc_id"   AND tip.id = fac."tipoDoc_id" AND fac.documento_id = usu.id  AND conv.id = fac.convenio_id '

    print(comando)

    cur.execute(comando)

    facturacion = []

    for id,factura , fechaFactura , tipoDoc, documento, paciente, consecAdmision , nombreConvenio in cur.fetchall():
            facturacion.append( {"id": id,"factura":factura, "fechaFactura" : fechaFactura, "tipoDoc":tipoDoc, "documento":documento,
                     "paciente": paciente, "consecAdmision": consecAdmision, "nombreConvenio": nombreConvenio
                                 })


    miConexionx.close()
    print(facturacion)

    # Cierro Conexion


    return JsonResponse({'pk':facturacion[0]['id'],'id':facturacion[0]['id'], 'factura':facturacion[0]['factura'],'fechaFactura':facturacion[0]['fechaFactura'],
		          'tipoDoc':facturacion[0]['tipoDoc'],'documento':facturacion[0]['documento'],'paciente':facturacion[0]['paciente'],  'consecAdmision':facturacion[0]['consecAdmision'],
                             'nombreConvenio':facturacion[0]['nombreConvenio']        })




def AnularFactura(request):
    print ("Entre AnularFactura")
    facturacionId = request.POST["facturacionId"]

    print ("el id es = ", facturacionId)

    #Que pasa con los abonos aquip
    ##Rutina liberar Abonos, es decir devolverles el saldo/Aunque la factura original quede modificada por estos abonos

    miConexion3 = None
    try:

        miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",  password="123456")
        cur3 = miConexion3.cursor()

        comando = 'UPDATE facturacion_facturacion SET "estadoReg" = ' + "'" + str('N') + "' WHERE id =  " + str(facturacionId )
        print(comando)
        cur3.execute(comando)
        miConexion3.commit()
        miConexion3.close()

    except psycopg2.DatabaseError as error:
        print("Entre por rollback", error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            miConexion3.rollback()

        print("Voy a hacer el jsonresponde")
        return JsonResponse({'success': False, 'Mensaje': error})

    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()


        return JsonResponse({'success': True, 'message': 'Factura Anulada!'})


def ReFacturar(request):

    print ("Entre ReFacturar")
    usuarioRegistro = request.POST["username_id"]

    facturacionId = request.POST["facturacionId"]
    print ("el id es = ", facturacionId)

    facturacionId2 = Facturacion.objects.get(id=facturacionId)

    now = datetime.datetime.now()
    print("NOW  = ", now)
    fechaRegistro = now

    miConexion3 = None
    try:

                miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",  password="123456")
                cur3 = miConexion3.cursor()

                comando = 'UPDATE facturacion_facturacion SET "estadoReg" = ' + "'" + str('R') + "'" + ', "usuarioAnula_id" = ' + "'" + str(usuarioRegistro) + "'" +  ', "usuarioRegistro_id" = ' + "'" + str(usuarioRegistro) + "'" +  ', "fechaRegistro" = ' + "'" + str(fechaRegistro) + "'" + ' , "fechaAnulacion" = ' + "'" + str(fechaRegistro) + "'" +  ' WHERE id =  ' + facturacionId
                print (comando)
                cur3.execute(comando)

                liquidacionU = Liquidacion.objects.all().aggregate(maximo=Coalesce(Max('id'), 0))
                liquidacionId = (liquidacionU['maximo']) + 1

                liquidacionId = str(liquidacionId)
                liquidacionId = liquidacionId.replace("(", ' ')
                liquidacionId = liquidacionId.replace(")", ' ')
                liquidacionId = liquidacionId.replace(",", ' ')
                print ("liquidacionid = ", liquidacionId)


                # Aquip hacer los INSERT A LIQUIDACION a partir de facturacion

                comando1 = 'INSERT INTO facturacion_liquidacion (id, documento_id ,  "consecAdmision" ,  fecha ,  "totalCopagos" ,  "totalCuotaModeradora" ,  "totalProcedimientos" ,  "totalSuministros" ,  "totalLiquidacion" ,  "valorApagar" ,  anulado ,  "fechaCorte" ,  anticipos ,  "detalleAnulacion" ,  "fechaAnulacion" ,  observaciones ,  "fechaRegistro" ,  "estadoRegistro" ,  convenio_id ,  "tipoDoc_id" ,  "usuarioAnula_id" , "usuarioRegistro_id" ,  "totalAbonos" ,  "totalRecibido" ) SELECT ' + "'" + str(liquidacionId) + "'," + ' documento_id ,  "consecAdmision" ,  "fechaFactura" ,  "totalCopagos" ,  "totalCuotaModeradora" ,  "totalProcedimientos" ,  "totalSuministros" ,  "totalFactura" ,  "valorApagar" ,  anulado ,  "fechaCorte" ,  anticipos ,  "detalleAnulacion" ,  "fechaAnulacion" ,  observaciones ,  "fechaRegistro" ,  "estadoReg" ,  convenio_id ,  "tipoDoc_id" ,  "usuarioAnula_id" , "usuarioRegistro_id" ,  "totalAbonos" ,  "totalRecibido"  FROM facturacion_facturacion WHERE id =  ' + facturacionId
                print(comando1)
                cur3.execute(comando1)


                # Aquip hacer los INSERT A LIQUIDACIONDETALLE a partir de facturacion detalle

                comando2 = 'INSERT INTO facturacion_liquidaciondetalle (consecutivo ,  fecha ,  cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia ,  "fechaCrea" ,  "fechaModifica" ,  observaciones ,  "fechaRegistro" ,  "estadoRegistro" ,  "examen_id" ,  cums_id ,  "usuarioModifica_id" ,  "usuarioRegistro_id" ,  liquidacion_id ,  "tipoHonorario_id" ,  "tipoRegistro" ) SELECT "consecutivoFactura" ,  fecha ,  cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia ,  "fechaCrea" ,  "fechaModifica" ,  observaciones ,  "fechaRegistro" ,  "estadoRegistro" ,  "examen_id" ,  cums_id ,  "usuarioModifica_id" ,  "usuarioRegistro_id" , ' + "'" + str(liquidacionId) + "'" + ' ,  "tipoHonorario_id" ,  "tipoRegistro"  FROM facturacion_facturaciondetalle WHERE facturacion_id =  ' + facturacionId
                print(comando2)
                cur3.execute(comando2)


               ##  Aquip hacer el INSERT a la tabla facturacion_refactura


                comando3 = 'INSERT INTO facturacion_refacturacion (documento_id,"consecAdmision" ,fecha ,  "facturaAnulada" ,  "facturaNueva" ,  "fechaRegistro" ,  "estadoRegistro" ,  "tipoDoc_id" ,  "usuarioRegistro_id" ) values (' + str(facturacionId2.documento_id) + "," + str(facturacionId2.consecAdmision) + ","  + "'" + str(fechaRegistro) + "'," + str(facturacionId2.id) + ',0,' + "'" + str(fechaRegistro) + "'," + "'" + str('A') + "'," +  "'" + str(facturacionId2.tipoDoc_id) + "','" +  str(usuarioRegistro) + "')"
                print(comando3)
                cur3.execute(comando3)

                ## Actualiza campo salidaDefinitiva = R

                ingresoId = Ingresos.object.get(tipoDoc_id=facturacionId2.tipoDoc_id  , documento_id= facturacionId2.documento_id , consec = facturacionId2.consecAdmision)

                comando4 = 'UPDATE admisiones_ingresos SET "salidaDefinitiva"= ' + "'" + str('R') + "'" + ' WHERE  id = ' + str(ingresoId.id)
                print(comando4)
                cur3.execute(comando4)
                miConexion3.commit()
                cur3.close()
                miConexion3.close()

                return JsonResponse({'success': True, 'message': 'Factura Anulada!'})

    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexion3:
            print("Entro ha hacer el Rollback")
            miConexion3.rollback()

        print ("Voy a hacer el jsonresponde")
        return JsonResponse({'success': False, 'Mensaje': error})

    finally:
        if miConexion3:
            cur3.close()
            miConexion3.close()


def GuardaApliqueAbonosFacturacion(request):

    print ("Entre ApliqueParcialAbonos" )

    liquidacionId = request.POST['liquidacionIdA']
    #tipoPago = request.POST['AtipoPago']
    #formaPago = request.POST['aformaPago']
    valor = request.POST['avalorAbono']
    valorEnCurso = request.POST['avalorEnCurso']
    saldo = request.POST['aSaldo']
    print ("liquidacionId  = ", liquidacionId )
    abonoId = request.POST["aabonoId"]
    print ("abonoId = ", abonoId)
    aformaPago = request.POST["aformaPago"]

    print("aformaPago = ", aformaPago)

    fechaRegistro = datetime.datetime.now()

    registroId = Liquidacion.objects.get(id=liquidacionId)
    print  ("registroId documento =" , registroId.documento_id)
    print  ("registroId tipoDoc =" , registroId.tipoDoc_id)
    print  ("registroId consec =" , registroId.consecAdmision)

    try:
        with transaction.atomic():

            grabo1 = Pagos.objects.filter(id=abonoId).update(valorEnCurso=valorEnCurso)


        # Aqui Crear rutina que haga la sumatoria de los valores en curso por forma de pago y luego si actualizar el valor en curso, con estas sumatorias con ORM


        # Voy a actualizar el total de Abono, o Moderadora o Anticipo


            if aformaPago == "1":
                print("Entre 1")

                sumatoriaAnticipos = Pagos.objects.filter(tipoDoc_id=registroId.tipoDoc_id, documento_id=registroId.documento_id, consec=registroId.consecAdmision,convenio_id=registroId.convenio_id, formaPago_id=aformaPago).exclude(estadoReg='N').aggregate(totalA=Coalesce(Sum('valorEnCurso'), 0))
                sumatoriaAnticipos = (sumatoriaAnticipos['totalA']) + 0
                print("sumatoriaAnticipos", sumatoriaAnticipos)
                grabo2 = Liquidacion.objects.filter(id=liquidacionId).update(anticipos=sumatoriaAnticipos)
            if aformaPago == "2":
                print("Entre 2")

                sumatoriaAbonos = Pagos.objects.filter(tipoDoc_id=registroId.tipoDoc_id, documento_id=registroId.documento_id, consec=registroId.consecAdmision,convenio_id=registroId.convenio_id,formaPago_id=aformaPago).exclude(estadoReg='N').aggregate(totalAb=Coalesce(Sum('valorEnCurso'), 0))
                sumatoriaAbonos = (sumatoriaAbonos['totalAb']) + 0
                print("sumatoriaAbonos", sumatoriaAbonos)
                grabo2 = Liquidacion.objects.filter(id=liquidacionId).update(totalAbonos=sumatoriaAbonos)

            if aformaPago == "3":
                print("Entre 3")
                sumatoriaCuotaModeradora = Pagos.objects.filter(tipoDoc_id=registroId.tipoDoc_id, documento_id=registroId.documento_id, consec=registroId.consecAdmision,convenio_id=registroId.convenio_id,formaPago_id=aformaPago).exclude(estadoReg='N').aggregate(totalM=Coalesce(Sum('valorEnCurso'), 0))
                sumatoriaCuotaModeradora = (sumatoriaCuotaModeradora['totalM']) + 0
                print("sumatoriaCuotaModeradora", sumatoriaCuotaModeradora)
                grabo2 = Liquidacion.objects.filter(id=liquidacionId).update(totalCuotaModeradora=sumatoriaCuotaModeradora)

            if aformaPago == "4":
                print ("Entre 4")

                sumatoriaCopagos = Pagos.objects.filter(tipoDoc_id=registroId.tipoDoc_id, documento_id=registroId.documento_id, consec=registroId.consecAdmision,convenio_id=registroId.convenio_id,formaPago_id=aformaPago).exclude(estadoReg='N').aggregate(totalC=Coalesce(Sum('valorEnCurso'), 0))
                sumatoriaCopagos = (sumatoriaCopagos['totalC']) + 0
                print("sumatoriaCopagos", sumatoriaCopagos)
                grabo2 = Liquidacion.objects.filter(id=liquidacionId).update(totalCopagos=sumatoriaCopagos)

            grabo3 = Liquidacion.objects.filter(id=liquidacionId).update(totalRecibido= F('anticipos') + F('totalAbonos') + F('totalCuotaModeradora') + F('totalCopagos'))


            grabo4 = Liquidacion.objects.filter(id=liquidacionId).update(valorApagar  = F('totalProcedimientos') + F('totalSuministros') - F('totalRecibido'))

            return JsonResponse({'success': True, 'message': 'Valor abono en curso guardado satisfactoriamente!'})

    except Exception as e:
        # Aquí ya se hizo rollback automáticamente
        print("Se hizo rollback por:", e)


def TrasladarConvenio(request):
    print ("Entre a Trasladar Convenio" )

    liquidacionId = request.POST['liquidacionId']
    tipoIng = request.POST['tipoIng']
    username_id =  request.POST['username_id']
    convenioId = request.POST['convenioId']
    print ("liquidacionId = ", liquidacionId)
    print ("convenioId = ", convenioId)

    convenioIdHacia = request.POST['convenioIdHacia']
    print ("convenioIdHacia = ", convenioIdHacia)

    fechaRegistro = datetime.datetime.now()
    estadoReg= 'A'

    registroId = Liquidacion.objects.get(id=liquidacionId)
    print  ("registroId documento =" , registroId.documento_id)
    print  ("registroId tipoDoc =" , registroId.tipoDoc_id)
    print  ("registroId consec =" , registroId.consecAdmision)

    ## Primero debo averiguar si existe cabezote para el nuevo convenio. So no existe se crea el cabezote

    # Busco las liquidacionesId de cada convenio

    #if (convenioId == ''):
    #    liquidacionIdDesde = Liquidacion.objects.get(tipoDoc_id=registroId.tipoDoc_id, documento_id=registroId.documento_id, consecAdmision=registroId.consecAdmision ,convenio_id ='None')
    #else:
    liquidacionIdDesde = Liquidacion.objects.get(tipoDoc_id=registroId.tipoDoc_id, documento_id=registroId.documento_id, consecAdmision=registroId.consecAdmision, convenio_id = convenioId)


    liquidacionIdHasta = Liquidacion.objects.get(tipoDoc_id=registroId.tipoDoc_id, documento_id=registroId.documento_id, consecAdmision=registroId.consecAdmision, convenio_id = convenioIdHacia)

    print ("liquidacionIdDesde =", liquidacionIdDesde )
    print("liquidacionIdHasta", liquidacionIdHasta )

    print ("liquidacionIdDesde.id =", liquidacionIdDesde.id )
    print("liquidacionIdHasta.id", liquidacionIdHasta.id )


    ## Se busca de que columna se van a traer los valores

    ## Primero se actualiza cabezote Los totales


    miConexiont = None
    try:

        # Busco la columna de Procedimientos a leer la tarifa

        comando1 = 'SELECT descrip.columna columnaProced FROM facturacion_liquidacion liq,contratacion_convenios conv,tarifarios_tarifariosdescripcion descrip where liq.id =	' + "'" + str(
            liquidacionIdHasta) + "'" + ' AND liq.convenio_id = conv.id and descrip.id = conv."tarifariosDescripcionProc_id"'
        curt.execute(comando1)
        print(comando1)

        columnaProcedimientos = []

        for columnaProced  in curt.fetchall():
                columnaProcedimientos.append( {"columnaProced": columnaProced})


        print ("columnaProcedimientos", columnaProcedimientos[0]['columnaProced'])

        columnaProcedimientos = columnaProcedimientos[0]['columnaProced']
        columnaProcedimientos = str(columnaProcedimientos)


        columnaProcedimientos = columnaProcedimientos.replace("(", ' ')
        columnaProcedimientos = columnaProcedimientos.replace(")", ' ')
        columnaProcedimientos = columnaProcedimientos.replace(",", ' ')
        columnaProcedimientos = columnaProcedimientos.replace("'", '')
        columnaProcedimientos = columnaProcedimientos.replace(" ", '')
        print("columnaProcedimientos QUEDO= ", columnaProcedimientos)

        # Busco la columna de Suministros a leer la tarifa

        comando2 = 'SELECT descrip.columna columnaSuminist FROM facturacion_liquidacion liq,contratacion_convenios conv,tarifarios_tarifariosdescripcion descrip where liq.id =	' + "'" + str(liquidacionIdHasta) + "'" + ' AND liq.convenio_id = conv.id and descrip.id = conv."tarifariosDescripcionSum_id"'
        print("comando = ", comando2)

        curt.execute(comando2)

        columnaSuministros = []

        for columnaSuminist  in curt.fetchall():
                columnaSuministros.append( {"columnaSuminist": columnaSuminist})


        print ("columnaSuministros", columnaSuministros[0]['columnaSuminist'])

        columnaSuministros = columnaSuministros[0]['columnaSuminist']
        columnaSuministros = str(columnaSuministros)


        columnaSuministros = columnaSuministros.replace("(", ' ')
        columnaSuministros = columnaSuministros.replace(")", ' ')
        columnaSuministros = columnaSuministros.replace(",", ' ')

        columnaSuministros = columnaSuministros.replace("'", '')
        columnaSuministros = columnaSuministros.replace(" ", '')

        print("columnaSuministros = ", columnaSuministros)

        ## Segundo busco los Cups desde y los envio Hasta


        comando3 = 'INSERT INTO facturacion_liquidaciondetalle ( consecutivo, fecha, cantidad, "valorUnitario", "valorTotal", cirugia, "fechaCrea", "fechaModifica", observaciones, "fechaRegistro", "estadoRegistro",examen_id,  "usuarioModifica_id", "usuarioRegistro_id", liquidacion_id, "tipoHonorario_id", "tipoRegistro", "historiaMedicamento_id") select  det.consecutivo, liq.fecha, cantidad, proc."' + str(columnaProcedimientos) + '"' + ', proc."' + str(columnaSuministros) + '"' + ' * cantidad, cirugia, "fechaCrea", "fechaModifica", liq.observaciones, liq."fechaRegistro", liq."estadoRegistro", examen_id, "usuarioModifica_id", liq."usuarioRegistro_id",' + "'" + str(liquidacionIdHasta.id) + "'" + ' , "tipoHonorario_id",	"tipoRegistro", "historiaMedicamento_id" from facturacion_liquidacion liq  , facturacion_liquidaciondetalle det, contratacion_convenios conv,	  tarifarios_tarifariosdescripcion descrip, tarifarios_tipostarifa tiptar, tarifarios_tarifariosProcedimientos proc where det.liquidacion_id = liq.id and det.liquidacion_id = ' + "'" + str(liquidacionIdDesde.id) + "'" + ' and conv.id = ' + "'" + str(liquidacionIdHasta.convenio_id) + "'" + ' and det."estadoRegistro" = ' + "'" + str('A') + "'" + ' and descrip.id = conv."tarifariosDescripcionProc_id" and tiptar.id = descrip."tiposTarifa_id" and tiptar.id = proc."tiposTarifa_id" and proc."codigoCups_id" = det.examen_id'
        print("comando = ", comando3)
        curt.execute(comando3)


        ## Tercero busco los Cums desde y los envio Hasta

        comando4 = 'INSERT INTO facturacion_liquidaciondetalle ( consecutivo, fecha, cantidad, "valorUnitario", "valorTotal", cirugia, "fechaCrea", "fechaModifica", observaciones, "fechaRegistro", "estadoRegistro",cums_id,  "usuarioModifica_id", "usuarioRegistro_id", liquidacion_id, "tipoHonorario_id", "tipoRegistro", "historiaMedicamento_id") select  det.consecutivo, liq.fecha, cantidad, sum.' + '"' + str(columnaSuministros) + '"' + ', sum."' + str(columnaSuministros) + '"'  + ' * cantidad, cirugia, "fechaCrea", "fechaModifica", liq.observaciones, liq."fechaRegistro", liq."estadoRegistro", cums_id, "usuarioModifica_id", liq."usuarioRegistro_id",' + "'" + str(liquidacionIdHasta.id) + "'" + ' , "tipoHonorario_id",	"tipoRegistro", "historiaMedicamento_id" from facturacion_liquidacion liq  , facturacion_liquidaciondetalle det, contratacion_convenios conv,	  tarifarios_tarifariosdescripcion descrip, tarifarios_tipostarifa tiptar, tarifarios_tarifariosSuministros sum where det.liquidacion_id = liq.id and det.liquidacion_id = ' + "'" + str(liquidacionIdDesde.id) + "'" + ' and conv.id = ' + "'" + str(liquidacionIdHasta.convenio_id) + "'" + ' and det."estadoRegistro" =  ' + "'" + str('A') + "'" + ' and descrip.id = conv."tarifariosDescripcionSum_id" and tiptar.id = descrip."tiposTarifa_id" and tiptar.id = sum."tiposTarifa_id" and sum."codigoCum_id" = det.cums_id'
        print("comando = ", comando4)
        curt.execute(comando4)

        # Ops fata Anular todo el detalle de la cuenta donde estaba


        comando5 = 'UPDATE facturacion_liquidaciondetalle set "estadoRegistro" = ' + "'" +str('N') + "'," + '"fechaRegistro" = ' + "'" + str(fechaRegistro) + "'"
        print("comando = ", comando5)
        curt.execute(comando5)

        miConexiont.commit()
        curt.close()
        miConexiont.close()


        ## Faltan trasladar los Abonos sera por el apicativo abonos ??



    except psycopg2.DatabaseError as error:
        print ("Entre por rollback" , error)
        if miConexiont:
            print("Entro ha hacer el Rollback")
            miConexiont.rollback()

        print ("Voy a hacer el jsonresponde")
        return JsonResponse({'success': False, 'Mensaje': error})

    finally:
        if miConexiont:
            curt.close()
            miConexiont.close()

    totalSuministros = LiquidacionDetalle.objects.all().filter(liquidacion_id=liquidacionIdHasta.id).filter(examen_id = None).exclude(estadoRegistro='N').aggregate(totalS=Coalesce(Sum('valorTotal'), 0))
    totalSuministros = (totalSuministros['totalS']) + 0
    print("totalSuministros", totalSuministros)
    totalProcedimientos = LiquidacionDetalle.objects.all().filter(liquidacion_id=liquidacionIdHasta.id).filter(cums_id = None).exclude(estadoRegistro='N').aggregate(totalP=Coalesce(Sum('valorTotal'), 0))
    totalProcedimientos = (totalProcedimientos['totalP']) + 0
    print("totalProcedimientos", totalProcedimientos)
    registroPago = Liquidacion.objects.get(id=liquidacionIdHasta.id)
    totalCopagos = registroPago.totalCopagos
    totalCuotaModeradora = registroPago.totalCuotaModeradora
    totalAnticipos = registroPago.anticipos
    totalAbonos = registroPago.totalAbonos
    #valorEnCurso = registroPago.valorEnCurso
    totalRecibido = registroPago.totalRecibido
    totalAnticipos = registroPago.anticipos
    valorApagar = registroPago.valorApagar
    totalLiquidacion = registroPago.totalLiquidacion

    print ("Voy a grabar el cabezote")

    miConexiont = None
    try:


        miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                       password="123456")
        curt = miConexiont.cursor()
        comando = 'UPDATE facturacion_liquidacion SET "totalSuministros" = ' + str(
            totalSuministros) + ',"totalProcedimientos" = ' + str(totalProcedimientos) + ', "totalCopagos" = ' + str(
            totalCopagos) + ' , "totalCuotaModeradora" = ' + str(totalCuotaModeradora) + ', anticipos = ' + str(
            totalAnticipos) + ' ,"totalAbonos" = ' + str(totalAbonos) + ', "totalLiquidacion" = ' + str(
            totalLiquidacion) + ', "valorApagar" = ' + str(valorApagar) + ', "totalRecibido" = ' + str(
            totalRecibido) + ' WHERE id =' + str(liquidacionIdHasta.id)
        curt.execute(comando)
        miConexiont.commit()
        curt.close()
        miConexiont.close()

        # Rutina Guarda en cabezote los totales

        return JsonResponse({'success': True, 'message': 'Traslado realizado satisfactoriamente!'})

    except psycopg2.DatabaseError as error:
        print("Entre por rollback", error)
        if miConexiont:
            print("Entro ha hacer el Rollback")
            miConexiont.rollback()

        print("Voy a hacer el jsonresponde")
        return JsonResponse({'success': False, 'Mensaje': error})

    finally:
        if miConexiont:
            curt.close()
            miConexiont.close()


def BuscoAbono(request):
    print ("Entre a BuscoAbono" )
    abonoId = request.POST["abonoId"]

    # Combo TiposPagos

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT c.id id,c.nombre nombre FROM cartera_tiposPagos c order by c.nombre'

    curt.execute(comando)
    print(comando)

    tiposPagos = []

    # tiposPagos.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
        tiposPagos.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(tiposPagos)

    # context['TiposPagos'] = tiposPagos

    # Fin combo tiposPagos

    # Combo FormasPago

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curt = miConexiont.cursor()

    comando = 'SELECT c.id id,c.nombre nombre FROM cartera_formasPagos c order by c.nombre'

    curt.execute(comando)
    print(comando)

    formasPagos = []

    # formasPagos.append({'id': '', 'nombre': ''})

    for id, nombre in curt.fetchall():
        formasPagos.append({'id': id, 'nombre': nombre})

    miConexiont.close()
    print(formasPagos)

    # Fin combo formasPagos

    # Abro Conexion

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",password="123456")
    cur = miConexionx.cursor()

    comando = 'select pag.id id, pag.fecha fecha, pag.consec consec, pag.valor valor , pag.descripcion descripcion, pag."estadoReg" estadoReg, pag."tipoPago_id"  tipoPago_id, pag."formaPago_id" formaPago_id,  pag.saldo saldo, pag."totalAplicado" totalAplicado, pag."valorEnCurso" valorEnCurso FROM cartera_pagos pag where pag.id = ' + "'" + str(abonoId) + "'"

    print(comando)

    cur.execute(comando)

    abonoPaciente = []

    for id, fecha , consec, valor, descripcion, estadoReg, tipoPago_id, formaPago_id, saldo, totalAplicado, valorEnCurso in cur.fetchall():
            abonoPaciente.append( {"id": id,"consec":consec, "valor" : valor, "descripcion":descripcion, "estadoReg":estadoReg, "tipoPago_id":tipoPago_id,
                     "formaPago_id": formaPago_id, "saldo": saldo, "totalAplicado": totalAplicado, "valorEnCurso":valorEnCurso
                                 })


    miConexionx.close()
    print("abonoPaciente = " , abonoPaciente)

    # Cierro Conexion    

    return JsonResponse({'pk':abonoPaciente[0]['id'],'id':abonoPaciente[0]['id'], 'consec':abonoPaciente[0]['consec'],'valor':abonoPaciente[0]['valor'],
		          'descripcion':abonoPaciente[0]['descripcion'],'estadoReg':abonoPaciente[0]['estadoReg'],'tipoPago_id':abonoPaciente[0]['tipoPago_id'],  'formaPago_id':abonoPaciente[0]['formaPago_id'],
                         'saldo': abonoPaciente[0]['saldo'], 'totalAplicado':abonoPaciente[0]['totalAplicado'] , 'valorEnCurso':abonoPaciente[0]['valorEnCurso'], 'FormasPagos':formasPagos, 'TiposPagos':tiposPagos      })



def load_dataFacturacionDetalle(request, data):
    print("Entre load_dataFacturacionDetalle")

    context = {}

    d = json.loads(data)

    username = d['username']
    sede = d['sede']
    username_id = d['username_id']
    #valor = d['valor']
    liquidacionId = d['liquidacionId']

    nombreSede = d['nombreSede']
    print("sede:", sede)
    print("username:", username)
    print("username_id:", username_id)
    print("liquidacionId:",liquidacionId)


    # Abro Conexion para la Liquidacion Detalle

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    cur = miConexionx.cursor()

    comando = 'select liq.id id,"consecutivoFactura" consecutivo ,  cast(date(fecha)||\' \'||to_char(fecha, \'HH:MI:SS\') as text) fecha  ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia ,  cast(date("fechaCrea")||\' \'||to_char("fechaCrea", \'HH:MI:SS\') as text)  fechaCrea , liq.observaciones ,  "estadoRegistro" ,  "examen_id" ,  cums_id , exa.nombre  nombreExamen  ,  facturacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro" , liq."estadoRegistro" estadoReg FROM facturacion_facturaciondetalle liq inner join clinico_examenes exa on (exa.id = liq."examen_id")  where facturacion_id= ' + "'" +  str(liquidacionId) + "'" +  ' UNION select liq.id id,"consecutivoFactura"  consecutivo, cast(date(fecha)||\' \'||to_char(fecha, \'HH:MI:SS\') as text) fecha  ,  liq.cantidad ,  "valorUnitario" ,  "valorTotal" ,  cirugia ,  cast(date("fechaCrea")||\' \'||to_char("fechaCrea", \'HH:MI:SS\') as text)  fechaCrea , liq.observaciones ,  "estadoRegistro" ,  "examen_id" ,  cums_id , sum.nombre  nombreExamen  ,  facturacion_id ,  liq."tipoHonorario_id" ,  "tipoRegistro" , liq."estadoRegistro" estadoReg FROM facturacion_facturaciondetalle liq inner join facturacion_suministros sum on (sum.id = liq.cums_id)  where facturacion_id= '  + "'" +  str(liquidacionId) + "'" + ' order by consecutivo'

    print(comando)

    cur.execute(comando)

    facturacionDetalle = []

    for id, consecutivo, fecha, cantidad, valorUnitario, valorTotal, cirugia, fechaCrea, observaciones, estadoRegistro, examen_id, cums_id, nombreExamen, liquidacion_id, tipoHonorario_id, tipoRegistro, estadoReg in cur.fetchall():
        facturacionDetalle.append(
            {"model": "facturacionDetalle.facturacionDetalle", "pk": id, "fields":
                {"id": id, "consecutivo": consecutivo,
                 "fecha": fecha,
                 "cantidad": cantidad,
                 "valorUnitario": valorUnitario, "valorTotal": valorTotal,
                 "cirugia": cirugia,
                 #"fechaCrea": fechaCrea,
                 "observaciones": observaciones,
                 "estadoRegistro": estadoRegistro, "examen_id": examen_id,
                 "cums_id": cums_id, "nombreExamen": nombreExamen,
                 "liquidacion_id": liquidacion_id, "tipoHonorario_id": tipoHonorario_id,
                 "tipoRegistro": tipoRegistro, "estadoReg":estadoReg}})

    miConexionx.close()
    print(facturacionDetalle)

    # Cierro Conexion

    serialized1 = json.dumps(facturacionDetalle, default=decimal_serializer)


    return HttpResponse(serialized1, content_type='application/json')
