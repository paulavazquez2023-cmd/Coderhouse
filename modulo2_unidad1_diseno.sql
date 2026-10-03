--CREAR BASE DE DATOS
CREATE DATABASE modulo2unidad1;

--CLAUSULA USE
USE modulo2unidad1;

--CREAR TABLA CLIENTES 
CREATE TABLE Clientes (
Id_Cliente INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
Nombre VARCHAR(100) NOT NULL,
Perfil_bio TEXT NOT NULL,
Fecha_registro DATE NOT NULL
);

--CREAR TABLA PRODUCTOS
CREATE TABLE Productos (
Id_Producto INT NOT NULL PRIMARY KEY,
Descripcion VARCHAR (255),
Precio DECIMAL(10,2),
Esta_activo INT,
);

--USE para crear las tablas en la base de datos generada
--Id_Cliente INT numero entero (INT) not null para que exista el dato y que varie de 1 en 1 (identity)
--Nombre VARCHAR (100) para colocar texto de hasta 100 caracteres y not null para que exista el dato
--Perfil_bio porque la consigna pedia general una columna donde se pueda escribir texto y elegi esa opcion sin limite de caracteres
--Fecha_registro pide solo la fecha por eso elegi date
--Id_producto INT para que el identificador sea un numero entero, not null para que exista el dato
-- Descripcion la consigna solicita un espacio para incluir texto hasta 255 caracteres
-- Precio es un valor numerico que puede ser decimal de hasta diez digitos con dos decimales
-- Esta_activo para saber si el producto tiene stock seleccione la opcion de INT numero entero para saber la cantidad de productos que quedan, incluso puede ser cantidad nula.

