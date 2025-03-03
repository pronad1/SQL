--How and why a sql inner left right full and cross join returns the same row count? Illustrate example for Deleting duplicate rows in SQL.

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50)
);

CREATE TABLE Salaries (
    emp_id INT PRIMARY KEY,
    salary INT
);
