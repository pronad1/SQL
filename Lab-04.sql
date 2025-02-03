-- 1.Find the names of those departments whose budget is higher than that of Astronomy. List them in alphabetic orde
SELECT dept_name from department
where department.budget>(SELECT budget from department where dept_name='Astronomy')
ORDER by dept_name;

-- 2.Display a list of all instructors, showing each instructor's ID and the number of sections taught.
--Make sure to show the number of sections as 0 for instructors who have not taught any section.
SELECT i.ID, COALESCE(COUNT(t.course_id), 0) AS number_of_sections
FROM instructor i
LEFT JOIN teaches t ON i.ID = t.ID
GROUP BY i.ID
ORDER BY  number_of_sections;
--or
SELECT instructor.ID, COUNT(teaches.sec_id) AS cnt 
FROM instructor 
LEFT JOIN teaches ON instructor.ID = teaches.ID 
GROUP BY instructor.ID 
ORDER BY cnt ASC;

--3.For each student who has retaken a course at least twice (i.e., the student has taken the course at
--least three times), show the course ID and the student's ID. Please display your results in order of course ID and do not display duplicate rows.
SELECT DISTINCT t.course_id, t.ID
FROM takes t
WHERE (SELECT COUNT(*) 
       FROM takes 
       WHERE takes.ID = t.ID AND takes.course_id = t.course_id) >= 3
ORDER BY t.course_id, t.ID;
--or
SELECT DISTINCT course_id ,ID from takes
GROUP BY course_id, ID
HAVING COUNT(*)>=3
order by course_id;

--4. Find the names of Biology students who have taken at least 3 Accounting courses
SELECT s.name
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE s.dept_name = 'Biology' AND c.dept_name = 'Accounting'
GROUP BY s.ID, s.name
HAVING COUNT(DISTINCT t.course_id) >= 3;


5. Find the sections that had maximum enrollment in Fall 2010.
SELECT course_id,sec_id
from takes
WHERE semester='Fall' and year=2010
GROUP by course_id, sec_id
HAVING COUNT(ID)=( 
    SELECT MAX(cnt) 
    FROM (SELECT COUNT(ID) as cnt
         FROM takes WHERE semester='Fall' and year=2010 GROUP by course_id,sec_id) as subject
    );
Or
WITH section_enrollments AS (
    SELECT course_id, sec_id, COUNT(ID) AS enrollment_count
    FROM takes
    WHERE semester = 'Fall' AND year = 2010
    GROUP BY course_id, sec_id
)
SELECT course_id, sec_id
FROM section_enrollments
WHERE enrollment_count = (SELECT MAX(enrollment_count) FROM section_enrollments);


-- 6. Find student names and the number of law courses taken for students who have taken at least
--half of the available law courses. (These courses are named things like 'Tort Law' or 'Environmental Law').
WITH total_law_courses AS (
    SELECT COUNT(DISTINCT course_id) / 2 AS half_law_courses FROM course WHERE title LIKE '%Law%'
)
SELECT s.name, COUNT(DISTINCT t.course_id) AS course_count
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE c.title LIKE '%Law%'
GROUP BY s.ID, s.name
HAVING COUNT(DISTINCT t.course_id) >= (SELECT half_law_courses FROM total_law_courses)
ORDER BY s.name;


--7. Find the rank and name of the 10 students who earned the most A grades (A-, A, A+). Use
--alphabetical order by name to break ties. Note: the browser SQLite does not support window functions
WITH StudentAGrades AS (
    SELECT s.name, COUNT(*) AS a_count
    FROM student s
    JOIN takes t ON s.ID = t.ID
    WHERE t.grade IN ('A', 'A-', 'A+')
    GROUP BY s.ID, s.name
)
SELECT RANK() OVER (ORDER BY a_count DESC, name ASC) AS rank, name
FROM StudentAGrades
ORDER BY rank
LIMIT 10;
Half part
SELECT s.name, COUNT(*) AS rank
FROM student s
JOIN takes t ON s.ID = t.ID
WHERE t.grade IN ('A', 'A-', 'A+')
GROUP BY s.ID, s.name
ORDER BY COUNT(*) DESC, s.name ASC;




