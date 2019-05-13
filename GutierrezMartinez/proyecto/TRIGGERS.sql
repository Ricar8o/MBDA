/*Da automanicamente un codigo a los afiliados ingresados, ademas le 
asignarles el tipo por defecto de normal en caso de no poseer uno*/
CREATE OR REPLACE TRIGGER AD_AFILIADO1
BEFORE INSERT ON AFILIADOS
FOR EACH ROW
DECLARE 
    a number(6);
BEGIN
  SELECT MAX(to_number(codigo ,'999999999999.99')) into a FROM afiliados;
  IF (a IS NULL) THEN
     a:= 0;
  END IF;
  a:= a+ 1;
  IF (a >= 0 AND a <10) THEN 
    :new.codigo := CONCAT('00000', TO_CHAR(a));
  END IF;
  IF (a >= 10 AND a <100) THEN 
    :new.codigo := CONCAT('0000', TO_CHAR(a ));
  END IF;
  IF (a >= 100 AND a <1000) THEN 
    :new.codigo := CONCAT('000', TO_CHAR(a));
  END IF;
  IF (a >= 1000 AND a <10000) THEN 
    :new.codigo := CONCAT('00', TO_CHAR(a));
  END IF;
   IF (a >= 10000 AND a <100000) THEN 
    :new.codigo := CONCAT('0', TO_CHAR(a));
  END IF;
   IF (a >= 100000 AND a <1000000) THEN 
    :new.codigo := TO_CHAR(a);
  END IF;
  IF (:new.tipo IS NULL) THEN
    :new.tipo:= 'n';
  END IF;
END;

/*Inserta al afiliado en una tabla adicional dependiendo de su tipo*/
CREATE OR REPLACE TRIGGER AD_AFILIADO2
AfTER INSERT ON AFILIADOS
FOR EACH ROW
BEGIN
  IF (:new.tipo = 'o') THEN
     INSERT INTO afiliados_oro (afiliado , diasExtra) VALUES (:new.codigo , 10);
  END IF;
  IF (:new.tipo = 'p') THEN
     INSERT INTO afiliados_plata (afiliado , diasExtra) VALUES (:new.codigo , 5);
  END IF;
  IF (:new.tipo = 'n') THEN
     INSERT INTO afiliados_normal (afiliado , diasExtra) VALUES (:new.codigo , 0);
  END IF;
END;

/*Se asegura que no se modifique el codigo del afiliado*/
CREATE OR REPLACE TRIGGER MO_AFILIADO1
BEFORE UPDATE OF CODIGO ON AFILIADOS
FOR EACH ROW 
BEGIN
    RAISE_APPLICATION_ERROR(-20032, 'No se puede modificar el codigo de un afiliado');
END;

/*Realiza el cambio de tipo del afiliado, haciendo el traslado de la tabla que le correspondía por su tipo,
a la nueva tabla dada por su nuevo tipo*/
CREATE OR REPLACE TRIGGER MO_AFILIADO2
BEFORE UPDATE OF TIPO ON AFILIADOS
FOR EACH ROW
BEGIN
    IF (:old.tipo = 'o') THEN
        DELETE FROM AFILIADOS_ORO WHERE afiliado = :old.codigo;
    END IF;
    IF (:old.tipo = 'n') THEN
        DELETE FROM AFILIADOS_NORMAL WHERE afiliado = :old.codigo;
    END IF;
    IF (:old.tipo = 'p') THEN
        DELETE FROM AFILIADOS_PLATA WHERE afiliado = :old.codigo;
    END IF;
    IF (:new.tipo = 'o') THEN
     INSERT INTO afiliados_oro (afiliado , diasExtra) VALUES (:new.codigo , 10);
    END IF;
    IF (:new.tipo = 'p') THEN
         INSERT INTO afiliados_plata (afiliado , diasExtra) VALUES (:new.codigo , 5);
    END IF;
    IF (:new.tipo = 'n') THEN
         INSERT INTO afiliados_normal (afiliado , diasExtra) VALUES (:new.codigo , 0);
    END IF;
