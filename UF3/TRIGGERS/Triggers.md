# TRIGGERS

Los Triggers son programas almacenados que se ejecutan o disparan automáticamente cuando se producen algunos eventos. 
Los Triggers son escritos para ser ejecutado en respuesta a cualquiera de los siguientes eventos: 
Una sentencia de manipulación de Bases de Datos (DML) (DELETE, INSERT o UPDATE).

```sql
CREATE {OR REPLACE} TRIGGER nombre_disp
  [BEFORE|AFTER]
  [DELETE|INSERT|UPDATE {OF columnas}] [ OR [DELETE|INSERT|UPDATE {OF columnas}]...]
  ON tabla
  [FOR EACH ROW [WHEN condicion disparo]]
[DECLARE]
  -- Declaración de variables locales
BEGIN
  -- Instrucciones de ejecución
[EXCEPTION]
  -- Instrucciones de excepción
END;
```

## Usos:
Los Triggers complementan las capacidades básicas de Oracle para proporcionar un sistema de gestión de Base de Datos altamente personalizado. 
Por ejemplo, un Trigger puede restringir las operaciones DML en una tabla para que solo se ejecuten en horario de oficina. 
También pueden ser usados para:

1. Generar automáticamente valores derivados en columnas.
2. Evitar transacciones inválidas. 
3. Imponer complejas autorizaciones de seguridad.
4. Exigir integridad referencial entre los nodos en una Base de Datos distribuida.
5. Hacer cumplir reglas de negocio complejas.
6. Proporcionar un registro de eventos transparente.
7. Proporcionar auditoría.
8. Mantener réplicas síncronas de tablas.
9. Recopilar estadísticas de acceso en tablas.
10. Modificar datos de una tabla cuando se emiten sentencias DML en vistas.
11. Publicar información sobre eventos de Base de Datos, eventos de usuario, y sentencias SQL a aplicaciones suscritas.


## Restricciones Triggers
En principio, dentro del cuerpo de programa del trigger podemos hacer uso de cualquier orden de consulta o manipulación de la BD, 
y llamadas a funciones o procedimientos siempre que:

- No se utilicen comandos DDL
- No se acceda a las tablas que están siendo modificadas con DELETE, INSERT o UPDATE en la misma sesión
- No se violen las reglas de integridad, es decir no se pueden modificar llaves primarias, ni actualizar llaves externas
- No se utilicen sentencias de control de transacciones (Commit, Rollback o Savepoint)
- No se llamen a procedimientos que trasgredan la restricción anterior
- No se llame a procedimientos que utilicen sentencias de control de transacciones


## Predicados condicionales

Cuando se crea un trigger para más de una operación DML, se puede utilizar un predicado condicional en las sentencias 
que componen el trigger que indique que tipo de operación o sentencia ha disparado el trigger. 
Estos predicados condicionales son los siguientes:

```sql
Inserting: Retorna true cuando el trigger ha sido disparado por un INSERT
Deleting: Retorna true cuando el trigger ha sido disparado por un DELETE
Updating: Retorna true cuando el trigger ha sido disparado por un UPDATE
Updating (columna): Retorna true cuando el trigger ha sido disparado por un UPDATE y la columna ha sido modificada.
```
```sql
CREATE TRIGGER audit_trigger BEFORE INSERT OR DELETE OR UPDATE
  ON classified_table FOR EACH ROW
BEGIN
  IF INSERTING THEN
    INSERT INTO audit_table
    VALUES (USER || ' is inserting' ||
    ' new key: ' || :new.key);
  ELSIF DELETING THEN
    INSERT INTO audit_table
    VALUES (USER || ' is deleting' ||
    ' old key: ' || :old.key);
  ELSIF UPDATING('FORMULA') THEN
    INSERT INTO audit_table
    VALUES (USER || ' is updating' ||
    ' old formula: ' || :old.formula ||
    ' new formula: ' || :new.formula);
  ELSIF UPDATING THEN
    INSERT INTO audit_table
    VALUES (USER || ' is updating' ||
    ' old key: ' || :old.key ||
    ' new key: ' || :new.key);
  END IF;
END;
```
## Trigger a nivel de sentencia

