/**Crud BIBLIOTECA*/
CREATE TABLE bibliotecas(
nombre varchar(50) NOT NULL PRIMARY KEY,
direccion varchar(60) NOT NULL UNIQUE,
codigoPostal varchar(6),
correo varchar(30) UNIQUE);

CREATE TABLE telefonos(
telefono varchar(10) NOT NULL PRIMARY KEY,
biblioteca varchar(50));

ALTER TABLE telefonos ADD CONSTRAINT FK_TELEFONO_BIBLIOTECA
FOREIGN KEY (biblioteca) REFERENCES bibliotecas(nombre);
ALTER TABLE telefonos ADD CONSTRAINT CK_TELEFONOS_TEL
CHECK (LENGTH(TRIM(TRANSLATE(telefono, '0123456789', ' '))) = 0);
ALTER TABLE afiliados ADD CONSTRAINT CK_BIBLIOTECA
CHECK (correo LIKE '%@%.%');


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
apariciones number(100));

ALTER TABLE afiliados_oro ADD CONSTRAINT FK_AFILIADO_ORO
FOREIGN KEY (afiliado) REFERENCES afiliados(codigo);
ALTER TABLE afiliados_plata ADD CONSTRAINT FK_AFILIADO_PLATA
FOREIGN KEY (afiliado) REFERENCES afiliados(codigo);
ALTER TABLE intereses ADD CONSTRAINT PK_INTERES
PRIMARY KEY (afiliado, palabra);
ALTER TABLE intereses ADD CONSTRAINT FK_INTERES
FOREIGN KEY (afiliado) REFERENCES afiliados(codigo);
ALTER TABLE afiliados ADD CONSTRAINT CH_AFILIADO0
CHECK (LENGTH(TRIM(TRANSLATE(codigo, '0123456789', ' '))) = 0);
ALTER TABLE afiliados ADD CONSTRAINT CH_AFILIADO1
CHECK (bloqueado IN (1 , 0));
ALTER TABLE afiliados ADD CONSTRAINT CH_AFILIADO2
CHECK (correo LIKE '%@%.%');
ALTER TABLE afiliados ADD CONSTRAINT CH_AFILIADO3
CHECK (tipo IN ('o' , 'p', 'n'));
ALTER TABLE intereses ADD CONSTRAINT CH_INTERES
CHECK (LENGTH(TRIM(TRANSLATE(palabra, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-', ' '))) = 0);
ALTER TABLE afiliados ADD CONSTRAINT CH_AFILIADO4
CHECK (LENGTH(TRIM(TRANSLATE(telefono, '0123456789', ' '))) = 0);
ALTER TABLE afiliados ADD CONSTRAINT CH_AFILIADO5
CHECK (LENGTH(TRIM(TRANSLATE(cedula, '0123456789', ' '))) = 0);
ALTER TABLE afiliados ADD CONSTRAINT CH_AFILIADO6
CHECK (LENGTH(TRIM(TRANSLATE(nombre, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) = 0);
ALTER TABLE afiliados_oro ADD CONSTRAINT CH_AFILIADO_ORO
CHECK (diasExtra >= 0);
ALTER TABLE afiliados_plata ADD CONSTRAINT CH_AFILIADO_PLATA
CHECK (diasExtra >= 0);
ALTER TABLE afiliados_normal ADD CONSTRAINT CH_AFILIADO_NORMAL
CHECK (diasExtra >= 0);
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
libro NUMBER(15) NOT NULL,
nombre varchar(20) NOT NULL);

ALTER TABLE etiquetas ADD CONSTRAINT PK_ETIQUETA
PRIMARY KEY (libro, palabra);
ALTER TABLE etiquetas ADD CONSTRAINT FK_ETIQUETA
FOREIGN KEY (libro) REFERENCES libros(codigo);
ALTER TABLE libros ADD CONSTRAINT FK_LIBRO_BIBLIOTECA
FOREIGN KEY (biblioteca) REFERENCES bibliotecas(nombre);
ALTER TABLE libros ADD CONSTRAINT FK_LIBRO_ARCHIVISTA
FOREIGN KEY (archivista) REFERENCES archivistas(empleado);
ALTER TABLE etiquetas ADD CONSTRAINT CH_ETIQUETA
CHECK (LENGTH(TRIM(TRANSLATE(palabra, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) = 0);
ALTER TABLE autores ADD CONSTRAINT CK_AUTOR1
CHECK (LENGTH(TRIM(TRANSLATE(nombre, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-.', ' '))) = 0);
ALTER TABLE libros ADD CONSTRAINT CH_LIBRO1
CHECK (precio >= 0);
ALTER TABLE libros ADD CONSTRAINT CH_LIBRO2
CHECK (diasPrestamo >= 0);
ALTER TABLE libros ADD CONSTRAINT CH_LIBRO3
CHECK (precioDiaDemora >= 0);
ALTER TABLE libros ADD CONSTRAINT CK_LIBRO4
CHECK (libre IN (1 , 0));

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


ALTER TABLE empleados ADD CONSTRAINT FK_EMPLEADO_BIBLIOTECA
FOREIGN KEY (biblioteca) REFERENCES bibliotecas(nombre);
ALTER TABLE empleados ADD CONSTRAINT CH_EMPLEADO1
CHECK (correo LIKE '%@%.%');
ALTER TABLE empleados ADD CONSTRAINT CH_EMPLEADO2
CHECK (LENGTH(TRIM(TRANSLATE(telefono, '0123456789', ' '))) = 0);
ALTER TABLE empleados ADD CONSTRAINT CH_EMPLEADO3
CHECK (LENGTH(TRIM(TRANSLATE(cedula, '0123456789', ' '))) = 0);
ALTER TABLE empleados ADD CONSTRAINT CH_EMPLEADO4
CHECK (LENGTH(TRIM(TRANSLATE(nombre, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-', ' '))) = 0);
ALTER TABLE archivistas ADD CONSTRAINT FK_ARCHIVISTA
FOREIGN KEY (empleado) REFERENCES empleados(codigo);
ALTER TABLE bibliotecarios ADD CONSTRAINT FK_BIBLIOTECARIO
FOREIGN KEY (empleado) REFERENCES empleados(codigo);
ALTER TABLE servicio_generales ADD CONSTRAINT FK_SERVICIOS
FOREIGN KEY (empleado) REFERENCES empleados(codigo);
ALTER TABLE empleados ADD CONSTRAINT CH_EMPLEADO5
CHECK (salario >= 0);
ALTER TABLE afiliados ADD CONSTRAINT CH_EMPLEADO6
CHECK (tipo IN ('b' , 'a', 's'));



/*CRUD reserva*/
CREATE TABLE reservas(
codigo  NUMBER(6) NOT NULL PRIMARY KEY,
fecha DATE,
afiliado_oro varchar(6) NOT NULL,
libro varchar(15) NOT NULL,
fecha_limite DATE,
bibliotecario varchar(6)NOT NULL);

ALTER TABLE reservas ADD CONSTRAINT FK_RESERVA1
FOREIGN KEY (afiliado_oro) REFERENCES afiliados_oro(afiliado);
ALTER TABLE reservas ADD CONSTRAINT FK_RESERVA2
FOREIGN KEY (libro) REFERENCES libros(codigo);
ALTER TABLE reservas ADD CONSTRAINT FK_RESERVA3
FOREIGN KEY (bibliotecario) REFERENCES bibliotecarios(empleado);

/*CRUD prestamo*/
CREATE TABLE prestamos(
codigo NUMBER(6) NOT NULL PRIMARY KEY,
fecha DATE,
afiliado varchar(6) NOT NULL,
libro varchar(15) NOT NULL,
fechaMaximaEntrega DATE,
bibliotecario varchar(6)NOT NULL,
FechaEntrega DATE);

ALTER TABLE prestamos ADD CONSTRAINT FK_PRESTAMO1
FOREIGN KEY (afiliado) REFERENCES afiliados(codigo);
ALTER TABLE prestamos ADD CONSTRAINT FK_PRESTAMO2
FOREIGN KEY (libro) REFERENCES libros(codigo);
ALTER TABLE prestamos ADD CONSTRAINT FK_PRESTAMO3
FOREIGN KEY (bibliotecario) REFERENCES bibliotecarios(empleado);

/*CRUD multa*/
CREATE TABLE causas(
id varchar(20) NOT NULL PRIMARY KEY,
descripcion varchar(100));

CREATE TABLE multas(
causa varchar(20) NOT NULL, 
prestamo number(6) NOT NULL,
valor NUMBER(6));

ALTER TABLE multas ADD CONSTRAINT PK_MULTA
PRIMARY KEY (causa, prestamo);
ALTER TABLE multas ADD CONSTRAINT FK_MULTA1
FOREIGN KEY (prestamo) REFERENCES prestamos(codigo);
ALTER TABLE multas ADD CONSTRAINT FK_MULTA2
FOREIGN KEY (causa) REFERENCES causas(id);
ALTER TABLE multas ADD CONSTRAINT CH_MULTA
CHECK (valor >= 0);

/*PoblarOk*/
/*Biblioteca*/
INSERT INTO bibliotecas(nombre, direccion, codigoPostal, correo)
VALUES('Luis Angel Arango', 'Cl. 11 #4-14', '52513', 'LuisAngelA@bibliomail.com');
INSERT INTO bibliotecas(nombre, direccion, codigoPostal, correo)
VALUES('Virgilio Barco', 'Avenida Carrera 60 #57 – 60', '215819', 'VirgilioBarco@bibliomail.com');
INSERT INTO bibliotecas(nombre, direccion, codigoPostal, correo)
VALUES('El Tintal Manuel Zapata Olivella', 'Ak. 86 #6c-09', '461569', 'ElTintalMZO@bibliomail.com');
INSERT INTO bibliotecas(nombre, direccion, codigoPostal, correo)
VALUES('Biblioteca Publica Parque El Tunal', 'Calle 48B Sur #21-13', '217474', 'ParqueElTunal@bibliomail.com');
INSERT INTO bibliotecas(nombre, direccion, codigoPostal, correo)
VALUES('Biblioteca Publica Julio Mario Santo Domingo', 'Cl. 170 #67-51', '678398', 'JulioMarioSD@bibliomail.com');
INSERT INTO bibliotecas(nombre, direccion, codigoPostal, correo)
VALUES('Biblioteca Nacional', 'Cl. 24 #5-60', '993677', 'Nacional@bibliomail.com');
INSERT INTO bibliotecas(nombre, direccion, codigoPostal, correo)
VALUES('La Victoria', 'Diagonal 36m Sur #2 Este35', '632233', 'LaVictoria@bibliomail.com');
INSERT INTO bibliotecas(nombre, direccion, codigoPostal, correo)
VALUES('Las Ferias', 'Cra. 69j #73-29', '205210', 'LasFerias@bibliomail.com');
INSERT INTO bibliotecas(nombre, direccion, codigoPostal, correo)
VALUES('Biblioteca Publica El parque', 'Cra. 5 #3621', '282574', 'ElParque@bibliomail.com');
INSERT INTO bibliotecas(nombre, direccion, codigoPostal, correo)
VALUES('Biblioteca Publica Lago Timiza', '52. Cra. 74 #42 G', '30441','LagoTimiza@bibliomail.com');

/*telefonos*/
insert into telefonos (telefono, biblioteca) values ('7484885720', 'Biblioteca Publica Lago Timiza');
insert into telefonos (telefono, biblioteca) values ('8993118947', 'Las Ferias');
insert into telefonos (telefono, biblioteca) values ('4264634098', 'Luis Angel Arango');
insert into telefonos (telefono, biblioteca) values ('9781669100', 'Virgilio Barco');
insert into telefonos (telefono, biblioteca) values ('7026027725', 'El Tintal Manuel Zapata Olivella');
insert into telefonos (telefono, biblioteca) values ('2213802136', 'Biblioteca Nacional');
insert into telefonos (telefono, biblioteca) values ('9684690532', 'Biblioteca Publica Julio Mario Santo Domingo');
insert into telefonos (telefono, biblioteca) values ('6952723542', 'Biblioteca Publica El parque');
insert into telefonos (telefono, biblioteca) values ('7083584797', 'Virgilio Barco');
insert into telefonos (telefono, biblioteca) values ('3239771541', 'Biblioteca Publica Parque El Tunal');
insert into telefonos (telefono, biblioteca) values ('6962299305', 'La Victoria');
insert into telefonos (telefono, biblioteca) values ('3656833340', 'Biblioteca Nacional');
insert into telefonos (telefono, biblioteca) values ('5281998545', 'Las Ferias');
/*afiliados*/
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('8649017914', 'Lorette Strettell', 'lstrettell0@npr.org', 0, '7425338300','o');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('8770035128', 'Say Sivior', 'ssivior1@youtube.com', 0, '1493307642', 'p');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('3900744131', 'Lanny Ruthven', 'lruthven2@edublogs.org', 0, '2475965901', 'o');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono) values ('2771104257', 'Stanford McLorinan', 'smclorinan3@amazonaws.com', 1, '4047149052');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('8914152071', 'Gaspard Berardt', 'gberardt4@xrea.com', 1, '4562467624', 'p');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('3905144260', 'Giffard McKleod', 'gmckleod5@omniture.com', 0, '7344259901', 'o');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono) values ('1606063735', 'Virginia Seleway', 'vseleway6@mozilla.org', 1, '6673922503');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono) values ('3929733048', 'Wheeler Santore', 'wsantore7@tinyurl.com', 1, '5399707004');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('4945371114', 'Hailee Blaskett', 'hblaskett8@bravesites.com', 1, '8273288290', 'p');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('5069008893', 'Joey Alpin', 'jalpin9@prlog.org', 1, '1654592012', 'o');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('7880212493', 'Moore Jimmison', 'mjimmisona@weather.com', 0, '1963919549', 'o');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono) values ('9633387332', 'Phylys Mertgen', 'pmertgenb@shop-pro.jp', 1, '4395630160');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono) values ('7303281074', 'Shalom Rome', 'sromec@eventbrite.com', 1, '3059580048');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('6170472857', 'Calypso Sisselot', 'csisselotd@hatena.ne.jp', 0, '4042226562', 'p');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('4367420928', 'Wilburt Hacon', 'whacone@google.ca', 1, '5061594152', 'o');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono) values ('1715497662', 'Selie Wolfendale', 'swolfendalef@utexas.edu', 0, '8399640967');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono) values ('2646155883', 'Allyson Carette', 'acaretteg@google.fr', 0, '9387999549');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('1160396378', 'Pammi Deplacido', 'pdeplacidoh@miitbeian.gov.cn', 0, '3198072192', 'p');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono) values ('2674360873', 'Winnifred Gellett', 'wgelletti@mac.com', 0, '5555099166');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('3039736965', 'Alvira Jouanot', 'ajouanotj@artisteer.com', 0, '6745874597', 'o');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono) values ('5353659915', 'Solomon Kernermann', 'skernermannk@cocolog-nifty.com', 0, '9009801752');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('2487266307', 'Carly Wodeland', 'cwodelandl@sun.com', 1, '1557169613', 'p');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('2373225090', 'Nicole Banat', 'nbanatm@bizjournals.com', 1, '9362300079', 'p');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono) values ('3309808300', 'Ronna Hunnable', 'rhunnablen@google.com.br', 0, '4908583959');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('3501708786', 'Vivienne Skellern', 'vskellerno@netvibes.com', 0, '6915846488', 'o');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono) values ('4515449011', 'Marlin McArley', 'mmcarleyp@nbcnews.com', 0, '7772124059');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono) values ('2373802481', 'Dall Brelsford', 'dbrelsfordq@yandex.ru', 1, '9815855367');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('2264427338', 'Tamiko Trevain', 'ttrevainr@virginia.edu', 1, '9951200980', 'o');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono, tipo) values ('8663832218', 'Lynsey Curdell', 'lcurdells@histats.com', 1, '7908838657', 'p');
insert into afiliados (cedula, nombre, correo, bloqueado, telefono) values ('1258251372', 'Kali Burkinshaw', 'shawt@acquirethisname.com', 1, '6278154558');

/*intereses*/
INSERT INTO intereses(afiliado, palabra)VALUES('imu336', 'radical');
INSERT INTO intereses(afiliado, palabra)VALUES('ett783', 'Upgradable');
INSERT INTO intereses(afiliado, palabra)VALUES('iln492', 'Fundamental');
INSERT INTO intereses(afiliado, palabra)VALUES('sif751', 'time-frame');
INSERT INTO intereses(afiliado, palabra)VALUES('cfm534', 'Persistent');
INSERT INTO intereses(afiliado, palabra)VALUES('akb509', 'well-modulated');
INSERT INTO intereses(afiliado, palabra)VALUES('kdx604', 'Future-proofed');
INSERT INTO intereses(afiliado, palabra)VALUES('acw052', 'orchestration');
INSERT INTO intereses(afiliado, palabra)VALUES('fqs694', 'neutral');
INSERT INTO intereses(afiliado, palabra)VALUES('yzb705', 'policy');
INSERT INTO intereses(afiliado, palabra)VALUES('hfi981', 'Horizontal');
INSERT INTO intereses(afiliado, palabra)VALUES('lqb980', 'full-range');
INSERT INTO intereses(afiliado, palabra)VALUES('msg954', 'Switchable');
INSERT INTO intereses(afiliado, palabra)VALUES('sst185', 'Future-proofed');
INSERT INTO intereses(afiliado, palabra)VALUES('syc615', 'Reactive');
INSERT INTO intereses(afiliado, palabra)VALUES('lud400', 'directional');
INSERT INTO intereses(afiliado, palabra)VALUES('gof451', 'Versatile');
INSERT INTO intereses(afiliado, palabra)VALUES('thm987', 'conglomeration');
INSERT INTO intereses(afiliado, palabra)VALUES('mqm623', 'Self-enabling');
INSERT INTO intereses(afiliado, palabra)VALUES('rmg171', 'Networked');
INSERT INTO intereses(afiliado, palabra)VALUES('ipi944', 'Cross-platform');
INSERT INTO intereses(afiliado, palabra)VALUES('tua406', 'zero tolerance');
INSERT INTO intereses(afiliado, palabra)VALUES('aum434', 'User-centric');
INSERT INTO intereses(afiliado, palabra)VALUES('two490', 'moratorium');
INSERT INTO intereses(afiliado, palabra)VALUES('imo045', 'Programmable');
INSERT INTO intereses(afiliado, palabra)VALUES('hfp729', 'Sharable');
INSERT INTO intereses(afiliado, palabra)VALUES('syo869', 'interactive');
INSERT INTO intereses(afiliado, palabra)VALUES('axo595', 'homogeneous');
INSERT INTO intereses(afiliado, palabra)VALUES('szb128', 'focus group');
INSERT INTO intereses(afiliado, palabra)VALUES('pns594', 'holistic');

/*libros*/
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca, archivista)
VALUES('Cancion de Hielo y Fuego: Choque de Reyes', 0, 47, 13, 5, 'Penguin Random House', 'Virgilio Barco', '000013');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca, archivista)
VALUES('Cancion de Hielo y Fuego: Tormenta de Espadas', 0, 33, 15, 4, 'Penguin Random House', 'Biblioteca Publica Lago Timiza', '000010');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca, archivista)
VALUES('Antennaria howellii Greene ssp. howellii', 1, 29, 10, 5, 'Norma', 'Biblioteca Publica El parque', '000008');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca, archivista)
VALUES('Basic Industries', 0, 149, 9, 3, 'Norma', 'Biblioteca Publica El parque', '000008');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca, archivista)
VALUES('Basic Industries', 1, 148, 7, 3, 'Norma', 'Biblioteca Publica Julio Mario Santo Domingo', '000007');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca, archivista)
VALUES('El Caballero Errante', 0, 72, 10, 5, 'Penguin Random House', 'Luis Angel Arango', '000012');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca, archivista)
VALUES('Festin de cuervos', 0, 143, 9, 3, 'Penguin Random House', 'Las Ferias', '000009');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca, archivista)
VALUES('Capital Goods', 0, 114, 9, 1, 'Salvat', 'Biblioteca Nacional', '000006');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca, archivista)
VALUES('Celmisia Cass.', 0, 62, 14, 1, 'Norma', 'El Tintal Manuel Zapata Olivella', '000005');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca, archivista)
VALUES('Cancion de Hielo y Fuego: Choque de Reyes', 0, 115, 8, 2, 'Penguin Random House', 'Biblioteca Nacional', '000006');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca, archivista)
VALUES('Ciudad de Cristal', 1, 139, 9, 5, 'Planeta', 'Virgilio Barco', '000013');
/**INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Ciudad de Hueso', 0, 72, 7, 1, 'Planeta', 'Virgilio Barco');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Consumer Services', 1, 122, 2, 3, 'Norma', 'Biblioteca Publica Lago Timiza');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Craniolaria L.', 1, 90, 9, 2, 'Norma', 'Biblioteca Nacional');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Cyrilla Garden ex L.', 0, 131, 9, 2, 'Norma', 'La Victoria');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Cyrilla parvifolia Raf.', 0, 59, 9, 5, 'Norma', 'Biblioteca Publica Lago Timiza');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Draw', 0, 137, 6, 1, 'Norma', 'Biblioteca Publica Parque El Tunal');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Energy', 1, 116, 4, 5, 'Salvat', 'Biblioteca Nacional');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Finance', 0, 65, 8, 3, 'Norma', 'Virgilio Barco');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Finance', 0, 44, 2, 1, 'Norma', 'Luis Angel Arango');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('France', 1, 133, 11, 4, 'Norma', 'Biblioteca Nacional');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Gladiolus communis L.', 0, 21, 14, 2, 'Salvat', 'Biblioteca Publica Julio Mario Santo Domingo');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Health Care', 0, 36, 10, 4, 'Norma', 'El Tintal Manuel Zapata Olivella');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Helianthus nuttallii Torr.', 0, 48, 14, 3, 'Norma', 'Virgilio Barco');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Ischaemum timorense Kunth', 1, 18, 4, 4, 'Norma', 'Biblioteca Publica Lago Timiza');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Loeflingia squarrosa Nutt. ssp. squarrosa', 0, 126, 8, 5, 'Norma', 'Biblioteca Publica Parque El Tunal');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Manihot catingae Ule', 1, 131, 2, 4, 'Norma', 'Virgilio Barco');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Miscellaneous', 1, 110, 14, 5, 'Norma', 'Luis Angel Arango');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Pachira aquatica Aubl.', 0, 24, 14, 1, 'Salvat', 'Biblioteca Nacional');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Pedicularis bracteosa Benth. var. bracteosa', 1, 87, 11, 4, 'Norma', 'Biblioteca Publica Lago Timiza');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Pinus pinea L.', 1, 18, 6, 5, 'Norma', 'Virgilio Barco');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Pteris irregularis Kaulf.', 1, 81, 13, 4, 'Norma', 'Biblioteca Publica El parque');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Quercus cedrosensis C.H. Mull.', 0, 50, 5, 2, 'Norma', 'Biblioteca Publica Julio Mario Santo Domingo');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Rhynchospora megaplumosa Bridges y Orzell', 0, 26, 12, 3, 'Salvat', 'Virgilio Barco');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Scutellaria elliptica Muhl.', 1, 132, 12, 1, 'Salvat', 'El Tintal Manuel Zapata Olivella');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Sphaeromeria compacta (H.M. Hall)', 0, 57, 10, 1, 'Salvat', 'Biblioteca Publica El parque');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Ciudad de Ceniza', 1, 116, 13, 2, 'Planeta', 'Biblioteca Publica Julio Mario Santo Domingo');
INSERT INTO libros(nombre, libre, precio, diasPrestamo, PrecioDiaDemora, editorial, biblioteca)
VALUES('Technology', 0, 126, 5, 3, 'Norma', 'Biblioteca Nacional');*/
/*autores*/
INSERT INTO autores(libro, nombre)
VALUES
(
'pgk292', 'George R.R. Martin'
);

