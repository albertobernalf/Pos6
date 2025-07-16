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
from rips.models  import RipsMedicamentos, RipsConsultas, RipsProcedimientos, RipsOtrosServicios
import pickle


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

    miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
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

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT glo.id, "fechaRecepcion", "saldoFactura", "totalSoportado", "totalAceptado", observaciones, glo."fechaRegistro", glo."estadoReg", convenio_id,  conv.nombre nombreConvenio,glo."usuarioRegistro_id", factura_id, "fechaRespuesta", "tipoGlosa_id", tipglo.nombre nombreTipoGlosa,  "usuarioRecepcion_id", "usuarioRespuesta_id", "valorGlosa", "estadoRadicacion_id", "estadoRecepcion_id", estGlosa.nombre estadoGlosaRecepcion, glo."sedesClinica_id", "ripsEnvio_id" FROM public.cartera_glosas glo, cartera_estadosglosas estGlosa , contratacion_convenios conv, cartera_tiposglosas tipglo WHERE glo."sedesClinica_id" = ' + "'" + str(sede) + "'" + 'AND tipglo.id = glo."tipoGlosa_id"   AND  conv.id = glo.convenio_id AND estGlosa.id =  glo."estadoRecepcion_id" AND estGlosa.tipo = ' + "'" + str('RECEPCION') + "'"

    print(detalle)

    curx.execute(detalle)

    for id,  fechaRecepcion, saldoFactura, totalSoportado, totalAceptado, observaciones, fechaRegistro, estadoReg, convenio_id, nombreConvenio, usuarioRegistro_id, factura_id,  fechaRespuesta, tipoGlosa_id,nombreTipoGlosa, usuarioRecepcion_id, usuarioRespuesta_id,  valorGlosa, estadoRadicacion_id , estadoRecepcion_id, estadoGlosaRecepcion,  sedesClinica_id, ripsEnvio_id in curx.fetchall():
        glosas.append(
            {"model": "cartera.glosas", "pk": id, "fields":
                {'id': id, 'fechaRecepcion': fechaRecepcion, 'saldoFactura': saldoFactura, 'totalSoportado': totalSoportado,'totalAceptado':totalAceptado,
                 'observaciones': observaciones, 'fechaRegistro': fechaRegistro,'estadoReg': estadoReg, 'convenio_id': convenio_id,'nombreConvenio':nombreConvenio, 'usuarioRegistro_id': usuarioRegistro_id, 'factura_id' : factura_id,
                 'factura_id': factura_id, 'fechaRespuesta': fechaRespuesta,
                 'tipoGlosa_id': tipoGlosa_id,'nombreTipoGlosa' :nombreTipoGlosa, 'usuarioRecepcion_id': usuarioRecepcion_id,'estadoGlosaRecepcion':estadoGlosaRecepcion, 'usuarioRespuesta_id': usuarioRespuesta_id,
                 'valorGlosa': valorGlosa, 'estadoRadicacion_id': estadoRadicacion_id, 'estadoRecepcion_id': estadoRecepcion_id,
                 'sedesClinica_id': sedesClinica_id,'ripsEnvio_id':ripsEnvio_id}})

    miConexionx.close()
    print("glosas "  , glosas)
    context['Glosas'] = glosas

    serialized1 = json.dumps(glosas,  default=str)

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

    valorGlosa = request.POST['valorGlosa']
    print ("valorGlosa =", valorGlosa)

    estadoRecepcion_id = request.POST['estadoRecepcion_id']
    print ("estadoRecepcion_id =", estadoRecepcion_id)


    usuarioRegistro_id = request.POST['usuarioRegistro_id']
    print ("usuarioRegistro_id =", usuarioRegistro_id)

    estadoReg = 'A'
    fechaRegistro = datetime.datetime.now()

    miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",  password="123456")
    cur3 = miConexion3.cursor()

    comando = 'INSERT INTO cartera_glosas ("fechaRecepcion", "saldoFactura", "totalSoportado", "totalAceptado", observaciones, "fechaRegistro", "estadoReg", convenio_id, "usuarioRegistro_id", factura_id,  "tipoGlosa_id", "usuarioRecepcion_id",  "valorGlosa", "estadoRadicacion_id", "estadoRecepcion_id","sedesClinica_id", "ripsEnvio_id" ) VALUES (' + "'" + str(fechaRecepcion) + "'" + ', 0,0,0,' + "'" + str(observaciones) + "','" + str(fechaRegistro) + "','" + str(estadoReg) + "','" + str(convenio_id) + "','"  + str(usuarioRegistro_id) + "', '" + str(factura_id) + "', '" + str(tipoGlosa_id) + "', '" + str(usuarioRegistro_id) + "','" + str(valorGlosa) + "', null, '" + str(estadoRecepcion_id) + "', '" + str(sedesClinica_id)  + "',null)"

    print(comando)
    cur3.execute(comando)
    miConexion3.commit()
    miConexion3.close()



    return JsonResponse({'success': True, 'message': 'Envio realizado satisfactoriamente!'})


