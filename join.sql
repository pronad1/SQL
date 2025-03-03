--How and why a sql inner left right full and cross join returns the same row count? Illustrate example for Deleting duplicate rows in SQL.

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50)
);

CREATE TABLE Salaries (
    emp_id INT PRIMARY KEY,
    salary INT
);

-- Inner join
SELECT e.emp_id, e.emp_name, s.salary
FROM Employees e
INNER JOIN Salaries s ON e.emp_id = s.emp_id;

-- Left join
SELECT e.emp_id, e.emp_name, s.salary
FROM Employees e
LEFT JOIN Salaries s ON e.emp_id = s.emp_id;

-- Right join
SELECT e.emp_id, e.emp_name, s.salary
FROM Employees e
RIGHT JOIN Salaries s ON e.emp_id = s.emp_id;


-- Full join

SELECT e.emp_id, e.emp_name, s.salary
FROM Employees e
LEFT JOIN Salaries s ON e.emp_id = s.emp_id

UNION

SELECT e.emp_id, e.emp_name, s.salary
FROM Employees e
RIGHT JOIN Salaries s ON e.emp_id = s.emp_id;


-- Cross join
SELECT e.emp_id, e.emp_name, s.salary
FROM Employees e
CROSS JOIN Salaries s
WHERE e.emp_id = s.emp_id;

--Creating a Table with Duplicates
CREATE TABLE EmployeesDuplicate (
    emp_id INT,
    emp_name VARCHAR(50)
);

-- -- DELETE Using ROW_NUMBER()
-- with cte as (
--     SELECT * , row_number() over (partition by emp_id order by emp_id) as rn
--     from EmployeesDuplicate
-- )
-- DELETE FROM EmployeesDuplicate
-- WHERE emp_id IN (
--     SELECT emp_id
--     FROM (
--         SELECT emp_id, row_number() over (partition by emp_id order by emp_id) as rn
--         FROM EmployeesDuplicate
--     ) cte
--     WHERE rn > 1
-- );


-- Deleting duplicate rows in SQL
DELETE FROM Employees
WHERE emp_id NOT IN (
    SELECT MIN(emp_id)
    FROM Employees
    GROUP BY emp_name
);

--DELETE Using DISTINCT and Temporary Table
CREATE TABLE Temp_Employees AS 
SELECT DISTINCT * FROM EmployeesDuplicate;

DROP TABLE EmployeesDuplicate;
ALTER TABLE Temp_Employees RENAME TO EmployeesDuplicate;
