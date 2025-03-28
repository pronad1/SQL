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
