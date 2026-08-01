-- ============================================
-- TỔNG HỢP CÁC CÂU LỆNH SQL MẪU TỪ CƠ BẢN ĐẾN NÂNG CAO
-- ============================================

-- ============================================
-- PHẦN 1: KHỞI TẠO DỮ LIỆU MẪU
-- ============================================

-- Tạo bảng Departments (Phòng ban)
CREATE TABLE IF NOT EXISTS Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

-- Tạo bảng Employees (Nhân viên)
CREATE TABLE IF NOT EXISTS Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    HireDate DATE,
    Salary DECIMAL(10, 2),
    DepartmentID INT,
    ManagerID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

-- Tạo bảng Projects (Dự án)
CREATE TABLE IF NOT EXISTS Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Budget DECIMAL(12, 2),
    Status VARCHAR(20)
);

-- Tạo bảng EmployeeProjects (Phân công nhân viên vào dự án)
CREATE TABLE IF NOT EXISTS EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    Role VARCHAR(50),
    AssignedDate DATE,
    HoursWorked DECIMAL(5, 2),
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

-- Tạo bảng Customers (Khách hàng)
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(200),
    City VARCHAR(50),
    Country VARCHAR(50),
    CreatedDate DATE
);

-- Tạo bảng Products (Sản phẩm)
CREATE TABLE IF NOT EXISTS Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    UnitPrice DECIMAL(10, 2),
    StockQuantity INT,
    Category VARCHAR(50),
    SupplierID INT
);

-- Tạo bảng Orders (Đơn hàng)
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    ShipDate DATE,
    TotalAmount DECIMAL(12, 2),
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Tạo bảng OrderDetails (Chi tiết đơn hàng)
CREATE TABLE IF NOT EXISTS OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    Discount DECIMAL(5, 2),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Chèn dữ liệu mẫu vào Departments
INSERT INTO Departments VALUES 
(1, 'IT', 'Ha Noi'),
(2, 'HR', 'Ho Chi Minh'),
(3, 'Sales', 'Da Nang'),
(4, 'Marketing', 'Ha Noi'),
(5, 'Finance', 'Ho Chi Minh');

-- Chèn dữ liệu mẫu vào Employees
INSERT INTO Employees VALUES 
(1, 'Nguyen', 'Van A', 'vana@email.com', '0901001001', '2020-01-15', 15000000, 1, NULL),
(2, 'Tran', 'Thi B', 'thib@email.com', '0901001002', '2019-06-20', 12000000, 1, 1),
(3, 'Le', 'Van C', 'vanc@email.com', '0901001003', '2021-03-10', 10000000, 1, 1),
(4, 'Pham', 'Thi D', 'thid@email.com', '0901001004', '2018-09-05', 18000000, 2, NULL),
(5, 'Hoang', 'Van E', 'vane@email.com', '0901001005', '2020-11-25', 11000000, 2, 4),
(6, 'Vu', 'Thi F', 'thif@email.com', '0901001006', '2019-02-14', 13000000, 3, NULL),
(7, 'Do', 'Van G', 'vang@email.com', '0901001007', '2021-07-01', 9500000, 3, 6),
(8, 'Ngo', 'Thi H', 'thih@email.com', '0901001008', '2020-04-18', 14000000, 4, NULL),
(9, 'Dinh', 'Van I', 'vani@email.com', '0901001009', '2019-12-30', 16000000, 4, 8),
(10, 'Ly', 'Thi K', 'thik@email.com', '0901001010', '2021-01-05', 20000000, 5, NULL);

-- Chèn dữ liệu mẫu vào Projects
INSERT INTO Projects VALUES 
(1, 'Website Redesign', '2023-01-01', '2023-06-30', 500000000, 'Completed'),
(2, 'Mobile App Development', '2023-03-15', '2023-12-31', 800000000, 'In Progress'),
(3, 'CRM System', '2023-06-01', '2024-03-31', 1200000000, 'In Progress'),
(4, 'Data Migration', '2023-09-01', '2023-11-30', 300000000, 'Completed'),
(5, 'Security Audit', '2024-01-15', '2024-04-15', 250000000, 'Planning');

-- Chèn dữ liệu mẫu vào EmployeeProjects
INSERT INTO EmployeeProjects VALUES 
(1, 1, 'Project Manager', '2023-01-01', 160),
(2, 1, 'Developer', '2023-01-15', 150),
(3, 1, 'Developer', '2023-02-01', 140),
(1, 2, 'Technical Lead', '2023-03-15', 180),
(2, 2, 'Senior Developer', '2023-03-20', 170),
(3, 2, 'Developer', '2023-04-01', 160),
(4, 3, 'Business Analyst', '2023-06-01', 120),
(5, 3, 'Developer', '2023-06-15', 150),
(6, 4, 'Sales Lead', '2023-09-01', 100),
(7, 4, 'Support', '2023-09-15', 80),
(8, 5, 'Marketing Manager', '2024-01-15', 90),
(9, 5, 'Content Creator', '2024-01-20', 85),
(10, 3, 'Financial Advisor', '2023-07-01', 110);

-- Chèn dữ liệu mẫu vào Customers
INSERT INTO Customers VALUES 
(1, 'Cong Ty ABC', 'abc@company.com', '0902001001', '123 Duong A', 'Ha Noi', 'Vietnam', '2022-01-10'),
(2, 'Cong Ty XYZ', 'xyz@company.com', '0902001002', '456 Duong B', 'Ho Chi Minh', 'Vietnam', '2022-03-15'),
(3, 'Nguyen Van Tuan', 'tuan@email.com', '0902001003', '789 Duong C', 'Da Nang', 'Vietnam', '2022-05-20'),
(4, 'Tran Thi Mai', 'mai@email.com', '0902001004', '321 Duong D', 'Ha Noi', 'Vietnam', '2022-07-25'),
(5, 'Le Van Hung', 'hung@email.com', '0902001005', '654 Duong E', 'Can Tho', 'Vietnam', '2022-09-30');

