--3.1
--a.Find the titles of courses in the Comp. Sci. department that have 3 credits. 
SELECT title
sec_id, course_id, COUNT(ID) AS enrollment 
FROM takes 
WHERE semester = 'Fall' AND year = 2017 
GROUP BY sec_id, course_id;

--b. Find the IDs of all students who were taught by an instructor named Einstein; make sure there are no duplicates in the result.
SELECT DISTINCT takes.ID 
FROM takes 
JOIN teaches ON takes.course_id = teaches.course_id 
    AND takes.sec_id = teaches.sec_id 
    AND takes.semester = teaches.semester 
    AND takes.year = teaches.year 
JOIN instructor ON teaches.ID = instructor.ID 
WHERE instructor.name = 'Einstein';

--c . Find the highest salary of any instructor. 
SELECT MAX(salary) AS highest_salary 
FROM instructor;

--d. Find all instructors earning the highest salary (there may be more than one with the same salary). 
SELECT name, salary 
FROM instructor 
WHERE salary = (SELECT MAX(salary) FROM instructor);

--e. Find the enrollment of each section that was offered in Fall 2017.
SELECT sec_id, course_id, COUNT(ID) AS enrollment 
FROM takes 
WHERE semester = 'Fall' AND year = 2007 
GROUP BY sec_id, course_id;

-- f. Find the maximum enrollment, across all sections, in Fall 2017.
SELECT MAX(enrollment) AS max_enrollment 
FROM ( 
    SELECT sec_id, course_id, COUNT(ID) AS enrollment 
    FROM takes 
    WHERE semester = 'Fall' AND year = 2007 
    GROUP BY sec_id, course_id
) AS section_enrollment;

--g.. Find the sections that had the maximum enrollment in Fall 2017.
SELECT sec_id, course_id, COUNT(ID) AS enrollment 
FROM takes 
WHERE semester = 'Fall' AND year = 2007 
GROUP BY sec_id, course_id 
HAVING COUNT(ID) = ( 
    SELECT MAX(enrollment) 
    FROM ( 
        SELECT sec_id, course_id, COUNT(ID) AS enrollment 
        FROM takes 
        WHERE semester = 'Fall' AND year = 2007 
        GROUP BY sec_id, course_id
    ) AS section_enrollment
);


--3.2
--a. Find the total grade points earned by the student with ID '12345', across all courses taken by the student
--Find the grade point average (GPA) for the above student, that is, the total grade points divided by the total credits for the associated courses. 

--3.3
--a. Increase the salary of each instructor in the Comp. Sci. department by 10%. 


--3.11
--a. Find the ID and name of each student who has taken at least one Comp. Sci. course; make sure there are no duplicate names in the result. 
SELECT DISTINCT s.ID, s.name
FROM student s
JOIN enrollment e ON s.ID = e.student_ID
JOIN course c ON e.course_ID = c.ID
WHERE c.department = 'Comp. Sci.';
--b. Find the ID and name of each student who has not taken any course offered before 2017. 
SELECT s.ID, s.name
FROM student s
WHERE NOT EXISTS (SELECT 1
                  FROM enrollment e
                  JOIN course c ON e.course_ID = c.ID
                  WHERE e.student_ID = s.ID
                    AND c.year < 2017);
--c. For each department, find the maximum salary of instructors in that department. You may assume that every department has at least one instructor. 
SELECT d.dept_name, MAX(i.salary) AS max_salary
FROM department d
JOIN instructor i ON d.dept_name = i.dept_name
GROUP BY d.dept_name;
--d. Find the lowest, across all departments, of the per-department maximum salary computed by the preceding query.
SELECT MIN(max_salary) AS lowest_max_salary
FROM (
    SELECT MAX(i.salary) AS max_salary
    FROM department d
    JOIN instructor i ON d.dept_name = i.dept_name
    GROUP BY d.dept_name
) AS department_max_salaries;


--3.12 

--3.28 Using the university schema, write an SQL query to find the names and IDs of those instructors who teach every course taught in his or her department (i.e., every course that appears in the course relation with the instructor’s department name). Order result by name. 
SELECT i.ID, i.name
FROM instructor i
WHERE NOT EXISTS (
    SELECT c.course_id
    FROM course c
    WHERE c.dept_name = i.dept_name
    AND NOT EXISTS (
        SELECT 1
        FROM teaches t
        WHERE t.course_id = c.course_id
        AND t.ID = i.ID
    )
)
ORDER BY i.name;


--3.31  Using the university schema, write an SQL query to find the ID and name of each instructor who has never given an A grade in any course she or he has taught. (Instructors who have never taught a course trivially satisfy this condition.) 
SELECT i.ID, i.name
FROM instructor i
WHERE NOT EXISTS (
    SELECT 1
    FROM teaches t
    JOIN takes tk ON t.course_id = tk.course_id
                AND t.sec_id = tk.sec_id
                AND t.semester = tk.semester
                AND t.year = tk.year
    WHERE t.ID = i.ID AND tk.grade = 'A'
);
