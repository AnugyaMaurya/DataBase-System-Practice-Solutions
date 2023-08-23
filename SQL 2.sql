CREATE TABLE LOCATION (
    Location_ID INT PRIMARY KEY,
    City VARCHAR(50)
);

INSERT INTO LOCATION (Location_ID, City) VALUES
    (122, 'New York'),
    (123, 'Dallas'),
    (124, 'Chicago'),
    (167, 'Boston');

CREATE TABLE department (
    Department_Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Location_Id INT,
    FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);

CREATE TABLE JOB (
    Job_ID INT PRIMARY KEY,
    Designation VARCHAR(50)
);

INSERT INTO department (Department_Id, Name, Location_Id) VALUES
    (10, 'Accounting', 122),
    (20, 'Sales', 124),
    (30, 'Research', 123),
    (40, 'Operations', 167);

INSERT INTO JOB (Job_ID, Designation) VALUES
    (667, 'Clerk'),
    (668, 'Staff'),
    (669, 'Analyst'),
    (670, 'Sales Person'),
    (671, 'Manager'),
    (672, 'President');

CREATE TABLE EMPLOYEE (
    Employee_Id INT PRIMARY KEY,
    Last_Name VARCHAR(50),
    First_Name VARCHAR(50),
    Middle_Name VARCHAR(50),
    Job_Id INT,
    Hire_Date DATE,
    Salary DECIMAL(10, 2),
    Commission DECIMAL(10, 2),
    Department_Id INT,
    FOREIGN KEY (Job_Id) REFERENCES JOB(Job_ID),
    FOREIGN KEY (Department_Id) REFERENCES department(Department_Id)
);

INSERT INTO EMPLOYEE (Employee_Id, Last_Name, First_Name, Middle_Name, Job_Id, Hire_Date, Salary, Commission, Department_Id) VALUES
    (7369, 'Smith', 'John', 'Q', 667, '1984-12-17', 800.00, NULL, 20),
    (7499, 'Allen', 'Kevin', 'J', 670, '1985-02-20', 1600.00, 300.00, 30),
    (7555, 'Doyle', 'Jean', 'K', 671, '1985-04-04', 2850.00, NULL, 30),
    (7556, 'Dennis', 'Lynn', 'S', 671, '1985-05-15', 2750.00, NULL, 30),
    (7557, 'Baker', 'Leslie', 'D', 671, '1985-06-10', 2200.00, NULL, 40),
    (7521, 'Wark', 'Cynthia', 'D', 670, '1985-02-22', 1250.00, 50.00, 30);


--1. List all the employee details.
SELECT * FROM EMPLOYEE;

-- 2. List all the department details. 
SELECT * FROM department;

--3. List all job details. 
SELECT * FROM JOB;

--4.List all the locations. 
SELECT * FROM LOCATION;

--5.list out the First Name, Last Name, Salary, Commission for allEmployees.
SELECT First_Name, Last_Name, Salary, Commission FROM EMPLOYEE;

-- 6. List out the Employee ID, Last Name, Department ID for all employeesandalias Employee ID as "ID of the Employee", Last Name as "Name of theEmployee", Department ID as "Dep_id". 
SELECT 
    Employee_Id AS "ID of the Employee",
    Last_Name AS "Name of the Employee",
    Department_Id AS "Dep_id"
FROM EMPLOYEE;

--7. List out the annual salary of the employees with their names only.
SELECT CONCAT(First_Name, ' ', Last_Name) AS Employee_Name, Salary * 12 AS Annual_Salary
FROM EMPLOYEE;

--WHERE QUESTIONS
--1. List the details about "Smith". 
SELECT * FROM EMPLOYEE WHERE Last_Name = 'Smith';

--2. List out the employees who are working in department 20. 
SELECT * FROM EMPLOYEE WHERE Department_Id = 20;

--3. List out the employees who are earning salaries between 3000and4500. 
SELECT * FROM EMPLOYEE WHERE Salary BETWEEN 3000 AND 4500;

