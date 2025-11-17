CREATE DATABASE Customers;
USE Customers;
CREATE TABLE Customers (
customerID INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL,
joinDate DATE);
CREATE TABLE Orders (
orderID INT PRIMARY KEY,
customerID INT NOT NULL,
orderDate DATETIME,
totalAmount DECIMAL(10,2) NOT NULL,
FOREIGN KEY (customerID) REFERENCES Customers(customerID));
--- them 4 khach hang vao customers
INSERT INTO Customers
(customerID, name, email, joinDate) VALUES
(1, 'Pham Thi Huyen', 'huyen@gmail.com', '2024-12-01'),
(2, 'Tran Thi Trung', 'trung@gmail.com', '2024-11-03'),
(3, 'Le Van An', 'an@gmail.com', '2024-9-23'),
(4, 'Pham Thi Duyen', 'duyen@gmail.com', '2024-12-10');
SELECT * FROM Customers;
---them 5 don hang vao orders ( lien ket customerID)
INSERT INTO Orders
( orderID, customerID, orderDate, totalAmount) VALUES
(1, 1, '2025-01-01', 100.00),
(2, 2, '2025-01-02', 200.00),
(3, 4, '2025-01-03', 300.00),
(4, 3, '2025-01-23', 400.00),
(5, 2, '2025-12-09', 500.00);
--cap nhat totalAmount don hang orderID=3 thanh 350
UPDATE Orders
SET totalAmount = 350
WHERE orderID = 3;
SELECT * FROM Orders;
-- cap nhat email khach hang CustomerID = 2
UPDATE Customers
SET email = 
'new_email_b@gmail.com'
WHERE customerID = 2;

--xoa khach hang customerID = 4
--vi co rang buoc FK, can xoa orders truoc.

SELECT * FROM Orders
WHERE customerID = 4;
--xoa cac don hang cua khach 4 truoc
DELETE FROM Orders
WHERE customerID = 4;
-- sau do moi xoa khach hang 4
DELETE FROM Customers 
WHERE customerID = 4;
--xoa don hang orderID = 1
DELETE FROM Orders
WHERE orderID = 1;
--lay tat ca don hang kem ten khach
SELECT o.orderID, o.orderDate, o.totalAmount, c.name AS customerName
FROM Orders o 
JOIN Customers c ON o.customerID = c.customerID;

---lay tong tung don hang cua tung khach (GROUP BY CustomerID)
SELECT customerID, 
SUM(totalAmount) AS 
totalSpent
FROM Orders
GROUP BY customerID;













