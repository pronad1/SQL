SELECT * FROM "classroom";
SELECT * FROM "course";
SELECT * FROM "department";
SELECT * FROM "instructor";
SELECT * FROM "prereq";
SELECT name FROM instructor WHERE dept_name='Comp.Sci.' AND salary > 70000;
SELECT name FROM instructor WHERE dept_name='Comp.Sci.' AND salary > 70000;
SELECT name FROM instructor WHERE dept_name='Comp.Sci.' AND salary > 70000;
SELECT name FROM instructor;
SELECT name, instructor.dept_name, building 
FROM instructor 
JOIN department ON instructor.dept_name = department.dept_name;
SELECT name, course_id 
FROM instructor 
JOIN teaches ON instructor.ID = teaches.ID;
SELECT name, course_id 
FROM instructor 
JOIN teaches ON instructor.ID = teaches.ID 
WHERE instructor.dept_name = 'Comp.Sci.';
SELECT * FROM "instructor";
SELECT name, course_id 
FROM instructor 
JOIN teaches ON instructor.ID = teaches.ID;
SELECT * FROM "teaches";
SELECT t.name, s.course_id 
FROM instructor t 
JOIN teaches s ON t.ID = s.ID;
SELECT name, course_id 
FROM instructor 
JOIN teaches ON instructor.ID = teaches.ID 
WHERE instructor.dept_name = 'Comp.Sci.';
SELECT course_id 
FROM section 
WHERE semester = 'Fall' AND year = 2017;
SELECT course_id 
FROM section 
WHERE semester = 'Spring' AND year = 2018;
SELECT course_id 
FROM section 
WHERE semester = 'Spring' AND year = 2008;
SELECT course_id 
FROM section 
WHERE semester = 'Fall' AND year = 2007
UNION 
SELECT course_id 
FROM section 
WHERE semester = 'Spring' AND year = 2008;
SELECT name 
FROM instructor 
WHERE salary IS NULL;
SELECT name 
FROM instructor 
WHERE salary > 10000 IS UNKNOWN;
SELECT avg(salary) 
FROM instructor 
WHERE dept_name = 'Comp.Sci.';
SELECT COUNT(DISTINCT ID) 
FROM teaches 
WHERE semester = 'Spring' AND year = 2018;
SELECT dept_name, AVG(salary) AS avg_salary 
FROM instructor 
GROUP BY dept_name;
SELECT dept_name, AVG(salary) AS avg_salary 
FROM instructor 
GROUP BY dept_name 
HAVING AVG(salary) > 42000;
SELECT course_id 
FROM course 
WHERE course_id NOT IN (SELECT course_id FROM section WHERE year = 2007);
SELECT * FROM "job_listing";
SELECT count(*) 
FROM course;
SELECT * FROM "section";
SELECT dept_name, avg_salary 
FROM (SELECT dept_name, AVG(salary) AS avg_salary FROM instructor GROUP BY dept_name) a 
WHERE avg_salary > 42000;
SELECT name 
FROM instructor 
WHERE salary > ALL (SELECT salary FROM instructor WHERE dept_name = 'Biology');
WITH max_budget(value) AS (SELECT MAX(budget) FROM department) 
SELECT department.dept_name 
FROM department, max_budget 
WHERE department.budget = max_budget.value;
WITH dept_total(dept_name, value) AS (SELECT dept_name, SUM(salary) FROM instructor GROUP BY dept_name), 
dept_total_avg(value) AS (SELECT AVG(value) FROM dept_total) 
SELECT dept_name 
FROM dept_total, dept_total_avg 
WHERE dept_total.value > dept_total_avg.value;
SELECT dept_name, 
(SELECT COUNT(*) FROM instructor WHERE department.dept_name = instructor.dept_name) AS num_in 
FROM department;
SELECT DISTINCT course_id 
FROM section 
WHERE semester = 'Fall' AND year = 2007 
AND course_id IN (SELECT course_id FROM section WHERE semester = 'Spring' AND year = 2008);
CREATE DATABASE employeebd;
CREATE TABLE EmployeeSalary (
       employeeID INT,                     
       employeeName VARCHAR(100),           
       salary DECIMAL(10,2),                
SELECT dept_name,avg(salary) as avg_salary FROM instructor group by dept_name HAVING avg(salary)>42000;
SELECT name from instructor WHERE salary>all(SELECT salary from instructor where dept_name='Biology');


SELECT dept_name,avg_salary from (SELECT dept_name,avg(salary) as avg_salary from instructor GROUP by dept_name) as t where avg_salary>42000;
with max_budget(value) AS (SELECT max(budget) from department) SELECT department.dept_name FROM department, max_budget where department.budget=max_budget.value;
with max_budget(value) AS (SELECT min(budget) from department) SELECT department.dept_name FROM department, max_budget where department.budget=max_budget.value;
Expand Requery Edit Bookmark Database : university Queried time : 10:54:37
with max_budget(value) AS (SELECT max(budget) from department) SELECT department.dept_name FROM department, max_budget where department.budget=max_budget.value;
with dept_total(dept_name,value) as (SELECT dept_name, sum(salary) from instructor GROUP BY dept_name), dept_total_avg(value) as(SELECT avg(value) from dept_total) SELECT dept_name from dept_total,dept_total_avg where dept_total.value>dept_total_avg.value;
with dept_total(dept_name,value) as (SELECT dept_name, sum(salary) from instructor GROUP BY dept_name), dept_total_avg(value) as(SELECT avg(value) from dept_total) SELECT dept_name from dept_total,dept_total_avg where dept_total.value>dept_total_avg.value;
with dept_total(dept_name,value) as (SELECT dept_name, sum(salary) from instructor GROUP BY dept_name), dept_total_avg(value) as(SELECT avg(value) from dept_total) SELECT dept_name from dept_total,dept_total_avg where dept_total.value>dept_total_avg.value;
with dept_total(dept_name,value) as (SELECT dept_name, sum(salary) from instructor GROUP BY dept_name), dept_total_avg(value) as(SELECT avg(value) from dept_total) SELECT dept_name from dept_total,dept_total_avg where dept_total.value>dept_total_avg.value;
with dept_total(dept_name,value) as (SELECT dept_name, sum(salary) from instructor GROUP BY dept_name), dept_total_avg(value) as(SELECT avg(value) from dept_total) SELECT dept_name, dept_total.value from dept_total,dept_total_avg where dept_total.value>dept_total_avg.value;

with dept_total(dept_name,value) as 
(SELECT dept_name, sum(salary) 
 from instructor 
 GROUP BY dept_name), dept_total_avg(value) as(SELECT avg(value) from dept_total)
                                     SELECT dept_name, dept_total.value from dept_total,dept_total_avg
                                     where dept_total.value>dept_total_avg.value;

SELECT dept_name,
(SELECT count(*)
 from instructor
 WHERE department.dept_name=instructor.dept_name)
 as num_in
 FROM department;

 SELECT DISTINCT course_id
FROM section
where semester='Fall' and year=2007 AND
course_id in(SELECT course_id FROM section WHERE semester='Spring' and year=2008);

--create a relational database for empployee salary maintainance with attributes employeeID(pk),employeeName, salary, department, month.
-- From Employee Table, transform rows into columns in mysql.

create database employeebd;

CREATE TABLE EmployeeSalary (
    employeeID INT,                     -- Employee ID
    employeeName VARCHAR(100),           -- Employee Name
    salary DECIMAL(10,2),                -- Salary Amount
    department VARCHAR(50),              -- Department Name
    month VARCHAR(20),                   -- Salary Month
    PRIMARY KEY (employeeID, month)      -- Composite Primary Key
);

-- insert value into the table

-- sql

SELECT employeeID, employeeName, department,
    SUM(CASE WHEN month = 'January' THEN salary ELSE 0 END) AS January,
    SUM(CASE WHEN month = 'February' THEN salary ELSE 0 END) AS February,
    SUM(CASE WHEN month = 'March' THEN salary ELSE 0 END) AS March,
    SUM(CASE WHEN month = 'April' THEN salary ELSE 0 END) AS April,
    SUM(CASE WHEN month = 'May' THEN salary ELSE 0 END) AS May,
    SUM(CASE WHEN month = 'June' THEN salary ELSE 0 END) AS June,
    SUM(CASE WHEN month = 'July' THEN salary ELSE 0 END) AS July,
    SUM(CASE WHEN month = 'August' THEN salary ELSE 0 END) AS August,
    SUM(CASE WHEN month = 'September' THEN salary ELSE 0 END) AS September,
    SUM(CASE WHEN month = 'October' THEN salary ELSE 0 END) AS October,
    SUM(CASE WHEN month = 'November' THEN salary ELSE 0 END) AS November,
    SUM(CASE WHEN month = 'December' THEN salary ELSE 0 END) AS December
FROM EmployeeSalary
GROUP BY employeeID, employeeName, department
ORDER BY employeeID;