---------    Normal Question         --------------

--1. Find out the ID and salary of the instructors.
SELECT ID , salary from instructor;

--2. Find out the ID and salary of the instructor who gets more than $85,000.
SELECT ID , salary from instructor where salary>85000;

--3. Find out the department names and their budget at the university
SELECT dept_name, budget from department;

--4. List out the names of the instructors from Computer Science who have more than $70,000
SELECT name from instructor where dept_name='Comp. Sci.' and salary>70000;

--5. For all instructors in the university who have taught some course, find their names and the course ID of all courses they taught
SELECT instructor.name,teaches.course_id from instructor JOIN teaches on instructor.ID=teaches.ID;

--6. Find the names of all instructors whose salary is greater than at least one instructor in the Biology department
SELECT name from instructor where salary>(select min(salary) from instructor where dept_name='Biology');
--or
SELECT name 
FROM instructor 
WHERE salary > ANY (
    SELECT salary 
    FROM instructor 
    WHERE dept_name = 'Biology'
);

--7.Find the advisor of the student with ID 123
SELECT instructor.name FROM
advisor JOIN student on student.ID=advisor.s_ID
JOIN instructor on advisor.i_ID=instructor.ID
WHERE student.ID=123;
--or
SELECT advisor.i_ID FROM
advisor JOIN student on student.ID=advisor.s_ID
WHERE student.ID=123;

--8.Find the average salary of all instructors
SELECT avg(salary) from instructor;

--9. Find the names of all departments whose building name includes the substring 'Taylor'
select dept_name from department where building like '%Taylor%';

--10.Find the names of instructors with salary amounts between $90,000 and $100,000
SELECT name,salary from instructor where salary between 90000 AND 100000;

--11. Find the instructor names and the courses they taught for all instructors in the Biology department who have taught some course
SELECT i.name, c.title 
FROM instructor i
JOIN teaches t ON i.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE i.dept_name = 'Biology';

--12. Find the courses taught in Fall-2009 semester.
SELECT course.title from course join section on section.course_id=course.course_id where semester='Fall' and year=2009;

--13. Find the set of all courses taught either in Fall-2009 or in Spring-2010.
SELECT course.title, section.semester, section.year 
FROM course 
JOIN section ON section.course_id = course.course_id  
WHERE (section.semester = 'Fall' AND section.year = 2009) 
   OR (section.semester = 'Spring' AND section.year = 2010);

--14. . Find the set of all courses taught in the Fall-2009 as well as in Spring-2010.
SELECT DISTINCT s1.course_id, c.title
FROM section s1
JOIN section s2 ON s1.course_id = s2.course_id
JOIN course c ON s1.course_id = c.course_id
WHERE s1.semester = 'Fall' AND s1.year = 2009
AND s2.semester = 'Spring' AND s2.year = 2010;

--15. Find all courses taught in the Fall-2009 semester but not in the Spring-2010 semester
SELECT DISTINCT s1.course_id, c.title
FROM section s1
JOIN course c ON s1.course_id = c.course_id
WHERE s1.semester = 'Fall' AND s1.year = 2009
AND s1.course_id NOT IN (
    SELECT course_id 
    FROM section 
    WHERE semester = 'Spring' AND year = 2010
);

--16.Find all instructors who appear in the instructor relation with null values for salary
SELECT name from instructor where salary IS NULL;

--17. Find the average salary of instructors in the Finance department.
SELECT avg(salary) from instructor where dept_name='Finance';

--18. Find the total number of instructors who teach a course in the Spring-2010 semester.
SELECT count(distinct ID) from teaches where semester='Spring' and year=2010;

--19.Find the average salary in each department
SELECT dept_name, ROUND(AVG(COALESCE(salary, 0)), 2) AS avg_salary
FROM instructor
GROUP BY dept_name
ORDER BY avg_salary DESC;
SELECT * FROM advisor
NATURAL JOIN student;

--20. Find the number of instructors in each department who teach a course in the Spring-2010 semester.
SELECT i.dept_name, count(distinct t.ID) from instructor i join teaches t on i.ID=t.ID where t.semester='Spring' and t.year=2010 GROUP BY i.dept_name;

