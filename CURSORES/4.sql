/*Procedimiento que muestra, por cada animal, su nombre, especie y cuántas visitas ha tenido.
(Se puede hacer perfectamente sin GROUP, o con GROUP, como queráis)*/


CREATE OR REPLACE PROCEDURE MOSTRAR_INFO_ANIMAL
AS
    
    IDENT NUMBER;
    
    CURSOR ANIMAL IS
    SELECT * FROM ANIMALES;
    
    CURSOR VISITA IS
    SELECT * FROM VISITAS
    WHERE IDENT_ANIMAL = IDENT;
    
BEGIN

    FOR I IN ANIMAL LOOP
            VER (I.IDENT_ANIMAL||' '||I.NOMBRE||' '||I.ESPECIE||' '||I.FECHA_NACIMIENTO||' '||I.SEXO);
        IDENT := I.IDENT_ANIMAL;
        
        VER (IDENT);
        
        FOR I IN VISITA LOOP
            VER (I.FH_VISITA||' '||I.MOTIVO);
        END LOOP;
        
    END LOOP;

END;

SET SERVEROUTPUT ON;

EXECUTE MOSTRAR_INFO_ANIMAL;
