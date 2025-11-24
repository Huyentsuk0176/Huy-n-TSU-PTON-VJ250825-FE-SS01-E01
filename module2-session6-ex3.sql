
CREATE DATABASE module2_session6_ex3;
USE module2_session6_ex3;

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price FLOAT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- 3. THÊM DỮ LIỆU MẪU
INSERT INTO categories (name) VALUES
('Điện thoại'),
('Laptop'),
('Phụ kiện');

INSERT INTO products (name, price, category_id) VALUES
('iPhone 15', 2500, 1),
('Samsung S24', 2100, 1),
('Oppo Reno 10', 900, 1),
('Macbook Pro M3', 3500, 2),
('Macbook Air M2', 1800, 2),
('Airpods Pro', 300, 3),
('Cáp sạc USB-C', 25, 3),
('Chuột Bluetooth', 45, 3);

-- 4.1. Tìm sản phẩm có giá nằm trong khoảng 50 đến 2000
SELECT *
FROM products
WHERE price BETWEEN 50 AND 2000;

-- 4.2. Tìm sản phẩm có tên chứa chữ "Pro"
SELECT *
FROM products
WHERE name LIKE '%Pro%';

-- 4.3. Tính giá trung bình của sản phẩm theo từng danh mục
SELECT 
    c.name AS category_name,
    AVG(p.price) AS avg_price
FROM products p
JOIN categories c ON p.category_id = c.id
GROUP BY c.name;

-- 4.4. Tìm sản phẩm có giá cao hơn mức giá trung bình của toàn bộ sản phẩm
SELECT *
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 4.5. Tìm sản phẩm có giá thấp nhất theo từng danh mục
SELECT *
FROM products p
WHERE price = (
    SELECT MIN(price)
    FROM products
    WHERE category_id = p.category_id
);