-- Chèn dữ liệu mẫu vào Products
INSERT INTO Products VALUES 
(1, 'Laptop Dell XPS 15', 'High performance laptop', 35000000, 50, 'Electronics', 1),
(2, 'Mouse Logitech MX Master 3', 'Wireless mouse', 2500000, 200, 'Electronics', 1),
(3, 'Keyboard Mechanical Keychron K2', 'Mechanical keyboard', 3000000, 150, 'Electronics', 1),
(4, 'Monitor LG 27 inch 4K', '4K UHD Monitor', 12000000, 80, 'Electronics', 2),
(5, 'Chair Ergonomic Herman Miller', 'Office chair', 25000000, 30, 'Furniture', 2),
(6, 'Desk Standing Desk', 'Adjustable standing desk', 8000000, 60, 'Furniture', 2),
(7, 'Webcam Logitech C920', 'HD Webcam', 2000000, 100, 'Electronics', 1),
(8, 'Headphone Sony WH-1000XM4', 'Noise cancelling headphone', 8500000, 75, 'Electronics', 3),
(9, 'Printer HP LaserJet Pro', 'Laser printer', 6000000, 40, 'Electronics', 3),
(10, 'Router WiFi 6 Asus', 'WiFi 6 Router', 4500000, 90, 'Electronics', 3);

-- Chèn dữ liệu mẫu vào Orders
INSERT INTO Orders VALUES 
(1, 1, '2023-06-15', '2023-06-18', 40500000, 'Delivered'),
(2, 2, '2023-07-20', '2023-07-25', 15500000, 'Delivered'),
(3, 3, '2023-08-10', '2023-08-15', 5000000, 'Delivered'),
(4, 4, '2023-09-05', '2023-09-10', 33000000, 'Delivered'),
(5, 5, '2023-10-12', '2023-10-18', 10500000, 'Shipped'),
(6, 1, '2023-11-20', NULL, 27000000, 'Processing'),
(7, 3, '2023-12-01', NULL, 8500000, 'Processing'),
(8, 2, '2024-01-15', NULL, 50000000, 'Pending'),
(9, 4, '2024-02-10', NULL, 12000000, 'Pending'),
(10, 5, '2024-03-05', NULL, 6000000, 'Pending');

-- Chèn dữ liệu mẫu vào OrderDetails
INSERT INTO OrderDetails VALUES 
(1, 1, 1, 35000000, 0),
(1, 2, 2, 2500000, 0),
(2, 4, 1, 12000000, 0),
(2, 7, 1, 2000000, 0),
(2, 8, 1, 8500000, 0.1),
(3, 2, 2, 2500000, 0),
(4, 5, 1, 25000000, 0),
(4, 6, 1, 8000000, 0),
(5, 3, 1, 3000000, 0),
(5, 7, 2, 2000000, 0),
(5, 9, 1, 6000000, 0.1),
(6, 4, 2, 12000000, 0.1),
(6, 2, 3, 2500000, 0),
(7, 8, 1, 8500000, 0),
(8, 1, 1, 35000000, 0.1),
(8, 5, 1, 25000000, 0.2),
(9, 6, 1, 8000000, 0),
(9, 3, 1, 3000000, 0.1),
(10, 9, 1, 6000000, 0),
(10, 2, 2, 2500000, 0.05);


-- ============================================
-- PHẦN 2: CÁC CÂU LỆNH SQL CƠ BẢN (BASIC)
-- ============================================

-- 2.1. SELECT - Truy vấn cơ bản
-- Lấy tất cả dữ liệu từ bảng
SELECT * FROM Employees;

-- Lấy một số cột cụ thể
SELECT FirstName, LastName, Email FROM Employees;

-- Sử dụng bí danh (alias) cho cột
SELECT FirstName AS Ho, LastName AS Ten, Email AS ThuDienTu FROM Employees;

-- 2.2. WHERE - Lọc dữ liệu
-- Lọc theo điều kiện bằng
SELECT * FROM Employees WHERE DepartmentID = 1;

-- Lọc theo nhiều điều kiện với AND
SELECT * FROM Employees WHERE DepartmentID = 1 AND Salary > 12000000;

-- Lọc theo nhiều điều kiện với OR
SELECT * FROM Employees WHERE DepartmentID = 1 OR DepartmentID = 2;

-- Lọc sử dụng IN
SELECT * FROM Employees WHERE DepartmentID IN (1, 3, 5);

-- Lọc sử dụng BETWEEN
SELECT * FROM Employees WHERE Salary BETWEEN 10000000 AND 15000000;

-- Lọc sử dụng LIKE (tìm kiếm mẫu)
SELECT * FROM Employees WHERE FirstName LIKE 'Ng%';  -- Bắt đầu bằng Ng
SELECT * FROM Employees WHERE Email LIKE '%@email.com';  -- Kết thúc bằng @email.com
SELECT * FROM Employees WHERE Phone LIKE '090100100_';  -- Ký tự đơn bất kỳ

-- Lọc với IS NULL / IS NOT NULL
SELECT * FROM Employees WHERE ManagerID IS NULL;  -- Những người không có quản lý
SELECT * FROM Employees WHERE ManagerID IS NOT NULL;  -- Những người có quản lý

-- 2.3. ORDER BY - Sắp xếp dữ liệu
-- Sắp xếp tăng dần
SELECT * FROM Employees ORDER BY Salary ASC;

-- Sắp xếp giảm dần
SELECT * FROM Employees ORDER BY Salary DESC;

-- Sắp xếp theo nhiều cột
SELECT * FROM Employees ORDER BY DepartmentID ASC, Salary DESC;

-- 2.4. LIMIT / TOP - Giới hạn số lượng bản ghi
-- MySQL/PostgreSQL/SQLite
SELECT * FROM Employees LIMIT 5;

-- SQL Server
-- SELECT TOP 5 * FROM Employees;

-- Kết hợp với OFFSET (phân trang)
SELECT * FROM Employees ORDER BY EmployeeID LIMIT 5 OFFSET 0;  -- Trang 1
SELECT * FROM Employees ORDER BY EmployeeID LIMIT 5 OFFSET 5;  -- Trang 2

-- 2.5. DISTINCT - Loại bỏ trùng lặp
-- Lấy các phòng ban duy nhất
SELECT DISTINCT DepartmentID FROM Employees;

-- Lấy tổ hợp duy nhất
SELECT DISTINCT DepartmentID, Salary FROM Employees;

-- 2.6. Các hàm aggregate cơ bản
-- COUNT - Đếm số lượng
SELECT COUNT(*) AS TongSoNhanVien FROM Employees;
SELECT COUNT(DISTINCT DepartmentID) AS SoPhongBan FROM Employees;

-- SUM - Tính tổng
SELECT SUM(Salary) AS TongLuong FROM Employees;

-- AVG - Tính trung bình
SELECT AVG(Salary) AS LuongTrungBinh FROM Employees;

-- MIN - Tìm giá trị nhỏ nhất
SELECT MIN(Salary) AS LuongThapNhat FROM Employees;

