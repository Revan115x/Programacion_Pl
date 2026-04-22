/*Procedimiento que recibe una especie (puede venir en mayúsculas, minúsculas, mezcladas… o incluso solo una parte de la palabra, PER, G…)
y muestra los animales de esa especie: Nombre, raza, fecha de nacimiento, edad y MACHO o HEMBRA según sea uno u otro. 
*/

CREATE OR REPLACE PROCEDURE ESPECIES(ESPEC VARCHAR2)
AS

  CURSOR RAZA IS
  SELECT * FROM ANIMALES
  WHERE UPPER(ESPECIE) LIKE UPPER('%PER%');

BEGIN

  FOR I IN RAZA LOOP
    VER (I.NOMBRE||' '||I.ESPECIE||' '||I.FECHA_NACIMIENTO||' '||I.SEXO);
  END LOOP;

END;

SET SERVEROUTPUT ON;

EXECUTE ESPECIES('PER');