-- employees database
-- created at: <022021>
-- author: <Matt Hurt>

-- TODO: create database employees
CREATE TABLE Employees (
	id INT AUTO_INCREMENT PRIMARY KEY, -- Auto increments each row of id
    name VARCHAR(30) NOT NULL
    );

INSERT INTO Employees (name) VALUES 
	("Matt"), 	-- id 1
    ("James"), 	-- id 2
    ("Rob"), 	-- id 3
    ("Mary"); 	-- id 4
    
-- TODO: create table departments

-- TODO: populate table departments

-- TODO: create table employees

-- TODO: populate table Employees

-- TODO: a) list all rows in Departments.

-- TODO: b) list only the codes in Departments.

-- TODO: c) list all rows in Employees.

-- TODO: d) list only the names in Employees in alphabetical order.

-- TODO: e) list only the names and salaries in Employees, from the highest to the lowest salary.

-- TODO: f) list the cartesian product of Employees and Departments.

-- TODO: g) do the natural join of Employees and Departments; the result should be exactly the same as the cartesian product; do you know why?

-- TODO: i) do an equi join of Employees and Departments matching the rows by Employees.deptCode and Departments.code (hint: use JOIN and the ON clause).

-- TODO: j) same as previous query but project name and salary of the employees plus the description of their departments.

-- TODO: k) same as previous query but only the employees that earn less than 60000.

-- TODO: l) same as query ‘i’  but only the employees that earn more than ‘Jose Caipirinha’.

-- TODO: m) list the left outer join of Employees and Departments (use the ON clause to match by department code); how does the result of this query differs from query ‘i’?

-- TODO: n) from query ‘m’, how would you do the left anti-join?

-- TODO: o) show the number of employees per department.

-- TODO: p) same as query ‘o’ but I want to see the description of each department (not just their codes).
