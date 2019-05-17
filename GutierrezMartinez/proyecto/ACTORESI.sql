CREATE OR REPLACE PACKAGE BODY PA_AFILIADO IS 
    FUNCTION CO_EDITORIALES_BIBLIOTECA (bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS EDIT SYS_REFCURSOR;
    BEGIN 
    EDIT:= PC_LIBROS.CO_EDITORIALES_BIBLIOTECA(bibliotecax);
    RETURN EDIT;
    END;
    FUNCTION CO_LIBROS_BIBLIOTECA (nombrex IN VARCHAR, bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_BIB SYS_REFCURSOR;
    BEGIN 
    LIB_BIB:= PC_LIBROS.CO_LIBROS_BIBLIOTECA(nombrex , bibliotecax);
    RETURN LIB_BIB;
    END;
    FUNCTION CO_LIBRO_LIBRE (nombrex IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_L SYS_REFCURSOR;
    BEGIN 
    LIB_L := PC_LIBROS.CO_LIBRO_LIBRE(nombrex);
    RETURN LIB_L ;
    END;
    FUNCTION CO_LIBRO_LIBRE_B (nombrex IN VARCHAR, bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_L SYS_REFCURSOR;
    BEGIN 
    LIB_L := PC_LIBROS.CO_LIBRO_LIBRE_B(nombrex, bibliotecax);
    RETURN LIB_L ;
    END;
    FUNCTION CO_LIBRO_LIBRE_A (autorx IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_L SYS_REFCURSOR;
    BEGIN 
    LIB_L := PC_LIBROS.CO_LIBRO_LIBRE_A(autorx);
    RETURN LIB_L ;
    END;
    FUNCTION CO_LIBRO_LIBRE_E (etiquetax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_L SYS_REFCURSOR;
    BEGIN 
    LIB_L := PC_LIBROS.CO_LIBRO_LIBRE_E(etiquetax);
    RETURN LIB_L ;
    END;
    PROCEDURE AD_RESERVA (xlibro IN VARCHAR, xafiliado IN VARCHAR) IS
    BEGIN
        PC_RESERVA.AD_RESERVA(xlibro , xafiliado);
    END;
    PROCEDURE CANCELAR_RESERVA (xreserva IN NUMBER) IS
    BEGIN
        PC_RESERVA.CANCELAR_RESERVA(xreserva);
    END;
    PROCEDURE AD_AFILIADO (cedulax VARCHAR, nombrex VARCHAR, correox VARCHAR, telefonox VARCHAR, tipox VARCHAR) IS 
    BEGIN
        PCK_AFILIADO.AD_AFILIADO(cedulax, nombrex, correox, telefonox, tipox);
    END; 
    PROCEDURE MO_AFILIADO_NOM (codigox VARCHAR, nombrex VARCHAR) IS
    BEGIN
        PCK_AFILIADO.MO_AFILIADO_NOM(codigox, nombrex);
    END; 
    PROCEDURE MO_AFILIADO_COR (codigox VARCHAR, correox VARCHAR) IS
    BEGIN
        PCK_AFILIADO.MO_AFILIADO_COR(codigox, correox);
    END; 
    PROCEDURE MO_AFILIADO_TEL (codigox VARCHAR, telefonox VARCHAR) IS
    BEGIN
        PCK_AFILIADO.MO_AFILIADO_TEL(codigox, telefonox);
    END; 
    PROCEDURE MO_AFILIADO_TIP (codigox VARCHAR, tipox VARCHAR) IS
    BEGIN
        PCK_AFILIADO.MO_AFILIADO_TIP(codigox, tipox);
    END; 
    FUNCTION CO_INTERESES (codigox IN VARCHAR)  RETURN SYS_REFCURSOR IS INTE SYS_REFCURSOR;
    BEGIN 
    INTE := PCK_AFILIADO.CO_INTERESES (codigox);
    RETURN INTE ;
    END;
    FUNCTION CO_LIBROS_SACADOS (codigox IN VARCHAR)  RETURN SYS_REFCURSOR IS LIBS SYS_REFCURSOR;
    BEGIN 
    LIBS := PCK_AFILIADO.CO_LIBROS_SACADOS (codigox);
    RETURN LIBS ;
    END;
END PA_AFILIADO;
/
CREATE OR REPLACE PACKAGE BODY PA_BIBLIOTECARIO IS 
    PROCEDURE AD_PRESTAMO (xempleado IN VARCHAR, xlibro IN VARCHAR, xafiliado IN VARCHAR) IS
    BEGIN
        PC_PRESTAMO.AD_PRESTAMO(xempleado , xlibro , xafiliado);
    END;
    PROCEDURE DEVOLVER_lIBRO (xempleado IN VARCHAR, xlibro IN VARCHAR) IS
    BEGIN
        PC_PRESTAMO.DEVOLVER_lIBRO(xempleado , xlibro );
    END;
    PROCEDURE AD_ETIQUETA(codigox IN VARCHAR,palabrax IN VARCHAR) IS
    BEGIN
        PC_LIBROS.AD_ETIQUETA(codigox, palabrax);
    END;
    PROCEDURE MO_LIBRO_PRECIO(codigox IN VARCHAR, preciox IN NUMBER) IS
    BEGIN
        PC_LIBROS.MO_LIBRO_PRECIO(codigox , preciox );
    END;
    PROCEDURE MO_LIBRO_DIAS (codigox IN VARCHAR, diasPrestamox IN NUMBER) IS
    BEGIN
        PC_LIBROS.MO_LIBRO_DIAS(codigox , diasPrestamox );
    END;
    PROCEDURE MO_LIBRO_PRECIO_DIA (codigox IN VARCHAR, precioDiaDemorax IN NUMBER) IS
    BEGIN
        PC_LIBROS.MO_LIBRO_PRECIO_DIA(codigox,precioDiaDemorax);
    END;
    PROCEDURE MO_LIBRO_EDITORIAL (codigox IN VARCHAR, editorialx  IN VARCHAR) IS
    BEGIN
        PC_LIBROS.MO_LIBRO_EDITORIAL (codigox , editorialx);
    END;
    PROCEDURE MO_DIRECCION (codigox IN VARCHAR, direccionx  IN VARCHAR) IS
    BEGIN
        PC_LIBROS.MO_DIRECCION(codigox , direccionx);
    END;
    PROCEDURE MO_CATEGORIA (codigox IN VARCHAR, categoriax IN VARCHAR, ncategoriax IN VARCHAR) IS
    BEGIN
        PC_LIBROS.MO_CATEGORIA(codigox ,categoriax ,ncategoriax);
    END;
    PROCEDURE MO_AUTOR (codigox IN VARCHAR, nombrex IN VARCHAR, nnombrex IN VARCHAR) IS 
    BEGIN
        PC_LIBROS.MO_AUTOR(codigox ,nombrex ,nnombrex);
    END;
    PROCEDURE MO_ETIQUETA (codigox IN VARCHAR, palabrax IN VARCHAR, npalabrax IN VARCHAR) IS 
    BEGIN
        PC_LIBROS.MO_ETIQUETA(codigox ,palabrax ,npalabrax);
    END;
    FUNCTION CO_EDITORIALES_BIBLIOTECA (bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS EDIT SYS_REFCURSOR;
    BEGIN 
    EDIT:= PC_LIBROS.CO_EDITORIALES_BIBLIOTECA(bibliotecax);
    RETURN EDIT;
    END;
    FUNCTION CO_LIBROS_BIBLIOTECA (nombrex IN VARCHAR, bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_BIB SYS_REFCURSOR;
    BEGIN 
    LIB_BIB:= PC_LIBROS.CO_LIBROS_BIBLIOTECA(nombrex , bibliotecax);
    RETURN LIB_BIB;
    END;
    FUNCTION CO_LIBRO_LIBRE (nombrex IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_L SYS_REFCURSOR;
    BEGIN 
    LIB_L := PC_LIBROS.CO_LIBRO_LIBRE(nombrex);
    RETURN LIB_L ;
    END;
    FUNCTION CO_LIBRO_LIBRE_B (nombrex IN VARCHAR, bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_L SYS_REFCURSOR;
    BEGIN 
    LIB_L := PC_LIBROS.CO_LIBRO_LIBRE_B(nombrex, bibliotecax);
    RETURN LIB_L ;
    END;
    FUNCTION CO_LIBRO_LIBRE_A (autorx IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_L SYS_REFCURSOR;
    BEGIN 
    LIB_L := PC_LIBROS.CO_LIBRO_LIBRE_A(autorx);
    RETURN LIB_L ;
    END;
    FUNCTION CO_LIBRO_LIBRE_E (etiquetax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_L SYS_REFCURSOR;
    BEGIN 
    LIB_L := PC_LIBROS.CO_LIBRO_LIBRE_E(etiquetax);
    RETURN LIB_L ;
    END;
    PROCEDURE DE_AFILIADO (codigox VARCHAR) IS
    BEGIN
        PCK_AFILIADO.DE_AFILIADO(codigox);
    END; 
    FUNCTION CO_INTERESES (codigox IN VARCHAR)  RETURN SYS_REFCURSOR IS INTE SYS_REFCURSOR;
    BEGIN 
    INTE := PCK_AFILIADO.CO_INTERESES (codigox);
    RETURN INTE ;
    END;
    FUNCTION CO_LIBROS_SACADOS (codigox IN VARCHAR)  RETURN SYS_REFCURSOR IS LIBS SYS_REFCURSOR;
    BEGIN 
    LIBS := PCK_AFILIADO.CO_LIBROS_SACADOS (codigox);
    RETURN LIBS ;
    END;
END PA_BIBLIOTECARIO;
/
CREATE OR REPLACE PACKAGE BODY PA_ARCHIVISTA IS 
    PROCEDURE AD_LIBRO(nombrex IN VARCHAR, preciox IN NUMBER, diasPrestamox IN NUMBER, precioDiaDemorax IN NUMBER, editorialx  IN VARCHAR, bibliotecax IN VARCHAR, archivistax IN VARCHAR, direccionx IN VARCHAR) IS
    BEGIN 
        PC_LIBROS.AD_LIBRO(nombrex, preciox, diasPrestamox, precioDiaDemorax, editorialx, bibliotecax, archivistax, direccionx);
    END;
    PROCEDURE AD_CATEGORIA (codigox IN VARCHAR, categoriax IN VARCHAR) IS
    BEGIN 
        PC_LIBROS.AD_CATEGORIA(codigox, categoriax);
    END;
    PROCEDURE AD_AUTOR (codigox IN VARCHAR, nombrex IN VARCHAR) IS
    BEGIN
        PC_LIBROS.AD_AUTOR(codigox, nombrex);
    END;
    PROCEDURE AD_ETIQUETA (codigox IN VARCHAR, palabrax IN VARCHAR) IS
    BEGIN
        PC_LIBROS.AD_ETIQUETA(codigox, palabrax);
    END;
    PROCEDURE DE_LIBRO (codigox IN VARCHAR) IS
    BEGIN
        PC_LIBROS.DE_LIBRO(codigox);
    END;
    FUNCTION CO_EDITORIALES_BIBLIOTECA (bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS EDIT SYS_REFCURSOR;
    BEGIN 
    EDIT:= PC_LIBROS.CO_EDITORIALES_BIBLIOTECA(bibliotecax);
    RETURN EDIT;
    END;
    FUNCTION CO_LIBROS_BIBLIOTECA (nombrex IN VARCHAR, bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_BIB SYS_REFCURSOR;
    BEGIN 
    LIB_BIB:= PC_LIBROS.CO_LIBROS_BIBLIOTECA(nombrex , bibliotecax);
    RETURN LIB_BIB;
    END;
    FUNCTION CO_LIBRO_LIBRE (nombrex IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_L SYS_REFCURSOR;
    BEGIN 
    LIB_L := PC_LIBROS.CO_LIBRO_LIBRE(nombrex);
    RETURN LIB_L ;
    END;
    FUNCTION CO_LIBRO_LIBRE_B (nombrex IN VARCHAR, bibliotecax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_L SYS_REFCURSOR;
    BEGIN 
    LIB_L := PC_LIBROS.CO_LIBRO_LIBRE_B(nombrex, bibliotecax);
    RETURN LIB_L ;
    END;
    FUNCTION CO_LIBRO_LIBRE_A (autorx IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_L SYS_REFCURSOR;
    BEGIN 
    LIB_L := PC_LIBROS.CO_LIBRO_LIBRE_A(autorx);
    RETURN LIB_L ;
    END;
    FUNCTION CO_LIBRO_LIBRE_E (etiquetax IN VARCHAR)  RETURN SYS_REFCURSOR IS LIB_L SYS_REFCURSOR;
    BEGIN 
    LIB_L := PC_LIBROS.CO_LIBRO_LIBRE_E(etiquetax);
    RETURN LIB_L ;
    END;
END PA_ARCHIVISTA;
