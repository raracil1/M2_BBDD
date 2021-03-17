#### EJERCICIO 1

Procedimiento que devuelva  el numero de empleados por rango salarial dentro de un departamento.
El procedimiento solo aceptará el nombre del departamento.

```sql
Ejemplo resultado.

Rango salario departamento: Finance
  6000 -   6999 :    1
  7000 -   7999 :    2
  8000 -   8999 :    1
  9000 -   9999 :    1
 12000 -  12999 :    1
```

#### EJERCICIO 2

Procedimiento que permita cambiar el manager de un empleado por otro. Hay que controlar que el manager insertado no sea el mismo
que ya tiene el empleado, y además hay que controlar que el manager pertenezca al mismo departamento del empleado.
El procedimiento necesitará como parametros  de entrada el id del empleado y el id del manager.


#### EJERCICIO 3

Funcion manager_job_history que a partir de un codigo de departamento como dato de entrada, permita saber cuantos manager de cada departamento aparecen en la tabla job_history.

AL ejecutar esta select:

```sql
select department_name, manager_job_history(department_id)
from departments
```

Debemos obtener el siguiente resultado:

```sql
Administration	    2
Marketing         	1
Purchasing        	1
Human Resources   	0
Shipping	          0
IT	                0
Public Relations  	0
Sales             	0
Executive         	0
Finance           	0
Accounting        	0
Treasury	          NULL
Corporate Tax	      NULL
Control And Credit	NULL
Shareholder Services	NULL
Benefits	          NULL
Manufacturing	      NULL
Construction	      NULL
Contracting	        NULL
Operations	        NULL
IT Support	        NULL
NOC	                NULL
IT Helpdesk	        NULL
Government Sales	  NULL
Retail Sales	      NULL
Recruiting	        NULL
Payroll	            NULL
```

### CURSORES Y EXCEPCIONES

#### EJERCICIO 1
```SQL
Crea las siguientes tablas e introduce registros de prueba:
Realiza los siguientes ejercicios, así como las llamadas a ellos.

EQUIPOS
CodEquipo VARCHAR2, tamaño 4 Clave Primaria
Nombre VARCHAR2, tamaño 30 No Nulo
Localidad VARCHAR2, tamaño 15

PARTIDOS
CodPartido VARCHAR2, tamaño 4 Clave Primaria
CodEquipoLocal VARCHAR2, tamaño 4 Clave Ajena
CodEquipoVisitante VARCHAR2, tamaño 4 Clave Ajena
Fecha FECHA No puede ser de Julio o Agosto
Jornada VARCHAR2, tamaño 20
Gol_Local NUMBER(2)
Gol_Visitante NUMBER(2)


CREATE TABLE EQUIPOS
(
CODEQUIPO VARCHAR2 (4),
NOMBRE VARCHAR2 (30) NOT NULL,
LOCALIDAD varchar2 (15),
CONSTRAINT PK_CODEQUIPO PRIMARY KEY (CODEQUIPO)
);

CREATE TABLE PARTIDOS
(
CODPARTIDO VARCHAR2 (4),
CODEQUIPOLOCAL VARCHAR2 (4),
CODEQUIPOVISITANTE VARCHAR2 (4),
FECHA DATE,
JORNADA VARCHAR2 (20),
GOL_LOCAL NUMBER (2),
GOL_VISITANTE NUMBER (2),
CONSTRAINT PK_CODPARTIDO PRIMARY KEY (CODPARTIDO),
CONSTRAINT FK_CODEQUIPOLOCAL FOREIGN KEY (CODEQUIPOLOCAL) REFERENCES EQUIPOS1(CODEQUIPO),
CONSTRAINT FK_CODEQUIVISITANTE FOREIGN KEY (CODEQUIPOVISITANTE) REFERENCES EQUIPOS1(CODEQUIPO) ON DELETE CASCADE
);

INSERT INTO EQUIPOS1 VALUES (1111, 'SEVILLA', 'SEVILLA');
INSERT INTO EQUIPOS1 VALUES (1112, 'BETIS', 'SEVILLA');
INSERT INTO EQUIPOS1 VALUES (1113, 'MALAGA', 'MALAGA');

INSERT INTO PARTIDOS1 VALUES (2222, 1111, 1112,TO_DATE('01-ENE-2014', 'DD-MON-YYYY'), 'PRIMERA', 1,2);
INSERT INTO PARTIDOS1 VALUES (2223, 1111, 1113,TO_DATE('02-ENE-2014', 'DD-MON-YYYY'),'SEGUNDA', 3,2);
INSERT INTO PARTIDOS1 VALUES (2224, 1112, 1113,TO_DATE('03-ENE-2014', 'DD-MON-YYYY'),'PRIMERA', 4,1);

/*
1.- Crea una función DevolverNombreEquipo que reciba un código de equipo y devuelva el nombre del mismo.
Si el equipo no existe devuelve la cadena “Error en código”.
*/

/*
Crea una procedimiento DevolverGolesEquipo que reciba el código de un equipo y devuelva el total de goles a favor y total de goles en contra.
 Contempla las excepciones oportunas.
*/

/*
Crea un procedimiento DevolverResultadosEquipo que reciba el código de un equipo y devuelva el número de partidos que ha ganado, el número de partidos que ha perdido y el número de partidos que ha empatado. Contempla las excepciones oportunas.
*/


```

