from django.db import models

# Create your models here.

class Farmacia(models.Model):
    id = models.AutoField(primary_key=True)
    sedesClinica = models.ForeignKey('sitios.SedesClinica',   blank=True,null= True, on_delete=models.PROTECT ,related_name ='sedesClinica390')
    historia = models.ForeignKey('clinico.Historia', on_delete=models.PROTECT, blank=True, null=True,  editable=True,  related_name='HistoriaFarmacia01')
    serviciosAdministrativos = models.ForeignKey('sitios.ServiciosAdministrativos', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='servAdmFarm01')
    tipoOrigen = models.ForeignKey('enfermeria.EnfermeriaTipoOrigen', on_delete=models.PROTECT, blank=True, null=True,  editable=True,  related_name='TipoEnfermeria04')
    tipoMovimiento = models.ForeignKey('enfermeria.EnfermeriaTipoMovimiento', on_delete=models.PROTECT, blank=True, null=True,  editable=True,  related_name='TipoEnfermeria05')
    estado = models.ForeignKey('farmacia.FarmaciaEstados', on_delete=models.PROTECT, blank=True, null=True,  editable=True,  related_name='Farmaciaestados01')
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True, on_delete=models.PROTECT   , related_name='Planta3450')
    estadoReg = models.CharField(max_length=1, default='A', editable=False,  blank=True, null=True,)

    def __str__(self):
        return str(self.id)

class FarmaciaDetalle(models.Model):
    id = models.AutoField(primary_key=True)
    farmacia = models.ForeignKey('farmacia.Farmacia', on_delete=models.PROTECT, blank=True, null=True,  editable=True,  related_name='Farmacia01')
    historiaMedicamentos = models.ForeignKey('clinico.HistoriaMedicamentos', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='servAdmFarm01')
    suministro = models.ForeignKey('facturacion.Suministros', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    dosisCantidad = models.DecimalField(max_digits=20, decimal_places=3)
    dosisUnidad = models.ForeignKey('clinico.UnidadesDeMedidaDosis', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    viaAdministracion = models.ForeignKey('clinico.ViasAdministracion', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    frecuencia = models.ForeignKey('clinico.FrecuenciasAplicacion', blank=True, null=True, editable=True,               on_delete=models.PROTECT)
    cantidadOrdenada = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True, editable=True)
    diasTratamiento =  models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True, on_delete=models.PROTECT   , related_name='Planta3451')
    estadoReg = models.CharField(max_length=1, default='A', editable=False,  blank=True, null=True,)

    def __str__(self):
        return str(self.id)

class FarmaciaDespachos(models.Model):

    id = models.AutoField(primary_key=True)
    serviciosAdministrativos = models.ForeignKey('sitios.ServiciosAdministrativos', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='servAdmFarm02')
    farmacia = models.ForeignKey('farmacia.Farmacia', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='FarmaDespacho02')
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True, on_delete=models.PROTECT   , related_name='Planta3452')
    estadoReg = models.CharField(max_length=1, default='A', editable=False,  blank=True, null=True,)

    def __str__(self):
        return str(self.id)


class FarmaciaDespachosDispensa(models.Model):
    id = models.AutoField(primary_key=True)
    farmaciaDetalle = models.ForeignKey('farmacia.FarmaciaDetalle', on_delete=models.PROTECT, blank=True, null=True,  editable=True,  related_name='FarmaciaDetalle01')
    despacho = models.ForeignKey('farmacia.FarmaciaDespachos', on_delete=models.PROTECT, blank=True, null=True,  editable=True,  related_name='FarmaciaDespachos01')
    item = models.CharField(max_length=5, blank=True, null=True)
    suministro = models.ForeignKey('facturacion.Suministros', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    dosisCantidad = models.DecimalField(max_digits=20, decimal_places=3)
    dosisUnidad = models.ForeignKey('clinico.UnidadesDeMedidaDosis', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    viaAdministracion = models.ForeignKey('clinico.ViasAdministracion', blank=True, null=True, editable=True,   on_delete=models.PROTECT)
    frecuencia = models.ForeignKey('clinico.FrecuenciasAplicacion', blank=True, null=True, editable=True,               on_delete=models.PROTECT)
    cantidadOrdenada = models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True, editable=True)
    diasTratamiento =  models.DecimalField(max_digits=10, decimal_places=0, blank=True, null=True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True, on_delete=models.PROTECT   , related_name='PlantaFarmacia3453')
    estadoReg = models.CharField(max_length=1, default='A', editable=False,  blank=True, null=True,)

    def __str__(self):
        return str(self.id)

class FarmaciaEstados(models.Model):
    id = models.AutoField(primary_key=True)
    nombre =  models.CharField(max_length=50, default='A', editable=True,  blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', blank=True, null=True, editable=True, on_delete=models.PROTECT   , related_name='Planta3459')
    estadoReg = models.CharField(max_length=1, default='A', editable=False,  blank=True, null=True,)

    def __str__(self):
        return str(self.nombre)
