select * from clinico_revisionsistemas;
select * from clinico_historiarevisionsistemas;
select * from clinico_historia;

      comando = 'INSERT INTO clinico_Historia ("tipoDoc_id" , documento_id , "consecAdmision", folio ,fecha , "tiposFolio_id" ,"causasExterna_id" , "dependenciasRealizado_id" , especialidades_id ,planta_id, motivo , subjetivo,objetivo, analisis ,plann, tratamiento , "fechaRegistro"  ,"usuarioRegistro_id", "estadoReg" ) VALUES ('  + "'" +  str(
                    tipoDocId.id) + "','" + str(documentoId.id) + "','" + str(ingresoPaciente) + "','" + str(ultimofolio2) + "','" + str(fechaRegistro) + "','"  +  str(tiposFolio) + "','" + str(causasExterna) + "','" + str(dependenciasRealizado) + "','" + str(espMedico) + "','" + str(plantaId.id) + "','" + str(motivo) + "','" + str(
                    subjetivo) + "','" + str(objetivo) + "','" + str(analisis) + "','" + str(plan) + "','" + str(tratamiento) +  "','" + str(fechaRegistro) + "','" + str(usuarioRegistro) + "','" + str(estadoReg) + "');"
                
  comando = 'INSERT INTO clinico_Historia ("tipoDoc_id" , documento_id , "consecAdmision", folio ,fecha , "tiposFolio_id" ,"causasExterna_id" , "dependenciasRealizado_id" , especialidades_id ,planta_id, motivo , subjetivo,objetivo, analisis ,plann, tratamiento , 
		apache2,antibioticos,monitoreo,"movilidadLimitada",nauseas, "llenadoCapilar", neurologia,irritacion, pulsos,  "retiroPuntos",
  inmovilizacion, "notaAclaratoria","fecNotaAclaratoria",  "examenFisico", "noQx",observaciones,  "riesgoHemodinamico", riesgos,
          trombocitopenia, hipotension,"indiceMortalidad", "ingestaAlcohol", "inmovilizacionObservaciones",
            justificacion,leucopenia, manejoQx , "fechaRegistro"  ,"usuarioRegistro_id", "estadoReg" ) 
VALUES ('  + "'" +  str(tipoDocId.id) + "','" + str(documentoId.id) + "','" + str(ingresoPaciente) + "','" + str(ultimofolio2) + "','" + str(fechaRegistro) + "','"  +  str(tiposFolio) + "','" + str(causasExterna) + "','" + str(dependenciasRealizado) + "','" + str(espMedico) + "','" + str(plantaId.id) + "','" + str(motivo) + "','" + str(
                    subjetivo) + "','" + str(objetivo) + "','" + str(analisis) + "','" + str(plan) + "','" + str(tratamiento) 
	+ "','" + str(apache2) + "','" 	+ "','" + str(antibioticos) + "','"+ "','" + str(monitoreo) + "','" + "','" + str(movilidadLimitada) + "','" + "','" + str(nauseas) + "','" + "','" + str(neurologia) + "','"
+ "','" + str(irritacion) + "','" + "','" + str(pulsos) + "','"  + "','" + str(inmovilizacion) + "','" + "','" + str(notaAclaratoria) + "','"
+ "','" + str(fecNotaAclaratoria) + "','" + "','" + str(noQx1) + "','" + "','" + str(observaciones) + "','" + "','" + str(riesgoHemodinamico) + "','"
+ "','" + str(riesgos) + "','" + "','" + str(trombocitopenia) + "','" + "','" + str(hipotension) + "','" + "','" + str(indiceMortalidad) + "','"
+ "','" + str(ingestaAlcohol) +  "','" + str(inmovilizacionObservaciones) + "','"
+ "','" + str(justificacion) + "','" + "','" + str(leucopenia) + "','" + "','" + str(manejoQx) + "','" 	+ "','" + str(fechaRegistro) 
	+ "','" + str(usuarioRegistro)  + "','" + str(estadoReg) + "');"
                
