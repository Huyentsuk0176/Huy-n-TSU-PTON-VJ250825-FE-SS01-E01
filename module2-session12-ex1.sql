CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) DEFAULT 0,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Cash') NOT NULL,
    status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);
INSERT INTO customers (name,email,phone,address) VALUES
('Nguyen Van A','a@gmail.com','0901111111','HCM'),
('Tran Thi B','b@gmail.com','0902222222','HN'),
('Le Van C','c@gmail.com','0903333333','DN');
INSERT INTO products (name,price,description) VALUES
('Laptop',1500,'Gaming Laptop'),
('Phone',800,'Smart phone'),
('Headphone',200,'Bluetooth headset'),
('Mouse',50,'Wireless Mouse');
INSERT INTO inventory (product_id, stock_quantity) VALUES
(1,10),
(2,20),
(3,50),
(4,100);
INSERT INTO orders (customer_id) VALUES
(1),
(2),
(3);
INSERT INTO order_items (order_id,product_id,quantity,price) VALUES
(1,1,2,1500),
(1,3,3,200),
(2,2,1,800),
(3,4,5,50);
INSERT INTO payments (order_id,amount,payment_method,status) VALUES
(1,3600,'Credit Card','Completed'),
(2,800,'Cash','Pending'),
(3,250,'PayPal','Completed');
SELECT * FROM inventory;
SELECT * FROM orders;
SELECT * FROM order_items;
INSERT INTO order_items VALUES (NULL,1,1,999,100);
DELETE FROM orders WHERE order_id = 1;
DROP TRIGGER IF EXISTS trg_before_insert_order_items;
DROP TRIGGER IF EXISTS trg_after_insert_order_items;
DROP TRIGGER IF EXISTS trg_before_update_order_items;
DROP TRIGGER IF EXISTS trg_after_update_order_items;
DROP TRIGGER IF EXISTS trg_before_delete_orders;
DROP TRIGGER IF EXISTS trg_after_delete_order_items;


