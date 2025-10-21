DECLARE
    v_cant NUMBER;
BEGIN
    dbms_output.put_line('Ventas por empleado:');

    FOR emp IN (SELECT * FROM empleado) LOOP
        SELECT COUNT(*) INTO v_cant
        FROM venta
        WHERE idempleado = emp.idempleado;

        dbms_output.put_line(emp.nombre || ' ' || emp.apellido || ': ');
        dbms_output.put_line( ' -'|| v_cant || ' ventas');
    END LOOP;
END;

--set serveroutput on;