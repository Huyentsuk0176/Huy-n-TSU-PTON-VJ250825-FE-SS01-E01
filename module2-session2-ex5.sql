CREATE DATABASE IF NOT EXISTS RetailDB;
USE RetailDB;

-- BẢNG PRODUCTS
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    StockQuantity INT
);

-- BẢNG ORDERS
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATE,
    ProductID INT,
    Quantity INT,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
--chen 3 san pham vao Products
INSERT INTO Products (ProductName, Category, Price, StockQuantity)
VALUE ('Monblanc cake', 'Desert', 200, 50), ('Obazai', 'Food', 80, 100), ('tea-milk', 'Drink', 20, 90);
SELECT * FROM Orders;
--cap nhat gia mot san pham cu the
UPDATE Products
SET Price = 25
WHERE ProductName = 'tea-milk';
--them mot don hang vao orders
INSERT INTO Orders ( OrderDate, ProductID, Quantity)
VALUE ('2025-11-13', 1, 3);
--tinh totalamount=quantity*price
UPDATE Orders o
JOIN Products p ON o.ProductID = p.ProductID
SET o.TotalAmount = o.Quantity * p.Price;
SELECT * FROM Orders;
--lay danh sach san pham + ton kho
SELECT ProductID, ProductName, Category, Price, StockQuantity
FROM Products;
--lay danh sach don hang+ten san pham+so luong+tong tien\
SELECT
o.OrderID,
o.OrderDate,
p.ProductName,
o.Quantity,
o.TotalAmount
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID;