#### EJERCICIO 2

```sql
CREATE TABLE SOCIOS
(
DNI VARCHAR2 (10) NOT NULL,
NOMBRE VARCHAR2 (20) NOT NULL,
DIRECCION VARCHAR2 (20),
PENALIZACIONES NUMBER (2) DEFAULT 0,
CONSTRAINT PK_DNI_SOC PRIMARY KEY (DNI)
);

INSERT INTO SOCIOS VALUES (11111111, 'ANA', 'CALLE 1',1);
INSERT INTO SOCIOS VALUES (11111112, 'ROCIO', 'CALLE 2',0);
INSERT INTO SOCIOS VALUES (11111113, 'JAVIER', 'CALLE 3',2);

CREATE TABLE LIBROS
(
REFLIBRO VARCHAR2 (10) NOT NULL,
NOMBRE VARCHAR2 (30) NOT NULL,
AUTOR VARCHAR2 (20) NOT NULL,
GENERO VARCHAR2 (10),
ANYOPUBLICACION NUMBER,
EDITORIAL VARCHAR2 (10),
CONSTRAINT PK_REFLIBRO PRIMARY KEY (REFLIBRO)
);

INSERT INTO LIBROS VALUES ('1111111A', 'LIBRO1', 'AUTOR1','GENERO1',2000,'EDITORIAL1');
INSERT INTO LIBROS VALUES ('1111111B', 'LIBRO2', 'AUTOR2','GENERO2',2000,'EDITORIAL2');
INSERT INTO LIBROS VALUES ('1111111C', 'LIBRO3', 'AUTOR3','GENERO3',2000,'EDITORIAL3');

CREATE TABLE PRESTAMOS
(
DNI VARCHAR2 (10) NOT NULL,
REFLIBRO VARCHAR2 (10) NOT NULL,
FECHAPRESTAMO DATE NOT NULL,
DURACION NUMBER (2) DEFAULT 24,
CONSTRAINT PK_PRESTAMOS PRIMARY KEY (DNI,REFLIBRO,FECHAPRESTAMO),
CONSTRAINT FK_DNI_PREST FOREIGN KEY (DNI) REFERENCES SOCIOS(DNI),
CONSTRAINT FK_REFLIBRO_PREST FOREIGN KEY (REFLIBRO) REFERENCES LIBROS(REFLIBRO)ON DELETE CASCADE
);

INSERT INTO PRESTAMOS VALUES (11111111, '1111111A', TO_DATE('01-ENE-2014', 'DD-MON-YYYY'),1);
INSERT INTO PRESTAMOS VALUES (11111112, '1111111B', TO_DATE('02-ENE-2014', 'DD-MON-YYYY'),2);
INSERT INTO PRESTAMOS VALUES (11111113, '1111111C', TO_DATE('03-ENE-2014', 'DD-MON-YYYY'),3);


/*
Realiza un procedimiento llamado listadotresmasprestados que nos muestre por pantalla un listado de los tres libros más prestados y los socios a los que han sido prestados con el siguiente formato:

NombreLibro1 NumPrestamosLibro1 GeneroLibro1

DNISocio1 FechaPrestamoalSocio1
...
DNISocion FechaPrestamoal Socion

NombreLibro2 NumPrestamosLibro2 GeneroLibro2

DNISocio1 FechaPrestamoalSocio1
...
DNISocion FechaPrestamoalSocion

NombreLibro3 NumPrestamosLibro3 GeneroLibro3

DNISocio1 FechaPrestamoalSocio1
...
DNISocion FechaPrestamoalSocion

El procedimiento debe gestionar adecuadamente las siguientes excepciones:
La tabla Libros está vacía.
La tabla Socios está vacía.
Hay menos de tres libros que hayan sido prestados.

*/

```

