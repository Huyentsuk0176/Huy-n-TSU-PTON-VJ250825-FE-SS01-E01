USE InventoryManagement;
CREATE TABLE IF NOT EXISTS InventoryChangeHistory (
    historyID INT AUTO_INCREMENT PRIMARY KEY,
    productID INT NOT NULL,
    oldQuantity INT,
    newQuantity INT,
    changeType ENUM('INCREASE','DECREASE'),
    changeDate DATETIME,
    FOREIGN KEY (productID) REFERENCES Products(productID)
);
ALTER TABLE InventoryChangeHistory
MODIFY changeType ENUM('INCREASE','DECREASE') NULL;

DROP TRIGGER IF EXISTS AfterProductUpdateHistory;
DELIMITER $$

CREATE TRIGGER AfterProductUpdateHistory
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO InventoryChangeHistory
    (productID, oldQuantity, newQuantity, changeType, changeDate)
    VALUES
    (
        OLD.productID,
        OLD.quantity,
        NEW.quantity,
        CASE
            WHEN NEW.quantity > OLD.quantity THEN 'INCREASE'
            WHEN NEW.quantity < OLD.quantity THEN 'DECREASE'
            ELSE NULL
        END,
        NOW()
    );
END$$

DELIMITER ;
UPDATE Products
SET quantity = quantity + 10
WHERE productID = 1;
select * from Products;

--Nếu bảng Products trống → thêm 1 record test:
INSERT INTO Products (productName, quantity)
VALUES ('Test Product', 100);
select * from Products;
UPDATE Products
SET quantity = 120
WHERE productID = 1;
SELECT * FROM InventoryChangeHistory;
show triggers;















    
    
    
    
    
    



