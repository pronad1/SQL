-- 1.Write the following queries in SQL, using the university schema.

-- a.Find the titles of courses in the Comp. Sci. department that have 3 credits.
select title from course
where dept_name='Comp. Sci.' and credits=3;

--b.Find the IDs of all students who were taught by an instructor named 
--Bawa; make sure there are no duplicates in the result.
SELECT DISTINCT takes.ID
from takes, instructor, teaches
where takes.course_id=teaches.course_id and 
takes.sec_id=teaches.sec_id and 
takes.semester=teaches.semester and 
takes.year=teaches.year and 
teaches.id=instructor.ID and 
instructor.name='Bawa';


--c.Find the highest salary of any instructor.
select max(salary) from instructor;  --OR 
SELECT salary from instructor order by salary DESC limit 1;

--d.Find all instructors earning the highest salary (there may be more than one with the same salary).
SELECT ID,name from instructor
WHERE salary=(select max(salary)
from instructor);

--e.. Find the enrollment of each section that was offered in Fall 2007.
SELECT t.course_id,t.sec_id,COUNT(ID)
from section s,takes t
WHERE
t.course_id=s.course_id and
t.sec_id=s.sec_id and
t.semester=s.semester and
t.year=s.year and
t.year=2007 and t.semester='Fall'
GROUP by t.course_id,t.sec_id;

--f.Find the maximum enrollment, a ross all se tions, in Fall 2017.
select max(en) 
from (
    select count(ID) as en
    from section s,takes t 
    where t.course_id=s.course_id and
    t.sec_id=s.sec_id and
    t.semester=s.semester and 
    t.year=s.year and
    t.year=2007 and t.semester='Fall'
    group by t.course_id,t.sec_id
) as subquery;


--g. Find the sections that had the maximum enrollment in Fall 2017
with section_enrollment as ( select 
    t.course_id,t.sec_id,count(ID) as en 
    from section s, takes t 
    where t.course_id = s.course_id and 
    t.sec_id =s.sec_id and 
    t.semester = s.semester and 
    t.year = s.year and t.year=2007 and t.semester='Fall' group by t.course_id,t.sec_id
)
select course_id ,sec_id from section_enrollment 
where en=(
    select max(en) from section_enrollment
)

--2.Suppose you are given a relation grade points
--a.Find the total grade points earned by the student with ID '10705', across all courses taken by the student.
SELECT 
    SUM(
        CASE T.grade
            WHEN 'A+' THEN 4.3 * C.credits
            WHEN 'A'  THEN 4.0 * C.credits
            WHEN 'A-' THEN 3.7 * C.credits
            WHEN 'B+' THEN 3.3 * C.credits
            WHEN 'B'  THEN 3.0 * C.credits
            WHEN 'B-' THEN 2.7 * C.credits
            WHEN 'C+' THEN 2.3 * C.credits
            WHEN 'C'  THEN 2.0 * C.credits
            WHEN 'C-' THEN 1.7 * C.credits
            WHEN 'D+' THEN 1.3 * C.credits
            WHEN 'D'  THEN 1.0 * C.credits
            WHEN 'D-' THEN 0.7 * C.credits
            WHEN 'F'  THEN 0.0
            ELSE 0.0
        END
    ) AS total_grade_points
FROM takes T
JOIN course C ON T.course_id = C.course_id
WHERE T.ID = '10705';

--If grade_point is available then we can easily write
select sum(credits*point) 
from takes,course,grade_points 
where takes.grade=grade_points.grade and
takes.course_id=course.course_id and id='10705'

--b. Find the grade point average (GPA) for the above student, that is, the total 
--grade points divided by the total credits for the associated courses.
SELECT 
    SUM(
        CASE T.grade
            WHEN 'A+' THEN 4.3 * C.credits
            WHEN 'A'  THEN 4.0 * C.credits
            WHEN 'A-' THEN 3.7 * C.credits
            WHEN 'B+' THEN 3.3 * C.credits
            WHEN 'B'  THEN 3.0 * C.credits
            WHEN 'B-' THEN 2.7 * C.credits
            WHEN 'C+' THEN 2.3 * C.credits
            WHEN 'C'  THEN 2.0 * C.credits
            WHEN 'C-' THEN 1.7 * C.credits
            WHEN 'D+' THEN 1.3 * C.credits
            WHEN 'D'  THEN 1.0 * C.credits
            WHEN 'D-' THEN 0.7 * C.credits
            WHEN 'F'  THEN 0.0
            ELSE 0.0
        END
    ) / SUM(C.credits) AS GPA
