from fpdf import FPDF

class PDF(FPDF):
    def header(self):
        # Logo
        self.image('C:/EntornosPython/practicaPos3/vulner/Medical.png',  180, 1)
        # Arial bold 15
        self.set_font('Arial', 'B', 8)
        # Move to the right
        self.cell(5)
        # Title
        self.cell(1, 1, 'CLINICA MEDICAL', 1, 0, 'C')
        self.cell(1, 9, 'HISTORIA CLINICA', 1, 0, 'C')
        self.cell(1, 17, 'PACIENTE:', 1, 0, 'C')
        self.cell(1, 25, 'FECHA:', 1, 0, 'C')
        self.cell(1, 30, '-------------------------------------------------------------------------------------------------------------------------------------------------------------------', 1, 0, 'C')
        # Line break
        self.ln(20)

    # Page footer
    def footer(self):
        # Position at 1.5 cm from bottom
        self.set_y(-15)
        # Arial italic 8
        self.set_font('Arial', 'I', 8)
        # Page number
        self.cell(0, 10, 'Page ' + str(self.page_no()) + '/{nb}', 0, 0, 'C')

# Instantiation of inherited class
pdf = PDF()
pdf.alias_nb_pages()
pdf.add_page()
pdf.set_font('Times', '', 12)
for i in range(1, 81):
    pdf.cell(0, 10, 'Folio No ' + str(i), 0, 1)
    pdf.cell(5, 10, 'Fecha: ' + '2024-11-29', 0, 1)
pdf.output('C:/EntornosPython/practicaPos3/vulner/NuevosReportes/tutorial.pdf', 'F')