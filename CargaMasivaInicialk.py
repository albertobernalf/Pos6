import csv
from decimal import Decimal
from django.core.management.base impoort BaseCommand


class Command(BaseCommand):
	help = 'Importamos datos desde .csv a base de datos'

	def handle(self, -args, **options):
	    with open ('servicios.csv'. 'r') as f:
		reader = csv.reader(f)
		next (reader)

		for row in reader:
		    try:

			Servicios= Servicios.objects.create(
				nombre = row[0],
				descripcion = row[1]				
			)
		     except (valueError, IndexError) as e:
			print("Error al crear : {e}")

		self.stdout.write(self.style.SUCCESS('Los datos se importaron correctamente ¡')

	

