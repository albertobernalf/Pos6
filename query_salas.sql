
SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,prog."horaProgramacionInicia",
	prog."horaProgramacionFin" , 'OCUPADO' estado
FROM cirugia_programacioncirugias prog 
LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id ) 
WHERE salas."sedesClinica_id" = '1'
ORDER BY salas.numero,prog."fechaProgramacionInicia",cast(prog."horaProgramacionInicia" as time)


 select * from sitios_salas;
select * from cirugia_programacioncirugias;


SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,prog."horaProgramacionInicia",
	prog."horaProgramacionFin" , 'OCUPADO' estado
FROM cirugia_programacioncirugias prog 
LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id ) 
WHERE salas."sedesClinica_id" = '1'
ORDER BY salas.numero,prog."fechaProgramacionInicia",cast(prog."horaProgramacionInicia" as time)
UNION
	
SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,prog."horaProgramacionInicia",
	prog."horaProgramacionFin" , 'OCUPADO' estado,
	(
	select salas1.numero||' '||prog1."fechaProgramacionInicia"
	FROM cirugia_programacioncirugias prog1
	LEFT JOIN sitios_salas salas1 ON (salas1.id = prog1.sala_id ) 
	WHERE salas1.numero=salas.numero and prog1."fechaProgramacionInicia" = (select min(prog2."fechaProgramacionInicia")
																			FROM cirugia_programacioncirugias prog2
																			LEFT JOIN sitios_salas salas2 ON (salas2.id = prog2.sala_id ) 	
																			where salas2.numero=salas1.numero AND prog2."fechaProgramacionInicia" > prog."fechaProgramacionInicia"
																		
	
	)) valor
FROM cirugia_programacioncirugias prog 
LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id ) 
WHERE salas."sedesClinica_id" = '1'
ORDER BY salas.numero,prog."fechaProgramacionInicia",cast(prog."horaProgramacionInicia" as time)


SELECT * FROM cirugia_programacioncirugias;