/* INSERT QUERY NO: 2 */
INSERT INTO autores(libro, nombre)
VALUES
(
'ago871', 'George R.R. Martin'
);

/* INSERT QUERY NO: 3 */
INSERT INTO autores(libro, nombre)
VALUES
(
'imf806', 'Bucky McCaskill'
);

/* INSERT QUERY NO: 4 */
INSERT INTO autores(libro, nombre)
VALUES
(
'tki342', 'Gianna Andreas'
);

/* INSERT QUERY NO: 5 */
INSERT INTO autores(libro, nombre)
VALUES
(
'qmv007', 'Christiane Linklet'
);

/* INSERT QUERY NO: 6 */
INSERT INTO autores(libro, nombre)
VALUES
(
'000001', 'George R.R. Martin'
);

/* INSERT QUERY NO: 7 */
INSERT INTO autores(libro, nombre)
VALUES
(
'000002', 'George R.R. Martin'
);

/* INSERT QUERY NO: 8 */
INSERT INTO autores(libro, nombre)
VALUES
(
'000003', 'Letisha Hovenden'
);

/* INSERT QUERY NO: 9 */
INSERT INTO autores(libro, nombre)
VALUES
(
'000004', 'Letisha Hovenden'
);

/* INSERT QUERY NO: 10 */
INSERT INTO autores(libro, nombre)
VALUES
(
'000005', 'Beniamino Waldock'
);