A continuación veremos la creación de un disparador para el evento de inserción: "insert trigger".

```sql
 create or replace trigger NOMBREDISPARADOR
  MOMENTO insert
  on NOMBRETABLA
  begin
   CUERPO DEL TRIGGER;
  end NOMBREDISPARADOR;
  /
  ```
Analizamos la sintaxis:

Luego de la instrucción "create trigger" se coloca el nombre del disparador. Si se agrega "or replace" al momento de crearlo y ya 
existe un trigger con el mismo nombre, tal disparador será borrado y vuelto a crear.

"MOMENTO" indica cuando se disparará el trigger en relación al evento, puede se BEFORE (antes) o AFTER (después). 
Se especifica el evento que causa que el trigger se dispare, en este caso "insert", ya que el trigger se activará cada vez que se ejecute la sentencia "insert" sobre la tabla especificada luego de "on".

Es un trigger a nivel de sentencia, es decir, se dispara una sola vez por cada sentencia "insert", aunque la sentencia ingrese varios registros. 
Es el valor por defecto si no se especifica.

Finalmente se coloca el cuerpo del trigger dentro del bloque "begin.. end".

Las siguientes sentencias disparan un trigger de inserción:
```sql
 insert into TABLA values ...;
 insert into TABLA select ... from...;
 ```
### Ejemplo: Creamos un trigger que se dispara cada vez que se ejecuta un "insert" sobre la tabla "videojuegos":

```sql
 create or replace trigger tr_ingresar_videojuegos
  before insert
  on videojuegos
 begin
  insert into Control values(user,sysdate);
 end tr_ingresar_videojuegos;
 /
 ```
Analizamos el trigger anterior:

"create or replace trigger" junto al nombre del disparador que tiene un prefijo "tr" para reconocer que es un trigger, 
referencia el evento que lo disparará y la tabla asociada.

Para identificar fácilmente los disparadores de otros objetos se recomienda usar un prefijo y darles el nombre de la tabla 
para la cual se crean junto al tipo de acción.

El disparador se activará antes ("before") del evento "insert" sobre la tabla "videojuegos", es decir, se disparará ANTES que se realice una inserción en "videojuegos". 
El trigger está definido a nivel de sentencia, se activa una vez por cada instrucción "insert" sobre "videojuegos". 
El cuerpo del disparador se delimita con "begin... end",  allí se especifican las acciones que se realizarán al ocurrir el evento de inserción, en este caso, ingresar en la tabla "control" el nombre del usuario que alteró la tabla "videojuegos" (obtenida mediante la función "user") y la fecha en que lo hizo (mediante la función "sysdate").

## Trigger a nivel de fila

La siguiente es la sintaxis para crear un trigger de inserción a nivel de fila, se dispare una vez por cada fila ingresada sobre la tabla especificada:
```sql
 create or replace trigger NOMBREDISPARADOR
  MOMENTO insert
  on NOMBRETABLA
  for each row
  begin
   CUERPO DEL TRIGGER;
  end NOMBREDISPARADOR;
  /
  ```
Creamos un desencadenador que se dispara una vez por cada registro ingresado en la tabla "ofertas":
```sql
 create or replace trigger tr_ingresar_ofertas
  before insert
  on ofertas
  for each row
 begin
  insert into Control values(user,sysdate);
 end tr_ingresar_ofertas;
 /
 ```
Si al ejecutar un "insert" sobre "ofertas" empleamos la siguiente sentencia:
```sql
 insert into ofertas select titulo,plataforma,precio from videojuegos where precio<30;
 ```
y se ingresan 5 registros en "ofertas", en la tabla "control" se ingresarán 5 registros, uno por cada inserción en "ofertas". 
Si el trigger hubiese sido definido a nivel de sentencia (statement), se agregaría una sola fila en "control".

