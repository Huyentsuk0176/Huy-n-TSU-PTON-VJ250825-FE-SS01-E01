-- 1. TẠO DATABASE VÀ SỬ DỤNG
CREATE DATABASE IF NOT EXISTS MoneyManagement;
USE MoneyManagement;

-- 2. BẢNG ACCOUNTS: lưu số dư từng tài khoản
CREATE TABLE Accounts (
    accountID INT AUTO_INCREMENT PRIMARY KEY,
    balance   DECIMAL(10,2) NOT NULL DEFAULT 0
);

-- 3. BẢNG TRANSACTIONS: lưu từng giao dịch chuyển tiền
CREATE TABLE Transactions (
    transactionID   INT AUTO_INCREMENT PRIMARY KEY,
    fromAccountID   INT NOT NULL,
    toAccountID     INT NOT NULL,
    amount          DECIMAL(10,2) NOT NULL,
    transactionDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_tran_from
      FOREIGN KEY (fromAccountID) REFERENCES Accounts(accountID),
    CONSTRAINT fk_tran_to
      FOREIGN KEY (toAccountID) REFERENCES Accounts(accountID)
);

-- 4. BẢNG BUDGETS: hạn mức chi tiêu theo tháng
CREATE TABLE Budgets (
    budgetID  INT AUTO_INCREMENT PRIMARY KEY,
    accountID INT NOT NULL,
    amount    DECIMAL(10,2) NOT NULL,
    month     VARCHAR(20) NOT NULL,
    
    CONSTRAINT fk_budget_acc
      FOREIGN KEY (accountID) REFERENCES Accounts(accountID)
);

-- 5. BẢNG EXPENSES: các khoản chi tiêu thực tế
CREATE TABLE Expenses (
    expenseID   INT AUTO_INCREMENT PRIMARY KEY,
    accountID   INT NOT NULL,
    amount      DECIMAL(10,2) NOT NULL,
    category    VARCHAR(50),
    description VARCHAR(255),
    expenseDate DATETIME NOT NULL,
    
    CONSTRAINT fk_exp_acc
      FOREIGN KEY (accountID) REFERENCES Accounts(accountID)
);

-- 6. BẢNG TRANSACTIONHISTORY: lịch sử cho từng tài khoản
-- (mỗi giao dịch sẽ có 2 dòng: 1 cho tài khoản gửi, 1 cho tài khoản nhận)
CREATE TABLE TransactionHistory (
    historyID       INT AUTO_INCREMENT PRIMARY KEY,
    transactionID   INT NOT NULL,
    accountID       INT NOT NULL,
    amount          DECIMAL(10,2) NOT NULL,
    transactionDate DATETIME NOT NULL,
    type            VARCHAR(50) NOT NULL,   -- 'DEBIT' / 'CREDIT'
    
    CONSTRAINT fk_hist_tran
      FOREIGN KEY (transactionID) REFERENCES Transactions(transactionID),
    CONSTRAINT fk_hist_acc
      FOREIGN KEY (accountID) REFERENCES Accounts(accountID)
);

-- 7. BẢNG RECURRINGTRANSACTIONS: thiết lập giao dịch định kỳ
CREATE TABLE RecurringTransactions (
    recurringID        INT AUTO_INCREMENT PRIMARY KEY,
    fromAccountID      INT NOT NULL,
    toAccountID        INT NOT NULL,
    amount             DECIMAL(10,2) NOT NULL,
    startDate          DATETIME NOT NULL,
    frequency          VARCHAR(50) NOT NULL,   -- 'DAILY', 'WEEKLY', 'MONTHLY',...
    nextTransactionDate DATETIME NOT NULL,
    
    CONSTRAINT fk_rec_from
      FOREIGN KEY (fromAccountID) REFERENCES Accounts(accountID),
    CONSTRAINT fk_rec_to
      FOREIGN KEY (toAccountID) REFERENCES Accounts(accountID)
);
-- Thêm 2 tài khoản
INSERT INTO Accounts(balance)
VALUES (1000000.00),  -- accountID = 1
       (500000.00);   -- accountID = 2

-- Một lệnh chuyển tiền định kỳ: từ TK 1 sang TK 2, 50,000 yên, hàng tháng
INSERT INTO RecurringTransactions
(fromAccountID, toAccountID, amount, startDate, frequency, nextTransactionDate)
VALUES
(1, 2, 50000.00, NOW(), 'MONTHLY', NOW());
DELIMITER $$

