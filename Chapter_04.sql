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
SELECT student.* , takes.*
FROM student 
LEFT JOIN takes 
ON student.ID = takes.ID;

--b
SELECT student.*, takes.*
FROM student 
LEFT JOIN takes 
ON student.ID = takes.ID

UNION

SELECT student.*, takes.*
FROM student 
RIGHT JOIN takes 
ON student.ID = takes.ID;


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