## :OLD / :NEW
Cuando trabajamos con trigger a nivel de fila, Oracle provee de dos tablas temporales a las cuales se puede acceder, que contienen los antiguos y nuevos valores de los campos del registro afectado por la sentencia que disparó el trigger. 
El nuevo valor es ":new" y el viejo valor es ":old". Para referirnos a ellos debemos especificar su campo separado por un punto ":new.CAMPO" y ":old.CAMPO".

El acceso a estos campos depende del evento del disparador.

En un trigger disparado por un "insert", se puede acceder al campo ":new" unicamente, el campo ":old" contiene "null".

En una inserción se puede emplear ":new" para escribir nuevos valores en las columnas de la tabla.

En un trigger que se dispara con "update", se puede acceder a ambos campos. En una actualizacion, se pueden comparar los valores de ":new" y ":old".

En un trigger de borrado, unicamente se puede acceder al campo "old", ya que el campo ":new" no existe luego que el registro es eliminado, el campo ":new" contiene "null" y no puede ser modificado.

Los valores de "old" y "new" están disponibles en triggers after y before.

El valor de ":new" puede modificarse en un trigger before, es decir, se puede acceder a los nuevos valores antes que se ingresen en la tabla y cambiar los valores asignando a ":new.CAMPO" otro valor.

El valor de ":new" NO puede modificarse en un trigger after, esto es porque el trigger se activa luego que los valores de "new" se almacenaron en la tabla.

El campo ":old" nunca se modifica, sólo puede leerse.

Pueden usarse en una clásula "when" (que veremos posteriormente).

En el cuerpo el trigger, los campos "old" y "new" deben estar precedidos por ":" (dos puntos), pero si está en "when" no.

Veamos un ejemplo.

Creamos un trigger a nivel de fila que se dispara "antes" que se ejecute un "update" sobre el campo "precio" de la tabla "videojuegos". En el cuerpo del disparador se debe ingresar en la tabla "control", el nombre del usuario que realizó la actualización, la fecha, el código del videojuego que ha sido modificado, el precio anterior y el nuevo:

```sql
 create or replace trigger tr_actualizar_precio_videojuegos
 before update of precio
 on videojuegos
 for each row
 begin
  insert into control values(user,sysdate,:new.codigo,:old.precio,:new.precio);
 end tr_actualizar_precio_videojuegos;
 /
 ```
Cuando el trigger se dispare, antes de ingresar los valores a la tabla, almacenará en "control", además del nombre del usuario y la fecha, el precio anterior del videojuego y el nuevo valor.

El siguiente trigger debe controlar el precio que se está actualizando, si supera los 50 euros, se debe redondear tal valor a entero, hacia abajo (empleando "floor"), es decir, se modifica el valor ingresado accediendo a ":new.precio" asignándole otro valor:

```sql
 create or replace trigger tr_actualizar_precio_videojuegos
 before update of precio
 on videojuegos
 for each row
 begin
  if (:new.precio>50) then
   :new.precio:=floor(:new.precio);
  end if;
  insert into control values(user,sysdate,:new.codigo,:old.precio,:new.precio);
 end tr_actualizar_precio_videojuegos;
 /
 ```
Si al actualizar el precio de un videojuego colocamos un valor superior a 50, con decimales, tal valor se redondea al entero más cercano hacia abajo. Por ejemplo, si el nuevo valor es "54.99", se almacenará "54".

Podemos crear un disparador para múltiples eventos, que se dispare al ejecutar "insert", "update" y "delete" sobre "videojuegos". En el cuerpo del trigger se realiza la siguiente acción: se almacena el nombre del usuario, la fecha y los antiguos y viejos valores del campo "precio":

