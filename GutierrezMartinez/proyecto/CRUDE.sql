CREATE OR REPLACE PACKAGE PC_PRESTAMO IS 
  PROCEDURE AD_PRESTAMO (xempleado IN VARCHAR, xlibro IN VARCHAR, xafiliado IN VARCHAR);
  PROCEDURE DEVOLVER_lIBRO (xempleado IN VARCHAR, xlibro IN VARCHAR);
END PC_PRESTAMO;
