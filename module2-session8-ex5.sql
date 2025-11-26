DELIMITER //

CREATE PROCEDURE GetMonthlyRevenueByCustomer(
    IN inCustomerID INT,
    IN inMonthYear VARCHAR(7)   -- ví dụ '2024-07'
)
BEGIN
    SELECT 
        SUM(S.SaleAmount) AS TotalRevenue
    FROM Sales S
    JOIN Orders O ON S.OrderID = O.OrderID
    WHERE O.CustomerID = inCustomerID
      AND DATE_FORMAT(S.SaleDate, '%Y-%m') = inMonthYear;
END //

DELIMITER ;

CALL GetMonthlyRevenueByCustomer(1, '2024-07');
