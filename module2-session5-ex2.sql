CREATE DATABASE SESSION5EX2DB;
USE SESSION5EX2DB;
CREATE TABLE sales (
    saleID INT PRIMARY KEY,
    productID INT NOT NULL,
    saleDate DATE NOT NULL,
    quantity INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);
INSERT INTO sales (saleID, productID, saleDate, quantity, amount) VALUES
(1,  101, '2024-01-05', 2,  150000),
(2,  101, '2024-01-10', 1,   75000),
(3,  102, '2024-01-12', 3,  210000),
(4,  103, '2024-01-15', 1,   50000),
(5,  101, '2024-01-18', 4,  300000),
(6,  102, '2024-01-20', 2,  140000),
(7,  104, '2024-01-21', 1,   80000),
(8,  103, '2024-01-22', 5,  250000),
(9,  101, '2024-01-25', 2,  150000),
(10, 102, '2024-01-28', 1,   70000);
SELECT * FROM Sales;
SELECT 
productID,
COUNT(saleID) AS totalOrders
FROM sales
GROUP BY productID;


