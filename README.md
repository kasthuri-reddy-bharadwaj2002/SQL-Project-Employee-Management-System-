# Employee Management System (SQL Project)

## 📌 Project Overview
The **Employee Management System (EMS)** is a SQL-based database project designed to manage employee information efficiently within an organization.  

The system organizes data related to employees, departments, job roles, qualifications, leaves, salaries, bonuses, and payroll processing using a **relational database structure**.

This project demonstrates how SQL can be used to:
- Structure organizational data
- Maintain data integrity using foreign keys
- Perform analytical queries
- Generate HR insights for decision-making

---

## 🎯 Objective
The objective of this project is to design a structured database system that:

- Stores employee details
- Tracks job roles and departments
- Maintains salary and bonus information
- Records employee qualifications
- Tracks leave history
- Processes payroll data

The system helps HR departments analyze workforce data and make informed management decisions.

---

## 🗂️ Database Schema

The system contains **6 interconnected tables**:

### 1️⃣ JobDepartment
Stores information about job roles and departments.

| Column | Description |
|------|-------------|
| JobID | Primary key for job roles |
| jobdept | Department name |
| name | Job role name |
| description | Role description |
| salaryrange | Salary range for the job |

---

### 2️⃣ Salary_Bonus
Stores salary and bonus information for each job role.

| Column | Description |
|------|-------------|
| salaryID | Primary key |
| JobID | Foreign key referencing JobDepartment |
| amount | Salary amount |
| annual | Annual salary |
| bonus | Bonus amount |

---

### 3️⃣ Employee
Stores employee personal details.

| Column | Description |
|------|-------------|
| empID | Primary key |
| firstname | Employee first name |
| lastname | Employee last name |
| gender | Gender |
| age | Employee age |
| contactAdd | Contact address |
| empemail | Employee email |
| emppass | Password |
| JobID | Foreign key referencing JobDepartment |

---

### 4️⃣ Qualification
Stores employee qualification details.

| Column | Description |
|------|-------------|
| QualID | Primary key |
| EmpID | Foreign key referencing Employee |
| Position | Job position |
| Requirements | Skills or requirements |
| Date_In | Qualification date |

---

### 5️⃣ Leaves
Tracks employee leave records.

| Column | Description |
|------|-------------|
| leaveID | Primary key |
| empID | Foreign key referencing Employee |
| date | Leave date |
| reason | Reason for leave |

---

### 6️⃣ Payroll
Combines salary, job, and leave data to calculate final payroll.

| Column | Description |
|------|-------------|
| payrollID | Primary key |
| empID | Employee ID |
| jobID | Job role ID |
| salaryID | Salary ID |
| leaveID | Leave ID |
| date | Payroll date |
| report | Payroll notes |
| totalamount | Final payroll amount |

---

## 🔗 Database Relationships

The database uses **foreign keys with cascading rules**:

- `Employee.JobID → JobDepartment.JobID`
- `Salary_Bonus.JobID → JobDepartment.JobID`
- `Qualification.EmpID → Employee.empID`
- `Leaves.empID → Employee.empID`
- `Payroll.empID → Employee.empID`
- `Payroll.jobID → JobDepartment.jobID`
- `Payroll.salaryID → Salary_Bonus.salaryID`
- `Payroll.leaveID → Leaves.leaveID`

These relationships ensure **data integrity and consistency**.

---

## 📊 Analysis Queries

This project includes several analytical SQL queries:

### Employee Insights
- Total number of employees
- Departments with the highest employees
- Average salary per department
- Top 5 highest-paid employees
- Total salary expenditure

### Job Role & Department Analysis
- Number of job roles in each department
- Departments with highest salary allocation
- Highest paying job roles

### Qualification & Skills Analysis
- Employees with qualifications
- Positions requiring the most qualifications
- Employees with the highest number of qualifications

### Leave & Absence Patterns
- Year with most leaves
- Average leave days per department
- Employees with the most leaves
- Total leave days company-wide

### Payroll Analysis
- Monthly payroll expenses
- Average bonus per department
- Department with highest bonuses
- Average payroll after leave deductions

---

## 💡 Business Insights

From the analysis:

- Departments with more employees have higher salary expenses.
- Certain job roles offer significantly higher compensation.
- Leave trends may indicate workload or seasonal patterns.
- Payroll varies depending on bonuses and leave deductions.

---

## 🧠 Challenges Faced

During the development of this project:

- Designing the **ER Diagram and relational schema**
- Writing **complex JOIN queries across multiple tables**
- Managing **foreign key constraints**
- Handling **date-based SQL analysis**
- Ensuring **data consistency during updates and deletes**

---

## 🛠️ Technologies Used

- **SQL**
- **MySQL / Relational Database**
- **Database Design (ER Modeling)**

---

## 📁 Project Structure


---

## 📈 Learning Outcomes

Through this project, I gained hands-on experience with:

- SQL database design
- Creating relational tables
- Foreign key relationships
- JOIN queries
- Aggregation functions
- HR data analysis using SQL

---

## 📌 Conclusion

The Employee Management System demonstrates how **SQL databases can efficiently organize and analyze employee data**.  

By combining structured tables, relational modeling, and analytical queries, the system helps generate meaningful insights for **HR management, payroll planning, and workforce analysis**.

---

## 👨‍💻 Author

**Balu Chebrolu**

Data Analyst
