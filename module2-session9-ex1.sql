CREATE DATABASE Session9_ex1;
USE Session9_ex1;

CREATE TABLE Branch (
BranchID INT PRIMARY KEY AUTO_INCREMENT,
BranchName VARCHAR(100)NOT NULL,
Location VARCHAR(100),
PhoneNumber VARCHAR(20)
);
CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
FullName VARCHAR(100)NOT NULL,
Position VARCHAR(50),
Salary DECIMAL(15,0)NOT NULL,
HireDate DATE,
PhoneNumber VARCHAR(20),
BranchID INT,
CONSTRAINT fk_employees_branch
FOREIGN KEY(BranchID)REFERENCES Branch(BranchID)
);
DESC Employees;
INSERT INTO Branch(BranchName, Location, PhoneNumber)
VALUES
('Chi nhanh Ha Noi', 'Ha Noi', '024-111-222'),
('Chi nhanh Ho Chi Minh', 'Ho Chi Minh', '028-333-444'),
('Chi nhanh Da Nang', 'Da Nang', '0236-555-666');
INSERT INTO Employees(FullName, Position, Salary, HireDate, PhoneNumber, BranchID)
VALUES
('Nguyen Van A', 'Nhan Vien Ban Hang', 12000000,'2022-01-10','0901-111-111',1),
('Tran Thi B', 'Quan Ly', 20000000,'2021-05-15','0902-222-222',1),
('Le Van C', 'Nhan Vien Kho',15000000,'2023-03-20','0903-333-333',2),
('Pham Thi D','Ke Toan',18000000,'2020-07-01','0604-444-444',2),
('Hoang van E','Nhan Vien Ban Hang',9000000, '2024-01-05','0905-555-555',1);

CREATE VIEW EmployeeBranch AS
SELECT
   e.EmployeeID,
   e.FullName,
   e.Position,
   e.Salary,
   e.HireDate,
   b.BranchName,
   b.Location
   FROM Employees e
   JOIN Branch b
   ON e.BranchID = b.BranchID;
   SELECT database();
   SHOW TABLES;
   SHOW FULL TABLES WHERE Table_type = 'VIEW';
   SELECT * FROM Employees;
   SELECT * FROM Branch;
   select * from EmployeeBranch;
   
   DROP VIEW IF EXISTS HighSalaryEmployees;
   CREATE VIEW HighSalaryEmployees AS
   SELECT
       EmployeeID,
       FullName,
       Position,
       Salary,
       HireDate,
       PhoneNumber,
       BranchID
	FROM employees
    WHERE Salary >= 15000000
    WITH CHECK OPTION;
    
   INSERT INTO HighSalaryEmployees(FullName, Position, Salary, HireDate, PhoneNumber, BranchID) VALUES
   ('Pham Thi Huyen', 'Nhom Truong', 20000000, '2025-11-01', '0709-225-383',1);
   
   SHOW FULL TABLES WHERE Table_type = 'VIEW';
   SELECT * FROM EmployeeBranch;
   SELECT * FROM HighSalaryEmployees;
   
   ALTER VIEW EmployeeBranch AS
   SELECT
   e.EmployeeID, e.FullName, e.Position, e.Salary, e. HireDate, e.PhoneNumber AS EmployeePhone,
   b.BranchName,
   b.Location,
   b.PhoneNumber AS BranchPhone
   FROM Employees e
   JOIN Branch b
   ON e.BranchID=b.BranchID;
   SELECT * FROM EmployeeBranch;
   
   --xoa du lieu nhan vien thuoc chi nhanh ha noi
   DELETE e 
   FROM Employees e
   JOIN Branch b
   ON e.BranchID = b.BranchID
   WHERE b.BranchName='Chi nhanh Ha Noi';
   select * from Employees;
   select * from EmployeeBranch;
   
   
   
   
   
   
   
   
   



