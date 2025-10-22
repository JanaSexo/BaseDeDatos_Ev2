ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI:SS';
set serveroutput on;

select * from usuario;
CREATE SEQUENCE venta_seq START WITH 25 INCREMENT BY 1;
CREATE OR REPLACE PACKAGE libreria_pkg AS
    PROCEDURE comprar_libro(
        p_idcliente IN VARCHAR2,
        p_idproducto IN CHAR,
        p_cantidad IN NUMBER,
        p_idempleado IN NUMBER
    );
END libreria_pkg;

CREATE OR REPLACE PACKAGE BODY libreria_pkg AS

    PROCEDURE comprar_libro(
        p_idcliente IN VARCHAR2,
        p_idproducto IN CHAR,
        p_cantidad IN NUMBER,
        p_idempleado IN NUMBER
    ) IS
        v_precio   NUMBER(10,2);
        v_stock    NUMBER;
        v_total    NUMBER(10,2);
    BEGIN
        SELECT precio, stock INTO v_precio, v_stock
        FROM producto
        WHERE idproducto = p_idproducto;


        v_total := p_cantidad * v_precio;
        
        

        INSERT INTO venta (idventa, idcliente, fecha_hora,idempleado, total)
        VALUES (venta_seq.NEXTVAL, p_idcliente, SYSDATE ,p_idempleado, v_total);
        
        INSERT INTO detalle_venta (cantidad,idproducto,idventa)
        VALUES (p_cantidad, p_idproducto, venta_seq.CURRVAL);

        UPDATE producto
        SET stock = stock - p_cantidad
        WHERE idproducto = p_idproducto;

        COMMIT;

       

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('El libro no existe.');
        WHEN OTHERS THEN
            dbms_output.put_line('Error al procesar la compra: ' || SQLERRM);
    END comprar_libro;

END libreria_pkg;

EXEC libreria_pkg.comprar_libro('3', 'SEP00005', 2, 1);

select * from venta;
select * from detalle_venta;

DROP SEQUENCE venta_seq;