#### EJERCICIO 3

```sql
DROP TABLE ALUMNOS cascade constraints;

CREATE TABLE ALUMNOS
(
  DNI VARCHAR2(10) NOT NULL,
  APENOM VARCHAR2(30),
  DIREC VARCHAR2(30),
  POBLA  VARCHAR2(15),
  TELEF  VARCHAR2(10) 
);

DROP TABLE ASIGNATURAS cascade constraints;

CREATE TABLE ASIGNATURAS
(
  COD NUMBER(2) NOT NULL,
  NOMBRE VARCHAR2(25)
);

DROP TABLE NOTAS cascade constraints;

CREATE TABLE NOTAS
(
  DNI VARCHAR2(10) NOT NULL,
  COD NUMBER(2) NOT NULL,
  NOTA NUMBER(2)
);

INSERT INTO ASIGNATURAS VALUES (1,'Prog. Leng. Estr.');
INSERT INTO ASIGNATURAS VALUES (2,'Sist. Informáticos');
INSERT INTO ASIGNATURAS VALUES (3,'Análisis');
INSERT INTO ASIGNATURAS VALUES (4,'FOL');
INSERT INTO ASIGNATURAS VALUES (5,'RET');
INSERT INTO ASIGNATURAS VALUES (6,'Entornos Gráficos');
INSERT INTO ASIGNATURAS VALUES (7,'Aplic. Entornos 4ªGen');

INSERT INTO ALUMNOS VALUES
('12344345','Alcalde García, Elena', 'C/Las Matas, 24','Madrid','917766545');

INSERT INTO ALUMNOS VALUES
('4448242','Cerrato Vela, Luis', 'C/Mina 28 - 3A', 'Madrid','916566545');

INSERT INTO ALUMNOS VALUES
('56882942','Díaz Fernández, María', 'C/Luis Vives 25', 'Móstoles','915577545');

INSERT INTO NOTAS VALUES('12344345', 1,6);
INSERT INTO NOTAS VALUES('12344345', 2,5);
INSERT INTO NOTAS VALUES('12344345', 3,6);

INSERT INTO NOTAS VALUES('4448242', 4,6);
INSERT INTO NOTAS VALUES('4448242', 5,8);
INSERT INTO NOTAS VALUES('4448242', 6,4);
INSERT INTO NOTAS VALUES('4448242', 7,5);

INSERT INTO NOTAS VALUES('56882942', 5,7);
INSERT INTO NOTAS VALUES('56882942', 6,8);
INSERT INTO NOTAS VALUES('56882942', 7,9);

COMMIT;

/*
Diseña una función llamada nota_media que reciba un nombre de un módulo y devuelva la nota media obtenida por los alumnos matriculados en el mismo.
*/

/*
Diseña un procedimiento al que pasemos como parámetro de entrada el nombre de uno de los módulos existentes en la BD y visualice el nombre de los alumnos que lo han cursado junto a su nota.
Al final del listado debe aparecer el nº de suspensos, aprobados, notables y sobresalientes.
Asimismo, deben aparecer al final los nombres y notas de los alumnos que tengan la nota más alta y la más baja.
Debes comprobar que las tablas tengan almacenada información y que exista el módulo cuyo nombre pasamos como parámetro al procedimiento.

```
#### EJERCICIO4

