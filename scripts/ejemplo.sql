# Script de ejemplo
# -----------------
# Para ejecutarlo en el MySQL en el contenedor se puede ejecutar
#   source /scripts/ejemplo.MySQL

use employees;

# lista los primeros 10 empleados
select * from employees limit 10;