create database FinanceDB;
use FinanceDB;
create table accounts (
accountID int primary key,
balance decimal(10,2)
);
create table transactions (
transactionID int primary key auto_increment,
fromAccountID int not null,
toAccountID int not null,
amount decimal(10,2),
transactionDate datetime
);
create table budgets (
budgetID int primary key auto_increment,
accountID int not null,
amount decimal(10,2),
month varchar(20)
);
create table expenses (
expenseID int primary key auto_increment,
accountID int not null,
amount decimal(10,2),
expenseDate datetime,
description varchar(225)
);
insert into accounts values
(1, 5000),
(2, 3000);
insert into budgets (accountID, amount, month) values
(1, 2000, '2025-12'),
(2, 1500, '2025-12');
select * from accounts;
select * from budgets;

DROP PROCEDURE IF EXISTS SpendMoney;

DELIMITER $$

CREATE PROCEDURE SpendMoney (
    IN p_accountID INT,
    IN p_spendAmount DECIMAL(10,2),
    IN p_month VARCHAR(20),
    IN p_description VARCHAR(255)
)
BEGIN
    DECLARE currentBalance DECIMAL(10,2);
    DECLARE currentBudget DECIMAL(10,2);

    START TRANSACTION;

    -- Lấy số dư tài khoản
    SELECT balance INTO currentBalance
    FROM accounts
    WHERE accountID = p_accountID
    FOR UPDATE;

    -- Không đủ tiền thì rollback
    IF currentBalance < p_spendAmount THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số dư không đủ!';
    END IF;

    -- Trừ tiền
    UPDATE accounts
    SET balance = balance - p_spendAmount
    WHERE accountID = p_accountID;

    -- Thêm expense
    INSERT INTO expenses(accountID, amount, expenseDate, description)
    VALUES (p_accountID, p_spendAmount, NOW(), p_description);

    -- Lấy budget
    SELECT amount INTO currentBudget
    FROM budgets
    WHERE accountID = p_accountID AND month = p_month
    FOR UPDATE;

    -- Nếu có thì cập nhật budget
    IF currentBudget IS NOT NULL THEN
        UPDATE budgets
        SET amount = amount - p_spendAmount
        WHERE accountID = p_accountID AND month = p_month;
    END IF;

    COMMIT;

END $$

DELIMITER ;

show create procedure SpendMoney;
SET SQL_SAFE_UPDATES = 0;


call SpendMoney(1, 500, '2025-12', 'Mua giao trinh FE'
);
SELECT * FROM accounts;
SELECT * FROM budgets;
SELECT * FROM expenses;

truncate table expenses;





