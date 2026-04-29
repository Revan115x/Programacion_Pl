/*Por cada coche mostrar:
Sus datos 
Los arreglos terminados ordenados por fecha de entrada. Al último de cada coche modificarle el importe rebajándolo un 10%.
*/

CREATE OR REPLACE PROCEDURE COCHES_INF
AS

    CURSOR VEH IS
    SELECT * FROM COCHES_TALLER;
    
    CURSOR ARRGL (MAT VARCHAR2 )IS
    SELECT MATRICULA,FECHA_ENTRADA,FECHA_SALIDA,IMPORTE FROM ARREGLOS
    WHERE MATRICULA = MAT;
    
BEGIN

    FOR I IN VEH LOOP
    VER (I.MATRICULA||' '||I.MODELO);
        FOR J IN ARRGL(I.MATRICULA) LOOP
            VER (J.MATRICULA||' '||J.FECHA_ENTRADA||' '||J.FECHA_SALIDA||' '||J.IMPORTE);
         END LOOP;
    END LOOP;
END;

EXECUTE COCHES_INF(); 
