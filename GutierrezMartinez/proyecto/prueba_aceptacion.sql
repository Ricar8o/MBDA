/*Soy un archivista de la biblioteca Luis Angel Arango*/
INSERT INTO empleados(biblioteca, cedula, nombre, fechavinculacion, salario, correo, telefono, tipo) VALUES 
('Luis Angel Arango', '1000929358', 'Pedro Ayala', (SELECT SYSDATE FROM DUAL), 2000000, 'pedro.ay@biblio.com', '3142923245', 'a');
/*Voy a registrar un nuevo libro recien adquierido por la biblioteca*/
EXECUTE pc_libros.ad_libro('El Castillo', 30000, 5, 2000, 'DeBolsilo', 'Luis Angel Arango', '001003', 'abc987');
/*Ahora registrare su autor*/
EXECUTE pc_libros.ad_autor('000250', 'Franz Kafka');
/*Ahora lo pondre en una categoria*/
EXECUTE pc_libros.ad_categoria('000250', 'Existencialismo');
/*Y agregare algunas etiquetas*/
EXECUTE pc_libros.ad_etiqueta('000250', 'Aleman');
EXECUTE pc_libros.ad_etiqueta('000250', 'Burocracia');
EXECUTE pc_libros.ad_etiqueta('000250', 'Siglo XX');
EXECUTE pc_libros.ad_etiqueta('000250', 'Clasico');
/*Ahora quisiera saber que editoriales hay en la biblioteca donde estoy*/ 
SELECT PC_LIBROS.CO_EDITORIALES_BIBLIOTECA ('Luis Angel Arango') FROM DUAL;
/*Para saber si mandar a adquirir una nueva edicion de 'La mala hora', me gustaria saber cuales tenemos 
en este momento en la biblioteca*/
SELECT PC_LIBROS.CO_LIBROS_BIBLIOTECA ('La mala hora', 'Luis Angel Arango') FROM DUAL;
/*Quisiera consultar cuales libros libres hay en el sistema de 'La vuelta al dia en ochenta mundos*/
SELECT PC_LIBROS.CO_LIBRO_LIBRE ('La vuelta al dia en ochenta mundos')  FROM DUAL;
/*Ahora quisiera saber si hay alguno en nuestra biblioteca*/
SELECT PC_LIBROS.CO_LIBRO_LIBRE_B ('La vuelta al dia en ochenta mundos', 'Luis Angel Arango') FROM DUAL;
/*Qusiera saber cuantos libros libres tenemos de 'Albert Camus' en el sistema y en donde se encuentran*/
SELECT PC_LIBROS.CO_LIBRO_LIBRE_A ('Albert Camus') FROM DUAL;
/*Finalmente, me gustaria saber que otros libros de 'clasicos' tenemos en el sistema*/
SELECT PC_LIBROS.CO_LIBRO_LIBRE_E ('Clasico') FROM DUAL;

/*Soy el nuevo bibliotecario de la 'Luis Angel Arango'*/
INSERT INTO empleados(biblioteca, cedula, nombre, fechavinculacion, salario, correo, telefono, tipo) VALUES 
('Luis Angel Arango', '1022432945', 'Ramiro Rodriguez', (SELECT SYSDATE FROM DUAL), 1000000, 'rramiro@biblio.com', '3175423235', 'b');
/*Como primera labor, debo editar: el precio, dias, precio por retraso, editorial y direccion del libro 'El castillo', del cual tengo
su identificador*/
EXECUTE PC_LIBROS.MO_LIBRO_PRECIO ('000250', 40000);
EXECUTE PC_LIBROS.MO_LIBRO_DIAS ('000250', 8);
EXECUTE PC_LIBROS.MO_LIBRO_PRECIO_DIA ('000250', 8000);
EXECUTE PC_LIBROS.MO_LIBRO_EDITORIAL ('000250', 'DeBolsillo');
EXECUTE PC_LIBROS.MO_DIRECCION ('000250', 'var146');


/*Soy Tomas Casablanas, me quiero inscribir a la red de bibliotecas.
Quiero primero tener una suscripcion normal*/
EXECUTE PCK_AFILIADO.AD_AFILIADO('1000491420', 'Tomas Casablancas', 'tomas.casa@mail.com', '3004442907', 'n');
SELECT * FROM AFILIADOS WHERE cedula = '1000491420';
/*Quisiera consultar un libro de Albert Camus que se encuentre libre y saber en que biblioteca esta*/
SELECT PC_LIBROS.CO_LIBRO_LIBRE_A ('Franz Kafka') FROM DUAL;
/*Noto que El Casitllo esta libre en la Luis Angel Arango. Espectacular para mi, ya que es un libro que siempre me 
ha interesado y ademas la biblioteca solo queda a unas cuadras de mi casa. 
Para asegurarme de tenerlo, deseo reservarlo, asi no me llevare con una sorpresa cuando llegue*/
EXECUTE PC_RESERVA.AD_RESERVA('000250', '001001');
/*Al parecer no puede hacer la reserva, a menos que sea usuario oro o plata. 
Creo que pagare por la suscripcion plata, solo son unos pesos mas*/
EXECUTE PCK_AFILIADO.MO_AFILIADO_TIP ('001001', 'p');
/*Ahora intentare nuevamente hacer la reserva*/
EXECUTE PC_RESERVA.AD_RESERVA('000250', '001001');
/*Listo, ire mañana por el libro, ya que hoy estoy ocupado.
Hoy ire a reclamar el libro que reserve. Voy a la caja y dejo que el bibliotecario de turno registre mi prestamo*/
EXECUTE PC_PRESTAMO.AD_PRESTAMO('001004', '000250', '001001');
/*Despues de terminar mi libro deseo retornarlo a la biblioteca. 
Lo registra el mismo bibliotecario que antes*/
EXECUTE PC_PRESTAMO.DEVOLVER_LIBRO('001004', '000250');
/*Antes de irme de la biblioteca, quisiera hacer una rapida renovacion de datos, ya que 
perdi mi clave del correo y digite mal mi telefono la primera vez*/
EXECUTE PCK_AFILIADO.MO_AFILIADO_COR ('001001', 'casatomas@gmail.com');
EXECUTE PCK_AFILIADO.MO_AFILIADO_TEL ('001001', '3004442906');