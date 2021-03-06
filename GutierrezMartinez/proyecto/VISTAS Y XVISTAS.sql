CREATE VIEW BLOQUEADOS AS 
SELECT CODIGO,NOMBRE,CORREO,CEDULA,TELEFONO FROM AFILIADOS WHERE bloqueado=1;

CREATE VIEW CATEGORIAS_BIBLIOTECAS AS 
SELECT L.BIBLIOTECA,C.NOMBRE,COUNT(C.LIBRO) AS LIBROS FROM CATEGORIAS C,LIBROS L 
WHERE c.libro=l.codigo
GROUP BY L.BIBLIOTECA,C.NOMBRE;

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

CREATE VIEW Libros_Autores AS
SELECT nombre,COUNT(libro) AS LIBROS  FROM autoreslibros l JOIN autores a on a.codigo = l.autor
GROUP BY NOMBRE
ORDER BY LIBROS DESC;

select * from CATEGORIAS_BIBLIOTECAS;

DROP VIEW BLOQUEADOS;
DROP VIEW CATEGORIAS_BIBLIOTECAS;
DROP VIEW POPULARIDAD;
DROP VIEW NOVELAS;
DROP VIEW Cantidad_Libros;
DROP VIEW Libros_Autores;
