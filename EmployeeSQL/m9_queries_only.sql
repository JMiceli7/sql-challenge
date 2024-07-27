
-- List employee number, last name, first name, sex, and salary
SELECT *
FROM employees

SELECT *
FROM salaries

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;



-- List the first name, last name, and hire date for the employees 
-- who were hired in 1986

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date ASC;



-- List the manager of each department along with their department number, 
-- department name, employee number, last name, and first name.

SELECT *
FROM dept_manager

SELECT *
FROM employees

SELECT *
FROM departments

SELECT d.dept_no, d2.dept_name, d.emp_no, e.last_name, e.first_name
FROM dept_manager d
JOIN employees e ON d.emp_no = e.emp_no
JOIN departments d2 ON d.dept_no = d2.dept_no;



-- List the department number for each employee along with that employee’s 
-- employee number, last name, first name, and department name

SELECT *
FROM dept_emp

SELECT *
FROM departments
	
SELECT *
FROM employees

SELECT d.dept_no, e.emp_no, e.last_name, e.first_name, d2.dept_name
FROM dept_emp d
JOIN employees e ON e.emp_no = d.emp_no
JOIN departments d2 ON d.dept_no = d2.dept_no;



-- List first name, last name, and sex of each employee whose first name 
-- is Hercules and whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';



-- List each employee in the Sales department, including their employee number, 
-- last name, and first name.

SELECT *
FROM employees

SELECT *
FROM departments

SELECT *
FROM dept_emp

SELECT d2.dept_name, e.emp_no, e.last_name, e.first_name
FROM dept_emp d
JOIN employees e ON e.emp_no = d.emp_no
JOIN departments d2 ON d.dept_no = d2.dept_no
WHERE d2.dept_name = 'Sales'



-- List each employee in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name

SELECT d2.dept_name, e.emp_no, e.last_name, e.first_name
FROM dept_emp d
JOIN employees e ON e.emp_no = d.emp_no
JOIN departments d2 ON d.dept_no = d2.dept_no
WHERE d2.dept_name IN ('Sales', 'Development')
ORDER BY CASE d2.dept_name
    WHEN 'Development' THEN 0
    WHEN 'Sales' THEN 1
END, d2.dept_name, e.last_name, e.first_name;



-- List the frequency counts, in descending order, of all the 
-- employee last names (that is, how many employees share each last name)

SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;

SELECT *
FROM titles