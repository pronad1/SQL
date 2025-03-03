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

