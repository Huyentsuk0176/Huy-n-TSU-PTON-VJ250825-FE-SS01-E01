
CREATE DATABASE IF NOT EXISTS companyDB;
USE companyDB;
CREATE TABLE departments (
    departmentID INT AUTO_INCREMENT PRIMARY KEY,
    departmentName VARCHAR(100)
);

CREATE TABLE employees (
    employeeID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    departmentID INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (departmentID) REFERENCES departments(departmentID)
);

INSERT INTO departments (departmentName)
VALUES ('Sales'), ('IT'), ('HR');

INSERT INTO employees (firstName, lastName, departmentID, salary)
VALUES
('Nguyen', 'Ngoc', 1, 1000),
('Tran', 'Mai', 2, 5000),
('Pham', 'Huyen', 2, 7000),
('Vo', 'Hanh', 3, 5000),
('Tran', 'Ngoc', 1, 6000);

SELECT * FROM employees;
show tables;
select e.employeeID, e.firstname, e.lastname, d.departmentname, e.salary
from employees e
join departments d on
e.departmentID = d.departmentID
where d.departmentname = 'IT';
update employees
set salary = 9000
where firstname = 'Pham' and lastname = 'Huyen';
delete from employees 
where salary <5000;
DESC employees;
set sql_safe_updates = 0;
select * from employees;