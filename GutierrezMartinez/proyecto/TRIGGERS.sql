/*Da automanicamente un codigo a los afiliados ingresados, ademas le 
asignarles el tipo por defecto de normal en caso de no poseer uno*/
CREATE OR REPLACE TRIGGER AD_AFILIADO1
BEFORE INSERT ON AFILIADOS
FOR EACH ROW
DECLARE 
  a number(6);
BEGIN
  :new.num_prestamos := 0; 
  :new.num_reservas := 0; 
  :new.bloqueado := 0;
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
/
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
/
/*Se asegura que no se modifique el codigo del afiliado*/
CREATE OR REPLACE TRIGGER MO_AFILIADO1
BEFORE UPDATE OF CODIGO ON AFILIADOS
FOR EACH ROW 
BEGIN
    RAISE_APPLICATION_ERROR(-20032, 'No se puede modificar el codigo de un afiliado');
END;
/
/*Realiza el cambio de tipo del afiliado, haciendo el traslado de la tabla que le correspondÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â­a por su tipo,
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
/
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
/
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
/
/*Se asegura que no se modifique el codigo ni el tipo del empleado*/
CREATE OR REPLACE TRIGGER MO_EMPLEADO1
BEFORE UPDATE OF CODIGO, TIPO ON EMPLEADOS
FOR EACH ROW 
BEGIN
    RAISE_APPLICATION_ERROR(-20032, 'No se puede modificar estos datos del empleado');
END;
/
/*Se asegura que el archivista que registra el libro este asignado a esa biblioteca*/
CREATE OR REPLACE TRIGGER AD_LIBRO1
BEFORE INSERT ON LIBROS
FOR EACH ROW
DECLARE 
    b varchar(50);
    a number(6);
BEGIN
    :new.libre := 1;
    SELECT biblioteca INTO b FROM EMPLEADOS WHERE codigo = :new.archivista;
    IF ( b <> :new.biblioteca) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El archivista que quiere ingresar un libro no esta asignado a la biblioteca');
    END IF;
    SELECT MAX(to_number(codigo ,'999999999999.99')) into a FROM libros;
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
END;
/
CREATE OR REPLACE PROCEDURE ad_interes(palabrax IN VARCHAR, afiliadox IN VARCHAR) IS
    apar NUMBER(3);
    BEGIN
    SELECT count(afiliado) INTO apar FROM intereses WHERE palabrax = palabra and afiliado = afiliadox;
    IF (apar = 0) THEN
        INSERT INTO intereses(afiliado, palabra, apariciones) VALUES (afiliadox, palabrax, 1);
    END IF;
    IF (apar >0) THEN
        UPDATE intereses SET apariciones = apariciones + 1 WHERE palabra = palabrax and afiliado = afiliadox;
    END IF;
END;
/
CREATE OR REPLACE PROCEDURE agregarIntereses(librox IN VARCHAR, afiliadox IN VARCHAR) IS
    cursor eti is 
    select * 
    from etiquetas
    where libro = librox;
    BEGIN 
    for u in eti loop
        ad_interes (u.palabra, afiliadox);
    end loop; 
END;
/
CREATE OR REPLACE FUNCTION fecha_entrega (afiliadox IN varchar, librox IN varchar) RETURN DATE IS
    val number(2);
    tipox varchar(1);
    val2 number(2);
    fecha DATE;
    BEGIN
    val:= 0;
    val2:= 0;
    SELECT tipo INTO tipox FROM afiliados WHERE afiliadox = codigo;
    IF (tipox = 'o') THEN
        SELECT diasExtra into val FROM afiliados_oro WHERE afiliadox = afiliado;
    END IF;
    IF (tipox = 'p') THEN
        SELECT diasExtra into val FROM afiliados_plata WHERE afiliadox = afiliado;
    END IF;
    IF (tipox = 'n') THEN
        SELECT diasExtra into val FROM afiliados_normal WHERE afiliadox = afiliado;
    END IF;
    SELECT diasPrestamo INTO val2 FROM libros WHERE codigo = librox;
    fecha := SYSDATE + val + val2;
    return fecha;
