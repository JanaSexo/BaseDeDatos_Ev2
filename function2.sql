CREATE OR REPLACE FUNCTION obtener_autor(p_idproducto IN CHAR)
RETURN VARCHAR2 IS v_autor VARCHAR2(100);
BEGIN
    SELECT autor INTO v_autor
    FROM producto
    WHERE idproducto = p_idproducto;

    RETURN v_autor;

END;

SELECT obtener_autor('LIB00001') AS autor FROM dual;
