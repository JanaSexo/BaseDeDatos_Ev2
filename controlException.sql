DECLARE
    exce_noempleado EXCEPTION;
    PRAGMA EXCEPTION_INIT(exce_noempleado, -20001);

    v_nombreemp     VARCHAR2(50);
    v_idempleado    VARCHAR2(15);
BEGIN
    BEGIN
        
        SELECT nombre, idempleado INTO v_nombreemp, v_idempleado
        FROM empleado
        WHERE idempleado = 23;

        dbms_output.put_line('El id de ' || v_nombreemp || ' es: ' || v_idempleado);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE exce_noempleado;
    END;

EXCEPTION
    WHEN exce_noempleado THEN
        dbms_output.put_line('Error -20001: El empleado no existe.');

END;

set serveroutput on;