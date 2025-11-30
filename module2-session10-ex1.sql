CREATE DATABASE InventoryManagement;
USE InventoryManagement;
SHOW TABLES;


CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    Quantity INT NOT NULL
);

CREATE TABLE InventoryChanges (
    ChangeID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    OldQuantity INT,
    NewQuantity INT,
    ChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP
);
DROP TRIGGER IF EXISTS AfterProductUpdate;

INSERT INTO Products (ProductName, Quantity)
VALUES 
('Bánh Matcha', 50),
('Bánh Hạt Dẻ', 100);
select * from products;

DELIMITER $$

CREATE TRIGGER AfterProductUpdate
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF OLD.Quantity <> NEW.Quantity THEN
        INSERT INTO InventoryChanges (ProductID, OldQuantity, NewQuantity)
        VALUES (OLD.ProductID, OLD.Quantity, NEW.Quantity);
    END IF;
END$$

DELIMITER ;

    
    UPDATE products
    SET Quantity = 80
    WHERE ProductID = 1;
    
    SELECT * FROM InventoryChanges;




