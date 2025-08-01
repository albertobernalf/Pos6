# Generated by Django 2.1.15 on 2025-07-25 11:35

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('sitios', '0023_salas_tiposala'),
        ('planta', '0010_remove_planta_serviciosadministrativos'),
        ('farmacia', '0014_auto_20250725_1048'),
    ]

    operations = [
        migrations.CreateModel(
            name='FarmaciaDevolucion',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('observaciones', models.CharField(blank=True, max_length=250)),
                ('fechaRegistro', models.DateTimeField(blank=True, null=True)),
                ('estadoReg', models.CharField(blank=True, default='A', editable=False, max_length=1, null=True)),
                ('sedesClinica', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='sedesClinica39022', to='sitios.SedesClinica')),
                ('serviciosAdministrativosDevuelve', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='servDevuelve331', to='sitios.ServiciosAdministrativos')),
                ('serviciosAdministrativosRecibe', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='servRecibe3231', to='sitios.ServiciosAdministrativos')),
                ('usuarioDevuelve', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='PlantaDevuelve453', to='planta.Planta')),
                ('usuarioRecibe', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='PlantaRecibe453', to='planta.Planta')),
                ('usuarioRegistro', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='PlantaFarmaciaDev3453', to='planta.Planta')),
            ],
        ),
        migrations.CreateModel(
            name='FarmaciaDevolucionDetalle',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('cantidadDevuelta', models.DecimalField(blank=True, decimal_places=0, max_digits=10, null=True)),
                ('fechaRegistro', models.DateTimeField(blank=True, null=True)),
                ('estadoReg', models.CharField(blank=True, default='A', editable=False, max_length=1, null=True)),
            ],
        ),
        migrations.AlterField(
            model_name='farmaciadespachosdispensa',
            name='usuarioRegistro',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='PlantaFarmacia2253', to='planta.Planta'),
        ),
        migrations.AddField(
            model_name='farmaciadevoluciondetalle',
            name='farmaciaDespachosDispensa',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='FarmaciaDespachos21201', to='farmacia.FarmaciaDespachosDispensa'),
        ),
        migrations.AddField(
            model_name='farmaciadevoluciondetalle',
            name='farmaciaDevolucion',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='FarmaciaDevolucion01', to='farmacia.FarmaciaDevolucion'),
        ),
        migrations.AddField(
            model_name='farmaciadevoluciondetalle',
            name='usuarioRegistro',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='PlantaFarmaciaDevDet3453', to='planta.Planta'),
        ),
    ]
