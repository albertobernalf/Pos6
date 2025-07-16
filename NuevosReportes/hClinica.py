from fpdf import FPDF
import psycopg2
import json 
import datetime 


class PDF(FPDF):
    def header(self):
        # Logo
        self.image('C:/EntornosPython/practicaPos3/vulner/Medical.png',  180, 1)
        # Arial bold 15
        self.set_font('Times', 'B', 7)

        # Move to the right
        self.cell(12)

	    ## CURSOR PARA LEER ENCABEZADO
        #
        miConexiont = psycopg2.connect(host="192.168.79.129", database="vulner", port="5432", user="postgres",   password="pass123")

        curt = miConexiont.cursor()
        comando = 'select  u."tipoDoc_id" , tip.nombre tipnombre, documento documentoPaciente, u.nombre nombre, case when genero = ' + "'" + str('M') + "'" + ' then ' + "'" + str("Masculino") + "'" + ' when genero= ' + "'" + str('F') + "'" + ' then ' + "'" + str('Femenino') + "'" + ' end as genero, cen.nombre as centro, tu.nombre as tipoUsuario,"fechaNacio", u.direccion direccion, u.telefono telefono from usuarios_usuarios u, usuarios_tiposUsuario tu, sitios_centros cen, usuarios_tiposDocumento tip where tip.id = u."tipoDoc_id"  AND u."tipoDoc_id" = ' +"'" + str('1') + "'" + ' and u.documento >= ' + "'" + str('19465673') + "'" + ' and u."tiposUsuario_id" = tu.id and u."centrosC_id" = cen.id'
        curt.execute(comando)
        print(comando)

        historia = []

        for tipoDoc_id, tipnombre, documentoPaciente, nombre, genero, centro, tipoUsuario, fechaNacio, direccion, telefono in curt.fetchall():
            historia.append(
                {'tipoDoc_id': tipoDoc_id, 'tipnombre': tipnombre, 'documentoPaciente': documentoPaciente,
                 'nombre': nombre, 'genero': genero, 'centro': centro, 'tipoUsuario': tipoUsuario, 'fechaNacio': fechaNacio, 'direccion': direccion,'telefono': telefono})

        miConexiont.close()

	## FIN CURSOR

        # Title
        #
        self.ln(5)
        self.cell(25, 1, 'CLINICA MEDICAL', 0, 0, 'L')
        self.ln(1)
        self.cell(25, 9, 'HISTORIA CLINICA', 0, 0, 'L')
        self.ln(1)
        self.cell(25, 17, 'PACIENTE: ', 0, 0, 'L')
        self.cell(25, 17, historia[0]['tipnombre'], 0, 0, 'L')
        self.cell(25, 17, historia[0]['documentoPaciente'], 0, 0, 'L')
        self.cell(25, 17, historia[0]['nombre'], 0, 0, 'L')
        self.ln(1)
        self.cell(25, 25, 'DIRECCION:', 0, 0, 'L')
        self.cell(50, 25, historia[0]['direccion'], 0, 0, 'L')
        self.cell(50, 25, 'ASEGURADORA:', 0, 0, 'L')
        self.cell(50, 25, 'TELEFONO:', 0, 0, 'L')
        self.cell(25, 25, historia[0]['telefono'], 0, 0, 'L')
        self.ln(1)
        self.cell(25, 33, 'TIPO USUARIO:', 0, 0, 'L')
        self.cell(25, 33, historia[0]['tipoUsuario'], 0, 0, 'L')
        self.ln(1)
        self.cell(25, 40, 'FECHA:', 0, 0, 'L')

        # Line break
        self.ln(16)

    # Page footer
    def footer(self):
        # Position at 1.5 cm from bottom
        self.set_y(-15)
        # Arial italic 8
        self.set_font('Times', 'I', 8)
        # Page number
        self.cell(0, 10, 'Page ' + str(self.page_no()) + '/{nb}', 0, 0, 'C')



# Instantiation of inherited class
pdf = PDF()
pdf.alias_nb_pages()
pdf.set_margins(left= 10, top= 5, right= 5 )
pdf.add_page()
pdf.set_font('Times', '', 8)
pdf.ln(7)
linea = 7
totalFolios = 20

#El propgrama debe preguntar desde que Folio hasta cual Y/O desde que fecha y hasta cual fecha

# Cursor recorre Folios

miConexiont = psycopg2.connect(host="192.168.79.129", database="vulner", port="5432", user="postgres",   password="pass123")
curt = miConexiont.cursor()

comando = 'select  h.id folioId, h.fecha fechaFolio, h."tiposFolio_id" tipoFolio from clinico_historia h where h.documento_id = ' + "'" + str('1') + "'" + ' order by id'
curt.execute(comando)
print(comando)

folios = []

for folioId, fechaFolio, tipoFolio in curt.fetchall():
            folios.append(
                {'folioId': folioId, 'fechaFolio': fechaFolio, 'tipoFolio': tipoFolio})
miConexiont.close()

