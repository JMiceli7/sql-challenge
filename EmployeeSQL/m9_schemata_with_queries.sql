-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR(25)   NOT NULL,
    "dept_name" VARCHAR(75)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(25)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(25)   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(50)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(75)   NOT NULL,
    "last_name" VARCHAR(75)   NOT NULL,
    "sex" VARCHAR(5)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(25)   NOT NULL,
    "title" VARCHAR(75)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");




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