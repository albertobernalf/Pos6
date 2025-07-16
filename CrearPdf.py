import fpdf

def generar_pdf():
    # Creamos un objeto fpdf
    pdf = fpdf.FPDF()

    # Agregamos una página
    pdf.add_page()
    pdf.set_font(family='Times',style='B',size=12)

    # Agregamos un encabezado
    #pdf.set_header("Documento PDF con fpdf")

    # Agregamos un texto
    pdf.cell(200, 10, "Este es un texto", 0, 0, 'C')

    # Agregamos una imagen
    pdf.image("C:\\EntornosPython\\practicaPos3\\vulner\\static\\img\\CIRUGIA.jpg", 5, 5)

    # Agregamos un pie de página
    #pdf.set_footer("Página {}".format(pdf.page_no()))

    # Guardamos el documento
    pdf.output("C:\\EntornosPython\\practicaPos3\\vulner\\documento.pdf")

if __name__ == "__main__":
    generar_pdf()