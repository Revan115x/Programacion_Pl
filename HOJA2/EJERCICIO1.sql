/*Función que recibe el apellido de un empleado de la tabla EMPL y devuelve:
? La fecha de alta en la empresa si el empleado existe
? NULL si no existe*/

CREATE OR REPLACE FUNCTION FECHA_EMPLE (PAPELLIDO VARCHAR2)
RETURN DATE
IS
VFECHA DATE;
BEGIN
  SELECT FECHA_ALTA INTO VFECHA
  FROM EMPLE
  WHERE APELLIDO = PAPELLIDO;
  
  RETURN VFECHA;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END;

EXECUTE VER(FECHA_EMPLE('SANCHEZ'));