END;

/*Da automanicamente un codigo a los empleados ingresados, ademas le 
asignarles el tipo por defecto de servicios generales en caso de no poseer uno*/
CREATE OR REPLACE TRIGGER AD_EMPLEADO1
BEFORE INSERT ON EMPLEADOS
FOR EACH ROW
DECLARE 
    a number(6);
BEGIN
  SELECT MAX(to_number(codigo ,'999999999999.99')) into a FROM empleados;
  IF (a IS NULL) THEN
     a:= 0;
  END IF;
  a:= a+ 1;
  IF (a >= 0 AND a <10) THEN 
    :new.codigo := CONCAT('00000', TO_CHAR(a));
  END IF;
  IF (a >= 10 AND a <100) THEN 
    :new.codigo := CONCAT('0000', TO_CHAR(a ));
  END IF;
  IF (a >= 100 AND a <1000) THEN 
    :new.codigo := CONCAT('000', TO_CHAR(a));
  END IF;
  IF (a >= 1000 AND a <10000) THEN 
    :new.codigo := CONCAT('00', TO_CHAR(a));
  END IF;
   IF (a >= 10000 AND a <100000) THEN 
    :new.codigo := CONCAT('0', TO_CHAR(a));
  END IF;
   IF (a >= 100000 AND a <1000000) THEN 
    :new.codigo := TO_CHAR(a);
  END IF;
  IF (:new.tipo IS NULL) THEN
    :new.tipo:= 's';
  END IF;
END;

/*Inserta al empleado en una tabla adicional dependiendo de su tipo*/
CREATE OR REPLACE TRIGGER AD_EMPLEADOS2
AfTER INSERT ON EMPLEADOS
FOR EACH ROW
BEGIN
  IF (:new.tipo = 'a') THEN
     INSERT INTO archivistas (empleado) VALUES (:new.codigo);
  END IF;
  IF (:new.tipo = 'b') THEN
     INSERT INTO bibliotecarios (empleado) VALUES (:new.codigo);
  END IF;
  IF (:new.tipo = 's') THEN
     INSERT INTO servicio_generales (empleado) VALUES (:new.codigo);
  END IF;
END;

/*Se asegura que no se modifique el codigo ni el tipo del empleado*/
CREATE OR REPLACE TRIGGER MO_EMPLEADO1
BEFORE UPDATE OF CODIGO, TIPO ON EMPLEADOS
FOR EACH ROW 
BEGIN
    RAISE_APPLICATION_ERROR(-20032, 'No se puede modificar estos datos del empleado');
END;

/*Se asegura que el archivista que registra el libro esté asignado a esa biblioteca*/
CREATE OR REPLACE TRIGGER AD_LIBRO1
BEFORE INSERT ON LIBROS
FOR EACH ROW
DECLARE 
    a varchar(50);
BEGIN
    SELECT biblioteca INTO a FROM EMPLEADOS WHERE codigo = :new.archivista;
    IF ( a <> :new.biblioteca) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El archivista que quiere ingresar un libro no esta asignado a la biblioteca');
    END IF;
END;

/*Se asegura que la reserva no la haga un usuario bloqueado o que el libre que se desea
reservar este ocupado*/
CREATE OR REPLACE TRIGGER AD_RESERVA1
BEFORE INSERT ON RESERVAS
FOR EACH ROW
DECLARE 
    a varchar(50);
    c number (1);
BEGIN
    SELECT libre INTO a FROM LIBROS WHERE :new.libro = codigo;
    SELECT codigo INTO c FROM AFILIADOS WHERE codigo = :new.afiliado;
    IF ( a = 1 ) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El libro se encuentrá ocupado.');
    END IF;
    IF ( c = 1) THEN 
        RAISE_APPLICATION_ERROR(-20032, 'El afiliado se encuentra bloqueado');
    END IF;
