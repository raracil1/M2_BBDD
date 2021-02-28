# PROCEDIMIENTOS

A la hora de guardar un bloque de código hay que tener en cuenta ciertas normas:

- La palabra reservada DECLARE desaparece.
- Podremos crear procedimientos y funciones. Los procedimientos no podrán retornar ningún valor sobre su nombre, 
mientras que las funciones deben retornar un valor de un tipo de dato básico.

Un procedimiento tiene un nombre, un conjunto de parámetros (opcional) y un bloque de código. 
Una vez se crean los procedimientos, estos pasan a formar parte de la definicion de base de datos y se pueden volver 
a utiizar tantas veces como se quiera.
Su sintaxis es la siguiente:
```sql
CREATE {OR REPLACE} PROCEDURE nombre_proc( param1 [IN | OUT | IN OUT] tipo,... )
IS | AS
  -- Declaración de variables locales
  BEGIN
  -- Instrucciones de ejecución
  [EXCEPTION]
  -- Instrucciones de excepción
END;
```
Como podemos ver, los parametros pueden ser de entrada, se salida, o de ambos tipos, de esta manera, podemos tener o datos de entrada
para especificar los valores para lanzar el pcocedimiento, o datos de salida, que se sobreescribirán con los nuevos valores.

Ejemplo:

```sql
CREATE OR DECLARE PROCEDURE INTERCAMBIO (A IN OUT NUMBER, B IN OUT NUMBER) AS
AUX NUMBER;
BEGIN
  AUX := A;
  A := B;
  B := AUX;
  END;
  /
```
A continuacion creamos un programa rápido para ejecutar nuestro procedimiento:
```sql
DECLARE
N1 NUMBER := 3;
N2 NUMBER := 6;
BEGIN
  DBMS_OUTPUT.PUT_LINE('N1: '||N1||' N2: ' ||N2);
  INTERCAMBIO(N1,N2);
  DBMS_OUTPUT.PUT_LINE('N1: '||N1||' N2: ' ||N2);
END;
/
```

### EJERCICIOS
1.  Diseña un procedimiento llamado listarNumeros que pasemos como parametro un entero, y el procedimiento escriba los números
desde el 0 al número que has pasado como parámetro.
2.  Diseña un procedimiento llamado DividirNumero que pasemos como parametros d entrada: el dividendo y el divisor, y como parametros de salida:
cociente y resto. Usa este procedimiento en un programa en el que se divida 18 entre 4, y que muestre por pantalla el dividendo, el dividor,
el cociente y el resto.

# FUNCIONES

La diferencia entre una función y un procedimiento, es que la función va a devolver valores, va adisponer de un RETURN ( como mínimo ).

```sql
CREATE {OR REPLACE} FUNCTION nombre_func(param1 tipo,param2 tipo,... ) RETURN tipo_dato IS
  -- Declaración de variables locales
BEGIN
  -- Instrucciones de ejecución
[EXCEPTION]
  -- Instrucciones de excepción
END;
```
Ejemplo:
```sql
CREATE OR REPLACE FUNCTION SUMANUMEROS( A IN NUMBER) RETURN NUMBER
AS
SUMA NUMBER := 0;
BEGIN
  FOR I IN 1..A LOOP
    SUMA := SUMA + I;
  END LOOP;
  RETURN (SUMA);
END;
/
```

### EJERCICIOS
1.  Diseña una función que se pasen como parámetros dos números enteros y nos devuelva el mayor de los dos.
2.  Diseña una función a la que se le pasen como parámetros dos números enteros y nos devuelva verdadero si el primero es multiplo del segundo, 
o falso en caso contrario. La función MOD (a;b) te ayudará ya que devuelve el resto de dividir a entre b.

## Como llamar a procedimientos a funciones.

Como hemos visto antes, podemos llamar a los procedimientos o funciones mediante perogramas ( bloques de codigo )
```sql
DECLARE
RESULTADO INT;
PROCEDIMIENTO1(100,2);
RESULTADO:=FUNCION1(245);
END;
/
```
O invocando los procedimientos mediante CALL o EXEC;
```sql
CALL PROCEDIMIENTO1(100,2);
EXEC PROCEDIMIENTO1(100,2);
```
Y las funciones si no queremos almacenarlas en niguna variable, tendremos que meterlas por ejemplo en la función de imprimir:
```sql
CALL DBMS_OUTPUT-PUT_LINE(SUMANUMEROS(10));
```



# MÁS EJERCICIOS

1.  Programar un script que nos muestre los números entre un rango. El rango mínimo es 1 y el máximo se lo tiene que
preguntar al usuario. Programar el script utilizando la estructura FOR o la estructura WHILE.
Este ejercicio se tiene que programar con un procedimiento, de tal manera que muestre los números entre
un rango en este procedimiento.
Ayuda:
- Se tiene que programar dentro del script un procedimiento que dado el rango mínimo a 1 y el máximo que
se le pasa como parámetro al procedimiento, imprima por pantalla los números que hay entre
el rango mínimo y el máximo. El procedimiento recibirá el nombre de RANGO.
- Además, al mismo script (EA121_exercici1.sql) se tiene que programar un bloque principal, que
tiene que contener los siguientes aspectos. 
Al mismo script se tiene que realizar lo siguiente:
  preguntar al usuario por el rango máximo.
  comprobar que el rango máximo no es negativo. Si es negativo dar el mensaje correspondiente y acabar el programa.
  llamar al procedimiento RANGO, pasando como parámetro el rango máximo introducido por teclado.
  
2.  Programar un script (EA121_exercici2.sql) que contenga una función que duplique la cantidad
recibida como parámetro. La función recibirá el nombre de DUPLICAR_CANTIDAD. Al mismo script se tiene que
programa un bloque principal que pida por teclado la cantidad y que llame a la función que se acaba de programar,
pasando el parámetro correspondiente.

#### SOBRE LA BASE DE DATOS HR

3.  Programar un script (exercici3.sql) que contenga un procedimiento que dé de alta un
nuevo oficio (puesto de trabajo). Los datos del nuevo oficio se tienen que introducir por teclado. Antes de insertar se tiene que comprobar que el
valor mínimo y máximo del oficio no sea negativo y además, que el salario mínimo sea más pequeño que el máximo.

4.  Programar un script (exercici4.sql) un procedimiento que dé de baja un oficio. El código
del oficio se tiene que introducir por teclado.

5.  Programar un script (exercici5.sql) que contenga una función que devuelva cuántos empleados hay de un departamento, que se pasará por parámetro a la función. La función llamada CONTAR, se llamará desde un bloque anónimo o principal y el parámetro que se le pasa a la función se le preguntará al usuario y por tanto, se tiene que introducir por teclado.