-- MAX - Tìm giá trị lớn nhất
SELECT MAX(Salary) AS LuongCaoNhat FROM Employees;

-- 2.7. GROUP BY - Nhóm dữ liệu
-- Nhóm theo phòng ban và tính tổng lương
SELECT DepartmentID, COUNT(*) AS SoNhanVien, SUM(Salary) AS TongLuong
FROM Employees
GROUP BY DepartmentID;

-- Nhóm theo phòng ban với nhiều thống kê
SELECT 
    DepartmentID,
    COUNT(*) AS SoNhanVien,
    AVG(Salary) AS LuongTB,
    MIN(Salary) AS LuongMin,
    MAX(Salary) AS LuongMax
FROM Employees
GROUP BY DepartmentID;

-- 2.8. HAVING - Lọc sau khi nhóm
-- Chỉ lấy các phòng ban có trên 2 nhân viên
SELECT DepartmentID, COUNT(*) AS SoNhanVien
FROM Employees
GROUP BY DepartmentID
HAVING COUNT(*) >= 2;

-- Chỉ lấy các phòng ban có tổng lương > 30 triệu
SELECT DepartmentID, SUM(Salary) AS TongLuong
FROM Employees
GROUP BY DepartmentID
HAVING SUM(Salary) > 30000000;

-- 2.9. Các hàm xử lý chuỗi
-- UPPER / LOWER - Chuyển đổi chữ hoa/thường
SELECT UPPER(FirstName) AS HoUpper, LOWER(LastName) AS TenLower FROM Employees;

-- CONCAT - Nối chuỗi
SELECT CONCAT(FirstName, ' ', LastName) AS HoTenDayDu FROM Employees;

-- LENGTH / LEN - Độ dài chuỗi
SELECT FirstName, LENGTH(FirstName) AS DoDaiHo FROM Employees;

-- SUBSTRING - Cắt chuỗi
SELECT Email, SUBSTRING(Email, 1, 5) AS NamKyTuDau FROM Employees;

-- TRIM / LTRIM / RTRIM - Xóa khoảng trắng
SELECT TRIM('   Hello World   ') AS KetQua;

-- REPLACE - Thay thế
SELECT REPLACE(Email, '@email.com', '@company.com') AS EmailMoi FROM Employees;

-- 2.10. Các hàm xử lý ngày tháng
-- CURRENT_DATE / GETDATE() - Ngày hiện tại
SELECT CURRENT_DATE AS NgayHomNay;

-- YEAR, MONTH, DAY - Trích xuất năm, tháng, ngày
SELECT HireDate, YEAR(HireDate) AS Nam, MONTH(HireDate) AS Thang, DAY(HireDate) AS Ngay
FROM Employees;

-- DATE_ADD / DATEADD - Cộng thêm ngày
-- MySQL/PostgreSQL
SELECT HireDate, DATE_ADD(HireDate, INTERVAL 1 YEAR) AS NamSau FROM Employees;

-- SQL Server
-- SELECT HireDate, DATEADD(YEAR, 1, HireDate) AS NamSau FROM Employees;

-- DATEDIFF - Tính chênh lệch ngày
-- MySQL
SELECT HireDate, DATEDIFF(CURRENT_DATE, HireDate) AS SoNgayLamViec FROM Employees;

-- SQL Server
-- SELECT HireDate, DATEDIFF(DAY, HireDate, GETDATE()) AS SoNgayLamViec FROM Employees;

-- DATE_FORMAT / FORMAT - Định dạng ngày
-- MySQL
SELECT HireDate, DATE_FORMAT(HireDate, '%d/%m/%Y') AS DinhDangVN FROM Employees;

-- SQL Server
-- SELECT HireDate, FORMAT(HireDate, 'dd/MM/yyyy') AS DinhDangVN FROM Employees;


-- ============================================
-- PHẦN 3: CÁC CÂU LỆNH SQL TRUNG BÌNH (INTERMEDIATE)
-- ============================================

-- 3.1. INNER JOIN - Kết nối trong
-- Kết nối Employees với Departments
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    d.DepartmentName,
    e.Salary
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- Kết nối 3 bảng
SELECT 
    e.FirstName,
    e.LastName,
    d.DepartmentName,
    p.ProjectName,
    ep.Role
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
INNER JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
INNER JOIN Projects p ON ep.ProjectID = p.ProjectID;

-- 3.2. LEFT JOIN - Kết nối trái
-- Lấy tất cả nhân viên và phòng ban (kể cả nhân viên chưa có phòng ban)
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- Tìm nhân viên chưa được phân vào dự án nào
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName
FROM Employees e
LEFT JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
WHERE ep.EmployeeID IS NULL;

-- 3.3. RIGHT JOIN - Kết nối phải
-- Lấy tất cả phòng ban và nhân viên (kể cả phòng ban chưa có nhân viên)
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    e.EmployeeID,
    e.FirstName
FROM Employees e
RIGHT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- 3.4. FULL OUTER JOIN - Kết nối đầy đủ
-- MySQL không hỗ trợ trực tiếp, dùng UNION
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    e.EmployeeID,
    e.FirstName
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
UNION
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    e.EmployeeID,
    e.FirstName
FROM Departments d
RIGHT JOIN Employees e ON d.DepartmentID = e.DepartmentID;

-- SQL Server / PostgreSQL
-- SELECT 
--     d.DepartmentID,
--     d.DepartmentName,
--     e.EmployeeID,
--     e.FirstName
-- FROM Departments d
-- FULL OUTER JOIN Employees e ON d.DepartmentID = e.DepartmentID;

-- 3.5. CROSS JOIN - Tích Descartes
-- Tạo tất cả tổ hợp có thể giữa 2 bảng
SELECT 
    d.DepartmentName,
    p.ProjectName
FROM Departments d
CROSS JOIN Projects p;

-- 3.6. SELF JOIN - Tự kết nối
-- Tìm nhân viên và quản lý của họ
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS NhanVien,
    m.EmployeeID AS QuanLyID,
    CONCAT(m.FirstName, ' ', m.LastName) AS QuanLy
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;

-- 3.7. UNION / UNION ALL - Hợp tập hợp
-- UNION (loại bỏ trùng)
SELECT DepartmentID AS ID, DepartmentName AS Ten FROM Departments
UNION
SELECT ProjectID, ProjectName FROM Projects;

-- UNION ALL (giữ lại trùng)
SELECT FirstName FROM Employees
UNION ALL
SELECT CustomerName FROM Customers;

