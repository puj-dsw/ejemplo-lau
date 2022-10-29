DROP VIEW last_salary;
DROP VIEW last_title;
DROP VIEW more_salary;
DROP VIEW same_dept;
-- consulta 1
SELECT emp.emp_no, emp.first_name, emp.last_name, emp.gender, emp.hire_date,
       tit.title, ult_title.from_date, ult_title.to_date
    FROM titles AS tit
        JOIN ( 
	      SELECT *
                            FROM employees AS emp
	       WHERE 
	             emp.first_name = 'Elvis' and
	             emp.last_name = 'Demeyer'
              ) AS emp ON tit.emp_no = emp.emp_no
        JOIN (
                  SELECT emp_no, 
                                  max(from_date) AS from_date, 
                                  max(to_date) AS to_date
                            FROM titles
	      GROUP BY emp_no
          ) AS ult_title ON ult_title.emp_no = emp.emp_no
;

-- Consulta 2
SELECT ult.emp_no,
                emp.first_name, emp.last_name, emp.gender, emp.hire_date,
                sal.salary, ult.from_date, ult.to_date
         FROM employees AS emp 
	    JOIN (
                          SELECT emp_no, 
                                          max(from_date) AS from_date, 
                                          max(to_date) AS to_date
                                    FROM salaries
		 GROUP BY emp_no
                          ) AS ult ON ult.emp_no = emp.emp_no
               JOIN salaries AS sal ON emp.emp_no = sal.emp_no AND ult.from_date = sal.from_date
WHERE 
	emp.first_name = 'Elvis' and
	emp.last_name = 'Demeyer'
;

-- Crear vistas de las querys anteriores, 1 y 2
-- Ultimo cargo

CREATE OR REPLACE VIEW last_title AS 
SELECT tit.emp_no, emp.first_name, emp.last_name, emp.gender, emp.hire_date,
                tit.title, ult_title.from_date, ult_title.to_date
          FROM titles AS tit
	    JOIN (
                          SELECT emp_no, 
                                          max(from_date) AS from_date, 
                                          max(to_date) AS to_date
                                    FROM titles
		   GROUP BY emp_no
                         ) AS ult_title ON ult_title.emp_no = tit.emp_no
	     JOIN ( 
	               SELECT *
                                    FROM employees as emp
                           ) AS emp ON tit.emp_no = emp.emp_no
;

-- Ultimo salario
CREATE OR REPLACE VIEW last_salary AS
SELECT ult.emp_no,
                emp.first_name, emp.last_name, emp.gender, emp.hire_date,
                sal.salary, ult.from_date, ult.to_date
          FROM employees as emp 
	      JOIN (
                           SELECT emp_no, 
                                           max(from_date) as from_date, 
                                           max(to_date) as to_date
                                     FROM salaries
		   GROUP BY emp_no
          ) AS ult ON ult.emp_no = emp.emp_no
                  JOIN salaries AS sal ON emp.emp_no = sal.emp_no and ult.from_date = sal.from_date
;

-- Consulta 3
SELECT tit.emp_no, tit.first_name, tit.last_name, tit.gender,
                tit.title, sal.salary, tit.hire_date, tit.from_date, tit.to_date
          FROM last_salary as sal
                 JOIN last_title AS tit ON sal.emp_no = tit.emp_no
;

-- Consulta 4
SELECT salary_others.*
    FROM (
        SELECT sal.first_name, sal.last_name, sal.salary
            FROM last_salary AS sal 
            WHERE sal.first_name="Elvis" AND sal.last_name="Demeyer"
    ) AS salary_elvis,
    (
        SELECT sal.first_name, sal.last_name, sal.salary
            FROM last_salary AS sal 
    ) AS salary_others
    WHERE salary_others.salary > salary_elvis.salary
LIMIT 10
;

-- Consulta 5
SELECT dept.dept_no, dept.dept_name,
                emp.emp_no, emp.first_name, emp.last_name, emp.gender, emp.hire_date,
                ult_trabajo.from_date, ult_trabajo.to_date
          FROM departments AS dept
                 JOIN dept_emp ON dept.dept_no = dept_emp.dept_no
                 JOIN ( 
                         SELECT *
                                   FROM employees as emp
	             WHERE 
	                            emp.first_name = 'Elvis' and
	                            emp.last_name = 'Demeyer'
                            ) AS emp ON dept_emp.emp_no = emp.emp_no
                   JOIN (
                          SELECT emp_no, 
                                          max(from_date) AS from_date,
                                          max(to_date) AS to_date
			FROM dept_emp
                          GROUP BY emp_no
                    ) AS ult_trabajo ON dept_emp.emp_no = ult_trabajo.emp_no
 ;

-- Consulta 6
SELECT dept_others.*
    FROM (
        SELECT emp.first_name, emp.last_name, dept.dept_no
            FROM current_dept_emp AS dept
            JOIN employees AS emp
               ON dept.emp_no = emp.emp_no
            WHERE emp.first_name="Elvis" AND emp.last_name="Demeyer"
    ) AS dept_elvis,
     (
        SELECT emp.first_name, emp.last_name, dept.dept_no
            FROM current_dept_emp AS dept
            JOIN employees AS emp
               ON dept.emp_no = emp.emp_no
    ) AS dept_others
WHERE dept_others.dept_no = dept_elvis.dept_no
LIMIT 10
;

-- Consulta 7
-- Crear vistas de las consultas 4 y 6
CREATE OR REPLACE VIEW more_salary AS
SELECT salary_others.*
    FROM (
        SELECT sal.emp_no, sal.first_name, sal.last_name, sal.salary
            FROM last_salary AS sal 
		WHERE sal.first_name="Elvis" AND sal.last_name="Demeyer"
    ) AS salary_elvis,
    (
        SELECT sal.emp_no, sal.first_name, sal.last_name, sal.salary
            FROM last_salary AS sal 
    ) AS salary_others
WHERE salary_others.salary > salary_elvis.salary
;

CREATE OR REPLACE VIEW same_dept AS
SELECT dept_others.*
    FROM (
        SELECT emp.emp_no, emp.first_name, emp.last_name, dept.dept_no
            FROM current_dept_emp AS dept
            JOIN employees AS emp
               ON dept.emp_no = emp.emp_no
            WHERE emp.first_name="Elvis" AND emp.last_name="Demeyer"
    ) AS dept_elvis,
     (
        SELECT emp.emp_no, emp.first_name, emp.last_name, dept.dept_no
            FROM current_dept_emp AS dept
            JOIN employees AS emp
                ON dept.emp_no = emp.emp_no
    ) AS dept_others
WHERE dept_others.dept_no = dept_elvis.dept_no
;

-- Consulta 7
SELECT sd.emp_no, sd.first_name, sd.last_name, sd.dept_no, ms.salary
    FROM same_dept_tb AS sd  JOIN more_salary_tb AS ms ON sd.emp_no = ms.emp_no
;
