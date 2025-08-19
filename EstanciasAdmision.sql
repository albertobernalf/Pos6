-- Function: estancias_admision()

-- DROP FUNCTION estancias_admision();

CREATE OR REPLACE FUNCTION estancias_admision()
  RETURNS integer AS
$BODY$
	DECLARE 
	contador int4; 
	tabla RECORD; 
	BEGIN 
	contador:=1; 
	FOR tabla IN SELECT * FROM tbladm_admisiones WHERE num_admision = 50852 order by num_admision
	LOOP 
		INSERT INTO  tblfac_cargos  (num_admision, num_hclinica, cant_cargo, fec_cargo,hora_cargo,cod_concepto,codigo,descripcion)
		SELECT Tabla.num_admision,Tabla.num_hclinica,1, a.fecha,Tabla.hora_ingreso,a.cod_concepto,a.codigo,a.descripcion FROM fechas a
		WHERE fecha between Tabla.fec_ingreso and Tabla.fec_egreso-1;		
		contador:=contador+1; 
	END LOOP; 
	RETURN contador; 
	END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION estancias_admision()
  OWNER TO postgres;