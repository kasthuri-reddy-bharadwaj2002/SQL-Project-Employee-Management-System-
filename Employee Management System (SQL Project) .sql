create database sql_project;
use sql_project;

-- Table 1: Job Department 
CREATE TABLE JobDepartment ( 
    JobID INT PRIMARY KEY, 
    jobdept VARCHAR(50), 
    name VARCHAR(100), 
    description TEXT, 
    salaryrange VARCHAR(50) 
    
); 

select * from JobDepartment;

-- Table 2: Salary/Bonus 
CREATE TABLE Salary_Bonus ( 
    salaryID INT PRIMARY KEY, 
    JobID INT, 
    amount DECIMAL(10,2), 
    annual DECIMAL(10,2), 
    bonus DECIMAL(10,2), 
    CONSTRAINT fk_salary_job FOREIGN KEY (JobID) REFERENCES JobDepartment(JobID) 
        ON DELETE CASCADE ON UPDATE CASCADE 
        
); 

select * from Salary_Bonus;

-- Table 3: Employee 
CREATE TABLE Employee ( 
    empID INT PRIMARY KEY, 
    firstname VARCHAR(50), 
    lastname VARCHAR(50), 
    gender VARCHAR(10), 
    age INT, 
    contactAdd VARCHAR(100), 
    empemail VARCHAR(100) UNIQUE, 
    emppass VARCHAR(50), 
    JobID INT, 
    CONSTRAINT fk_employee_job FOREIGN KEY (JobID) 
        REFERENCES JobDepartment(JobID) 
        ON DELETE SET NULL 
        ON UPDATE CASCADE 
); 
select * from Employee;

 -- Table 4: Qualification 
CREATE TABLE Qualification ( 
    QualID INT PRIMARY KEY, 
    EmpID INT, 
    Position VARCHAR(50), 
    Requirements VARCHAR(255), 
    Date_In DATE, 
    CONSTRAINT fk_qualification_emp FOREIGN KEY (EmpID) 
        REFERENCES Employee(empID) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE 
); 
select * from Qualification;

 -- Table 5: Leaves 
CREATE TABLE Leaves ( 
    leaveID INT PRIMARY KEY, 
    empID INT, 
    date DATE, 
    reason TEXT, 
    CONSTRAINT fk_leave_emp FOREIGN KEY (empID) REFERENCES Employee(empID) 
        ON DELETE CASCADE ON UPDATE CASCADE 
); 
select * from Leaves;

 -- Table 6: Payroll 
