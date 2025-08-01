# Generated by Django 2.1.15 on 2025-07-03 17:03

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('sitios', '0023_salas_tiposala'),
        ('clinico', '0123_auto_20250519_1153'),
        ('facturacion', '0085_auto_20250519_1543'),
        ('farmacia', '0002_auto_20250703_1703'),
        ('planta', '0010_remove_planta_serviciosadministrativos'),
        ('enfermeria', '0013_historiaexamenes'),
    ]

    operations = [
        migrations.CreateModel(
            name='Enfermeria',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('tipoOrden', models.CharField(blank=True, default='C', editable=False, max_length=1, null=True)),
                ('tipoMovimiento', models.CharField(blank=True, default='F', editable=False, max_length=1, null=True)),
                ('fechaRegistro', models.DateTimeField(blank=True, null=True)),
                ('estadoReg', models.CharField(blank=True, default='A', editable=False, max_length=1, null=True)),
                ('historia', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='HistoriaEnfermeria01', to='clinico.Historia')),
                ('serviciosAdministrativos', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='servAdmEnfermeria101', to='sitios.ServiciosAdministrativos')),
                ('usuarioRegistro', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='Planta3460', to='planta.Planta')),
            ],
        ),
        migrations.CreateModel(
            name='EnfermeriaDetalle',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('dosisCantidad', models.DecimalField(decimal_places=3, max_digits=20)),
                ('cantidadOrdenada', models.DecimalField(blank=True, decimal_places=0, max_digits=10, null=True)),
                ('diasTratamiento', models.DecimalField(blank=True, decimal_places=0, max_digits=10, null=True)),
                ('fechaRegistro', models.DateTimeField(blank=True, null=True)),
                ('estadoReg', models.CharField(blank=True, default='A', editable=False, max_length=1, null=True)),
                ('dosisUnidad', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='clinico.UnidadesDeMedidaDosis')),
                ('enfermeria', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='Enfermeria01', to='enfermeria.Enfermeria')),
                ('frecuencia', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='clinico.FrecuenciasAplicacion')),
                ('historiaMedicamentos', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='servAdmEnfermeria102', to='clinico.HistoriaMedicamentos')),
                ('suministro', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='facturacion.Suministros')),
                ('usuarioRegistro', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='Planta3462', to='planta.Planta')),
                ('viaAdministracion', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='clinico.ViasAdministracion')),
            ],
        ),
        migrations.CreateModel(
            name='EnfermeriaPlaneacion',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('consecutivo', models.IntegerField(default=0)),
                ('desdeFecha', models.DateTimeField(blank=True, null=True)),
                ('hastaFecha', models.DateTimeField(blank=True, null=True)),
                ('dosisCantidad', models.DecimalField(decimal_places=3, max_digits=20)),
                ('cantidadDispensada', models.DecimalField(blank=True, decimal_places=0, max_digits=10, null=True)),
                ('cantidadPlaneada', models.DecimalField(blank=True, decimal_places=0, max_digits=10, null=True)),
                ('cantidadAplicada', models.DecimalField(blank=True, decimal_places=0, max_digits=10, null=True)),
                ('diasTratamiento', models.DecimalField(blank=True, decimal_places=0, max_digits=10, null=True)),
                ('fechaRegistro', models.DateTimeField(blank=True, null=True)),
                ('estadoReg', models.CharField(blank=True, default='A', editable=False, max_length=1, null=True)),
                ('dosisUnidad', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='clinico.UnidadesDeMedidaDosis')),
                ('enfermeraAplica', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='PlantaEnfermera3468', to='planta.Planta')),
                ('enfermeraPlanea', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='PlantaEnfermeraPlanea3468', to='planta.Planta')),
                ('enfermeriaDetalle', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='EnfermeriaDetalle1102', to='enfermeria.EnfermeriaDetalle')),
                ('frecuencia', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='clinico.FrecuenciasAplicacion')),
                ('suministro', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='facturacion.Suministros')),
                ('turnoEnfermeria', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='enfermeria.TurnosEnfermeria')),
                ('usuarioRegistro', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='Planta3488', to='planta.Planta')),
                ('viaAdministracion', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='clinico.ViasAdministracion')),
            ],
        ),
        migrations.CreateModel(
            name='EnfermeriaRecibe',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('dosisCantidad', models.DecimalField(decimal_places=3, max_digits=20)),
                ('cantidadDispensada', models.DecimalField(blank=True, decimal_places=0, max_digits=10, null=True)),
                ('diasTratamiento', models.DecimalField(blank=True, decimal_places=0, max_digits=10, null=True)),
                ('fechaRegistro', models.DateTimeField(blank=True, null=True)),
                ('estadoReg', models.CharField(blank=True, default='A', editable=False, max_length=1, null=True)),
                ('despacho', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='EnfermeriaDespachos01', to='farmacia.Despachos')),
                ('dosisUnidad', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='clinico.UnidadesDeMedidaDosis')),
                ('enfermeriaDetalle', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='EnfermeriaDetalle1101', to='enfermeria.EnfermeriaDetalle')),
                ('frecuencia', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='clinico.FrecuenciasAplicacion')),
                ('suministro', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='facturacion.Suministros')),
                ('usuarioRegistro', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='Planta3478', to='planta.Planta')),
                ('viaAdministracion', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='clinico.ViasAdministracion')),
            ],
        ),
    ]
