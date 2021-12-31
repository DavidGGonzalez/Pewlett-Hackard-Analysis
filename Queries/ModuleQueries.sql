select * from departments;
select * from dept_emp;
select * from employees;
select * from managers;
select * from salaries;
select * from titles;

select title, count(emp_no) as "Total" from titles group by title;

-- Eligible for retirement, born between 1952 and 1955
select first_name, last_name 
from employees
where birth_date between '1952-01-01' and '1955-12-31';

-- 1952
select first_name, last_name 
from employees
where birth_date between '1952-01-01' and '1952-12-31';

-- 1953
select first_name, last_name 
from employees
where birth_date between '1953-01-01' and '1953-12-31';

-- 1954
select first_name, last_name 
from employees
where birth_date between '1954-01-01' and '1954-12-31';

-- 1955
select first_name, last_name 
from employees
where birth_date between '1955-01-01' and '1955-12-31';

-- Eligible for retirement, born between 1952 and 1955
-- Now use hiring date as a filter too
select first_name, last_name 
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
	and (hire_date between '1985-01-01' and '1988-12-31');
	
-- Count: Now use hiring date as a filter too
select count(first_name)
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
	and (hire_date between '1985-01-01' and '1988-12-31');
	
-- Create a new table to export it in CSV format
-- Now use hiring date as a filter too
select emp_no,first_name, last_name 
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
	and (hire_date between '1985-01-01' and '1988-12-31');
	
	
-- Join tables
select first_name, last_name, title
from employees as e
--left join titles as t on t.emp_no = e.emp_no;
left join titles as t on e.emp_no = t.emp_no;

-- drop retirement_info and re-create it including emp_no
drop table retirement_info



-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     managers.emp_no,
     managers.from_date,
     managers.to_date
FROM departments
INNER JOIN managers
ON departments.dept_no = managers.dept_no;


-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Create a new table
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

select * from current_emp

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
into count_bydept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;