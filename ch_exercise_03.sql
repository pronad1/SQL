-- 1.Write the following queries in SQL, using the university schema.
-- a.Find the titles of courses in the Comp. Sci. department that have 3 credits.
select title from course
where dept_name='Comp. Sci.' and credits=3;

--b.Find the IDs of all students who were taught by an instructor named 
--Bawa; make sure there are no duplicates in the result.
SELECT DISTINCT takes.ID
from takes,instructor,teaches
where takes.course_id=teaches.course_id and 
takes.sec_id=teaches.sec_id and 
takes.semester=teaches.semester and 
takes.year=teaches.year and 
teaches.id=(SELECT ID from instructor where name='Bawa');

--c.Find the highest salary of any instructor.
SELECT salary from instructor order by salary DESC limit 1;

--d.Find all instructors earning the highest salary (there may be more than one with the same salary).
SELECT ID,name from instructor
WHERE salary=(select salary
from instructor
order by salary desc
limit 1);

--e.. Find the enrollment of each section that was offered in Fall 2017.
SELECT course_id,sec_id,COUNT(*)
from takes WHERE
year=2017 and semester='Fall'
GROUP by course_id,sec_id;

--f.Find the maximum enrollment, a ross all se tions, in Fall 2017.
SELECT course_id,sec_id
FROM takes
where semester='Fall' and year=2017
GROUP by course_id,sec_id
HAVING count(id)=(
SELECT MAX(enrollment_count)
FROM (
    SELECT COUNT(ID) AS enrollment_count
    FROM takes
    WHERE semester = 'Fall' AND year = 2017
    GROUP BY course_id, sec_id
) AS section_enrollments
);

--g. Find the sections that had the maximum enrollment in Fall 2017
select sec_id,course_id from takes
where year=2017 and semester='Fall'
GROUP BY sec_id,course_id
HAVING COUNT(*) order by COUNT(*) DESC limit 1;

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


--5Suppose that we have a relation marks(ID, score) and we wish 
--to assign grades
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