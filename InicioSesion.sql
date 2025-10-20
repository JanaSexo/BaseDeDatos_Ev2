CREATE OR REPLACE PROCEDURE iniciar_sesion(
    p_usuario IN VARCHAR2,
    p_clave IN VARCHAR2,
    p_mensaje OUT VARCHAR2
)AS
    v_idcliente NUMBER(8);
    v_idempleado NUMBER(8);
    
    
BEGIN
    SELECT idcliente,idempleado
    INTO v_idcliente,v_idempleado
    FROM usuario
    WHERE nombreusuario = p_usuario 
    AND clave = p_clave;
    
IF v_idcliente IS NOT NULL THEN
    p_mensaje := 'Sesión de cliente iniciada exitosamente.';
ELSE
    p_mensaje := 'Sesión de empleado iniciada exitosamente.';
END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_mensaje := 'Credenciales incorrectas.';
    WHEN OTHERS THEN
        p_mensaje := 'Error en el inicio de sesión.';
END iniciar_sesion;

--SET SERVEROUTPUT ON;
DECLARE
    mensaje VARCHAR2(50);
BEGIN
    iniciar_sesion('Manuuel','holasoymanuel',mensaje);
    dbms_output.put_line(mensaje);
END;

DECLARE
    mensaje VARCHAR2(50);
BEGIN
    iniciar_sesion('Manuuel','holasoymanuel',mensaje);
    dbms_output.put_line(mensaje);
END;

DECLARE
    mensaje VARCHAR2(50);
BEGIN
    iniciar_sesion('Manuuel','hola',mensaje);
    dbms_output.put_line(mensaje);
END;

    