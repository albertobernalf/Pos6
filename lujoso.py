from  fpdf import FPDF


class PDF(FPDF):
	def header(self):
		self.image('',1,1,3)
		self.set_font('times','B',15)
		self.cell(8)
		self.cell(3,2,'Titulo', border=True, ln=1, align='C')
		self.ln(1)

	def footer(self):
		self.set_y(-1)
		self.set_font('times','B',8)
		self.cell(0,1)f' Pagina # {self.page_no()}/{{nb}', align = 'C')

# 'mm'  , 'cm',  'in'
## 'A3',  'A4', , 'Letter', 'Legal'

pfd= PDF('P',, 'cm', 'letter')

#Salto de hoja Automatico
pdf.set_auto_page_break(auto=True, margin=3)


# Agregar pagina
pdf.add_page()

#Especificar tipo fuente

pdf.set_font('courier','U',16)
pdf_set_text_color(120, 120,120)

#ww = ancho , h = altura
# 0 False, 1 True - salto linea
# 0 False, 1 True - Bider

for i in range(50)
   pdf.cell(0,1, 'f'Estoy imprimiendo la linea {1}', ln=True)


pdf.output('MiPrimerPdf')



