set serveroutput on;
DECLARE
    tit producto%ROWTYPE;
    tip tipo%ROWTYPE;
    
    CURSOR tipo_cur IS SELECT * FROM tipo;
    
    CURSOR tit_cur (id_tipo CHAR) IS  SELECT * FROM producto
    WHERE idtipo=id_tipo;
BEGIN
    OPEN tipo_cur;
    LOOP
        FETCH tipo_cur INTO tip;
        EXIT WHEN tipo_cur%NOTFOUND;
        dbms_output.put_line(tip.descripcion||':');
        OPEN tit_cur(tip.idtipo);
            LOOP
                FETCH tit_cur INTO tit;
                EXIT WHEN tit_cur%NOTFOUND;
                dbms_output.put_line('-'||tit.titulo);
            END LOOP;
        CLOSE tit_cur;
        
    END LOOP;
    CLOSE tipo_cur;

END;