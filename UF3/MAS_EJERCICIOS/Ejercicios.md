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

Funcion que a partir de un codigo de departamento como dato de entrada, permita saber cuantos manager de cada departamento aparecen en la tabla job_history.

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
