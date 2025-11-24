CREATE DATABASE session7_ex2;
USE session7_ex2;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    CreatedAt DATETIME
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Category VARCHAR(255),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    TotalAmount DECIMAL(10,2) NOT NULL,
    CreatedAt DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE VIEW CustomerOrders AS
SELECT 
    o.OrderID,
    c.CustomerName,
    o.CreatedAt AS OrderDate,
    o.TotalAmount
FROM Orders o
JOIN Customers c 
    ON o.CustomerID = c.CustomerID
WITH CASCADED CHECK OPTION;
select * from customerorders;





