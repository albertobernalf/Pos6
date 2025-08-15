SELECT prog.numero.prog."fechaProgramacionFin", prog."horaProgramacionFin" +1,
       (SELECT cast(prog1."fechaProgramacionInicial"||' '||prog1."horaProgramacionInicial" + 1 as datetime) FROm cirugia_programacioncirugia prog1
         WHERE prog1.id = (SELECT min(prog2.id) FROM cirugia_programacionCirugia prog2  WHERE  prog2.id > prog.id))
FROM cirugia_programacioncirugia prog
WHERE prog.id =id
