CREATE DATABASE EmployeeSalariesDB;
USE  EmployeeSalariesDB; 
CREATE TABLE employeeSalaries (
    employeeID INT PRIMARY KEY,
    departmentID INT NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);
INSERT INTO employeeSalaries (employeeID, departmentID, salary) VALUES
(1, 1, 5000000),
(2, 1, 6000000),
(3, 1, 5500000),

(4, 2, 4500000),
(5, 2, 4700000),

(6, 3, 7000000),
(7, 3, 7200000),
(8, 3, 6800000);
---Truy vấn tính tổng lương + lương trung bình theo phòng ban
SELECT
departmentID,
SUM(salary) AS totalSalary,
AVG(salary) AS avergeSalary
FROM employeeSalaries
GROUP BY departmentID;