def Load_tablaGlosasProcedimientos(request, data):

    print("Entre load_data Procedimientos Glosas")

    context = {}
    d = json.loads(data)

    sedesClinica_id = d['sedesClinica_id']
    print("sedesClinica_id = ", sedesClinica_id)

    facturaId = d['facturaId']
    print("facturaId = ", facturaId)

    procedimientosRips = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
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

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
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

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT  ripsu.id, ripsu."tipoDocumentoIdentificacion", ripsu."tipoUsuario", ripsu."fechaNacimiento", ripsu."codSexo", ripsu."codZonaTerritorialResidencia", ripsu.incapacidad, ripsu.consecutivo, ripsu."fechaRegistro", ripsu."codMunicipioResidencia_id", ripsu."codPaisOrigen_id",ripsu."codPaisResidencia_id", ripsu."usuarioRegistro_id", ripsu."numDocumentoIdentificacion", ripsu."ripsDetalle_id", ripsu."ripsTransaccion_id"  FROM public.rips_ripsusuarios ripsu, public.rips_ripstransaccion ripstra  WHERE ripstra.id = ripsu."ripsTransaccion_id" and cast(ripstra."numFactura" as integer) =' + "'" + str(facturaId) + "'"

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

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT  GloDet.id id,"itemFactura", "nomTecnologiaSalud", GloDet."idMIPRES",  cums.nombre cums,"concentracionMedicamento", "cantidadMedicamento",  "vrUnitMedicamento", "vrServicio",  consecutivo,  "tipoMedicamento_id", "unidadMedida_id", "cantidadGlosada", "cantidadAceptada", "cantidadSoportado", "valorGlosado","vAceptado",	 "valorSoportado","motivoGlosa_id", "notasCreditoGlosa", "notasCreditoOtras", "notasDebito" FROM public.rips_ripstransaccion ripstra , public.rips_ripsmedicamentos GloDet , public.rips_ripscums cums  WHERE   ripstra.id = GloDet."ripsTransaccion_id" AND cum ="nomTecnologiaSalud" and cast(ripstra."numFactura" as integer) =' +  str(facturaId)

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


    glosasDetalle = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()



    detalle = 'select ' + "'" + str('MEDICAMENTOS') + "'" + ' tipo,med.id, med.consecutivo consec, med."itemFactura",med."nomTecnologiaSalud" codigo,cums.nombre nombre,med."vrServicio",mot.nombre glosaNombre, med."cantidadGlosada",med."cantidadAceptada",med."cantidadSoportado", med."valorGlosado", med."vAceptado", med."valorSoportado",med."notasCreditoGlosa" FROM rips_ripstransaccion ripstra , rips_ripsmedicamentos med, rips_ripscums cums, facturacion_facturaciondetalle det, cartera_motivosglosas mot where  cast(ripstra."numFactura" as float) = ' + str(facturaId) + ' and med."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and med."nomTecnologiaSalud" =  cums.cum and med."itemFactura" = det."consecutivoFactura" and mot.id = med."motivoGlosa_id" and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'" + str('PROCEDIMIENTOS') + "'" + ' tipo, proc.id, proc.consecutivo consec, proc."itemFactura", cast(proc."codProcedimiento_id" as text) codigo, exa.nombre nombre, proc."vrServicio", mot.nombre glosaNombre, proc."cantidadGlosada", proc."cantidadAceptada", proc."cantidadSoportado", proc."valorGlosado", proc."vAceptado", proc."valorSoportado", proc."notasCreditoGlosa"  FROM  rips_ripstransaccion ripstra inner join  rips_ripsprocedimientos proc on (proc."ripsTransaccion_id" = ripstra.id) inner join clinico_examenes exa on ( exa.id =proc."codProcedimiento_id" ) inner join facturacion_facturaciondetalle det on (det.facturacion_id=cast(ripstra."numFactura" as float) and det."consecutivoFactura" = proc."itemFactura") left join cartera_motivosglosas mot on (mot.id = proc."motivoGlosa_id")  where cast(ripstra."numFactura" as float) = ' +  str(facturaId) +  ' and ripstra."numNota"= ' + "'" + str('0') + "'" + ' UNION select ' + "'"  + str('CONSULTAS') + "'" + ' tipo, cons.id, cons.consecutivo consec, cons."itemFactura", cast(cons."codConsulta_id" as text) codigo, exa.nombre nombre, cons."vrServicio", mot.nombre glosaNombre, cons."cantidadGlosada", cons."cantidadAceptada", cons."cantidadSoportado", cons."valorGlosado", cons."vAceptado", cons."valorSoportado", cons."notasCreditoGlosa" FROM rips_ripstransaccion  ripstra, rips_ripsconsultas cons, clinico_examenes exa, facturacion_facturaciondetalle det, cartera_motivosglosas mot  where cast(ripstra."numFactura" as float) = ' + str(facturaId) + ' and cons."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and cons. "codConsulta_id" = exa.id and cons."itemFactura" = det."consecutivoFactura" and mot.id = cons."motivoGlosa_id" UNION select '+ "'" + str('OTROS SERVICIOS') + "'" + ' tipo, serv.id, serv.consecutivo consec, serv."itemFactura", serv."nomTecnologiaSalud" codigo, cums.nombre nombre, serv."vrServicio", mot.nombre glosaNombre, serv."cantidadGlosada", serv."cantidadAceptada", serv."cantidadSoportado", serv."valorGlosado", serv."vAceptado", serv."valorSoportado", serv."notasCreditoGlosa" FROM rips_ripstransaccion ripstra, rips_ripsotrosservicios serv, rips_ripscums cums, facturacion_facturaciondetalle  det, cartera_motivosglosas  mot where cast(ripstra."numFactura" as float) = ' + "'" +  str(facturaId) + "'" + ' and serv."ripsTransaccion_id" = ripstra.id and cast(ripstra."numFactura" as float) = det.facturacion_id and serv."codTecnologiaSalud_id" = cums.id and serv."itemFactura" = det."consecutivoFactura" and mot.id = serv."motivoGlosa_id"  order by 4'

    print(detalle)

    curx.execute(detalle)

    for  tipo, id, consec, itemFactura, codigo, nombre, vrServicio,  glosaNombre, cantidadGlosada , cantidadAceptada, cantidadSoportado, valorGlosado,vAceptado, valorSoportado , notasCreditoGlosa in curx.fetchall():
        glosasDetalle.append(
            {"model": "rips.GlosasDetalle", "pk": id, "fields":
                {'tipo':tipo, 'id': id, 'consec':consec,  'itemFactura': itemFactura , 'codigo': codigo, 'nombre' :nombre, 'vrServicio':vrServicio,'glosaNombre':glosaNombre,'cantidadGlosada':cantidadGlosada,'cantidadAceptada':cantidadAceptada,'cantidadSoportado':cantidadSoportado,'valorGlosado':valorGlosado,'vAceptado':vAceptado,'valorSoportado':valorSoportado,'notasCreditoGlosa':notasCreditoGlosa}})


    miConexionx.close()


    serialized1 = json.dumps(glosasDetalle,  default=str)

    return HttpResponse(serialized1, content_type='application/json')



