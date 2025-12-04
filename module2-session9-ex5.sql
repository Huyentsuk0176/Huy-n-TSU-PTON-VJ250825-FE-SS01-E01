CREATE VIEW View_Album_Artist AS
SELECT 
    a.AlbumId,
    a.Title AS Album_Title,
    ar.Name AS Artist_Name
FROM Album a
JOIN Artist ar
ON a.ArtistId = ar.ArtistId;
SELECT * FROM View_Album_Artist;

CREATE VIEW View_Customer_Spending AS
SELECT 
    c.CustomerId,
    c.FirstName,
    c.LastName,
    c.Email,
    SUM(i.Total) AS Total_Spending
FROM Customer c
JOIN Invoice i
ON c.CustomerId = i.CustomerId
GROUP BY 
    c.CustomerId,
    c.FirstName,
    c.LastName,
    c.Email;

SELECT * FROM View_Customer_Spending;

CREATE INDEX idx_Employee_LastName 
ON Employee(LastName);

EXPLAIN 
SELECT * FROM Employee
WHERE LastName = 'King';

DELIMITER $$

CREATE PROCEDURE GetTracksByGenre(IN p_GenreId INT)
BEGIN
    SELECT 
        t.TrackId,
        t.Name AS Track_Name,
        al.Title AS Album_Title,
        ar.Name AS Artist_Name
    FROM Track t
    JOIN Album al ON t.AlbumId = al.AlbumId
    JOIN Artist ar ON al.ArtistId = ar.ArtistId
    WHERE t.GenreId = p_GenreId;
END$$

DELIMITER ;

CALL GetTracksByGenre(1);

DELIMITER $$

CREATE PROCEDURE GetTrackCountByAlbum(IN p_AlbumId INT)
BEGIN
    SELECT 
        COUNT(*) AS Total_Tracks
    FROM Track
    WHERE AlbumId = p_AlbumId;
END$$

DELIMITER ;

CALL GetTrackCountByAlbum(1);

DROP VIEW IF EXISTS View_Album_Artist;
DROP VIEW IF EXISTS View_Customer_Spending;

DROP INDEX idx_Employee_LastName ON Employee;

DROP PROCEDURE IF EXISTS GetTracksByGenre;
DROP PROCEDURE IF EXISTS GetTrackCountByAlbum;









