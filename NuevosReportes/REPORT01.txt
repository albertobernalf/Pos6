def report():
    response.title = "web2py sample report"

    # include a google chart (download it dynamically!)
    url = "http://chart.apis.google.com/chart?cht=p3&chd=t:60,40&chs=500x200&chl=Hello|World&.png"
    chart = IMG(_src=url, _width="250", _height="100")

    # create a small table with some data:
    rows = [THEAD(TR(TH("Key", _width="70%"), TH("Value", _width="30%"))),
            TBODY(TR(TD("Hello"), TD("60")), 
                  TR(TD("World"), TD("40")))]
    table = TABLE(*rows, _border="0", _align="center", _width="50%")

    if request.extension == "pdf":
        from gluon.contrib.pyfpdf import FPDF, HTMLMixin

        # create a custom class with the required functionality 
        class MyFPDF(FPDF, HTMLMixin):
            def header(self): 
                "hook to draw custom page header (logo and title)"
                logo = os.path.join(request.env.web2py_path, "gluon", "contrib", "pyfpdf", "tutorial", "logo_pb.png")
                self.image(logo, 10, 8, 33)
                self.set_font('Arial', 'B', 15)
                self.cell(65) # padding
                self.cell(60, 10, response.title, 1, 0, 'C')
                self.ln(20)

            def footer(self):
                "hook to draw custom page footer (printing page numbers)"
                self.set_y(-15)
                self.set_font('Arial', 'I', 8)
                txt = 'Page %s of %s' % (self.page_no(), self.alias_nb_pages())
                self.cell(0, 10, txt, 0, 0, 'C')

        pdf = MyFPDF()
        # create a page and serialize/render HTML objects
        pdf.add_page()
        pdf.write_html(str(XML(table, sanitize=False)))
        pdf.write_html(str(XML(CENTER(chart), sanitize=False)))
        # prepare PDF to download:
        response.headers['Content-Type'] = 'application/pdf'
        return pdf.output(dest='S')
    else:
        # normal html view:
        return dict(chart=chart, table=table)