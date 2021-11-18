--Prueba - Biblioteca
--Parte 2 - Creando el modelo en la base de datos
--1. Crear el modelo en una base de datos llamada biblioteca, considerando las tablas
--definidas y sus atributos.

CREATE TABLE libro(
	isbn BIGINT PRIMARY KEY,
	titulo VARCHAR(30) ,
	numero_paginas INTEGER ,
	codigo_autor INTEGER ,
	nombre_autor VARCHAR(20),
	apellido_autor VARCHAR(20),
	año_nacimiento VARCHAR(9),
	año_muerte VARCHAR(9),
	tipo_autor VARCHAR(10),
	dias_prestamo INTEGER
);

SELECT * FROM libro


CREATE TABLE socios(
	rut VARCHAR(10) PRIMARY KEY,
	nombre VARCHAR(20),
	apellido VARCHAR(20),
	direccion VARCHAR(500),
	telefono VARCHAR(9)
);

SELECT * FROM socios

CREATE TABLE prestamos(
	id_prestamo INT PRIMARY KEY,
	socio VARCHAR(40),
	libro VARCHAR(30),
	fecha_prestamo DATE,
	fecha_esperada_entrega DATE,
	fecha_real_entrega DATE,
	ISBN_libro BIGINT,
	Rut_socio VARCHAR(12),
	FOREIGN KEY (ISBN_libro) REFERENCES libro(ISBN),
	FOREIGN KEY (Rut_socio) REFERENCES socios(Rut)
);

SELECT * FROM prestamos


--2. Se deben insertar los registros en las tablas correspondientes

INSERT INTO libro
VALUES (1111111111111,'CUENTOS DE TERROR',344,3,'JOSE','SALGADO','1968','2020','PRINCIPAL',7),
       (2222222222222,'POESÍAS CONTEMPORANEAS',167,1,'ANDRÉS','ULLOA','1982','Vivo','PRINCIPAL',7),
       (3333333333333,'HISTORIA DE ASIA',511,2,'SERGIO','MARDONES','1950','2012','PRINCIPAL',14),
       (4444444444444,'MANUAL DE MECÁNICA',298,5,'MARTIN','PORTA','1976','Vivo','PRINCIPAL',14);

SELECT * FROM libro

INSERT INTO socios
VALUES ('1111111-1', 'JUAN', 'SOTO', 'AVENIDA 1, SANTIAGO', '911111111'),
       ('2222222-2', 'ANA', 'PÉREZ', 'PASAJE 2, SANTIAGO', '922222222'),
       ('3333333-3', 'SANDRA', 'AGUILAR', 'AVENIDA 2, SANTIAGO', '933333333'),
       ('4444444-4', 'ESTEBAN', 'JEREZ', 'AVENIDA 3, SANTIAGO', '944444444'),
       ('5555555-5', 'SILVANA', 'MUÑOZ', 'PASAJE 3, SANTIAGO', '955555555');

SELECT * FROM socios

INSERT INTO prestamos
VALUES (1,'JUAN SOTO','CUENTOS DE TERROR','2020-01-20','2020-01-27','2020-01-27',1111111111111,'1111111-1'),
       (2,'SILVANA MUÑOZ','POESÍAS CONTEMPORANEAS','2020-01-20','2020-01-27', '2020-01-30',3333333333333,'5555555-5'),
       (3,'SANDRA AGUILAR','HISTORIA DE ASIA','2020-01-22','2020-01-29','2020-01-30',4444444444444,'3333333-3'),
       (4,'ESTEBAN JEREZ','MANUAL DE MECÁNICA','2020-01-23','2020-01-30','2020-01-30',4444444444444,'4444444-4'),
       (5,'ANA PÉREZ','CUENTOS DE TERROR','2020-01-27','2020-02-03','2020-02-04',1111111111111,'2222222-2'),
       (6,'JUAN SOTO','MANUAL DE MECÁNICA','2020-01-31','2020-02-07','2020-02-12',4444444444444,'1111111-1'),
       (7, 'SANDRA AGUILAR','POESÍAS CONTEMPORANEAS','2020-01-31','2020-02-07','2020-02-12',2222222222222,'3333333-3');
SELECT * FROM prestamos   

--3. Realizar las siguientes consultas:

----a. Mostrar todos los libros que posean menos de 300 páginas.

 SELECT titulo, numero_paginas,nombre_autor, apellido_autor
 FROM libro
 WHERE numero_paginas < 300;

--b. Mostrar todos los autores que hayan nacido después del 01-01-1970.

 SELECT nombre_autor, apellido_autor, año_nacimiento
 FROM libro 
 WHERE año_nacimiento > '1970-01-01';


--c. ¿Cuál es el libro más solicitado?

  SELECT libro, COUNT(*) 
  FROM prestamos 
  GROUP BY libro
  HAVING COUNT(*)>1;


-- d. Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto
-- debería pagar cada usuario que entregue el préstamo después de 7 días.
 
 SELECT socio, libro, fecha_prestamo,fecha_esperada_entrega,fecha_real_entrega,
 fecha_real_entrega::DATE - fecha_esperada_entrega::DATE
 AS dias_atraso,
 (fecha_real_entrega::DATE - fecha_esperada_entrega::DATE) *100
 AS multa FROM prestamos
 ORDER BY socio;


	   