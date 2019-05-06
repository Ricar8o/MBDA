/**Crud BIBLIOTECA*/
CREATE TABLE bibliotecas(
nombre varchar(50) NOT NULL PRIMARY KEY,
direccion varchar(60) NOT NULL UNIQUE,
codigoPostal varchar(6),
correo varchar(30) UNIQUE);

CREATE TABLE telefonos(
telefono varchar(10) NOT NULL PRIMARY KEY,
biblioteca varchar(50));

/**Crud Afiliado*/
CREATE TABLE afiliados(
codigo varchar(6) NOT NULL PRIMARY KEY,
cedula varchar(10) NOT NULL UNIQUE,
nombre varchar(30),
correo varchar(30) UNIQUE,
bloqueado NUMBER(1),
telefono varchar(10) UNIQUE, 
tipo varchar(1) NOT NULL);

CREATE TABLE afiliados_oro(
afiliado varchar(6) NOT NULL PRIMARY KEY,
diasExtra NUMBER(2));

CREATE TABLE afiliados_plata(
afiliado varchar(6) NOT NULL PRIMARY KEY,
diasExtra NUMBER(2));

CREATE TABLE afiliados_normal(
afiliado varchar(6) NOT NULL PRIMARY KEY,
diasExtra NUMBER(2));

CREATE TABLE intereses(
afiliado varchar(6) NOT NULL,
palabra varchar(20) NOT NULL, 
apariciones number(3));

/*CRUD libro*/
CREATE TABLE libros(
codigo VARCHAR(6) NOT NULL PRIMARY KEY,
nombre varchar(120),
libre NUMBER(1),
precio NUMBER(6),
diasPrestamo NUMBER(2),
precioDiaDemora NUMBER(6),
editorial varchar(40),
biblioteca varchar(50),
archivista varchar(6));

CREATE TABLE etiquetas(
libro VARCHAR(15) NOT NULL,
palabra varchar(10) NOT NULL);

CREATE TABLE autores(
libro VARCHAR(15) NOT NULL,
nombre varchar(30) NOT NULL);

CREATE TABLE categorias(
libro VARCHAR(6) NOT NULL,
nombre varchar(20) NOT NULL);

/*CRUD empleado*/
CREATE TABLE empleados(
codigo varchar(6) NOT NULL PRIMARY KEY,
cedula varchar(10) NOT NULL UNIQUE,
nombre varchar(30),
fechaVinculacion DATE,
salario number(7),
correo varchar(30) UNIQUE,
telefono varchar(10) UNIQUE,
biblioteca varchar(50),
tipo varchar(1));

CREATE TABLE archivistas(
empleado varchar(6) NOT NULL PRIMARY KEY);

CREATE TABLE bibliotecarios(
empleado varchar(6) NOT NULL PRIMARY KEY);

CREATE TABLE servicio_generales(
empleado varchar(6) NOT NULL PRIMARY KEY);

/*CRUD reserva*/
CREATE TABLE reservas(
codigo  NUMBER(6) NOT NULL PRIMARY KEY,
fecha DATE,
afiliado varchar(6) NOT NULL,
libro varchar(15) NOT NULL,
fecha_limite DATE,
empleado varchar(6));

/*CRUD prestamo*/
CREATE TABLE prestamos(
codigo NUMBER(6) NOT NULL PRIMARY KEY,
fecha DATE,
afiliado varchar(6) NOT NULL,
libro varchar(15) NOT NULL,
fechaMaximaEntrega DATE,
empleado varchar(6)NOT NULL,
FechaEntrega DATE);

/*CRUD multa*/
CREATE TABLE causas(
id varchar(20) NOT NULL PRIMARY KEY,
descripcion varchar(100));

CREATE TABLE multas(
causa varchar(20) NOT NULL, 
prestamo number(6) NOT NULL,
valor NUMBER(6));
