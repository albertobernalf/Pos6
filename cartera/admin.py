from django.contrib import admin

# Register your models here.

from cartera.models import FormasPagos, TiposPagos,Pagos,TiposGlosas,MotivosGlosas, Radicaciones, Remisiones, TiposNotas, EstadosGlosas, GlosasConceptoGeneral, GlosasConceptoEspecifico

@admin.register(FormasPagos)
class formasPagosAdmin(admin.ModelAdmin):
    list_display = ("id", "nombre")
    search_fields = ("id", "nombre")
    # Filtrar
    list_filter = ('nombre',)


@admin.register(TiposPagos)
class tiposPagosAdmin(admin.ModelAdmin):
    list_display = ("id", "nombre")
    search_fields = ("id", "nombre")
    # Filtrar
    list_filter = ('nombre',)


@admin.register(Pagos)
class pagosAdmin(admin.ModelAdmin):
    list_display = ("id", "fecha", "documento", "tipoPago","formaPago")
    search_fields = ("id", "fecha", "documento", "tipoPago","formaPago")
    # Filtrar
    list_filter = ("id", "fecha", "documento", "tipoPago","formaPago")

@admin.register(TiposGlosas)
class tiposGlosasAdmin(admin.ModelAdmin):
    list_display = ("id", "nombre")
    search_fields = ("id", "nombre")
    # Filtrar
    list_filter = ("id", "nombre")

@admin.register(EstadosGlosas)
class estadosGlosasAdmin(admin.ModelAdmin):
    list_display = ("id",  "tipo", "nombre")
    search_fields = ("id",  "tipo", "nombre")
    # Filtrar
    list_filter = ("id",  "tipo", "nombre")


@admin.register(GlosasConceptoGeneral)
class glosasConceptoGeneralAdmin(admin.ModelAdmin):
    list_display = ("id",  "codigo", "nombre")
    search_fields = ("id",  "codigo", "nombre")
    # Filtrar
    list_filter = ("id",  "codigo", "nombre")



@admin.register(GlosasConceptoEspecifico)
class glosasConceptoEspecificoAdmin(admin.ModelAdmin):
    list_display = ("id", "conceptoGeneral", "codigo", "nombre")
    search_fields = ("id", "conceptoGeneral", "codigo", "nombre")
    # Filtrar
    list_filter = ("id", "conceptoGeneral",  "codigo", "nombre")



@admin.register(MotivosGlosas)
class motivosGlosasAdmin(admin.ModelAdmin):
    list_display = ("id","conceptoGeneral", "conceptoEspecifico",  "conceptoGlosa", "nombre","descripcion")
    search_fields = ("id","conceptoGeneral", "conceptoEspecifico","conceptoGlosa", "nombre","descripcion")
    # Filtrar
    list_filter = ("id", "conceptoGeneral", "conceptoEspecifico","conceptoGlosa", "nombre","descripcion")



@admin.register(Radicaciones)
class radicacionesAdmin(admin.ModelAdmin):
    list_display = ("id", "fecha", "radicacion")
    search_fields = ("id","fecha", "radicacion")
    # Filtrar
    list_filter = ("id", "fecha","radicacion")



@admin.register(Remisiones)
class remisionesAdmin(admin.ModelAdmin):
    list_display = ("id", "fecha","remision")
    search_fields = ("id", "fecha","remision")
    # Filtrar
    list_filter = ("id", "fecha","remision")


@admin.register(TiposNotas)
class tiposNotasAdmin(admin.ModelAdmin):
    list_display = ("id", "nombre")
    search_fields = ("id", "nombre")
    # Filtrar
    list_filter = ('nombre',)
