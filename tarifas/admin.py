from django.contrib import admin

# Register your models here.

from tarifas.models import TiposHonorarios,  Uvr, TiposSalas,  Tarifas, TiposTarifa, GruposQx, TarifasSuministros,  HonorariosIss 


@admin.register(TiposHonorarios)
class tiposHonorariosAdmin(admin.ModelAdmin):

   list_display = ("id", "nombre")
   search_fields = ("id", "nombre")
   # Filtrar
   list_filter = ("id", "nombre")




@admin.register(Uvr)
class uvrsAdmin(admin.ModelAdmin):

   list_display = ("id", "tipoTarifa", "año", "valor")
   search_fields = ("id", "tipoTarifa", "año", "valor")
   # Filtrar
   list_filter = ("id", "tipoTarifa", "año", "valor")




@admin.register(TiposSalas)
class tiposSalasAdmin(admin.ModelAdmin):

   list_display = ("id", "nombre")
   search_fields = ("id", "nombre")
   # Filtrar
   list_filter = ("id", "nombre")




@admin.register(Tarifas)
class tarifasAdmin(admin.ModelAdmin):

   list_display = ("id", "tipoTarifa", "nombre", "codigoHomologado")
   search_fields = ("id", "tipoTarifa", "nombre", "codigoHomologado")
   # Filtrar
   list_filter =("id", "tipoTarifa", "nombre", "codigoHomologado")


@admin.register(GruposQx)
class gruposQxAdmin(admin.ModelAdmin):

   list_display = ("id", "nombre")
   search_fields = ("id", "nombre")
   # Filtrar
   list_filter = ("id", "nombre")


@admin.register(TarifasSuministros)
class tarifasSuministrosAdmin(admin.ModelAdmin):

   list_display = ("id", "tipoTarifa", "suministro", "codigoHomologado")
   search_fields = ("id", "tipoTarifa", "suministro", "codigoHomologado")
   # Filtrar
   list_filter =("id", "tipoTarifa", "suministro", "codigoHomologado")




@admin.register(HonorariosIss)
class honorariosIssAdmin(admin.ModelAdmin):

   list_display = ("id", "descripcion","minUvr","maxUvr", "valor")
   search_fields = ("id", "descripcion","minUvr","maxUvr", "valor")
   # Filtrar
   list_filter = ("id", "descripcion","minUvr","maxUvr","valor")


