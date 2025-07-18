from django.contrib import admin

# Register your models here.

from enfermeria.models import EnfermeriaTipoOrigen,  EnfermeriaTipoMovimiento, TiposTurnosEnfermeria, TurnosEnfermeria


@admin.register( EnfermeriaTipoOrigen)
class  enfermeriaTipoOrigenAdmin(admin.ModelAdmin):

    list_display = ( "id","nombre",  "usuarioRegistro")
    search_fields = ( "id","nombre",  "usuarioRegistro")
    # Filtrar
    list_filter =  ( "id","nombre",  "usuarioRegistro")

@admin.register( EnfermeriaTipoMovimiento)
class  enfermeriaTipoMovimientoAdmin(admin.ModelAdmin):

    list_display = ( "id","nombre",  "usuarioRegistro")
    search_fields = ( "id","nombre",  "usuarioRegistro")
    # Filtrar
    list_filter =  ( "id","nombre",  "usuarioRegistro")

@admin.register( TiposTurnosEnfermeria)
class  tiposTurnosEnfermeriaAdmin(admin.ModelAdmin):

    list_display = ( "id","nombre", "horario", "sedesClinica",  "usuarioRegistro")
    search_fields = ( "id","nombre", "horario", "sedesClinica",  "usuarioRegistro")
    # Filtrar
    list_filter =  ( "id","nombre", "horario", "sedesClinica",  "usuarioRegistro")


@admin.register( TurnosEnfermeria)
class  turnosEnfermeriaAdmin(admin.ModelAdmin):

    list_display = ( "id", "tiposTurnosEnfermeria", "enfermeraTurno", "serviciosAdministrativos", "usuarioRegistro")
    search_fields =( "id", "tiposTurnosEnfermeria", "enfermeraTurno", "serviciosAdministrativos", "usuarioRegistro")
    # Filtrar
    list_filter =  ( "id", "tiposTurnosEnfermeria", "enfermeraTurno", "serviciosAdministrativos", "usuarioRegistro")