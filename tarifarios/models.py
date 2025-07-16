from django.db import models

# Create your models here.

class TiposTarifaProducto (models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=30, blank=True, null=True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False )

    def __str__(self):
        return str(self.nombre)

class TiposTarifa (models.Model):
    id = models.AutoField(primary_key=True)
    tiposTarifaProducto = models.ForeignKey('tarifarios.TiposTarifaProducto', blank=True,null= True, editable=True, on_delete=models.PROTECT , related_name='TipoTarifa11')
    nombre = models.CharField(max_length=30, blank=True, null=True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False )

    def __str__(self):
        return str(self.nombre + ' ' + str(self.tiposTarifaProducto))

class TiposHonorarios(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=30, blank=True, null=True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False )

    def __str__(self):
        return str(self.nombre)


class TarifariosDescripcion (models.Model):
    id = models.AutoField(primary_key=True)
    serviciosAdministrativos = models.ForeignKey('sitios.ServiciosAdministrativos', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='seradm30')
    tiposTarifa = models.ForeignKey('tarifarios.TiposTarifa', blank=True,null= True, editable=True, on_delete=models.PROTECT , related_name='TipoTarifa11')
    columna =  models.CharField(max_length=15,  blank=True,null= True, editable=True)
    descripcion = models.CharField(max_length=100, blank=True, null=True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False )

    def __str__(self):
        return str(str(self.tiposTarifa) + ' '  + str(self.descripcion))

class TarifariosDescripcionHonorarios (models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=100, blank=True, null=True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False )

    def __str__(self):
         return str(self.nombre)


class TarifariosProcedimientos (models.Model):
    id = models.AutoField(primary_key=True)
    serviciosAdministrativos = models.ForeignKey('sitios.ServiciosAdministrativos', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='seradm31')
    tiposTarifa = models.ForeignKey('tarifarios.TiposTarifa', blank=True,null= True, editable=True, on_delete=models.PROTECT , related_name='TipoTarifa171')
    codigoCups = models.ForeignKey('clinico.Examenes', blank=True,null= True, editable=True, on_delete=models.PROTECT , related_name='Cups10121')
    codigoHomologado = models.CharField(max_length=10, blank=True, null=True, editable=True)
    concepto = models.ForeignKey('facturacion.Conceptos', blank=True,null= True, editable=True, on_delete=models.PROTECT , related_name='Concepto2271')
    colValorBase =  models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor1 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor2 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor3 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor4 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor5 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor6 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor7 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor8 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor9 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor10 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True, on_delete=models.PROTECT , related_name='plantas2020')
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False )

    class Meta:
        unique_together = (('tiposTarifa', 'codigoCups'),)

    class Meta:
        indexes = [
            models.Index(fields=['tiposTarifa','codigoCups'], name='tarifProcedTipostarifaIdx'),
        ]

    def __str__(self):
        return str(self.codigoHomologado)

class TarifariosProcedimientosHonorarios (models.Model):
    id = models.AutoField(primary_key=True)
    serviciosAdministrativos = models.ForeignKey('sitios.ServiciosAdministrativos', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='seradm33')
    tiposTarifa = models.ForeignKey('tarifarios.TiposTarifa', blank=True,null= True, editable=True, on_delete=models.PROTECT , related_name='TipoTarifa1711')
    codigoCups = models.ForeignKey('clinico.Examenes', blank=True,null= True, editable=True, on_delete=models.PROTECT , related_name='Cups101211')
    #tipoHonorario = models.ForeignKey('tarifarios.TiposHonorarios', blank=True,null= True, editable=True, on_delete=models.PROTECT , related_name='TipoHonorario1122')
    codigoHomologado = models.CharField(max_length=10, blank=True, null=True, editable=True)
    concepto = models.ForeignKey('facturacion.Conceptos', blank=True,null= True, editable=True, on_delete=models.PROTECT , related_name='Concepto22714')
    valorHonorarioCirujano =  models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    valorHonorarioAnestesiologo =  models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    valorHonorarioAyudante =  models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    valorHonorarioPerfucionista =  models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    valorHonorarioViaAcceso =  models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    valorHonorarioUnicaVia =  models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    valorHonorarioDobleVia =  models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    #colValorBase =  models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    #colValor1 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    #colValor2 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    #colValor3 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    #colValor4 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    #colValor5 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    #colValor6 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    #colValor7 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    ##colValor8 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    #colValor9 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    #colValor10 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True, on_delete=models.PROTECT , related_name='plantas20205')
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False )

    def __str__(self):
        return str(self.codigoHomologado)





