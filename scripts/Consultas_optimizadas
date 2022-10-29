-- Consulta 1
SELECT *
    FROM last_title_tb
WHERE first_name="Elvis" and last_name="Demeyer";

-- Consulta 2
SELECT *
    FROM last_salary_tb
WHERE first_name="Elvis" and last_name="Demeyer";

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
            FROM last_salary_tb AS sal 
            WHERE sal.first_name="Elvis" AND sal.last_name="Demeyer"
    ) AS salary_elvis,
    (
        SELECT sal.first_name, sal.last_name, sal.salary
            FROM last_salary_tb AS sal 
    ) AS salary_others
    WHERE salary_others.salary > salary_elvis.salary
LIMIT 10
;

-- Consulta 5
SELECT dept.dept_no, dept.dept_name,
	   emp.emp_no, emp.first_name, emp.last_name, emp.gender, emp.hire_date,
	   current_dept_emp_tb.from_date, current_dept_emp_tb.to_date
          FROM departments AS dept
                 JOIN dept_emp ON dept.dept_no = dept_emp.dept_no
                 JOIN employees AS emp ON dept_emp.emp_no = emp.emp_no
				 JOIN current_dept_emp_tb ON dept_emp.emp_no = current_dept_emp_tb.emp_no
WHERE
     emp.first_name = 'Elvis'
     AND emp.last_name = 'DEMEYER'
 ;
 
 -- Consulta 6
 -- Consulta 6
SELECT dept_others.*
    FROM (
        SELECT emp.first_name, emp.last_name, dept.dept_no
            FROM current_dept_emp_tb AS dept
            JOIN employees AS emp
               ON dept.emp_no = emp.emp_no
            WHERE emp.first_name="Elvis" AND emp.last_name="Demeyer"
    ) AS dept_elvis,
     (
        SELECT emp.first_name, emp.last_name, dept.dept_no
            FROM current_dept_emp_tb AS dept
            JOIN employees AS emp
               ON dept.emp_no = emp.emp_no
    ) AS dept_others
WHERE dept_others.dept_no = dept_elvis.dept_no
LIMIT 10
;

-- Consulta 7
SELECT sd.emp_no, sd.first_name, sd.last_name, sd.dept_no, ms.salary
    FROM same_dept_tb AS sd  JOIN more_salary_tb AS ms ON sd.emp_no = ms.emp_no
;