--4. List out the employees who are working in department 10 or 20. 
SELECT * FROM EMPLOYEE WHERE Department_Id IN (10, 20);

--5. Find out the employees who are not working in department 10 or 30.
SELECT * FROM EMPLOYEE WHERE Department_Id NOT IN (10, 30);

 --6. List out the employees whose name starts with 'S'.
SELECT * FROM EMPLOYEE WHERE First_Name LIKE 'S%';

--7.List out the employees whose name starts with 'S' and ends with'H'. 
SELECT * FROM EMPLOYEE WHERE First_Name LIKE 'S%h';

--8. List out the employees whose name length is 4 and start with 'S'. 
SELECT * FROM EMPLOYEE WHERE First_Name LIKE 'S___';

--9. List out employees who are working in department 10 and drawsalariesmorethan 3500. 
SELECT * FROM EMPLOYEE WHERE Department_Id = 10 AND Salary > 3500;

--10. List out the employees who are not receiving commission
SELECT * FROM EMPLOYEE WHERE Commission IS NULL;

--ORDER BY Clause:
--1. List out the Employee ID and Last Name in ascending order basedontheEmployee ID. 
SELECT Employee_Id, Last_Name FROM EMPLOYEE ORDER BY Employee_Id ASC;

--2. List out the Employee ID and Name in descending order based onsalary. 
SELECT Employee_Id, CONCAT(First_Name, ' ', Last_Name) AS Name FROM EMPLOYEE ORDER BY Salary DESC;

--3. List out the employee details according to their Last Name in ascending-order.
SELECT * FROM EMPLOYEE ORDER BY Last_Name ASC;

--4. List out the employee details according to their Last Name in ascendingorder and then Department ID in descending order.
SELECT * FROM EMPLOYEE ORDER BY Last_Name ASC, Department_Id DESC;

--GROUP BY and HAVING Clause:
--1. How many employees are in different departments in theorganization?
SELECT Department_Id, COUNT(*) AS Employee_Count FROM EMPLOYEE GROUP BY Department_Id;

--2. List out the department wise maximum salary, minimumsalary andaverage salary of the employees. 
SELECT Department_Id, MAX(Salary) AS Max_Salary, MIN(Salary) AS Min_Salary, AVG(Salary) AS Avg_Salary
FROM EMPLOYEE GROUP BY Department_Id;

--3. List out the job wise maximum salary, minimum salary and averagesalary of the employees. 
SELECT Job_Id, MAX(Salary) AS Max_Salary, MIN(Salary) AS Min_Salary, AVG(Salary) AS Avg_Salary
FROM EMPLOYEE GROUP BY Job_Id;

--4. List out the number of employees who joined each month in ascendingorder.
SELECT EXTRACT(MONTH FROM Hire_Date) AS Join_Month, COUNT(*) AS Employee_Count
FROM EMPLOYEE GROUP BY Join_Month ORDER BY Join_Month;

--5. List out the number of employees for each month and year in ascending order based on the year and month.
SELECT EXTRACT(YEAR FROM Hire_Date) AS Join_Year, EXTRACT(MONTH FROM Hire_Date) AS Join_Month, COUNT(*) AS Employee_Count
FROM EMPLOYEE GROUP BY Join_Year, Join_Month ORDER BY Join_Year, Join_Month;

 --6. List out the Department ID having at least four employees. 
SELECT Department_Id, COUNT(*) AS Employee_Count FROM EMPLOYEE GROUP BY Department_Id HAVING Employee_Count >= 4;

--7. How many employees joined in the month of January?
SELECT COUNT(*) AS January_Join_Count FROM EMPLOYEE WHERE EXTRACT(MONTH FROM Hire_Date) = 1;

--8. How many employees joined in the month of January orSeptember?
SELECT COUNT(*) AS Jan_Sep_Join_Count FROM EMPLOYEE WHERE EXTRACT(MONTH FROM Hire_Date) IN (1, 9);

--9. How many employees joined in 1985?
SELECT COUNT(*) AS Join_1985_Count FROM EMPLOYEE WHERE EXTRACT(YEAR FROM Hire_Date) = 1985;

