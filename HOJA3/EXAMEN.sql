1. Función EX_BUSCAR_DUEÑO. (1 pto)
Recibe un nombre de un dueño (puede estar en mayúsculas/minúsculas/mezcladas) y lo busca en la tabla
DUEÑOS. Si existe devuelve el DNI del dueño y si no existe devuelve NULL.

SELECT * FROM ANIMALES;

CREATE OR REPLACE FUNCTION EX_BUSCAR_DUENO(PNOMBRE VARCHAR2)
RETURN VARCHAR2
AS
    EXISTE_DUENO DUEÑOS.DNI%TYPE;
BEGIN
    SELECT DNI INTO EXISTE_DUENO
    FROM DUEÑOS
    WHERE UPPER(NOMBRE) = UPPER(PNOMBRE);

    RETURN EXISTE_DUENO;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;

/*2. Procedimiento EX_ALTA_ANIMAL. (3 ptos)
Recibe el nombre de un animal, la especie, la fecha de nacimiento, el sexo y el nombre del dueño.
Mediante excepciones validar:
a) El nombre tiene que tener al menos 2 caracteres, si no mensaje de error y acaba el
procedimiento.
b) Si la especie no es ni PERRO ni GATO, mensaje de error y acaba el procedimiento
c) Si el sexo no es ni MACHO ni HEMBRA, mensaje de error y acaba el procedimiento
d) La fecha de nacimiento ha de ser anterior a la del sistema, si no es así mensaje de error y
acaba el procedimiento.
e) Llamar a la función EX_BUSCAR_DUEÑO pasando el nombre del dueño recibido. Si devuelve
NULL mostrar un mensaje diciendo que primero hay que registrar al dueño y acabar el
procedimiento.*/

SET SERVEROUTPUT ON;

SELECT * FROM DUEÑOS;

CREATE OR REPLACE PROCEDURE EX_ALTA_ANIMAL(NANIMAL VARCHAR2,NESPECIE VARCHAR2,FECHA DATE,NSEXO VARCHAR2,NDUEÑO VARCHAR2)
AS
ERROR_LENGTH EXCEPTION;
NO_ESPECIE EXCEPTION;
NO_SEXO EXCEPTION;
NO_FECHA EXCEPTION;
NO_DNI EXCEPTION;
DNI DUEÑOS.DNI%TYPE;
SUM_ANIMAL NUMBER;
BEGIN

    IF LENGTH (NANIMAL) < 2 THEN
        RAISE ERROR_LENGTH;
    END IF;
    
    IF UPPER(NESPECIE) NOT IN ('PERRO','GATO')THEN
        RAISE NO_ESPECIE;
    END IF;
     
    IF UPPER(NSEXO) NOT IN ('M','H')THEN
        RAISE NO_SEXO;
    END IF;
     
    IF FECHA > SYSDATE THEN
        RAISE NO_FECHA;
    END IF;
    
    DNI := EX_BUSCAR_DUENO (NDUEÑO);
    
    IF DNI IS NULL THEN
        RAISE NO_DNI;
    END IF;
     
    SELECT MAX(IDENT_ANIMAL) INTO SUM_ANIMAL
    FROM ANIMALES;
    
    INSERT INTO ANIMALES (IDENT_ANIMAL, NOMBRE, ESPECIE, FECHA_NACIMIENTO,SEXO,DNI_DUEÑO)
    VALUES (SUM_ANIMAL + 1 ,NANIMAL ,NESPECIE ,FECHA ,NSEXO ,DNI);
    
    VER('ALTA TERMINADA......................');
     
EXCEPTION
    WHEN ERROR_LENGTH THEN
        VER('NO CUMPLE LOS DOS CARACTERES');
    WHEN NO_ESPECIE THEN
        VER ('BRO TIENE QUE SER O PERRA O GATA');
    WHEN NO_SEXO THEN
        VER ('NO TIENE SEXO');
    WHEN NO_FECHA THEN
        VER('NO PUEDE SER SUPERIOR A LA FECHA ACTUAL');
    WHEN NO_DNI THEN
        VER ('HAY QUE REGISTRAR AL DUEÑO');
END;

EXECUTE EX_ALTA_ANIMAL ('YUMMY','GATO',TO_DATE('14/05/2019','DD/MM/YYYY'),'H','Esther Flores');
/

/*3. Función EX_BUSCA_VETERINARIO (2 pto)
Recibe un dato PDATO. La función busca los veterinarios que tienen ese PDATO como nombre (en
mayúsculas o minúsculas) o ese PDATO como teléfono. Si hay un veterinario, muestra todos sus datos. Si
no hay ninguno, muestra un mensaje indicándolo. La función devuelve el número del colegiado o NULL
dependiendo de si lo ha encontrado o no.*/

CREATE OR REPLACE FUNCTION EX_BUSCA_VETERINARIO(PDATO VARCHAR2)RETURN NUMBER
AS
    V_NUMCOLE   VETERINARIOS.NUMCOLEGIADO%TYPE;
    V_NOMBRE    VETERINARIOS.NOMBRE%TYPE;
    V_TELEFONO  VETERINARIOS.TELEFONO%TYPE;
BEGIN
    SELECT NUMCOLEGIADO, NOMBRE, TELEFONO
    INTO V_NUMCOLE, V_NOMBRE, V_TELEFONO
    FROM VETERINARIOS
    WHERE UPPER(NOMBRE) = UPPER(PDATO)
       OR TELEFONO = PDATO;

    VER('ENCONTRADO:');
    VER('COLEGIADO: ' || V_NUMCOLE);
    VER('NOMBRE: ' || V_NOMBRE);
    VER('TELEFONO: ' || V_TELEFONO);

    RETURN V_NUMCOLE;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        VER('NO EXISTE NINGUN VETERINARIO');
        RETURN NULL;

    WHEN TOO_MANY_ROWS THEN
        VER('HAY VARIOS VETERINARIOS CON ESE DATO');
        RETURN NULL;
END;
/*4. Procedimiento EX_MUESTRA_ANIMALES. (2 ptos)
Por cada dueño:
Muestra su nombre, su teléfono y año en el que se dio de alta en la clínica.
Después, muestra los animales de este dueño: saca el nombre, la especie y los años que tiene el
animal.
Al acabar indica cuantos gatos y cuantos perros tiene el dueño*/

5. Procedimiento EX_BUCLE_ORDINARIA (2 ptos)
Recibe dos números, comprueba que sean distintos, si no lo son mensaje de error y no se hace nada más.
Si son distintos voy multiplicando el menor por sí mismo hasta sobrepasar el número mayor.

Por ejemplo:
EXECUTE EX_BUCLE_ORDINARIA (2, 40)
Se muestra: 2, 4, 8, 16, 32, 64

EXECUTE EX_BUCLE_ORDINARIA (40, 2)
Se muestra: 2, 4, 8, 16, 32, 64