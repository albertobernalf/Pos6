-- Function: obtienevlrletras(numeric)

-- DROP FUNCTION obtienevlrletras(numeric);

CREATE OR REPLACE FUNCTION obtienevlrletras(prvalor numeric)
  RETURNS character AS
$BODY$ 
DECLARE nUnidad numeric(30,0);
DECLARE nDecena numeric(30,0);
DECLARE nCentena numeric(30,0);
DECLARE Control_Pesos numeric(30,0);
DECLARE sValor numeric(30,0);
DECLARE Largo numeric(30,0);
DECLARE strVlrLetras character(1000);
BEGIN
    Largo = LENGTH(TRIM(CAST(prValor AS VARCHAR)));
    sValor = TRIM(CAST(prValor AS VARCHAR));
    strVlrLetras = '';
    IF Largo = 12 THEN
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),1,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),2,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),3,1);
       strVlrLetras = CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || ' ' || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE Decenas(nDecena,nUnidad) || ' MIL' END;
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),4,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),5,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),6,1);
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || ' ' || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE Decenas(nDecena,nUnidad) || ' MILLONES' END;
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),7,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),8,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),9,1);
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || ' ' || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE Decenas(nDecena,nUnidad) || ' MIL' END;
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),10,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),11,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),12,1);
       
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Decenas(nDecena,nUnidad) END;
       Control_Pesos = nCentena + nDecena + nUnidad;
    END IF;
    IF Largo = 11 THEN
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),1,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),2,1);
       strVlrLetras = Decenas(nDecena,nUnidad) || ' MIL';
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),3,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),4,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),5,1);
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || ' ' || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE Decenas(nDecena,nUnidad) || ' MILLONES' END;
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),6,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),7,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),8,1);
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || ' ' || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE Decenas(nDecena,nUnidad) || ' MIL' END;
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),9,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),10,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),11,1);
       
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Decenas(nDecena,nUnidad) END;
       Control_Pesos = nCentena + nDecena + nUnidad;
    END IF;
    IF Largo = 10 THEN
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),1,1);
       strVlrLetras = CASE WHEN Unidades(nUnidad) = 'UN' THEN '' ELSE Unidades(nUnidad) || ' ' END || 'MIL';
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),2,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),3,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),4,1);
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || ' ' || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE Decenas(nDecena,nUnidad) END || ' MILLONES' ;
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),5,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),6,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),7,1);
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || ' ' || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE Decenas(nDecena,nUnidad) END || ' MIL' ;
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),8,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),9,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),10,1);
       
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Decenas(nDecena,nUnidad) END;
       Control_Pesos = nCentena + nDecena + nUnidad;
    END IF; 
    IF Largo = 9 THEN
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),1,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),2,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),3,1);
       strVlrLetras = CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || ' ' || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE Decenas(nDecena,nUnidad) END || ' MILLONES' ;
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),4,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),5,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),6,1);
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || ' ' || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE Decenas(nDecena,nUnidad) END || ' MIL' ;
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),7,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),8,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),9,1);
       
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Decenas(nDecena,nUnidad) END;
       Control_Pesos = nCentena + nDecena + nUnidad;
    END IF; 
    IF Largo = 8 THEN
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),1,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),2,1);
       strVlrLetras = Decenas(nDecena,nUnidad) || ' MILLONES';
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),3,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),4,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),5,1);
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || ' ' || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE Decenas(nDecena,nUnidad) || ' MIL' END;
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),6,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),7,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),8,1);
       
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Decenas(nDecena,nUnidad) END;
       Control_Pesos = nCentena + nDecena + nUnidad;
    END IF; 
    IF Largo = 7 THEN
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),1,1);
       strVlrLetras = CASE WHEN Unidades(nUnidad) = 'UN' THEN 'UN MILLON' ELSE Unidades(nUnidad) || ' MILLONES' END ;
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),2,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),3,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),4,1);
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad)  END ;
       strVlrLetras = strVlrLetras || ' ' || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE Decenas(nDecena,nUnidad)  END || CASE WHEN nCentena+nDecena+nUnidad > 0 THEN ' MIL' ELSE '' END;
       --strVlrLetras = strVlrLetras || ' MIL';
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),5,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),6,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),7,1);
       
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Decenas(nDecena,nUnidad) END;
       Control_Pesos = nCentena + nDecena + nUnidad;
    END IF; 
    IF Largo = 6 THEN
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),1,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),2,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),3,1);
       strVlrLetras = CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad)  END;
       strVlrLetras = strVlrLetras || ' ' || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE Decenas(nDecena,nUnidad)  END || ' MIL';
       --strVlrLetras = strVlrLetras || ' MIL';       
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),4,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),5,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),6,1);
       
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Decenas(nDecena,nUnidad) END;
       Control_Pesos = nCentena + nDecena + nUnidad;
    END IF; 
    IF Largo = 5 THEN
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),1,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),2,1);
       strVlrLetras = Decenas(nDecena,nUnidad) || ' MIL';
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),3,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),4,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),5,1);
       
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Decenas(nDecena,nUnidad) END;
       Control_Pesos = nCentena + nDecena + nUnidad;
    END IF; 
    IF Largo = 4 THEN
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),1,1);
       strVlrLetras = CASE WHEN Unidades(nUnidad) = 'UN' THEN '' ELSE Unidades(nUnidad) || ' ' END || 'MIL';
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),2,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),3,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),4,1);
       
       strVlrLetras = strVlrLetras || CASE WHEN Centenas(nCentena,nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Centenas(nCentena,nDecena,nUnidad) END;
       strVlrLetras = strVlrLetras || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Decenas(nDecena,nUnidad) END;
       Control_Pesos = nCentena + nDecena + nUnidad;
    END IF; 
    IF Largo = 3 THEN
       nCentena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),1,1);
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),2,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),3,1);
       
       strVlrLetras = strVlrLetras || Centenas(nCentena,nDecena,nUnidad);
       strVlrLetras = strVlrLetras || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Decenas(nDecena,nUnidad) END;
       Control_Pesos = nCentena + nDecena + nUnidad;
       
    END IF;     
    IF Largo = 2 THEN
       nDecena = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),1,1);
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),2,1);
       
       strVlrLetras = strVlrLetras || CASE WHEN Decenas(nDecena,nUnidad) IS NULL THEN '' ELSE ' ' || Decenas(nDecena,nUnidad) END;
       Control_Pesos = nCentena + nDecena + nUnidad;
       
    END IF;
    IF Largo = 1 THEN
       nUnidad = SUBSTRING(TRIM(CAST(prValor AS VARCHAR)),1,1);
       
       strVlrLetras = strVlrLetras || Unidades(nUnidad);
       Control_Pesos = nCentena + nDecena + nUnidad;
       
    END IF;
    IF prValor > 0 THEN
       strVlrLetras = strVlrLetras || CASE WHEN Control_Pesos = 0 AND Largo >= 7 THEN ' DE' ELSE '' END || ' PESOS M/CTE.';
    ELSE
       strVlrLetras = 'CERO PESOS M/CTE.';   
    END IF;
    

    RETURN strVlrLetras;
END $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION obtienevlrletras(numeric)
  OWNER TO postgres;
GRANT EXECUTE ON FUNCTION obtienevlrletras(numeric) TO public;
GRANT EXECUTE ON FUNCTION obtienevlrletras(numeric) TO postgres;
GRANT EXECUTE ON FUNCTION obtienevlrletras(numeric) TO renea;
GRANT EXECUTE ON FUNCTION obtienevlrletras(numeric) TO fernandao;
GRANT EXECUTE ON FUNCTION obtienevlrletras(numeric) TO germans;
GRANT EXECUTE ON FUNCTION obtienevlrletras(numeric) TO haroldr;
GRANT EXECUTE ON FUNCTION obtienevlrletras(numeric) TO alexanders;
GRANT EXECUTE ON FUNCTION obtienevlrletras(numeric) TO georginap;