CREATE TABLE Payroll ( 
    payrollID INT PRIMARY KEY, 
    empID INT, 
    jobID INT, 
    salaryID INT, 
    leaveID INT, 
    date DATE, 
    report TEXT, 
    totalamount DECIMAL(10,2), 
    CONSTRAINT fk_payroll_emp FOREIGN KEY (empID) REFERENCES Employee(empID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_payroll_job FOREIGN KEY (jobID) REFERENCES JobDepartment(jobID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_payroll_salary FOREIGN KEY (salaryID) REFERENCES 
Salary_Bonus(salaryID) 
        ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_payroll_leave FOREIGN KEY (leaveID) REFERENCES Leaves(leaveID) 
        ON DELETE SET NULL ON UPDATE CASCADE 
);
select * from Payroll;

-- 1. EMPLOYEE INSIGHTS 
-- ● How many unique employees are currently in the system? 
select count(*) as Total_employees from employee;

-- ● Which departments have the highest number of employees? 
SELECT 
    jd.jobdept AS department_name,
    COUNT(e.empID) AS employee_count
FROM JobDepartment jd
LEFT JOIN Employee e
    ON jd.JobID = e.JobID
GROUP BY jd.jobdept
ORDER BY employee_count DESC;

-- ● What is the average salary per department? 
SELECT jd.jobdept, AVG(sb.amount) AS avg_salary
FROM JobDepartment jd
JOIN Salary_Bonus sb ON sb.JobID = jd.JobID
GROUP BY jd.jobdept
ORDER BY avg_salary DESC;

-- ● Who are the top 5 highest-paid employees? 
SELECT e.empID, e.firstname, e.lastname, sb.amount
FROM Employee e
JOIN Salary_Bonus sb ON sb.JobID = e.JobID
ORDER BY sb.amount DESC
LIMIT 5;

-- ● What is the total salary expenditure across the company?
SELECT SUM(sb.amount) AS total_salary
FROM Employee e
JOIN Salary_Bonus sb ON sb.JobID = e.JobID;

-- 2. JOB ROLE AND DEPARTMENT ANALYSIS 
-- ● How many different job roles exist in each department? 
SELECT jobdept, COUNT(*) AS roles_count
FROM JobDepartment
GROUP BY jobdept;

-- ● What is the average salary range per department? 

SELECT 
    jobdept,
    MIN(amount) AS Min_Salary,
    MAX(amount) AS Max_Salary,
    (MAX(amount) - MIN(amount)) AS Salary_Range
FROM JobDepartment jd 
JOIN Salary_Bonus sb 
    ON jd.JobID = sb.JobID
GROUP BY jobdept;

-- ● Which job roles offer the highest salary? 

SELECT jd.jobdept, jd.name AS job_role, sb.amount
FROM JobDepartment jd
JOIN Salary_Bonus sb ON sb.JobID = jd.JobID
ORDER BY sb.amount DESC
LIMIT 10;

-- ● Which departments have the highest total salary allocation?

SELECT jd.jobdept, SUM(sb.amount) AS total_alloc
FROM Employee e
JOIN JobDepartment jd ON jd.JobID = e.JobID
JOIN Salary_Bonus sb ON sb.JobID = e.JobID
GROUP BY jd.jobdept
ORDER BY total_alloc DESC;

-- 3. QUALIFICATION AND SKILLS ANALYSIS 
-- ● How many employees have at least one qualification listed?
 
SELECT COUNT(DISTINCT EmpID) AS employees_with_quals FROM Qualification;

-- ● Which positions require the most qualifications? 

SELECT Position, COUNT(*) AS qual_count
FROM Qualification
GROUP BY Position
ORDER BY qual_count DESC;

-- ● Which employees have the highest number of qualifications?

SELECT  EmpID, COUNT(*)
FROM Qualification
GROUP BY EmpID
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 4. LEAVE AND ABSENCE PATTERNS 
-- ● Which year had the most employees taking leaves? 

SELECT YEAR(date), COUNT(DISTINCT EmpID)
FROM Leaves
GROUP BY YEAR(date)
ORDER BY COUNT(*) DESC;

-- ● What is the average number of leave days taken by its employees per department? 

select j.jobdept, AVG(extract(day from date)) as avg_leave from leaves l
join employee e on l.empid=e.empid
join jobdepartment j on e.jobid=j.jobid
group by j.jobdept;

-- ● Which employees have taken the most leaves? 

select e.empid, sum(extract(day from l.date)) as most_leaves
from leaves l join employee e on l.empid = e.empid
group by e.empid
order by most_leaves desc;

-- ● What is the total number of leave days taken company-wide? 

select j.jobdept, sum(extract(day from l.date)) as total_leaves
from leaves l
join employee e on l.empid=e.empid
join jobdepartment j on j.jobid=e.jobid
group by j.jobdept
order by total_leaves desc;

-- ● How do leave days correlate with payroll amounts?

select p.empid, extract(day from l.date) as leave_day,
p.date as pay_roll_date, totalamount
from leaves l
join payroll p on l.leaveid = p.leaveid;

-- 5. PAYROLL AND COMPENSATION ANALYSIS 
-- ● What is the total monthly payroll processed? 

select extract(year from date) as year,
extract(month from date) as month,
sum(totalamount) as total from payroll
group by extract(year from date), extract(month from date)
order by year, month;

-- ● What is the average bonus given per department? 

select j.jobdept, avg(s.bonus) as avg_bonus
from jobdepartment j join salary_bonus s on j.jobid = s.jobid
group by j.jobdept;

-- ● Which department receives the highest total bonuses? 

select j.jobdept, sum(s.bonus) as total_bonus
from jobdepartment j join salary_bonus s on j.jobid = s.jobid
group by j.jobdept
order by total_bonus desc
limit 1;

-- ● What is the average value of total_amount after considering leave deductions?

select avg(totalamount) as avg_value from payroll;