for i in range(1, len(folios)):
   pdf.cell(1, 5, '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------', 0, 0, 'L')
   pdf.cell(20,  8, 'Folio No ' + str(folios[0+i]['folioId']) ,0,0,'L' )
   pdf.cell(80,  8, 'Fecha: ' + str(folios[0+i]['fechaFolio']),0,0,'L')
   pdf.cell(25,  8, 'Tipo Folio: ' + str(folios[0+i]['tipoFolio']),0,0,'L')

   linea=linea + 1
   pdf.ln(linea)
   #pdf.cell(1, 16, '----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------',            0, 0, 'L')

   # Cursor recorre basicos Historia Clinica

   miConexiont = psycopg2.connect(host="192.168.79.129", database="vulner", port="5432", user="postgres",
                                  password="pass123")
   curt = miConexiont.cursor()

   comando = 'select  h.motivo motivo, h.subjetivo subjetivo, h.objetivo objetivo, h.analisis analisis, h.plann plan, h."causasExterna_id" causasExterna    from clinico_historia h where h.id = '  + str(folios[0 + i]['folioId'])

   curt.execute(comando)

   print(comando)

   historia = []

   for motivo, subjetivo, objetivo, analisis, plan, causasExterna  in curt.fetchall():
       historia.append(
           {'motivo': motivo, 'subjetivo': subjetivo, 'objetivo': objetivo, 'analisis': analisis, 'plan':plan, 'causasExterna':causasExterna})
   miConexiont.close()

   print("historia = ", historia)
   print("matriz historia = ", len(historia))

   for l in range(0, len(historia)):
       pdf.cell(250, 1, 'Motivo ' + str(historia[0 + l]['motivo']), 0, 0, 'L')
       pdf.ln(3)

       pdf.cell(250, 1, 'Subjetivo: ' + str(historia[0 + l]['subjetivo']), 0, 0, 'L')
       pdf.ln(3)
       pdf.cell(250, 1, 'Objetivo: ' + str(historia[0 + l]['objetivo']), 0, 0, 'L')
       pdf.ln(3)
       pdf.cell(250, 1, 'Analisis: ' + str(historia[0 + l]['analisis']), 0, 0, 'L')
       pdf.ln(3)
       pdf.cell(250, 1, 'Plan: ' + str(historia[0 + l]['plan']), 0, 0, 'L')
       pdf.ln(3)
       pdf.cell(30, 1, 'CausasExterna: ' + str(historia[0 + l]['causasExterna']), 0, 0, 'L')
       linea = linea + 1
       pdf.ln(5)


   # Cursor recorre Laboratorios

   miConexiont = psycopg2.connect(host="192.168.79.129", database="vulner", port="5432", user="postgres",    password="pass123")
   curt = miConexiont.cursor()

   comando ='select h."codigoCups" codigoCups, e.nombre nombre, h.cantidad cantidad, h.observaciones observaciones from clinico_historiaexamenes h, clinico_examenes    e, clinico_tiposexamen t  where h."tiposExamen_id" = t.id and t.nombre like(' + "'" + '%LABORATO%' + "'" + ') and e."codigoCups" = h."codigoCups" and h.historia_id = ' + str(folios[0+i]['folioId'])

   curt.execute(comando)

   print(comando)

   laboratorios = []

   for codigoCups, nombre, cantidad, observaciones in curt.fetchall():
       laboratorios.append(
           {'codigoCups': codigoCups, 'nombre': nombre, 'cantidad': cantidad, 'observaciones': observaciones})
   miConexiont.close()

   print("laboratorios = ", laboratorios)
   print("matriz laboratorios = " , len(laboratorios))

   for l in range(0, len(laboratorios)):
       pdf.cell(20, 1 , 'Cups ' + str(laboratorios[0 + l]['codigoCups']), 0, 0, 'L')
       pdf.cell(120, 1, 'Nombre: ' + str(laboratorios[0 + l]['nombre']), 0, 0, 'L')
       pdf.cell(25, 1 , 'Cantidad: ' + str(laboratorios[0 + l]['cantidad']), 0, 0, 'L')
       pdf.cell(25, 1 , 'Observacion: ' + str(laboratorios[0 + l]['observaciones']), 0, 0, 'L')
       linea = linea + 1
       pdf.ln()


   # Cursor recorre Radiologia

   miConexiont = psycopg2.connect(host="192.168.79.129", database="vulner", port="5432", user="postgres",    password="pass123")
   curt = miConexiont.cursor()

   comando ='select h."codigoCups" codigoCups, e.nombre nombre, h.cantidad cantidad, h.observaciones observaciones from clinico_historiaexamenes h, clinico_examenes    e, clinico_tiposexamen t  where h."tiposExamen_id" = t.id and t.nombre like(' + "'" + '%RAD%' + "'" + ') and e."codigoCups" = h."codigoCups" and h.historia_id = ' + str(folios[0+i]['folioId'])

   curt.execute(comando)

   print(comando)

   radiologia = []

   for codigoCups, nombre, cantidad, observaciones in curt.fetchall():
       radiologia.append(
           {'codigoCups': codigoCups, 'nombre': nombre, 'cantidad': cantidad, 'observaciones': observaciones})
   miConexiont.close()

   print("Radiologia = ", radiologia)
   print("matriz Radiologia = " , len(radiologia))

   for l in range(0, len(radiologia)):
       pdf.cell(20, 10 + l, 'Cups ' + str(radiologia[0 + l]['codigoCups']), 0, 0, 'L')
       pdf.cell(120, 10 + 1, 'Nombre: ' + str(radiologia[0 + l]['nombre']), 0, 0, 'L')
       pdf.cell(25, 10 + l, 'Cantidad: ' + str(radiologia[0 + l]['cantidad']), 0, 0, 'L')
       pdf.cell(25, 10 + l, 'Observacion: ' + str(radiologia[0 + l]['observaciones']), 0, 0, 'L')
       linea = linea + 1
       pdf.ln()

   # Cursor recorre Terapias

   miConexiont = psycopg2.connect(host="192.168.79.129", database="vulner", port="5432", user="postgres",    password="pass123")
   curt = miConexiont.cursor()

   comando ='select h."codigoCups" codigoCups, e.nombre nombre, h.cantidad cantidad, h.observaciones observaciones from clinico_historiaexamenes h, clinico_examenes    e, clinico_tiposexamen t  where h."tiposExamen_id" = t.id and t.nombre like(' + "'" + '%TERAP%' + "'" + ') and e."codigoCups" = h."codigoCups" and h.historia_id = ' + str(folios[0+i]['folioId'])

   curt.execute(comando)

   print(comando)

   terapias  = []

   for codigoCups, nombre, cantidad, observaciones in curt.fetchall():
       terapias.append(
           {'codigoCups': codigoCups, 'nombre': nombre, 'cantidad': cantidad, 'observaciones': observaciones})
   miConexiont.close()

   print("terapias = ", terapias)
   print("matriz terapias = " , len(terapias))

   for l in range(0, len(terapias)):
       pdf.cell(20, 10 + l, 'Cups ' + str(terapias[0 + l]['codigoCups']), 0, 0, 'L')
       pdf.cell(120, 10 + 1, 'Nombre: ' + str(terapias[0 + l]['nombre']), 0, 0, 'L')
       pdf.cell(25, 10 + l, 'Cantidad: ' + str(terapias[0 + l]['cantidad']), 0, 0, 'L')
       pdf.cell(25, 10 + l, 'Observacion: ' + str(terapias[0 + l]['observaciones']), 0, 0, 'L')
       linea = linea + 1
       pdf.ln()


   # Cursor recorre Proc Mo qx

   miConexiont = psycopg2.connect(host="192.168.79.129", database="vulner", port="5432", user="postgres",    password="pass123")
   curt = miConexiont.cursor()

   comando ='select h."codigoCups" codigoCups, e.nombre nombre, h.cantidad cantidad, h.observaciones observaciones from clinico_historiaexamenes h, clinico_examenes    e, clinico_tiposexamen t  where h."tiposExamen_id" = t.id and t.nombre like(' + "'" + '%NO%' + "'" + ') and e."codigoCups" = h."codigoCups" and h.historia_id = ' + str(folios[0+i]['folioId'])

   curt.execute(comando)

   print(comando)

   noqX  = []

   for codigoCups, nombre, cantidad, observaciones in curt.fetchall():
       noqX.append(
           {'codigoCups': codigoCups, 'nombre': nombre, 'cantidad': cantidad, 'observaciones': observaciones})
   miConexiont.close()

   print("noqX = ", noqX)
   print("matriz noqX = " , len(noqX))

   for l in range(0, len(noqX)):
       pdf.cell(20, 10 + l, 'Cups ' + str(noqX[0 + l]['codigoCups']), 0, 0, 'L')
       pdf.cell(120, 10 + 1, 'Nombre: ' + str(noqX[0 + l]['nombre']), 0, 0, 'L')
       pdf.cell(25, 10 + l, 'Cantidad: ' + str(noqX[0 + l]['cantidad']), 0, 0, 'L')
       pdf.cell(25, 10 + l, 'Observacion: ' + str(noqX[0 + l]['observaciones']), 0, 0, 'L')
       linea = linea + 1
       pdf.ln()


   # Cursor recorre Historia Clinica (basicos+ analisis, plan, subjetivo,objetivo, enfermedad General,  consulta externa, etc flags de heridas etc

   # Cursor recorre Revision x Sistemas 

   # Cursor recorre Antecedentes

   # Cursor recorre Examenes. Orden, Laboratorio, Radiologia, Terapias, Proced No qx

   # Cursor recorre Medicamentos

   # Cursor recorre Cirugias

   # Cursor recorre Enfermeria

   # Cursor recorre Diagnosticos

   # Cursor recorre Incapacidades



pdf.output('C:/EntornosPython/practicaPos3/vulner/NuevosReportes/hClinica.pdf', 'F')
