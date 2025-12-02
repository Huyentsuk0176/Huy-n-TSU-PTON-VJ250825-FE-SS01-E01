DROP DATABASE IF EXISTS BankDB;
CREATE DATABASE BankDB;
USE BankDB;
CREATE TABLE Accounts (
    accountID INT PRIMARY KEY,
    balance DECIMAL(10,2) NOT NULL
) ENGINE = InnoDB;
CREATE TABLE Transactions (
    transactionID INT AUTO_INCREMENT PRIMARY KEY,
    fromAccountID INT NOT NULL,
    toAccountID INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    transactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (fromAccountID) REFERENCES Accounts(accountID),
    FOREIGN KEY (toAccountID) REFERENCES Accounts(accountID)
) ENGINE = InnoDB;
INSERT INTO Accounts VALUES (1, 5000);
INSERT INTO Accounts VALUES (2, 3000);
DROP PROCEDURE IF EXISTS transfermoney;
DELIMITER $$

CREATE PROCEDURE transfermoney(
    IN p_from INT,
    IN p_to INT,
    IN p_amount DECIMAL(10,2)
)
BEGIN
    DECLARE sender_balance DECIMAL(10,2);

    START TRANSACTION;

    -- Lấy số dư tài khoản nguồn
    SELECT balance INTO sender_balance
    FROM Accounts
    WHERE accountID = p_from
    FOR UPDATE;

    -- Nếu không đủ tiền → rollback
    IF sender_balance < p_amount THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Khong du so du';
    END IF;

    -- Trừ tiền người gửi
    UPDATE Accounts
    SET balance = balance - p_amount
    WHERE accountID = p_from;

    -- Cộng tiền người nhận
    UPDATE Accounts
    SET balance = balance + p_amount
    WHERE accountID = p_to;

    -- Ghi lịch sử giao dịch
    INSERT INTO Transactions(fromAccountID, toAccountID, amount)
    VALUES (p_from, p_to, p_amount);

    -- Xác nhận giao dịch
    COMMIT;
END$$
DELIMITER ;
CALL transfermoney(1, 2, 1000);
SELECT * FROM Accounts;
SELECT * FROM Transactions;
