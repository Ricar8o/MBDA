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
