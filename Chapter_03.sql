SELECT * FROM 'classroom'
SELECT * FROM `course`
SELECT * FROM `department`
SELECT * FROM `instructor`
SELECT * FROM `prereq`
SELECT name from instructor where dept_name='Comp.Sci.' AND salary>70000;
SELECT name from instructor where dept_name='Comp.Sci.' AND salary>70000;
SELECT name from instructor where dept_name='Comp.Sci.' AND salary>70000;
select name from instructor;
select name, instructor.dept_name, building from instructor, department where instructor.dept_name= department.dept_name;
SELECT name,course_id from instructor,teaches WHERE instructor.ID=teaches.ID;
SELECT name,course_id from instructor,teaches WHERE instructor.ID=teaches.ID and instructor.dept_name='Comp.Sci.';
SELECT * FROM `instructor`;
select name,course_id from instructor,teaches where instructor.ID=teaches.ID;
select name,course_id from instructor,teaches where instructor.ID=teaches.ID;
SELECT * FROM `teaches`;
SELECT t.name,s.course_id from instructor as t, teaches as s WHERE t.ID=s.ID;

SELECT name,course_id from instructor,teaches WHERE instructor.ID=teaches.ID and instructor.dept_name='Comp.Sci.';
SELECT name,course_id from instructor,teaches WHERE instructor.ID=teaches.ID and instructor.dept_name='Comp.Sci.';
SELECT course_id FROM section WHERE semester='Fall' and year=2017;
select course_id from section where semester = 'Spring' and year= 2018;
select course_id from section where semester = 'Spring' and year= 2018;
select course_id from section where semester = 'Spring' and year= 2018;
select course_id from section where semester = 'Spring' and year= 2008;
​
ascendingdescendingOrder:Debug SQLExecution orderTime takenOrder by:Group queries
Some error occurred while getting SQL debug info.
BookmarksRefreshAdd
No bookmarks
Add bookmark
Label: 
 Target database: 
 Share this bookmark 
​
OptionsSet default
Always expand query messages
Show query history at start
Show current browsing query
 Execute queries on Enter and insert new line with Shift+Enter. To make this permanent, view settings.
Switch to dark theme
Run SQL query/queries on table university.section: Documentation
1
(SELECT course_id from section
2
WHERE semester='Fall' and year=2007)
3
UNION (SELECT course_id FROM section 
4
       WHERE section='Spring' and year=2008);
Bind parameters Documentation
Columnscourse_idsec_idsemesteryearbuildingroom_numbertime_slot_id
Bookmark this SQL query:
Delimiter
Delimiter
;
Show this query here again
Retain query box
Rollback when finished
Enable foreign key checks
Error
SQL query: Copy Documentation


(SELECT course_id from section
WHERE semester='Fall' and year=2007)
UNION (SELECT course_id FROM section 
       WHERE section='Spring' and year=2008) LIMIT 0, 25
MySQL said: Documentation

#1054 - Unknown column 'section' in 'where clause'




(select course_id from section where semester = 'Fall' and year= 2007) union all (select course_id from section where semester = 'Spring' and year= 2008);
(select course_id from section where semester = 'Fall' and year= 2007) union (select course_id from section where semester = 'Spring' and year= 2008);
select name from instructor where salary is null;
select name from instructor where salary > 10000 is unknown;
select name from instructor where salary is null;
SELECT avg(salary) from instructor WHERE dept_name='Comp.Sci.';
SELECT COUNT(DISTINCT ID) FROM teaches WHERE semester='Spring' and year=2018;
SELECT dept_name,AVG(salary) as avg_salary FROM instructor GROUP by dept_name;
SELECT dept_name,AVG(salary) as avg_salary FROM instructor GROUP by dept_name HAVING avg(salary)>42000;
SELECT course_id FROM course WHERE course_id NOT IN ( SELECT course_id FROM section WHERE year = 2007 );


SELECT * FROM `job_listing`
SELECT name from instructor where salary is null;
SELECT name from instructor where salary is null;
SELECT count(*) FROM course;
SELECT * FROM `section`
(SELECT course_id from section WHERE semester='Fall' and year=2007) UNION (SELECT course_id from section WHERE semester='Spring' and year=2008);
select dept_name, avg_salary from (select dept_name, AVG(salary) as avg_salary from instructor group by dept_name) as a where avg_salary>42000;
SELECT avg(salary) FROM instructor WHERE dept_name='Comp.Sci.';
SELECT COUNT(DISTINCT ID) from teaches WHERE semester='Spring' and year=2008;
(SELECT course_id from section WHERE semester='Fall' and year=2007) UNION (SELECT course_id from section WHERE semester='Spring' and year=2008);
(SELECT course_id from section WHERE semester='Fall' and year=2007) UNION (SELECT course_id from section WHERE semester='Spring' and year=2008);
SELECT dept_name, avg(salary) FROM instructor GROUP by dept_name;
SELECT dept_name, ID,avg(salary) FROM instructor GROUP by dept_name;
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

