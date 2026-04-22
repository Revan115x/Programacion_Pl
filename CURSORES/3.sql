/*Procedimiento que recibe el nombre de un animal y: 
Llama a una función que devuelve el identificador del animal. Si no encuentra ninguno devuelve -1, 
si encuentra varios devuelve -2
Si la función ha devuelto un identificador muestra las visitas de ese animal:
	Nombre del veterinario
	Motivo 
	Fecha y hora:   dd/mm hh24:mi
	Precio:     20€
Al final muestra cuántas visitas ha tenido y la suma de sus precios*/


/**funcion**/

CREATE OR REPLACE FUNCTION BUSCAR_ANIMAL( ANIM_NOMBRE VARCHAR2 )RETURN NUMBER
AS
  IDENT NUMBER;
BEGIN
  
  SELECT IDENT_ANIMAL INTO IDENT
  FROM ANIMALES
  WHERE UPPER(NOMBRE) = UPPER(ANIM_NOMBRE);

  RETURN IDENT;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN -1;
    WHEN TOO_MANY_ROWS THEN
      RETURN -2;
  
END;

SELECT * FROM ANIMALES;

SET SERVEROUTPUT ON;

EXECUTE VER ( BUSCAR_ANIMAL('JAS') );


CREATE OR REPLACE PROCEDURE NOMBRE(NOM_ESPEC VARCHAR2)
AS
  IDENTI NUMBER;
  
  CURSOR COSAS IS
  SELECT * FROM VISITAS
  WHERE IDENT_ANIMAL = IDENTI;
  
BEGIN

  IDENTI := BUSCAR_ANIMAL(NOM_ESPEC);
  
  FOR I IN COSAS LOOP
    VER (I.IDENT_ANIMAL||' '||I.FH_VISITA||' '||I.MOTIVO||' '||I.DIAGNOSTICO);
  END LOOP;

END;

EXECUTE NOMBRE('JAS');

SELECT * FROM VISITAS;