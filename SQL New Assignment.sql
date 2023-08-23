/*
SQL NEW Assignment
*/

/*
Create Employee table and Employee bonus table as given in the assignment document
*/

CREATE DATABASE NEW_ASSIGNMENT

create table Employee (Employee_id int Primary Key,First_name varchar(20),
Last_name varchar(20),salary float,joining_date datetime,Department varchar(20));

create table Employee_Bonus(Employee_ref_id int CONSTRAINT fk_group FOREIGN KEY (Employee_ref_id) 
REFERENCES Employee(Employee_id),Bonus_Amount float ,Bonus_Date datetime); 

create table Employee_title(Employee_ref_id int 
REFERENCES Employee(Employee_id),Employee_title varchar(20),Affective_Date datetime)

insert into Employee values 
(1,'Anika','Arora',100000,'2020-02-14 9:00:00','HR'),
(2,'Veena','Verma',80000,'2011-06-15 9:00:00','Admin'),
(3,'Vishal','Singhal',300000,'2020-02-16 9:00:00','HR'),
(4,'Sushanth','Singh',500000,'2020-02-17 9:00:00','Admin'),
(5,'Bhupal','Bhati',500000,'2011-06-18 9:00:00','Admin'),
(6,'Dheeraj','Diwan',200000,'2011-06-19 9:00:00','Account'),
(7,'Karan','Kumar',75000,'2020-01-14 9:00:00','Account'),
(8,'Chandrika','Chauhan',90000,'2011-04-15 9:00:00','Admin');

SELECT * FROM Employee

insert into Employee_Bonus values 
(1,5000,'2020-02-16 00:00:00'),
(2,3000,'2011-06-16 00:00:00'),
(3,4000,'2020-02-16 00:00:00'),
(1,4500,'2020-02-16 00:00:00'),
(2,3500,'2011-06-16 00:00:00');

SELECT * FROM Employee_Bonus


--1 Display the “FIRST_NAME” from Employee table using the alias name as Employee_name
select * from Employee;
select first_name as Employee_name from Employee;


--2 Display “LAST_NAME” from Employee table in upper case.
select UPPER(Last_name) as Last_name from Employee;

--3 Display unique values of DEPARTMENT from EMPLOYEE table.
select distinct department from Employee;

--4 Display the first three characters of LAST_NAME from EMPLOYEE table.
select SUBSTRING(last_name,0,4) from Employee;

--5 Display the unique values of DEPARTMENT from EMPLOYEE table and prints its length.
select distinct department from Employee;
SELECT distinct LEN(department) AS LengthOfName from Employee;

--6 Display the FIRST_NAME and LAST_NAME from EMPLOYEE table into a single column AS FULL_NAME. a space char should separate them.
select * from Employee;
select first_name ,last_name , CONCAT(first_name, ' ',last_name) as FULL_NAME from Employee;

--7 DISPLAY all EMPLOYEE details from the employee table order by FIRST_NAME Ascending.
select * from Employee order by First_name ASC;

--8. Display all EMPLOYEE details order by FIRST_NAME Ascending and DEPARTMENT Descending
select * from Employee order by  Department DESC , First_name ASC ;

--9 Display details for EMPLOYEE with the first name as “VEENA” and “KARAN” from EMPLOYEE table.
select * from EMployee where first_name in ('VEENA','KARAN');

--10 Display details of EMPLOYEE with DEPARTMENT name as “Admin”.
select * from Employee where Department = 'Admin';

--11 DISPLAY details of the EMPLOYEES whose FIRST_NAME contains ‘V’
select * from Employee where First_name like '%v%';

--12 DISPLAY details of the EMPLOYEES whose SALARY lies between 100000 and 500000
select * from Employee where salary between 100000 and 500000;

--13 Display details of the employees who have joined in Feb-2020.select * from Employee where joining_date like 'Feb%';

--14 Display employee names with salaries >= 50000 and <= 100000.select first_name +' '+last_name as 'Employee Name' from Employee where salary >=50000 and salary<=100000;

--16 DISPLAY details of the EMPLOYEES who are also Managers.select * from Employee e inner join Employee_title et on e.Employee_id = et.Employee_ref_id where Employee_title='Manager';

--17 DISPLAY duplicate records having matching data in some fields of a table
select count(*),Employee_title  from Employee_title group by Employee_title having count(*) > 1;


--18 Display only odd rows from a table.
select * from (select *,ROW_NUMBER () over(order by employee_id asc) row_number from employee) a where (row_number % 2) = 1;

--19 Clone a new table from EMPLOYEE table.
select * into Employee_New from Employee;

--20 DISPLAY the TOP 2 highest salary from a table.
select Top 2 salary from Employee order by salary desc;

--21. DISPLAY the list of employees with the same salary
select * from employee where salary in (select salary from Employee group by salary having count(*) >1);


--22 Display the second highest salary from a table.
select max(salary) from employee where salary not in (select max(salary) from Employee);

--23 Display the first 50% records from a table
SELECT TOP 50 PERCENT * FROM   Employee;

--24. Display the departments that have less than 4 people in it.
select count(*) as 'No Of People',department from employee group by Department having count(*) < 4;

--25. Display all departments along with the number of people in there.
select count(*) as 'No Of People',department from employee group by Department;

--26 Display the name of employees having the highest salary in each department.
select first_name +' '+last_name as 'Employee Name',Department from employee where salary in (select max(Salary) from employee group by Department);

--27 Display the names of employees who earn the highest salary.
select first_name +' '+last_name as 'Employee Name' from employee where salary in (select max(salary) from employee);

--28 Diplay the average salaries for each department
select avg(Salary) as 'Average Salaries',department from employee group by Department;

--29 display the name of the employee who has got maximum bonus
select first_name +' '+last_name as 'Employee Name' from Employee obj inner join 
Employee_Bonus eb on obj.Employee_id = eb.Employee_ref_id where eb.bonus_amount in (select max(bonus_amount) from Employee_Bonus)

--30 Display the first name and title of all the employees
select first_name , Employee_title from employee e inner join Employee_title et on e.Employee_id = et.Employee_ref_id;