--21.. List out the departments where the average salary of the instructors is more than $42,000.
SELECT dept_name from instructor group by dept_name having avg(salary)>42000;

--22. For each course section offered in 2009, find the average total credits (tot cred) of all students enrolled in the section, if the section had at least 2 students.
SELECT s.course_id, s.sec_id, AVG(st.tot_cred) AS avg_tot_cred
FROM section s
JOIN takes t ON s.course_id = t.course_id AND s.sec_id = t.sec_id
JOIN student st ON t.ID = st.ID
WHERE s.year = 2009
GROUP BY s.course_id, s.sec_id
HAVING COUNT(t.ID) >= 2;

--23. Find all the courses taught in both the Fall-2009 and Spring-2010 semesters.
SELECT DISTINCT s1.course_id
FROM section s1
JOIN section s2 ON s1.course_id = s2.course_id
WHERE s1.semester = 'Fall' AND s1.year = 2009
AND s2.semester = 'Spring' AND s2.year = 2010;

--24. Find all the courses taught in the Fall-2009 semester but not in the Spring-2010 semester.
SELECT course_id
FROM section
WHERE semester = 'Fall' AND year = 2009
AND course_id NOT IN (
    SELECT course_id
    FROM section
    WHERE semester = 'Spring' AND year = 2010
);

--25. Select the names of instructors whose names are neither "Mozart" nor "Einstein".
SELECT name
FROM instructor
WHERE name NOT IN ('Mozart', 'Einstein');

--26. Find the total number of (distinct) students who have taken course sections taught by the instructor with ID 110011.
SELECT COUNT(DISTINCT t.ID) AS student_count
FROM takes t
JOIN teaches te ON t.course_id = te.course_id AND t.sec_id = te.sec_id
WHERE te.ID = 22591;

--27.Find the ID and names of all instructors whose salary is greater than at least one instructor in the History department.
select ID, name from instructor where salary > any (select salary from instructor where dept_name='History');

--28. Find the names of all instructors that have a salary value greater than that of each instructor in theBiology department
select name from instructor where salary > all (select salary from instructor where dept_name='Biology');
select name from instructor where salary > (select max(salary) from instructor where dept_name='Biology');
--29. Find the departments that have the highest average salary
SELECT dept_name
FROM instructor
GROUP BY dept_name
HAVING AVG(salary) = (
    SELECT MAX(avg_salary)
    FROM (
        SELECT dept_name, AVG(salary) AS avg_salary
        FROM instructor
        GROUP BY dept_name
    ) subquery
);

--30. Find all courses taught in both the Fall 2009 semester and in the Spring-2010 semester.
select course_id from section where (semester='Fall' and year=2009) and course_id in (select course_id from section where semester='Spring' and year=2010);

--31. Find all students who have taken all the courses offered in the Biology department
SELECT s.ID, s.name
FROM student s
WHERE NOT EXISTS (
    SELECT c.course_id
    FROM course c
    WHERE c.dept_name = 'Biology'
    AND NOT EXISTS (
        SELECT t.course_id
        FROM takes t
        WHERE t.ID = s.ID
        AND t.course_id = c.course_id
    )
);
--or
SELECT DISTINCT t.ID
FROM takes t
JOIN course c ON t.course_id = c.course_id
WHERE c.dept_name = 'Biology'
GROUP BY t.ID
HAVING COUNT(DISTINCT t.course_id) = 
    (SELECT COUNT(*) FROM course WHERE dept_name = 'Biology');

--32. Find all courses that were offered at most once in 2009
SELECT course_id
FROM section
WHERE year = 2009
GROUP BY course_id
HAVING COUNT(*) <= 1;

--33. Find all courses that were offered at least twice in 2009.
select course_id from section where year=2009 group by course_id having count(*)>=2;

--34. Find the average instructors' salaries of those departments where the average salary is greater than$42,000.
select dept_name, avg(salary) from instructor group by dept_name having avg(salary)>42000;


--35. Find the maximum across all departments of the total salary at each department.
select dept_name, max(salary) from instructor group by dept_name;

--36. List all departments along with the number of instructors in each department.
select dept_name, count(ID) from instructor group by dept_name;