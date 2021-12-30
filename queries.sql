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
select first_name, last_name 
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
	and (hire_date between '1985-01-01' and '1988-12-31');