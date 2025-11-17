CREATE DATABASE SalesDB;
USE SalesDB;
CREATE TABLE Products (
productID INT PRIMARY KEY,
productName VARCHAR(100) NOT NULL,
price DECIMAL(10,2) NOT NULL);
CREATE TABLE Invoices (
invoiceID INT PRIMARY KEY, 
invoiceDate DATETIME NOT NULL,
customerName VARCHAR(100) NOT NULL);
CREATE TABLE InvoiceDetails (
detailID INT PRIMARY KEY,
invoiceID INT NOT NULL,
productID INT NOT NULL,
quantity INT NOT NULL,
price DECIMAL(10,2) NOT NULL,
FOREIGN KEY (invoiceID)
REFERENCES Invoices(invoiceID),
FOREIGN KEY  (productID)
REFERENCES Products (productID));
--them 3 san pham vao bang product 
INSERT INTO Products
(productID, productName, price) VALUES
(1, 'Milk tea',20.00),
(2, 'Coffee', 50.00),
(3, 'Fruit', 30.00); 
--them 2 hoa don vao bang invoices
INSERT INTO Invoices 
(invoiceID, invoiceDate, customerName) VALUES
(1, '2025-10-20', 'Nguyen Van A'),
(2, '2025-10-12', 'Nguyen Van B');
--them 4 chi tiet hoa don vao invoicedetail( lien ket hoa don +san pham)
INSERT INTO InvoiceDetails
(detailID, invoiceID, productID, quantity, price) VALUES
(1, 1, 1, 4, 30.00),
(2, 2, 3, 10, 40.00),
(3, 1, 1, 40, 50.00),
(4, 2, 2, 50, 60.00);
--Cap nhat gia san pham productID=1 thanh 55.00
UPDATE Products
SET price = 55.00
WHERE productID = 1;
--cap nhat so luong trong chi tiet hoa don detailID=2 thanh 10
UPDATE InvoiceDetails
SET quantity = 10
WHERE detailID = 2;
--Xóa chi tiết hóa đơn DetailID = 1
DELETE FROM InvoiceDetails
WHERE detailID = 1;
--SELECT – Truy vấn dữ liệu
(1) Lấy tổng giá trị hóa đơn (giá × số lượng) của từng hóa đơn
SELECT invoiceID,
       SUM(quantity * price) AS totalAmount
FROM InvoiceDetails
GROUP BY invoiceID;
--(2) Lấy danh sách tất cả sản phẩm trong từng hóa đơn, kèm số lượng và giá

SELECT i.invoiceID,
       i.customerName,
       p.productName,
       d.quantity,
       d.price,
       (d.quantity * d.price) AS subTotal
FROM Invoices i
JOIN InvoiceDetails d ON i.invoiceID = d.invoiceID
JOIN Products p ON d.productID = p.productID
ORDER BY i.invoiceID;









