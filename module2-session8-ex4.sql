
DELIMITER //

CREATE PROCEDURE DeleteOrderAndSales(
    IN inOrderID INT
)
BEGIN
    DELETE FROM Sales
    WHERE OrderID = inOrderID;

    DELETE FROM Orders
    WHERE OrderID = inOrderID;
END //

DELIMITER ;