def ConsultaGlosasDetalle(request):
    
    print("Entre consultaGlosasDetalle")

    id  = request.POST['id']
    print("id  =", id )

    tipo  = request.POST["tipo"]
    print("tipo  =", tipo )


    medicamentosRipsUnRegistro = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    if (tipo == 'MEDICAMENTOS'):

        detalle = 'SELECT ' + "'" + str('MEDICAMENTOS') + "'" + ' tipo, med.id,"itemFactura", "nomTecnologiaSalud" codigo, cums.nombre nombre, "vrServicio",	consecutivo,  "cantidadGlosada", "cantidadAceptada", "cantidadSoportado", "valorGlosado","vAceptado","valorSoportado","motivoGlosa_id", "notasCreditoGlosa" FROM public.rips_ripsmedicamentos med, public.rips_ripscums cums where med.id= ' + "'" + str(id) + "'" + ' and cum ="nomTecnologiaSalud"'

    if (tipo == 'PROCEDIMIENTOS'):

        detalle = 'SELECT ' + "'" + str('PROCEDIMIENTOS') + "'" + ' tipo, proc.id, "itemFactura", proc."codProcedimiento_id" codigo , exa.nombre nombre, "vrServicio",	consecutivo,  "cantidadGlosada", "cantidadAceptada", "cantidadSoportado","valorGlosado","vAceptado","valorSoportado","motivoGlosa_id", "notasCreditoGlosa"FROM public.rips_ripsprocedimientos proc, public.clinico_examenes exa   where proc.id= ' + "'" + str(id) + "'" + ' and proc."codProcedimiento_id" = exa.id'

    if (tipo == 'CONSULTAS'):
        detalle = 'SELECT ' + "'" + str('CONSULTAS') + "'" + ' tipo, cons.id, "itemFactura", cons."codConsulta_id" codigo, exa.nombre nombre, "vrServicio",	consecutivo,  "cantidadGlosada", "cantidadAceptada", "cantidadSoportado","valorGlosado","vAceptado","valorSoportado","motivoGlosa_id", "notasCreditoGlosa" FROM public.rips_ripsconsultas cons, public.clinico_examenes exa      where cons.id= ' + "'" + str(id) + "'" + ' and cons."codConsulta_id" = exa.id'

    if (tipo == 'OTROS SERVICIOS'):

        detalle = 'SELECT ' + "'" + str('OTROS SERVICIOS') + "'" + ' tipo, serv.id,"itemFactura",serv."nomTecnologiaSalud" codigo , cums.nombre nombre, "vrServicio",	consecutivo,  "cantidadGlosada", "cantidadAceptada", "cantidadSoportado","valorGlosado","vAceptado","valorSoportado","motivoGlosa_id", "notasCreditoGlosa" FROM public.rips_ripsotrosservicios serv, public.rips_ripscums cums  where serv.id= ' + "'" + str(id) + "'" + ' and serv."codTecnologiaSalud_id" =  cums.id'


    print(detalle)

    curx.execute(detalle)

    for tipo, id, itemFactura, codigo, nombre,  vrServicio,  consecutivo,  cantidadGlosada, cantidadAceptada, cantidadSoportado, valorGlosado,vAceptado, valorSoportado , motivoGlosa_id, notasCreditoGlosa   in curx.fetchall():
     medicamentosRipsUnRegistro.append(
            {"model": "rips.ripsmedicamentos", "pk": id, "fields":
                {'tipo':tipo, 'id': id, 'itemFactura': itemFactura , 'codigo': codigo,  'nombre':nombre,
		  'vrServicio':vrServicio,'consecutivo':consecutivo,'cantidadGlosada':cantidadGlosada,'cantidadAceptada':cantidadAceptada,'cantidadSoportado':cantidadSoportado,'valorGlosado':valorGlosado,'vAceptado':vAceptado,'valorSoportado':valorSoportado,'motivoGlosa_id':motivoGlosa_id,'notasCreditoGlosa':notasCreditoGlosa
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


    cantidadGlosada = request.POST['cantidadGlosadaGloDet']
    print ("cantidadGlosada =", cantidadGlosada)

    if (cantidadGlosada==''):
        cantidadGlosada=0.0

    print ("cantidadGlosada =", cantidadGlosada)

    cantidadAceptada = request.POST['cantidadAceptadaGloDet']
    print ("cantidadAceptada =", cantidadAceptada)

    if (cantidadAceptada==''):
        cantidadAceptada=0.0

    cantidadSoportado = request.POST['cantidadSoportadoGloDet']
    print ("cantidadSoportado =", cantidadSoportado)

    if (cantidadSoportado==''):
        cantidadSoportado=0.0


    valorGlosado = request.POST['valorGlosadoGloDet']
    valorGlosado = float(valorGlosado)


    print ("valorGlosado =", valorGlosado)

    if (valorGlosado==''):
        valorGlosado=0.0

    vAceptado = float(request.POST['vAceptadoGloDet'])
    print ("vAceptado =", vAceptado)

    if (vAceptado==''):
        vAceptado=0.0

    valorSoportado = float(request.POST['valorSoportadoGloDet'])
    print ("valorSoportado=",valorSoportado)

    if (valorSoportado==''):
        valorSoportado=0.0

    notasCreditoGlosa = request.POST['notasCreditoGlosaGloDet']
    print ("notasCreditoGlosa=",notasCreditoGlosa)

    if (notasCreditoGlosa==''):
        notasCreditoGlosa=0.0

 
    vrServicioGloDet = float(request.POST['vrServicioGloDet'])
    print ("vrServicioGloDet=", vrServicioGloDet)


    estadoReg = 'A'
    fechaRegistro = datetime.datetime.now()

    if ( valorGlosado > vrServicioGloDet ):
        print ("Entre 1")
        print("valorGlosado=", valorGlosado)
        print("vrServicioGloDet=", vrServicioGloDet)
        return JsonResponse({'success': False, 'Error' :'Si', 'message': 'Valor Glosa mayor que el valor del servicio!'})

    if ( valorSoportado > vrServicioGloDet ):
        print ("Entre 4")
        return JsonResponse({'success': False, 'Error' :'Si','message': 'Valor Soportado mayor que el valor del servicio!'})

    if ( vAceptado > vrServicioGloDet ):
        print ("Entre 5")
        return JsonResponse({'success': False, 'Error' :'Si','message': 'Valor aceptado mayor que el valor del servicio!'})

    if ( cantidadAceptada > cantidadGlosada ):
        print ("Entre 2")
        return JsonResponse({'success': False, 'Error' :'Si','message': 'Cantidad aceptada mayor que el valor del glosado!'})

    if ( cantidadSoportado > cantidadGlosada ):
        print ("Entre 3")
        return JsonResponse({'success': False, 'Error' :'Si','message': 'Cantidad soportada mayor que el valor del glosado!'})


    if ( (vAceptado + valorSoportado) > vrServicioGloDet ):
        print ("Entre 3")
        return JsonResponse({'success': False, 'Error' :'Si','message': 'Valor soportado mas valor aceptado mayor que el valor del servicio!'})



    miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",  password="123456")
    cur3 = miConexion3.cursor()
    if tipoGloDet == 'MEDICAMENTOS' :

        comando = 'UPDATE rips_ripsmedicamentos SET "cantidadGlosada"= ' +"'" + str(cantidadGlosada) + "'," + ' "cantidadAceptada" = ' + "'" +str(cantidadAceptada) + "'," + '"cantidadSoportado" = ' + "'" + str(cantidadSoportado) + "'," + '"valorGlosado"= ' + "'" + str(valorGlosado) + "'," + '"vAceptado" = ' + "'" + str(vAceptado) + "',"  + '"valorSoportado" = ' + "'" + str(valorSoportado) + "'," +  '"notasCreditoGlosa" = ' + "'" + str(notasCreditoGlosa) + "'" + ', glosa_id = '  + "'" + str(glosaId) + "'," + '"motivoGlosa_id" = ' + "'" + str(motivoGlosa_id) + "'" + '   WHERE id = ' + str(ripsId)

    if tipoGloDet == 'PROCEDIMIENTOS' :

        comando = 'UPDATE rips_ripsprocedimientos SET "cantidadGlosada"= ' +"'" + str(cantidadGlosada) + "'," + ' "cantidadAceptada" = ' + "'" +str(cantidadAceptada) + "'," + '"cantidadSoportado" = ' + "'" + str(cantidadSoportado) + "'," + '"valorGlosado"= ' + "'" + str(valorGlosado) + "'," + '"vAceptado" = ' + "'" + str(vAceptado) + "',"  + '"valorSoportado" = ' + "'" + str(valorSoportado) + "'," +  '"notasCreditoGlosa" = ' + "'" + str(notasCreditoGlosa) + "'" + ', glosa_id = '  + "'" + str(glosaId) + "'," + '"motivoGlosa_id" = ' + "'" + str(motivoGlosa_id) + "'" + '   WHERE id = ' + str(ripsId)

    if tipoGloDet == 'CONSULTAS' :

        comando = 'UPDATE rips_ripsconsultas SET "cantidadGlosada"= ' +"'" + str(cantidadGlosada) + "'," + ' "cantidadAceptada" = ' + "'" +str(cantidadAceptada) + "'," + '"cantidadSoportado" = ' + "'" + str(cantidadSoportado) + "'," + '"valorGlosado"= ' + "'" + str(valorGlosado) + "'," + '"vAceptado" = ' + "'" + str(vAceptado) + "',"  + '"valorSoportado" = ' + "'" + str(valorSoportado) + "'," +  '"notasCreditoGlosa" = ' + "'" + str(notasCreditoGlosa) + "'" + ', glosa_id = '  + "'" + str(glosaId) + "'," + '"motivoGlosa_id" = ' + "'" + str(motivoGlosa_id) + "'" + '   WHERE id = ' + str(ripsId)

    if tipoGloDet == 'OTOS SERVICIOS' :

        comando = 'UPDATE rips_ripsotrosservicios SET "cantidadGlosada"= ' +"'" + str(cantidadGlosada) + "'," + ' "cantidadAceptada" = ' + "'" +str(cantidadAceptada) + "'," + '"cantidadSoportado" = ' + "'" + str(cantidadSoportado) + "'," + '"valorGlosado"= ' + "'" + str(valorGlosado) + "'," + '"vAceptado" = ' + "'" + str(vAceptado) + "',"  + '"valorSoportado" = ' + "'" + str(valorSoportado) + "'," +  '"notasCreditoGlosa" = ' + "'" + str(notasCreditoGlosa) + "'" + ', glosa_id = '  + "'" + str(glosaId) + "'," + '"motivoGlosa_id" = ' + "'" + str(motivoGlosa_id) + "'" + '   WHERE id = ' + str(ripsId)



    print(comando)
    cur3.execute(comando)
    miConexion3.commit()
    miConexion3.close()


    # TOTALES
    totalAceptadoMed = RipsMedicamentos.objects.all().filter(glosa_id=glosaId).aggregate(totalA=Coalesce(Sum('vAceptado'), 0))
    totalSoportadoMed = RipsMedicamentos.objects.all().filter(glosa_id=glosaId).aggregate(totalS=Coalesce(Sum('valorSoportado'), 0))
    totalGlosadoMed = RipsMedicamentos.objects.all().filter(glosa_id=glosaId).aggregate(totalG=Coalesce(Sum('valorGlosado'), 0))

    totalAceptadoProc = RipsProcedimientos.objects.all().filter(glosa_id=glosaId).aggregate(totalA=Coalesce(Sum('vAceptado'), 0))
    totalSoportadoProc = RipsProcedimientos.objects.all().filter(glosa_id=glosaId).aggregate(totalS=Coalesce(Sum('valorSoportado'), 0))
    totalGlosadoProc = RipsProcedimientos.objects.all().filter(glosa_id=glosaId).aggregate(totalG=Coalesce(Sum('valorGlosado'), 0))

    totalAceptadoOtrosServ = RipsOtrosServicios.objects.all().filter(glosa_id=glosaId).aggregate(totalA=Coalesce(Sum('vAceptado'), 0))
    totalSoportadoOtrosServ = RipsOtrosServicios.objects.all().filter(glosa_id=glosaId).aggregate(totalS=Coalesce(Sum('valorSoportado'), 0))
    totalGlosadoOtrosServ = RipsOtrosServicios.objects.all().filter(glosa_id=glosaId).aggregate(totalG=Coalesce(Sum('valorGlosado'), 0))

    totalAceptadoCons = RipsConsultas.objects.all().filter(glosa_id=glosaId).aggregate(totalA=Coalesce(Sum('vAceptado'), 0))
    totalSoportadoCons = RipsConsultas.objects.all().filter(glosa_id=glosaId).aggregate(totalS=Coalesce(Sum('valorSoportado'), 0))
    totalGlosadoCons = RipsConsultas.objects.all().filter(glosa_id=glosaId).aggregate(totalG=Coalesce(Sum('valorGlosado'), 0))


    totalAceptado = totalAceptadoMed['totalA'] + totalAceptadoProc['totalA'] + totalAceptadoOtrosServ['totalA'] + totalAceptadoCons['totalA']
    totalSoportado = totalSoportadoMed['totalS'] + totalSoportadoProc['totalS'] + totalSoportadoOtrosServ['totalS'] + totalSoportadoCons['totalS']
    totalGlosado = totalGlosadoMed['totalG'] + totalGlosadoProc['totalG'] + totalGlosadoOtrosServ['totalG'] + totalGlosadoCons['totalG']

    print ("totalAceptado = ",totalAceptado)
    print("totalSoportado = ", totalSoportado)
    print("totalGlosado = ", totalGlosado)

    saldoFactura = 0

    # TIENE QUE ACTUALIZAR CARTERA_GLOSAS LOS TOTALES / PENDIENTE SALDO FACTURA


    miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",  password="123456")
    cur3 = miConexion3.cursor()

    comando = 'UPDATE cartera_glosas SET "totalSoportado"= ' +"'" + str(totalSoportado) + "'," + '"valorGlosa" = ' + "'" + str(valorGlosado) + "'," + ' "totalAceptado" = ' + "'" +str(totalAceptado) + "'," + '"saldoFactura" = ' + "'" + str(saldoFactura) + "'" + '   WHERE id = ' + str(glosaId)

    print(comando)
    cur3.execute(comando)
    miConexion3.commit()
    miConexion3.close()



    # TIENE QUE ACTUALIZAR CARTERA_GLOSASDETALLE INSERTAR O UPDATE, NO VOY A METER MAS SIMPOLEMENTE UN QUERY ENTRE TABÑAS
    # RIPS Y LA FACTURACION PARA MOSTRAR EL NITIDO DETALLE GLOSADO



    # TIENE QUE ACTUALIZAR FACTURACION_FACTURACIONDETALLE INSERTAR O UPDATE DE PRONOT OPCIOPNAL ??

    # CREO NO MAS ??


    # Aqui voya leer el dato guardado

    glosa = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                   password="123456")
    curx = miConexionx.cursor()

    detalle = 'SELECT id, "valorGlosa", "totalSoportado", "totalAceptado", "saldoFactura", "tipoGlosa_id", "estadoRadicacion_id" , "estadoRecepcion_id"  FROM public.cartera_glosas where id= ' + "'" + str(glosaId) + "'"

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

    miConexion3 = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",  password="123456")
    cur3 = miConexion3.cursor()

    comando = 'UPDATE cartera_glosas SET "tipoGlosa_id"= ' +"'" + str(tipoGlosa) + "'," + ' "estadoRadicacion_id" = ' + "'" +str(estadoRadicacion) + "'," + '"estadoRecepcion_id" = ' + "'" + str(estadoRecepcion) + "'" + '   WHERE id = ' + str(glosaId)

    print(comando)
    cur3.execute(comando)
    miConexion3.commit()
    miConexion3.close()

    return JsonResponse({'success': True, 'message': 'Glosa Actualizada satisfactoriamente!'})

def Load_tablaGlosasHospitalizacion(request, data):
    print("Entre load_data Hospitalizacion Rips")

    context = {}
    d = json.loads(data)

    sedesClinica_id = d['sedesClinica_id']
    print("sedesClinica_id = ", sedesClinica_id)

    facturaId = d['facturaId']
    print("facturaId = ", facturaId)

    hospitalizacionGlosas = []

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
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

    miConexionx = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
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

