---
title: "🎉 SQL for"
description: "Trong công việc hàng ngày, Tester cần truy cập trực tiếp vào Database để xác minh rằng dữ liệu được lưu trữ đúng như ..."
---

# 🗄️ SQL for Testers: Data Verification Mastery

Trong công việc hàng ngày, Tester cần truy cập trực tiếp vào Database để xác minh rằng dữ liệu được lưu trữ đúng như những gì hiển thị trên giao diện (UI).

## 1. Xác minh dữ liệu cơ bản (CRUD Verification)
Sau khi thực hiện các hành động Thêm, Sửa, Xóa trên UI, hãy dùng các câu lệnh này để kiểm tra "sự thật" dưới Database.

| Mục tiêu | Câu lệnh SQL mẫu |
| :--- | :--- |
| **Kiểm tra bản ghi mới** | `SELECT * FROM users WHERE email = 'test@example.com';` |
| **Xác nhận cập nhật** | `SELECT status, updated_at FROM orders WHERE order_id = 'ORD-123';` |
| **Kiểm tra xóa mềm** | `SELECT * FROM products WHERE id = 50 AND deleted_at IS NOT NULL;` |

---

## 2. Kiểm tra tính toàn vẹn và trùng lặp
Lỗi trùng lặp dữ liệu là một trong những lỗi phổ biến nhất khi hệ thống không xử lý tốt các yêu cầu đồng thời (Concurrency).

### Tìm các bản ghi bị trùng Email
```sql
SELECT email, COUNT(*) 
FROM users 
GROUP BY email 
HAVING COUNT(*) > 1;
```

### Kiểm tra các bản ghi "mồ côi" (Orphan Records)
Ví dụ: Tìm các đơn hàng không có thông tin khách hàng tương ứng.
```sql
SELECT o.order_id 
FROM orders o 
LEFT JOIN users u ON o.user_id = u.id 
WHERE u.id IS NULL;
```

---

## 3. Các hàm tổng hợp để đối soát báo cáo
Khi test các tính năng báo cáo hoặc thống kê, bạn cần tự tính toán lại các con số để đối chiếu với UI.

- **Tính tổng doanh thu theo ngày:**
  ```sql
  SELECT DATE(created_at) as date, SUM(total_amount) 
  FROM orders 
  WHERE status = 'COMPLETED' 
  GROUP BY DATE(created_at);
  ```
- **Đếm số lượng bản ghi theo trạng thái:**
  ```sql
  SELECT status, COUNT(*) 
  FROM tasks 
  GROUP BY status;
  ```

---

## 4. Mẹo an toàn khi thao tác Database
Tuyệt đối không chạy các lệnh `UPDATE` hoặc `DELETE` mà không có mệnh đề `WHERE` cụ thể. Một thói quen tốt của Senior Tester là luôn chạy lệnh `SELECT` với cùng điều kiện `WHERE` trước khi thực hiện thay đổi để đảm bảo bạn đang tác động đúng đối tượng. Nếu có thể, hãy thực hiện các thao tác thay đổi dữ liệu trong một **Transaction** để có thể `ROLLBACK` nếu xảy ra sai sót.

---
> 💡 **AI Prompt Tip:** *"Viết một câu lệnh SQL JOIN để lấy tên khách hàng và tên sản phẩm từ 3 bảng: users, orders, và order_items cho đơn hàng có ID là 999."*
