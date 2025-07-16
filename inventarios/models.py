from django.db import models

# Create your models here.

from django.utils.timezone import now


from smart_selects.db_fields import GroupedForeignKey
from smart_selects.db_fields import ChainedForeignKey
#from django.db.models import UniqueConstraint


class Kardex(models.Model):
    id = models.AutoField(primary_key=True)
    sedesClinica = models.ForeignKey('sitios.SedesClinica', blank=True,null= True, editable=True, on_delete=models.PROTECT)
    bodegas = models.ForeignKey('sitios.Bodegas', blank=True,null= True, editable=True, on_delete=models.PROTECT)
    suministros = models.ForeignKey('facturacion.Suministros', blank=True,null= True, editable=True, on_delete=models.PROTECT)
    cantidadEntrada =  models.DecimalField( max_digits=15, decimal_places=2 , blank=True,null= True, editable=True)
    cantidadSalida =  models.DecimalField( max_digits=15, decimal_places=2 , blank=True,null= True, editable=True)
    valorEntrada =  models.DecimalField( max_digits=15, decimal_places=2 , blank=True,null= True, editable=True)
    valorSalida =  models.DecimalField( max_digits=15, decimal_places=2 , blank=True,null= True, editable=True)
    fechaRegistro = models.DateTimeField(default=now, editable=False)
    estadoReg = models.CharField(max_length=1, default='A', editable=False)

    def __str__(self):
        return self.suministros


class Movimientos(models.Model):
     E = 'ENTRADA'
     S = 'SALIDA'
     TIPO_CHOICES = (
        ('E', 'ENTRADA'),
        ('S', 'SALIDA'),
     )
     id = models.AutoField(primary_key=True)
     sedesClinica = models.ForeignKey('sitios.SedesClinica', blank=True,null= True, editable=True, on_delete=models.PROTECT)
     tipo =   models.CharField(max_length=20,  blank=True, null=True, editable=True, choices = TIPO_CHOICES)
     bodegasEntrada  = models.ForeignKey('sitios.Bodegas', blank=True,null= True, editable=True, on_delete=models.PROTECT, related_name='Bode01')
     bodegasSalida  = models.ForeignKey('sitios.Bodegas', blank=True,null= True, editable=True, on_delete=models.PROTECT, related_name='Bode02')
     suministros = models.ForeignKey('facturacion.Suministros', blank=True,null= True, editable=True, on_delete=models.PROTECT)
     cantidad =  models.DecimalField( max_digits=15, decimal_places=2 , blank=True,null= True, editable=True)
     valor =  models.DecimalField( max_digits=15, decimal_places=2 , blank=True,null= True, editable=True)
     fechaRegistro = models.DateTimeField(default=now, editable=False)
     estadoReg = models.CharField(max_length=1, default='A', editable=False)

     def __str__(self):
        return self.nombre

class TiposDocumentos(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=50)
    fechaRegistro = models.DateTimeField(default=now, editable=False)
    estadoReg = models.CharField(max_length=1, default='A', editable=False)


    def __str__(self):
        return self.nombre