-- 3.8. Subquery - Truy vấn con
-- Subquery trong WHERE
-- Tìm nhân viên có lương cao hơn mức trung bình
SELECT * FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- Subquery trong SELECT
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.Salary,
    (SELECT AVG(Salary) FROM Employees) AS LuongTB,
    e.Salary - (SELECT AVG(Salary) FROM Employees) AS ChenhLech
FROM Employees e;

-- Subquery trong FROM
SELECT DeptStats.DepartmentID, DeptStats.SoNhanVien, DeptStats.LuongTB
FROM (
    SELECT 
        DepartmentID,
        COUNT(*) AS SoNhanVien,
        AVG(Salary) AS LuongTB
    FROM Employees
    GROUP BY DepartmentID
) AS DeptStats
WHERE DeptStats.LuongTB > 12000000;

-- Subquery với IN
SELECT * FROM Employees
WHERE DepartmentID IN (
    SELECT DepartmentID 
    FROM Departments 
    WHERE Location = 'Ha Noi'
);

-- Subquery với EXISTS
SELECT * FROM Employees e
WHERE EXISTS (
    SELECT 1 FROM EmployeeProjects ep 
    WHERE ep.EmployeeID = e.EmployeeID
);

-- 3.9. CASE WHEN - Điều kiện
-- Phân loại lương
SELECT 
    FirstName,
    LastName,
    Salary,
    CASE 
        WHEN Salary >= 15000000 THEN 'Cao'
        WHEN Salary >= 10000000 THEN 'Trung Binh'
        ELSE 'Thap'
    END AS MucLuong
FROM Employees;

-- CASE WHEN phức tạp
SELECT 
    e.FirstName,
    e.LastName,
    d.DepartmentName,
    CASE 
        WHEN d.DepartmentName = 'IT' THEN e.Salary * 1.1
        WHEN d.DepartmentName = 'Sales' THEN e.Salary * 1.15
        ELSE e.Salary * 1.05
    END AS LuongDuKien
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- 3.10. CAST / CONVERT - Chuyển đổi kiểu dữ liệu
-- Chuyển số sang chuỗi
SELECT EmployeeID, CAST(Salary AS VARCHAR(20)) AS SalaryStr FROM Employees;

-- Chuyển chuỗi sang số
SELECT CAST('12345' AS INT) AS So;

-- Chuyển đổi ngày tháng
SELECT CAST('2024-01-15' AS DATE) AS Ngay;

-- 3.11. COALESCE / ISNULL - Xử lý NULL
-- COALESCE (trả về giá trị khác NULL đầu tiên)
SELECT 
    FirstName,
    LastName,
    COALESCE(Phone, 'Chua co so dien thoai') AS SoDienThoai
FROM Employees;

-- ISNULL (SQL Server)
-- SELECT FirstName, LastName, ISNULL(Phone, 'Chua co so dien thoai') AS SoDienThoai FROM Employees;

-- 3.12. NULLIF - Trả về NULL nếu bằng nhau
SELECT NULLIF(10, 10) AS KetQua1;  -- Returns NULL
SELECT NULLIF(10, 5) AS KetQua2;   -- Returns 10

-- Ứng dụng: Tránh chia cho 0
SELECT 
    ProductName,
    StockQuantity,
    NULLIF(StockQuantity, 0) AS StockNonZero
FROM Products;


-- ============================================
-- PHẦN 4: CÁC CÂU LỆNH SQL NÂNG CAO (ADVANCED)
-- ============================================

-- 4.1. Common Table Expressions (CTE) - Biểu thức bảng chung
-- CTE đơn giản
WITH NhanVienHN AS (
    SELECT e.* 
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    WHERE d.Location = 'Ha Noi'
)
SELECT * FROM NhanVienHN WHERE Salary > 12000000;

-- Multiple CTEs
WITH 
DeptStats AS (
    SELECT 
        DepartmentID,
        COUNT(*) AS SoNhanVien,
        AVG(Salary) AS LuongTB
    FROM Employees
    GROUP BY DepartmentID
),
ProjStats AS (
    SELECT 
        p.ProjectID,
        p.ProjectName,
        COUNT(ep.EmployeeID) AS SoNhanVienThamGia
    FROM Projects p
    LEFT JOIN EmployeeProjects ep ON p.ProjectID = ep.ProjectID
    GROUP BY p.ProjectID, p.ProjectName
)
SELECT 
    d.DepartmentID,
    ds.SoNhanVien,
    ds.LuongTB,
    ps.ProjectName,
    ps.SoNhanVienThamGia
FROM Departments d
JOIN DeptStats ds ON d.DepartmentID = ds.DepartmentID
LEFT JOIN ProjStats ps ON 1=1
WHERE ds.LuongTB > 10000000;

-- 4.2. Recursive CTE - CTE đệ quy
-- Tìm cấu trúc quản lý (hierarchy)
WITH RECURSIVE OrgChart AS (
    -- Base case: Những người không có quản lý (CEO)
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        ManagerID,
        1 AS CapBac
    FROM Employees
    WHERE ManagerID IS NULL
    
    UNION ALL
    
    -- Recursive case: Những người có quản lý
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.ManagerID,
        oc.CapBac + 1
    FROM Employees e
    INNER JOIN OrgChart oc ON e.ManagerID = oc.EmployeeID
)
SELECT * FROM OrgChart ORDER BY CapBac, EmployeeID;

-- 4.3. Window Functions - Hàm cửa sổ
-- ROW_NUMBER() - Đánh số thứ tự
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    DepartmentID,
    Salary,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS STT
FROM Employees;

-- ROW_NUMBER() với PARTITION BY
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    DepartmentID,
    Salary,
    ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS STTTrongPhong
FROM Employees;

-- RANK() và DENSE_RANK()
SELECT 
    EmployeeID,
    FirstName,
    Salary,
    RANK() OVER (ORDER BY Salary DESC) AS Rank,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank
FROM Employees;

-- NTILE() - Chia thành các nhóm
SELECT 
    EmployeeID,
    FirstName,
    Salary,
    NTILE(4) OVER (ORDER BY Salary DESC) AS PhanTu
FROM Employees;

-- LAG() và LEAD() - Truy cập dòng trước/sau
SELECT 
    EmployeeID,
    FirstName,
    Salary,
    LAG(Salary, 1) OVER (ORDER BY Salary) AS LuongNguoiTruoc,
    LEAD(Salary, 1) OVER (ORDER BY Salary) AS LuongNguoiSau
FROM Employees;

