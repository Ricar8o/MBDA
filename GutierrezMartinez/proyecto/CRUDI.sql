CREATE OR REPLACE PACKAGE BODY PC_PRESTAMO IS 
  PROCEDURE AD_CONTENIDO (xempleado IN VARCHAR, xlibro IN VARCHAR, xafiliado IN VARCHAR) IS
    BEGIN
        INSERT INTO PRESTAMOS(empleado,libro,afiliado) values(xempleado, xlibro, xafiliado);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'No se pudo realizar el prestamo');
    END;
END PC_PRESTAMO;


EXECUTE pc_prestamo.ad_contenido('000018','pgk292','000001');