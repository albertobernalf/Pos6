# Generated by Django 2.1.15 on 2025-07-28 15:40

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('enfermeria', '0038_auto_20250728_1529'),
    ]

    operations = [
        migrations.AlterField(
            model_name='enfermeriadevoluciondetalle',
            name='enfermeriaDevolucion',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='EnfermeriDevolos261201', to='enfermeria.EnfermeriaDevolucion'),
        ),
    ]
