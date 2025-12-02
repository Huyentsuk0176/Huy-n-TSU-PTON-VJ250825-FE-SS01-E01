CREATE TABLE order_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    old_status ENUM('Pending','Completed','Cancelled'),
    new_status ENUM('Pending','Completed','Cancelled'),
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);
--Trigger: before_insert_check_payment
DELIMITER $$

CREATE TRIGGER before_insert_check_payment
BEFORE INSERT ON payments
FOR EACH ROW
BEGIN
    DECLARE order_total DECIMAL(10,2);

    -- Lấy tổng tiền đơn hàng
    SELECT total_amount INTO order_total
    FROM orders
    WHERE order_id = NEW.order_id;

    -- Nếu số tiền không khớp -> báo lỗi
    IF NEW.amount <> order_total THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số tiền thanh toán KHÔNG khớp với tổng đơn hàng';
    END IF;
END$$

DELIMITER ;

--Trigger: after_update_order_status
DELIMITER $$

CREATE TRIGGER after_update_order_status
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO order_logs(order_id, old_status, new_status)
        VALUES (OLD.order_id, OLD.status, NEW.status);
    END IF;
END$$

DELIMITER ;
--Procedure: sp_update_order_status_with_payment
DELIMITER $$

CREATE PROCEDURE sp_update_order_status_with_payment
(
    IN p_order_id INT,
    IN p_new_status ENUM('Pending','Completed','Cancelled'),
    IN p_payment_amount DECIMAL(10,2),
    IN p_payment_method VARCHAR(50)
)
BEGIN
    DECLARE current_status ENUM('Pending','Completed','Cancelled');

    -- Xử lý lỗi
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Có lỗi xảy ra, transaction đã rollback';
    END;

    START TRANSACTION;

    -- Lấy trạng thái hiện tại
    SELECT status INTO current_status
    FROM orders
    WHERE order_id = p_order_id
    FOR UPDATE;

    -- Nếu trạng thái giống nhau => lỗi
    IF current_status = p_new_status THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Trạng thái đã giống nhau, không cần cập nhật';
    END IF;

    -- Nếu chuyển sang Completed → thêm payment
    IF p_new_status = 'Completed' THEN
        INSERT INTO payments(order_id, amount, payment_method, status)
        VALUES (p_order_id, p_payment_amount, p_payment_method, 'Success');
        -- Trigger BEFORE INSERT sẽ check tiền
    END IF;

    -- Cập nhật trạng thái order
    UPDATE orders
    SET status = p_new_status
    WHERE order_id = p_order_id;
    -- Trigger AFTER UPDATE sẽ ghi log

    COMMIT;
END$$

DELIMITER ;
--Giả sử order_id = 1
INSERT INTO orders(customer_id, total_amount, status)
VALUES (1, 300000, 'Pending');
select * from orders;
CALL sp_update_order_status_with_payment(1, 'Completed', 300000, 'Cash');

DROP TRIGGER before_insert_check_payment;
DROP TRIGGER after_update_order_status;

DROP PROCEDURE sp_update_order_status_with_payment;

DROP TABLE order_logs;




