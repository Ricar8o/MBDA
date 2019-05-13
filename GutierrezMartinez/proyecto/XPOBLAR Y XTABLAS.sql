/*Xpoblar*/
DELETE etiquetas;
DELETE autores;
DELETE libros;
DELETE categorias;
DELETE empleados;
DELETE intereses;
DELETE afiliados_oro;
DELETE afiliados_plata;
DELETE afiliados;
DELETE multas;
DELETE causas;
DELETE prestamos;
DELETE reservas;
DELETE telefonos;
DELETE bibliotecas;

/*Xtablas*/
DROP TABLE telefonos CASCADE CONSTRAINTS;
DROP TABLE etiquetas CASCADE CONSTRAINTS;
DROP TABLE empleados CASCADE CONSTRAINTS;
DROP TABLE bibliotecarios CASCADE CONSTRAINTS;
DROP TABLE archivistas CASCADE CONSTRAINTS;
DROP TABLE servicio_generales CASCADE CONSTRAINTS;
DROP TABLE afiliados CASCADE CONSTRAINTS;
DROP TABLE afiliados_oro CASCADE CONSTRAINTS;
DROP TABLE afiliados_plata CASCADE CONSTRAINTS;
DROP TABLE afiliados_normal CASCADE CONSTRAINTS;
DROP TABLE intereses CASCADE CONSTRAINTS;
DROP TABLE autores CASCADE CONSTRAINTS;
DROP TABLE categorias CASCADE CONSTRAINTS;
DROP TABLE libros CASCADE CONSTRAINTS; 
DROP TABLE causas CASCADE CONSTRAINTS;
DROP TABLE multas CASCADE CONSTRAINTS;
DROP TABLE prestamos CASCADE CONSTRAINTS;
DROP TABLE reservas CASCADE CONSTRAINTS;
DROP TABLE bibliotecas CASCADE CONSTRAINTS;
