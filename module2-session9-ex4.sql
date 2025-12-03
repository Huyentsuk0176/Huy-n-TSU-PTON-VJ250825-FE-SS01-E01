DROP PROCEDURE IF EXISTS GetCustomerByPhone;
DROP PROCEDURE IF EXISTS GetTotalBalance;
DROP PROCEDURE IF EXISTS IncreaseEmployeeSalary;

DROP PROCEDURE IF EXISTS UpdateSalaryByID;
DROP PROCEDURE IF EXISTS GetLoanAmountByCustomerID;
DROP PROCEDURE IF EXISTS DeleteAccountIfLowBalance;
DROP PROCEDURE IF EXISTS TransferMoney;

DELIMITER $$

CREATE PROCEDURE GetCustomerByPhone(IN p_phone VARCHAR(20))
BEGIN
    SELECT *
    FROM Customers
    WHERE PhoneNumber = p_phone;
END$$

DELIMITER ;
select * from Customers;

CALL GetCustomerByPhone('0909998888');
DELIMITER $$

CREATE PROCEDURE GetTotalBalance(
    IN p_customerid INT,
    OUT total_balance DECIMAL(15,2)
)
BEGIN
    SELECT IFNULL(SUM(Balance),0)
    INTO total_balance
    FROM Accounts
    WHERE CustomerID = p_customerid;
END$$

DELIMITER ;
CALL GetTotalBalance(1, @total_balance);
SELECT @total_balance;

DELIMITER $$

CREATE PROCEDURE IncreaseEmployeeSalary(
    IN p_employeeid INT,
    INOUT p_salary DECIMAL(15,2)
)
BEGIN
    SET p_salary = p_salary * 1.10;

    UPDATE Employees
    SET Salary = p_salary
    WHERE EmployeeID = p_employeeid;
END$$

DELIMITER ;
SELECT Salary INTO @cur_salary 
FROM Employees 
WHERE EmployeeID = 1;

CALL IncreaseEmployeeSalary(1, @cur_salary);

SELECT @cur_salary AS NewSalary;

DELIMITER $$

CREATE PROCEDURE UpdateSalaryByID(IN p_employeeid INT)
BEGIN
    DECLARE cur_salary DECIMAL(15,2);
    DECLARE new_salary DECIMAL(15,2);

    SELECT Salary INTO cur_salary
    FROM Employees
    WHERE EmployeeID = p_employeeid;

    IF cur_salary < 20000000 THEN
        SET new_salary = cur_salary * 1.10;
    ELSE
        SET new_salary = cur_salary * 1.05;
    END IF;

    UPDATE Employees
    SET Salary = new_salary
    WHERE EmployeeID = p_employeeid;

    SELECT new_salary AS UpdatedSalary;
END$$

DELIMITER ;

CALL GetLoanAmountByCustomerID(2, @loan);
SELECT @loan;

DELIMITER $$

CREATE PROCEDURE DeleteAccountIfLowBalance(IN p_accountid INT)
BEGIN
    DECLARE cur_balance DECIMAL(15,2);

    SELECT Balance INTO cur_balance
    FROM Accounts
    WHERE AccountID = p_accountid;

    IF cur_balance < 1000000 THEN
        DELETE FROM Accounts WHERE AccountID = p_accountid;
        SELECT 'Xóa thành công' AS Message;
    ELSE
        SELECT 'Không đủ điều kiện xóa' AS Message;
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE TransferMoney(
    IN p_from INT,
    IN p_to INT,
    IN p_amount DECIMAL(15,2),
    OUT transferred DECIMAL(15,2)
)
BEGIN
    DECLARE from_balance DECIMAL(15,2);

    SELECT Balance INTO from_balance
    FROM Accounts
    WHERE AccountID = p_from;

    IF from_balance >= p_amount THEN

        UPDATE Accounts
        SET Balance = Balance - p_amount
        WHERE AccountID = p_from;

        UPDATE Accounts
        SET Balance = Balance + p_amount
        WHERE AccountID = p_to;

        SET transferred = p_amount;

    ELSE
        SET transferred = 0;
    END IF;
END$$

DELIMITER ;

CALL TransferMoney(1, 2, 500000, @money);
SELECT @money AS Transferred;

DROP PROCEDURE IF EXISTS GetCustomerByPhone;
DROP PROCEDURE IF EXISTS GetTotalBalance;
DROP PROCEDURE IF EXISTS IncreaseEmployeeSalary;
DROP PROCEDURE IF EXISTS UpdateSalaryByID;
DROP PROCEDURE IF EXISTS GetLoanAmountByCustomerID;
DROP PROCEDURE IF EXISTS DeleteAccountIfLowBalance;
DROP PROCEDURE IF EXISTS TransferMoney;