/* INSERT QUERY NO: 11 */
INSERT INTO autores(libro, nombre)
VALUES
(
'000006', 'Letisha Hovenden'
);

/* INSERT QUERY NO: 12 */
INSERT INTO autores(libro, nombre)
VALUES
(
'000007', 'George R.R. Martin'
);

/* INSERT QUERY NO: 13 */
INSERT INTO autores(libro, nombre)
VALUES
(
'000008', 'Cassandra Clare'
);

/* INSERT QUERY NO: 14 */
INSERT INTO autores(libro, nombre)
VALUES
(
'000009', 'Cassandra Clare'
);

/* INSERT QUERY NO: 15 */
INSERT INTO autores(libro, nombre)
VALUES
(
'000010', 'Rubetta Larwood'
);

/* INSERT QUERY NO: 16 */
INSERT INTO autores(libro, nombre)
VALUES
(
'000011', 'Brittany Greir'
);

/* INSERT QUERY NO: 17 */
INSERT INTO autores(libro, nombre)
VALUES
(
'kgp432', 'Brittany Greir'
);

/* INSERT QUERY NO: 18 */
INSERT INTO autores(libro, nombre)
VALUES
(
'hih469', 'Rubetta Larwood'
);

/* INSERT QUERY NO: 19 */
INSERT INTO autores(libro, nombre)
VALUES
(
'jof957', 'Bucky McCaskill'
);

