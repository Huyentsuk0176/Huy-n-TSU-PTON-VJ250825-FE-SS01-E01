CREATE DATABASE ProductsDB;
USE ProductsDB;
INSERT INTO products (productID, productName, price) VALUES
(1, 'Bánh Mì', 15000),
(2, 'Sữa Tươi', 22000),
(3, 'Kẹo Socola', 45000),
(4, 'Mì Ly', 12000),
(5, 'Nước Ngọt', 18000),
(6, 'Khoai Tây Chiên', 35000);
SELECT *
FROM products
WHERE price = (SELECT MAX(price) FROM products);

SELECT *
FROM products
WHERE price = (SELECT MIN(price) FROM products);


