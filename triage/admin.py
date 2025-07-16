from django.contrib import admin

# Register your models here.

from triage.models import Triage


@admin.register(Triage)
class triageAdmin(admin.ModelAdmin):
    list_display = ("id", "sedesClinica","fechaSolicita", "fechaAtendio", "tipoDoc","documento","hClinica","regimen","tiposCotizante","motivo")
    search_fields = ("id", "sedesClinica","fechaSolicita", "fechaAtendio", "tipoDoc","documento","hClinica","regimen","tiposCotizante","motivo")
    # Filtrar
    list_filter =("id", "sedesClinica","fechaSolicita", "fechaAtendio", "tipoDoc","documento","hClinica","regimen","tiposCotizante","motivo")

