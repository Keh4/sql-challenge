
CREATE TABLE "Departments" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_Employees" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(255)   NOT NULL
);

CREATE TABLE "Dept_Managers" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "Employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(255)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(255)   NOT NULL,
    "last_name" VARCHAR(255)   NOT NULL,
    "sex" VARCHAR(10)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "Titles" (
    "title_id" VARCHAR(255)   NOT NULL,
    "title" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "Dept_Employees" ADD CONSTRAINT "fk_Dept_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_Employees" ADD CONSTRAINT "fk_Dept_Employees_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Managers" ADD CONSTRAINT "fk_Dept_Managers_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_Managers" ADD CONSTRAINT "fk_Dept_Managers_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

--1. List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Employees".sex, "Salaries".salary
FROM "Salaries"
INNER JOIN "Employees" ON 
"Employees".emp_no="Salaries".emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.

Select first_name, last_name, hire_date
From "Employees"
Where hire_date between '19860101'and '19870101'

--3.  List the manager of each department with the following information: 
--		department number, department name, the manager's employee number, last name, first name.

Select "Departments".dept_no, "Departments".dept_name, "Dept_Managers".emp_no, "Employees".last_name, "Employees".first_name
From "Employees"
Inner Join "Dept_Managers" ON
"Dept_Managers".emp_no = "Employees".emp_no
Inner Join "Departments" ON
"Departments".dept_no = "Dept_Managers".dept_no;

--4.  List the department of each employee with the following information: 
--		employee number, last name, first name, and department name.

Select "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
From "Employees"
Inner Join "Dept_Employees" ON
"Dept_Employees".emp_no = "Employees".emp_no
Inner Join "Departments" ON
"Departments".dept_no = "Dept_Employees".dept_no;

--5.List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

Select first_name, last_name, sex
From "Employees"
Where 
	first_name = 'Hercules' 
	and last_name like 'B%';


--6. List all employees in the Sales department, 
--		including their employee number, last name, first name, and department name.

Select "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
From "Employees"
Inner Join "Dept_Employees" ON
"Dept_Employees".emp_no = "Employees".emp_no
Inner Join "Departments" ON
"Departments".dept_no = "Dept_Employees".dept_no
Where "Departments".dept_name = 'Sales';


--7. List all employees in the Sales and Development departments, 
--		including their employee number, last name, first name, and department name.
Select "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
From "Employees"
Inner Join "Dept_Employees" ON
"Dept_Employees".emp_no = "Employees".emp_no
Inner Join "Departments" ON
"Departments".dept_no = "Dept_Employees".dept_no
Where "Departments".dept_name = 'Sales' OR "Departments".dept_name = 'Development';

--8.In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.

Select last_name, COUNT(last_name) AS "Employee Last Name Count"
From "Employees"
Group By last_name
Order by "Employee Last Name Count" DESC;

