from django.contrib import admin

# Register your models here.


from autorizaciones.models import  Autorizaciones, AutorizacionesDetalle, AutorizacionesCirugias, EstadosAutorizacion


@admin.register(Autorizaciones)
class autorizacionesAdmin(admin.ModelAdmin):
    list_display = ("id", "sedesClinica", "historia","estadoAutorizacion", "fechaSolicitud","empresa","fechaAutorizacion")
    search_fields = ("id", "sedesClinica", "historia","estadoAutorizacion", "fechaSolicitud","empresa","fechaAutorizacion")
    # Filtrar
    list_filter = ("id", "sedesClinica", "historia", "estadoAutorizacion","fechaSolicitud","empresa","fechaAutorizacion")


@admin.register(AutorizacionesDetalle)
class autorizacionesDetalleAdmin(admin.ModelAdmin):
    list_display = ("id",  "autorizaciones", "estadoAutorizacion","cantidadSolicitada","cantidadAutorizada")
    search_fields = ("id", "autorizaciones", "estadoAutorizacion","cantidadSolicitada","cantidadAutorizada")
    # Filtrar
    # list_filter =("id",  "autorizaciones","estadoAutorizacion","cantidadSolicitada","cantidadAutorizada")



@admin.register(AutorizacionesCirugias)
class autorizacionesCirugiasAdmin(admin.ModelAdmin):

   list_display = ("id", "sedesClinica", "tipoDoc","documento","hClinica","consec", "autorizacionesId","fechaRegistro","usuarioRegistro")
   search_fields = ("id", "sedesClinica", "tipoDoc","documento","hClinica","consec", "autorizacionesId","fechaRegistro","usuarioRegistro")
   # Filtrar
   # list_filter = ("id", "sedesClinica", "tipoDoc","documento","hClinica","consec", "autorizacionesId","fechaRegistro","usuarioRegistro")

@admin.register(EstadosAutorizacion)
class estadosAutorizacionAdmin(admin.ModelAdmin):

   list_display = ("id", "nombre")
   search_fields = ("id", "nombre")
   # Filtrar
   # list_filter = ("id", "nombre")

