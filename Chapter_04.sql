--4.1
SELECT i.name, c.title
FROM instructor i
JOIN teaches t ON i.ID = t.ID
JOIN section s ON t.course_id = s.course_id 
              AND t.sec_id = s.sec_id 
              AND t.semester = s.semester 
              AND t.year = s.year
JOIN course c ON s.course_id = c.course_id
WHERE s.semester = 'Spring' AND s.year = 2017;

--4.2
--a
SELECT i.ID, COUNT(t.course_id) AS num_sections
FROM instructor i
LEFT JOIN teaches t ON i.ID = t.ID
GROUP BY i.ID;

--b
SELECT i.ID,  
       (SELECT COUNT(*)  
        FROM teaches t  
        WHERE t.ID = i.ID) AS num_sections  
FROM instructor i;

--c
SELECT 
    s.course_id,
    s.sec_id,
    s.semester,
    s.year,
    COALESCE(i.ID, '—') AS instructor_id,
    COALESCE(i.name, '—') AS instructor_name
FROM 
    section s
LEFT JOIN teaches t 
    ON s.course_id = t.course_id 
    AND s.sec_id = t.sec_id 
    AND s.semester = t.semester 
    AND s.year = t.year
LEFT JOIN instructor i 
    ON t.ID = i.ID;
--OR
selet course_id, sec_id, ID,
decode(name, null, '*', name) as name
from (setion natural left outer join teahes)
natural left outer join instrutor
where semester='Spring' and year= 2018

--d
SELECT 
    d.dept_name,
    COUNT(i.ID) AS instructor_count
FROM 
    department d
LEFT JOIN instructor i 
    ON d.dept_name = i.dept_name
GROUP BY 
    d.dept_name;

--4.3
--a
selet * from student natural join takes
union
selet ID, name, dept name, tot_cred, null, null, null, null, null
from student S1 where not exists
(selet ID from takes T1 where T1.id = S1.id)

--b
(selet * from student natural join takes)
union
(selet ID, name, dept name, tot_cred, null, null, null, null, null
from student S1
where not exists
(selet ID from takes T1 where T1.id = S1.id))
union
(selet ID, null, null, null, course_id, sec_id, semester, year, grade
from takes T1
where not exists
(selet ID from student S1 where T1.id = S1.id))


--4.5
--a
SELECT i.name, t.course_id, c.title
FROM instructor i 
JOIN teaches t ON i.ID = t.ID
JOIN course c ON t.course_id = c.course_id;

--b
SELECT s.name, t.course_id
FROM student s 
LEFT JOIN takes t ON s.ID = t.ID;

--c 
SELECT s.name, i.name AS advisor
FROM student s
LEFT JOIN instructor i ON s.ID = i.ID;


--4.6

CREATE VIEW student_gpa AS
SELECT 
    s.ID AS student_id,
    COALESCE(
        SUM(gp.points * c.credits) / NULLIF(SUM(c.credits), 0),
    0) AS GPA
FROM 
    student s
LEFT JOIN 
    takes t ON s.ID = t.ID AND t.grade IS NOT NULL
LEFT JOIN 
    course c ON t.course_id = c.course_id
LEFT JOIN 
    grade_points gp ON t.grade = gp.grade
GROUP BY 
    s.ID;




--4.10
(
    SELECT a.name, a.address, a.title, b.salary
    FROM a LEFT JOIN b USING (name, address)
UNION
(
    SELECT b.name, b.address, a.title, b.salary
    FROM a RIGHT JOIN b USING (name, address)
LIMIT 0, 25;

--4.14
SELECT course_id, semester, year, sec_id, avg(tot_cred)
FROM takes NATURAL JOIN student
WHERE year = 2017
GROUP BY course_id, semester, year, sec_id
HAVING count(ID) >= 2;

--4.15 Can be rewritten using INNER JOIN with USING as follows:
SELECT *
FROM section INNER JOIN classroom
USING (building, room_number);

--4.16 4.16 Write an SQL query using the university schema to find the ID of each student who has never taken a course at the university. Do this using no subqueries and
--no set operations (use an outer join).

SELECT s.ID
FROM student s
LEFT JOIN takes t ON s.ID = t.ID
WHERE t.ID IS NULL;


--4.17
SELECT s.ID
FROM student s
LEFT JOIN advisor a ON s.ID = a.s_ID
WHERE a.s_ID IS NULL;


--4.18
SELECT employee_ID
FROM employee
WHERE manager_ID IS NULL;

--4.19
SELECT * 
FROM student NATURAL FULL OUTER JOIN takes 
NATURAL FULL OUTER JOIN course

--4.20
CREATE VIEW tot_credits(year, num_credits) AS
SELECT year, SUM(credits)
FROM takes NATURAL JOIN course
GROUP BY year;

