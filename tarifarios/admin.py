from django.contrib import admin

# Register your models here.

from tarifarios.models import TiposHonorarios, TiposTarifaProducto,TiposTarifa,TarifariosDescripcion,TarifariosProcedimientos,TarifariosSuministros, TarifariosProcedimientosHonorarios, TablaSalasDeCirugia,TablaMaterialSuturaCuracion,TablaHonorariosSoat,TablaHonorariosIss ,MinimosLegales, GruposQx, TarifariosDescripcionHonorarios ,TablaSalasDeCirugiaIss , TablaMaterialSuturaCuracionIss


@admin.register(TiposTarifa)
class tiposTarifaAdmin(admin.ModelAdmin):

   list_display = ("id", "tiposTarifaProducto","nombre","fechaRegistro")
   search_fields = ("id", "tiposTarifaProducto", "nombre","fechaRegistro")
   # Filtrar
   list_filter = ("id", "tiposTarifaProducto", "nombre","fechaRegistro")

@admin.register(TiposTarifaProducto)
class tiposTarifaProductoAdmin(admin.ModelAdmin):

   list_display = ("id", "nombre","fechaRegistro")
   search_fields = ("id", "nombre","fechaRegistro")
   # Filtrar
   list_filter = ("id", "nombre","fechaRegistro")

@admin.register(TiposHonorarios)
class tiposHonorariosAdmin(admin.ModelAdmin):

   list_display = ("id", "nombre")
   search_fields = ("id", "nombre")
   # Filtrar
   list_filter = ("id", "nombre")

@admin.register(TarifariosDescripcion)
class TarifariosDescripcionAdmin(admin.ModelAdmin):

   list_display = ("id","tiposTarifa", "columna",  "descripcion","fechaRegistro")
   search_fields = ("id","tiposTarifa", "columna",  "descripcion","fechaRegistro")
   # Filtrar
   list_filter = ("id","tiposTarifa", "columna",  "descripcion","fechaRegistro")

@admin.register(TarifariosDescripcionHonorarios)
class TarifariosDescripcionHonorariosAdmin(admin.ModelAdmin):

   list_display = ("id","nombre")
   search_fields = ("id","nombre")
   # Filtrar
   list_filter = ("id","nombre")

@admin.register(TarifariosProcedimientos)
class tarifariosProcedimientosAdmin(admin.ModelAdmin):

   list_display = ("id","tiposTarifa", "codigoCups",  "codigoHomologado", "colValorBase", "colValor1", "colValor2", "colValor3","colValor1", "fechaRegistro")
   search_fields = ("id","tiposTarifa", "codigoCups",  "codigoHomologado", "colValorBase", "colValor1", "colValor2", "colValor3","colValor1", "fechaRegistro")
   # Filtrar
   list_filter = ("id","tiposTarifa", "codigoCups",  "codigoHomologado", "colValorBase", "colValor1", "colValor2", "colValor3","colValor1", "fechaRegistro")




@admin.register(TarifariosSuministros)
class tarifariosSuministrosAdmin(admin.ModelAdmin):

   list_display = ("id","tiposTarifa", "codigoCum",  "codigoHomologado", "colValorBase", "colValor1", "colValor2", "colValor3","colValor1", "fechaRegistro")
   search_fields = ("id","tiposTarifa", "codigoCum", "codigoHomologado", "colValorBase", "colValor1", "colValor2", "colValor3","colValor1", "fechaRegistro")
   # Filtrar
   list_filter = ("id","tiposTarifa", "codigoCum",  "codigoHomologado", "colValorBase", "colValor1", "colValor2", "colValor3","colValor1", "fechaRegistro")



@admin.register(TarifariosProcedimientosHonorarios)
class tarifariosProcedimientosHonorariosAdmin(admin.ModelAdmin):

   list_display = ("id","tiposTarifa", "codigoCups",  "codigoHomologado", "valorHonorarioCirujano", "valorHonorarioAnestesiologo", "valorHonorarioAyudante", "valorHonorarioPerfucionista","valorHonorarioViaAcceso", "fechaRegistro")
   search_fields = ("id","tiposTarifa", "codigoCups",  "codigoHomologado", "valorHonorarioCirujano", "valorHonorarioAnestesiologo", "valorHonorarioAyudante", "valorHonorarioPerfucionista","valorHonorarioViaAcceso", "fechaRegistro")
   # Filtrar
   list_filter = ("id","tiposTarifa", "codigoCups",  "codigoHomologado", "valorHonorarioCirujano", "valorHonorarioAnestesiologo", "valorHonorarioAyudante", "valorHonorarioPerfucionista","valorHonorarioViaAcceso", "fechaRegistro")

