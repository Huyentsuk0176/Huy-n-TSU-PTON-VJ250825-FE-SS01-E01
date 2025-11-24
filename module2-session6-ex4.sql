create database module2_session6_ex4;
use module2_session6_ex4;
-- Bảng orders
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE
);

-- Bảng order_details
CREATE TABLE order_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    price FLOAT,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- 3) THÊM DỮ LIỆU MẪU

INSERT INTO orders (order_date) VALUES
('2024-01-01'),
('2024-01-10'),
('2024-02-15'),
('2024-03-20');

INSERT INTO order_details (order_id, product_name, quantity, price) VALUES
(1, 'iPhone 15', 1, 2500),
(1, 'Airpods Pro', 2, 300),

(2, 'Macbook Pro', 1, 3500),
(2, 'Cáp sạc', 3, 20),

(3, 'Samsung S24', 2, 2100),

(4, 'Cáp sạc', 5, 20),
(4, 'Chuột Bluetooth', 1, 45);

-- 4.1. Thêm một đơn hàng mới + chi tiết đơn hàng
INSERT INTO orders (order_date) VALUES ('2024-04-01');
INSERT INTO order_details (order_id, product_name, quantity, price) VALUES
(LAST_INSERT_ID(), 'iPad Air', 1, 1500);

-- 4.2. Tính tổng doanh thu của toàn bộ cửa hàng
SELECT 
    SUM(quantity * price) AS total_revenue
FROM order_details;

-- 4.3. Tính doanh thu trung bình của mỗi đơn hàng
SELECT 
    o.id AS order_id,
    AVG(od.quantity * od.price) AS avg_revenue_per_order
FROM orders o
JOIN order_details od ON o.id = od.order_id
GROUP BY o.id;

-- 4.4. Tìm và hiển thị đơn hàng có doanh thu cao nhất
SELECT 
    o.id AS order_id,
    SUM(od.quantity * od.price) AS total_revenue
FROM orders o
JOIN order_details od ON o.id = od.order_id
GROUP BY o.id
ORDER BY total_revenue DESC
LIMIT 1;

-- 4.5. Tìm 3 sản phẩm bán chạy nhất theo tổng số lượng bán
SELECT 
    product_name,
    SUM(quantity) AS total_sold
FROM order_details
GROUP BY product_name
ORDER BY total_sold DESC
LIMIT 3;
