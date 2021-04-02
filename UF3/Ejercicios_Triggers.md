Para al comprobación de los ejercicios, el alumno deberá de nutrir la tabla de datos.

Crea la siguiente tabla:

```sql
CREATE TABLE empleados
(dni char(9) PRIMARY KEY,
nomemp varchar2(50),
jefe char(9),
departamento integer,
salario number(9,2) DEFAULT 1000,
usuario varchar2(50),
fecha date,
FOREIGN KEY (jefe) REFERENCES empleados (dni)
);
```
1. Crear un trigger sobre la tabla EMPLEADOS para que no se permita que un empleado sea jefe de más de cinco empleados.
2. Crear un trigger para impedir que se aumente el salario de un empleado en más de un 20%. Es necesario comparar los valores :old.salario y :new.salario cada vez que se modifica el atributo salario (BEFORE UPDATE).
3. Crear una tabla empleados_baja con la siguiente estructura:
```sql
CREATE TABLE empleados_baja (
dni char(9) PRIMARY KEY,
nomemp varchar2(50),
jefe char(9),
departamento integer,
salario number(9,2) DEFAULT 1000,
usuario varchar2(50),
fecha date
);
```
Crear un trigger que inserte una fila en la tabla empleados_baja cuando se borre una fila en la tabla empleados.
Los datos que se insertan son los del empleado que se da de baja en la tabla empleados, salvo en las columnas
usuario y fecha se grabarán las variables del sistema USER y SYSDATE que almacenan el usuario y fecha actual.
4. Crear un trigger para impedir que, al insertar un empleado, el empleado y su jefe puedan pertenecer a departamentos distintos.
5. Crear un trigger para impedir que, al insertar un empleado, la suma de los salarios de los empleados pertenecientes al departamento del empleado insertado supere los 10.000 euros.

6. 
```sql
Visualizar los trigger definidos sobre una tabla consultando la vista ALL-_TRIGGERS.
– DESC ALL-_TRIGGERS
– SELECT trigger_name, status FROM ALL_TRIGGERS WHERE table_name = 'empleados';
Desactivar (DISABLE) y activar (ENABLE) los trigger definidos sobre una tabla:
– ALTER TABLE empleados DISABLE ALL TRIGGERS;
Activar y desactivar un trigger especifico:
– ALTER TRIGGER nombre_trigger DISABLE;
Ver la descripción de un trigger:
– SELECT description FROM USER_TRIGGERS WHERE trigger_name = 'nombre_trigger';
Ver el cuerpo de un trigger:
– SELECT trigger_body FROM USER_TRIGGERS WHERE trigger_name = 'nombre_trigger';
```