/* INSERT QUERY NO: 20 */
INSERT INTO autores(libro, nombre)
VALUES
(
'ocy073', 'Gianna Andreas'
);

/* INSERT QUERY NO: 21 */
INSERT INTO autores(libro, nombre)
VALUES
(
'jbb186', 'Beniamino Waldock'
);

/* INSERT QUERY NO: 22 */
INSERT INTO autores(libro, nombre)
VALUES
(
'jbb187', 'Christiane Linklet'
);

/* INSERT QUERY NO: 23 */
INSERT INTO autores(libro, nombre)
VALUES
(
'nyg100', 'Christiane Linklet'
);

/* INSERT QUERY NO: 24 */
INSERT INTO autores(libro, nombre)
VALUES
(
'nyg101', 'Beniamino Waldock'
);

/* INSERT QUERY NO: 25 */
INSERT INTO autores(libro, nombre)
VALUES
(
'tbq800', 'Letti Barwis'
);

/* INSERT QUERY NO: 26 */
INSERT INTO autores(libro, nombre)
VALUES
(
'phx749', 'Letisha Hovenden'
);

/* INSERT QUERY NO: 27 */
INSERT INTO autores(libro, nombre)
VALUES
(
'dog808', 'Krystyna Falconer-Taylor'
);

/* INSERT QUERY NO: 28 */
INSERT INTO autores(libro, nombre)
VALUES
(
'ocf581', 'Rolfe Mithun'
);

