select * from cirugia_cirugias;

SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionInicia" as time), cast(prog."horaProgramacionFin" as time) , 'OCUPADO' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1'
	ORDER BY salas.numero,prog."fechaProgramacionInicia",cast(prog."horaProgramacionInicia" as time)


select * from sitios_salas;

select * from sitios_tipossalas;
select * from cirugia_estadossalas;

select * from cirugia_programacioncirugias
	update cirugia_programacioncirugias set sala_id=1

SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionInicia" as time), cast(prog."horaProgramacionFin" as time) , 'OCUPADO' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1'
union
SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionFin" as time) + interval '1 minute' , cast(salas."finServicio" as time) , 'LIBRE' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1'
--ORDER BY salas.numero,prog."fechaProgramacionInicia",cast(prog."horaProgramacionInicia" as time)
order by 2,4,6

-- El que sigue

	SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionInicia" as time), cast(prog."horaProgramacionFin" as time) , 'OCUPADO' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1'
union
	SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionInicia" as time)  , -- cast(prog."horaProgramacionFin" as time) 
		CASE when cast(salas."finServicio" as time) >= cast(prog."horaProgramacionInicia" as time) then cast(salas."finServicio" as time)   ELSE cast(prog."horaProgramacionInicia" as time)  END
	, 'LIBRE' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1' AND prog.id > (select min(prog1.id) from cirugia_programacioncirugias prog1 
														where prog1.id <> prog.id  ) 

	/*
SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionFin" as time) + interval '1 minute' ,
	CASE when cast(salas."finServicio" as time) >= cast(prog."horaProgramacionFin" as time) then cast(salas."finServicio" as time)   ELSE cast(prog."horaProgramacionFin" as time)  END
	, 'LIBRE' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1'	
*/
union	
SELECT salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionInicia" as time)  , cast(prog."horaProgramacionFin" as time) , 'OCUPADO' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1' AND prog.id > (select min(prog1.id) from cirugia_programacioncirugias prog1 
														where prog1.id <> prog.id  ) 
order by 2,4,6
	
select * from sitios_salas
select * from clinico_especialidadesmedicos
select * from cirugia_cirugias;
update cirugia_cirugias set especialidad_id=1
	select * from cirugia_programacioncirugias;

-- Otra voz

	SELECT prog.id, salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,
	cast(prog."horaProgramacionInicia" as time), cast(prog."horaProgramacionFin" as time) , 'OCUPADO' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id and salas."sedesClinica_id" = prog."sedesClinica_id" )
	WHERE salas."sedesClinica_id" = '1'
union
SELECT prog.id, salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionFin", prog2."fechaProgramacionInicia" ,
	cast(prog."horaProgramacionFin" as time) + interval '1 minute' , cast(prog2."horaProgramacionInicia" as time) - interval '1 minute' , 'LIBRE' estado 
FROM cirugia_programacioncirugias prog , sitios_salas salas, cirugia_programacioncirugias prog2
where salas.id = prog.sala_id  and salas."sedesClinica_id" = prog."sedesClinica_id" and prog2."sedesClinica_id" = prog."sedesClinica_id"
		and	salas."sedesClinica_id" = '1' and  prog2.id = (select min(prog3.id) from cirugia_programacioncirugias prog3
														where prog3.id > prog.id  ) 
UNION
SELECT prog.id, salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionFin", prog2."fechaProgramacionInicia" ,
	cast(prog2."horaProgramacionFin" as time) + interval '1 minute' , cast(salas."finServicio" as time)  , 'LIBRE' estado 
FROM cirugia_programacioncirugias prog , sitios_salas salas, cirugia_programacioncirugias prog2
where salas.id = prog.sala_id  and salas."sedesClinica_id" = prog."sedesClinica_id" and prog2."sedesClinica_id" = prog."sedesClinica_id"
		and	salas."sedesClinica_id" = '1' and  prog2.id = (select min(prog3.id) from cirugia_programacioncirugias prog3
														where prog3.id > prog.id  ) 
order by 3,5,7

detalle = 'SELECT prog.id, salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionInicia", prog."fechaProgramacionFin" ,	cast(prog."horaProgramacionInicia" as time), cast(prog."horaProgramacionFin" as time) , 'OCUPADO' estado FROM cirugia_programacioncirugias prog LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id and salas."sedesClinica_id" = prog."sedesClinica_id" ) WHERE salas."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' union SELECT prog.id, salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionFin", prog2."fechaProgramacionInicia" ,cast(prog."horaProgramacionFin" as time) + interval ' + "'" + str('1 minute') + "'" + ' , cast(prog2."horaProgramacionInicia" as time) - interval ' + "'" + str('1 minute') + "'" + ', ' + "'" + str('LIBRE') + "'" + ' estado FROM cirugia_programacioncirugias prog , sitios_salas salas, cirugia_programacioncirugias prog2 where salas.id = prog.sala_id  and salas."sedesClinica_id" = prog."sedesClinica_id" and prog2."sedesClinica_id" = prog."sedesClinica_id" and	salas."sedesClinica_id" =  ' + "'" + str(sede) + "'" + ' and  prog2.id = (select min(prog3.id) from cirugia_programacioncirugias prog3 where prog3.id > prog.id) UNION SELECT prog.id, salas.id id,salas.numero numero , salas.nombre nombre,prog."fechaProgramacionFin", prog2."fechaProgramacionInicia" ,cast(prog2."horaProgramacionFin" as time) + interval ' + "'" + str('1 minute') + "'" + ' , cast(salas."finServicio" as time)  , ' + "'" + str('LIBRE') + "'" + ' estado FROM cirugia_programacioncirugias prog , sitios_salas salas, cirugia_programacioncirugias prog2 where salas.id = prog.sala_id  and salas."sedesClinica_id" = prog."sedesClinica_id" and prog2."sedesClinica_id" = prog."sedesClinica_id" and	salas."sedesClinica_id" = ' + "'" + str(sede) + "'" + ' and  prog2.id = (select min(prog3.id) from cirugia_programacioncirugias prog3 where prog3.id > prog.id ) order by 3,5,7'