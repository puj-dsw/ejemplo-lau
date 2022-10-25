
use employees;

CREATE OR REPLACE VIEW current_title AS
    SELECT l.emp_no , title, l.from_date, l.to_date
    FROM titles d
        INNER JOIN title_latest_date l
        ON d.emp_no=l.emp_no AND d.from_date=l.from_date AND l.to_date = d.to_date;

CREATE OR REPLACE VIEW current_salary AS
    SELECT l.emp_no, salary, l.from_date, l.to_date
    FROM salaries s
        INNER JOIN salary_latest_date l
        ON s.emp_no=l.emp_no 
        AND s.from_date=l.from_date 
        AND l.to_date = s.to_date ;

#CONSULTA 1

SELECT l.emp_no AS EmployeeNum, l.first_name AS Name, l.last_name AS LastName, title AS Title, from_date AS FromDate, to_date AS ToDate
FROM current_title 
INNER JOIN employees l ON current_title.emp_no=l.emp_no
WHERE first_name="Elvis" and last_name="Demeyer";

#CONSULTA 2
SELECT l.emp_no AS EmployeeNum, l.first_name AS Name, l.last_name AS LastName, salary AS Salary, from_date AS FromDate, to_date AS ToDate
FROM current_salary
INNER JOIN employees l ON current_salary.emp_no=l.emp_no
WHERE  first_name="Elvis" and last_name="Demeyer";

CREATE OR REPLACE VIEW salary_latest_date AS
    SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM salaries
    GROUP BY emp_no;

CREATE OR REPLACE VIEW title_latest_date AS
    SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM titles
    GROUP BY emp_no;

CREATE OR REPLACE VIEW dept_emp_latest_date AS
    SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM dept_emp
    GROUP BY emp_no;

#CONSULTA 3
SELECT l.emp_no, d.title, s.salary, l.from_date, l.to_date, s.from_date, s.to_date
    FROM titles d
        INNER JOIN title_latest_date l
        ON d.emp_no=l.emp_no AND d.from_date=l.from_date AND l.to_date = d.to_date
INNER JOIN current_salary s
ON s.emp_no=l.emp_no AND s.from_date=l.from_date AND l.to_date = s.to_date
limit 10;


#CONSULTA 4
SELECT salary_elvis.*
    FROM (
        SELECT emp.first_name, emp.last_name, sal.salary
            FROM current_salary AS sal
            JOIN employees AS emp
               ON sal.emp_no = emp.emp_no
            WHERE emp.first_name="Elvis" and emp.last_name="Demeyer"
    ) as salary_elvis;

SELECT salary_others.*
    FROM (
        SELECT emp.first_name, emp.last_name, sal.salary
            FROM current_salary AS sal 
            JOIN employees AS emp
               ON sal.emp_no = emp.emp_no 
            WHERE emp.first_name="Elvis" and emp.last_name="Demeyer"
    ) as salary_elvis,
    (
        SELECT emp.first_name, emp.last_name, sal.salary
            FROM current_salary AS sal 
            JOIN employees AS emp
               ON sal.emp_no = emp.emp_no 
    ) as salary_others
    WHERE salary_others.salary > salary_elvis.salary
limit 10;


CREATE OR REPLACE VIEW current_dept_emp AS
    SELECT l.emp_no, d.dept_no, l.from_date, l.to_date
    FROM dept_emp d
     INNER JOIN dept_emp_latest_date l
        ON d.emp_no=l.emp_no AND d.from_date=l.from_date AND l.to_date = d.to_date;

#CONSULTA 5
SELECT dept_elvis.*
    FROM (
        SELECT emp.first_name, emp.last_name, dept.dept_no
            FROM current_dept_emp AS dept
            JOIN employees AS emp
                 ON dept.emp_no = emp.emp_no
            WHERE emp.first_name="Elvis" and emp.last_name="Demeyer"
     as dept_elvis;
     
#CONSULTA 6
SELECT dept_others.*
    FROM (
        SELECT emp.first_name, emp.last_name, dept.dept_no
            FROM current_dept_emp AS dept
            JOIN employees AS emp
               ON dept.emp_no = emp.emp_no
            WHERE emp.first_name="Elvis" and emp.last_name="Demeyer"
    ) as dept_elvis,
     (
        SELECT emp.first_name, emp.last_name, dept.dept_no
            FROM current_dept_emp AS dept
            JOIN employees AS emp
               ON dept.emp_no = emp.emp_no
    ) as dept_others
    WHERE dept_others.dept_no = dept_elvis.dept_no
limit 10;
