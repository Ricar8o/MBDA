CREATE OR REPLACE PACKAGE PC_PRESTAMO IS 
  PROCEDURE AD_CONTENIDO (xempleado IN VARCHAR, xlibro IN VARCHAR, xafiliado IN VARCHAR);
END PC_PRESTAMO;
