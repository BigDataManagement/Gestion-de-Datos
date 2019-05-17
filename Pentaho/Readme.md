# Pentaho

Pasos a seguir para ejecutar el trabajo:

## 1. Ejecutar los scripts de MySQL en Workbench.

* [Diseño Rental](./Pentaho/Pentaho.sql)

* [Diseño Payment](./Pentaho/Payment.sql)

## 2. Abrir los scrips de pentaho en el programa.
* [Rental](./Pentaho/Pentaho.ktr)

* [Payment](./Pentaho/Payment.ktr)

## 3. Realizar conexión en Pentaho a cada uno de los esquemas.
En esta parte se debe cambiar la configuración de la base de datos (como se muestra en la imagen) según los datos que tiene en su Workbench. 

![](./Pentaho/conexion.png)

## 4. Ejecución.
Para ambos archivos, se deben realizar los siguientes pasos.

![](./Pentaho/disable.jpeg)

* Correr el .ktr con lo señalado en la imagen en modo enable (flechas de color azul).

* Volver a correr el .ktr con lo señalado en la imagen en modo disable (flechas grises).
