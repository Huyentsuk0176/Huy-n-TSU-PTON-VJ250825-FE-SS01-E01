create database session8_ex2;
use session8_ex2;
---Customers, Products, Orders, OrderDetails, Promotions, Sales
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Promotions (
    PromotionID INT AUTO_INCREMENT PRIMARY KEY,
    PromotionName VARCHAR(100) NOT NULL,
    DiscountPercentage DECIMAL(5,2) NOT NULL
);
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    PromotionID INT,
    FOREIGN KEY (PromotionID) REFERENCES Promotions(PromotionID)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10,2) NOT NULL
);

create index idx_customer_email on Customers(Email);
create index idx_orders_customer on Orders(CustomerID);
create index idx_orderdetails_product on OrderDetails(ProductID);
create index idx_products_promotion on Products(PromotionID);

DROP PROCEDURE IF EXISTS AddNewCustomer;
DELIMITER $$

create procedure AddNewCustomer (
in inFirstName varchar(50),
in inLastName varchar(50),
in inEmail varchar(100)
)
begin
insert into Customers (FirstName, LastName, Email)
values (inFirstName, inLastName, Email);
end $$

DELIMITER ;


CALL AddNewCustomer('Huyen', 'Pham', 'huyen@gmail.com');

select * from Customers;











