UPDATE producto
SET stock = 0
WHERE idproducto = 'REV00001';

COMMIT;

CREATE OR REPLACE TRIGGER trg_validar_stock
BEFORE INSERT ON venta
FOR EACH ROW
DECLARE
    v_stock NUMBER;
BEGIN
    SELECT stock INTO v_stock
    FROM producto
    WHERE idproducto = :NEW.idproducto;

    IF v_stock <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No hay stock.');
    END IF;
END;