FROM takes T 
JOIN course C ON T.course_id = C.course_id
WHERE T.ID = '10705';

-- Or 
select sum(credits*point)/sum(credits) as GPA 
from takes , course , grade_points 
where takes.grade=grade_points.grade and takes.course_id=course.course_id 
and id ='10705';

--c.Find the ID and the grade-point average of each student.
select t.id, sum(
    case t.grade
        when 'A+' then 4*c.credits
        when 'A' then 3.75*c.credits
        when 'A-' then 3.5*c.credits
        when 'B+' then 3.25*c.credits
        when 'B' then 3*c.credits
        when 'B-' then 2.75*c.credits
        when 'C+' then 2.5*c.credits
        when 'C' then 2.25*c.credits
        when 'C-' then 2*c.credits
        when 'D+' then 1.75*c.credits
        when 'D' then 1.5*c.credits
        when 'D-' then 1.25*c.credits
        when 'F' then 0
        else 0
    end
) / sum(c.credits) as gpa
from takes t
join course c on t.course_id=c.course_id
group by t.id
order by gpa desc;


--d. Now reconsider your answers to the earlier parts of this exercise under the 
--assumption that some grades might be null. Explain whether your solutions 
--still work and, if not, provide versions that handle nulls properly.
SELECT 
    T.ID, 
    COALESCE(SUM(
        CASE COALESCE(T.grade, 'F') -- If grade is NULL, treat it as 'F'
            WHEN 'A+' THEN 4.3 * C.credits
            WHEN 'A'  THEN 4.0 * C.credits
            WHEN 'A-' THEN 3.7 * C.credits
            WHEN 'B+' THEN 3.3 * C.credits
            WHEN 'B'  THEN 3.0 * C.credits
            WHEN 'B-' THEN 2.7 * C.credits
            WHEN 'C+' THEN 2.3 * C.credits
            WHEN 'C'  THEN 2.0 * C.credits
            WHEN 'C-' THEN 1.7 * C.credits
            WHEN 'D+' THEN 1.3 * C.credits
            WHEN 'D'  THEN 1.0 * C.credits
            WHEN 'D-' THEN 0.7 * C.credits
            WHEN 'F'  THEN 0.0
            ELSE 0.0
        END
    ), 0) / NULLIF(SUM(C.credits), 0) AS GPA -- Prevent division by zero
FROM takes T
JOIN course C ON T.course_id = C.course_id
GROUP BY T.ID
ORDER BY GPA DESC;

-- 3. Write the following inserts, deletes, or updates in SQL, using the 
--university schema.

--a. Increase the salary of each instructor in the Comp. Sci. department by 10%
UPDATE instructor 
SET salary = salary * 1.1 
WHERE dept_name = 'Comp. Sci.';


--b. Delete all courses that have never been offered (i.e., do not occur in the section 
--relation).
DELETE from course
where  course_id not in (
    SELECT course_id  from section
    );


--c. Insert every student whose tot_cred attribute is greater than 100 as an 
--instructor in the same department, with a salary of $10,000
INSERT INTO instructor (ID, name, dept_name, salary)
SELECT s.ID, s.name, s.dept_name, 30000
FROM student s
WHERE s.tot_cred > 100;


--4

--a. Find the total number of people who owned cars that were involved in accidents in 2017.
select count(distinct person.driver_id) 
from accident, participated, person, owns
where accident.report_number=participated.report_number and  
    owns.driver_id=person.driver_id and
    owns.license_plate=participated.license_plate and
    year=2017;

--b. Delete all year-2010 ars belonging to the person whose ID is 12345.
delete car where year=2010 and 
    license_plate in (select license_plate from owns where owns.driver_id='12345');


--5Suppose that we have a relation marks(ID, score) and we wish 
--to assign grades

