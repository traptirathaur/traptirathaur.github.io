---Creating Database;
create database employee_data_management_system;
use employee_data_management_system;

create table Employee (
	EmployeeID int primary key,
	FirstName varchar(50),
	LastName varchar(50),
	Department varchar(50),
	Salary decimal(10,2),
	HireDate date
)
create table Departments (
	DepartmentID int primary key,
	DepartmentName varchar(50)
);

---Inserting Data;
insert into Employee (EmployeeID, FirstName, LastName, Department, Salary, HireDate) values
(1, 'John', 'Doe', 'Sales', 60000.00, '2020-01-15'),
(2, 'Jane', 'Smith', 'Marketing', 70000.00, '2019-03-22'),
(3, 'Mike', 'Johnson', 'Sales', 50000.00, '2021-06-10'),
(4, 'Emily', 'Davis', 'IT', 90000.00, '2022-07-01'),
(5, 'Chris', 'Brown', 'IT', 95000.00, '2018-11-20'),
(6, 'Katie', 'Wilson', 'HR', 55000.00, '2021-02-18'),
(7, 'James', 'Garcia', 'HR', 62000.00, '2020-05-30')

Insert into Departments (DepartmentID, DepartmentName) values
(1, 'Sales'),
(2, 'Marketing'),
(3, 'IT'),
(4, 'HR');


------------------Quering Only "Employee" Dataset;

---Basic Queries;

---Select All Records;
select * from Employee;

---Filter Records;
select * from Employee where Department = 'Sales';

---Sort Records;
select * from Employee order by Salary desc;

------------------Aggregate Functions;

---Count Employees;
select count(*) as TotalEmployees from Employee;

---Average Salary;
select avg(Salary) as AverageSalary from Employee;

------------------Group By;

---Total Salary by Department;
select Department, sum(Salary) as TotalSalary from Employee group by Department;

------------------CTE

---Using CTE for Average Salary;
with AverageSalaries as (
	select Department, avg(Salary) as AverageSalary
	from Employee
	Group by Department
)
select * from AverageSalaries;

------------------Window Fns;

---Salary Rank by Department;
select FirstName, LastName, Salary,
	rank() over (partition by Department order by Salary desc) as SalaryRank
from Employee;

---Top 2 Salary in Each Department;
with RankedSalaries as (
	select FirstName, LastName, Department, Salary,
		ROW_NUMBER() over (partition by Department order by Salary desc) as Rank
	from Employee
)
select * from RankedSalaries where Rank <=2;

---Inner Join;
select e.FirstName, e.LastName, d.DepartmentName
from Employee e
Inner Join Departments d on e.Department = d.DepartmentName;

---Left Join;
SELECT e.FirstName, e.LastName, d.DepartmentName
FROM Employee e
LEFT JOIN Departments d ON e.Department = d.DepartmentName;

---Right Join;
SELECT e.FirstName, e.LastName, d.DepartmentName
FROM Employee e
RIGHT JOIN Departments d ON e.Department = d.DepartmentName;

---Full Join;
SELECT e.FirstName, e.LastName, d.DepartmentName
FROM Employee e
FULL JOIN Departments d ON e.Department = d.DepartmentName;

---Cross Join;
SELECT e.FirstName, d.DepartmentName
FROM Employee e
CROSS JOIN Departments d;

---Self Join;
select e1.FirstName as Employee, e2.Firstname as Colleague
from Employee e1
Inner Join Employee e2 on e1.Department = e2.Department and e1.Salary > e2.Salary;

---Combined Query;

WITH EmployeeDetails AS (
	SELECT e.EmployeeID, e.FirstName, e.Lastname, e.Department, e.Salary, e.HireDate, d.DepartmentID, d.DepartmentName
	FROM Employee e
	LEFT JOIN Departments d ON e.Department = d.DepartmentName
),
RankedSalaries AS (
	SELECT FirstName, LastName, Department, Salary,
		RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
)

SELECT ed.FirstName, ed.LastName, ed.DepartmentName, ed.Salary, rs.SalaryRank,
		AVG(ed.Salary) OVER (PARTITION BY ed.Department) AS AvgDepartmentSalary
FROM EmployeeDetails ed
LEFT JOIN RankedSalaries rs ON ed.FirstName = rs.FirstName AND ed.LastName = rs.LastName
ORDER BY ed.Department, rs.SalaryRank;