CREATE PROCEDURE ProcessRecurringTransactions()
BEGIN
    -- 1. KHAI BÁO BIẾN ĐỂ DÙNG TRONG CURSOR
    DECLARE v_done INT DEFAULT 0;
    DECLARE v_recurringID INT;
    DECLARE v_fromAccountID INT;
    DECLARE v_toAccountID INT;
    DECLARE v_amount DECIMAL(10,2);
    DECLARE v_frequency VARCHAR(50);
    DECLARE v_nextDate DATETIME;
    DECLARE v_current_balance DECIMAL(10,2);
    DECLARE v_transactionID INT;

    -- 2. CURSOR LẤY CÁC GIAO DỊCH ĐỊNH KỲ ĐẾN HẠN
    DECLARE cur_recurring CURSOR FOR
        SELECT recurringID, fromAccountID, toAccountID, amount,
               frequency, nextTransactionDate
        FROM RecurringTransactions
        WHERE nextTransactionDate <= NOW();

    -- 3. HANDLER: KHI CURSOR HẾT DỮ LIỆU THÌ SET v_done = 1
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

    -- 4. MỞ CURSOR
    OPEN cur_recurring;

    read_loop: LOOP
        -- 5. ĐỌC TỪNG DÒNG TRONG CURSOR VÀO BIẾN
        FETCH cur_recurring
        INTO v_recurringID, v_fromAccountID, v_toAccountID,
             v_amount, v_frequency, v_nextDate;

        -- Nếu không còn dữ liệu → thoát khỏi vòng lặp
        IF v_done = 1 THEN
            LEAVE read_loop;
        END IF;

        -- 6. LẤY SỐ DƯ TÀI KHOẢN NGUỒN HIỆN TẠI
        SELECT balance
        INTO v_current_balance
        FROM Accounts
        WHERE accountID = v_fromAccountID;

        -- 7. CHỈ THỰC HIỆN GIAO DỊCH NẾU ĐỦ TIỀN
        IF v_current_balance >= v_amount THEN

            -- 7.1 GHI MỘT DÒNG VÀO BẢNG TRANSACTIONS
            INSERT INTO Transactions (fromAccountID, toAccountID, amount, transactionDate)
            VALUES (v_fromAccountID, v_toAccountID, v_amount, NOW());

            -- Lấy ID giao dịch vừa tạo
            SET v_transactionID = LAST_INSERT_ID();

            -- 7.2 CẬP NHẬT SỐ DƯ ACCOUNTS
            UPDATE Accounts
            SET balance = balance - v_amount
            WHERE accountID = v_fromAccountID;

            UPDATE Accounts
            SET balance = balance + v_amount
            WHERE accountID = v_toAccountID;

            -- 7.3 GHI LOG VÀO TRANSACTIONHISTORY
            INSERT INTO TransactionHistory
                (transactionID, accountID, amount, transactionDate, type)
            VALUES
                (v_transactionID, v_fromAccountID, v_amount * -1, NOW(), 'DEBIT'),
                (v_transactionID, v_toAccountID, v_amount,      NOW(), 'CREDIT');

            -- 7.4 CẬP NHẬT NGÀY THỰC HIỆN TIẾP THEO
            UPDATE RecurringTransactions
            SET nextTransactionDate =
                CASE UPPER(v_frequency)
                    WHEN 'DAILY'   THEN DATE_ADD(v_nextDate, INTERVAL 1 DAY)
                    WHEN 'WEEKLY'  THEN DATE_ADD(v_nextDate, INTERVAL 1 WEEK)
                    WHEN 'MONTHLY' THEN DATE_ADD(v_nextDate, INTERVAL 1 MONTH)
                    ELSE DATE_ADD(v_nextDate, INTERVAL 1 DAY) -- mặc định 1 ngày
                END
            WHERE recurringID = v_recurringID;

        END IF;   -- END IF v_current_balance >= v_amount

    END LOOP;

    -- 8. ĐÓNG CURSOR
    CLOSE cur_recurring;
END $$

DELIMITER ;
-- Gọi procedure thực hiện tất cả giao dịch định kỳ đến hạn
CALL ProcessRecurringTransactions();

-- Xem kết quả
SELECT * FROM Accounts;
SELECT * FROM Transactions;
SELECT * FROM TransactionHistory;
SELECT * FROM RecurringTransactions;