@admin.register(GruposQx)
class gruposQxAdmin(admin.ModelAdmin):
    list_display = ("id", "nombre","fechaRegistro")
    search_fields =  ("id", "nombre","fechaRegistro")
    # Filtrar
    list_filter =  ("id", "nombre","fechaRegistro")

@admin.register(MinimosLegales)
class minimosLegalesAdmin(admin.ModelAdmin):
    list_display = ("id", "nombre","año","valor","fechaRegistro")
    search_fields =  ("id", "nombre","año","valor","fechaRegistro")
    # Filtrar
    list_filter = ("id", "nombre","año","valor","fechaRegistro")


@admin.register(TablaHonorariosSoat)
class tablaHonorariosSoatAdmin(admin.ModelAdmin):
    list_display = ("id","tiposTarifaProducto","tiposHonorarios","homologado","grupoQx","smldv", "fechaRegistro")
    search_fields =  ("id","tiposTarifaProducto","tiposHonorarios","homologado","grupoQx","smldv", "fechaRegistro")
    # Filtrar
    list_filter = ("id", "tiposTarifaProducto","tiposHonorarios","homologado","grupoQx","smldv", "fechaRegistro")


@admin.register(TablaMaterialSuturaCuracion)
class tablaMaterialSuturaCuracionAdmin(admin.ModelAdmin):
    list_display = ("id", "tiposTarifaProducto","homologado","grupoQx","smldv","cruento", "fechaRegistro")
    search_fields =  ("id","tiposTarifaProducto","homologado","grupoQx","smldv", "cruento","fechaRegistro")
    # Filtrar
    list_filter = ("id", "tiposTarifaProducto","homologado","grupoQx","smldv", "cruento","fechaRegistro")


@admin.register(TablaSalasDeCirugia)
class tablaSalasDeCirugia(admin.ModelAdmin):
    list_display = ("id", "tiposTarifaProducto","homologado","grupoQx","smldv", "cruento", "fechaRegistro")
    search_fields =  ("id","tiposTarifaProducto","homologado","grupoQx","smldv","cruento", "fechaRegistro")
    # Filtrar
    list_filter = ("id", "tiposTarifaProducto","homologado","grupoQx","smldv", "cruento","fechaRegistro")

@admin.register(TablaHonorariosIss)
class tablaHonorariosIssAdmin(admin.ModelAdmin):
    list_display = ("id","tiposTarifaProducto","tiposHonorarios","homologado","valorUvr" ,"fechaRegistro")
    search_fields =  ("id","tiposTarifaProducto","tiposHonorarios","homologado","valorUvr", "fechaRegistro")
    # Filtrar
    list_filter = ("id", "tiposTarifaProducto","tiposHonorarios","homologado","valorUvr", "fechaRegistro")

@admin.register(TablaSalasDeCirugiaIss)
class tablaSalasDeCirugiaIss(admin.ModelAdmin):
    list_display = ("id", "tiposSala", "homologado","desdeUvr","hastaUvr", "valor", "fechaRegistro")
    search_fields =  ("id","tiposSala","homologado","desdeUvr","hastaUvr", "valor", "fechaRegistro")
    # Filtrar
    list_filter = ("id", "tiposSala","homologado","desdeUvr","hastaUvr", "valor", "fechaRegistro")

@admin.register(TablaMaterialSuturaCuracionIss)
class tablaMaterialSuturaCuracionIss(admin.ModelAdmin):
    list_display = ("id", "tiposSala", "homologado","desdeUvr","hastaUvr", "valor", "fechaRegistro")
    search_fields =  ("id","tiposSala","homologado","desdeUvr","hastaUvr", "valor", "fechaRegistro")
    # Filtrar
    list_filter = ("id", "tiposSala","homologado","desdeUvr","hastaUvr", "valor", "fechaRegistro")