/* INSERT QUERY NO: 29 */
INSERT INTO autores(libro, nombre)
VALUES
(
'yls048', 'Vanni Blinder'
);

/* INSERT QUERY NO: 30 */
INSERT INTO autores(libro, nombre)
VALUES
(
'wrn003', 'Lynea Ivell'
);

/* INSERT QUERY NO: 31 */
INSERT INTO autores(libro, nombre)
VALUES
(
'grj820', 'Flori Woltering'
);

/* INSERT QUERY NO: 32 */
INSERT INTO autores(libro, nombre)
VALUES
(
'qol739', 'Brittany Greir'
);

/* INSERT QUERY NO: 33 */
INSERT INTO autores(libro, nombre)
VALUES
(
'rwq600', 'Rubetta Larwood'
);

/* INSERT QUERY NO: 34 */
INSERT INTO autores(libro, nombre)
VALUES
(
'xwb370', 'Bucky McCaskill'
);

/* INSERT QUERY NO: 35 */
INSERT INTO autores(libro, nombre)
VALUES
(
'hbt165', 'Gianna Andreas'
);

/* INSERT QUERY NO: 36 */
INSERT INTO autores(libro, nombre)
VALUES
(
'mfl921', 'Christiane Linklet'
);

/* INSERT QUERY NO: 37 */
INSERT INTO autores(libro, nombre)
VALUES
(
'lyz889', 'Beniamino Waldock'
);