--10. How many employees joined each month in 1985?
SELECT EXTRACT(MONTH FROM Hire_Date) AS Join_Month, COUNT(*) AS Employee_Count
FROM EMPLOYEE WHERE EXTRACT(YEAR FROM Hire_Date) = 1985 GROUP BY Join_Month;

--11. How many employees joined in March 1985?
SELECT COUNT(*) AS Mar_1985_Join_Count FROM EMPLOYEE WHERE EXTRACT(YEAR FROM Hire_Date) = 1985 AND EXTRACT(MONTH FROM Hire_Date) = 3;

--12. Which is the Department ID having greater than or equal to 3 employeesjoining in April 1985?
SELECT Department_Id FROM EMPLOYEE WHERE EXTRACT(YEAR FROM Hire_Date) = 1985 AND EXTRACT(MONTH FROM Hire_Date) = 4
GROUP BY Department_Id HAVING COUNT(*) >= 3;

--Joins:
--1. List out employees with their department names. 
SELECT E.*, D.Name AS Department_Name
FROM EMPLOYEE E
JOIN department D ON E.Department_Id = D.Department_Id;

--2. Display employees with their designations. 
SELECT E.*, J.Designation
FROM EMPLOYEE E
JOIN JOB J ON E.Job_Id = J.Job_ID;

--3. Display the employees with their department names and regional groups.
SELECT E.*, D.Name AS Department_Name, L.City AS Regional_Group
FROM EMPLOYEE E
JOIN department D ON E.Department_Id = D.Department_Id
JOIN LOCATION L ON D.Location_Id = L.Location_ID;

-- 4. How many employees are working in different departments? Displaywithdepartment names. 
SELECT D.Name AS Department_Name, COUNT(*) AS Employee_Count
FROM EMPLOYEE E
JOIN department D ON E.Department_Id = D.Department_Id
GROUP BY D.Name;

--5. How many employees are working in the sales department?
SELECT COUNT(*) AS Sales_Employee_Count
FROM EMPLOYEE E
JOIN department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Sales';

--6. Which is the department having greater than or equal to 5 employees? Display the department names in ascending order. 
SELECT D.Name AS Department_Name
FROM EMPLOYEE E
JOIN department D ON E.Department_Id = D.Department_Id
GROUP BY D.Name
HAVING COUNT(*) >= 5
ORDER BY Department_Name ASC;

--7. How many jobs are there in the organization? Display with designations.
SELECT COUNT(*) AS Job_Count, J.Designation
FROM JOB J;

 --8. How many employees are working in "New York"?
SELECT COUNT(*) AS Employees_In_NY
FROM EMPLOYEE E
JOIN department D ON E.Department_Id = D.Department_Id
JOIN LOCATION L ON D.Location_Id = L.Location_ID
WHERE L.City = 'New York';

--9. Display the employee details with salary grades. Use conditional statementtocreate a grade column. 
SELECT E.*, 
       CASE
           WHEN Salary >= 5000 THEN 'A'
           WHEN Salary >= 3000 THEN 'B'
           ELSE 'C'
       END AS Salary_Grade
FROM EMPLOYEE E;

--10. List out the number of employees grade wise. Use conditional statementtocreate a grade column.
SELECT 
    CASE
        WHEN Salary >= 5000 THEN 'A'
        WHEN Salary >= 3000 THEN 'B'
        ELSE 'C'
    END AS Salary_Grade,
    COUNT(*) AS Employee_Count
FROM EMPLOYEE
GROUP BY Salary_Grade;
 
--11.Display the employee salary grades and the number of employees between 2000 to 5000 range of salary. 
SELECT 
    CASE
        WHEN Salary >= 5000 THEN 'A'
        WHEN Salary >= 3000 THEN 'B'
        ELSE 'C'
    END AS Salary_Grade,
    COUNT(*) AS Employee_Count
FROM EMPLOYEE
WHERE Salary BETWEEN 2000 AND 5000
GROUP BY Salary_Grade;


