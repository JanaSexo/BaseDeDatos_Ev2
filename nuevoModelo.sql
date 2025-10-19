--Base de datos origunal de:
REM Empresa           :  BookStore S.A.C.
REM Software          :  Sistema de Comercialización y Control de Stock  (SCCS)
REM DBMS              :  ORACLE 12G o Superior
REM Esquema           :  BookStore
REM Script            :  Crea el esquema y carga Datos de Prueba
REM Autor             :  Eric Gustavo Coronel Castillo
REM Email             :  gcoronelc@gmail.com
REM Sitio Web         :  www.desarrollasoftware.com
REM Blog              :  gcoronelc.blogspot.com
REM Cursos virtuales  :  gcoronelc.github.io    

-- =============================================
-- Ultimos cambios
-- =============================================
/*

20-Junio-2017: Se agrego la tabla USUARIO.

*/


-- ============================================
-- DESHABILITAR SALIDAS
-- ============================================

-- SET TERMOUT OFF
-- SET ECHO OFF

-- =============================================
-- CRACIÓN DEL USUARIO
-- =============================================

--DECLARE
--	N INT;
--	COMMAND VARCHAR2(200);
--BEGIN
--	COMMAND := 'DROP USER BOOKSTORE CASCADE';
--	SELECT COUNT(*) INTO N
--	FROM DBA_USERS
--	WHERE USERNAME = 'BOOKSTORE';
--	IF ( N = 1 ) THEN
--		EXECUTE IMMEDIATE COMMAND;
--	END IF;
--END;
--/

-- Valido para la versión 12
--ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

--CREATE USER BOOKSTORE IDENTIFIED BY Abcdef123456;

--GRANT CONNECT, RESOURCE TO BOOKSTORE;
--GRANT CREATE VIEW TO BOOKSTORE;


-- =============================================
-- CONECTARSE A ORACLE
-- =============================================

--CONNECT BOOKSTORE/ADMIN

  
  
-- ==========================================================
-- Creación de la Tablas
-- ==========================================================
CREATE TABLE CLIENTE 
    ( 
     idcliente NUMBER (8)  NOT NULL , 
     nombre    VARCHAR2 (100) NOT NULL, 
     apellido  VARCHAR2 (100)  NOT NULL , 
     idusuario NUMBER (8)  NOT NULL 
    ) 
;

ALTER TABLE CLIENTE 
    ADD CONSTRAINT CLIENTE_PK PRIMARY KEY ( idcliente ) ;

CREATE TABLE DETALLE_VENTA 
    ( 
     cantidad   NUMBER (3)  NOT NULL , 
     idproducto CHAR (8)  NOT NULL , 
     idventa    NUMBER (8)  NOT NULL 
    ) 
;

CREATE TABLE EMPLEADO 
    ( 
     idempleado NUMBER (8)  NOT NULL , 
     nombre     VARCHAR2 (100)  NOT NULL , 
     apellido   VARCHAR2 (100)  NOT NULL , 
     idusuario  NUMBER (8)  NOT NULL 
    ) 
;

ALTER TABLE EMPLEADO 
    ADD CONSTRAINT EMPLEADO_PK PRIMARY KEY ( idempleado ) ;

CREATE TABLE PRODUCTO 
    ( 
     idproducto CHAR (8)  NOT NULL , 
     titulo     VARCHAR2 (150)  NOT NULL , 
     idtipo     CHAR (3)  NOT NULL , 
     autor      VARCHAR2 (150)  NOT NULL , 
     nroedicion NUMBER (3)  NOT NULL , 
     precio     NUMBER (10,2)  NOT NULL , 
     stock      NUMBER (8)  NOT NULL 
    ) 
;

ALTER TABLE PRODUCTO 
    ADD CONSTRAINT PRODUCTO_PK PRIMARY KEY ( idproducto ) ;
    
  

CREATE TABLE TIPO 
    ( 
     idtipo      CHAR (3)  NOT NULL , 
     descripcion VARCHAR2 (100)  NOT NULL 
    ) 
;

ALTER TABLE TIPO 
    ADD CONSTRAINT TIPO_PK PRIMARY KEY ( idtipo ) ;

