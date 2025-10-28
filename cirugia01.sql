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
	cast(prog."horaProgramacionFin" as time) + interval '1 minute' ,
	CASE when cast(salas."finServicio" as time) >= cast(prog."horaProgramacionFin" as time) then cast(salas."finServicio" as time)   ELSE cast(prog."horaProgramacionFin" as time)  END
	, 'LIBRE' estado 
	FROM cirugia_programacioncirugias prog 
	LEFT JOIN sitios_salas salas ON (salas.id = prog.sala_id )
	WHERE salas."sedesClinica_id" = '1'	
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