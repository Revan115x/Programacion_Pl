/*Procedimiento que recibe un departamento y un porcentaje. Busca el
empleado con menos salario de dicho departamento para subirle un porcentaje
que recibe como parámetro. Validar que con ese porcentaje no supere la media
del departamento, en cuyo caso no se modifica.*/


CREATE OR REPLACE PROCEDURE SUBIR_SALARIO(PCOD NUMBER, DPORCENTAJE NUMBER)
AS
    NO NUMBER;
    V_EMP EMPLE.EMP_NO%TYPE;
    V_SAL EMPLE.SALARIO%TYPE;
    V_MEDIA NUMBER;
    V_NUEVO_SAL NUMBER;
    ERROR_DEPART EXCEPTION;
BEGIN
    -- Comprobar si hay empleados en el departamento
    SELECT COUNT(*) INTO NO
    FROM EMPLE
    WHERE DEPT_NO = PCOD;

    IF NO = 0 THEN
        RAISE ERROR_DEPART;
    END IF;

    -- Buscar empleado con menor salario
    SELECT EMP_NO, SALARIO
    INTO V_EMP, V_SAL
    FROM EMPLE
    WHERE DEPT_NO = PCOD
    AND SALARIO = (
        SELECT MIN(SALARIO)
        FROM EMPLE
        WHERE DEPT_NO = PCOD
    );

    -- Calcular media del departamento
    SELECT AVG(SALARIO)
    INTO V_MEDIA
    FROM EMPLE
    WHERE DEPT_NO = PCOD;

    -- Calcular nuevo salario
    V_NUEVO_SAL := V_SAL + (V_SAL * DPORCENTAJE / 100);

    -- Validar si supera la media
    IF V_NUEVO_SAL <= V_MEDIA THEN
        UPDATE EMPLE
        SET SALARIO = V_NUEVO_SAL
        WHERE EMP_NO = V_EMP;

        VER('SALARIO ACTUALIZADO');
    ELSE
        VER('NO SE PUEDE SUBIR, SUPERA LA MEDIA DEL DEPARTAMENTO');
    END IF;

EXCEPTION
    WHEN ERROR_DEPART THEN
        VER('NO EXISTE ESE DEPARTAMENTO');
END;

EXECUTE SUBIR_SALARIO (10,5);