CREATE TABLE USUARIO 
    ( 
     idusuario     NUMBER (8)  NOT NULL , 
     idcliente     NUMBER (8) , 
     idempleado    NUMBER (8) , 
     nombreusuario VARCHAR2 (20)  NOT NULL , 
     clave         VARCHAR2 (20)  NOT NULL , 
     activo        NUMBER (1)  NOT NULL 
    ) 
;

ALTER TABLE USUARIO 
    ADD CONSTRAINT USUARIO_PK PRIMARY KEY ( idusuario ) ;

ALTER TABLE USUARIO 
    ADD CONSTRAINT USUARIO__UN UNIQUE ( nombreusuario ) ;

CREATE TABLE VENTA 
    ( 
     idventa    NUMBER (8)  NOT NULL , 
     total      NUMBER (7)  NOT NULL , 
     fecha_hora DATE  NOT NULL , 
     idcliente  NUMBER (8)  NOT NULL , 
     idempleado NUMBER (8)  NOT NULL 
    ) 
;

ALTER TABLE VENTA 
    ADD CONSTRAINT VENTA_PK PRIMARY KEY ( idventa ) ;

ALTER TABLE CLIENTE 
    ADD CONSTRAINT CLIENTE_USUARIO_FK FOREIGN KEY 
    ( 
     idusuario
    ) 
    REFERENCES USUARIO 
    ( 
     idusuario
    ) 
;

ALTER TABLE DETALLE_VENTA 
    ADD CONSTRAINT DETALLE_VENTA_PRODUCTO_FK FOREIGN KEY 
    ( 
     idproducto
    ) 
    REFERENCES PRODUCTO 
    ( 
     idproducto
    ) 
;

ALTER TABLE DETALLE_VENTA 
    ADD CONSTRAINT DETALLE_VENTA_VENTA_FK FOREIGN KEY 
    ( 
     idventa
    ) 
    REFERENCES VENTA 
    ( 
     idventa
    ) 
;

ALTER TABLE EMPLEADO 
    ADD CONSTRAINT EMPLEADO_USUARIO_FK FOREIGN KEY 
    ( 
     idusuario
    ) 
    REFERENCES USUARIO 
    ( 
     idusuario
    ) 
;

ALTER TABLE PRODUCTO 
    ADD CONSTRAINT PRODUCTO_TIPO_FK FOREIGN KEY 
    ( 
     idtipo
    ) 
    REFERENCES TIPO 
    ( 
     idtipo
    ) 
;

ALTER TABLE VENTA 
    ADD CONSTRAINT VENTA_CLIENTE_FK FOREIGN KEY 
    ( 
     idcliente
    ) 
    REFERENCES CLIENTE 
    ( 
     idcliente
    ) 
;

ALTER TABLE VENTA 
    ADD CONSTRAINT VENTA_EMPLEADO_FK FOREIGN KEY 
    ( 
     idempleado
    ) 
    REFERENCES EMPLEADO 
    ( 
     idempleado
    ) 
;




-- ==========================================================
-- Cargar Datos de Prueba
-- ==========================================================

-- Tabla: tipo

   Insert Into tipo( idtipo,descripcion) Values( 'LIB','Libro');
   Insert Into tipo( idtipo,descripcion) Values( 'REV','Revista');
   Insert Into tipo( idtipo,descripcion) Values( 'SEP','Separata');


-- Libros
    

   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00001','LIB','Power Builder','William B. Heys',1, 5000,1000);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00002','LIB','Visual Basic','Joel Carrasco',2,4000,1500);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00003','LIB','Programación C/S con VB','Kenneth L. Spenver',1,4000,450);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00004','LIB','JavaScript a través de Ejemplos','Jery Honeycutt',1,3000,720);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00005','LIB','UNIX en 12 lecciones','Juan Matías Matías',1,2000,500);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00006','LIB','Visual Basic y SQL Server','Eric G. Coronel Castillo',1,3000,5000);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00007','LIB','Power Builder y SQL Server','Eric G. Coronel Castillo',1,3000,5000);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00008','LIB','PHP y MySQL','Eric G. Coronel Castillo',1,5000,5000);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00009','LIB','Lenguaje de Programación Java 2','Eric G. Coronel Castillo',1,5000,5000);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('LIB00010','LIB','Oracle Database','Eric G. Coronel Castillo',1,7000,5000);


