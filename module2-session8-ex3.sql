
CREATE DATABASE session8_ex3;
USE session8_ex3;

CREATE TABLE Promotions (
    PromotionID INT PRIMARY KEY AUTO_INCREMENT,
    PromotionName VARCHAR(100) NOT NULL,
    DiscountPercentage DECIMAL(5,2)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    PromotionID INT,
    FOREIGN KEY (PromotionID) REFERENCES Promotions(PromotionID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
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

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
CREATE INDEX idx_orders_customerID ON Orders(CustomerID);
show index from Orders;
CREATE INDEX idx_orderdetails_orderID on OrderDetails(OrderID);
CREATE INDEX idx_products_promotionID ON Products(PromotionID);
CREATE INDEX idx_sales_orderID ON Sales(OrderID);

-- Promotions
INSERT INTO Promotions (PromotionName, DiscountPercentage)
VALUES 
('Summer Sale', 10),
('Black Friday', 20),
('No Promo', 0);

-- Customers
INSERT INTO Customers (FirstName, LastName, Email)
VALUES
('Huyen', 'Pham', 'huyen@gmail.com'),
('Minh', 'Nguyen', 'minh@gmail.com');

-- Products
INSERT INTO Products (ProductName, Price, PromotionID)
VALUES
('Banh Mi', 30.00, 1),
('Tra Sua', 50.00, 2),
('Cafe', 40.00, 3);

-- Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
(1, NOW(), 0),
(2, NOW(), 0);

-- Order Details
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 2, 30.00),
(1, 3, 1, 40.00),
(2, 2, 1, 50.00);

-- STORED PROCEDURE
DROP PROCEDURE IF EXISTS UpdateOrderTotalAmount;

DELIMITER //

CREATE PROCEDURE UpdateOrderTotalAmount(
    IN inOrderID INT,
    IN inNewTotalAmount DECIMAL(10,2)
)
BEGIN
    UPDATE Orders
    SET TotalAmount = inNewTotalAmount
    WHERE OrderID = inOrderID;
END //

DELIMITER ;

CALL UpdateOrderTotalAmount(1, 200.50);

SELECT * FROM Orders WHERE OrderID = 1;



SHOW PROCEDURE STATUS LIKE 'UpdateTotalAmount';


CALL UpdateOrderTotalAmount(1, 200.50);
 SELECT * FROM Orders WHERE OrderID = 1;
