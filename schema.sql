-----------------------------------
-- Create PH-EmployeesDB Tables
-----------------------------------

-- Create Department's table
create table Departments (
	dept_no varchar(4) not null,
	dept_name varchar(40) not null,
	primary key (dept_no),
	unique (dept_name)
);

-- Create Empoyees' table
create table Employees (
	emp_no int not null,
	birth_date date not null,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	gender varchar(1) not null,
	hire_date date not null,
	primary key (emp_no)
);

-- Create Salary's table
create table Salaries (
	emp_no int not null,
	salary int not null,
	from_date date not null,
	to_date date not null,
	foreign key (emp_no) references employees (emp_no),
	primary key (emp_no)
);

-- Create Managers' table
create table Managers (
	dept_no varchar not null,
	emp_no int not null,
	from_date date not null,
	to_date date not null,
	foreign key (dept_no) references departments (dept_no),
	foreign key (emp_no) references employees (emp_no),
	primary key (dept_no, emp_no)
);

-- Create Departments and Employees table
create table Dept_Emp (
	emp_no int not null,
	dept_no varchar not null,
	from_date date not null,
	to_date date not null,
	foreign key (dept_no) references departments (dept_no),
	foreign key (emp_no) references employees (emp_no),
	primary key (dept_no, emp_no)	
);

-- Create Titles table
create table Titles (
	emp_no int not null,
	title varchar(50) not null,
	from_date date not null,
	to_date date not null,
	foreign key (emp_no) references employees (emp_no)
);
