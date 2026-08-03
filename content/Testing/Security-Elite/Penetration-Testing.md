# 🛡️ Elite Security: Penetration Testing for QA

Một "Super Tester" không chỉ tìm lỗi logic mà còn phải là một "Ethical Hacker" biết cách bảo vệ hệ thống khỏi các cuộc tấn công từ bên ngoài.

## 1. Tư duy của một Penetration Tester
Đừng chỉ kiểm tra xem hệ thống hoạt động như thế nào, hãy tìm cách khiến nó hoạt động sai mục đích ban đầu.
- **Information Gathering:** Thu thập mọi thông tin có thể về hệ thống (Tech stack, server info, hidden endpoints).
- **Vulnerability Assessment:** Tìm kiếm các lỗ hổng đã biết thông qua các công cụ quét.
- **Exploitation:** Thử nghiệm tấn công để xác định mức độ ảnh hưởng thực tế.

---

## 2. Advanced Attack Vectors
Đi sâu vào các kỹ thuật tấn công phức tạp hơn ngoài OWASP Top 10 cơ bản.

| Kỹ thuật | Mô tả | Cách phòng chống |
| :--- | :--- | :--- |
| **SSRF** | Server-Side Request Forgery: Lừa server gọi tới các địa chỉ nội bộ. | Validate URL đầu vào nghiêm ngặt, dùng whitelist. |
| **Insecure Deserialization** | Tận dụng việc giải mã dữ liệu sai cách để thực thi code. | Tránh dùng các thư viện serialization không an toàn. |
| **XXE Injection** | Tấn công thông qua các thực thể bên ngoài trong file XML. | Vô hiệu hóa DTD (Document Type Definitions) trong parser. |
| **Broken Access Control** | Lỗi phân quyền sâu (vd: truy cập admin dashboard bằng cách sửa URL). | Luôn kiểm tra quyền ở phía Server cho mọi request. |

---

## 3. The Elite Security Toolkit
Những công cụ mà các chuyên gia bảo mật hàng đầu tin dùng:
- **Burp Suite Professional:** Công cụ mạnh mẽ nhất để đánh chặn, phân tích và tấn công ứng dụng web.
- **OWASP ZAP:** Lựa chọn thay thế mã nguồn mở tuyệt vời, dễ dàng tích hợp vào CI/CD để quét tự động.
- **Nmap:** Quét cổng (Port scanning) để tìm các dịch vụ đang chạy công khai trên server.
- **Sqlmap:** Tự động hóa việc tìm kiếm và khai thác các lỗ hổng SQL Injection.

---

## 4. Tích hợp Bảo mật vào Quy trình QA (DevSecOps)
Bảo mật không nên là bước cuối cùng trước khi release. Hãy đưa nó vào sớm hơn (Shift Left Security):
- Sử dụng các công cụ **SAST** (Static Application Security Testing) để quét code khi Dev vừa push.
- Sử dụng **DAST** (Dynamic Application Security Testing) để quét ứng dụng đang chạy trong môi trường Staging.
- Đào tạo đội ngũ về **Secure Coding Practices** để ngăn chặn lỗi ngay từ khi viết code.

---
> 💡 **AI Prompt Tip:** *"Hãy đóng vai một chuyên gia bảo mật, phân tích đoạn mã sau và tìm ra 3 lỗ hổng bảo mật tiềm ẩn: [Dán Code Backend]"*
