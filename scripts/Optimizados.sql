-- Borrar índices
DROP INDEX employees_idx_names on employees;
DROP INDEX employees_idx_names on last_title_tb;
DROP INDEX employees_idx_names on last_salary_tb;
-- Borrar vistas materializadas
DROP TABLE last_salary_tb;
DROP TABLE last_title_tb;
DROP TABLE same_dept_tb;
DROP TABLE more_salary_tb;
DROP TABLE current_dept_emp_tb;

-- Materializar vistas 
-- Crear tabla last_salary
CREATE TABLE last_salary_tb
( 
   emp_no INT(11) PRIMARY KEY,
   first_name VARCHAR(14),
   last_name VARCHAR(16),
   gender ENUM ('M','F'), 
   hire_date DATE, 
   salary INT,
   from_date DATE,
   to_date DATE
);
-- Inserción de datos
INSERT INTO last_salary_tb
SELECT * FROM last_salary;

-- Procedure
/*CREATE PROCEDURE last_salary_tb_refresh ( 
    OUT result INT
)

BEGIN
     -- borrar la tabla
     truncate last_salary_tb ;
   
     -- insertar los datos de la vista
     INSERT INTO last_salary_tb
          SELECT * FROM last_salary ;
       
	 SET result = 0;
END;
$$$

DELIMITER ;

CALL last_salary_tb_refresh(@result);*/

-- Vista materializada de el último carggo de los empleados
CREATE TABLE last_title_tb
( 
   emp_no INT(11),
   first_name VARCHAR(14),
   last_name VARCHAR(16),
   gender ENUM ('M','F'), 
   hire_date DATE, 
   title VARCHAR(50),
   from_date DATE,
   to_date DATE
);
-- Inserción de datos
INSERT INTO last_title_tb
SELECT * FROM last_title;
-- Procedure
/*CREATE PROCEDURE last_title_tb_refresh ( 
    OUT result INT
)

BEGIN
     -- borrar la tabla
     truncate last_title_tb ;
   
     -- insertar los datos de la vista
     INSERT INTO last_title_tb
          SELECT * FROM last_title ;
       
	 SET result = 0;
END;
$$$

DELIMITER ;

CALL last_salary_tb_refresh(@result);*/

-- View materializada de personas que pertenecen a el mismo departamento de x persona 
CREATE TABLE same_dept_tb
( 
   emp_no INT(11) PRIMARY KEY,
   first_name VARCHAR(14),
   last_name VARCHAR(16),
   dept_no CHAR(4)
);
-- Inserción de datos
INSERT INTO same_dept_tb
SELECT * FROM same_dept;
-- Procedure
/*CREATE PROCEDURE same_dept_tb_refresh ( 
    OUT result INT
)

BEGIN
     -- borrar la tabla
     truncate same_dept_tb ;
   
     -- insertar los datos de la vista
     INSERT INTO same_dept_tb
          SELECT * FROM same_dept ;
       
	 SET result = 0;
END;
$$$

DELIMITER ;

CALL last_salary_tb_refresh(@result);*/
-- Vista materializada de personas que ganarón más que x persona
CREATE TABLE more_salary_tb
( 
   emp_no INT(11) PRIMARY KEY,
   first_name VARCHAR(14),
   last_name VARCHAR(16),
   salary INT
);
-- Inserción de datos
INSERT INTO more_salary_tb
SELECT * FROM more_salary;
-- Procedure
/*CREATE PROCEDURE more_salary_tb_refresh ( 
    OUT result INT
)

BEGIN
     -- borrar la tabla
     truncate more_salary_tb ;
   
     -- insertar los datos de la vista
     INSERT INTO more_salary_tb
          SELECT * FROM more_salary ;
       
	 SET result = 0;
END;
$$$

DELIMITER ;

CALL last_salary_tb_refresh(@result);*/
-- Vista materializada de último departamento por persona
CREATE TABLE current_dept_emp_tb
( 
   emp_no INT(11) PRIMARY KEY,
   dept_no CHAR (4),
   from_date date,
   to_date date
);
-- Insertar datos
INSERT INTO current_dept_emp_tb
SELECT * FROM current_dept_emp;
-- Procedure
/*CREATE PROCEDURE current_dept_emp_tb_refresh ( 
    OUT result INT
)

BEGIN
     -- borrar la tabla
     truncate current_dept_emp_tb ;
   
     -- insertar los datos de la vista
     INSERT INTO current_dept_emp_tb
          SELECT * FROM current_dept_emp ;
       
	 SET result = 0;
END;
$$$

DELIMITER ;

CALL last_salary_tb_refresh(@result);*/
-- Creación de índices
CREATE INDEX employees_idx_names ON employees(first_name, last_name);
CREATE INDEX employees_idx_names ON last_title_tb (first_name, last_name);
CREATE INDEX employees_idx_names ON last_salary_tb (first_name, last_name);
