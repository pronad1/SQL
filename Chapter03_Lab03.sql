--3.1
SELECT sec_id, course_id, COUNT(ID) AS enrollment 
FROM takes 
WHERE semester = 'Fall' AND year = 2017 
GROUP BY sec_id, course_id;
