-- Deliverable #1
SELECT 
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees e
INNER JOIN titles t ON t.emp_no = e.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Now we should use DISTINCT to obtain just the first occurrence based on emp_no
-- Also we should filter titles.to_date = '9999-01-01' so the ones tha
SELECT DISTINCT ON (rt.emp_no)
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	t.title
INTO unique_titles
FROM retirement_titles rt
INNER JOIN titles t ON t.emp_no = rt.emp_no
WHERE t.to_date = '9999-01-01'
ORDER BY rt.emp_no, t.from_date DESC;

-- Check unique_titles table
SELECT * FROM unique_titles;

-- Get the total number of titles from the unique_titles table
SELECT COUNT(title), title 
INTO retiring_titles
FROM unique_titles 
GROUP BY title 
ORDER BY 1 DESC;

-- Deliverable #2
-- Create the mentorship_eligibility table
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN titles t ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, t.from_date DESC;


-- Queries for the analysis
-- Current total number of employees
SELECT COUNT(emp_no) FROM employees

-- Current total number of employees about to retire
SELECT count(e.emp_no) FROM employees e WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'

-- Count employees ready to enter a mentorship program
SELECT COUNT(e.emp_no)
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
	
-- Get Retiring employees by Department
SELECT DISTINCT ON (rt.emp_no)
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	de.dept_name
INTO unique_department
FROM retirement_titles rt
INNER JOIN dept_emp d ON d.emp_no = rt.emp_no
LEFT JOIN departments de ON de.dept_no = d.dept_no
WHERE d.to_date = '9999-01-01'
ORDER BY rt.emp_no, d.from_date DESC


-- Get the total number of employees by department from the newly created unique_department table
SELECT COUNT(dept_name), dept_name
FROM unique_department 
GROUP BY dept_name 
ORDER BY 1 DESC;