END;
/
/*Se asegura que la reserva no la haga un usuario bloqueado o que el libre que se desea
reservar este ocupado*/
CREATE OR REPLACE TRIGGER AD_RESERVA1
BEFORE INSERT ON RESERVAS
FOR EACH ROW
DECLARE 
    a varchar(50);
    c number (1);
    COD number(6);
BEGIN
    SELECT libre INTO a FROM LIBROS WHERE :new.libro = codigo;
    SELECT bloqueado INTO c FROM AFILIADOS WHERE codigo = :new.afiliado;
    SELECT SYSDATE INTO :new.fecha FROM DUAL; 
    :new.fecha_limite := fecha_entrega(:new.afiliado , :new.libro);
    :new.activa := 1;
    SELECT MAX(CODIGO) INTO COD FROM RESERVAS;   
    IF ( a = 0 ) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El libro se encuentra ocupado.');
    END IF;
    IF ( c = 1) THEN 
        RAISE_APPLICATION_ERROR(-20032, 'El afiliado se encuentra bloqueado');
    END IF;
    IF (COD IS NULL) THEN
        COD:=0;
    END IF;
    :NEW.CODIGO:= COD + 1;
END;
/
/*Inserta las etiquetas de un libro a los intereses del usuario caundo este hace una reserva del mismo*/
CREATE OR REPLACE TRIGGER AD_RESERVA2 
AFTER INSERT ON reservas
FOR EACH ROW 
BEGIN
    UPDATE afiliados SET num_reservas = num_reservas +1 WHERE codigo = :new.afiliado;
    UPDATE libros SET libre = 0 WHERE codigo = :new.libro;
    agregarIntereses(:new.libro, :new.afiliado);
END;
/
/*Cancela una reserva*/
CREATE OR REPLACE TRIGGER MO_RESERVA 
BEFORE UPDATE OF activa ON reservas
FOR EACH ROW 
BEGIN
    UPDATE afiliados SET num_reservas = num_reservas -1 WHERE codigo = :new.afiliado;
    UPDATE libros SET libre = 1 WHERE codigo = :old.libro;
END;
/
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
    b varchar (15);
    c number (1);
    d number (1);
    res number(6);
    COD NUMBER(20);
    bip varchar(50);
    act NUMBER(1);
BEGIN
    SELECT SYSDATE INTO :new.fecha FROM DUAL; 
    SELECT codigo INTO af FROM afiliados WHERE :new.afiliado = codigo;
    SELECT codigo,biblioteca INTO lib,a FROM LIBROS WHERE :new.libro = codigo;
    SELECT bloqueado INTO c FROM afiliados WHERE :new.afiliado = codigo;
    SELECT libre INTO d FROM LIBROS WHERE :new.libro = codigo; 
    SELECT MAX(CODIGO) INTO COD FROM PRESTAMOS;
    SELECT biblioteca INTO bip FROM empleados WHERE :new.empleadoreg = codigo;
    :new.fechaMaximaEntrega := fecha_entrega(:new.afiliado, :new.libro);
    IF ( af is null) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El afiliado no existe');
    END IF;
    IF ( lib is null) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El libro no existe');
    END IF;
    IF ( c = 1) THEN 
        RAISE_APPLICATION_ERROR(-20032, 'El afiliado se encuentra bloqueado');
    END IF;
    IF (bip <> a) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El bibliotecario que registra el prestamo debe estar asignado a la biblioteca');
    END IF;
    IF (d = 0) THEN 
        SELECT afiliado, codigo, activa INTO b, res, act FROM reservas WHERE :new.libro = libro;
        IF (b is null) THEN
            RAISE_APPLICATION_ERROR(-20032, 'El libro no esta disponible');
        END IF;
        IF (b <> :new.afiliado) THEN
            RAISE_APPLICATION_ERROR(-20032, 'El libro no esta disponible');
        END IF;
        IF (b = :new.afiliado and act = 1) THEN
            UPDATE RESERVAS SET activa = 0 WHERE res = codigo;
        END IF;
    END IF;
    IF (COD IS NULL) THEN
        COD:=0;
    END IF;
    :NEW.CODIGO:= COD + 1;
