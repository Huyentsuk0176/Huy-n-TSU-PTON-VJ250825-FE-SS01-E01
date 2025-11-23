-- Tạo database
CREATE DATABASE IF NOT EXISTS shopDB;
USE shopDB;

-----------------------------------------------------
-- BẢNG CUSTOMERS
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100)
);

-----------------------------------------------------
-- BẢNG ORDERS
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-----------------------------------------------------
-- BẢNG CATEGORIES
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

-----------------------------------------------------
-- BẢNG PRODUCTS
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price FLOAT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-----------------------------------------------------
-- BẢNG ORDER_DETAILS
CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    price FLOAT,
    PRIMARY KEY(order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-----------------------------------------------------
-- INSERT DỮ LIỆU MẪU
INSERT INTO customers (name, email) VALUES
('Nguyen Van A', 'a@gmail.com'),
('Le Thi B', 'b@gmail.com'),
('Tran Van C', 'c@gmail.com'),
('Pham Thi D', 'd@gmail.com');

INSERT INTO categories (name) VALUES
('Điện thoại'),
('Laptop'),
('Phụ kiện');

INSERT INTO products (name, price, category_id) VALUES
('iPhone 15', 2500, 1),
('Samsung S24', 2100, 1),
('Macbook Pro', 3500, 2),
('Airpods Pro', 300, 3),
('Cáp sạc', 25, 3);

INSERT INTO orders (customer_id, order_date) VALUES
(1, '2024-01-01'),
(1, '2024-02-02'),
(2, '2024-03-03'),
(3, '2024-04-04');

INSERT INTO order_details (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 2500),
(1, 4, 1, 300),
(2, 2, 2, 2100),
(3, 3, 1, 3500),
(4, 5, 3, 25);
-- 1. Thêm 2 khách hàng mới vào bảng customers
INSERT INTO customers (name, email)
VALUES ('Nguyen Van A', 'a@example.com'),
       ('Tran Thi B', 'b@example.com');
-- 2. Liệt kê những khách hàng đã có ít nhất một đơn hàng
SELECT DISTINCT c.id, c.name, c.email
FROM customers c
JOIN orders o ON o.customer_id = c.id;
-- 3. Tìm những khách hàng chưa từng đặt đơn hàng nào
SELECT c.id, c.name, c.email
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id
WHERE o.id IS NULL;
-- 4. Tính tổng doanh thu mà mỗi khách hàng đã mang lại
-- (doanh thu = quantity * price trong order_details)
SELECT  c.id,
        c.name,
        SUM(od.quantity * od.price) AS total_revenue
FROM customers c
JOIN orders o       ON o.customer_id = c.id
JOIN order_details od ON od.order_id = o.id
GROUP BY c.id, c.name;

-- 5. Xác định khách hàng đã mua sản phẩm có giá cao nhất
SELECT DISTINCT c.id, c.name, c.email
FROM customers c
JOIN orders o         ON o.customer_id = c.id
JOIN order_details od ON od.order_id = o.id
JOIN products p       ON p.id = od.product_id
WHERE p.price = (SELECT MAX(price) FROM products);

