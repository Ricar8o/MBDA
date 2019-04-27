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

