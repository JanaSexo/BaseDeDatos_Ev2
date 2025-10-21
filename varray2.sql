DECLARE
    TYPE tipo_varray IS VARRAY(5) OF VARCHAR2(50);
    v_toplibros tipo_varray := tipo_varray();
BEGIN
    FOR r IN (
        SELECT p.titulo
        FROM producto p
        JOIN detalle_venta v ON p.idproducto = v.idproducto
        GROUP BY p.titulo
        ORDER BY COUNT(*) DESC
        FETCH FIRST 5 ROWS ONLY
    ) LOOP
        v_toplibros.EXTEND;
        v_toplibros(v_toplibros.COUNT) := r.titulo;
    END LOOP;

    FOR i IN 1 .. v_toplibros.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Libro más comprado #' || i || ': ' || v_toplibros(i));
    END LOOP;
END;

--set serveroutput on;