-- FIRST_VALUE() và LAST_VALUE()
SELECT 
    EmployeeID,
    FirstName,
    DepartmentID,
    Salary,
    FIRST_VALUE(Salary) OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS LuongCaoNhatPhong,
    LAST_VALUE(Salary) OVER (
        PARTITION BY DepartmentID 
        ORDER BY Salary 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS LuongThapNhatPhong
FROM Employees;

-- SUM/AVG với window function
SELECT 
    EmployeeID,
    FirstName,
    Salary,
    SUM(Salary) OVER () AS TongLuongCongTy,
    AVG(Salary) OVER () AS LuongTBCongTy,
    SUM(Salary) OVER (PARTITION BY DepartmentID) AS TongLuongPhong,
    AVG(Salary) OVER (PARTITION BY DepartmentID) AS LuongTBPhong
FROM Employees;

-- Running Total (tổng lũy tích)
SELECT 
    OrderID,
    OrderDate,
    TotalAmount,
    SUM(TotalAmount) OVER (ORDER BY OrderDate) AS TongLuyTich
FROM Orders;

-- 4.4. PIVOT - Xoay cột thành dòng (SQL Server/Oracle)
-- MySQL cần dùng CASE WHEN
SELECT 
    DepartmentID,
    SUM(CASE WHEN YEAR(HireDate) = 2019 THEN 1 ELSE 0 END) AS Nam2019,
    SUM(CASE WHEN YEAR(HireDate) = 2020 THEN 1 ELSE 0 END) AS Nam2020,
    SUM(CASE WHEN YEAR(HireDate) = 2021 THEN 1 ELSE 0 END) AS Nam2021
FROM Employees
GROUP BY DepartmentID;

-- 4.5. STORED PROCEDURE - Thủ tục lưu trữ
DELIMITER //

CREATE PROCEDURE GetEmployeesByDepartment(IN deptID INT)
BEGIN
    SELECT * FROM Employees WHERE DepartmentID = deptID;
END //

CREATE PROCEDURE GetEmployeeSalaryStats(
    IN deptID INT,
    OUT avgSalary DECIMAL(10,2),
    OUT minSalary DECIMAL(10,2),
    OUT maxSalary DECIMAL(10,2)
)
BEGIN
    SELECT AVG(Salary), MIN(Salary), MAX(Salary)
    INTO avgSalary, minSalary, maxSalary
    FROM Employees
    WHERE DepartmentID = deptID;
END //

CREATE PROCEDURE UpdateEmployeeSalary(
    IN empID INT,
    IN percentage DECIMAL(5,2)
)
BEGIN
    UPDATE Employees
    SET Salary = Salary * (1 + percentage/100)
    WHERE EmployeeID = empID;
END //

DELIMITER ;

-- Gọi stored procedure
-- CALL GetEmployeesByDepartment(1);
-- CALL GetEmployeeSalaryStats(1, @avg, @min, @max);
-- SELECT @avg, @min, @max;
-- CALL UpdateEmployeeSalary(1, 10);

-- 4.6. FUNCTIONS - Hàm do người dùng định nghĩa
DELIMITER //

CREATE FUNCTION CalculateAnnualSalary(empID INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE monthlySalary DECIMAL(10,2);
    DECLARE annualSalary DECIMAL(12,2);
    
    SELECT Salary INTO monthlySalary
    FROM Employees
    WHERE EmployeeID = empID;
    
    SET annualSalary = monthlySalary * 12;
    RETURN annualSalary;
END //

CREATE FUNCTION GetEmployeeFullname(empID INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE fullname VARCHAR(100);
    
    SELECT CONCAT(FirstName, ' ', LastName) INTO fullname
    FROM Employees
    WHERE EmployeeID = empID;
    
    RETURN fullname;
END //

DELIMITER ;

-- Sử dụng function
-- SELECT EmployeeID, GetEmployeeFullname(EmployeeID) AS Fullname, CalculateAnnualSalary(EmployeeID) AS AnnualSalary FROM Employees;

-- 4.7. TRIGGERS - Bộ kích hoạt
DELIMITER //

-- Trigger trước khi INSERT
CREATE TRIGGER BeforeEmployeeInsert
BEFORE INSERT ON Employees
FOR EACH ROW
BEGIN
    IF NEW.Salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Luong khong duoc am';
    END IF;
    
    IF NEW.Email IS NULL THEN
        SET NEW.Email = CONCAT(NEW.FirstName, '.', NEW.LastName, '@default.com');
    END IF;
END //

-- Trigger sau khi UPDATE
CREATE TRIGGER AfterEmployeeUpdate
AFTER UPDATE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeAudit (EmployeeID, OldSalary, NewSalary, ChangedDate)
    VALUES (OLD.EmployeeID, OLD.Salary, NEW.Salary, NOW());
END //

DELIMITER ;

-- Tạo bảng audit cho trigger
CREATE TABLE IF NOT EXISTS EmployeeAudit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ChangedDate DATETIME
);

-- 4.8. VIEWS - Khung nhìn
-- View đơn giản
CREATE VIEW vw_EmployeeInfo AS
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    e.Email,
    e.Phone,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- View với aggregation
CREATE VIEW vw_DepartmentStats AS
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    d.Location,
    COUNT(e.EmployeeID) AS EmployeeCount,
    AVG(e.Salary) AS AvgSalary,
    SUM(e.Salary) AS TotalSalary
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName, d.Location;

-- Materialized View (PostgreSQL/Oracle)
-- CREATE MATERIALIZED VIEW mv_DepartmentStats AS
-- SELECT ... (tương tự như trên)

-- 4.9. INDEXES - Chỉ mục
-- Tạo index đơn
CREATE INDEX idx_Employee_LastName ON Employees(LastName);

-- Tạo index composite
CREATE INDEX idx_Employee_Dept_Salary ON Employees(DepartmentID, Salary);

-- Tạo index duy nhất
CREATE UNIQUE INDEX idx_Employee_Email ON Employees(Email);

-- Tạo index full-text (cho tìm kiếm văn bản)
-- CREATE FULLTEXT INDEX idx_Product_Description ON Products(Description);

-- Xem chỉ mục
-- SHOW INDEX FROM Employees;

-- Xóa chỉ mục
-- DROP INDEX idx_Employee_LastName ON Employees;

-- 4.10. TRANSACTION - Giao dịch
-- Bắt đầu giao dịch
START TRANSACTION;

-- Các thao tác
UPDATE Employees SET Salary = Salary * 1.1 WHERE DepartmentID = 1;
UPDATE Employees SET Salary = Salary * 1.15 WHERE DepartmentID = 3;

-- Commit hoặc Rollback
COMMIT;
-- ROLLBACK;

-- Transaction với SAVEPOINT
START TRANSACTION;

UPDATE Employees SET Salary = Salary + 1000000 WHERE EmployeeID = 1;
SAVEPOINT sp1;

UPDATE Employees SET Salary = Salary + 1000000 WHERE EmployeeID = 2;
SAVEPOINT sp2;

-- Rollback về savepoint
-- ROLLBACK TO sp1;

COMMIT;

-- 4.11. CURSOR - Con trỏ
DELIMITER //

CREATE PROCEDURE ProcessAllEmployees()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE empID INT;
    DECLARE empName VARCHAR(100);
    DECLARE empSalary DECIMAL(10,2);
    
    DECLARE cur CURSOR FOR 
        SELECT EmployeeID, CONCAT(FirstName, ' ', LastName), Salary 
        FROM Employees;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO empID, empName, empSalary;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Xử lý từng bản ghi
        IF empSalary < 10000000 THEN
            UPDATE Employees SET Salary = Salary * 1.2 WHERE EmployeeID = empID;
        END IF;
    END LOOP;
    
    CLOSE cur;
END //

DELIMITER ;

-- 4.12. Advanced Analytics Queries

-- Cohort Analysis (Phân tích nhóm khách hàng)
WITH CustomerCohorts AS (
    SELECT 
        CustomerID,
        DATE_FORMAT(MIN(OrderDate), '%Y-%m') AS CohortMonth
    FROM Orders
    GROUP BY CustomerID
),
CustomerOrders AS (
    SELECT 
        o.CustomerID,
        DATE_FORMAT(o.OrderDate, '%Y-%m') AS OrderMonth,
        cc.CohortMonth,
        TIMESTAMPDIFF(MONTH, cc.CohortMonth, o.OrderDate) AS MonthsSinceFirstOrder
    FROM Orders o
    JOIN CustomerCohorts cc ON o.CustomerID = cc.CustomerID
)
SELECT 
    CohortMonth,
    MonthsSinceFirstOrder,
    COUNT(DISTINCT CustomerID) AS ActiveCustomers
FROM CustomerOrders
GROUP BY CohortMonth, MonthsSinceFirstOrder
ORDER BY CohortMonth, MonthsSinceFirstOrder;

-- RFM Analysis (Recency, Frequency, Monetary)
WITH RFM AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        DATEDIFF(MAX(o.OrderDate), CURRENT_DATE) AS Recency,
        COUNT(o.OrderID) AS Frequency,
        SUM(o.TotalAmount) AS Monetary
    FROM Customers c
    LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.CustomerName
),
RFM_Scores AS (
    SELECT 
        *,
        NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(5) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM RFM
)
SELECT 
    CustomerID,
    CustomerName,
    Recency,
    Frequency,
    Monetary,
    R_Score,
    F_Score,
    M_Score,
    (R_Score + F_Score + M_Score) AS RFM_Total,
    CASE 
        WHEN R_Score >= 4 AND F_Score >= 4 AND M_Score >= 4 THEN 'Champions'
        WHEN R_Score >= 3 AND F_Score >= 3 AND M_Score >= 3 THEN 'Loyal Customers'
        WHEN R_Score >= 4 AND F_Score <= 2 THEN 'New Customers'
        WHEN R_Score <= 2 AND F_Score >= 3 THEN 'At Risk'
        ELSE 'Others'
    END AS CustomerSegment
FROM RFM_Scores
ORDER BY RFM_Total DESC;

-- Pareto Analysis (80/20 rule)
WITH ProductSales AS (
    SELECT 
        p.ProductID,
        p.ProductName,
        SUM(od.Quantity * od.UnitPrice) AS TotalSales
    FROM Products p
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    GROUP BY p.ProductID, p.ProductName
),
ProductSalesWithCumulative AS (
    SELECT 
        ProductID,
        ProductName,
        TotalSales,
        SUM(TotalSales) OVER (ORDER BY TotalSales DESC) AS CumulativeSales,
        SUM(TotalSales) OVER () AS GrandTotal
    FROM ProductSales
)
SELECT 
    ProductID,
    ProductName,
    TotalSales,
    CumulativeSales,
    GrandTotal,
    ROUND(CumulativeSales * 100.0 / GrandTotal, 2) AS CumulativePercentage
FROM ProductSalesWithCumulative
ORDER BY TotalSales DESC;

-- Time Series Analysis (Phân tích chuỗi thời gian)
WITH MonthlySales AS (
    SELECT 
        DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
        COUNT(*) AS OrderCount,
        SUM(TotalAmount) AS TotalRevenue,
        AVG(TotalAmount) AS AvgOrderValue
    FROM Orders
    GROUP BY DATE_FORMAT(OrderDate, '%Y-%m')
)
SELECT 
    Month,
    OrderCount,
    TotalRevenue,
    AvgOrderValue,
    LAG(TotalRevenue, 1) OVER (ORDER BY Month) AS PrevMonthRevenue,
    ROUND(
        (TotalRevenue - LAG(TotalRevenue, 1) OVER (ORDER BY Month)) * 100.0 / 
        NULLIF(LAG(TotalRevenue, 1) OVER (ORDER BY Month), 0), 
        2
    ) AS GrowthRate
FROM MonthlySales
ORDER BY Month;

-- 4.13. Dynamic SQL (SQL động)
DELIMITER //

CREATE PROCEDURE GetTableStats(IN tableName VARCHAR(100))
BEGIN
    SET @sql = CONCAT(
        'SELECT COUNT(*) AS RowCount FROM ', tableName
    );
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

-- 4.14. Common Table Expression với nhiều cấp độ
WITH RECURSIVE NumberSequence AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM NumberSequence WHERE n < 100
),
Primes AS (
    SELECT n 
    FROM NumberSequence 
    WHERE n > 1
    AND NOT EXISTS (
        SELECT 1 FROM NumberSequence ns2 
        WHERE ns2.n > 1 
        AND ns2.n < n 
        AND n % ns2.n = 0
    )
)
SELECT * FROM Primes LIMIT 25;

