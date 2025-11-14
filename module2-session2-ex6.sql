CREATE DATABASE module2;
USE module2;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
-- TẠO BẢNG CUSTOMERS
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

-- TẠO BẢNG ORDERS
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- TẠO BẢNG ORDERDETAILS
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
INSERT INTO Customers (CustomerName, Email, Phone)
VALUES
('Nguyen Van A', 'a@gmail.com', '0901111111'),
('Tran Thi B', 'b@gmail.com', '0902222222');
INSERT INTO Orders (OrderDate, CustomerID)
VALUES
('2025-01-01', 1),
('2025-01-03', 1),
('2025-01-05', 2);
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 101, 2, 120.00),
(1, 102, 1, 80.00),
(2, 103, 3, 50.00),
(3, 101, 1, 120.00),
(3, 105, 4, 30.00);
DESCRIBE OrderDetails;
--cap nhat du lieu
UPDATE Customers
SET Phone = '0988888888'
WHERE CustomerID = 1;
--xoa du lieu 
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Orders
WHERE CustomerID NOT IN (SELECT CustomerID FROM Customers);
SET SQL_SAFE_UPDATES = 1;
--Danh sach khach va tong so don hang
SELECT 
    C.CustomerID,
    C.CustomerName,
    COUNT(O.OrderID) AS TotalOrders
FROM Customers C
LEFT JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName;
--chi tiet don hang + tong tien tung dong
SELECT 
    O.OrderID,
    OD.ProductID,
    OD.Quantity,
    OD.UnitPrice,
    (OD.Quantity * OD.UnitPrice) AS TotalAmount
FROM OrderDetails OD
JOIN Orders O 
    ON OD.OrderID = O.OrderID
ORDER BY O.OrderID;









