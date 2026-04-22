CREATE OR REPLACE FUNCTION MECANICO_INF RETURN VARCHAR2
AS
    EMPL NUMBER;
    INFO VARCHAR2(4000) := '';
    
    CURSOR MEC IS 
        SELECT * FROM MECANICOS;
    
    CURSOR ARRG (P_EMPL NUMBER) IS
        SELECT A.MATRICULA,
               A.IMPORTE,
               A.FECHA_ENTRADA,
               TRUNC(SYSDATE - A.FECHA_ENTRADA) AS DIAS,
               C.NOMBRE
        FROM ARREGLOS A 
        JOIN COCHES_TALLER CT ON A.MATRICULA = CT.MATRICULA
        JOIN CLIENTES_TALLER C ON CT.NCLIENTE = C.NCLIENTE
        WHERE A.NEMPLEADO = P_EMPL
        ORDER BY A.FECHA_ENTRADA DESC
        FETCH FIRST 3 ROWS ONLY;

BEGIN

    FOR M IN MEC LOOP
        INFO := INFO || VER(M.NOMBRE || ' ' || M.TELEFONO);
        EMPL := M.NEMPLEADO;
        
        FOR A IN ARRG(EMPL) LOOP
            INFO := INFO || VER(A.MATRICULA || ' ' || 
                                 A.NOMBRE || ' ' ||
                                 A.IMPORTE || ' ' || 
                                 A.FECHA_ENTRADA || ' ' || 
                                 A.DIAS);
        END LOOP;
        
    END LOOP;
    
    RETURN INFO;

END;