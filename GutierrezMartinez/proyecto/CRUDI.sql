
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
END PC_PRESTAMO;

EXECUTE pc_prestamo.ad_PRESTAMO('000018','000001','000001');
execute PC_PRESTAMO.DEVOLVER_LIBRO('000018','000001');

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
        INSERT INTO AUTORES (libro, nombre) VALUES (codigox, nombrex);
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
        UPDATE AUTORES set nombre = nnombrex WHERE libro = codigox and nombre = nombrex;
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
    PROCEDURE DE_CATEGORIA (codigox IN VARCHAR, categoriax IN VARCHAR) IS
    BEGIN 
        DELETE FROM CATEGORIAS WHERE libro = codigox and nombre = categoriax;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo eliminar la categoria');
    END; 
    PROCEDURE DE_AUTOR (codigox IN VARCHAR, nombrex IN VARCHAR) IS
    BEGIN 
        DELETE FROM AUTORES WHERE libro = codigox and nombre = nombrex;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo eliminar el autor');
    END; 
    PROCEDURE DE_ETIQUETA (codigox IN VARCHAR, palabrax IN VARCHAR) IS 
    BEGIN 
        DELETE FROM ETIQUETAS WHERE libro = codigox and palabra = palabrax;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo eliminar la etiqueta');
    END; 
    PROCEDURE DE_LIBRO (codigox IN VARCHAR) IS 
    BEGIN 
        DELETE FROM LIBROS WHERE codigo = codigox;
    EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001, 'No se pudo eliminar el libro');
    END; 
    FUNCTION CO_EDITORIALES_BIBLIOTECA (bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS EDITO SYS_REFCURSOR;
    BEGIN
    OPEN EDITO  FOR
        SELECT DISTINCT(EDITORIAL) FROM LIBROS WHERE biblioteca = bibliotecax;
    RETURN EDITO;
    END;
    FUNCTION CO_LIBROS_BIBLIOTECA (nombrex IN VARCHAR, bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB SYS_REFCURSOR;
    BEGIN
    OPEN LIB  FOR
        SELECT codigo, nombre, editorial, biblioteca, direccion  FROM LIBROS WHERE nombre = nombrex and  biblioteca = bibliotecax;
    RETURN LIB;
    END;
    FUNCTION CO_LIBRO_LIBRE (nombrex IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB SYS_REFCURSOR;
    BEGIN
    OPEN LIB  FOR
        SELECT codigo, nombre, editorial, biblioteca, direccion FROM LIBROS WHERE nombre = nombrex and libre = 1;
    RETURN LIB;
    END;
    FUNCTION CO_LIBRO_LIBRE_B (nombrex IN VARCHAR, bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB SYS_REFCURSOR;
    BEGIN
    OPEN LIB  FOR
        SELECT codigo, nombre, editorial, biblioteca, direccion  FROM LIBROS WHERE nombre = nombrex and  biblioteca = bibliotecax and libre = 1;
    RETURN LIB;
    END;
    FUNCTION CO_LIBRO__LIBRE_A (autorx IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB SYS_REFCURSOR;
    BEGIN
    OPEN LIB  FOR
        SELECT b.codigo, b.nombre, b.editorial, b.biblioteca, b.direccion  FROM LIBROS b JOIN AUTORES a ON b.codigo = a.libro WHERE a.nombre = autorx and b.libre = 1;
    RETURN LIB;
    END;
    FUNCTION CO_LIBRO_LIBRE_E (etiquetax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB SYS_REFCURSOR;
    BEGIN
    OPEN LIB  FOR
        SELECT b.codigo, b.nombre, b.editorial, b.biblioteca, b.direccion  FROM LIBROS b JOIN ETIQUETAS e ON b.codigo = e.libro WHERE e.palabra = etiquetax and b.libre = 1;
    RETURN LIB;
    END;
END PC_LIBROS;  
