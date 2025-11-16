CREATE DATABASE Suppliers;
USE Suppliers;
CREATE TABLE Suppliers (
supplierID INT PRIMARY KEY,
supplierName VARCHAR(100) NOT NULL,
contactEmail VARCHAR(100) NOT NULL);
CREATE TABLE Products (
productID INT PRIMARY KEY,
productName VARCHAR(100) NOT NULL,
supplierID INT,
price DECIMAL(10,2) NOT NULL,
FOREIGN KEY ( supplierID)
REFERENCES Suppliers ( supplierID));
---them 3 nha cung cap
INSERT INTO Suppliers
(supplierID, supplierName, contactEmail) VALUES
( 1, 'Rakuten Co.', 'rakuten@gmail.com'),
( 2, 'GobalWorld', 'gobal@gmail.com'),
( 3, 'MegaCar', 'mega@gmail.com');
SELECT * FROM Suppliers;
--them 4 san pham products co lien ket supplierid
INSERT INTO Products (productID, productName, supplierID, price) VALUES
(1, 'Noveda laptop', 1, 900.00),
(2, 'Mouse Ultra', 2, 1000.00),
(3, 'Monitor', 3, 2000.00),
(4, 'Keyboard', 1, 300.00);
SELECT * FROM Products;
-- cap nhat gia productID = 2 thanh 45.99
UPDATE Products
SET price = 45.99
WHERE productID = 2;
--cap nhat ten nha cung cap supplierID = 1
UPDATE Suppliers
SET supplierName = 'Premium Tech Supply'
WHERE supplierID = 1;
--xoa san pham lien quan supplierID = 3. vi rang buoc foreign key nen phai xoa products
DELETE FROM Products
WHERE supplierID = 3;

--sau do xoa supplier 

DELETE FROM Suppliers
WHERE supplierID = 3;

SELECT * FROM Products;
SELECT * FROM Suppliers;
--xoa san pham co productID = 4

DELETE FROM Products
WHERE productID = 4;

SELECT * FROM Products;
SELECT * FROM Suppliers;



