-- 4.15. JSON Operations (MySQL 5.7+, PostgreSQL)
-- Tạo bảng với cột JSON
CREATE TABLE IF NOT EXISTS EmployeeSkills (
    EmployeeID INT PRIMARY KEY,
    Skills JSON,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Chèn dữ liệu JSON
INSERT INTO EmployeeSkills VALUES 
(1, '{"technical": ["Java", "Python", "SQL"], "soft": ["Leadership", "Communication"]}'),
(2, '{"technical": ["JavaScript", "React", "Node.js"], "soft": ["Teamwork", "Problem Solving"]}'),
(3, '{"technical": ["Python", "Machine Learning", "Data Analysis"], "soft": ["Analytical Thinking"]}');

-- Truy vấn JSON
SELECT 
    EmployeeID,
    JSON_EXTRACT(Skills, '$.technical[0]') AS FirstSkill,
    JSON_LENGTH(Skills, '$.technical') AS TechnicalSkillCount
FROM EmployeeSkills;

-- Kiểm tra tồn tại trong JSON
SELECT * FROM EmployeeSkills
WHERE JSON_CONTAINS(Skills, '"Java"', '$.technical');


-- ============================================
-- PHẦN 5: DATA MANIPULATION (THAO TÁC DỮ LIỆU)
-- ============================================

-- 5.1. INSERT - Chèn dữ liệu
-- Chèn một bản ghi
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, HireDate, Salary, DepartmentID)
VALUES (11, 'Vo', 'Van M', 'vanm@email.com', '2024-01-15', 11000000, 1);

