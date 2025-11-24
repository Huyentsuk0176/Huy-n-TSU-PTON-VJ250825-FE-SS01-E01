CREATE DATABASE session7_ex4;
USE session7_ex4;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    CreatedAt DATETIME DEFAULT NOW()
);


CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(255) NOT NULL,
    Category VARCHAR(255),
    Price DECIMAL(10,2) NOT NULL
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT NOW(),
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


INSERT INTO Customers (CustomerName, Email, Phone) VALUES
('Nguyen Van A', 'a@gmail.com', '0901112222'),
('Tran Thi B', 'b@gmail.com', '0903334444'),
('Le Van C', 'c@gmail.com', '0905556666');

INSERT INTO Products (ProductName, Category, Price) VALUES
('Iphone 15', 'Điện thoại', 25000),
('Samsung S23', 'Điện thoại', 20000),
('AirPods Pro', 'Âm thanh', 5000);

INSERT INTO Orders (CustomerID, TotalAmount) VALUES
(1, 30000),
(2, 15000),
(3, 5000);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 25000),   -- iPhone
(1, 3, 1, 5000),    -- AirPods
(2, 2, 1, 15000),   -- Samsung S23
(3, 3, 1, 5000);    -- AirPods

CREATE OR REPLACE VIEW CustomerOrders AS
SELECT 
    o.OrderID,
    c.CustomerName,
    o.OrderDate,
    o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;
SHOW CREATE VIEW CustomerOrders;


UPDATE CustomerOrders
SET TotalAmount = 250.00
WHERE OrderID = 1;
select * from CustomerOrders;


