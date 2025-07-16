from django.db import models
from django.utils.timezone import now

# Create your models here.


class FormasPagos(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=30, null=False)     

    def __str__(self):
        return self.nombre

class TiposPagos(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=30, null=False)     

    def __str__(self):
        return self.nombre

class Pagos(models.Model):

    id = models.AutoField(primary_key=True)
    fecha = models.DateTimeField(editable=True, null=True, blank=True)
    serviciosAdministrativos = models.ForeignKey('sitios.ServiciosAdministrativos', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='seradm05')
    tipoDoc = models.ForeignKey('usuarios.TiposDocumento', blank=True,null= True, editable=True, on_delete=models.PROTECT)
    documento = models.ForeignKey('usuarios.Usuarios',blank=True,null= True, editable=True, on_delete=models.PROTECT,  related_name='Documento77')
    consec    = models.IntegerField()
    tipoPago = models.ForeignKey('cartera.TiposPagos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
    formaPago = models.ForeignKey('cartera.FormasPagos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
    valor = models.DecimalField( max_digits=20, decimal_places=2)
    descripcion = models.CharField(max_length=200, null=False)
    totalAplicado = models.DecimalField( max_digits=20, decimal_places=2 , blank=True, null=True, editable=True , default=0.0)
    valorEnCurso = models.DecimalField( max_digits=20, decimal_places=2 , blank=True, null=True, editable=True , default=0.0)
    saldo = models.DecimalField( max_digits=20, decimal_places=2, default=0.0)
    convenio = models.ForeignKey('contratacion.Convenios', blank=True,null= True, editable=True, on_delete=models.PROTECT)
    #facturaAplicada  =  models.ForeignKey('facturacion.facturacion',blank=True,null= True, editable=True, on_delete=models.PROTECT)
    fechaRegistro = models.DateTimeField(default=now, blank=True, null=True, editable=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False)

    def __str__(self):
        return self.descripcion

class PagosFacturas(models.Model):

    id = models.AutoField(primary_key=True)
    serviciosAdministrativos = models.ForeignKey('sitios.ServiciosAdministrativos', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='seradm06')
    pago = models.ForeignKey('cartera.Pagos', blank=True,null= True, editable=True, on_delete=models.PROTECT)
    facturaAplicada  =  models.ForeignKey('facturacion.facturacion',blank=True,null= True, editable=True, on_delete=models.PROTECT)
    valorAplicado = models.DecimalField( max_digits=20, decimal_places=2)
    fechaRegistro = models.DateTimeField(default=now, blank=True, null=True, editable=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False)

    def __str__(self):
        return self.facturaAplicada


class TiposGlosas(models.Model):
    id = models.AutoField(primary_key=True)
    #codigo = models.CharField(max_length=30, null=False)     
    nombre = models.CharField(max_length=30, null=False)     

    def __str__(self):
        return self.nombre

class GlosasConceptoGeneral(models.Model):
    id = models.AutoField(primary_key=True)
    codigo = models.CharField(max_length=2, null=False)     
    nombre = models.CharField(max_length=1000, null=False)     
    def __str__(self):
        return self.nombre


class GlosasConceptoEspecifico(models.Model):
    id = models.AutoField(primary_key=True)
    conceptoGeneral = models.ForeignKey('cartera.GlosasConceptoGeneral', default=1, on_delete=models.PROTECT, null=True)
    codigo = models.CharField(max_length=2, null=False)     
    nombre = models.CharField(max_length=1000, null=False)     

    def __str__(self):
        return self.nombre



class MotivosGlosas(models.Model):
    id = models.AutoField(primary_key=True)
    conceptoGeneral = models.ForeignKey('cartera.GlosasConceptoGeneral', default=1, on_delete=models.PROTECT, null=True)
    conceptoEspecifico = models.ForeignKey('cartera.GlosasConceptoEspecifico', default=1, on_delete=models.PROTECT, null=True)
    conceptoDeAplicacion = models.CharField(max_length=2, null=True) 
    conceptoGlosa = models.CharField(max_length=6, null=True) 
    nombre = models.CharField(max_length=50, null=False)     
    descripcion = models.CharField(max_length=600, null=True)     

    def __str__(self):
        return self.conceptoGlosa

class Radicaciones(models.Model):
    id = models.AutoField(primary_key=True)
    sedesClinica = models.ForeignKey('sitios.SedesClinica', blank=True,null= True, editable=True, on_delete=models.PROTECT, related_name = 'SedesClinica762')
    serviciosAdministrativos = models.ForeignKey('sitios.ServiciosAdministrativos', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='seradm08')
    fecha = models.DateTimeField(editable=True, null=True, blank=True)
    remision= models.CharField(max_length=20, null=False)
    radicacion= models.CharField(max_length=20, null=False)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', default=1, on_delete=models.PROTECT, null=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False)

    def __str__(self):
        return self.radicacion


class Remisiones(models.Model):
    id = models.AutoField(primary_key=True)
    sedesClinica = models.ForeignKey('sitios.SedesClinica', blank=True,null= True, editable=True, on_delete=models.PROTECT, related_name = 'SedesClinica763')
    fecha = models.DateTimeField(editable=True, null=True, blank=True)
    remision= models.CharField(max_length=20, null=False)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', default=1, on_delete=models.PROTECT, null=True)
    estadoReg = models.CharField(max_length=1, default='A', editable=False)

    def __str__(self):
        return self.remision

class TiposNotas (models.Model):

   id = models.AutoField(primary_key=True)
   codigo = models.CharField(max_length=2, blank=True,null= True, editable=True)
   nombre =   models.CharField(max_length=80, blank=True,null= True, editable=True)

   def __str__(self):
        return self.nombre

class EstadosGlosas (models.Model):

   id = models.AutoField(primary_key=True)
   #codigo = models.CharField(max_length=2, blank=True,null= True, editable=True)
   tipo  = models.CharField(max_length=10, blank=True,null= True, editable=True)
   nombre =   models.CharField(max_length=80, blank=True,null= True, editable=True)

   def __str__(self):
        return self.nombre


class Glosas(models.Model):
    id = models.AutoField(primary_key=True)
    sedesClinica = models.ForeignKey('sitios.SedesClinica', blank=True,null= True, editable=True, on_delete=models.PROTECT, related_name = 'SedesClinica764')
    serviciosAdministrativos = models.ForeignKey('sitios.ServiciosAdministrativos', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='seradm10')
    convenio = models.ForeignKey('contratacion.Convenios',blank=True,null= True, editable=True, on_delete=models.PROTECT)
    ripsEnvio =  models.ForeignKey('rips.RipsEnvios',blank=True,null= True, editable=True, on_delete=models.PROTECT )
    fechaRecepcion = models.DateTimeField(editable=True, null=True, blank=True)
    tipoGlosa = models.ForeignKey('cartera.TiposGlosas',blank=True,null= True, editable=True, on_delete=models.PROTECT ,  related_name='estadoGlosa01')
    factura = models.ForeignKey('facturacion.Facturacion',blank=True,null= True, editable=True, on_delete=models.PROTECT ,  related_name='facturacion102')
    saldoFactura =  models.DecimalField( max_digits=15, decimal_places=2)
    valorGlosa =  models.DecimalField( max_digits=15, decimal_places=2, default=0)
    totalGlosa =  models.DecimalField( max_digits=15, decimal_places=2, default=0)
    totalSoportado =  models.DecimalField( max_digits=15, decimal_places=2)
    totalAceptado =  models.DecimalField( max_digits=15, decimal_places=2)
    totalNotasCredito =  models.DecimalField( max_digits=15, decimal_places=2, default=0)
    observaciones = models.CharField(max_length=120, blank=True,null= True, editable=True)
    estadoRecepcion = models.ForeignKey('cartera.EstadosGlosas',blank=True,null= True, editable=True, on_delete=models.PROTECT ,  related_name='estadoGlosa01')
    estadoRadicacion = models.ForeignKey('cartera.EstadosGlosas',blank=True,null= True, editable=True, on_delete=models.PROTECT ,  related_name='estadoGloas02')
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    fechaRespuesta = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRespuesta = models.ForeignKey('planta.Planta', default=1, on_delete=models.PROTECT, null=True  ,  related_name='respuesta01')
    usuarioRecepcion = models.ForeignKey('planta.Planta', default=1, on_delete=models.PROTECT, null=True  ,  related_name='recepcion01')
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', default=1, on_delete=models.PROTECT, null=True ,  related_name='usuario987')
    estadoReg = models.CharField(max_length=1, default='A', editable=False)

    def __str__(self):
        return self.observaciones

class GlosasDetalle(models.Model):
    id = models.AutoField(primary_key=True)
    glosa = models.ForeignKey('cartera.Glosas',blank=True,null= True, editable=True, on_delete=models.PROTECT )
    itemFactura =  models.IntegerField(editable=True, null=True, blank=True)
    ripsDetalle =  models.ForeignKey('rips.RipsDetalle',blank=True,null= True, editable=True, on_delete=models.PROTECT )
    ripsTipos =  models.ForeignKey('rips.RipsTipos', blank=True, null=True, editable=True, on_delete=models.PROTECT , related_name='RpsTipos10')   
    itemRips =  models.IntegerField(editable=True, null=True, blank=True)
    ripsId    =  models.IntegerField(editable=True, null=True, blank=True)
    motivoGlosa = models.ForeignKey('cartera.MotivosGlosas',blank=True,null= True, editable=True, on_delete=models.PROTECT )
    valorServicio = models.DecimalField( max_digits=15, decimal_places=2)
    valorGlosa = models.DecimalField( max_digits=15, decimal_places=2)
    totalSoportado =  models.DecimalField( max_digits=15, decimal_places=2)
    totalAceptado =  models.DecimalField( max_digits=15, decimal_places=2)
    observaciones = models.CharField(max_length=120, blank=True,null= True, editable=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', default=1, on_delete=models.PROTECT, null=True ,  related_name='usuario799')
    estadoReg = models.CharField(max_length=1, default='A', editable=False)

    def __integer__(self):
        return self.observaciones

class NotasCredito(models.Model):

    id = models.AutoField(primary_key=True)
    sedesClinica = models.ForeignKey('sitios.SedesClinica', blank=True,null= True, editable=True, on_delete=models.PROTECT, related_name = 'SedesClinica765')	
    serviciosAdministrativos = models.ForeignKey('sitios.ServiciosAdministrativos', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='seradm11')
    empresa = models.ForeignKey('facturacion.Empresas',blank=True,null= True, editable=True, on_delete=models.PROTECT)
    fechaNota = models.DateTimeField(editable=True, null=True, blank=True)
    factura = models.ForeignKey('facturacion.Facturacion',blank=True,null= True, editable=True, on_delete=models.PROTECT ,  related_name='facturacion103')
    itemFactura =  models.IntegerField(editable=True, null=True, blank=True)
    ripsDetalle =  models.ForeignKey('rips.RipsDetalle',blank=True,null= True, editable=True, on_delete=models.PROTECT )
    ripsTipos =  models.ForeignKey('rips.RipsTipos', blank=True, null=True, editable=True, on_delete=models.PROTECT , related_name='RpsTipos11')   
    ripsId    =  models.IntegerField(editable=True, null=True, blank=True)
    valorNota =  models.DecimalField( max_digits=15, decimal_places=2)
    cufeDef =  models.CharField(max_length=5000, default='A', editable=False)
    cufeVr =  models.CharField(max_length=5000, default='A', editable=False)
    codQr=  models.CharField(max_length=5000, default='A', editable=False)
    rutaQr = models.CharField(max_length=5000, default='A', editable=False)
    rutaRaiz = models.CharField(max_length=5000, default='A', editable=False)
    nomArchivo = models.CharField(max_length=5000, default='A', editable=False)
    rutaXml = models.CharField(max_length=5000, default='A', editable=False)
    rutaXmlFirmado = models.CharField(max_length=5000, default='A', editable=False)
    rutaZip = models.CharField(max_length=5000, default='A', editable=False)
    trackId =models.CharField(max_length=5000, default='A', editable=False)
    rutaXmlRespuesta = models.CharField(max_length=5000, default='A', editable=False)
    estado = models.CharField(max_length=5000, default='A', editable=False)
    codDian = models.CharField(max_length=5000, default='A', editable=False)
    prefijo = models.CharField(max_length=5000, default='A', editable=False)
    descripcion = models.CharField(max_length=5000, default='A', editable=False)
    estadoDian = models.CharField(max_length=5000, default='A', editable=False)
    mensajeDian = models.CharField(max_length=5000, default='A', editable=False)
    fechaEnvioDian = models.DateTimeField(editable=True, null=True, blank=True)
    conceptoCorreccion = models.DateTimeField(editable=True, null=True, blank=True)
    descConceptoCorreccion = models.DateTimeField(editable=True, null=True, blank=True)
    rutaPdf = models.DateTimeField(editable=True, null=True, blank=True)
    rutaAd = models.DateTimeField(editable=True, null=True, blank=True)
    notificacionAdministrativa = models.DateTimeField(editable=True, null=True, blank=True)
    codigoZip = models.IntegerField(editable=True, null=True, blank=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', default=1, on_delete=models.PROTECT, null=True ,  related_name='usuario798')
    estadoReg = models.CharField(max_length=1, default='A', editable=False)


    def __str__(self):
        return self.descripcion


class NotasDebito(models.Model):

    id = models.AutoField(primary_key=True)
    sedesClinica = models.ForeignKey('sitios.SedesClinica', blank=True,null= True, editable=True, on_delete=models.PROTECT, related_name = 'SedesClinica760')	
    serviciosAdministrativos = models.ForeignKey('sitios.ServiciosAdministrativos', blank=True,null= True, editable=True,  on_delete=models.PROTECT,   related_name='seradm12')
    empresa = models.ForeignKey('facturacion.Empresas',blank=True,null= True, editable=True, on_delete=models.PROTECT)
    fechaNota = models.DateTimeField(editable=True, null=True, blank=True)
    factura = models.ForeignKey('facturacion.Facturacion',blank=True,null= True, editable=True, on_delete=models.PROTECT ,  related_name='facturacion07')
    itemFactura =  models.IntegerField(editable=True, null=True, blank=True)
    ripsDetalle =  models.ForeignKey('rips.RipsDetalle',blank=True,null= True, editable=True, on_delete=models.PROTECT )
    ripsTipos =  models.ForeignKey('rips.RipsTipos', blank=True, null=True, editable=True, on_delete=models.PROTECT , related_name='RpsTipos12')   
    ripsId    =  models.IntegerField(editable=True, null=True, blank=True)
    valorNota =  models.DecimalField( max_digits=15, decimal_places=2)
    cufeDef =  models.CharField(max_length=5000, default='A', editable=False)
    cufeVr =  models.CharField(max_length=5000, default='A', editable=False)
    codQr=  models.CharField(max_length=5000, default='A', editable=False)
    rutaQr = models.CharField(max_length=5000, default='A', editable=False)
    rutaRaiz = models.CharField(max_length=5000, default='A', editable=False)
    nomArchivo = models.CharField(max_length=5000, default='A', editable=False)
    rutaXml = models.CharField(max_length=5000, default='A', editable=False)
    rutaXmlFirmado = models.CharField(max_length=5000, default='A', editable=False)
    rutaZip = models.CharField(max_length=5000, default='A', editable=False)
    trackId =models.CharField(max_length=5000, default='A', editable=False)
    rutaXmlRespuesta = models.CharField(max_length=5000, default='A', editable=False)
    estado = models.CharField(max_length=5000, default='A', editable=False)
    codDian = models.CharField(max_length=5000, default='A', editable=False)
    prefijo = models.CharField(max_length=5000, default='A', editable=False)
    descripcion = models.CharField(max_length=5000, default='A', editable=False)
    estadoDian = models.CharField(max_length=5000, default='A', editable=False)
    mensajeDian = models.CharField(max_length=5000, default='A', editable=False)
    fechaEnvioDian = models.DateTimeField(editable=True, null=True, blank=True)
    conceptoCorreccion = models.DateTimeField(editable=True, null=True, blank=True)
    descConceptoCorreccion = models.DateTimeField(editable=True, null=True, blank=True)
    rutaPdf = models.DateTimeField(editable=True, null=True, blank=True)
    rutaAd = models.DateTimeField(editable=True, null=True, blank=True)
    notificacionAdministrativa = models.DateTimeField(editable=True, null=True, blank=True)
    codigoZip = models.IntegerField(editable=True, null=True, blank=True)
    fechaRegistro = models.DateTimeField(editable=True, null=True, blank=True)
    usuarioRegistro = models.ForeignKey('planta.Planta', default=1, on_delete=models.PROTECT, null=True ,  related_name='usuario797')
    estadoReg = models.CharField(max_length=1, default='A', editable=False)


    def __str__(self):
        return self.descripcion

