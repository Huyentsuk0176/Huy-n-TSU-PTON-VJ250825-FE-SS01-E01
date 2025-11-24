
CREATE DATABASE session7_ex5;
USE session7_ex5;

CREATE TABLE customers (
    customerID   INT AUTO_INCREMENT PRIMARY KEY,
    firstName    VARCHAR(50)  NOT NULL,
    lastName     VARCHAR(50)  NOT NULL,
    email        VARCHAR(100)
);

CREATE TABLE orders (
    orderID      INT AUTO_INCREMENT PRIMARY KEY,
    customerID   INT          NOT NULL,
    orderDate    DATE,
    totalAmount  DECIMAL(10,2),
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customerID) REFERENCES customers(customerID)
);

CREATE TABLE products (
    productID    INT AUTO_INCREMENT PRIMARY KEY,
    productName  VARCHAR(100) NOT NULL,
    price        DECIMAL(10,2) NOT NULL
);

CREATE TABLE orderItems (
    orderItemID  INT AUTO_INCREMENT PRIMARY KEY,
    orderID      INT NOT NULL,
    productID    INT NOT NULL,
    quantity     INT,
    price        DECIMAL(10,2),   -- đơn giá tại thời điểm mua
    CONSTRAINT fk_orderItems_order
        FOREIGN KEY (orderID) REFERENCES orders(orderID),
    CONSTRAINT fk_orderItems_product
        FOREIGN KEY (productID) REFERENCES products(productID)
);


CREATE TABLE sales (
    saleID       INT AUTO_INCREMENT PRIMARY KEY,
    orderID      INT NOT NULL,
    saleDate     DATE,
    saleAmount   DECIMAL(10,2),
    CONSTRAINT fk_sales_order
        FOREIGN KEY (orderID) REFERENCES orders(orderID)
);

CREATE VIEW CustomerOrderSummary AS
SELECT 
    c.customerID,
    CONCAT(c.firstName, ' ', c.lastName) AS CustomerName,
    COUNT(o.orderID) AS TotalOrders,
    SUM(o.totalAmount) AS TotalAmountSpent
FROM customers c
LEFT JOIN orders o ON c.customerID = o.customerID
GROUP BY c.customerID, c.firstName, c.lastName;
SHOW FULL TABLES WHERE Table_type = 'VIEW';

SELECT *
FROM CustomerOrderSummary
WHERE TotalAmountSpent > 5000;
