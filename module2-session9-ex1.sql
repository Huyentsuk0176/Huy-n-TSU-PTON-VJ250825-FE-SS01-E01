
CREATE DATABASE bank_view;
USE bank_view;
CREATE TABLE Branch (
    BranchID INT PRIMARY KEY AUTO_INCREMENT,
    BranchName VARCHAR(100),
    Location VARCHAR(255),
    PhoneNumber VARCHAR(15)
);
INSERT INTO Branch (BranchName, Location, PhoneNumber) VALUES
('Chi nhánh Hà Nội', '123 Trần Hưng Đạo', '0241234567'),
('Chi nhánh TP.HCM', '456 Lê Lợi', '0287654321'),
('Chi nhánh Đà Nẵng', '789 Nguyễn Văn Linh', '0236123456');
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(15,2),
    HireDate DATE,
    PhoneNumber VARCHAR(15),
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);
INSERT INTO Employees (FullName, Position, Salary, HireDate, PhoneNumber, BranchID) VALUES
('Nguyễn Văn An', 'Giám đốc', 45000000, '2018-03-10', '0911111111', 1),
('Phạm Hoàng Kiên', 'Sale', 18000000, '2023-05-12', '0922222222', 1),
('Trần Thị Hạnh', 'Giao dịch viên', 15000000, '2021-06-20', '0933333333', 2),
('Đặng Hữu Bình', 'Quản lý', 32000000, '2023-06-12', '0944444444', 2),
('Lê Minh Tuấn', 'Kế toán', 10000000, '2022-01-05', '0955555555', 3);
SELECT * FROM Branch;
SELECT * FROM Employees;
CREATE VIEW EmployeeBranch AS
SELECT 
    e.EmployeeID,
    e.FullName AS EmployeeName,
    e.Position,
    e.Salary,
    e.HireDate,
    e.PhoneNumber AS EmployeePhone,
    b.BranchName,
    b.Location,
    b.PhoneNumber AS BranchPhone
FROM Employees e
JOIN Branch b
ON e.BranchID = b.BranchID;
CREATE VIEW HighSalaryEmployees AS
SELECT *
FROM Employees
WHERE Salary >= 15000000
WITH CHECK OPTION;
SELECT * FROM EmployeeBranch;
SELECT * FROM HighSalaryEmployees;

DELETE e
FROM Employees e
JOIN Branch b
ON e.BranchID = b.BranchID
WHERE b.BranchName = 'Chi nhánh Hà Nội';

SELECT * 
FROM Employees e
JOIN Branch b
ON e.BranchID = b.BranchID;








   
   
   