```sql
create or replace trigger tr_videojuegos
 before insert or update or delete
 on videojuegos
 for each row
 begin
  insert into control values(user,sysdate,:old.codigo,:old.precio,:new.precio);
 end tr_videojuegos
 ;
 /
 ````
Si ingresamos un registro, el campo ":old.codigo" y el campo ":old.precio" contendrán "null". Si realizamos una actualización del campo de un campo que no sea "precio", los campos ":old.precio" y ":new.precio" guardarán el mismo valor.

Si eliminamos un registro, el campo ":new.precio" contendrá "null".

Entonces, se puede acceder a los valores de ":new" y ":old" en disparadores a nivel de fila (no en disparadores a nivel de sentencia). Están disponibles en triggers after y before. Los valores de ":old" solamente pueden leerse, nunca modificarse. Los valores de ":new" pueden modificarse únicamente en triggers before (nunca en triggers after).


## CLAUSULA WHEN

En los triggers a nivel de fila, se puede incluir una restricción adicional, agregando la clausula "when" con una condición que se evalúa para cada fila que afecte el disparador; si resulta cierta, se ejecutan las sentencias del trigger para ese registro; si resulta falsa, el trigger no se dispara para ese registro.

Limitaciones de "when":

- no puede contener subconsultas, funciones agregadas ni funciones definidas por el usuario;

- sólo se puede hacer referencia a los parámetros del evento;

- no se puede especificar en los trigers "instead of" ni en trigger a nivel de sentencia.

Creamos el siguiente disparador:
```sql
create or replace trigger tr_precio_videojuegos
 before insert or update of precio
 on videojuegos
 for each row when(new.precio>50)
 begin
  :new.precio := round(:new.precio);
 end tr_precio_videojuegos;
 /
 ```
El disparador anterior se dispara ANTES (before) que se ejecute un "insert" sobre "videojuegos" o un "update" sobre "precio" de "videojuegos". 
Se ejecuta una vez por cada fila afectada (for each row) y solamente si cumple con la condición del "when", es decir, si el nuevo precio que se ingresa o modifica es superior a 50. 
Si el precio es menor o igual a 50, el trigger no se dispara. Si el precio es mayor a 50, se modifica el valor ingresado redondeándolo a entero.

Note que cuando hacemos referencia a "new" (igualmente con "old") en la condición "when", no se colocan los dos puntos precediéndolo; pero en el cuerpo del trigger si.

Si ingresamos un registro con el valor 30.80 para "precio", el trigger no se dispara.

Si ingresamos un registro con el valor "55.6" para "precio", el trigger se dispara modificando tal valor a "56".

Si actualizamos el precio de un libro a "40.30", el trigger no se activa.

Si actualizamos el precio de un libro a "50.30", el trigger se activa y modifica el valor a "50".

Si actualizamos el precio de 2 registros a valores que superen los "50", el trigger se activa 2 veces redondeando los valores a entero.

Si actualizamos en una sola sentencia el precio de 2 registros y solamente uno de ellos supera los "50", el trigger se activa 1 sola vez.

El trigger anterior podría haberse creado de la siguiente manera:

```sql
create or replace trigger tr_precio_videojuegos
 before insert or update of precio
 on videojuegos
 for each row
 begin
  if :new.precio>50 then
   :new.precio := round(:new.precio);
  end if;
 end tr_precio_videojuegos;
 /
 ```
En este caso, la condición se chequea en un "if" dentro del cuerpo del trigger. La diferencia con el primer trigger que contiene "when" es que la condición establecida en el "when" se testea antes que el trigger se dispare y si resulta verdadera, 
se dispara el trigger, sino no. En cambio, si la condición está dentro del cuerpo del disparador, el trigger se dispara y luego se controla el precio, si cumple la condición, se modifica el precio, sino no.

Por ejemplo, la siguiente sentencia:
```sql
 update videojuegos set precio=40 where...;
 ```
no dispara el primer trigger, ya que no cumple con la condición del "when"; pero si dispara el segundo trigger, que no realiza ninguna acción ya que al evaluarse la condición del "if", resulta falsa.