--a.
select id ,case 
when score<40 then 'F'
when score<60 then 'C'
when score<80 then 'B'
else 'A'
end as grade
from marks
--OR
SELECT id, CASE
when grade='A+' then 4.00
when grade='A-' then 3.75
when grade='A' then 3.50
when grade='B' then 3.00
when grade='B+' then 3.25
when grade='B-' then 2.75
when grade='C+' then 2.50
when grade='C' then 2.25
when grade='C-' then 2.00
else 2.00
END
from takes;

--b. Find the number of students with each grade

with grades as (
    select ID ,
    case 
    when score<40 then 'F'
    when score<60 then 'C'
    when score<80 then 'B'
    else 'A'
    end as grade
    from marks
)
select grade,count(ID) 
from grades
group by grade

--6. The SQL like operator is case sensitive (in most systems), but 
--the lower() funtion on strings can be used to perform case 
--insensitive matching. To show how, write a query that finds 
--departments whose names contain the string “sci” as a substring, 
--regardless of the case.
SELECT dept_name
from department
where lower(dept_name) like "%sci%";

--11.Write the following queries in SQL, using the university schema:

--a. Find the ID and name of each student who has taken at least one Comp. Sci. 
--course; make sure there are no duplicate names in the result.
select DISTINCT s.id, name from student s
join takes on s.ID=takes.ID
join course on takes.course_id=course.course_id
WHERE course.dept_name='Comp. Sci.';

--b. Find the ID and name of each student who has not taken any course offered before 2017.
select s.id, s.name from student s
WHERE s.id not in(
    SELECT takes.id
    from takes
    where takes.year<2017
    );

--c. For each department, find the maximum salary of instructors in that 
--department. You may assume that every department has at least one 
--instructor.
SELECT dept_name, max(salary)
from instructor
GROUP By dept_name;

--d. Find the lowest, across all departments, of the per-department maximum 
--salary computed by the preceding query.
SELECT min(max_salary)
from (
    SELECT dept_name, max(salary) as max_salary
    from instructor
    GROUP BY dept_name
    ) as dept_max_salaries;

--12. Write the SQL statements using the university schema to 
--perform the following operations:

--a. Create a new course “CS-001”, titled “Weekly Seminar”, with 0 credits.
INSERT INTO course (course_id, title, dept_name, credits)
VALUES ('CS-001', 'Weekly Seminar', 'Comp. Sci.', 0);

--b. Create a section of this course in Fall 2017, with sec_id of 1, and with the location of this section not yet specified.
insert into section(course_id,sec_id,semester,year)
values('CS-101',1,'Fall',2017);

--c. Enroll every student in the Comp. Sci. department in the above section.
INSERT into takes (id,course_id,sec_id,semester,year)
select student.id,'CS-001','Fall',2017
from student
where student.dept_name='Comp. Sci.';

--d. Delete enrollments in the above section where the student’s ID is 12345.
DELETE from takes
where course_id='CS-001'
and sec_id=1
and semester='Fall'
and year=2017
and id='12345'
;

--e. Delete the course CS-001. What will happen if you run this delete statement 
--without first deleting offerings (sections) of this course?
DELETE FROM course
WHERE course_id = 'CS-001';
-- Note: If you run this delete statement without first deleting the sections of this course, it will fail 
-- due to foreign key constraints (if the database enforces referential integrity).

--f. Delete all takes tuples corresponding to any section of any course with the 
--word “advanced” as a part of the title; ignore case when matching the word with the title.
delete from takes
where course_id in(
    select course_id
    from course
    where lower(title) like "%advanced%"
);


--22 Rewrite the where clause
where unique (select title from course)
without using the unique construct.
--ANS:
WHERE (SELECT COUNT(*) FROM course) <= 1


--24. Using the university schema, write an SQL query to find the name and ID of those Accounting students advised by an instructor in the Physics department.
SELECT s.name,s.ID
from student s
join advisor a on s.ID=a.s_ID
JOIN instructor i on i.ID=a.i_ID
where s.dept_name='Accounting' and i.dept_name='Physics';

--25. Using the university schema, write an SQL query to find the names of those departments whose budget is higher than that of 
--Philosophy. List them in alphabetic order.
select dept_name
from department
where budget>(
    select budget
    from department
    where dept_name='Philosophy'
)


