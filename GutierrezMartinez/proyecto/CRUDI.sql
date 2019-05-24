CREATE OR REPLACE PACKAGE BODY PC_PRESTAMO IS 
    PROCEDURE AD_PRESTAMO (xempleado IN VARCHAR, xlibro IN VARCHAR, xafiliado IN VARCHAR) IS
    BEGIN     
        INSERT INTO PRESTAMOS(empleadoReg,libro,afiliado) values(xempleado, xlibro, xafiliado);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'No se pudo realizar el prestamo');
    END;
    PROCEDURE DEVOLVER_lIBRO (xempleado IN VARCHAR, xlibro IN VARCHAR) IS
    BEGIN
        UPDATE PRESTAMOS SET empleadoEnt= xempleado WHERE empleadoEnt IS NULL AND LIBRO=xlibro;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'No se pudo realizar la devolucion');
    END;
    PROCEDURE RENOVAR_PRESTAMO (xcodigo IN VARCHAR) IS
    librox varchar(6);
    diasx NUMBER(2);
    BEGIN
        SELECT libro INTO librox FROM prestamos where codigo  = xcodigo;
        SELECT diasprestamo INTO diasx FROM LIBROS where codigo = librox;
        UPDATE PRESTAMOS SET fechamaximaentrega = fechamaximaentrega + diasx WHERE codigo = xcodigo;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'No se pudo realizar la renovacion');
    END;  
