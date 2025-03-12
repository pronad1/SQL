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
--a.Find the total grade points earned by the student with ID '12345', across all courses taken by the student.
