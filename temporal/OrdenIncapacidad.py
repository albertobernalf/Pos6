
from fpdf import FPDF
import psycopg2
import json 
import datetime 


class PDFIncapacidad(FPDF):
    def header(self):
        # Logo
        self.image('C:/EntornosPython/temporal/temporal/MedicalFinal.jpg', 170 ,1, 20 , 20)
        # Arial bold 15
        self.set_font('Times', 'B', 7)

        # Move to the right
        #self.cell(12)

	    ## CURSOR PARA LEER ENCABEZADO
        #
        miConexiont = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",   password="pass123")

        curt = miConexiont.cursor()

        comando = 'select  u."tipoDoc_id" , tip.nombre tipnombre, u.documento documentoPaciente, u.nombre nombre, case when genero = ' + "'" + str('M') + "'" + ' then ' + "'" + str('Masculino') + "'" + ' when genero= ' + "'" + str('F') + "'" + ' then ' + "'" + str('Femenino') + "'" + ' end as genero, cast((date_part(' + "'" + str('year') + "'" + ', now()) - date_part(' + "'" + str('year') + "'" + ', u."fechaNacio" )) as text) edad,   reg.nombre regimen, convenio.nombre convenio , serv.nombre servicio, cast(now() as text) fecha from admisiones_ingresos adm INNER JOIN 	usuarios_usuarios u ON (u."tipoDoc_id" = adm."tipoDoc_id" and u.id = adm.documento_id) INNER JOIN usuarios_tiposDocumento tip ON (tip.id = u."tipoDoc_id") INNER JOIN facturacion_conveniospacienteingresos  convIngreso ON (convIngreso."tipoDoc_id" = adm."tipoDoc_id" and convIngreso.documento_id = adm.documento_id and convIngreso."consecAdmision" = adm.consec) INNER JOIN contratacion_convenios convenio ON (convenio.id = convIngreso.convenio_id) INNER JOIN facturacion_empresas EMP on (emp.id =convenio.empresa_id ) INNER JOIN clinico_regimenes reg ON (reg.id=emp.regimen_id) INNER JOIN clinico_servicios serv ON (serv.id = adm."serviciosActual_id")	 WHERE adm."tipoDoc_id" = ' + "'" + str('1') + "'" + ' AND adm.documento_id= ' + "'" + str('16') + "'" + ' AND adm.consec = 1  and convenio.id = 1'
        curt.execute(comando)
        print(comando)

        historia = []

        for tipoDoc_id, tipnombre, documentoPaciente, nombre, genero, edad, regimen, convenio, servicio, fecha  in curt.fetchall():
            historia.append(
                {'tipoDoc_id': tipoDoc_id, 'tipnombre': tipnombre, 'documentoPaciente': documentoPaciente,
                 'nombre': nombre, 'genero': genero, 'edad': edad, 'regimen': regimen, 'convenio': convenio, 'servicio': servicio,'fecha':fecha})

        miConexiont.close()

	## FIN CURSOR

        # Title
        #
        self.ln(4)
        self.cell(25, 1, 'CLINICA MEDICAL',  0, 0, 'L')
        self.ln(1)
        self.set_font('Times', 'B', 7)
        self.cell(25, 11, 'PACIENTE: ', 0, 0, 'L')
        self.set_font('Times', '', 7)

        self.cell(25, 11, historia[0]['tipnombre'], 0, 0, 'L')
        self.cell(25, 11, historia[0]['documentoPaciente'], 0, 0, 'L')
        self.cell(25, 11, historia[0]['nombre'], 0, 0, 'L')
        self.ln(1)
        self.set_font('Times', 'B', 7)
        self.cell(25, 16, 'EDAD:', 0, 0, 'L')
        self.set_font('Times', '', 7)
        self.cell(50, 16, historia[0]['edad'], 0, 0, 'L')
        self.set_font('Times', 'B', 7)
        self.cell(25, 16, 'GENERO:', 0, 0, 'L')
        self.set_font('Times', '', 7)
        self.cell(50, 16, historia[0]['genero'], 0, 0, 'L')
        self.ln(2)
        self.set_font('Times', 'B', 7)
        self.cell(25, 18, 'REGIMEN:', 0, 0, 'L')
        self.set_font('Times', '', 7)
        self.cell(50, 18, historia[0]['regimen'], 0, 0, 'L')
        self.ln(2)
        self.set_font('Times', 'B', 7)
        self.cell(25, 20, 'CONVENIO:', 0, 0, 'L')
        self.set_font('Times', '', 7)
        self.cell(25, 20, historia[0]['convenio'], 0, 0, 'L')
        self.ln(2)
        self.set_font('Times', 'B', 7)
        self.cell(25, 21, 'SERVICIO:', 0, 0, 'L')
        self.set_font('Times', '', 7)
        self.cell(25, 21, historia[0]['servicio'], 0, 0, 'L')
        self.ln(2)
        self.set_font('Times', 'B', 7)
        self.cell(25, 23, 'FECHA:', 0, 0, 'L')
        self.cell(25, 23, historia[0]['fecha'], 0, 0, 'L')

        # Line break
        self.ln(10)

    # Page footer
    def footer(self):
        # Position at 1.5 cm from bottom
        self.set_y(-15)
        # Arial italic 8
        self.set_font('Times', 'B', 7)
        self.cell(180, 5, 'MEDICO ORDENA', 0, 0, 'C')
        self.ln(4)

        miConexionii = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",
                                       password="pass123")
        curii = miConexionii.cursor()

        comando = 'SELECT medicos."registroMedico", planta.nombre plantaNombre, usu."tipoDoc_id", usu.documento 	FROM clinico_historialincapacidades inca 	INNER JOIN clinico_historia historia ON (historia.id=inca.historia_id) 	INNER JOIN clinico_TiposIncapacidad tipo  ON (tipo.id = inca."tiposIncapacidad_id") INNER JOIN clinico_Diagnosticos diag ON (diag.id = inca."diagnosticosIncapacidad_id") INNER JOIN planta_planta planta ON (planta.id = historia."usuarioRegistro_id")	 INNER JOIN clinico_medicos medicos ON (medicos.id = historia."usuarioRegistro_id") INNER JOIN usuarios_usuarios usu ON (usu.id = historia."usuarioRegistro_id")	WHERE inca.historia_id = 721'
        curii.execute(comando)

        print(comando)

        incapacidadesI = []

        for registroMedico, plantaNombre, tipoDoc_id, documento in curii.fetchall():
            incapacidadesI.append(
                {'registroMedico': registroMedico, 'plantaNombre': plantaNombre, 'tipoDoc_id': tipoDoc_id, 'documento': documento})
        miConexionii.close()


        self.cell(15, 7, 'Firmado Por:', 0, 0, 'L')
        pdf.cell(25, 7, '' + str(incapacidadesI[0]['tipoDoc_id']), 0, 0, 'L')
        pdf.cell(25, 7, '' + str(incapacidadesI[0]['documento']), 0, 0, 'L')
        pdf.cell(80, 7, '' + str(incapacidadesI[0]['plantaNombre']), 0, 0, 'L')
        pdf.cell(50, 7, 'Registro Medico:' + str(incapacidadesI[0]['registroMedico']), 0, 0, 'L')

        self.ln(2)
        self.cell(100, 9, 'Firmado Electronicamente', 0, 0, 'L')
        self.set_font('Times', 'I', 8)
        # Page number
        #self.cell(0, 10, 'Page ' + str(self.page_no()) + '/{nb}', 0, 0, 'C')