END PC_PRESTAMO;
/
CREATE OR REPLACE PACKAGE BODY PC_LIBROS IS
    PROCEDURE AD_LIBRO(nombrex IN VARCHAR, preciox IN NUMBER, diasPrestamox IN NUMBER, precioDiaDemorax IN NUMBER, editorialx  IN VARCHAR, bibliotecax IN VARCHAR, archivistax IN VARCHAR, direccionx IN VARCHAR) IS
    BEGIN 
        INSERT INTO LIBROS(nombre, precio, diasPrestamo, precioDiaDemora, editorial, biblioteca, archivista, direccion) VALUES (nombrex, preciox, diasPrestamox, precioDiaDemorax, editorialx, bibliotecax, archivistax, direccionx);
        COMMIT;
        EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'No se pudo agregar el libro');
    END;
    PROCEDURE MO_LIBRO_PRECIO (codigox IN VARCHAR, preciox IN NUMBER) IS 
    BEGIN
        UPDATE LIBROS set precio = preciox WHERE codigo = codigox;
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se modificar el precio');
    END;
    PROCEDURE MO_LIBRO_DIAS (codigox IN VARCHAR, diasPrestamox IN NUMBER) IS
    BEGIN
        UPDATE LIBROS set diasPrestamo = diasPrestamox WHERE codigo = codigox;
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudieron modificar los dias de prestamo');
    END;
    PROCEDURE MO_LIBRO_PRECIO_DIA (codigox IN VARCHAR, precioDiaDemorax IN NUMBER) IS
    BEGIN
        UPDATE LIBROS set precioDiaDemora = precioDiaDemorax WHERE codigo = codigox;
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo actualizar el precio por dia de de demora');
    END;
    PROCEDURE MO_LIBRO_EDITORIAL (codigox IN VARCHAR, editorialx  IN VARCHAR) IS
    BEGIN
        UPDATE LIBROS set editorial = editorialx WHERE codigo = codigox;
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo actualizar la editorial');
    END;
    PROCEDURE MO_DIRECCION (codigox IN VARCHAR, direccionx  IN VARCHAR) IS
    BEGIN
        UPDATE LIBROS set direccion = direccionx WHERE codigo = codigox;
    COMMIT;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo actualizar la direccion');
    END;
    PROCEDURE AD_CATEGORIA (codigox IN VARCHAR, categoriax IN VARCHAR) IS 
    BEGIN
        INSERT INTO CATEGORIAS (libro, nombre) VALUES (codigox, categoriax);
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo agregar la categoria');
    END;
    PROCEDURE AD_AUTOR (codigox IN VARCHAR, nombrex IN VARCHAR) IS
    BEGIN
        INSERT INTO AUTORESLIBROS (libro, autor) VALUES (codigox, nombrex);
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo agregar el autor');
    END;
    PROCEDURE AD_ETIQUETA (codigox IN VARCHAR, palabrax IN VARCHAR) IS 
    BEGIN
        INSERT INTO ETIQUETAS (libro, palabra) VALUES (codigox, palabrax);
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo agregar la etiqueta');
    END;
    PROCEDURE MO_CATEGORIA (codigox IN VARCHAR, categoriax IN VARCHAR, ncategoriax IN VARCHAR) IS
    BEGIN 
        UPDATE CATEGORIAS set nombre = ncategoriax WHERE libro = codigox and nombre = categoriax;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo modificar la categoria');
    END;    
    PROCEDURE MO_AUTOR (codigox IN VARCHAR, nombrex IN VARCHAR, nnombrex IN VARCHAR) IS 
    BEGIN 
        UPDATE AUTORESLIBROS set autor = nnombrex WHERE libro = codigox and autor = nombrex;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo modificar el autor');
    END; 
    PROCEDURE MO_ETIQUETA (codigox IN VARCHAR, palabrax IN VARCHAR, npalabrax IN VARCHAR) IS
    BEGIN 
        UPDATE ETIQUETAS set palabra = npalabrax WHERE libro = codigox and palabra = palabrax;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo modificar la etiqueta');
    END; 
    PROCEDURE DE_LIBRO (codigox IN VARCHAR) IS 
    p number(1);
    BEGIN 
        SELECT count(libro) INTO p FROM prestamos WHERE libro = codigox and fechaEntrega is null;
        IF (p >0) THEN
            RAISE_APPLICATION_ERROR(-20001, 'No se pudo eliminar el libro');
        END IF;
        DELETE FROM LIBROS WHERE codigo = codigox;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo eliminar el libro');
    END; 
    FUNCTION CO_EDITORIALES_BIBLIOTECA (bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS EDITO SYS_REFCURSOR;
    BEGIN
    OPEN EDITO  FOR
        SELECT DISTINCT(EDITORIAL) FROM LIBROS WHERE lower(biblioteca) like '%'|| lower(bibliotecax) ||'%' ;
    RETURN EDITO;
    END;
    FUNCTION BUSCAR_LIBRO (nombrex IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB SYS_REFCURSOR;
    BEGIN
    OPEN LIB  FOR
        SELECT codigo, nombre, editorial, biblioteca, direccion,libre FROM LIBROS WHERE lower(nombre) like  '%'|| lower(nombrex) ||'%' and libre = 1;
    RETURN LIB;
    END;
    FUNCTION BUSCAR_LIBRO_BIBLIOTECA (nombrex IN VARCHAR, bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB SYS_REFCURSOR;
    BEGIN
    OPEN LIB  FOR
        SELECT codigo, nombre, editorial, biblioteca, direccion,libre  FROM LIBROS WHERE  lower(nombre) like  '%'|| lower(nombrex) ||'%' and  lower(biblioteca) like '%'|| lower(bibliotecax) ||'%' ;
    RETURN LIB;
    END;
    FUNCTION BUSCAR_LIBROS_AUTOR (autorx IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB SYS_REFCURSOR;
    BEGIN
    OPEN LIB  FOR
        SELECT f.codigo, f.nombre, f.editorial, f.biblioteca, f.direccion,f.libre FROM (SELECT * FROM libros b JOIN autoreslibros a ON b.codigo = a.libro) f JOIN autores u ON u.codigo = f.autor  WHERE  lower(u.nombre) like  '%'|| lower(autorx) ||'%';
    RETURN LIB;
    END;
    FUNCTION BUSCAR_LIBROS_ETIQUETA (etiquetax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB SYS_REFCURSOR;
    BEGIN
    OPEN LIB  FOR
        SELECT b.codigo, b.nombre, b.editorial, b.biblioteca, b.direccion,b.libre  FROM LIBROS b JOIN ETIQUETAS e ON b.codigo = e.libro WHERE lower(e.palabra) like  '%'|| lower(etiquetax) ||'%';
    RETURN LIB;
    END;
    FUNCTION CO_CATEGORIAS_BIBLIOTECA (bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS CAT SYS_REFCURSOR;
    BEGIN
    OPEN CAT FOR
        SELECT * FROM categorias_bibliotecas WHERE LOWER(biblioteca) LIKE  '%'||LOWER(bibliotecax)||'%'; 
    RETURN CAT;
    END;
    FUNCTION NUM_LIBROS_BIBLIOTECA (bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB SYS_REFCURSOR;
    BEGIN
    OPEN lib FOR 
        SELECT * FROM CANTIDAD_LIBROS WHERE LOWER(biblioteca) LIKE  '%'||LOWER(bibliotecax)||'%'; 
    RETURN LIB;
    END;
    FUNCTION CO_MAS_POPULARES RETURN SYS_REFCURSOR IS LIB SYS_REFCURSOR;
    BEGIN
    OPEN lib FOR 
        SELECT * FROM POPULARIDAD; 
    RETURN LIB;
    END;
END PC_LIBROS; 
/
CREATE OR REPLACE PACKAGE BODY PC_RESERVA IS 
    PROCEDURE AD_RESERVA (xlibro IN VARCHAR, xafiliado IN VARCHAR) IS
    numReservasx NUMBER(1);
    tipox VARCHAR(1);
    BEGIN
        SELECT num_reservas, tipo INTO numReservasx, tipox FROM afiliados WHERE codigo = xafiliado;
        IF ((numReservasx > 2 and tipox = 'o') or (numReservasx > 1 and tipox = 'p') or (tipox = 'n')) THEN
            RAISE_APPLICATION_ERROR(-20001, 'El afiliado no puede hacer una reserva mas');
        END IF;
        INSERT INTO RESERVAS(libro,afiliado) values(xlibro, xafiliado);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'No se pudo realizar la reserva');
    END;
    PROCEDURE CANCELAR_RESERVA (xreserva IN NUMBER) IS
    BEGIN
        UPDATE RESERVAS SET activa = 1 WHERE xreserva = codigo;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'No se pudo realizar la cancelacion');
    END;
END PC_RESERVA;
/
CREATE OR REPLACE PACKAGE BODY PCK_AFILIADO IS 
  PROCEDURE AD_AFILIADO (cedulax VARCHAR, nombrex VARCHAR, correox VARCHAR, telefonox VARCHAR, tipox VARCHAR) IS 
   BEGIN
        INSERT INTO AFILIADOS(cedula, nombre, correo, telefono, tipo) values(cedulax, nombrex, correox, telefonox, tipox);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'No se pudo agregar el afiliado');
    END;
  PROCEDURE MO_AFILIADO_NOM (codigox VARCHAR, nombrex VARCHAR) IS
    BEGIN 
        UPDATE AFILIADOS set nombre = nombrex WHERE codigo = codigox;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo modificar el nombre');
    END; 
  PROCEDURE MO_AFILIADO_COR (codigox VARCHAR, correox VARCHAR) IS 
  BEGIN 
        UPDATE AFILIADOS set correo = correox WHERE codigo = codigox;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo modificar el correo');
    END; 
  PROCEDURE MO_AFILIADO_TEL (codigox VARCHAR, telefonox VARCHAR) IS 
  BEGIN 
        UPDATE AFILIADOS set telefono = telefonox WHERE codigo = codigox;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo modificar el telefono');
    END; 
  PROCEDURE MO_AFILIADO_TIP (codigox VARCHAR, tipox VARCHAR) IS
    BEGIN 
        UPDATE AFILIADOS set tipo = tipox WHERE codigo = codigox;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo modificar el tipo');
    END; 
  PROCEDURE DE_AFILIADO (codigox VARCHAR) IS
  pr number(2);
  r number (2);
  m number (2);
  BEGIN 
    SELECT count(afiliado) INTO pr FROM prestamos WHERE afiliado = codigox and fechaentrega is null;
    SELECT count(afiliado) INTO r FROM reservas WHERE afiliado = codigox and activa = 1;
    SELECT count(afiliado) INTO m FROM multas m JOIN prestamos p ON p.codigo = m.prestamo WHERE p.afiliado = codigox and pagada = 0;
    IF (pr + r + m> 0) THEN 
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo eliminar al afiliado');
    END IF;
    DELETE FROM AFILIADOS WHERE codigo = codigox;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'No se pudo eliminar al afiliado');
    END; 
   FUNCTION CO_INTERESES (codigox IN VARCHAR)  RETURN SYS_REFCURSOR IS ETI SYS_REFCURSOR;
    BEGIN
    OPEN ETI FOR
        SELECT palabra, apariciones FROM INTERESES WHERE afiliado = codigox ORDER BY apariciones DESC;
    RETURN ETI;
    END;
   FUNCTION CO_LIBROS_SACADOS (codigox IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB SYS_REFCURSOR;
    BEGIN
    OPEN LIB FOR
        SELECT nombre, count(l.codigo) as veces FROM libros l JOIN (SELECT * FROM PRESTAMOS WHERE AFILIADO = codigox) f ON f.libro = l.codigo GROUP BY nombre;
    RETURN LIB;
    END;
END;
/
CREATE OR REPLACE PACKAGE BODY PC_RESERVASALON IS
  PROCEDURE reservar (afiliadox varchar, numSalonx number, bibliotecax varchar, bibliotecariox varchar, iniciox DATE, finx DATE) IS
  BEGIN
  INSERT INTO reservassalones (afiliado, salonnum, salonbib, bibliotecario, inicio, fin) VALUES (afiliadox, numSalonx, bibliotecax, bibliotecariox, iniciox, finx);
  EXCEPTION
  WHEN OTHERS THEN 
        ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'No se pudo hacer la reserva');
  END; 
  PROCEDURE pagar (reservax number) IS 
  BEGIN
  UPDATE reservassalones SET pagado = 1 WHERE codigo = reservax;
  EXCEPTION
  WHEN OTHERS THEN 
        ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'No se pudo hacer el pago');
  END; 
  PROCEDURE modificarFechas (reservax number, iniciox DATE, finx DATE) IS
  BEGIN
  UPDATE reservassalones SET inicio = iniciox, fin = finx WHERE codigo = reservax;
  EXCEPTION
  WHEN OTHERS THEN 
        ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'No se pudieron modificar las fechas');
  END; 
  PROCEDURE eliminarReserva (reservax number) IS
  BEGIN
  DELETE FROM reservassalones WHERE codigo = reservax;
  EXCEPTION
  WHEN OTHERS THEN 
    ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo eliminar la reserva');
  END;
  FUNCTION consultarSalon (tipox varchar) RETURN SYS_REFCURSOR IS SAL SYS_REFCURSOR;
    BEGIN
    OPEN SAL FOR 
        SELECT numero, biblioteca, tipo FROM salones WHERE LOWER(tipox) LIKE  '%'||LOWER(tipo)||'%'; 
    RETURN SAL;
  END;
  FUNCTION consultarSalon (tipox varchar, bibliotecax varchar) RETURN SYS_REFCURSOR IS SAL SYS_REFCURSOR;
    BEGIN
    OPEN SAL FOR 
        SELECT numero, biblioteca, tipo FROM salones WHERE LOWER(tipox) LIKE  '%'||LOWER(tipo)||'%' and LOWER(bibliotecax) LIKE  '%'||LOWER(biblioteca)||'%'; 
    RETURN SAL;
 END;
END;                                                                                       
