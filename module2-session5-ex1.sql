CREATE DATABASE CustomerOrderDB;
USE CustomerOrderDB;
CREATE TABLE customers (
    customerID INT PRIMARY KEY,
    customerName VARCHAR(100) NOT NULL,
    contactEmail VARCHAR(100) NOT NULL
);
CREATE TABLE orders (
    orderID INT PRIMARY KEY,
    customerID INT NOT NULL,
    orderDate DATE NOT NULL,
    totalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customerID) REFERENCES customers(customerID)
);
--Thêm dữ liệu mẫu (để JOIN thử)
INSERT INTO customers VALUES
(1, 'Nguyen Van A', 'a@gmail.com'),
(2, 'Tran Thi B', 'b@gmail.com'),
(3, 'Pham Van C', 'c@gmail.com');

INSERT INTO orders VALUES
(101, 1, '2024-05-10', 500000),
(102, 2, '2024-05-11', 750000),
(103, 1, '2024-05-12', 300000);
---JOIN lấy tên + email + đơn hàng
SELECT 
    o.orderID,
    c.customerName,
    c.contactEmail,
    o.orderDate,
    o.totalAmount
FROM orders o
JOIN customers c
ON o.customerID = c.customerID;





