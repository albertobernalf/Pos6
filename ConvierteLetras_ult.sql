-- Function: convierteletras_ult(character varying)

-- DROP FUNCTION convierteletras_ult(character varying);

CREATE OR REPLACE FUNCTION convierteletras_ult(variable character varying)
  RETURNS character varying AS
$BODY$
DECLARE
                numeroTipoCha varchar(1000);
		resultado varchar(100);
		valor1 varchar(100);
		valor2 varchar(100);
		valor3 varchar(100);
		valor4 varchar(100);
		valor5 varchar(100);
		valor6 varchar(100);
                letras varchar(1000);
		letras1 varchar(1000);
		corre1 varchar(100);
		corre2 varchar(100);
		corre3 varchar(100);
		corre4 varchar(100);
		corre5 varchar(100);
		corre6 varchar(100);
                
		palabras varchar(1000);
		posicionmil integer := 1;
		posicionpesos integer := 1;
		posicion integer := 1;
                tokens integer := 0; 
                cuenta integer := 1;
		voy integer := 1;
		datos1 varchar(50); 
		datos2 varchar(50); 
		datos3 varchar(50); 
		datos4 varchar(50); 
		datos5 varchar(50); 
		datos6 varchar(50); 

BEGIN
   letras := variable;
   numeroTipoCha:= '';
   datos1:='';
   datos2:='';
   datos3:='';
   datos4:='';
   datos5:='';
   datos6:='';
   valor1:='';
   valor2:='';
   valor3:='';
   valor4:='';
   valor5:='';
   valor6:='';
   corre1:='';
   corre2:='';
   corre3:='';
   corre4:='';
   corre5:='';
   corre6:='';

  

	SELECT strpos(letras, 'MIL' ) INTO posicionmil;
	posicionmil:= posicionmil-1;
	select substring(cast(letras as text) ,posicionmil+5,length(letras)) into letras;
	SELECT strpos(letras, 'PESOS' ) INTO posicionpesos;
	posicionpesos:= posicionpesos-1;
	select substring(cast(letras as text) ,1,posicionpesos) into letras;

	-- Hasta aqui tengo el datos desde MIL hasta PESOS
	-- Ahora acontar tokens que hay y recorrer cada token en orden a ver que pasa

	tokens := 0;
	letras1 := letras;
 
	while length(letras1) > 1 loop
	
	SELECT strpos(letras, ' ' ) INTO posicion;

	if (posicion > 0) then

		select substring(cast(letras as text),posicion+1, length(letras)) into letras;
		tokens:= tokens +1;
		letras1 := letras;

	else
		exit;
	end if;

	end loop;


	SELECT strpos(letras, ' ' ) INTO posicion;
	SELECT substring(cast(letras as text) ,1,posicion-1) into datos1;
	select substring(cast(letras as text),posicion+1, length(letras)) into letras;

	SELECT strpos(letras, ' ' ) INTO posicion;
	SELECT substring(cast(letras as text) ,1,posicion-1) into datos2;
	select substring(cast(letras as text),posicion+1, length(letras)) into letras;



	if (length(letras) > 0) then
		SELECT strpos(letras, ' ' ) INTO posicion;
		SELECT substring(cast(letras as text) ,1,posicion-1) into datos3;
		select substring(cast(letras as text),posicion+1, length(letras)) into letras;
	end if;

	if (length(letras) > 0) then
		SELECT strpos(letras, ' ' ) INTO posicion;
		SELECT substring(cast(letras as text) ,1,posicion-1) into datos4;
		select substring(cast(letras as text),posicion+1, length(letras)) into letras;
	end if;

	select valor,corre  into  valor1, corre1 from conversionDinero where id= datos1;
	select valor,corre  into  valor2 , corre2 from conversionDinero where id= datos2;	
	select valor,corre  into  valor3, corre3 from conversionDinero where id= datos3;	
	select valor,corre  into  valor4, corre4 from conversionDinero where id= datos4;	
	select valor,corre  into  valor5, corre5 from conversionDinero where id= datos5;	
	select valor,corre  into  valor6, corre6 from conversionDinero where id= datos6;	
	--SELECT concat(valor1,valor2) into resultado;
	--SELECT concat(resultado,valor3) into resultado;	
	--SELECT concat(resultado,valor4) into resultado;
	--SELECT concat(resultado,valor5) into resultado;
	--SELECT concat(resultado,valor6) into resultado;
	
	if datos1 <> ''  and datos2 <>'' and datos3 ='' then 
		SELECT concat(valor1,valor2) into resultado;
	end if;

 

	if datos1 <> ''  and datos2 ='' and datos3 = '' then 
		SELECT concat(valor1,'00') into resultado;
	end if;

	if datos1 <> ''  and datos2 <> '' and datos4 <> '' then 
		--resultado:=valor1||'0'||valor4;
		SELECT concat(concat(valor1,valor2),valor4) into resultado;
	end if;

	if datos1 <> ''  and datos2 = '' and datos4 <> '' then 
		--resultado:=valor1||'0'||valor4;
		SELECT concat(concat(valor1,'0'),valor4) into resultado;
	end if;

	if datos1 <> ''  and datos2 <> '' and datos3 = '' and datos4 = '' then 
		--resultado:=valor1||'0'||valor4;
		SELECT concat(concat(valor1,corre2),valor2) into resultado;
	end if;



RETURN ' tokens  = '||tokens;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION convierteletras_ult(character varying)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION convierteletras_ult(character varying) TO public;
GRANT EXECUTE ON FUNCTION convierteletras_ult(character varying) TO postgres;
GRANT EXECUTE ON FUNCTION convierteletras_ult(character varying) TO fernandao;
GRANT EXECUTE ON FUNCTION convierteletras_ult(character varying) TO germans;
GRANT EXECUTE ON FUNCTION convierteletras_ult(character varying) TO haroldr;
GRANT EXECUTE ON FUNCTION convierteletras_ult(character varying) TO alexanders;
GRANT EXECUTE ON FUNCTION convierteletras_ult(character varying) TO georginap;
