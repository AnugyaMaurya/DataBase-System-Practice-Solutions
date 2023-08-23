--Using Assignment 2 Database for Assignment 3 as well since both are related queries
USE [customer_db];

/*
Module-4 Assignment
Tasks to be done:
1. Use the inbuilt functions and find the minimum, maximum and average amount from the orders table 
2. Create a user-defined function, which will multiply the given number with 10 
3. Use the case statement to check if 100 is less than 200, greater than 200 or equal to 200 and print the corresponding value
*/

SELECT * FROM [orders];

SElECT min(amount) as 'Minimum Amount',max(amount) as 'Maximum Amount' , avg(amount) as 'Average' 
from orders;

CREATE FUNCTION dbo.mult(@X int)
returns int 
as
begin
declare @Y int
set @Y = @X * 10;
return @Y
end

select dbo.mult(10);

--3. Use the case statement to check if 100 is less than 200, greater than 200 or equal to 200 and print the corresponding value
select o.*,(case when 100<200 then 'Shipped' when 100>200 then 'Not Yet Dispatched' when 100=200 then 'Delivered'
else 'OTHER' End) as 'CASE001' from orders o;

--4.Using a case statement, find the status of the amount. Set the statusof theamount as high amount, low amount or medium amount based uponthecondition.

SELECT
    order_id,
    amount,
    CASE
        WHEN amount > 1000 THEN 'High amount'
        WHEN amount <= 100 THEN 'Low amount'
        ELSE 'Medium amount'
    END AS amount_status
FROM Orders;

--Create a user-defined function, to fetch the amount greater thanthengiveninput.

CREATE FUNCTION GetAmountsGreaterThan(@inputAmount DECIMAL(10, 2))
RETURNS TABLE
AS
RETURN (
    SELECT order_id, amount
    FROM Orders
    WHERE amount > @inputAmount
);