-- Chèn nhiều bản ghi
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, HireDate, Salary, DepartmentID) VALUES
(12, 'Ton', 'Thi N', 'thin@email.com', '2024-02-01', 10500000, 2),
(13, 'Mai', 'Van O', 'vano@email.com', '2024-02-15', 12000000, 3);

-- Chèn từ SELECT
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, HireDate, Salary, DepartmentID)
SELECT 
    EmployeeID + 100,
    FirstName,
    LastName,
    CONCAT('backup_', Email),
    HireDate,
    Salary,
    DepartmentID
FROM Employees
WHERE DepartmentID = 1;

-- 5.2. UPDATE - Cập nhật dữ liệu
-- Cập nhật một bản ghi
UPDATE Employees 
SET Salary = 16000000 
WHERE EmployeeID = 1;

-- Cập nhật nhiều bản ghi
UPDATE Employees 
SET Salary = Salary * 1.1 
WHERE DepartmentID = 1;

-- Cập nhật với JOIN
UPDATE Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
SET e.Salary = e.Salary * 1.15
WHERE d.Location = 'Ha Noi';

-- 5.3. DELETE - Xóa dữ liệu
-- Xóa một bản ghi
DELETE FROM Employees WHERE EmployeeID = 13;

-- Xóa với điều kiện
DELETE FROM Employees WHERE Salary < 9000000;

-- Xóa với JOIN
DELETE e FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Marketing';

-- 5.4. MERGE / UPSERT - Cập nhật hoặc chèn
-- MySQL (ON DUPLICATE KEY UPDATE)
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Salary)
VALUES (1, 'Nguyen', 'Van A Updated', 'vana@email.com', 20000000)
ON DUPLICATE KEY UPDATE 
    LastName = VALUES(LastName),
    Salary = VALUES(Salary);

-- SQL Server (MERGE)
/*
MERGE INTO Employees AS target
USING (SELECT 1 AS EmployeeID, 'Nguyen' AS FirstName, 'Van A Updated' AS LastName) AS source
ON (target.EmployeeID = source.EmployeeID)
WHEN MATCHED THEN
    UPDATE SET LastName = source.LastName
WHEN NOT MATCHED THEN
    INSERT (EmployeeID, FirstName, LastName)
    VALUES (source.EmployeeID, source.FirstName, source.LastName);
*/

-- 5.5. TRUNCATE - Xóa toàn bộ dữ liệu (nhanh hơn DELETE)
-- TRUNCATE TABLE EmployeeAudit;


-- ============================================
-- PHẦN 6: DATA DEFINITION (ĐỊNH NGHĨA DỮ LIỆU)
-- ============================================

-- 6.1. ALTER TABLE - Sửa cấu trúc bảng
-- Thêm cột
ALTER TABLE Employees ADD COLUMN Bonus DECIMAL(10,2);

-- Sửa cột
ALTER TABLE Employees MODIFY COLUMN Phone VARCHAR(30);

-- Xóa cột
ALTER TABLE Employees DROP COLUMN Bonus;

-- Thêm constraint
ALTER TABLE Employees ADD CONSTRAINT CHK_Salary CHECK (Salary > 0);

-- Xóa constraint
-- ALTER TABLE Employees DROP CONSTRAINT CHK_Salary;

-- Đổi tên bảng
-- ALTER TABLE Employees RENAME TO Staff;

-- 6.2. DROP TABLE - Xóa bảng
-- DROP TABLE IF EXISTS EmployeeAudit;

-- 6.3. CREATE TABLE với các constraints
CREATE TABLE IF NOT EXISTS Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20) NOT NULL,
    Address VARCHAR(200),
    City VARCHAR(50) DEFAULT 'Ha Noi',
    Country VARCHAR(50) DEFAULT 'Vietnam',
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    IsActive BOOLEAN DEFAULT TRUE,
    CONSTRAINT CHK_Phone CHECK (Phone LIKE '0%')
);

-- 6.4. Temporary Tables - Bảng tạm
CREATE TEMPORARY TABLE TempEmployeeStats AS
SELECT 
    DepartmentID,
    COUNT(*) AS EmployeeCount,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentID;

SELECT * FROM TempEmployeeStats;

-- 6.5. Table Partitioning (Phân vùng bảng - nâng cao)
-- CREATE TABLE Orders_Partitioned (
--     OrderID INT,
--     OrderDate DATE,
--     TotalAmount DECIMAL(12,2)
-- )
-- PARTITION BY RANGE (YEAR(OrderDate)) (
--     PARTITION p2022 VALUES LESS THAN (2023),
--     PARTITION p2023 VALUES LESS THAN (2024),
--     PARTITION p2024 VALUES LESS THAN (2025),
--     PARTITION pmax VALUES LESS THAN MAXVALUE
-- );


-- ============================================
-- PHẦN 7: PERFORMANCE & OPTIMIZATION (TỐI ƯU HIỆU NĂNG)
-- ============================================

-- 7.1. EXPLAIN - Phân tích truy vấn
EXPLAIN SELECT * FROM Employees WHERE DepartmentID = 1;

EXPLAIN SELECT 
    e.FirstName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 10000000;

-- 7.2. Query Optimization Tips
-- Tránh SELECT *
-- Thay vì: SELECT * FROM Employees
-- Dùng: SELECT EmployeeID, FirstName, LastName FROM Employees

