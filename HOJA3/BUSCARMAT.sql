/*Mediante una función Busca_Matricula a la que le pasamos la matrícula
recibida comprobamos que esta exista.
Si existe devolvemos true.
Si no existe:
Comprobamos que la matrícula tenga 4 dígitos y tres letras. Si no es así
la función devuelve false.
Si está bien la damos de alta en Coches_Taller dejando el resto de
campos a nulo excepto ncliente que será 0. Más adelante ya
rellenaremos los datos necesarios.*/

CREATE OR REPLACE FUNCTION Busca_Matricula(MAT VARCHAR2)
RETURN BOOLEAN
AS
EXIST_MAT NUMBER;
BEGIN

IF NOT REGEXP_LIKE (MAT,'^[0-9]{4}[A-Z]{3}$')THEN
    RETURN FALSE;
END IF;

  SELECT COUNT(*) INTO EXIST_MAT
  FROM COCHES_TALLER
  WHERE MATRICULA=MAT;
  
IF EXIST_MAT = 0 THEN
    RAISE NO_EXISTE;
ELSE
    RETURN TRUE;
END IF;
    
    EXCEPTION
    WHEN NO_EXISTE THEN
    RETURN FALSE;
    
END;

SET SERVEROUTPUT ON;

EXECUTE VER(Busca_Matricula('6546LMD'));
