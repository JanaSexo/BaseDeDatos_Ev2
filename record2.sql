SET SERVEROUTPUT ON;

DECLARE
    TYPE titulo_rec IS RECORD (
        nombre  cliente.nombre%TYPE,
        titulo  producto.titulo%TYPE,
        autor   producto.autor%TYPE
    );

    CURSOR cur_compra IS
        SELECT c.nombre, p.titulo, p.autor
        FROM venta v
        JOIN detalle_venta dv ON v.idventa = dv.idventa
        JOIN producto p ON dv.idproducto = p.idproducto
        JOIN cliente c ON c.idcliente = v.idcliente
        WHERE v.idventa = &idven;

    v_compra titulo_rec;
BEGIN
    OPEN cur_compra;
    LOOP
        FETCH cur_compra INTO v_compra;
        EXIT WHEN cur_compra%NOTFOUND;

        dbms_output.put_line(v_compra.nombre || ' compró el título: "' || v_compra.titulo || '" del autor ' || v_compra.autor);
    END LOOP;
    CLOSE cur_compra;
END;

--SELECT * FROM VENTA;