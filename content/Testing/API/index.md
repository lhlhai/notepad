# 🔌 API Testing Hub

API Testing cho phép kiểm tra logic nghiệp vụ ở tầng dưới, giúp phát hiện lỗi sớm hơn và hiệu quả hơn so với kiểm thử giao diện (UI).

## 📂 Tài liệu hỗ trợ

| Chủ đề | Nội dung chính |
| :--- | :--- |
| **[API Theory](Theory.md)** | Hiểu về HTTP Methods, Status Codes, Headers và cấu trúc Request/Response. |
| **[API Cheatsheet](Cheatsheet.md)** | Các kỹ thuật kiểm thử logic, validate schema và sử dụng Postman/Newman. |
| **[API Security](Security.md)** | Checklist kiểm tra bảo mật API, ngăn chặn các lỗ hổng phổ biến như Injections, Broken Auth. |

## 📅 Quy trình kiểm thử API hàng ngày

Để đảm bảo các dịch vụ backend hoạt động ổn định, bạn nên tuân thủ các bước sau:

*   **Xác thực Schema (Contract Testing):** Đảm bảo cấu trúc dữ liệu trả về đúng như tài liệu (Swagger/OpenAPI). Bất kỳ thay đổi nào ở schema cũng có thể làm hỏng ứng dụng phía Client.
*   **Kiểm tra Logic & Data:** Thực hiện các request với dữ liệu hợp lệ và không hợp lệ để kiểm tra các quy tắc nghiệp vụ (Business Rules).
*   **Kiểm tra Phân quyền (Authorization):** Đảm bảo User A không thể truy cập hoặc sửa đổi dữ liệu của User B thông qua API.
*   **Giám sát hiệu năng API:** Theo dõi thời gian phản hồi (Response Time) để đảm bảo hệ thống không bị chậm khi tải cao.

---
> 💡 **Mẹo:** Sử dụng **[SQL Snippets](../Database-Testing/SQL-Snippets.md)** để chuẩn bị dữ liệu test hoặc verify kết quả trực tiếp trong Database sau khi gọi API.
