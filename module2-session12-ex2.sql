DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status ENUM('Pending','Completed','Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    status ENUM('Success','Failed') DEFAULT 'Success',
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
INSERT INTO customers(name,email,phone,address)
VALUES ('Nguyen A','a@gmail.com','0901111','HN');

INSERT INTO products(name,price,description)
VALUES 
('Bánh Mì', 15000, 'Bánh mì giòn'),
('Trà sữa', 30000, 'Trà sữa trân châu');

INSERT INTO inventory(product_id, stock_quantity)
VALUES 
(1, 50),
(2, 20);

DELIMITER $$

CREATE PROCEDURE sp_create_order
(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    IN p_price DECIMAL(10,2)
)
BEGIN
    DECLARE v_stock INT;
    DECLARE v_order_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Có lỗi xảy ra, giao dịch đã bị huỷ!';
    END;

    START TRANSACTION;

    SELECT stock_quantity INTO v_stock
    FROM inventory
    WHERE product_id = p_product_id
    FOR UPDATE;

    IF v_stock < p_quantity THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không đủ hàng trong kho!';
    END IF;

    INSERT INTO orders(customer_id, order_date, total_amount, status)
    VALUES (p_customer_id, NOW(), p_quantity * p_price, 'Pending');

    SET v_order_id = LAST_INSERT_ID();

    INSERT INTO order_items(order_id, product_id, quantity, price)
    VALUES (v_order_id, p_product_id, p_quantity, p_price);

    UPDATE inventory
    SET stock_quantity = stock_quantity - p_quantity
    WHERE product_id = p_product_id;

    COMMIT;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_pay_order
(
    IN p_order_id INT,
    IN p_payment_method VARCHAR(50)
)
BEGIN
    DECLARE v_status VARCHAR(20);
    DECLARE v_total DECIMAL(10,2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Thanh toán thất bại!';
    END;

    START TRANSACTION;

    SELECT status, total_amount
    INTO v_status, v_total
    FROM orders
    WHERE order_id = p_order_id
    FOR UPDATE;

    IF v_status <> 'Pending' THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Chỉ được thanh toán đơn Pending!';
    END IF;

    INSERT INTO payments(order_id, payment_date, amount, payment_method, status)
    VALUES (p_order_id, NOW(), v_total, p_payment_method, 'Success');

    UPDATE orders
    SET status = 'Completed'
    WHERE order_id = p_order_id;

    COMMIT;
END$$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE sp_cancel_order
(
    IN p_order_id INT
)
BEGIN
    DECLARE v_status VARCHAR(20);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể hủy đơn!';
    END;

    START TRANSACTION;

    SELECT status INTO v_status
    FROM orders
    WHERE order_id = p_order_id
    FOR UPDATE;

    IF v_status <> 'Pending' THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Chỉ hủy được đơn hàng Pending!';
    END IF;

    -- Trả hàng về kho
    UPDATE inventory i
    JOIN order_items oi ON i.product_id = oi.product_id
    SET i.stock_quantity = i.stock_quantity + oi.quantity
    WHERE oi.order_id = p_order_id;

    -- Xóa chi tiết đơn
    DELETE FROM order_items WHERE order_id = p_order_id;

    -- Cập nhật trạng thái
    UPDATE orders SET status = 'Cancelled' WHERE order_id = p_order_id;

    COMMIT;
END$$

DELIMITER ;
DROP PROCEDURE IF EXISTS sp_create_order;
DROP PROCEDURE IF EXISTS sp_pay_order;
DROP PROCEDURE IF EXISTS sp_cancel_order;
show tables;

CALL sp_create_order(1, 1, 5, 15000);
CALL sp_pay_order(1, 'COD');
CALL sp_cancel_order(1);
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM inventory;