--26. Using the university schema, use SQL to do the following: For each student who has retaken a course at least twice (i.e., the student has taken the course at least three times), show the courseID and the student’s ID. Please display your results in order of 
--course ID and do not display duplicate rows.
select DISTINCT course_id,ID
from takes
group by id,course_id
having count(*)>2
order by course_id;

--27. Using the university schema, write an SQL query to find the Ds of those students who have retaken at least three distinct courses at least once (i.e., the student has taken the course at least two times).
select t.id from takes t 
where t.grade is not null and 
2<=(
    select count(course_id)
    from takes t2
    where t2.id=t.id and t2.course_id=t.course_id
)
group by t.id
having count(distinct course_id)>=3;

--28. Using the university schema, write an SQL query to find the names and IDs of those instructors who teach every course taught in his or her department (i.e., every course that appears in the course relation with the instructor’s department name). Order the result by name.
select i.id,i.name
from instructor i 
join teaches t on i.id=t.id
join course c on t.course_id=c.course_id and i.dept_name=c.dept_name
group by i.id,i.name,c.dept_name
having count(distinct t.course_id) = (
    select count(*)
    from course c2
    where c2.dept_name=i.dept_name
)
order by i.name;

--29. Using the university schema, write an SQL query to find the name and ID of each History student whose name begins with the letter ‘D’ and who has not taken at least five Music courses.
SELECT s.id,s.name from student s 
WHERE s.dept_name='History' and s.name like "D%" 
and (SELECT count(*) from takes t 
     where t.ID=s.ID
     and t.course_id in (
         SELECT c.course_id from course c 
         where c.dept_name='Music'
        )
     )<5;

--31. Using the university schema, write an SQL query to find the ID and name of each instructor who has never given an A grade in any course she or he has taught. (Instructors who have never taught a course trivially satisfy this condition.)
SELECT i.ID, i.name
FROM instructor i
LEFT JOIN teaches t ON i.ID = t.ID
LEFT JOIN takes tk ON t.course_id = tk.course_id
WHERE tk.grade != 'A' OR tk.grade IS NULL
GROUP BY i.ID;


--32. Rewrite the preceding query, but also ensure that you include only instructors who have given at least one other non-null grade in some course.
SELECT distinct i.ID, i.name
FROM instructor i
LEFT JOIN teaches t ON i.ID = t.ID
LEFT JOIN takes tk ON t.course_id = tk.course_id
WHERE tk.grade != 'A' AND EXISTS (
select tk2.grade
 from takes tk2
 where t.course_id = tk2.course_id
 and tk2.grade is not null
);


--33. Using the university schema, write an SQL query to find the ID and title of each course in Comp. Sci. that has had at least one section with afternoon hours (i.e., ends at or after 12:00). (You should eliminate duplicates if any.)
SELECT DISTINCT c.course_id, c.title FROM course c
JOIN section s ON c.course_id = s.course_id
JOIN time_slot t ON s.time_slot_id = t.time_slot_id
WHERE t.end_hr >= 12 AND c.dept_name = 'Comp. Sci.';


--34. Using the university schema, write an SQL query to find the number of students in each section. The result columns should appear in the order "courseid, secid, year, semester, num." You do not need to output sections with 0 students.
SELECT s.course_id, s.sec_id, s.year, s.semester,
COUNT(t.ID) AS num
FROM section s
LEFT JOIN takes t ON s.course_id = t.course_id
AND s.sec_id = t.sec_id
GROUP BY course_id, sec_id, year, semester
HAVING num > 0;

--35. Using the university schema, write an SQL query to find section(s) with maximum enrollment. The result columns should appear in the order "courseid, secid, year, semester, num." (It may be convenient to use the WITH construct.)
WITH section_enrollment AS (
 SELECT s.course_id, s.sec_id, s.year, s.semester, COUNT(t.ID) AS num
 FROM section s
 LEFT JOIN takes t ON s.course_id = t.course_id
 AND s.sec_id = t.sec_id
 GROUP BY course_id, sec_id, year, semester
)
SELECT course_id, sec_id, year, semester, num
FROM section_enrollment
WHERE num = (SELECT MAX(num) FROM section_enrollment);
