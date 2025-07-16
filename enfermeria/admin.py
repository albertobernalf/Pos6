from django.contrib import admin

# Register your models here.

from enfermeria.models import EnfermeriaTipoOrigen,  EnfermeriaTipoMovimiento


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