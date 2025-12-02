CREATE DATABASE PersonalFinance;
use  PersonalFinance;
CREATE TABLE accounts (
    accountID INT PRIMARY KEY AUTO_INCREMENT,
    balance   DECIMAL(10,2) NOT NULL DEFAULT 0
);
CREATE TABLE transactions (
    transactionID   INT PRIMARY KEY AUTO_INCREMENT,
    fromAccountID   INT NOT NULL,
    toAccountID     INT NOT NULL,
    amount          DECIMAL(10,2) NOT NULL,
    transactionDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_transactions_from
        FOREIGN KEY (fromAccountID) REFERENCES accounts(accountID),
    CONSTRAINT fk_transactions_to
        FOREIGN KEY (toAccountID) REFERENCES accounts(accountID)
);
CREATE TABLE budgets (
    budgetID  INT PRIMARY KEY AUTO_INCREMENT,
    accountID INT NOT NULL,
    amount    DECIMAL(10,2) NOT NULL,
    month     VARCHAR(20) NOT NULL,
    
    CONSTRAINT fk_budgets_account
        FOREIGN KEY (accountID) REFERENCES accounts(accountID)
);
CREATE TABLE expenses (
    expenseID   INT PRIMARY KEY AUTO_INCREMENT,
    accountID   INT NOT NULL,
    amount      DECIMAL(10,2) NOT NULL,
    expenseDate DATETIME NOT NULL,
    description VARCHAR(255),
    
    CONSTRAINT fk_expenses_account
        FOREIGN KEY (accountID) REFERENCES accounts(accountID)
);
CREATE TABLE transactionHistory (
    historyID       INT PRIMARY KEY AUTO_INCREMENT,
    transactionID   INT NOT NULL,
    accountID       INT NOT NULL,
    amount          DECIMAL(10,2) NOT NULL,
    transactionDate DATETIME NOT NULL,
    type            VARCHAR(50) NOT NULL, -- 'IN' / 'OUT'
    
    CONSTRAINT fk_history_transaction
        FOREIGN KEY (transactionID) REFERENCES transactions(transactionID),
    CONSTRAINT fk_history_account
        FOREIGN KEY (accountID) REFERENCES accounts(accountID)
);
-- Thêm 3 tài khoản
INSERT INTO accounts (balance) VALUES (100000), (50000), (200000);

-- Thêm một ít budgets
INSERT INTO budgets (accountID, amount, month) VALUES
(1, 50000, '2024-12'),
(2, 30000, '2024-12');
select * from budgets;

-- Thêm 1 vài expenses
INSERT INTO expenses (accountID, amount, expenseDate, description) VALUES
(1, 10000, '2024-12-01 10:00:00', 'Mua sắm'),
(2,  5000, '2024-12-02 11:00:00', 'Ăn uống');
select * from expenses;

DELIMITER $$

CREATE PROCEDURE AddTransactionWithHistory
(
    IN p_fromAccountID INT,
    IN p_toAccountID   INT,
    IN p_amount        DECIMAL(10,2),
    IN p_tranDate      DATETIME
)
BEGIN
    DECLARE v_transactionID INT;

    START TRANSACTION;

    -- 1. Tạo bản ghi giao dịch trong bảng transactions
    INSERT INTO transactions (fromAccountID, toAccountID, amount, transactionDate)
    VALUES (p_fromAccountID, p_toAccountID, p_amount, p_tranDate);

    -- Lấy ID giao dịch vừa tạo
    SET v_transactionID = LAST_INSERT_ID();

    -- 2. Ghi lịch sử cho tài khoản GỬI (OUT)
    INSERT INTO transactionHistory
    (transactionID, accountID, amount, transactionDate, type)
    VALUES
    (v_transactionID, p_fromAccountID, p_amount, p_tranDate, 'OUT');

    -- 3. Ghi lịch sử cho tài khoản NHẬN (IN)
    INSERT INTO transactionHistory
    (transactionID, accountID, amount, transactionDate, type)
    VALUES
    (v_transactionID, p_toAccountID, p_amount, p_tranDate, 'IN');

    COMMIT;
END$$

DELIMITER ;
CALL AddTransactionWithHistory(1, 2, 20000, '2024-12-03 09:00:00');
SELECT * FROM transactions;
SELECT * FROM transactionHistory;
DELIMITER $$

CREATE PROCEDURE GetAccountTransactionTotal
(
    IN  p_accountID INT,
    IN  p_startDate DATETIME,
    IN  p_endDate   DATETIME,
    OUT p_totalAmount DECIMAL(10,2)
)
BEGIN
    SELECT 
        IFNULL(SUM(
            CASE
                WHEN type = 'IN'  THEN amount
                WHEN type = 'OUT' THEN -amount
            END
        ), 0)
    INTO p_totalAmount
    FROM transactionHistory
    WHERE accountID = p_accountID
      AND transactionDate BETWEEN p_startDate AND p_endDate;
END$$

DELIMITER ;
-- Ví dụ: xem tổng giao dịch của accountID = 1 trong tháng 12/2024
CALL GetAccountTransactionTotal(
    1,
    '2024-12-01 00:00:00',
    '2024-12-31 23:59:59',
    @total
);

SELECT @total AS TongGiaoDich;

