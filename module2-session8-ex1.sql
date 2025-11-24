create database session8_ex1;
use session8_ex1;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100)
);

CREATE TABLE Promotions (
    PromotionID INT PRIMARY KEY AUTO_INCREMENT,
    PromotionName VARCHAR(100),
    DiscountPercentage DECIMAL(5,2)
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
    TotalAmount DECIMAL(10,2),
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

INSERT INTO Customers (FirstName, LastName, Email) VALUES
('Nguyen', 'An', 'an@gmail.com'),
('Tran', 'Binh', 'binh@gmail.com'),
('Le', 'Chi', 'chi@gmail.com');

INSERT INTO Promotions (PromotionName, DiscountPercentage) VALUES
('Summer Sale', 10),
('Black Friday', 20),
('No Promotion', 0);

INSERT INTO Products (ProductName, Price, PromotionID) VALUES
('Laptop Lenovo', 1500.00, 1),
('Iphone 15', 1200.00, 2),
('AirPods Pro', 250.00, 3),
('Samsung Monitor', 300.00, NULL);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-01-10', 0),
(1, '2024-03-05', 0),
(2, '2024-02-20', 0),
(3, '2024-05-15', 0);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
-- Order 1 (customer 1)
(1, 1, 1, 1500.00),
(1, 3, 2, 250.00),

-- Order 2 (customer 1)
(2, 2, 1, 1200.00),

-- Order 3 (customer 2)
(3, 4, 2, 300.00),

-- Order 4 (customer 3)
(4, 1, 1, 1500.00),
(4, 2, 1, 1200.00);

DELIMITER $$

CREATE PROCEDURE GetCustomerTotalRevenue (
    IN inCustomerID INT,
    IN inStartDate DATE,
    IN inEndDate DATE
)
BEGIN
    SELECT 
        SUM(od.Quantity * od.UnitPrice * (1 - IFNULL(p.DiscountPercentage, 0)/100)) AS TotalRevenue
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products pr ON od.ProductID = pr.ProductID
    LEFT JOIN Promotions p ON pr.PromotionID = p.PromotionID
    WHERE 
        o.CustomerID = inCustomerID
        AND o.OrderDate BETWEEN inStartDate AND inEndDate;
END$$

DELIMITER ;

CALL GetCustomerTotalRevenue(1, '2024-01-01', '2024-12-31');