--12. Display all employees in sales or operation departments
SELECT E.*, D.Name AS Department_Name
FROM EMPLOYEE E
JOIN department D ON E.Department_Id = D.Department_Id
WHERE D.Name IN ('Sales', 'Operations');


--SET Operators:
--1. List out the distinct jobs in sales and accounting departments. 
SELECT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN department D ON E.Department_Id = D.Department_Id
WHERE D.Name IN ('Sales', 'Accounting')
GROUP BY J.Designation;

--2. List out all the jobs in sales and accounting departments. 
SELECT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN department D ON E.Department_Id = D.Department_Id
WHERE D.Name IN ('Sales', 'Accounting');

--3. List out the common jobs in research and accounting departments in ascending order
SELECT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Research'
INTERSECT
SELECT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Accounting'
ORDER BY J.Designation ASC;

--Subqueries:
--1. Display the employees list who got the maximum salary
SELECT Employee_Id, First_Name, Last_Name, Salary
FROM EMPLOYEE
WHERE Salary = (SELECT MAX(Salary) FROM EMPLOYEE);

--2. Display the employees who are working in the sales department. 
SELECT Employee_Id, First_Name, Last_Name
FROM EMPLOYEE
WHERE Department_Id = (SELECT Department_Id FROM department WHERE Name = 'Sales');

--3. Display the employees who are working as 'Clerk'. 
SELECT Employee_Id, First_Name, Last_Name
FROM EMPLOYEE
WHERE Job_Id = (SELECT Job_ID FROM JOB WHERE Designation = 'Clerk');

--4. Display the list of employees who are living in "New York". 
SELECT Employee_Id, First_Name, Last_Name
FROM EMPLOYEE
WHERE Department_Id = (SELECT Department_Id FROM department WHERE Name = 'New York');

--5. Find out the number of employees working in the sales department. 
SELECT COUNT(*) AS Sales_Employee_Count
FROM EMPLOYEE
WHERE Department_Id = (SELECT Department_Id FROM department WHERE Name = 'Sales');

--6. Update the salaries of employees who are working as clerks on thebasisof 10%. 
UPDATE EMPLOYEE
SET Salary = Salary * 1.1
WHERE Job_Id = (SELECT Job_ID FROM JOB WHERE Designation = 'Clerk');

--7. Delete the employees who are working in the accounting department.
DELETE FROM EMPLOYEE
WHERE Department_Id = (SELECT Department_Id FROM department WHERE Name = 'Accounting');

 --8. Display the second highest salary drawing employee details. 
SELECT Employee_Id, First_Name, Last_Name, Salary
FROM EMPLOYEE
WHERE Salary = (SELECT MAX(Salary) FROM EMPLOYEE WHERE Salary < (SELECT MAX(Salary) FROM EMPLOYEE));

--9. Display the nth highest salary drawing employee details. 
SELECT Employee_Id, First_Name, Last_Name, Salary
FROM EMPLOYEE
WHERE Salary = (SELECT DISTINCT Salary FROM EMPLOYEE ORDER BY Salary DESC LIMIT 1 OFFSET n-1);

--10. List out the employees who earn more than every employee in department 30.
SELECT Employee_Id, First_Name, Last_Name
FROM EMPLOYEE
WHERE Salary > ALL (SELECT Salary FROM EMPLOYEE WHERE Department_Id = 30);

--11. List out the employees who earn more than the lowest salary in department.Find out whose department has no employees.
SELECT Employee_Id, First_Name, Last_Name
FROM EMPLOYEE
WHERE Salary > (SELECT MIN(Salary) FROM EMPLOYEE WHERE Department_Id = E.Department_Id);

 --12. Find out which department has no employees. 
SELECT Name AS Department_Name
FROM department D
WHERE NOT EXISTS (SELECT 1 FROM EMPLOYEE E WHERE E.Department_Id = D.Department_Id);

--13. Find out the employees who earn greater than the average salary for their department.
SELECT Employee_Id, First_Name, Last_Name
FROM EMPLOYEE E
WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEE WHERE Department_Id = E.Department_Id);

