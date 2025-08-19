-- Function: convierteletras(character varying)

-- DROP FUNCTION convierteletras(character varying);

CREATE OR REPLACE FUNCTION convierteletras(variable character varying)
  RETURNS character varying AS
$BODY$
DECLARE
                numeroTipoCha varchar(1000);
		resultado varchar(100);
                letras varchar(1000);
		palabras varchar(1000);
		posicion integer := 1;
                token varchar(50); 
                cuenta integer := 1;
		voy integer := 1;
		

BEGIN
   letras := variable;
   numeroTipoCha:= '';
   palabras := variable;
       
   while length(palabras) >5 loop
	SELECT strpos(palabras, ' ' ) INTO posicion;
	SELECT substring(palabras, posicion + 2, length(palabras)) into palabras;
	cuenta := cuenta+1;
   end loop;

  
   while LENGTH(letras) >1 loop
	
	SELECT strpos(letras, ' ' ) INTO posicion;
	posicion := posicion -1;
	select substring(cast(letras as text) ,1,posicion) into token;
	select valor  into  resultado from conversionDinero where id= token;
        select concat(rtrim(numeroTipoCha,''),rtrim(resultado,'')) into numeroTipoCha;
	SELECT substring(letras, posicion + 2, length(letras)) into letras;
	voy := voy +1;
	if (voy >= cuenta) then
		--RETURN numeroTipoCha||' '||length(letras)||'cuenta='||cuenta	;
		RETURN numeroTipoCha	;
	--posicion:= 0;
	end if;


   end loop;


RETURN numeroTipoCha||'por aquip' ;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION convierteletras(character varying)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION convierteletras(character varying) TO public;
GRANT EXECUTE ON FUNCTION convierteletras(character varying) TO postgres;
GRANT EXECUTE ON FUNCTION convierteletras(character varying) TO fernandao;
GRANT EXECUTE ON FUNCTION convierteletras(character varying) TO germans;
GRANT EXECUTE ON FUNCTION convierteletras(character varying) TO haroldr;
GRANT EXECUTE ON FUNCTION convierteletras(character varying) TO alexanders;
GRANT EXECUTE ON FUNCTION convierteletras(character varying) TO georginap;
