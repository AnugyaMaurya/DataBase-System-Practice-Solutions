
--1. Display the count of customers in each region who have done the transaction in the year 2020.
SELECT C.region_id, COUNT(*) AS Customer_Count
FROM Customers C
JOIN Transaction T ON C.customer_id = T.customer_id
WHERE YEAR(T.txn_date) = 2020
GROUP BY C.region_id;

--2. Display the maximum and minimum transaction amount of each transaction type.
SELECT txn_type, MAX(txn_amount) AS Max_Amount, MIN(txn_amount) AS Min_Amount
FROM Transaction
GROUP BY txn_type;

--3. Display the customer id, region name and transaction amount where transaction type is deposit and transaction amount > 2000.
SELECT C.customer_id, CO.region_name, T.txn_amount
FROM Customers C
JOIN Transaction T ON C.customer_id = T.customer_id
JOIN Continent CO ON C.region_id = CO.region_id
WHERE T.txn_type = 'deposit' AND T.txn_amount > 2000;

--4. Find duplicate records in the Customer table.
SELECT customer_id, COUNT(*) AS Duplicate_Count
FROM Customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

--5. Display the customer id, region name, transaction type and transaction amount for the minimum transaction amount in deposit.
SELECT C.customer_id, CO.region_name, T.txn_type, T.txn_amount
FROM Customers C
JOIN Transaction T ON C.customer_id = T.customer_id
JOIN Continent CO ON C.region_id = CO.region_id
WHERE T.txn_type = 'deposit' AND T.txn_amount = (SELECT MIN(txn_amount) FROM Transaction WHERE txn_type = 'deposit');

--6. Create a stored procedure to display details of customers in the Transaction table where the transaction date is greater than Jun 2020.
CREATE PROCEDURE GetCustomersAfterJune2020()
BEGIN
    SELECT C.customer_id, C.region_id, T.txn_date, T.txn_type, T.txn_amount
    FROM Customers C
    JOIN Transaction T ON C.customer_id = T.customer_id
    WHERE T.txn_date > '2020-06-01';
END 

--7. Create a stored procedure to insert a record in the Continent table.
DELIMITER //
CREATE PROCEDURE InsertIntoContinent(IN region_id INT, IN region_name VARCHAR(50))
BEGIN
    INSERT INTO Continent (region_id, region_name)
    VALUES (region_id, region_name);
END //
DELIMITER ;

--8. Create a stored procedure to display the details of transactions that happened on a specific day.
 DELIMITER //
CREATE PROCEDURE GetTransactionsByDate(IN txn_date DATE)
BEGIN
    SELECT *
    FROM Transaction
    WHERE txn_date = txn_date;
END //
DELIMITER ;

--9. Create a user defined function to add 10% of the transaction amount in a table
DELIMITER //
CREATE FUNCTION AddTenPercent(amount DECIMAL(10, 2)) RETURNS DECIMAL(10, 2)
BEGIN
    RETURN amount * 1.1;
END //
DELIMITER ;

--10. Create a user defined function to find the total transaction amount for a given transaction type.
DELIMITER //
CREATE FUNCTION GetTotalTransactionAmount(txn_type VARCHAR(50)) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total_amount DECIMAL(10, 2);
    SELECT SUM(txn_amount) INTO total_amount
    FROM Transaction
    WHERE txn_type = txn_type;
    RETURN total_amount;
END //
DELIMITER ;

--11. Create a table value function which comprises the columns customer_id,region_id ,txn_date , txn_type , txn_amount which will retrieve data from
--the above table.
DELIMITER //
CREATE FUNCTION GetTransactionData() RETURNS TABLE
AS
RETURN (
    SELECT customer_id, region_id, txn_date, txn_type, txn_amount
    FROM Transaction
);
//
DELIMITER ;

--12. Create a TRY...CATCH block to print a region id and region name in a single column.
BEGIN TRY
    SELECT region_id, region_name FROM Continent;
END TRY
BEGIN CATCH
    SELECT 'Error: ' + ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

--13. Create a TRY...CATCH block to insert a value in the Continent table.
BEGIN TRY
    INSERT INTO Continent (region_id, region_name) VALUES (100, 'Test Region');
END TRY
BEGIN CATCH
    SELECT 'Error: ' + ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

--14. Create a trigger to prevent deleting a table in a database.
CREATE TRIGGER PreventTableDeletion
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    RAISEERROR('Deleting tables is not allowed.', 16, 1);
    ROLLBACK;
END;

--15. Create a trigger to audit the data in a table.
CREATE TRIGGER AuditTransaction
ON Transaction
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO TransactionAudit (audit_date, audit_action)
    VALUES (GETDATE(), 'Transaction ' + EVENTDATA().action);
END;


--16. Create a trigger to prevent login of the same user id in multiple pages.
CREATE TRIGGER PreventMultiLogin
ON UserSessions
FOR INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM UserSessions U
        JOIN INSERTED I ON U.user_id = I.user_id
        WHERE U.session_id <> I.session_id
    )
    BEGIN
        RAISEERROR('User is already logged in on another page.', 16, 1);
        ROLLBACK;
    END;
END;

--17. Display top n customers on the basis of transaction type.
DECLARE @n INT = 10;
DECLARE @txn_type VARCHAR(50) = 'purchase';

SELECT TOP (@n) C.customer_id, C.region_id, T.txn_type, T.txn_amount
FROM Customers C
JOIN Transaction T ON C.customer_id = T.customer_id
WHERE T.txn_type = @txn_type
ORDER BY T.txn_amount DESC;

--18. Create a pivot table to display the total purchase, withdrawal and deposit for all the customers.
SELECT customer_id, region_id, [purchase], [withdrawal], [deposit]
FROM (
    SELECT customer_id, region_id, txn_type, txn_amount
    FROM Transaction
) AS SourceTable
PIVOT (
    SUM(txn_amount)
    FOR txn_type IN ([purchase], [withdrawal], [deposit])
) AS PivotTable;