-- Revistas

   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('REV00001','REV','Eureka','GrapPeru',1,4000,770);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('REV00002','REV','El Programador','Desarrolla Software SAC',1,6000,1200);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('REV00003','REV','La Revista del Programador','DotNET SAC',1,10000,590);


-- Separatas

   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('SEP00001','SEP','Java Orientado a Objetos','Eric G. Coronel C.',1000.00,500);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('SEP00002','SEP','Desarrollo Web con Java','Eric G. Coronel C.',1,1000,500);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('SEP00003','SEP','Electrónica Aplicada','Hugo Valencia M.',1,2000,500);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('SEP00004','SEP','Circuitos Digitales','Hugo Valencia M.',1,2000,500);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('SEP00005','SEP','SQL Server Básico','Sergio Matsukawa',1,2000,500);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('SEP00006','SEP','SQL Server Avanzado','Sergio Matsukawa',1,2000,500);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('SEP00007','SEP','Windows Server Fundamentos','Hugo Valencia',1,1000,1190);
   Insert Into producto( idproducto,idtipo,titulo,autor,nroedicion,precio,stock ) 
    Values('SEP00008','SEP','windows Server Administración','Sergio Matsukawa ',1,1000,2000);

-- usuario empleado
    
    INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(1,NULL,1,'EmilioAR','holasoyemilio',1);
     INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(2,NULL,2,'KathiaSR','holasoykathia',1);
     INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(3,NULL,3,'FelixWon','gato',1);
     INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(4,NULL,4,'EduCastillo','holasoyeduardo',1);
     INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(5,NULL,5,'LauraMi','holasoylaura',1);
    INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(6,NULL,6,'KennyDel','holasoyken',1);
     INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(7,NULL,7,'JoseElvis','elvistek',1);

-- empleados

   Insert Into empleado(idempleado,apellido,nombre,idusuario) 
     Values(1,'AGUERO RAMOS','EMILIO',1);
   Insert Into empleado(idempleado,apellido,nombre,idusuario) 
     Values(2,'SANCHEZ ROMERO','KATHIA',2);
   Insert Into empleado(idempleado,apellido,nombre,idusuario) 
     Values(3,'LUNG WON','FELIX',3);
   Insert Into empleado(idempleado,apellido,nombre,idusuario) 
     Values(4,'CASTILLO RAMOS','EDUARDO',4);
   Insert Into empleado(idempleado,apellido,nombre,idusuario) 
     Values(5,'MILICICH FLORES','LAURA',5);
   Insert Into empleado(idempleado,apellido,nombre,idusuario) 
     Values(6,'DELGADO BARRERA','KENNETH',6);
   Insert Into empleado(idempleado,apellido,nombre,idusuario) 
     Values(7,'GARCIA SOLIS','JOSE ELVIS',7);

--usuario clientes

    INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(8,1,NULL,'Manuuel','holasoymanuel',1);
     INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(9,2,NULL,'SelmmaW','holasoyselma',1);
     INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(10,3,NULL,'Karlitox','jojojo',1);
     INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(11,4,NULL,'Shelitto','marselo',1);
     INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(12,5,NULL,'Lucy234','holasoylucy',1);
    INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(13,6,NULL,'Panxito','holasoypancho',1);
     INSERT INTO usuario(idusuario,idcliente,idempleado,nombreusuario,clave,activo)
        VALUES(14,7,NULL,'Almendritaa','almendrabkn',1);
  
  -- clientes
    
    Insert Into cliente(idcliente,apellido,nombre,idusuario) 
     Values(1,'ZAMBRANO SANCHEZ','MANUEL',8);
   Insert Into cliente(idcliente,apellido,nombre,idusuario) 
     Values(2,'WILSON','SELMA',9);
   Insert Into cliente(idcliente,apellido,nombre,idusuario) 
     Values(3,'HERNANDEZ GARCIA','CARLOS',10);
   Insert Into cliente(idcliente,apellido,nombre,idusuario) 
     Values(4,'RODRIGUEZ PEREZ','MARCELO',11);
   Insert Into cliente(idcliente,apellido,nombre,idusuario) 
     Values(5,'RODRIGUEZ GONZALEZ','LUCIA',12);
   Insert Into cliente(idcliente,apellido,nombre,idusuario) 
     Values(6,'SANCHEZ GARCIA','FRANCISCO',13);
   Insert Into cliente(idcliente,apellido,nombre,idusuario) 
     Values(7,'QUISPE FLORES','ALMENDRA',14);
  
   
