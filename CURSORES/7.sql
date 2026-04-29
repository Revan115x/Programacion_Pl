/*Por cada cliente del taller mostrar:
Nombre, teléfono, año de alta (Cursor clientes)
De sus coches sacar: (Cursor coches)
Matrícula, modelo
Arreglos del más antiguo al más reciente, sacar fecha_entrada e importe. (cursor arreglos)
El total de los importes de los arreglos del coche
El total de los importes de todos sus coches
*/

CREATE OR REPLACE PROCEDURE CT_INFO
AS

    TOTAL_TODO NUMBER :=0;
    TOTAL_VEH NUMBER :=0;
    
    CURSOR CT IS
    SELECT * FROM CLIENTES_TALLER;
    
    CURSOR VEH(CL NUMBER) IS    
    SELECT MATRICULA,MODELO FROM COCHES_TALLER
    WHERE ncliente=CL;
    
    CURSOR ARRG(MAT VARCHAR2) IS
    SELECT FECHA_ENTRADA,FECHA_SALIDA,IMPORTE FROM ARREGLOS
    WHERE MATRICULA = MAT
    ORDER BY FECHA_ENTRADA;

BEGIN

    FOR I IN CT LOOP
        VER ('CLIENTES :'||' '||I.NOMBRE||' '||I.TELEFONO||' '||I.FECHA_ALTA);
        
        FOR J IN VEH(I.NCLIENTE) LOOP
            VER ('COCHES :'||' '||J.MATRICULA||' '||J.MODELO);
            
            TOTAL_VEH := 0;
            
            FOR M IN ARRG(J.MATRICULA)LOOP
                VER ('ARREGLOS :'||' '||M.FECHA_ENTRADA||' '||M.FECHA_SALIDA||' '||M.IMPORTE);
                
                TOTAL_VEH := TOTAL_VEH + M.IMPORTE;
                TOTAL_TODO := TOTAL_TODO + M.IMPORTE;
                
            END LOOP;
            
        END LOOP;
        
    END LOOP;
    
    VER ('TOTAL VEHICULO :'||' '||TOTAL_VEH);
     
    VER ('TOTAL TODOS LOS AUTOS :'||' '||TOTAL_TODO);
    
END;

EXECUTE CT_INFO;