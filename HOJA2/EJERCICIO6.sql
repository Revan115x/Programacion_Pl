/*Realizar una FUNCION para saber si un departamento tiene o no empleados.
Recibe un nombre (da igual que venga en mayúsculas o minúsculas) y
comprueba:
 Que el departamento exista, si no existe devuelve NULL
 Que tenga empleados, si no los tiene devuelve -1
 En otro caso devuelve el número del departamento
Después hacer un PROCEDIMIENTO que recibe un nombre de departamento y
un apellido.
Llama a la función anterior para ver si el departamento existe y tiene
empleados, según lo que devuelva la función, muestra un mensaje o si existe y
tiene empleados, cambia al empleado recibido al departamento recibido.*/

CREATE OR REPLACE FUNCTION DEPARTAMENTO(DPTNOMBRE VARCHAR2)
RETURN NUMBER
AS
EXISTE_DEPT NUMBER;
NO_EMPLE NUMBER;
NUM_DEPART NUMBER;
BEGIN

SELECT COUNT(*) INTO EXISTE_DEPT
FROM DEPART
WHERE UPPER(DNOMBRE)=UPPER(DPTNOMBRE);
    
    IF EXISTE_DEPT = 0 THEN
        RETURN NULL;
    END IF;
    
SELECT COUNT(*) INTO NO_EMPLE
FROM EMPLE
WHERE DEPT_NO = (SELECT DEPT_NO
                FROM DEPART
                WHERE UPPER(DNOMBRE)=UPPER(DPTNOMBRE));

     IF NO_EMPLE = 0 THEN
        RETURN -1;
    END IF;
    
SELECT DEPT_NO INTO NUM_DEPART
FROM DEPART
WHERE UPPER(DNOMBRE)=UPPER(DPTNOMBRE);

    RETURN NUM_DEPART;
END;