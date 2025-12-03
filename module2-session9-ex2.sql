CREATE DATABASE BankManagement;
USE BankManagement;
CREATE TABLE Branch (
    BranchID INT PRIMARY KEY AUTO_INCREMENT,
    BranchName VARCHAR(100) NOT NULL,
    Location VARCHAR(150),
    PhoneNumber VARCHAR(20) UNIQUE
);
DESCRIBE Branch;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(12,2),
    HireDate DATE,
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100),
    DateOfBirth DATE,
    Address VARCHAR(200),
    PhoneNumber VARCHAR(20) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    AccountType ENUM('Saving', 'Checking'),
    Balance DECIMAL(15,2) DEFAULT 0,
    OpenDate DATE,
    BranchID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    LoanType ENUM('Home', 'Car', 'Business', 'Personal'),
    LoanAmount DECIMAL(15,2),
    InterestRate DECIMAL(5,2),
    LoanTerm INT,
    StartDate DATE,
    Status ENUM('Active','Completed','Cancelled'),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT,
    TransactionType ENUM('Deposit', 'Withdraw', 'Transfer'),
    Amount DECIMAL(15 , 2 ),
    TransactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AccountID)
        REFERENCES Accounts (AccountID)
);
SHOW TABLES;
INSERT INTO Branch (BranchName, Location, PhoneNumber)
VALUES ('Tokyo Branch','Shibuya','0312345678');
INSERT INTO Customers (FullName, DateOfBirth, Address, PhoneNumber, Email, BranchID)
VALUES 
('Nguyen Van A','1995-05-20','Tokyo','0909998888','a@gmail.com',1),
('Tran Thi B','1996-06-20','Tokyo','0907776666','b@gmail.com',1);
INSERT INTO Employees (FullName, Position, Salary, HireDate, BranchID)
VALUES
('Employee One','Staff',9000000,'2022-01-01',1),
('Employee Two','Manager',15000000,'2020-01-01',1);
INSERT INTO Accounts (CustomerID, AccountType, Balance, OpenDate, BranchID)
VALUES
(1,'Saving',5000000,'2024-01-01',1),
(2,'Checking',3000000,'2024-02-01',1);
select * from Branch;
select * from Employees;
select * from Accounts;
--tao single-column index (phonenumber-customers)
create index idx_customers_phone
on Customers(PhoneNumber);
--kiem tra bang explain
explain 
select * from Customers
where PhoneNumber = '0909998888';
---tao composite index
create index
idx_employees_branch_salary
on Employees(BranchID, Salary);
explain 
select * from employees
where BranchID = 1 and Salary > 1000000;

create unique index
idx_accounts_unique
on Accounts(AccountID, CustomerID);

insert into Accounts(AccountID, CustomerID, AccountType, Balance, OpenDate, BranchID)
values
(1, 1, 'Saving', 100, '2024-03-01',1);

SHOW INDEX FROM Customers;
SHOW INDEX FROM Employees;
SHOW INDEX FROM Accounts;

DROP INDEX idx_customers_phone ON Customers;
DROP INDEX idx_employees_branch_salary ON Employees;
DROP INDEX idx_accounts_unique ON Accounts;

show create table Employees; 
show create table Customers; 
show create table Accounts; 

















