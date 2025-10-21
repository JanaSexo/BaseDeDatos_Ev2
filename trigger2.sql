set serveroutput on;
UPDATE producto
SET stock = 0
WHERE idproducto = 'REV00001';

COMMIT;



CREATE OR REPLACE TRIGGER trg_validar_stock
BEFORE INSERT ON detalle_venta
FOR EACH ROW
DECLARE
    v_stock NUMBER;
   
BEGIN
    SELECT stock INTO v_stock
    FROM producto  
    WHERE idproducto =:NEW.idproducto;

    IF v_stock < :NEW.cantidad THEN
        RAISE_APPLICATION_ERROR(-20001, 'No hay stock.');
    
    END IF;
END;

EXEC libreria_pkg.comprar_libro('3', 'REV00001', 2, 1);

select * from venta;