class TarifariosSuministros (models.Model):
    id = models.AutoField(primary_key=True)
    serviciosAdministrativos = models.ForeignKey('sitios.ServiciosAdministrativos', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='seradm34')
    tiposTarifa = models.ForeignKey('tarifarios.TiposTarifa', blank=True,null= True, editable=True, on_delete=models.PROTECT , related_name='TipoTarifa172')
    codigoCum = models.ForeignKey('facturacion.Suministros', blank=True,null= True, editable=True, on_delete=models.PROTECT , related_name='Suministro10121')
    codigoHomologado = models.CharField(max_length=10, blank=True, null=True, editable=True)
    concepto = models.ForeignKey('facturacion.Conceptos', blank=True,null= True, editable=True, on_delete=models.PROTECT , related_name='Concepto22712')
    colValorBase = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor1 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor2 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor3 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor4 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor5 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor6 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor7 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor8 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor9 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    colValor10 = models.DecimalField( max_digits=20, decimal_places=4,blank=True,null= True, editable=True,)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True, on_delete=models.PROTECT , related_name='plantas20202')
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False )

    class Meta:
        unique_together = (('tiposTarifa', 'codigoCum'),)

    class Meta:
        indexes = [
            models.Index(fields=['tiposTarifa','codigoCum'], name='tarifSuministTipostarifaIdx'),
        ]


    def __str__(self):
        return str(self.codigoHomologado)


class GruposQx(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=30, blank=True, null=True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False )

    def __str__(self):
        return str(self.nombre)

class MinimosLegales(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=30, blank=True, null=True, editable=True)
    año = models.CharField(max_length=4, blank=True, null=True, editable=True)
    valor =  models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False )

    def __str__(self):
        return str(self.nombre)

class TablaHonorariosSoat(models.Model):
    id = models.AutoField(primary_key=True)
    tiposTarifaProducto = models.ForeignKey('tarifarios.TiposTarifaProducto', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    tiposHonorarios =  models.ForeignKey('tarifarios.TiposHonorarios', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    homologado = models.CharField(max_length=8,  blank=True, null=True, editable=True)
    grupoQx =  models.ForeignKey('tarifarios.GruposQx', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    smldv = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True,    on_delete=models.PROTECT)
    estadoReg = models.CharField(max_length=1, default='A', editable=False)

    def __str__(self):
        return str(self.id)

class TablaHonorariosIss(models.Model):
    id = models.AutoField(primary_key=True)
    tiposTarifaProducto = models.ForeignKey('tarifarios.TiposTarifaProducto', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    tiposHonorarios =  models.ForeignKey('tarifarios.TiposHonorarios', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    homologado = models.CharField(max_length=8,  blank=True, null=True, editable=True)
    valorUvr = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True,    on_delete=models.PROTECT)
    estadoReg = models.CharField(max_length=1, default='A', editable=False)

    def __str__(self):
        return str(self.id)


class TablaMaterialSuturaCuracion(models.Model):
    id = models.AutoField(primary_key=True)
    tiposTarifaProducto = models.ForeignKey('tarifarios.TiposTarifaProducto', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    homologado = models.CharField(max_length=8,  blank=True, null=True, editable=True)
    grupoQx =  models.ForeignKey('tarifarios.GruposQx', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    smldv = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True, editable=True)
    cruento = models.CharField(max_length=1, blank=True, null=True ,editable=False)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True,    on_delete=models.PROTECT)
    estadoReg = models.CharField(max_length=1, default='A', editable=False)

    def __str__(self):
        return str(self.id)

class TablaMaterialSuturaCuracionIss(models.Model):
    id = models.AutoField(primary_key=True)
    tiposTarifaProducto = models.ForeignKey('tarifarios.TiposTarifaProducto', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    tiposSala = models.ForeignKey('sitios.TiposSalas', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    homologado = models.CharField(max_length=8,  blank=True, null=True, editable=True)
    desdeUvr =  models.CharField(max_length=3,  blank=True, null=True, editable=True)
    hastaUvr = models.CharField(max_length=3,  blank=True, null=True, editable=True)
    valor = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True,    on_delete=models.PROTECT)
    estadoReg = models.CharField(max_length=1, default='A', editable=False)

    def __str__(self):
        return str(self.id)


class TablaSalasDeCirugia(models.Model):
    id = models.AutoField(primary_key=True)
    tiposTarifaProducto = models.ForeignKey('tarifarios.TiposTarifaProducto', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    homologado = models.CharField(max_length=8,  blank=True, null=True, editable=True)
    grupoQx =  models.ForeignKey('tarifarios.GruposQx', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    smldv = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True, editable=True)
    cruento = models.CharField(max_length=1, blank=True, null=True ,editable=False)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True,    on_delete=models.PROTECT)
    estadoReg = models.CharField(max_length=1, default='A', editable=False)

    def __str__(self):
        return str(self.id)

class TablaSalasDeCirugiaIss(models.Model):
    id = models.AutoField(primary_key=True)
    tiposTarifaProducto = models.ForeignKey('tarifarios.TiposTarifaProducto', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    tiposSala = models.ForeignKey('sitios.TiposSalas', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    homologado = models.CharField(max_length=8,  blank=True, null=True, editable=True)
    desdeUvr =  models.CharField(max_length=3,  blank=True, null=True, editable=True)
    hastaUvr = models.CharField(max_length=3,  blank=True, null=True, editable=True)
    valor = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True,    on_delete=models.PROTECT)
    estadoReg = models.CharField(max_length=1, default='A', editable=False)

    def __str__(self):
        return str(self.id)