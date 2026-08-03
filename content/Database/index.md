---
title: "🚀 Database SQL"
description: "Dữ liệu là linh hồn của ứng dụng. Mục này giúp bạn làm chủ các kỹ năng truy vấn và quản lý cơ sở dữ liệu để phục vụ c..."
---

# 🗄️ Database & SQL Hub

Dữ liệu là linh hồn của ứng dụng. Mục này giúp bạn làm chủ các kỹ năng truy vấn và quản lý cơ sở dữ liệu để phục vụ công việc kiểm thử.

## 📂 Tài liệu thực chiến

| Tài liệu | Mô tả |
| :--- | :--- |
| **[SQL Queries](SQL-Queries.md)** | Tổng hợp các câu lệnh SELECT, JOIN, GROUP BY từ cơ bản đến nâng cao. |
| **[Advanced SQL Samples](sql_samples.sql)** | Các kịch bản truy vấn phức tạp, xử lý dữ liệu lớn và tối ưu hóa query. |

## 📅 Daily Database Tasks cho Tester

*   **Chuẩn bị dữ liệu (Data Seeding):** Sử dụng câu lệnh `INSERT`, `UPDATE` để tạo ra các trạng thái dữ liệu cần thiết trước khi test.
*   **Xác minh kết quả (Data Verification):** Sau khi thực hiện thao tác trên giao diện, hãy kiểm tra trực tiếp trong Database xem dữ liệu có được lưu đúng và đủ hay không.
*   **Kiểm tra Ràng buộc (Constraint Testing):** Thử nhập các dữ liệu vi phạm khóa chính (Primary Key), khóa ngoại (Foreign Key) hoặc các ràng buộc Null/Unique để xem DB xử lý thế nào.
*   **Dọn dẹp dữ liệu (Data Cleanup):** Xóa bỏ các dữ liệu rác sau khi kết thúc đợt test để giữ môi trường sạch sẽ.

---
> 🔗 Xem thêm: **[Database Testing Snippets](../Testing/Database-Testing/SQL-Snippets.md)** để biết các case kiểm thử DB phổ biến.
