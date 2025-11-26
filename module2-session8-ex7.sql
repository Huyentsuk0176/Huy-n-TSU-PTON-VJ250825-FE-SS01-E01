
CREATE DATABASE sesson8_ex6;
USE sesson8_ex6;

-- Bảng Customers: Thông tin khách hàng
CREATE TABLE Customers (
    CustomerID   INT PRIMARY KEY AUTO_INCREMENT,
    FirstName    VARCHAR(50)  NOT NULL,
    LastName     VARCHAR(50)  NOT NULL,
    Email        VARCHAR(100) NOT NULL
);

-- Bảng Promotions: Thông tin khuyến mãi
CREATE TABLE Promotions (
    PromotionID        INT PRIMARY KEY AUTO_INCREMENT,
    PromotionName      VARCHAR(100) NOT NULL,
    DiscountPercentage DECIMAL(5,2) NOT NULL  -- ví dụ: 10.00 = 10%
);

-- Bảng Products: Thông tin sản phẩm
CREATE TABLE Products (
    ProductID    INT PRIMARY KEY AUTO_INCREMENT,
    ProductName  VARCHAR(100)   NOT NULL,
    Price        DECIMAL(10,2)  NOT NULL,
    PromotionID  INT NULL,
    CONSTRAINT fk_products_promotions
        FOREIGN KEY (PromotionID) REFERENCES Promotions(PromotionID)
);

-- Bảng Orders: Đơn hàng
CREATE TABLE Orders (
    OrderID      INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID   INT        NOT NULL,
    OrderDate    DATETIME   NOT NULL,
    TotalAmount  DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Bảng OrderDetails: Chi tiết từng sản phẩm trong đơn
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID       INT NOT NULL,
    ProductID     INT NOT NULL,
    Quantity      INT NOT NULL,
    UnitPrice     DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_orderdetails_orders
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT fk_orderdetails_products
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Bảng Sales: Thông tin doanh thu (bán hàng)
CREATE TABLE Sales (
    SaleID      INT PRIMARY KEY AUTO_INCREMENT,
    OrderID     INT        NOT NULL,
    SaleDate    DATE       NOT NULL,
    SaleAmount  DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_sales_orders
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE INDEX idx_orders_customer ON Orders(CustomerID);
 
CREATE INDEX idx_orderdetails_order ON OrderDetails(OrderID);

CREATE INDEX idx_products_promotion ON Products(PromotionID);

CREATE UNIQUE INDEX idx_customers_email ON Customers(Email);

CREATE INDEX idx_orders_orderdate ON Orders(OrderDate);

-- Promotions
INSERT INTO Promotions (PromotionName, DiscountPercentage) VALUES
 ('New Year Promo',      10.00),
 ('Big Spender Promo',   15.00),
 ('VIP Customer Promo',  20.00);

-- Customers
INSERT INTO Customers (FirstName, LastName, Email) VALUES
 ('Anh',  'Nguyen', 'anh.nguyen@example.com'),
 ('Huong','Pham',   'huong.pham@example.com'),
 ('Tuan', 'Tran',   'tuan.tran@example.com');

-- Products
INSERT INTO Products (ProductName, Price, PromotionID) VALUES
 ('Laptop',      20000000, NULL),
 ('Mouse',        300000,  NULL),
 ('Keyboard',     800000,  1),   
 ('Monitor',     5000000,  NULL),
 ('Headphone',   1500000,  2);   

-- Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
 (1, '2025-11-20 10:00:00', 20500000),
 (2, '2025-11-21 15:30:00',  5300000),
 (3, '2025-11-22 18:45:00',  2000000);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
 (1, 1, 1, 20000000),  -- 1 Laptop
 (1, 2, 1,  300000),   -- 1 Mouse
 (2, 4, 1, 5000000),   -- 1 Monitor
 (2, 2, 1,  300000),   -- 1 Mouse
 (3, 3, 1,  800000),   -- 1 Keyboard
 (3, 5, 1, 1500000);   -- 1 Headphone


INSERT INTO Sales (OrderID, SaleDate, SaleAmount) VALUES
 (1, '2025-11-20', 20500000),
 (2, '2025-11-21',  5300000),
 (3, '2025-11-22',  2300000);

DELIMITER $$

CREATE PROCEDURE UpdateOrderTotalAndApplyPromotion (
    IN inOrderID INT,                 -- ID của đơn hàng
    IN inNewTotalAmount DECIMAL(10,2),-- Tổng doanh thu mới của đơn
    IN inRevenueThreshold DECIMAL(10,2) -- Ngưỡng doanh thu để áp dụng khuyến mãi
)
BEGIN
    -- 1. Cập nhật tổng doanh thu mới cho đơn hàng
    UPDATE Orders
    SET TotalAmount = inNewTotalAmount
    WHERE OrderID = inOrderID;

    -- 2. Nếu tổng mới >= ngưỡng, thêm một khuyến mãi vào bảng Promotions
    IF inNewTotalAmount >= inRevenueThreshold THEN
        INSERT INTO Promotions (PromotionName, DiscountPercentage)
        VALUES (
            CONCAT('High value order ', inOrderID), -- tên khuyến mãi (có thể đổi)
            10.00                                   -- % giảm giá ví dụ: 10%
        );
    END IF;
END$$

DELIMITER ;