# Instantiation of inherited class
pdf = PDFIncapacidad()
pdf.alias_nb_pages()
pdf.set_margins(left= 10, top= 5, right= 5 )
pdf.add_page()
pdf.set_font('Times', '', 8)
pdf.ln(7)
linea = 7
totalFolios = 20

#El propgrama debe preguntar desde que Folio hasta cual Y/O desde que fecha y hasta cual fecha

       # Cursor recorre Incapacidades

miConexioni = psycopg2.connect(host="192.168.79.133", database="vulner2", port="5432", user="postgres",    password="pass123")
curi = miConexioni.cursor()


comando = 'SELECT tipo.nombre tipo, diag.nombre diagnostico, inca."desdeFecha" desdeFecha, inca."hastaFecha" hastaFecha, inca."numDias" dias, inca.descripcion descripcion FROM clinico_historialincapacidades inca INNER JOIN clinico_TiposIncapacidad tipo  ON (tipo.id = inca."tiposIncapacidad_id") INNER JOIN clinico_Diagnosticos diag ON (diag.id = inca."diagnosticosIncapacidad_id") WHERE inca.historia_id = 721'
curi.execute(comando)

print(comando)

incapacidades = []

for tipo, diagnostico, desdeFecha, hastaFecha, dias, descripcion in curi.fetchall():
   incapacidades.append(
       {'tipo': tipo, 'diagnostico': diagnostico, 'desdeFecha': desdeFecha, 'hastaFecha': hastaFecha,'dias':dias, 'descripcion':descripcion})
miConexioni.close()

print("incapacidades = ", incapacidades)
print("matriz incapacidades = " , len(incapacidades))

if (incapacidades != []):

   linea = linea + 2
   pdf.ln(2)
   pdf.set_font('Times', 'B', 8)
   pdf.cell(180, 1, 'INCAPACIDAD' , 0, 0, 'C')
   pdf.set_font('Times', '', 8)
   linea = linea + 5
   pdf.ln(5)


for z in range(0, len(incapacidades)):

   pdf.cell(150, 1 , 'Diagnostico: ' + str(incapacidades[0 + z]['diagnostico']), 0, 0, 'L')
   linea = linea + 3
   pdf.ln(3)
   pdf.cell(50, 1 , 'Tipo: ' + str(incapacidades[0 + z]['tipo']), 0, 0, 'L')
   linea = linea + 3
   pdf.ln(3)
   pdf.cell(25, 1 , 'Desde: ' + str(incapacidades[0 + z]['desdeFecha']), 0, 0, 'L')
   pdf.cell(25, 1 , 'Hasta: ' + str(incapacidades[0 + z]['hastaFecha']), 0, 0, 'L')
   pdf.cell(20, 1,  'Dias: ' + str(incapacidades[0 + z]['dias']), 0, 0, 'L')
   pdf.cell(100, 1 , 'Observacion: ' + str(incapacidades[0 + z]['descripcion']), 0, 0, 'L')

   linea = linea + 3
   pdf.ln(3)


pdf.output('C:/EntornosPython/temporal/temporal/ordenIncapacidad.pdf', 'F')
