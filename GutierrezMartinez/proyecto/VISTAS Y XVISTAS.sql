CREATE VIEW BLOQUEADOS AS 
SELECT CODIGO,NOMBRE,CORREO,CEDULA,TELEFONO FROM AFILIADOS WHERE bloqueado=1;

CREATE VIEW AFILIADOS_TIPOS AS 
SELECT CODIGO,NOMBRE,TIPO FROM AFILIADOS;

/*Libros*/
CREATE VIEW POPULARIDAD AS
SELECT LIBRO, COUNT(CODIGO) AS NUMERO_DE_PRESTAMOS FROM PRESTAMOS
GROUP BY LIBRO;

CREATE VIEW NOVELAS AS
SELECT l.CODIGO, l.NOMBRE, l.BIBLIOTECA FROM CATEGORIAS c, LIBROS l 
WHERE c.nombre='Novela' AND c.LIBRO=l.CODIGO;

CREATE VIEW Cantidad_Libros AS
SELECT BIBLIOTECA,COUNT(NOMBRE) AS LIBROS  FROM LIBROS
GROUP BY BIBLIOTECA;


select * from Cantidad_Libros;

DROP VIEW BLOQUEADOS;
DROP VIEW AFILIADOS_TIPOS;
DROP VIEW POPULARIDAD;
DROP VIEW NOVELAS;
DROP VIEW Cantidad_Libros;
