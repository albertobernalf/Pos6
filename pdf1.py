# importar la libreria
from fpdf import FPDF
# crear una instancia de la libreria FPDF
pdf = FPDF (orientation="P", unit="mm", format="A4")
pdf.add_page() # agregar una pagina
pdf.set_font("Arial","",8) # asignar el tamaño de letra
pdf.text(x=5,y=20,txt="CLINICA MEDICAL S.a") # Crear una linea de texto
pdf.text(x=5,y=23,txt="Reporte : Historia Clinica") # Crear una linea de texto
pdf.text(x=5,y=26,txt="Paciente : Arturo Cacon") # Crear una linea de texto

pdf.set_font("Arial","",6) # asignar el tamaño de letra

pdf.text(x=20,y=50,txt="Probando FPDF en python") # Crear una linea de texto
pdf.text(x=20,y=53,txt="Segunda linea de FPDF en Python") # crear otra linea de texto
pdf.text(x=20,y=56,txt="Tercera linea de FPDF en Python") # crear otra linea de texto
pdf.text(x=20,y=59,txt="Cuarta linea de FPDF en Python") # crear otra linea de texto
pdf.text(x=20,y=62,txt="Quinta linea de FPDF en Python") # crear otra linea de texto
pdf.text(x=20,y=65,txt="Sexta linea de FPDF en Python") # crear otra linea de texto
pdf.text(x=20,y=68,txt="Septima linea de FPDF en Python") # crear otra linea de texto

pdf.output("C:\\EntornosPython\\practicaPos3\\vulner\\pdf1.pdf") 