/*Crud Biblioteca*/
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
nombre varchar(200),
correo varchar(200) UNIQUE,
bloqueado NUMBER(1),
telefono varchar(10) UNIQUE, 
tipo varchar(1) NOT NULL,
num_prestamos number(6) NOT NULL,
num_reservas NUMBER(2) NOT NULL);

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
codigo varchar(6) NOT NULL PRIMARY KEY,
nombre varchar(120),
libre NUMBER(1),
precio NUMBER(6),
diasPrestamo NUMBER(2),
precioDiaDemora NUMBER(6),
editorial varchar(40),
biblioteca varchar(50),
archivista varchar(6),
direccion varchar(6));

CREATE TABLE etiquetas(
libro varchar(6) NOT NULL,
palabra varchar(10) NOT NULL);

CREATE TABLE autoresLibros(
libro varchar(6) NOT NULL,
autor varchar(6) NOT NULL);

CREATE TABLE categorias(
libro varchar(6) NOT NULL,
nombre varchar(20) NOT NULL);

/*CRUD autores*/
CREATE TABLE autores(
codigo varchar(6),
nombre varchar(100),
pais varchar(50));

/*CRUD empleado*/
CREATE TABLE empleados(
codigo varchar(6) NOT NULL PRIMARY KEY,
cedula varchar(10) NOT NULL UNIQUE,
nombre varchar(200),
fechaVinculacion DATE,
salario number(7),
correo varchar(200) UNIQUE,
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
libro varchar(6) NOT NULL,
fecha_limite DATE,
activa number(1));

/*CRUD prestamo*/
CREATE TABLE prestamos(
codigo NUMBER(6) NOT NULL PRIMARY KEY,
fecha DATE,
afiliado varchar(6) NOT NULL,
libro varchar(6) NOT NULL,
empleadoReg varchar(6)NOT NULL,
fechaMaximaEntrega DATE,
fechaEntrega DATE,
empleadoEnt varchar(6));

/*CRUD multa*/
CREATE TABLE causas(
id varchar(20) NOT NULL PRIMARY KEY,
descripcion varchar(100));

CREATE TABLE multas(
causa varchar(20) NOT NULL, 
prestamo number(6) NOT NULL,
valor NUMBER(6),
pagada NUMBER(1));
