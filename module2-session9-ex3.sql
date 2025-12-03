DESCRIBE Customers;
DESCRIBE Accounts;
DESCRIBE Employees;
select * from Customers;

---Stored Procedure: GetCustomerByPhone
DROP PROCEDURE IF EXISTS GetCustomerByPhone;
DELIMITER $$

CREATE PROCEDURE GetCustomerByPhone (
    IN p_phone VARCHAR(20)
)
BEGIN
    SELECT *
    FROM Customers
    WHERE PhoneNumber = p_phone;
END$$

DELIMITER ;
CALL GetCustomerByPhone('0907776666');

DELIMITER $$

CREATE PROCEDURE GetTotalBalance (
    IN p_customerid INT,
    OUT total_balance DECIMAL(15,2)
)
BEGIN
    SELECT COALESCE(SUM(Balance), 0)
    INTO total_balance
    FROM Accounts
    WHERE CustomerID = p_customerid;
END$$

DELIMITER ;

CALL GetTotalBalance(1, @total_balance);
SELECT @total_balance AS TotalBalance;

DELIMITER $$

CREATE PROCEDURE IncreaseEmployeeSalary (
    IN p_employeeid INT,
    INOUT p_salary DECIMAL(10,2)
)
BEGIN
    -- Tăng lương 10%
    SET p_salary = p_salary * 1.10;

    -- Cập nhật vào bảng Employees
    UPDATE Employees
    SET Salary = p_salary
    WHERE EmployeeID = p_employeeid;

END$$

DELIMITER ;

SELECT Salary INTO @salary FROM Employees WHERE EmployeeID = 2;
select * from Employees;
CALL IncreaseEmployeeSalary(2, @salary);
SELECT @salary AS NewSalary;
SELECT * FROM Employees WHERE EmployeeID = 2;

DROP PROCEDURE IF EXISTS GetCustomerByPhone;
DROP PROCEDURE IF EXISTS GetTotalBalance;
DROP PROCEDURE IF EXISTS IncreaseEmployeeSalary;






