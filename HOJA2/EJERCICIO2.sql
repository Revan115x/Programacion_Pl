Procedimiento que recibe: Apellido de un empleado y Nuevo oficio
Valida: Que exista el empleado llamando a la función anterior
Si no existe da mensaje de error y no hace nada más
Modifica el oficio con el nuevo oficio recibido y muestra un mensaje el oficio
que tenía y el que tiene ahora

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


CREATE OR REPLACE PROCEDURE NUEVA_CHAMBA_EMPLE (PAPELLIDO VARCHAR2, NOFICIO VARCHAR2)
  AS
  BEGIN
    IF FECHA_EMPLE (PAPELLIDO) IS NULL THEN
      VER ('EL EMPLEADO NO EXISTE');
    ELSE
    -- SELECT PARA EL OFICIO 
    
    
      UPDATE EMPLE
      SET OFICIO = NOFICIO
      WHERE APELLIDO = PAPELLIDO;
      VER ('MODIFICADO');
    END IF;
  END;

EXECUTE NUEVA_CHAMBA_EMPLE('SANSSCHEZ','TELEOPERADOR');


EXECUTE VER ( FECHA_EMPLE ('SANCHEZ'));


SELECT * FROM EMPLE;