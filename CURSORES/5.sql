/* Recibir una  función de mecánico y mostrar:
Nombre y teléfono de cada uno de sus mecánicos   (1er cursor)
Por cada mecánico mostrar los tres últimos arreglos que ha hecho 
(matrícula del coche, nombre del dueño, importe, fecha de entrada y días que ha estado o que lleva en el taller.  (2do cursor)
*/

CREATE OR REPLACE FUNCTION MECANICO_INF RETURN VARCHAR2
AS
    INF VARCHAR2(5000):= '';
    
    CURSOR DATOS IS
    SELECT * FROM MECANICOS;
    
    CURSOR ARRG(P_ID NUMBER) IS
    SELECT ct.nombre,A.MATRICULA,A.FECHA_ENTRADA,A.FECHA_SALIDA,TRUNC(SYSDATE - FECHA_ENTRADA )DIAS,A.IMPORTE
    FROM ARREGLOS A JOIN coches_taller C
    ON a.matricula=c.matricula JOIN clientes_taller CT
    ON c.ncliente=ct.ncliente
    WHERE a.nempleado=P_ID;

BEGIN

    FOR I IN DATOS LOOP
        
        INF := INF ||' MECANICOS '|| I.NOMBRE||' '||I.TELEFONO ||CHR(10);
        
        FOR J IN ARRG(I.NEMPLEADO) LOOP
        
        INF := INF ||' ARREGLOS: '|| J.NOMBRE||' '||J.MATRICULA||' '||J.FECHA_ENTRADA||' '||J.FECHA_SALIDA||' '||J.DIAS||' '||J.IMPORTE||CHR(10);
        
        END LOOP;
        
    END LOOP;
    
    RETURN INF;
END;

SET SERVEROUTPUT ON;

EXECUTE VER(MECANICO_INF());