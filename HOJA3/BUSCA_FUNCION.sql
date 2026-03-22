/* Pasar la función recibida a una función Busca_Funcion que devolverá el
nempleado de:
o Si no hay nadie con esa función, el nempleado del más antiguo en el
taller.
o Si hay varios, el más nuevo de los de esa función.
o Si hay uno solo, ese.
 Dar de alta un arreglo con la matricula recibida, el nempleado devuelto por
la anterior función, fecha de entrada la del sistema, fecha de salida a nulo e
importe el recibido si es mayor o igual a 0. Si no dejarlo a nulo.*/

CREATE OR REPLACE FUNCTION Busca_Funcion(TRABAJO VARCHAR2)
RETURN NUMBER
AS
EXISTE NUMBER;
EMPLNUM NUMBER;
BEGIN
    
    SELECT COUNT(*) INTO EXISTE
    FROM MECANICOS
    WHERE FUNCION=TRABAJO;
    
IF EXISTE = 0 THEN
    SELECT NEMPLEADO,MIN(FECHA_ALTA) INTO EMPLNUM
    FROM MECANICOS;

EXCEPTION
WHEN TOO_MANY_ROWS THEN
    SELECT NEMPLEADO INTO EMPLNUM
    FROM MECANICOS
    WHERE FUNCION=TRABAJO 
    AND FECHA_ALTA IN (SELECT MAX(FECHA_ALTA)
                       FROM MECANICOS
                       WHERE FUNCION=TRABAJO);

    RETURN EMPLNUM;
    
WHEN OTHERS THEN
    RETURN NULL;
    
END;

SELECT * FROM MECANICOS;