CREATE DATABASE session7_ex3;
USE session7_ex3;

CREATE TABLE Customers (
    customerID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE Products (
    productID INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    orderID INT AUTO_INCREMENT PRIMARY KEY,
    customerID INT NOT NULL,
    orderDate DATE,
    totalAmount DECIMAL(10,2),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID)
);

CREATE TABLE OrderItems (
    orderItemID INT AUTO_INCREMENT PRIMARY KEY,
    orderID INT NOT NULL,
    productID INT NOT NULL,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (orderID) REFERENCES Orders(orderID),
    FOREIGN KEY (productID) REFERENCES Products(productID)
);

CREATE INDEX idx_orderID ON OrderItems(orderID);
SHOW INDEX FROM OrderItems;


