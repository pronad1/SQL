--01.Find the names of those departments whose budget is higher than that of Astronomy. List them in alphabetic order.

SELECT 
    dept_name
FROM
    department
WHERE
    budget > (SELECT 
            budget
        FROM
            department
        WHERE
            dept_name = 'Astronomy');
 


--02.Display a list of all instructors, showing each instructor’s ID 
--and the number of sections taught. Make sure to show the number of sections as 0 for instructors who have not taught any section.

SELECT 
    I.ID, COUNT(T.ID) as number_of_sections
FROM
    instructor AS I
        NATURAL LEFT JOIN
    teaches AS T
GROUP BY I.ID
ORDER BY number_of_sections;
--SQL SERVER
SELECT l.ID, COUNT(T.ID) AS num_of
FROM instructor AS l
LEFT JOIN teaches AS T ON l.ID = T.ID
GROUP BY l.ID
ORDER BY num_of;



--03.For each student who has retaken a course at least twice (i.e., the student has taken the course at least three times), 
--show the course ID and the student’s ID. Please display your results in order of course ID and do not display duplicate rows.

select distinct course_id, ID
	from takes
    group by ID, course_id having count(*) > 2
    order by course_id;
  
--04.Find the names of Biology students who have taken at least 3 Accounting courses.

SELECT s.name
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE s.dept_name = 'Biology'
AND c.dept_name = 'Accounting'
GROUP BY s.ID,s.name
HAVING COUNT(*) > 2;

 
--05.Find the sections that had maximum enrollment in Fall 2010.

select course_id, sec_id 
from takes
WHERE semester = 'Fall' AND year = 2010
group by course_id, sec_id
order by count(*) desc
limit 1;
--sql server
select top 1 course_id,sec_id from takes
where semester='Fall' and year=2010
group by course_id,sec_id
order by count(*) desc;


--06.Find student names and the number of law courses taken for students 
--who have taken at least half of the available law courses. (These courses are named things like ‘Tort Law’ or ‘Environmental Law’).


select s.name,count(*) from student as s  
join takes as t on t.ID=s.ID
where t.course_id in(
select course_id from course where title like '%Law%')
group by s.id ,s.name 
having count(*) >(
select count(*)/2 from course
where title like '%Law%');
 

--07.Find the rank and name of the 10 students who earned the most 
--A grades (A-, A, A+). Use alphabetical order by name to break ties. 
--Note: the browser SQLite does not support window functions.

select row_number() over(order by count(*) desc, name) as rnk, name 
from student st
natural join takes tt
where tt.grade in ("A+", "A", "A-")
group by ID
order by count(*) desc, name 
limit 10;
 
--sql server
select top 10 ROW_NUMBER() 
over(order by count(*) desc,name) as rnk,
name from student s
join takes t on t.ID=s.ID
where t.grade in ('A+','A','A-')
group by s.id,s.name 
order by count(*) desc,name;


--                                      Problem set 2

--01.Find out the ID and salary of the instructors.

select ID, salary from instructor;
 
--02.Find out the ID and salary of the instructor who gets more than $85,000.

select ID, salary from instructor
where salary > 85000;
 
 
--03Find out the department names and their budget at the university.

select dept_name, budget from department;
 

--04.List out the names of the instructors from Computer Science who have more than $70,000.


select * from instructor where dept_name='Comp. Sci.' and salary>70000;
 
 
--05.For all instructors in the university who have taught some course, find their names and the course ID of all courses they taught.

select I.name, T.course_id
from instructor I
natural join teaches T
order by I.name;
--sql server

select i.name,t.course_id from instructor as i 
join teaches as t on t.ID=i.ID
order by i.name;


--06.Find the names of all instructors whose salary is greater than at least one instructor in the Biology department.

SELECT name
FROM instructor
WHERE salary > (
    SELECT MIN(salary)
    FROM instructor
    WHERE dept_name = 'Biology'
);

--07.Find the advisor of the student with ID 12345

select * from advisor
where s_ID = 12345;
 

--08.Find the average salary of all instructors.

select avg(I.salary) average_salary from
(select salary from instructor) as I;
 

--09.Find the names of all departments whose building name 
--includes the substring ‘Watson’.

select dept_name from department
where building like "%Watson%";
 
--10.Find the names of instructors with salary amounts 
--between 90,000and100,000.

select name from instructor
where salary between 90000 and 100000;
 
--11.Find the instructor names and the courses they taught for all instructors in the Biology department who have taught some course.

select name, course_id
from instructor 
natural left join teaches
where dept_name = "Biology";
 

-- 12.Find the courses taught in Fall-2009 semester.

select course_id from teaches
where semester = "Fall" and year = 2009;
 
--13.Find the set of all courses taught either in Fall-2009 or in Spring-2010.

select course_id from teaches
where (semester = "Fall" and year = 2009) or (semester = "Spring" and year = 2010);
 
 
--14.Find the set of all courses taught in the Fall-2009 as well as in Spring-2010.

select course_id from teaches
where (semester = "Fall" and year = 2009) and (semester = "Spring" and year = 2010);

--15.Find all courses taught in the Fall-2009 semester but not in the Spring-2010 semester.
select course_id from teaches
where (semester = "Fall" and year = 2009) and not (semester = "Spring" and year = 2010);
 