```sql
DROP TABLE productos CASCADE CONSTRAINTS;

CREATE TABLE productos
(
                CodProducto     VARCHAR2(10) CONSTRAINT p_cod_no_nulo NOT NULL,
                Nombre              VARCHAR2(20) CONSTRAINT p_nom_no_nulo NOT NULL,
                LineaProducto  VARCHAR2(10),
                PrecioUnitario  NUMBER(6),
                Stock                    NUMBER(5),
                PRIMARY KEY (CodProducto)
);

DROP TABLE ventas CASCADE CONSTRAINTS;

CREATE TABLE ventas
(
                CodVenta                           VARCHAR2(10) CONSTRAINT cod_no_nula NOT NULL,
                CodProducto                    VARCHAR2(10) CONSTRAINT pro_no_nulo NOT NULL,
                FechaVenta                       DATE,
                UnidadesVendidas         NUMBER(3),
                PRIMARY KEY (CodVenta)
);

INSERT INTO productos VALUES ('1','Procesador P133', 'Proc',15000,20);
INSERT INTO productos VALUES ('2','Placa base VX',   'PB',  18000,15);
INSERT INTO productos VALUES ('3','Simm EDO 16Mb',   'Memo', 7000,30);
INSERT INTO productos VALUES ('4','Disco SCSI 4Gb',  'Disc',38000, 5);
INSERT INTO productos VALUES ('5','Procesador K6-2', 'Proc',18500,10);
INSERT INTO productos VALUES ('6','Disco IDE 2.5Gb', 'Disc',20000,25);
INSERT INTO productos VALUES ('7','Procesador MMX',  'Proc',15000, 5);
INSERT INTO productos VALUES ('8','Placa Base Atlas','PB',  12000, 3);
INSERT INTO productos VALUES ('9','DIMM SDRAM 32Mb', 'Memo',17000,12);

INSERT INTO ventas VALUES('V1', '2', '22/09/97',2);
INSERT INTO ventas VALUES('V2', '4', '22/09/97',1);
INSERT INTO ventas VALUES('V3', '6', '23/09/97',3);
INSERT INTO ventas VALUES('V4', '5', '26/09/97',5);
INSERT INTO ventas VALUES('V5', '9', '28/09/97',3);
INSERT INTO ventas VALUES('V6', '4', '28/09/97',1);
INSERT INTO ventas VALUES('V7', '6', '02/10/97',2);
INSERT INTO ventas VALUES('V8', '6', '02/10/97',1);
INSERT INTO ventas VALUES('V9', '2', '04/10/97',4);
INSERT INTO ventas VALUES('V10','9', '04/10/97',4);
INSERT INTO ventas VALUES('V11','6', '05/10/97',2);
INSERT INTO ventas VALUES('V12','7', '07/10/97',1);
INSERT INTO ventas VALUES('V13','4', '10/10/97',3);
INSERT INTO ventas VALUES('V14','4', '16/10/97',2);
INSERT INTO ventas VALUES('V15','3', '18/10/97',3);
INSERT INTO ventas VALUES('V16','4', '18/10/97',5);
INSERT INTO ventas VALUES('V17','6', '22/10/97',2);
INSERT INTO ventas VALUES('V18','6', '02/11/97',2);
INSERT INTO ventas VALUES('V19','2', '04/11/97',3);
INSERT INTO ventas VALUES('V20','9', '04/12/97',3);

/*
Realiza un procedimiento que actualice la columna Stock de la tabla Productos a partir de los registros de la tabla Ventas.
El citado procedimiento debe informarnos por pantalla si alguna de las tablas está vacía o si el stock de un producto pasa a ser negativo, en cuyo caso se parará la actualización.
*/


```