/* INSERT QUERY NO: 38 */
INSERT INTO autores(libro, nombre)
VALUES
(
'fak833', 'Letti Barwis'
);

/* INSERT QUERY NO: 39 */
INSERT INTO autores(libro, nombre)
VALUES
(
'kuh384', 'Letisha Hovenden'
);

/* INSERT QUERY NO: 40 */
INSERT INTO autores(libro, nombre)VALUES('ckn018', 'Krystyna Falconer-Taylor');
INSERT INTO autores(libro, nombre)VALUES('omw135', 'Cassandra Clare');
INSERT INTO autores(libro, nombre)VALUES('mge311', 'Rubetta Larwood');

/*Categorias*/

/*Poblar empleados*/
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Case Rodriguez', 1060927138, DATE '2018-10-20', 1178366, 'clanfere0@newyorker.com', '3271793468', 'Biblioteca Publica Lago Timiza', 'b');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Veruca Gutierrez', 1464543231, DATE '2018-10-20', 1128466, 'veruca@newyorker.com', '3136789468', 'Biblioteca Publica Lago Timiza', 'a');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Rori Hernandez', 1075225839, DATE '2018-07-20', 812504, 'rfawthrop1@guardian.co.uk', '3264192107', 'Las Ferias' , 'b');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Ulyses Joyce', 1565435751, DATE '2018-07-20', 812504, 'ulysesJoy@guardian.co.uk', '3232123542', 'Las Ferias' , 'a');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Agnola Aguilar', 1075954605, DATE '2018-11-06', 1025369, 'adanbye2@chronoengine.com', '3190929424', 'Luis Angel Arango', 'b');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Thom Yorke', 1012356522, DATE '2018-11-06', 1025369, 'thomo@chronoengine.com', '3194567642', 'Luis Angel Arango', 'a');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Natalina Gutierrez', 1042698881, DATE '2018-12-09', 1313766, 'nfarney3@ucoz.ru', '3210673233', 'Virgilio Barco', 'b');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Victoria Ramirez', 1041236522, DATE '2018-12-09', 1313766, 'victoria@ucoz.ru', '3256542123', 'Virgilio Barco', 'a');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Marco Avila', 1053571013, DATE '2018-06-20', 879602, 'mstudde4@example.com', '3904716619', 'El Tintal Manuel Zapata Olivella', 'a');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Bjork Linares', 1042325432, DATE '2018-06-20', 879602, 'bjork@example.com', '3032125432', 'El Tintal Manuel Zapata Olivella', 'b');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Robinett Forero', 1076702997, DATE '2018-09-08', 1031227, 'rwenman5@gmpg.org', '3654685240', 'Biblioteca Nacional', 'a');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Ernesto Sabato', 1087673456, DATE '2018-09-08', 1031227, 'ernesto@gmpg.org', '3422235432', 'Biblioteca Nacional', 'b');
INSERT INTO empleados(codigo, nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('aaa006', 'Leighton Sanchez', 1049881964, DATE '2018-07-29', 1166968, 'lbram6@nifty.com', '3861321646', 'Biblioteca Publica Julio Mario Santo Domingo', 'a');
INSERT INTO empleados(codigo, nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('aaa006', 'Alfonso Perez', 1034567532, DATE '2018-07-29', 1166968, 'alfonso@nifty.com', '3021365342', 'Biblioteca Publica Julio Mario Santo Domingo', 'b');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Blane Loaiza', 1015840043, DATE '2018-05-12', 1384614, 'bcornner7@opensource.org', '3437204959', 'Biblioteca Publica El parque', 'a');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Rodia Flores', 1034557522, DATE '2018-05-12', 1384614, 'myshkin@opensource.org', '3001123532', 'Biblioteca Publica El parque', 'b');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Terry Torres', 1087991716, DATE '2018-08-07', 871167, 'tdrage8@dailymail.co.uk', '3027312114', 'Virgilio Barco', 'a');
INSERT INTO empleados(nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('Lina Mina', 1020924654, DATE '2018-08-07', 871167, 'lina8@dailymail.co.uk', '3012323424', 'Virgilio Barco', 'b');
INSERT INTO empleados(codigo, nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('aaa009', 'Nerty Pinzon', 1096516069, DATE '2018-05-18', 936092, 'nparmley9@ebay.co.uk', '3043299328', 'Las Ferias', 'a');
INSERT INTO empleados(codigo, nombre, cedula, fechaVinculacion, salario, correo, telefono, biblioteca, tipo)
VALUES('aaa009', 'Hernan Herrera', 1102234212, DATE '2018-05-18', 936092, 'hernan@ebay.co.uk', '3041235428', 'Las Ferias', 'b');

/*Poblar prestamo*/
INSERT INTO prestamos(codigo, fecha, fechaMaximaEntrega, empleado, afiliado, libro)
VALUES(1, DATE '2018-03-01', DATE '2018-03-04', 'aaa000', 'akb509', 'ago871');
INSERT INTO prestamos(codigo, fecha, fechaMaximaEntrega, empleado, afiliado, libro)
VALUES(2, DATE '2018-03-02', DATE '2018-03-05', 'aaa001', 'kdx604', 'jdh686');
INSERT INTO prestamos(codigo, fecha, fechaMaximaEntrega, empleado, afiliado, libro)
VALUES(3, DATE '2018-02-22', DATE '2018-02-26', 'aaa002', 'fqs694', 'omw135');
INSERT INTO prestamos(codigo, fecha, fechaMaximaEntrega, empleado, afiliado, libro)
VALUES(4, DATE '2018-02-22', DATE '2018-02-26', 'aaa003', 'hfi981', 'hcc368');
INSERT INTO prestamos(codigo, fecha, fechaMaximaEntrega, empleado, afiliado, libro)
VALUES(5, DATE '2018-02-25', DATE '2018-03-02', 'aaa004', 'msg954', 'wrn003');
INSERT INTO prestamos(codigo, fecha, fechaMaximaEntrega, empleado, afiliado, libro)
VALUES(6, DATE '2018-03-27', DATE '2018-03-03', 'aaa005', 'syc615', 'pgk292');

/*Poblar reservas*/
INSERT INTO reservas(codigo, fecha, afiliado_oro, libro, fecha_limite, empleado)
VALUES(1, DATE '2018-03-05', 'imu336', 'tki342', DATE '2018-03-10', 'aaa002');
INSERT INTO reservas(codigo, fecha, afiliado_oro, libro, fecha_limite, empleado)
VALUES(2, DATE '2018-03-07', 'ett783', 'ckn018', DATE '2018-03-10', 'aaa003');
INSERT INTO reservas(codigo, fecha, afiliado_oro, libro, fecha_limite, empleado)
VALUES(3, DATE '2018-02-27', 'lud400', 'mpc505', DATE '2018-03-02', 'aaa004');
INSERT INTO reservas(codigo, fecha, afiliado_oro, libro, fecha_limite, empleado)
VALUES(4, DATE '2018-02-28', 'gof451', 'kgp432', DATE '2018-03-03', 'aaa005');
INSERT INTO reservas(codigo, fecha, afiliado_oro, libro, fecha_limite, empleado)
VALUES(5, DATE '2018-02-26', 'akb509', 'hbt165', DATE '2018-03-02', 'aaa006');
INSERT INTO reservas(codigo, fecha, afiliado_oro, libro, fecha_limite, empleado)
VALUES(6, DATE '2018-03-07', 'syc615', 'yls048', DATE '2018-03-11', 'aaa007');

/*Poblar causas*/
INSERT INTO causas(id, descripcion)
VALUES('Retraso', 'El libro fue entregado despues de la fecha maxima');
INSERT INTO causas(id, descripcion)
VALUES('Perdida', 'El libro fue perdido por el afiliado');
INSERT INTO causas(id, descripcion)
VALUES('Daño leve', 'El libro presenta un ligero daño, no es necesario reemplazo');
INSERT INTO causas(id, descripcion)
VALUES('Daño grave', 'El libro presenta un gran daño, solicita reemplazo');

/*Poblar multas*/
INSERT INTO multas(causa, prestamo, valor)
VALUES('Retraso', 1, 20000);
INSERT INTO multas(causa, prestamo, valor)
VALUES('Perdida', 2, 100000);
INSERT INTO multas(causa, prestamo, valor)
VALUES('Perdida', 3, 200000);
INSERT INTO multas(causa, prestamo, valor)
VALUES('Daño leve', 4, 50000);

/*Consultas gerenciales*/
SELECT codigo, nombre
FROM afiliados
WHERE codigo IN (SELECT p.afiliado
FROM prestamos p JOIN multas m ON p.codigo = m.prestamo
WHERE m.causa = 'Retraso');

SELECT sum(salario) as CostoVariable
FROM empleados;

SELECT COUNT(codigo) as Prestamos_del_dia, fecha
FROM prestamos 
GROUP BY fecha
ORDER BY Prestamos_del_dia DESC;

/*Consultas operacionales*/
SELECT l.nombre
FROM libros l, autores a
WHERE l.codigo=a.libro AND a.nombre = 'George R.R. Martin'
GROUP BY  l.nombre;

SELECT bloqueado
FROM afiliados
WHERE codigo = 'imo045';

CREATE OR REPLACE TRIGGER AD_AFILIADO1
BEFORE INSERT ON AFILIADOS
FOR EACH ROW
DECLARE 
    a number(6);
BEGIN
  SELECT MAX(to_number(codigo ,'999999999999.99')) into a FROM afiliados;
  IF (a IS NULL) THEN
     a:= 0;
  END IF;
  a:= a+ 1;
  IF (a >= 0 AND a <10) THEN 
    :new.codigo := CONCAT('00000', TO_CHAR(a));
  END IF;
  IF (a >= 10 AND a <100) THEN 
    :new.codigo := CONCAT('0000', TO_CHAR(a ));
  END IF;
  IF (a >= 100 AND a <1000) THEN 
    :new.codigo := CONCAT('000', TO_CHAR(a));
  END IF;
  IF (a >= 1000 AND a <10000) THEN 
    :new.codigo := CONCAT('00', TO_CHAR(a));
  END IF;
   IF (a >= 10000 AND a <100000) THEN 
    :new.codigo := CONCAT('0', TO_CHAR(a));
  END IF;
   IF (a >= 100000 AND a <1000000) THEN 
    :new.codigo := TO_CHAR(a);
  END IF;
  IF (:new.tipo IS NULL) THEN
    :new.tipo:= 'n';
  END IF;
END;

CREATE OR REPLACE TRIGGER AD_AFILIADO2
AfTER INSERT ON AFILIADOS
FOR EACH ROW
BEGIN
  IF (:new.tipo = 'o') THEN
     INSERT INTO afiliados_oro (afiliado , diasExtra) VALUES (:new.codigo , 10);
  END IF;
  IF (:new.tipo = 'p') THEN
     INSERT INTO afiliados_plata (afiliado , diasExtra) VALUES (:new.codigo , 5);
  END IF;
  IF (:new.tipo = 'n') THEN
     INSERT INTO afiliados_normal (afiliado , diasExtra) VALUES (:new.codigo , 0);
  END IF;
END;

CREATE OR REPLACE TRIGGER AD_LIBRO1
BEFORE INSERT ON LIBROS
FOR EACH ROW
DECLARE 
    a number(6);
BEGIN
  SELECT MAX(to_number(codigo ,'999999999999.99')) into a FROM libros;
  IF (a IS NULL) THEN
     a:= 0;
  END IF;
  a:= a+ 1;
  IF (a >= 0 AND a <10) THEN 
    :new.codigo := CONCAT('00000', TO_CHAR(a));
  END IF;
  IF (a >= 10 AND a <100) THEN 
    :new.codigo := CONCAT('0000', TO_CHAR(a ));
  END IF;
  IF (a >= 100 AND a <1000) THEN 
    :new.codigo := CONCAT('000', TO_CHAR(a));
  END IF;
  IF (a >= 1000 AND a <10000) THEN 
    :new.codigo := CONCAT('00', TO_CHAR(a));
  END IF;
   IF (a >= 10000 AND a <100000) THEN 
    :new.codigo := CONCAT('0', TO_CHAR(a));
  END IF;
   IF (a >= 100000 AND a <1000000) THEN 
    :new.codigo := TO_CHAR(a);
  END IF;
END;

CREATE OR REPLACE TRIGGER AD_EMPLEADO1
BEFORE INSERT ON EMPLEADOS
FOR EACH ROW
DECLARE 
    a number(6);
BEGIN
  SELECT MAX(to_number(codigo ,'999999999999.99')) into a FROM empleados;
  IF (a IS NULL) THEN
     a:= 0;
  END IF;
  a:= a+ 1;
  IF (a >= 0 AND a <10) THEN 
    :new.codigo := CONCAT('00000', TO_CHAR(a));
  END IF;
  IF (a >= 10 AND a <100) THEN 
    :new.codigo := CONCAT('0000', TO_CHAR(a ));
  END IF;
  IF (a >= 100 AND a <1000) THEN 
    :new.codigo := CONCAT('000', TO_CHAR(a));
  END IF;
  IF (a >= 1000 AND a <10000) THEN 
    :new.codigo := CONCAT('00', TO_CHAR(a));
  END IF;
   IF (a >= 10000 AND a <100000) THEN 
    :new.codigo := CONCAT('0', TO_CHAR(a));
  END IF;
   IF (a >= 100000 AND a <1000000) THEN 
    :new.codigo := TO_CHAR(a);
  END IF;
  IF (:new.tipo IS NULL) THEN
    :new.tipo:= 's';
  END IF;
END;

CREATE OR REPLACE TRIGGER AD_EMPLEADOS2
AfTER INSERT ON EMPLEADOS
FOR EACH ROW
BEGIN
  IF (:new.tipo = 'a') THEN
     INSERT INTO archivistas (empleado) VALUES (:new.codigo);
  END IF;
  IF (:new.tipo = 'b') THEN
     INSERT INTO bibliotecarios (empleado) VALUES (:new.codigo);
  END IF;
  IF (:new.tipo = 's') THEN
     INSERT INTO servicio_generales (empleado) VALUES (:new.codigo);
  END IF;
END;

CREATE OR REPLACE TRIGGER AD_LIBRO2
BEFORE INSERT ON LIBROS
FOR EACH ROW
DECLARE 
    a varchar(50);
BEGIN
    SELECT biblioteca INTO a FROM EMPLEADOS WHERE codigo = :new.archivista;
    IF ( a <> :new.biblioteca) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El archivista que quiere ingresar un libro no está asignado a la biblioteca');
    END IF;
END;

CREATE OR REPLACE TRIGGER AD_RESERVA1
BEFORE INSERT ON RESERVAS
FOR EACH ROW
DECLARE 
    a varchar(50);
    b varchar (50);
BEGIN
    SELECT biblioteca INTO a FROM EMPLEADOS WHERE codigo = :new.bibliotecario;
    SELECT biblioteca INTO b FROM LIBROS WHERE codigo = :new.libro;
    IF ( a <> b) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El bibliotecario que quiere registrar la reserva no está asignado a la biblioteca');
    END IF;
END;

CREATE OR REPLACE TRIGGER AD_PRESTAMO1
BEFORE INSERT ON PRESTAMOS
FOR EACH ROW
DECLARE 
    a varchar(50);
    b varchar (50);
BEGIN
    SELECT biblioteca INTO a FROM EMPLEADOS WHERE codigo = :new.bibliotecario;
    SELECT biblioteca INTO b FROM LIBROS WHERE codigo = :new.libro;
    IF ( a <> b) THEN
        RAISE_APPLICATION_ERROR(-20032, 'El bibliotecario que quiere registrar el prestamo no está asignado a la biblioteca');
    END IF;
END;

CREATE OR REPLACE TRIGGER MO_PRESTAMO
BEFORE UPDATE OF FECHAENTREGA ON PRESTAMOS
FOR EACH ROW 
DECLARE 
    a NUMBER(7);
    b NUMBER(7);
BEGIN 
    a := TRUNC(:old.FECHAMAXIMAENTREGA - :new.FECHAENTREGA, 0);
    IF (a < 0) THEN
       SELECT PRECIODIADEMORA INTO b FROM libros WHERE :old.libro = codigo;
       INSERT INTO multas (causa, prestamo, valor) VALUES ('Retraso' , :old.codigo, a*b);
    END IF;
END;
/*Xpoblar*/
DELETE telefonos;
DELETE etiquetas;
DELETE empleados;
DELETE afiliados;
DELETE afiliados_oro;
DELETE afiliados_plata;
DELETE intereses;
DELETE autores;
DELETE categorias;
DELETE libros;
DELETE causas;
DELETE multas;
DELETE prestamos;
DELETE reservas;
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