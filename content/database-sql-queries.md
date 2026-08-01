# 🗄️ Database & SQL Queries - Từ Cơ Bản Đến Nâng Cao
> Tài liệu tổng hợp các câu truy vấn SQL mẫu từ cơ bản đến nâng cao, phù hợp cho việc học tập và tham khảo.
---
## Mục Lục
1. [Giới Thiệu](#1-giới-thiệu)
2. [Khởi Tạo Dữ Liệu Mẫu](#2-khởi-tạo-dữ-liệu-mẫu)
3. [SQL Cơ Bản](#3-sql-cơ-bản)
4. [SQL Trung Bình](#4-sql-trung-bình)
5. [SQL Nâng Cao](#5-sql-nâng-cao)
6. [Thao Tác Dữ Liệu](#6-thao-tác-dữ-liệu)
7. [Định Nghĩa Dữ Liệu](#7-định-nghĩa-dữ-liệu)
8. [Tối Ưu Hiệu Năng](#8-tối-ưu-hiệu-năng)
9. [Bảo Mật Và Phân Quyền](#9-bảo-mật-và-phân-quyền)
10. [Mẫu Truy Vấn Thực Tế](#10-mẫu-truy-vấn-thực-tế)
---
## 1. Giới Thiệu
Tài liệu này bao gồm các ví dụ SQL từ cơ bản đến nâng cao, được thiết kế để:
- ✅ Học viên mới bắt đầu làm quen với SQL
- ✅ Developer cần tham khảo các mẫu query thông dụng
- ✅ DBA tìm hiểu các kỹ thuật tối ưu và quản trị database
**Database sử dụng trong ví dụ:** MySQL/PostgreSQL (có thể điều chỉnh cho SQL Server, Oracle)
---
## 2. Khởi Tạo Dữ Liệu Mẫu
### 2.1. Tạo Database và Tables
```sql
-- Tạo database mẫu
CREATE DATABASE IF NOT EXISTS sample_db;
USE sample_db;
-- Bảng Departments (Phòng ban)
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Bảng Employees (Nhân viên)
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    dept_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE,
    manager_id INT,
    status ENUM('active', 'inactive', 'terminated') DEFAULT 'active',
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);
-- Bảng Projects (Dự án)
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(200) NOT NULL,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(15, 2),
    status ENUM('planning', 'in_progress', 'completed', 'cancelled') DEFAULT 'planning',
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
-- Bảng Employee_Projects (Phân công nhân viên vào dự án)
CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT,
    role VARCHAR(50),
    assigned_date DATE,
    hours_worked DECIMAL(5, 2) DEFAULT 0,
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);
-- Bảng Salaries (Lịch sử lương)
CREATE TABLE salaries (
    salary_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    salary_amount DECIMAL(10, 2),
    effective_date DATE,
    end_date DATE,
    changed_by INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (changed_by) REFERENCES employees(emp_id)
);
-- Bảng Attendance (Chấm công)
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    attendance_date DATE,
    check_in TIME,
    check_out TIME,
    status ENUM('present', 'absent', 'late', 'half_day', 'on_leave'),
    notes TEXT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
-- Bảng Performance_Reviews (Đánh giá hiệu suất)
CREATE TABLE performance_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    reviewer_id INT,
    review_date DATE,
    rating DECIMAL(3, 2),
    comments TEXT,
    next_review_date DATE,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (reviewer_id) REFERENCES employees(emp_id)
);
```
### 2.2. Insert Dữ Liệu Mẫu
```sql
-- Insert Departments
INSERT INTO departments (dept_name, location) VALUES
('IT', 'Building A'),
('HR', 'Building B'),
('Finance', 'Building A'),
('Marketing', 'Building C'),
('Sales', 'Building B'),
('Operations', 'Building D');
-- Insert Employees (21 nhân viên)
INSERT INTO employees (emp_name, email, phone, dept_id, salary, hire_date, manager_id, status) VALUES
('Nguyen Van A', 'a.nguyen@company.com', '0901001001', 1, 25000000, '2020-01-15', NULL, 'active'),
('Tran Thi B', 'b.tran@company.com', '0901001002', 1, 20000000, '2021-03-20', 1, 'active'),
('Le Van C', 'c.le@company.com', '0901001003', 1, 18000000, '2022-06-10', 1, 'active'),
('Pham Thi D', 'd.pham@company.com', '0901001004', 1, 22000000, '2021-09-05', 1, 'active'),
('Hoang Van E', 'e.hoang@company.com', '0901001005', 1, 15000000, '2023-02-01', 2, 'active'),
('Vo Thi F', 'f.vo@company.com', '0901002001', 2, 18000000, '2019-05-10', NULL, 'active'),
('Dang Van G', 'g.dang@company.com', '0901002002', 2, 15000000, '2020-08-15', 6, 'active'),
('Bui Thi H', 'h.bui@company.com', '0901002003', 2, 12000000, '2022-01-20', 6, 'active'),
('Ngo Van I', 'i.ngo@company.com', '0901003001', 3, 22000000, '2018-11-01', NULL, 'active'),
('Do Thi J', 'j.do@company.com', '0901003002', 3, 19000000, '2020-04-15', 9, 'active'),
('Dinh Van K', 'k.dinh@company.com', '0901003003', 3, 17000000, '2021-07-20', 9, 'active'),
('Ly Thi L', 'l.ly@company.com', '0901004001', 4, 20000000, '2019-09-10', NULL, 'active'),
('Truong Van M', 'm.truong@company.com', '0901004002', 4, 16000000, '2021-02-25', 12, 'active'),
('Vu Thi N', 'n.vu@company.com', '0901004003', 4, 14000000, '2022-05-15', 12, 'active'),
('Ton Van O', 'o.ton@company.com', '0901005001', 5, 25000000, '2018-06-01', NULL, 'active'),
('Mai Thi P', 'p.mai@company.com', '0901005002', 5, 18000000, '2020-10-10', 15, 'active'),
('Cao Van Q', 'q.cao@company.com', '0901005003', 5, 16000000, '2021-12-05', 15, 'active'),
('Kim Thi R', 'r.kim@company.com', '0901005004', 5, 15000000, '2023-03-15', 15, 'inactive'),
('Luong Van S', 's.luong@company.com', '0901006001', 6, 21000000, '2019-03-20', NULL, 'active'),
('Duong Thi T', 't.duong@company.com', '0901006002', 6, 17000000, '2020-11-25', 19, 'active'),
('Ta Van U', 'u.ta@company.com', '0901006003', 6, 15000000, '2022-04-10', 19, 'active');
-- Insert Projects (8 dự án)
INSERT INTO projects (project_name, start_date, end_date, budget, status, dept_id) VALUES
('Website Redesign', '2024-01-01', '2024-06-30', 500000000, 'in_progress', 1),
('Mobile App Development', '2024-02-15', '2024-12-31', 1200000000, 'in_progress', 1),
('HR System Upgrade', '2024-03-01', '2024-08-31', 300000000, 'planning', 2),
('Financial Report Automation', '2024-01-15', '2024-05-31', 250000000, 'completed', 3),
('Marketing Campaign Q1', '2024-01-01', '2024-03-31', 400000000, 'completed', 4),
('CRM Implementation', '2024-04-01', '2024-10-31', 800000000, 'planning', 5),
('Inventory Management', '2024-02-01', '2024-09-30', 600000000, 'in_progress', 6),
('Data Migration', '2024-03-15', '2024-07-31', 350000000, 'in_progress', 1);
-- Insert Employee_Projects (23 assignments)
INSERT INTO employee_projects (emp_id, project_id, role, assigned_date, hours_worked) VALUES
(1, 1, 'Project Manager', '2024-01-01', 320),
(2, 1, 'Developer', '2024-01-01', 280),
(3, 1, 'Developer', '2024-01-15', 240),
(4, 1, 'Designer', '2024-01-01', 200),
(1, 2, 'Technical Lead', '2024-02-15', 280),
(2, 2, 'Developer', '2024-02-15', 260),
(3, 2, 'Developer', '2024-03-01', 220),
(5, 2, 'Junior Developer', '2024-03-01', 180),
(6, 3, 'Project Manager', '2024-03-01', 120),
(7, 3, 'HR Specialist', '2024-03-01', 100),
(9, 4, 'Project Manager', '2024-01-15', 200),
(10, 4, 'Analyst', '2024-01-15', 180),
(11, 4, 'Developer', '2024-02-01', 160),
(12, 5, 'Marketing Manager', '2024-01-01', 240),
(13, 5, 'Content Creator', '2024-01-01', 200),
(14, 5, 'Designer', '2024-01-01', 180),
(15, 6, 'Sales Director', '2024-04-01', 80),
(16, 6, 'Sales Analyst', '2024-04-01', 60),
(19, 7, 'Operations Manager', '2024-02-01', 220),
(20, 7, 'Analyst', '2024-02-01', 200),
(21, 7, 'Coordinator', '2024-02-15', 180),
(1, 8, 'Technical Consultant', '2024-03-15', 160),
(4, 8, 'Data Analyst', '2024-03-15', 140);
```
---
## 3. SQL Cơ Bản
### 3.1. SELECT - Truy Vấn Cơ Bản
```sql
-- Lấy tất cả dữ liệu từ bảng employees
SELECT * FROM employees;
-- Lấy một số cột cụ thể
SELECT emp_id, emp_name, email, dept_id FROM employees;
-- Sử dụng bí danh (alias) cho cột
SELECT
    emp_name AS "Tên Nhân Viên",
    email AS "Email",
    salary AS "Lương (VNĐ)"
FROM employees;
-- Sử dụng DISTINCT để loại bỏ trùng lặp
SELECT DISTINCT dept_id FROM employees;
-- Đếm số phòng ban khác nhau
SELECT COUNT(DISTINCT dept_id) AS "Số Phòng Ban" FROM employees;
```
### 3.2. WHERE - Lọc Dữ Liệu
```sql
-- Lọc nhân viên theo phòng ban
SELECT * FROM employees WHERE dept_id = 1;
-- Lọc nhân viên có lương > 20 triệu
SELECT emp_name, salary FROM employees WHERE salary > 20000000;
-- Kết hợp nhiều điều kiện với AND
SELECT * FROM employees
WHERE dept_id = 1 AND salary > 18000000 AND status = 'active';
-- Sử dụng OR
SELECT * FROM employees WHERE dept_id = 1 OR dept_id = 2;
-- Sử dụng IN
SELECT * FROM employees WHERE dept_id IN (1, 2, 3);
-- Sử dụng BETWEEN
SELECT * FROM employees WHERE salary BETWEEN 15000000 AND 20000000;
-- Sử dụng LIKE (tìm kiếm mẫu)
SELECT * FROM employees WHERE emp_name LIKE 'Nguyen%';
SELECT * FROM employees WHERE email LIKE '%@company.com';
-- Kiểm tra NULL
SELECT * FROM employees WHERE manager_id IS NULL;
SELECT * FROM employees WHERE manager_id IS NOT NULL;
```
### 3.3. ORDER BY - Sắp Xếp
```sql
-- Sắp xếp theo lương tăng dần
SELECT emp_name, salary FROM employees ORDER BY salary ASC;
-- Sắp xếp theo lương giảm dần
SELECT emp_name, salary FROM employees ORDER BY salary DESC;
-- Sắp xếp theo nhiều cột
SELECT emp_name, dept_id, salary
FROM employees
ORDER BY dept_id ASC, salary DESC;
```
### 3.4. LIMIT/OFFSET - Phân Trang
```sql
-- Lấy 5 nhân viên đầu tiên
SELECT * FROM employees LIMIT 5;
-- Lấy 5 nhân viên tiếp theo (phân trang)
SELECT * FROM employees LIMIT 5 OFFSET 5;
```
### 3.5. Hàm Aggregate (Tổng Hợp)
```sql
-- COUNT: Đếm số lượng
SELECT COUNT(*) AS "Tổng Số Nhân Viên" FROM employees;
-- SUM: Tính tổng
SELECT SUM(salary) AS "Tổng Quỹ Lương" FROM employees;
-- AVG: Tính trung bình
SELECT AVG(salary) AS "Lương Trung Bình" FROM employees;
-- MIN/MAX: Tìm giá trị nhỏ nhất/lớn nhất
SELECT MIN(salary) AS "Lương Thấp Nhất" FROM employees;
SELECT MAX(salary) AS "Lương Cao Nhất" FROM employees;
-- Kết hợp nhiều hàm aggregate
SELECT
    COUNT(*) AS "Số Lượng",
    SUM(salary) AS "Tổng Lương",
    AVG(salary) AS "Lương TB",
    MIN(salary) AS "Lương Min",
    MAX(salary) AS "Lương Max"
FROM employees;
```
### 3.6. GROUP BY - Nhóm Dữ Liệu
```sql
-- Nhóm theo phòng ban và đếm số nhân viên
SELECT dept_id, COUNT(*) AS "Số Nhân Viên"
FROM employees
GROUP BY dept_id;
-- Nhóm theo phòng ban và tính tổng lương
SELECT dept_id,
       COUNT(*) AS "Số Nhân Viên",
       SUM(salary) AS "Tổng Lương",
       AVG(salary) AS "Lương TB"
FROM employees
GROUP BY dept_id;
-- Nhóm theo trạng thái
SELECT status, COUNT(*) AS "Số Lượng"
FROM employees
GROUP BY status;
```
### 3.7. HAVING - Lọc Sau Khi Nhóm
```sql
-- Lọc các phòng ban có nhiều hơn 3 nhân viên
SELECT dept_id, COUNT(*) AS "Số Nhân Viên"
FROM employees
GROUP BY dept_id
HAVING COUNT(*) > 3;
-- Lọc các phòng ban có tổng lương > 50 triệu
SELECT dept_id, SUM(salary) AS "Tổng Lương"
FROM employees
GROUP BY dept_id
HAVING SUM(salary) > 50000000;
```
### 3.8. JOIN Cơ Bản
```sql
-- INNER JOIN: Lấy dữ liệu khớp giữa 2 bảng
SELECT e.emp_name, e.salary, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;
-- LEFT JOIN: Lấy tất cả từ bảng trái, khớp từ bảng phải
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;
-- RIGHT JOIN: Lấy tất cả từ bảng phải, khớp từ bảng trái
SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;
```
---
## 4. SQL Trung Bình
### 4.1. Các Loại JOIN Nâng Cao
```sql
-- Self Join: Tìm nhân viên và quản lý của họ
SELECT
    e.emp_name AS "Nhân Viên",
    m.emp_name AS "Quản Lý"
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;
-- Join 3 bảng
SELECT
    e.emp_name,
    d.dept_name,
    p.project_name,
    ep.role,
    ep.hours_worked
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
INNER JOIN employee_projects ep ON e.emp_id = ep.emp_id
INNER JOIN projects p ON ep.project_id = p.project_id;
```
### 4.2. Subquery (Truy Vấn Con)
```sql
-- Subquery trong WHERE
SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
-- Subquery trong SELECT
SELECT
    e.emp_name,
    e.salary,
    (SELECT AVG(salary) FROM employees) AS "Lương TB Công Ty"
FROM employees e;
-- Subquery trong FROM
SELECT
    dept_id,
    avg_salary
FROM (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
) AS dept_avg
WHERE avg_salary > 18000000;
-- Subquery với IN
SELECT emp_name, dept_id
FROM employees
WHERE dept_id IN (
    SELECT dept_id FROM departments WHERE location = 'Building A'
);
-- Subquery với EXISTS
SELECT dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1 FROM employees e WHERE e.dept_id = d.dept_id
);
```
### 4.3. CASE WHEN - Biểu Thức Điều Kiện
```sql
-- CASE WHEN đơn giản
SELECT
    emp_name,
    salary,
    CASE
        WHEN salary >= 25000000 THEN 'Cao'
        WHEN salary >= 18000000 THEN 'Trung Bình'
        ELSE 'Thấp'
    END AS "Mức Lương"
FROM employees;
-- CASE WHEN với nhiều điều kiện
SELECT
    emp_name,
    hire_date,
    CASE
        WHEN hire_date < '2020-01-01' THEN 'Senior (>4 năm)'
        WHEN hire_date >= '2020-01-01' AND hire_date < '2022-01-01' THEN 'Mid-level (2-4 năm)'
        WHEN hire_date >= '2022-01-01' AND hire_date < '2024-01-01' THEN 'Junior (1-2 năm)'
        ELSE 'Fresher (<1 năm)'
    END AS "Kinh Nghiệm"
FROM employees;
-- CASE WHEN trong GROUP BY
SELECT
    CASE
        WHEN salary >= 25000000 THEN 'High'
        WHEN salary >= 18000000 THEN 'Medium'
        ELSE 'Low'
    END AS "Salary Range",
    COUNT(*) AS "Số Nhân Viên",
    AVG(salary) AS "Lương TB"
FROM employees
GROUP BY
    CASE
        WHEN salary >= 25000000 THEN 'High'
        WHEN salary >= 18000000 THEN 'Medium'
        ELSE 'Low'
    END;
```
### 4.4. UNION
```sql
-- UNION: Kết hợp kết quả từ 2 query (loại bỏ trùng)
SELECT emp_name, 'Employee' AS type FROM employees
UNION
SELECT dept_name, 'Department' AS type FROM departments;
-- UNION ALL: Kết hợp kết quả (giữ lại trùng)
SELECT emp_name FROM employees WHERE dept_id = 1
UNION ALL
SELECT emp_name FROM employees WHERE salary > 20000000;
```
### 4.5. Hàm Xử Lý Chuỗi
```sql
-- CONCAT: Nối chuỗi
SELECT CONCAT(emp_name, ' (', email, ')') AS "Thông Tin" FROM employees;
-- LENGTH: Độ dài chuỗi
SELECT emp_name, LENGTH(emp_name) AS "Độ Dài" FROM employees;
-- UPPER/LOWER: Chuyển đổi chữ hoa/thường
SELECT emp_name, UPPER(emp_name) AS "UPPER", LOWER(emp_name) AS "lower" FROM employees;
-- SUBSTRING: Cắt chuỗi
SELECT emp_name, SUBSTRING(emp_name, 1, 5) AS "5 Ký Tự Đầu" FROM employees;
-- REPLACE: Thay thế chuỗi
SELECT REPLACE(email, '@company.com', '@newcompany.com') AS "New Email" FROM employees;
```
### 4.6. Hàm Xử Lý Ngày Tháng
```sql
-- CURRENT_DATE/NOW(): Ngày/giờ hiện tại
SELECT CURRENT_DATE AS "Ngày Hiện Tại", NOW() AS "Thời Gian Hiện Tại";
-- DATE_ADD/DATE_SUB: Thêm/trừ ngày
SELECT
    hire_date,
    DATE_ADD(hire_date, INTERVAL 1 YEAR) AS "+1 Năm",
    DATE_SUB(hire_date, INTERVAL 1 MONTH) AS "-1 Tháng"
FROM employees;
-- DATEDIFF: Tính chênh lệch ngày
SELECT
    emp_name,
    hire_date,
    DATEDIFF(CURRENT_DATE, hire_date) AS "Số Ngày Làm Việc"
FROM employees;
-- YEAR/MONTH/DAY: Trích xuất năm/tháng/ngày
SELECT
    emp_name,
    hire_date,
    YEAR(hire_date) AS "Năm",
    MONTH(hire_date) AS "Tháng",
    DAY(hire_date) AS "Ngày"
FROM employees;
-- DATE_FORMAT: Định dạng ngày
SELECT
    emp_name,
    hire_date,
    DATE_FORMAT(hire_date, '%d/%m/%Y') AS "DD/MM/YYYY"
FROM employees;
-- TIMESTAMPDIFF: Tính chênh lệch thời gian
SELECT
    emp_name,
    hire_date,
    TIMESTAMPDIFF(YEAR, hire_date, CURRENT_DATE) AS "Số Năm Làm Việc"
FROM employees;
```
---
## 5. SQL Nâng Cao
### 5.1. Common Table Expressions (CTE)
```sql
-- CTE đơn giản
WITH HighEarners AS (
    SELECT emp_id, emp_name, salary
    FROM employees
    WHERE salary > 20000000
)
SELECT * FROM HighEarners ORDER BY salary DESC;
-- Multiple CTEs
WITH
DeptStats AS (
    SELECT
        dept_id,
        COUNT(*) AS emp_count,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
),
DeptNames AS (
    SELECT dept_id, dept_name, location
    FROM departments
)
SELECT
    dn.dept_name,
    dn.location,
    ds.emp_count,
    ds.avg_salary
FROM DeptStats ds
JOIN DeptNames dn ON ds.dept_id = dn.dept_id
ORDER BY ds.avg_salary DESC;
-- Recursive CTE (Tìm hierarchy nhân viên)
WITH RECURSIVE EmpHierarchy AS (
    SELECT
        emp_id,
        emp_name,
        manager_id,
        1 AS level,
        emp_name AS path
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT
        e.emp_id,
        e.emp_name,
        e.manager_id,
        eh.level + 1,
        CONCAT(eh.path, ' -> ', e.emp_name)
    FROM employees e
    INNER JOIN EmpHierarchy eh ON e.manager_id = eh.emp_id
)
SELECT * FROM EmpHierarchy ORDER BY path;
```
### 5.2. Window Functions
```sql
-- ROW_NUMBER: Đánh số thứ tự
SELECT
    emp_name,
    dept_id,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS "Rank"
FROM employees;
-- ROW_NUMBER với PARTITION BY
SELECT
    emp_name,
    dept_id,
    salary,
    ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS "Rank Trong Phòng"
FROM employees;
-- RANK và DENSE_RANK
SELECT
    emp_name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS "Rank",
    DENSE_RANK() OVER (ORDER BY salary DESC) AS "Dense Rank"
FROM employees;
-- NTILE: Chia thành các nhóm bằng nhau
SELECT
    emp_name,
    salary,
    NTILE(4) OVER (ORDER BY salary DESC) AS "Quartile"
FROM employees;
-- LEAD và LAG: Truy cập hàng tiếp theo/trước đó
SELECT
    emp_name,
    dept_id,
    salary,
    LAG(salary, 1) OVER (PARTITION BY dept_id ORDER BY salary) AS "Lương Người Trước",
    LEAD(salary, 1) OVER (PARTITION BY dept_id ORDER BY salary) AS "Lương Người Sau"
FROM employees;
-- FIRST_VALUE và LAST_VALUE
SELECT
    emp_name,
    dept_id,
    salary,
    FIRST_VALUE(emp_name) OVER (PARTITION BY dept_id ORDER BY salary DESC) AS "Người Lương Cao Nhất Phòng"
FROM employees;
-- SUM/AVG với Window Function
SELECT
    emp_name,
    dept_id,
    salary,
    SUM(salary) OVER (PARTITION BY dept_id) AS "Tổng Lương Phòng",
    AVG(salary) OVER (PARTITION BY dept_id) AS "Lương TB Phòng",
    SUM(salary) OVER () AS "Tổng Lương Công Ty"
FROM employees;
-- Running Total (Tổng lũy tiến)
SELECT
    emp_name,
    hire_date,
    salary,
    SUM(salary) OVER (ORDER BY hire_date) AS "Running Total"
FROM employees;
```
### 5.3. Stored Procedures
```sql
DELIMITER //
-- Stored Procedure đơn giản
CREATE PROCEDURE GetEmployeesByDept(IN p_dept_id INT)
BEGIN
    SELECT * FROM employees WHERE dept_id = p_dept_id;
END //
-- Stored Procedure với OUT parameter
CREATE PROCEDURE GetDeptStats(
    IN p_dept_id INT,
    OUT p_emp_count INT,
    OUT p_avg_salary DECIMAL(10,2)
)
BEGIN
    SELECT COUNT(*), AVG(salary)
    INTO p_emp_count, p_avg_salary
    FROM employees
    WHERE dept_id = p_dept_id;
END //
-- Stored Procedure với transaction
CREATE PROCEDURE UpdateSalary(
    IN p_emp_id INT,
    IN p_new_salary DECIMAL(10,2),
    IN p_changed_by INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error occurred' AS message;
    END;
    START TRANSACTION;
    UPDATE employees SET salary = p_new_salary WHERE emp_id = p_emp_id;
    INSERT INTO salaries (emp_id, salary_amount, effective_date, changed_by)
    VALUES (p_emp_id, p_new_salary, CURRENT_DATE, p_changed_by);
    COMMIT;
    SELECT 'Salary updated successfully' AS message;
END //
DELIMITER ;
-- Gọi Stored Procedure
CALL GetEmployeesByDept(1);
CALL GetDeptStats(1, @count, @avg_sal);
SELECT @count, @avg_sal;
```
### 5.4. Functions
```sql
DELIMITER //
-- Function tính thưởng
CREATE FUNCTION CalculateBonus(p_salary DECIMAL(10,2), p_rating DECIMAL(3,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE bonus DECIMAL(10,2);
    IF p_rating >= 4.5 THEN
        SET bonus = p_salary * 0.20;
    ELSEIF p_rating >= 4.0 THEN
        SET bonus = p_salary * 0.15;
    ELSEIF p_rating >= 3.5 THEN
        SET bonus = p_salary * 0.10;
    ELSE
        SET bonus = p_salary * 0.05;
    END IF;
    RETURN bonus;
END //
-- Function tính thâm niên
CREATE FUNCTION CalculateYearsOfService(p_hire_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, p_hire_date, CURRENT_DATE);
END //
DELIMITER ;
-- Sử dụng Function
SELECT
    emp_name,
    salary,
    CalculateBonus(salary, 4.5) AS "Thưởng",
    CalculateYearsOfService(hire_date) AS "Thâm Niên"
FROM employees;
```
### 5.5. Triggers
```sql
DELIMITER //
-- Trigger BEFORE INSERT
CREATE TRIGGER BeforeEmployeeInsert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    SET NEW.email = LOWER(NEW.email);
    IF NEW.hire_date IS NULL THEN
        SET NEW.hire_date = CURRENT_DATE;
    END IF;
END //
-- Trigger AFTER INSERT
CREATE TRIGGER AfterEmployeeInsert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salaries (emp_id, salary_amount, effective_date, changed_by)
    VALUES (NEW.emp_id, NEW.salary, NEW.hire_date, NEW.manager_id);
END //
-- Trigger BEFORE UPDATE
CREATE TRIGGER BeforeSalaryUpdate
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary > NEW.salary THEN
        SET min_salary = OLD.salary * 0.9;
        IF NEW.salary < min_salary THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Salary cannot be reduced by more than 10%';
        END IF;
    END IF;
END //
DELIMITER ;
```
### 5.6. Views
```sql
-- View đơn giản
CREATE VIEW vw_active_employees AS
SELECT
    e.emp_id,
    e.emp_name,
    e.email,
    d.dept_name,
    e.salary,
    e.hire_date
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE e.status = 'active';
-- View với aggregation
CREATE VIEW vw_dept_summary AS
SELECT
    d.dept_id,
    d.dept_name,
    d.location,
    COUNT(e.emp_id) AS emp_count,
    SUM(e.salary) AS total_salary,
    AVG(e.salary) AS avg_salary
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name, d.location;
-- View với window functions
CREATE VIEW vw_employee_ranking AS
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name,
    e.salary,
    RANK() OVER (ORDER BY e.salary DESC) AS company_rank,
    RANK() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS dept_rank
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;
```
### 5.7. Indexes
```sql
-- Tạo Index đơn
CREATE INDEX idx_emp_name ON employees(emp_name);
CREATE INDEX idx_email ON employees(email);
CREATE INDEX idx_dept_id ON employees(dept_id);
-- Composite Index
CREATE INDEX idx_dept_salary ON employees(dept_id, salary);
-- Unique Index
CREATE UNIQUE INDEX idx_unique_email ON employees(email);
-- Xem indexes
SHOW INDEX FROM employees;
-- Xóa Index
DROP INDEX idx_emp_name ON employees;
-- Phân tích query
EXPLAIN SELECT * FROM employees WHERE dept_id = 1 AND salary > 15000000;
```
### 5.8. Transactions
```sql
-- Transaction cơ bản
START TRANSACTION;
UPDATE employees SET salary = salary * 1.1 WHERE dept_id = 1;
UPDATE employees SET salary = salary * 1.05 WHERE dept_id = 2;
COMMIT;
-- Transaction với Savepoint
START TRANSACTION;
UPDATE employees SET salary = 25000000 WHERE emp_id = 1;
SAVEPOINT sp1;
UPDATE employees SET salary = 20000000 WHERE emp_id = 2;
SAVEPOINT sp2;
UPDATE employees SET salary = 18000000 WHERE emp_id = 3;
ROLLBACK TO sp2;
COMMIT;
```
### 5.9. Cursors
```sql
DELIMITER //
CREATE PROCEDURE ProcessAllEmployees()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_emp_id INT;
    DECLARE v_emp_name VARCHAR(100);
    DECLARE v_salary DECIMAL(10,2);
    DECLARE emp_cursor CURSOR FOR
        SELECT emp_id, emp_name, salary FROM employees WHERE status = 'active';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN emp_cursor;
    read_loop: LOOP
        FETCH emp_cursor INTO v_emp_id, v_emp_name, v_salary;
        IF done THEN
            LEAVE read_loop;
        END IF;
        IF v_salary < 15000000 THEN
            UPDATE employees SET salary = salary * 1.15 WHERE emp_id = v_emp_id;
        ELSEIF v_salary < 20000000 THEN
            UPDATE employees SET salary = salary * 1.10 WHERE emp_id = v_emp_id;
        END IF;
    END LOOP;
    CLOSE emp_cursor;
END //
DELIMITER ;
CALL ProcessAllEmployees();
```
---
## 6. Thao Tác Dữ Liệu
### 6.1. INSERT
```sql
-- INSERT một row
INSERT INTO employees (emp_name, email, dept_id, salary, hire_date, status)
VALUES ('Test User', 'test@company.com', 1, 15000000, '2024-01-01', 'active');
-- INSERT nhiều rows
INSERT INTO employees (emp_name, email, dept_id, salary, hire_date, status) VALUES
('User 1', 'user1@company.com', 1, 15000000, '2024-01-01', 'active'),
('User 2', 'user2@company.com', 2, 16000000, '2024-01-02', 'active');
-- INSERT từ SELECT
INSERT INTO employees (emp_name, email, dept_id, salary, hire_date, status)
SELECT
    CONCAT(emp_name, ' (Copy)'),
    CONCAT('copy_', email),
    dept_id,
    salary,
    CURRENT_DATE,
    'active'
FROM employees
WHERE dept_id = 1
LIMIT 3;
-- INSERT ... ON DUPLICATE KEY UPDATE
INSERT INTO employees (emp_id, emp_name, email, salary)
VALUES (1, 'Updated Name', 'updated@company.com', 30000000)
ON DUPLICATE KEY UPDATE
    emp_name = VALUES(emp_name),
    salary = VALUES(salary);
```
### 6.2. UPDATE
```sql
-- UPDATE một cột
UPDATE employees SET salary = 20000000 WHERE emp_id = 1;
-- UPDATE nhiều cột
UPDATE employees
SET salary = 22000000, status = 'active'
WHERE emp_id = 1;
-- UPDATE với JOIN
UPDATE employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
SET e.salary = e.salary * 1.1
WHERE d.dept_name = 'IT';
-- UPDATE với CASE WHEN
UPDATE employees
SET salary = CASE
    WHEN salary < 15000000 THEN salary * 1.15
    WHEN salary < 20000000 THEN salary * 1.10
    WHEN salary < 25000000 THEN salary * 1.05
    ELSE salary
END;
```
### 6.3. DELETE
```sql
-- DELETE với WHERE
DELETE FROM employees WHERE emp_id = 1;
-- DELETE với nhiều điều kiện
DELETE FROM employees
WHERE status = 'inactive' AND hire_date < '2023-01-01';
-- DELETE với JOIN
DELETE e FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Marketing';
-- TRUNCATE (xóa toàn bộ, reset auto-increment)
TRUNCATE TABLE attendance;
```
### 6.4. MERGE/Upsert
```sql
-- MySQL: INSERT ... ON DUPLICATE KEY UPDATE
INSERT INTO employees (emp_id, emp_name, salary)
VALUES (1, 'New Name', 30000000)
ON DUPLICATE KEY UPDATE
    emp_name = VALUES(emp_name),
    salary = VALUES(salary);
-- MySQL: REPLACE INTO
REPLACE INTO employees (emp_id, emp_name, email, salary)
VALUES (1, 'Replaced', 'replaced@company.com', 35000000);
```
---
## 7. Định Nghĩa Dữ Liệu
### 7.1. ALTER TABLE
```sql
-- Thêm cột mới
ALTER TABLE employees ADD COLUMN address VARCHAR(200);
-- Sửa kiểu dữ liệu cột
ALTER TABLE employees MODIFY COLUMN phone VARCHAR(30);
-- Đổi tên cột
ALTER TABLE employees CHANGE COLUMN emp_name employee_name VARCHAR(100);
-- Thêm constraint
ALTER TABLE employees ADD CONSTRAINT chk_salary CHECK (salary > 0);
-- Thêm foreign key
ALTER TABLE employees
ADD CONSTRAINT fk_manager
FOREIGN KEY (manager_id) REFERENCES employees(emp_id);
-- Xóa cột
ALTER TABLE employees DROP COLUMN address;
-- Xóa constraint
ALTER TABLE employees DROP CONSTRAINT chk_salary;
-- Đổi tên table
ALTER TABLE employees RENAME TO staff;
-- Thêm index
ALTER TABLE employees ADD INDEX idx_name (employee_name);
```
### 7.2. CREATE TABLE với Constraints
```sql
CREATE TABLE employees_new (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    dept_id INT,
    salary DECIMAL(10, 2) CHECK (salary > 0),
    hire_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    manager_id INT,
    status ENUM('active', 'inactive', 'terminated') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES employees_new(emp_id),
    CONSTRAINT unique_email_dept UNIQUE (email, dept_id)
);
-- Table với composite primary key
CREATE TABLE employee_skills (
    emp_id INT,
    skill_name VARCHAR(100),
    proficiency_level INT CHECK (proficiency_level BETWEEN 1 AND 5),
    acquired_date DATE,
    PRIMARY KEY (emp_id, skill_name),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
```
---
## 8. Tối Ưu Hiệu Năng
### 8.1. EXPLAIN
```sql
-- Phân tích query execution plan
EXPLAIN SELECT * FROM employees WHERE dept_id = 1;
-- EXPLAIN FORMAT=JSON
EXPLAIN FORMAT=JSON
SELECT * FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary > 15000000;
```
### 8.2. Query Optimization Tips
```sql
-- ❌ KHÔNG NÊN: SELECT *
SELECT * FROM employees;
-- ✅ NÊN: Chỉ chọn cột cần thiết
SELECT emp_id, emp_name, salary FROM employees;
-- ❌ KHÔNG NÊN: Function trên column trong WHERE
SELECT * FROM employees WHERE YEAR(hire_date) = 2024;
-- ✅ NÊN: Sử dụng range
SELECT * FROM employees
WHERE hire_date >= '2024-01-01' AND hire_date < '2025-01-01';
-- ❌ KHÔNG NÊN: LIKE với wildcard đầu
SELECT * FROM employees WHERE emp_name LIKE '%Nguyen%';
-- ✅ NÊN: Sử dụng index-friendly pattern
SELECT * FROM employees WHERE emp_name LIKE 'Nguyen%';
-- ❌ KHÔNG NÊN: OR không tối ưu
SELECT * FROM employees WHERE dept_id = 1 OR dept_id = 2 OR dept_id = 3;
-- ✅ NÊN: Sử dụng IN
SELECT * FROM employees WHERE dept_id IN (1, 2, 3);
-- ✅ Tạo covering index
CREATE INDEX idx_covering ON employees(dept_id, salary, emp_name);
SELECT dept_id, salary, emp_name FROM employees WHERE dept_id = 1;
```
### 8.3. Partitioning
```sql
-- Range Partitioning (theo năm)
CREATE TABLE employees_partitioned (
    emp_id INT,
    emp_name VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10,2)
)
PARTITION BY RANGE (YEAR(hire_date)) (
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);
-- List Partitioning (theo department)
CREATE TABLE employees_list_part (
    emp_id INT,
    emp_name VARCHAR(100),
    dept_id INT
)
PARTITION BY LIST (dept_id) (
    PARTITION p_it VALUES IN (1),
    PARTITION p_hr VALUES IN (2),
    PARTITION p_finance VALUES IN (3),
    PARTITION p_marketing VALUES IN (4),
    PARTITION p_sales VALUES IN (5),
    PARTITION p_ops VALUES IN (6)
);
```
---
## 9. Bảo Mật Và Phân Quyền
```sql
-- Tạo user mới
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'secure_password';
-- Grant permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON sample_db.employees TO 'app_user'@'localhost';
GRANT SELECT ON sample_db.departments TO 'app_user'@'localhost';
-- Grant all on specific database
GRANT ALL PRIVILEGES ON sample_db.* TO 'app_user'@'localhost';
-- Revoke permissions
REVOKE DELETE ON sample_db.employees FROM 'app_user'@'localhost';
-- Xem permissions
SHOW GRANTS FOR 'app_user'@'localhost';
-- Xóa user
DROP USER 'app_user'@'localhost';
-- Đổi password
ALTER USER 'app_user'@'localhost' IDENTIFIED BY 'new_password';
-- Khóa/Mở khóa user
ALTER USER 'app_user'@'localhost' ACCOUNT LOCK;
ALTER USER 'app_user'@'localhost' ACCOUNT UNLOCK;
-- Tạo Role (MySQL 8.0+)
CREATE ROLE 'read_only';
GRANT SELECT ON sample_db.* TO 'read_only';
GRANT 'read_only' TO 'app_user'@'localhost';
```
---
## 10. Mẫu Truy Vấn Thực Tế
### 10.1. Báo Cáo Nhân Sự
```sql
-- Báo cáo nhân viên theo phòng ban
SELECT
    d.dept_name AS "Phòng Ban",
    COUNT(e.emp_id) AS "Số Nhân Viên",
    SUM(e.salary) AS "Tổng Quỹ Lương",
    AVG(e.salary) AS "Lương Trung Bình"
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY COUNT(e.emp_id) DESC;
-- Top 5 nhân viên có lương cao nhất
SELECT
    e.emp_name,
    d.dept_name,
    e.salary,
    RANK() OVER (ORDER BY e.salary DESC) AS "Rank"
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE e.status = 'active'
ORDER BY e.salary DESC
LIMIT 5;
-- Nhân viên sắp đến hạn đánh giá
SELECT
    e.emp_name,
    pr.next_review_date AS "Hạn Đánh Giá",
    DATEDIFF(pr.next_review_date, CURRENT_DATE) AS "Số Ngày Còn Lại"
FROM employees e
INNER JOIN performance_reviews pr ON e.emp_id = pr.emp_id
WHERE pr.next_review_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY)
ORDER BY pr.next_review_date;
```
### 10.2. Báo Cáo Dự Án
```sql
-- Báo cáo tiến độ dự án
SELECT
    p.project_name,
    p.status,
    p.start_date,
    p.end_date,
    p.budget,
    COUNT(ep.emp_id) AS "Số Nhân Sự",
    SUM(ep.hours_worked) AS "Tổng Giờ Công"
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.project_id
ORDER BY p.start_date DESC;
-- Nhân viên tham gia nhiều dự án nhất
SELECT
    e.emp_name,
    d.dept_name,
    COUNT(ep.project_id) AS "Số Dự Án",
    SUM(ep.hours_worked) AS "Tổng Giờ Làm"
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
INNER JOIN employee_projects ep ON e.emp_id = ep.emp_id
GROUP BY e.emp_id
ORDER BY COUNT(ep.project_id) DESC
LIMIT 10;
```
### 10.3. Báo Cáo Chấm Công
```sql
-- Thống kê vắng mặt
SELECT
    e.emp_name,
    d.dept_name,
    COUNT(CASE WHEN a.status = 'absent' THEN 1 END) AS "Vắng Mặt",
    COUNT(CASE WHEN a.status = 'late' THEN 1 END) AS "Đi Muộn",
    COUNT(CASE WHEN a.status = 'on_leave' THEN 1 END) AS "Nghỉ Phép"
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN attendance a ON e.emp_id = a.emp_id
WHERE a.attendance_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
GROUP BY e.emp_id
ORDER BY "Vắng Mặt" DESC;
-- Tỷ lệ chuyên cần
SELECT
    e.emp_name,
    COUNT(*) AS "Tổng Ngày",
    SUM(CASE WHEN a.status = 'present' THEN 1 ELSE 0 END) AS "Ngày Có Mặt",
    ROUND(SUM(CASE WHEN a.status = 'present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS "Tỷ Lệ %"
FROM employees e
INNER JOIN attendance a ON e.emp_id = a.emp_id
WHERE a.attendance_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)
GROUP BY e.emp_id
HAVING COUNT(*) >= 20
ORDER BY "Tỷ Lệ %" DESC;
```
### 10.4. Báo Cáo Hiệu Suất
```sql
-- Đánh giá hiệu suất theo phòng ban
SELECT
    d.dept_name,
    COUNT(pr.review_id) AS "Số Lần Đánh Giá",
    AVG(pr.rating) AS "Điểm TB",
    MAX(pr.rating) AS "Điểm Cao Nhất",
    MIN(pr.rating) AS "Điểm Thấp Nhất"
FROM departments d
INNER JOIN employees e ON d.dept_id = e.dept_id
INNER JOIN performance_reviews pr ON e.emp_id = pr.emp_id
GROUP BY d.dept_id
ORDER BY AVG(pr.rating) DESC;
-- Top performer
SELECT
    e.emp_name,
    d.dept_name,
    pr.rating,
    pr.comments
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
INNER JOIN performance_reviews pr ON e.emp_id = pr.emp_id
WHERE pr.review_date = (SELECT MAX(review_date) FROM performance_reviews)
ORDER BY pr.rating DESC
LIMIT 10;
```
### 10.5. Báo Cáo Lương
```sql
-- Phân bổ lương theo phòng ban
SELECT
    d.dept_name,
    COUNT(e.emp_id) AS "Số NV",
    SUM(e.salary) AS "Tổng Lương",
    ROUND(SUM(e.salary) * 100.0 / (SELECT SUM(salary) FROM employees), 2) AS "% Tổng Quỹ"
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id
ORDER BY SUM(e.salary) DESC;
-- Lịch sử tăng lương
SELECT
    e.emp_name,
    s.effective_date,
    s.salary_amount,
    LAG(s.salary_amount) OVER (PARTITION BY e.emp_id ORDER BY s.effective_date) AS "Lương Cũ",
    s.salary_amount - LAG(s.salary_amount) OVER (PARTITION BY e.emp_id ORDER BY s.effective_date) AS "Tăng"
FROM employees e
INNER JOIN salaries s ON e.emp_id = s.emp_id
ORDER BY e.emp_name, s.effective_date;
```
### 10.6. Dashboard Queries
```sql
-- KPI tổng quan
SELECT
    (SELECT COUNT(*) FROM employees WHERE status = 'active') AS "Tổng NV Active",
    (SELECT COUNT(*) FROM employees WHERE hire_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)) AS "NV Mới 30 Ngày",
    (SELECT COUNT(*) FROM projects WHERE status = 'in_progress') AS "Dự Án Đang Chạy",
    (SELECT AVG(rating) FROM performance_reviews WHERE review_date >= DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY)) AS "Điểm TB",
    (SELECT SUM(salary) FROM employees WHERE status = 'active') AS "Tổng Quỹ Lương";
-- Biểu đồ nhân sự theo thời gian
SELECT
    DATE_FORMAT(hire_date, '%Y-%m') AS "Tháng",
    COUNT(*) AS "Số NV"
FROM employees
GROUP BY DATE_FORMAT(hire_date, '%Y-%m')
ORDER BY "Tháng"
LIMIT 12;
-- Phân bố lương
SELECT
    CASE
        WHEN salary < 15000000 THEN '< 15M'
        WHEN salary < 20000000 THEN '15M - 20M'
        WHEN salary < 25000000 THEN '20M - 25M'
        ELSE '> 25M'
    END AS "Khoảng Lương",
    COUNT(*) AS "Số NV",
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees), 2) AS "%"
FROM employees
GROUP BY
    CASE
        WHEN salary < 15000000 THEN '< 15M'
        WHEN salary < 20000000 THEN '15M - 20M'
        WHEN salary < 25000000 THEN '20M - 25M'
        ELSE '> 25M'
    END
ORDER BY MIN(salary);
```
---
## 📚 Tài Liệu Tham Khảo
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [SQL Server Documentation](https://docs.microsoft.com/sql/)
- [Oracle Documentation](https://docs.oracle.com/en/database/)
- [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)
---
*Document created for educational purposes. Adjust syntax based on your specific database system.*