END;
/
/*Inserta las etiquetas de un libro a los intereses del usuario caundo este lo saca en prestamo*/
CREATE OR REPLACE TRIGGER AD_PRESTAMO2 
AFTER INSERT ON PRESTAMOS 
FOR EACH ROW 
BEGIN
    UPDATE afiliados SET num_prestamos = num_prestamos +1 WHERE codigo = :new.afiliado;
    UPDATE libros SET libre = 0 WHERE codigo = :new.libro;
    agregarIntereses(:new.libro, :new.afiliado);
END;
/
/*Crea automaticamente una multa en caso de que la entrega sea tardia*/
CREATE OR REPLACE TRIGGER MO_PRESTAMO1
BEFORE UPDATE OF EMPLEADOENT ON PRESTAMOS
FOR EACH ROW 
DECLARE 
    EMP VARCHAR(6);
    bib1 VARCHAR(50);
    bib2 VARCHAR(50);
BEGIN
    SELECT SYSDATE INTO :NEW.FECHAENTREGA FROM DUAL;
    SELECT BIBLIOTECARIOS.EMPLEADO INTO EMP FROM BIBLIOTECARIOS WHERE EMPLEADO=:NEW.EMPLEADOENT;
    SELECT biblioteca INTO bib1 FROM empleados WHERE :new.empleadoent = codigo;
    SELECT biblioteca INTO bib2 FROM LIBROS WHERE :old.libro = codigo;
    IF (bib1 <> bib2) THEN
        RAISE_APPLICATION_ERROR(-20003, 'El bibliotecario que registra la devolucion debe estar asignado a la biblioteca');
    END IF;
    IF (EMP IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20003, 'El empleado debe ser un bibliotecario');
    END IF;
    UPDATE LIBROS SET libre = 1 WHERE :old.libro = codigo;
    UPDATE afiliados SET num_prestamos = num_prestamos -1 WHERE codigo = :old.afiliado;
END;
/
/*Crea automaticamente una multa en caso de que la entrega sea tardia*/
CREATE OR REPLACE TRIGGER MO_PRESTAMO2
AFTER UPDATE OF EMPLEADOENT ON PRESTAMOS
FOR EACH ROW 
DECLARE 
    a NUMBER(7);
    b NUMBER(7);
BEGIN 
    a := TRUNC(:old.FECHAMAXIMAENTREGA - :new.FECHAENTREGA, 0);
    IF (a < 0) THEN
       SELECT PRECIODIADEMORA INTO b FROM LIBROS WHERE :old.libro = codigo;
       INSERT INTO multas (causa, prestamo, valor) VALUES ('Retraso' , :old.codigo, a*b);
    END IF;
END;
/
/*Evita que se elimine un prestamo*/
CREATE OR REPLACE TRIGGER EL_PRESTAMO
BEFORE DELETE ON PRESTAMOS 
FOR EACH ROW 
BEGIN 
    RAISE_APPLICATION_ERROR(-20223, 'No se pueden borrar datos de los prestamos');
END;
/
CREATE OR REPLACE PROCEDURE SACAR_LIBRO (xlibro IN VARCHAR) IS
   BEGIN
        UPDATE LIBROS SET libre = 0 WHERE codigo = xlibro;
END;
/
/*Verifica que la multa sea de un prestamo ya entregado y saca al libro de circulacion en caso de ser necesario*/
CREATE OR REPLACE TRIGGER AD_MULTA
BEFORE INSERT ON MULTAS
FOR EACH ROW
    DECLARE
    FECHA DATE;
    librox varchar(6);
    BEGIN
    :new.pagada := 0;
    SELECT fechaEntrega INTO FECHA FROM PRESTAMOS WHERE :new.prestamo = codigo;
    UPDATE AFILIADOS SET BLOQUEADO = 1 WHERE codigo = (SELECT afiliado FROM PRESTAMOS WHERE :new.prestamo = codigo);
    IF (FECHA is null) THEN 
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo agregar multa');
    END IF;
    IF (:new.causa = 'Perdida' or :new.causa = 'Dano grave') THEN 
        SELECT LIBRO INTO librox FROM PRESTAMOS WHERE :new.prestamo = codigo;
        SELECT PRECIO INTO :new.valor FROM LIBROS WHERE codigo = librox;
        SACAR_LIBRO (librox);
    END IF;
