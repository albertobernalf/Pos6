SELECT id, fecha, "totalEfectivo", "totalTarjetasDebito", "totalTarjetasCredito", "totalCheques", total, "fechaRegistro", "estadoReg", "serviciosAdministrativos_id", "usuarioEntrega_id", "usuarioRecibe_id", "usuarioRegistro_id", "usuarioSuperviza_id", "estadoCaja", "sedesClinica_id", "totalChequesEsperado", "totalEfectivoEsperado", "totalEsperado", "totalTarjetasCreditoEsperado", "totalTarjetasDebitoEsperado"
	FROM public.cartera_caja;

select * from clinico_historiaresultados;
select * from clinico_historiaexamenes where id = 652
select * from clinico_historia where id=1162

SELECT hisExa.interpretacion1, hisExa."fechaInterpretacion1", pla.nombre medicoInterpreta1, hisExa.interpretacion2, hisExa."fechaInterpretacion2", pla.nombre medicoInterpreta2 
	FROM clinico_historiaexamenes hisExa
	LEFT JOIN  clinico_medicos med ON (med.id = hisExa."medicoInterpretacion1_id") 
	LEFT  JOIN  clinico_medicos med2 ON (med2.id = hisExa."medicoInterpretacion2_id") 
	INNER JOIN clinico_historia historia on (historia.id = hisExa.historia_id )
	LEFT JOIN planta_planta pla ON (pla.id=med.planta_id) 
	LEFT JOIN planta_planta pla2 ON (pla2.id=med2.planta_id)
	WHERE hisExa.historia_id = '1162'

	select * from clinico_tiposfolio;

select * from clinico_causasexterna;

select * from planta_planta;
update planta_planta set "esCajero" = 'S' where id in (8,6)