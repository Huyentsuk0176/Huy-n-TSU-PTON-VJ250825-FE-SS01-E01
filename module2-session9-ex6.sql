
--Bài hát có giá > 0.99, kết hợp Track – Album – Artist

CREATE VIEW View_Track_Details AS
SELECT 
    t.TrackId,
    t.Name AS Track_Name,
    a.Title AS Album_Title,
    ar.Name AS Artist_Name,
    t.UnitPrice
FROM Track t
JOIN Album a ON t.AlbumId = a.AlbumId
JOIN Artist ar ON a.ArtistId = ar.ArtistId
WHERE t.UnitPrice > 0.99;

SELECT * FROM View_Track_Details;

-- View_Customer_Invoice
--employeeChỉ lấy khách có tổng chi tiêu > 50

CREATE VIEW View_Customer_Invoice AS
SELECT 
    c.CustomerId,
    c.FirstName,
    c.LastName,
    c.Email,
    e.FirstName AS Employee_FirstName,
    e.LastName AS Employee_LastName,
    SUM(i.Total) AS Total_Spending
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
JOIN Employee e ON c.SupportRepId = e.EmployeeId
GROUP BY 
    c.CustomerId,
    c.FirstName,
    c.LastName,
    c.Email,
    e.FirstName,
    e.LastName
HAVING SUM(i.Total) > 50;


SELECT * FROM View_Customer_Invoice;

-- View_Top_Selling_Tracks

--Những bài bán hơn 10 bản

CREATE VIEW View_Top_Selling_Tracks AS
SELECT 
    t.TrackId,
    t.Name AS Track_Name,
    g.Name AS Genre_Name,
    SUM(il.Quantity) AS Total_Sales
FROM Track t
JOIN InvoiceLine il ON t.TrackId = il.TrackId
JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY 
    t.TrackId,
    t.Name,
    g.Name
HAVING SUM(il.Quantity) > 10;


SELECT * FROM View_Top_Selling_Tracks;

--idx_Track_Name (BTREE)
CREATE INDEX idx_Track_Name
ON Track(Name);

--idx_Invoice_Total
CREATE INDEX idx_Invoice_Total
ON Invoice(Total);

--EXPLAIN kiểm tra INDEX
-- Dùng idx_Track_Name
EXPLAIN 
SELECT * FROM Track
WHERE Name LIKE '%Love%';

EXPLAIN
SELECT * FROM Invoice
WHERE Total > 50;

-- STORED PROCEDURE
--GetCustomerSpending
DELIMITER $$

CREATE PROCEDURE GetCustomerSpending(IN p_CustomerId INT)
BEGIN
    SELECT 
        CustomerId,
        FirstName,
        LastName,
        Email,
        Total_Spending
    FROM View_Customer_Invoice
    WHERE CustomerId = p_CustomerId;
END$$

DELIMITER ;

CALL GetCustomerSpending(1);

--SearchTrackByKeyword
DELIMITER $$

CREATE PROCEDURE SearchTrackByKeyword(IN p_Keyword VARCHAR(100))
BEGIN
    SELECT 
        TrackId, 
        Name,
        UnitPrice
    FROM Track
    WHERE Name LIKE CONCAT('%', p_Keyword, '%');
END$$

DELIMITER ;


CALL SearchTrackByKeyword('Love');

--GetTopSellingTracks
DELIMITER $$

CREATE PROCEDURE GetTopSellingTracks(
    IN p_MinSales INT,
    IN p_MaxSales INT
)
BEGIN
    SELECT *
    FROM View_Top_Selling_Tracks
    WHERE Total_Sales BETWEEN p_MinSales AND p_MaxSales;
END$$

DELIMITER ;

CALL GetTopSellingTracks(10, 50);

--DROP VIEW
DROP VIEW IF EXISTS View_Track_Details;
DROP VIEW IF EXISTS View_Customer_Invoice;
DROP VIEW IF EXISTS View_Top_Selling_Tracks;

-- DROP INDEX
DROP INDEX idx_Track_Name ON Track;
DROP INDEX idx_Invoice_Total ON Invoice;

-- DROP PROCEDURE
DROP PROCEDURE IF EXISTS GetCustomerSpending;
DROP PROCEDURE IF EXISTS SearchTrackByKeyword;
DROP PROCEDURE IF EXISTS GetTopSellingTracks;