--16.Find all instructors who appear in the instructor relation with null values for salary.
select * from instructor where salary is null;

--17.Find the average salary of instructors in the Finance department.

select avg(salary) from instructor where dept_name='Finance';


--18.Find the total number of instructors who teach a course in the Spring-2010 semester.

select  count(T.id) from
( select id from instructor
	natural join teaches
    where semester = "Spring" 
    and year = 2010 ) as T ;
 
-- 19.Find the average salary in each department.

select dept_name, avg(salary) from instructor group by dept_name;

 
--20.Find the number of instructors in each department who teach a course in the Spring-2010 semester.

SELECT d.dept_name, COUNT(DISTINCT i.ID) AS num_instructors
FROM department d
JOIN instructor i ON d.dept_name = i.dept_name
JOIN teaches t ON i.ID = t.ID
WHERE t.semester = 'Spring' AND t.year = 2010
GROUP BY d.dept_name;


--21.List out the departments where the average salary of the instructors is more than $42,000.

select dept_name from department d where
(select avg(salary) from(select salary from instructor i
where d.dept_name=i.dept_name) as t) >42000;


--22.For each course section offered in 2009, find the average total credits (tot cred) of all students enrolled in the section, if the section had at least 2 students.

select course_id, sec_id, avg(tot_cred)
from takes 
natural join student 
where year = 2009
group by sec_id, course_id
having count(*) > 1;
 
-- 23.Find all the courses taught in both the Fall-2009 and Spring-2010 semesters.



select course_id from teaches
where (semester = "Fall" and year = 2009) and (semester = "Spring" and year = 2010);
 

--24.Find all the courses taught in the Fall-2009 semester but not in the Spring-2010 semester.

select course_id from teaches
where (semester = "Fall" and year = 2009) and not (semester = "Spring" and year = 2010);
 
--25.Select the names of instructors whose names are neither ‘Mozart’ nor ‘Einstein’.

select name from instructor
where name not in ("Mozart", "Einstein");
 
-- 26.Find the total number of (distinct) students who have taken course sections taught by the instructor with ID 110011.

SELECT COUNT(DISTINCT t.ID) AS total_students
FROM takes t
JOIN teaches te ON t.course_id = te.course_id 
               AND t.sec_id = te.sec_id 
               AND t.semester = te.semester 
               AND t.year = te.year
WHERE te.ID = '110011';


--27.Find the ID and names of all instructors whose salary is greater than at least one instructor in the History department.

select id, name from instructor where salary>(select min(salary) from instructor where dept_name='History');

 
-- 28.Find the names of all instructors that have a salary value greater than that of each instructor in the Biology department.

select id, name from instructor where salary>(select max(salary) from instructor where dept_name='Biology');


--29.Find the departments that have the highest average salary.

select dept_name
from instructor
group by dept_name
order by avg(salary) desc
limit 1;
 
-- 30.Find all courses taught in both the Fall 2009 semester and in the Spring-2010 semester.

select course_id from teaches
where (semester = "Fall" and year = 2009) and (semester = "Spring" and year = 2010);
 
--31.Find all students who have taken all the courses offered in the Biology department.

select distinct s.id from student s
join takes t on t.ID=s.ID
join course c on c.course_id=t.course_id
where c.dept_name='Biology';


--32.Find all courses that were offered at most once in 2009.

select course_id 
from takes
where year = 2009 
group by course_id
having count(*) = 1;

--33.Find all courses that were offered at least twice in 2009.

select course_id 
from takes
where year = 2009 
group by course_id
having count(*) > 1;

--34.Find the average instructors’ salaries of those departments where the average salary is greater than $42,000.
select dept_name,avg(salary)
from instructor where (select avg(salary)
from instructor)>42000 
group by dept_name order by dept_name desc;

 
--35.Find the maximum across all departments of the total salary at each department.

select dept_name, max(salary) as max_salary 
from instructor group by dept_name;
 

--36.List all departments along with the number of instructors in each department.
select dept_name,count(id) as num_instractor from instructor
group by dept_name;
 
--                                 Problem set 3

--01.Find the titles of courses in the Comp. Sci. department that have 3 credits.

select title
from course
where dept_name = "Comp. Sci."
and credits = 3;
 

--02.Find the IDs of all students who were taught by an instructor named Einstein; make sure there are no duplicates in the result.

select distinct s.id from student s join advisor a
on s.id=a.s_ID join instructor i on i.id=a.i_ID
where 
i.name='Einstein';

--03.Find the ID and name of each student who has taken at least one Comp. Sci. course; make sure there are no duplicate names in the result.

select distinct ID, name
from student 
natural join takes 
where takes.course_id in (
	select course_id
    from course 
    where dept_name = "Comp. Sci."
);
 

--04.Find the course id, section id, and building for each section of a Biology course.

select course_id, sec_id, building 
from section
natural join course
where dept_name = "Biology";
 

--05.Output instructor names sorted by the ratio of their salary to their department’s budget (in ascending order).

select name
from instructor
natural left join department
order by (salary/ budget) asc;
 

--06.Output instructor names and buildings for each building an instructor has taught in. Include instructor names who have not taught any classes (the building name should be NULL in this case).

select name, building
from instructor
natural left join teaches 
natural left join section;
 