-- Sử dụng EXISTS thay vì IN cho subquery lớn
-- Hiệu quả: SELECT * FROM Employees e WHERE EXISTS (SELECT 1 FROM EmployeeProjects ep WHERE ep.EmployeeID = e.EmployeeID)
-- Kém hiệu quả: SELECT * FROM Employees WHERE EmployeeID IN (SELECT EmployeeID FROM EmployeeProjects)

-- Tránh function trên column trong WHERE
-- Kém hiệu quả: WHERE YEAR(HireDate) = 2020
-- Hiệu quả: WHERE HireDate >= '2020-01-01' AND HireDate < '2021-01-01'

-- Sử dụng UNION ALL thay vì UNION khi không cần loại bỏ trùng
-- UNION ALL nhanh hơn vì không cần sort để loại bỏ duplicate

-- 7.3. Database Statistics
-- ANALYZE TABLE Employees;
-- SHOW TABLE STATUS LIKE 'Employees';


-- ============================================
-- PHẦN 8: SECURITY & PERMISSIONS (BẢO MẬT VÀ PHÂN QUYỀN)
-- ============================================

-- 8.1. CREATE USER - Tạo người dùng
-- CREATE USER 'developer'@'localhost' IDENTIFIED BY 'password123';

-- 8.2. GRANT - Cấp quyền
-- GRANT SELECT, INSERT, UPDATE ON database.* TO 'developer'@'localhost';
-- GRANT ALL PRIVILEGES ON database.* TO 'admin'@'localhost';

-- 8.3. REVOKE - Thu hồi quyền
-- REVOKE DELETE ON database.* FROM 'developer'@'localhost';

-- 8.4. SHOW GRANTS - Xem quyền
-- SHOW GRANTS FOR 'developer'@'localhost';

-- 8.5. Roles (MySQL 8.0+)
-- CREATE ROLE 'read_only';
-- GRANT SELECT ON database.* TO 'read_only';
-- GRANT 'read_only' TO 'developer'@'localhost';


-- ============================================
-- PHẦN 9: BACKUP & RESTORE (SAO LƯU VÀ KHÔI PHỤC)
-- ============================================

-- 9.1. Backup bằng mysqldump (command line)
-- mysqldump -u username -p database_name > backup.sql
-- mysqldump -u username -p database_name table1 table2 > backup.sql

-- 9.2. Restore từ file backup
-- mysql -u username -p database_name < backup.sql

-- 9.3. Backup một phần
-- mysqldump -u username -p database_name --where="DepartmentID=1" Employees > employees_dept1.sql


-- ============================================
-- PHẦN 10: CÁC MẪU TRUY VẤN THỰC TẾ
-- ============================================

-- 10.1. Báo cáo doanh thu theo tháng
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS Thang,
    COUNT(OrderID) AS SoDonHang,
    SUM(TotalAmount) AS DoanhThu,
    AVG(TotalAmount) AS GiaTriTB
FROM Orders
GROUP BY DATE_FORMAT(OrderDate, '%Y-%m')
ORDER BY Thang;

-- 10.2. Top 5 sản phẩm bán chạy nhất
SELECT 
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS TongSoLuongBan,
    SUM(od.Quantity * od.UnitPrice) AS TongDoanhThu
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TongSoLuongBan DESC
LIMIT 5;

-- 10.3. Khách hàng thân thiết (mua nhiều nhất)
SELECT 
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS SoLanMua,
    SUM(o.TotalAmount) AS TongChiTieu,
    MAX(o.OrderDate) as LanMuaCuoi
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TongChiTieu DESC
LIMIT 10;

-- 10.4. Nhân viên xuất sắc (tham gia nhiều dự án nhất)
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS HoTen,
    d.DepartmentName,
    COUNT(ep.ProjectID) AS SoDuAnThamGia,
    SUM(ep.HoursWorked) AS TongGioLam
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
GROUP BY e.EmployeeID, HoTen, d.DepartmentName
ORDER BY SoDuAnThamGia DESC, TongGioLam DESC;

-- 10.5. Dự án vượt ngân sách
SELECT 
    p.ProjectID,
    p.ProjectName,
    p.Budget,
    SUM(ep.HoursWorked * 500000) AS ChiPhiThucTe,  -- Giả sử 500k/giờ
    SUM(ep.HoursWorked * 500000) - p.Budget AS VuotNganSach
FROM Projects p
JOIN EmployeeProjects ep ON p.ProjectID = ep.ProjectID
GROUP BY p.ProjectID, p.ProjectName, p.Budget
HAVING ChiPhiThucTe > p.Budget;

-- 10.6. Tỷ lệ hoàn thành dự án
SELECT 
    Status,
    COUNT(*) AS SoDuAn,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Projects), 2) AS TyLePhanTram
FROM Projects
GROUP BY Status;

-- 10.7. Phân tích biến động nhân sự
SELECT 
    YEAR(HireDate) AS Nam,
    COUNT(*) AS SoNhanVienMoi,
    (SELECT COUNT(*) FROM Employees) AS TongNhanVienHienTai
FROM Employees
GROUP BY YEAR(HireDate)
ORDER BY Nam;

-- 10.8. Sản phẩm tồn kho cần đặt hàng lại
SELECT 
    ProductID,
    ProductName,
    StockQuantity,
    CASE 
        WHEN StockQuantity < 20 THEN 'Can dat hang gap'
        WHEN StockQuantity < 50 THEN 'Can theo doi'
        ELSE 'Du hang'
    END AS TrangThai
FROM Products
WHERE StockQuantity < 50
ORDER BY StockQuantity ASC;

-- 10.9. Đơn hàng chưa giao trong vòng 7 ngày
SELECT 
    o.OrderID,
    c.CustomerName,
    o.OrderDate,
    DATEDIFF(CURRENT_DATE, o.OrderDate) AS SoNgayCho
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.ShipDate IS NULL
AND DATEDIFF(CURRENT_DATE, o.OrderDate) > 7
ORDER BY SoNgayCho DESC;

-- 10.10. Dashboard tổng quan
SELECT 
    (SELECT COUNT(*) FROM Employees) AS TongNhanVien,
    (SELECT COUNT(*) FROM Departments) AS TongPhongBan,
    (SELECT COUNT(*) FROM Projects WHERE Status = 'In Progress') AS DuAnDangChay,
    (SELECT SUM(TotalAmount) FROM Orders WHERE Status = 'Delivered') AS TongDoanhThu,
    (SELECT AVG(Salary) FROM Employees) AS LuongTrungBinh;

-- ============================================
-- KẾT THÚC FILE SQL MẪU
-- ============================================