END;
/
/*Quita el bloqueo si el usuario ya pago todas sus multas*/
CREATE OR REPLACE TRIGGER MO_MULTA
AFTER UPDATE OF PAGADA ON MULTAS
FOR EACH ROW
DECLARE 
    afiliadox VARCHAR(6);
    nmultas NUMBER(2);
BEGIN
    SELECT afiliado INTO afiliadox FROM prestamos WHERE :old.prestamo = codigo;
    SELECT count(codigo) INTO nmultas FROM multas m JOIN (SELECT codigo FROM PRESTAMOS WHERE afiliado = afiliadox) p ON m.prestamo = p.codigo WHERE m.pagada = 0;
    IF (nmultas = 0) THEN
        UPDATE AFILIADOS SET bloqueado = 0 WHERE codigo = afiliadox;
    END IF;
END;
/
CREATE OR REPLACE TRIGGER AD_AUTOR
BEFORE INSERT ON AUTORES
FOR EACH ROW
DECLARE 
  a number(6);
BEGIN
  SELECT MAX(to_number(codigo ,'999999999999.99')) into a FROM autores;
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
END;
/
CREATE OR REPLACE TRIGGER ad_reservasSalones
BEFORE INSERT ON reservasSalones
FOR EACH ROW
DECLARE 
    dif number(3);
    valor number(7);
    cod number(6);
    res number(3);
    des number (3);
    aft varchar(1);
    bip varchar(50);
BEGIN
    SELECT TRUNC(MOD((:new.fin - :new.inicio) * 24, 24)) into dif from dual;
    SELECT t.valorHora into valor FROM Salones s JOIN tiposSalones t ON t.tipo = s.tipo WHERE :new.salonNum = s.numero and :new.salonBib = s.biblioteca;
    SELECT count(codigo) INTO res FROM reservasSalones WHERE (inicio <= :new.inicio and :new.inicio <= fin) or (inicio <= :new.fin and :new.fin <= fin);
    SELECT max(codigo) INTO cod FROM reservasSalones;
    SELECT tipo INTO aft FROM afiliados WHERE codigo = :new.afiliado;
    SELECT biblioteca INTO bip FROM empleados WHERE :new.bibliotecario = codigo;
    IF (cod is null) THEN 
        cod:= 0;
    END IF;
    :new.pagado := 0;
    :new.codigo := cod + 1;
    IF (res > 0) THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo agregar la reserva');
    END IF;
    IF (valor is null) THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo agregar la reserva');
    END IF;
    IF (dif < 0) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Mal ingreso de fechas');
    END IF;
    IF (bip <> :new.salonbib) THEN
        RAISE_APPLICATION_ERROR(-20002, 'El bibliotecario no esta asignada a la biblioteca');
    END IF;
    :new.valorTotal := (dif * valor);
    UPDATE afiliados SET bloqueado = 1 WHERE :new.afiliado = codigo;
END;
/
CREATE OR REPLACE TRIGGER mo_reservasSalones1
BEFORE UPDATE OF pagado ON reservasSalones 
FOR EACH ROW
BEGIN
    IF (:new.pagado = 1) THEN
        UPDATE afiliados SET bloqueado = 0 WHERE :old.afiliado = codigo;
    END IF;
END;
/
CREATE OR REPLACE TRIGGER mo_reservasSalones2
BEFORE UPDATE OF inicio, fin ON reservasSalones
FOR EACH ROW
DECLARE
    fecha DATE;
    res number(3);
BEGIN
    SELECT SYSDATE into fecha from dual;
    SELECT count(codigo) INTO res FROM reservasSalones WHERE ((inicio <= :new.inicio and :new.inicio <= fin) or (inicio <= :new.fin and :new.fin <= fin)) and :old.codigo <> codigo;
    IF (fecha > :old.inicio) THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se pueden cambiar las fechas.');
    END IF;
    IF (res > 0) THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo agregar la reserva');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER de_reservasSalones
BEFORE DELETE ON reservasSalones
FOR EACH ROW
DECLARE
    fecha DATE;
BEGIN
    SELECT SYSDATE into fecha from dual;
    IF (fecha > :old.inicio) THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede eliminar la reserva');
    END IF;
    UPDATE afiliados SET bloqueado = 0 WHERE :old.afiliado = codigo;
END;
