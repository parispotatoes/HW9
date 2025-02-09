-- Query to see everything in any given table when needed.
SELECT * FROM departments
SELECT * FROM dept_emp
SELECT * FROM dept_manager
SELECT * FROM employees
SELECT * FROM salaries
SELECT * FROM titles

-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT 
	e.emp_no, 
	e.last_name, 
	e.first_name, 
	e.sex, 
	s.salary 
FROM employees e
	JOIN salaries s ON e.emp_no = s.emp_no
ORDER BY
	e.last_name,
	s.salary DESC;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
-- "EXTRACT" syntax obtained with the help of chatGPT.
SELECT
    e.first_name,
    e.last_name,
    EXTRACT(YEAR FROM e.hire_date) AS hire_year
FROM employees e
WHERE EXTRACT(YEAR FROM e.hire_date) = 1986; 

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
-- assistance from chatGPT with how to structure the query with 3 tables and debugging
SELECT 
	d.dept_no,
	d.dept_name,
	e.emp_no,
	e.last_name,
	e.first_name
FROM
	employees e
INNER JOIN dept_manager dm ON e.emp_no=dm.emp_no
INNER JOIN departments d ON dm.dept_no=d.dept_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
-- debugged with the help of chatGPT; had an issue with the ordering of the joins
SELECT
    d.dept_no,
    d.dept_name,
    e.emp_no,
    e.last_name,
    e.first_name
FROM
    employees e
INNER JOIN dept_emp de ON de.emp_no = e.emp_no
INNER JOIN departments d ON d.dept_no = de.dept_no;
	
-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT
	first_name,
	last_name,
	sex
FROM
	employees e
WHERE
	first_name = 'Hercules'
AND
	last_name LIKE 'B%'

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM employees e
INNER JOIN dept_emp de ON de.emp_no = e.emp_no
INNER JOIN departments d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales'

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name
FROM employees e
INNER JOIN dept_emp de ON de.emp_no = e.emp_no
INNER JOIN departments d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT
	last_name,
	COUNT(last_name) AS "Last Name Frequency"
FROM
	employees
GROUP BY last_name
ORDER BY "Last Name Frequency" DESC;
