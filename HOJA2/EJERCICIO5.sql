/*Codificar un procedimiento que permita borrar un empleado cuyo número se
pasará en la llamada.
 Si el empleado no existe se muestra un mensaje de que no existe.
 Si el empleado es director de otros empleados se muestra un mensaje
de que primero hay que asignar nuevos directores a los otros
empleados y no se borra el empleado.
 Si sí se puede borrar se muestra un mensaje indicando el apellido del
empleado borrado y el departamento al que pertenecía.*/

CREATE OR REPLACE PROCEDURE BORRAR_EMPLE(ENUM NUMBER)
AS
EMPLE_EXISTE NUMBER;
EMPLEADO NUMBER;
ERROR_EMPLE_DIRECTOR EXCEPTION;
ERROR_EMPLE EXCEPTION;
BEGIN

/*COMPRUEBO QUE EXISTE EMPLEADO*/
SELECT COUNT(*) INTO EMPLE_EXISTE
FROM EMPLE
WHERE emp_no=ENUM;
    
/*SI NO EXISTE SALTA ESTO*/
    IF EMPLE_EXISTE = 0 THEN
        RAISE ERROR_EMPLE;
    END IF;

/*COMPROBAR SI EL EMPLEADO ES DIRECTOR Y TIENE EMPLEADOS A CARGO*/
SELECT COUNT(*) INTO EMPLEADO
FROM EMPLE
WHERE 
OFICIO = 'DIRECTOR'
AND responsable=ENUM;

    IF EMPLEADO > 0 THEN
        RAISE ERROR_EMPLE_DIRECTOR;
    END IF;


/*BORRAR EL EMPLEADO SI ESTA TODO BIEN*/
DELETE FROM EMPLE
  WHERE emp_no=enum;
    
EXCEPTION
    WHEN ERROR_EMPLE THEN
    VER('NO EXISTE EL EMPLEADO');
    
    WHEN ERROR_EMPLE_DIRECTOR THEN
    VER('HAY QUE ASIGNAR NUEVOS DIRECTORES A LOS OTROS EMPLEADOS');
END;

EXECUTE BORRAR_EMPLE(7369);