-- ventas

   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(01,1,   5,SYSDATE - 60,10000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(02,2,    1,SYSDATE - 59,5000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(03,3,  3,SYSDATE - 58,8000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(04,4,  2,SYSDATE - 58,8000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(05,5,  1,SYSDATE - 57,6000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(06,6,  5,SYSDATE - 57,5000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(07,7,  6,SYSDATE - 56,8000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(08,6, 3,SYSDATE - 55,4000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(09,4,  6,SYSDATE - 54,20000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(10,2,   5,SYSDATE - 53 ,5000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(11,4,2,SYSDATE - 52,4000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(12,1,  2,SYSDATE - 51,6000);



  insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(13,2,   3,SYSDATE - 50,8000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(14,4,    6,SYSDATE - 49,5000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(15,4,    1,SYSDATE - 47,20000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(16,4, 3,SYSDATE - 47,6000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(17,6,  5,SYSDATE - 47,5000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(18,7,1,SYSDATE - 40,4000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(19,1,4,SYSDATE - 37,4000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(20,5,6,SYSDATE - 37,8000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(21,4,  2,SYSDATE - 32,4000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(22,3,  1,SYSDATE - 32,8000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(23,1,4,SYSDATE - 29,20000);
   insert Into venta (idventa,idcliente,idempleado,fecha_hora,total)
    values(24,4,3,SYSDATE - 29,4000);

-- detalle venta

     insert Into detalle_venta (idventa,idproducto,cantidad)
    values(01,'SEP00006',5);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(01,'LIB00009',1);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(02,'SEP00008',3);
     insert Into detalle_venta (idventa,idproducto,cantidad)
    values(02,'LIB00005',1);
    
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(03,'LIB00001',1);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(03,'LIB00004',1);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(04,'LIB00010',1);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(04,'SEP00002',1);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(05,'LIB00007',2);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(06,'REV00001',1);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(06,'SEP00008',1);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(07,'SEP00003',2);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(07,'LIB00006',1);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(07,'SEP00002',1);
    
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(08,'LIB00003',1);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(09,'REV00003',2);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(10,'SEP00002',3);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(10,'LIB00005',1);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(11,'LIB00006',1);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(11,'SEP00008',1);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(12,'LIB00007',1);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(12,'LIB00004',1);



  insert Into detalle_venta (idventa,idproducto,cantidad)
    values(13,'LIB00003',2);
    
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(14,'SEP00007',2);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(14,'LIB00004',1);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(15,'LIB00001',2);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(15,'SEP00003',3);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(15,'REV00001',1);
    
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(16,'LIB00005',2);
     insert Into detalle_venta (idventa,idproducto,cantidad)
    values(16,'SEP00003',1);
   
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(17,'LIB00009',1);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(18,'LIB00005',2);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(19,'SEP00003',2);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(20,'REV00002',1);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(20,'SEP00005',1);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(21,'LIB00002',1);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(22,'LIB00006',1);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(22,'SEP00005',2);
    insert Into detalle_venta (idventa,idproducto,cantidad)
    values(22,'SEP00008',1);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(23,'LIB00009',4);
    
   insert Into detalle_venta (idventa,idproducto,cantidad)
    values(24,'SEP00006',2);



-- Confirmar operaciones

  commit;

-- =============================================
-- HABILITAR SALIDAS
-- =============================================

SET TERMOUT ON
SET ECHO ON
SHOW USER
SET LINESIZE 600
SET PAGESIZE 5000
SELECT * FROM CAT;


