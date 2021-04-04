# PACKAGES

## DEFINICIÓN
Un paquete, es una sección declarativa nominada y cualquier cosa que se pueda incluir en esta
sección, se puede incluir en un paquete: procedimientos, funciones, cursores, tipos y variables.

Los paquetes:
1. no pueden ser llamados, parametrizados o anidados.
2. pueden contener procedimientos y/o funciones. Algunos de estos subprogramas pueden ser privados a los paquetes y otros públicos

## PARTES DE UN PAQUETE

1. CABECERA: La especificación (o cabecera) del paquete, contiene información sobre el contenido del paquete.
No contiene código de los procedimientos.
2. CUERPO: El cuerpo del paquete, es un objeto del diccionario de datos distinto de la cabecera. Este cuerpo
no puede ser compilado a menos que se haya previamente compilado la cabecera
Paquets no puede ser compilado a menos que se haya previamente compilado la cabecera correspondiente. 
El cuerpo contiene el código para las declaraciones formales de subprogramas incluidas en la cabecera

## CREACIÓN DE UN PAQUETE

CABECERA:
```SQL
CREATE [OR REPLACE] PACKAGE nombre_paquete
AS | IS
especificació_procedimiento |
especificación_función | declaración_variable
| definición_tipo | declaración_excepción |
declaración_cursor
Cabecera del
paquete }
Paquets END nombre_paquete; /
```
CUERPO:
```SQL
CREATE [OR REPLACE ] PACKAGE BODY nombre_paquete
AS | IS
declaraciones | subprogramas PL/SQL
END nombre_paquete;
```

Son necesarias las dos partes, tanto la cabecera como el cuerpo, y como podemos observar, en la cabecera
simplemente añadimos los objetos que vamos a crear mientras que en el cuerpo, ya especificamos la funcionalidad
del paquete.

### EJEMPLOS

#### paquete llamado imprimir que contieen un procedimiento llamado saludo.

```sql
CREATE OR REPLACE PACKAGE imprimir
AS
PROCEDURE saludo;
END imprimir;
/

CREATE OR REPLACE PACKAGE BODY imprimir
Paquets ASPROCEDURE saludo IS
BEGIN
DBMS_OUTPUT.PUT_LINE ('HOLA, ESTO ES UNA
PRUEBA');
END;
END imprimir;
```
Esto compila el paquete, pero no lo ejecuta, para llamarlo tendríamos que realizar lo siguiente:
```sql
SET SERVEROUTPUT ON
SET VERIFY OFF
SET ECHO OFF
BEGIN
imprimir.saludo;
END;
/
```

#### EJEMPLO PAQUETE VARIOS SUBPROGRAMAS PARA LA BBDD HR

Escribir un paquete completo para gestionar los departamentos. El paquete se llamará
gest_depart y deberá incluir, al menos, los siguientes subprogramas:
1. insertar_nuevo_depart: permite insertar un departamento nuevo. El procedimiento
recibe el nombre y la localidad del nuevo departamento. Creará el nuevo departamento
comprobando que el nombre no se duplique y le asignará como número de
departamento la decena siguiente al último número de departamento utilizado.
2. visualizar_datos_depart:  visualizará los datos de un departamento cuyo nombre se
pasará en la llamada. Además de los datos relativos al departamento, se visualizará el
número de empleados que pertenecen actualmente al departamento. Realizará
una llamada a la función buscar_depart_por_nombre que se indica en el apartado
siguiente.
3. buscar_depart_por_nombre: función local al paquete. Recibe el nombre de un
departamento y devuelve el número del mismo.