END;

/*Inserta las etiquetas de un libro a los intereses del usuario caundo este hace una reserva del mismo*/
CREATE OR REPLACE TRIGGER AD_RESERVA2 
AFTER INSERT ON PRESTAMOS 
FOR EACH ROW 
BEGIN
    INSERT INTO intereses (afiliado, palabra, apariciones) (SELECT :new.afiliado, palabra, 1 FROM ETIQUETAS WHERE libro = :new.libro);
END;

/*Se asegura que el prestamo no la haga un usuario bloqueado o que el libro que se desea
reservar este ocupado*/
CREATE OR REPLACE TRIGGER AD_PRESTAMO1
BEFORE INSERT ON PRESTAMOS
FOR EACH ROW
DECLARE 
    lib varchar(6);
    emp varchar (6);
    af varchar(6);
    a varchar(50);
    b varchar (50);
    c number (1);
    d number (1);
    COD NUMBER(20);
BEGIN
    SELECT SYSDATE INTO :new.fecha FROM DUAL; 
    SELECT codigo INTO af FROM afiliados WHERE :new.afiliado = codigo;
    SELECT empleado INTO emp FROM bibliotecarios WHERE :new.empleado = empleado;
    SELECT codigo,biblioteca INTO lib,a FROM LIBROS WHERE :new.libro = codigo;
    SELECT biblioteca INTO b FROM empleados WHERE :new.empleado = codigo;
    SELECT bloqueado INTO c FROM afiliados WHERE :new.afiliado = codigo;
    SELECT libre INTO d FROM LIBROS WHERE :new.libro = codigo; 
    SELECT MAX(CODIGO) INTO COD FROM PRESTAMOS;
    IF ( af is null) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El afiliado no existe');
    END IF;
    IF ( emp is null) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El empleado no es un bibliotecario o no existe');
    END IF;
    IF ( lib is null) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El libro no existe');
    END IF;
    IF ( a <> b) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El bibliotecario que quiere registrar el prestamo no esta asignado a la biblioteca');
    END IF;
    IF ( c = 1) THEN 
        RAISE_APPLICATION_ERROR(-20032, 'El afiliado se encuentra bloqueado');
    END IF;
    IF ( d = 1) THEN 
        RAISE_APPLICATION_ERROR(-20032, 'El libro ya se encuentra prestado');
    END IF;
    IF (COD IS NULL) THEN
        COD:=0;
    END IF;
    :NEW.CODIGO:= COD + 1;
    SELECT SYSDATE + DIASPRESTAMO INTO :NEW.FECHAENTREGA FROM LIBROS WHERE CODIGO= :NEW.LIBRO;
END;

/*Inserta las etiquetas de un libro a los intereses del usuario caundo este lo saca en prestamo*/
CREATE OR REPLACE TRIGGER AD_PRESTAMO2 
AFTER INSERT ON PRESTAMOS 
FOR EACH ROW 
BEGIN
    INSERT INTO intereses (afiliado, palabra, apariciones) (SELECT :new.afiliado, palabra, 1 FROM ETIQUETAS WHERE libro = :new.libro);
END;
    
/*Crea automaticamente una multa en caso de que la entrega sea tardía*/
CREATE OR REPLACE TRIGGER MO_PRESTAMO
BEFORE UPDATE OF FECHAENTREGA ON PRESTAMOS
FOR EACH ROW 
DECLARE 
    a NUMBER(7);
    b NUMBER(7);
BEGIN
    UPDATE LIBROS SET libre = 0 WHERE :old.libro = codigo; 
    a := TRUNC(:old.FECHAMAXIMAENTREGA - :new.FECHAENTREGA, 0);
    IF (a < 0) THEN
       SELECT PRECIODIADEMORA INTO b FROM libros WHERE :old.libro = codigo;
       INSERT INTO multas (causa, prestamo, valor) VALUES ('Retraso' , :old.codigo, a*b);
    END IF;
END;