```SQL
/************* Cabecera o especificación del paquete **********/
CREATE OR REPLACE PACKAGE gest_depart AS

PROCEDURE insert_depart
(v_nom_dep VARCHAR2,
v_loc VARCHAR2);

PROCEDURE visualizar_datos_depart
(v_num_dep NUMBER);

END gest_depart;
/

/******************* Cuerpo del paquete **********************/
CREATE OR REPLACE PACKAGE BODY gest_depart AS
FUNCTION buscar_depart_por_nombre /* Función privada */
(v_nom_dep VARCHAR2)
RETURN NUMBER;
/*************************************************************/
PROCEDURE insert_depart(
v_nom_dep VARCHAR2,
v_loc VARCHAR2)
AS
ultimo_dep DEPART.DEPT_NO%TYPE;
nombre_repetido EXCEPTION;
BEGIN
/*Comprobar dpt repetido(Puede levantar NO_DATA_FOUND)*/
DECLARE
nom_dep depart.DNOMBRE%TYPE;
nombre_repetido EXCEPTION;
BEGIN
SELECT dnombre INTO nom_dep FROM depart
WHERE dnombre = v_nom_dep;
RAISE insert_depart.nombre_repetido;
EXCEPTION
WHEN NO_DATA_FOUND THEN
NULL;
WHEN TOO_MANY_ROWS THEN
RAISE insert_Depart.nombre_repetido;
END; /* Fin del bloque de comprobación
de departamento repetido */
/* Calcular el número de departamento e insertar */
SELECT MAX(DEPT_NO) INTO ultimo_dep FROM DEPART;
INSERT INTO DEPART VALUES ((TRUNC(ultimo_dep, -1) +10),
v_nom_dep,v_loc);
EXCEPTION
WHEN nombre_repetido THEN
DBMS_OUTPUT.PUT_LINE
('Err. Nombre de departamento duplicado');
WHEN NO_DATA_FOUND THEN /* Si no había ningún departamento */
INSERT INTO DEPART VALUES (10,v_nom_dep,v_loc);
END insert_depart;
/**************************************************************/
PROCEDURE visualizar_datos_depart 
(v_nom_dep VARCHAR2)
AS
v_num_dep depart.dept_no%TYPE;
vr_dep depart%ROWTYPE;
v_num_empleados NUMBER(4);
BEGIN
v_num_dep:=buscar_depart_por_nombre(v_nom_dep);
SELECT * INTO vr_dep FROM depart
WHERE dept_no=v_num_dep;
28
SELECT COUNT(*) INTO v_num_empleados FROM EMPLE
WHERE dept_no=v_num_dep;
DBMS_OUTPUT.PUT_LINE
('Número de departamento: '||vr_dep.dept_no);
DBMS_OUTPUT.PUT_LINE
('Nombre del departamento: '||vr_dep.dnombre);
DBMS_OUTPUT.PUT_LINE
('Localidad : '||vr_dep.loc);
DBMS_OUTPUT.PUT_LINE
('Numero de empleados : '||v_num_empleados);
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Err departamento no encontrado');
END visualizar_datos_depart;
/*************************************************************/
FUNCTION buscar_depart_por_nombre
(v_nom_dep VARCHAR2)
RETURN NUMBER
AS
v_num_dep depart.dept_no%TYPE;
BEGIN
SELECT dept_no INTO v_num_dep FROM depart
WHERE DNOMBRE = v_nom_dep;
RETURN v_num_dep;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Err departamento no encontrado');
END buscar_depart_por_nombre;

END gest_depart;
```

### EJERCICIOS

Escribir un paquete completo para gestionar las localizaciones. El paquete se llamará
gest_loc y deberá incluir, al menos, los siguientes subprogramas:
1. insertar_nueva_loc: permite insertar una localizacon nueva. El procedimiento
recibe como calle, ciudad, postal_code, provincia y country_id . Creará la nueva localizacoin comprobando que no exista ya una en la misma ciudad.
2. modificar_loc_calle: Recibirá el loc_id. Modificará la calle.
3. modificar_loc_cod_pos: Recibirá el loc_id. Modificará el codigo postal
4. modificar_loc_city: Recibirá el loc_id. Modificará la ciudad.
5. modificar_loc_prov: Recibirá el loc_id. Modificará la provincia.
6. modificar_loc_country: Recibirá el loc_id. Modificará el pais.
visualizar_datos_loc: visualizará los datos de una localización cuyo número se
pasará en la llamada. Además de los datos relativos de una localización, se visualizará el
número de empleados trabajan en esa localidad.
