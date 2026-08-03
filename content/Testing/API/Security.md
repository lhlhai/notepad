---
title: "🧪 API Security"
description: "Bảo mật API là một phần không thể thiếu trong quy trình đảm bảo chất lượng. Việc bỏ sót các lỗ hổng bảo mật ở tầng API có thể dẫn đến rò rỉ dữ liệu nghiêm trọng."
---

# 🔒 API Testing: Security & Best Practices

Bảo mật API là một phần không thể thiếu trong quy trình đảm bảo chất lượng. Việc bỏ sót các lỗ hổng bảo mật ở tầng API có thể dẫn đến rò rỉ dữ liệu nghiêm trọng và ảnh hưởng đến uy tín của sản phẩm.

## 1. Các lỗ hổng bảo mật API phổ biến (OWASP API Top 10)
Hiểu rõ các nguy cơ giúp Tester xây dựng các kịch bản kiểm thử có trọng tâm và hiệu quả hơn.

| Lỗ hổng | Mô tả chi tiết | Cách kiểm thử thực tế |
| :--- | :--- | :--- |
| **IDOR (BOLA)** | Truy cập tài nguyên của người khác bằng cách thay đổi ID. | Đăng nhập User A, thử gọi API lấy profile của User B bằng ID của B. |
| **Broken Auth** | Cơ chế xác thực yếu hoặc bị lỗi. | Thử sử dụng Token đã hết hạn hoặc Token của môi trường khác. |
| **Mass Assignment** | Cho phép cập nhật các trường không được phép. | Thử gửi thêm field `"role": "admin"` trong request cập nhật profile. |
| **Rate Limiting** | Không giới hạn số lượng yêu cầu. | Dùng script gọi API liên tục 1000 lần trong 1 phút để xem server có chặn không. |

---

## 2. Checklist kiểm thử bảo mật hàng ngày
Tester nên áp dụng checklist này cho mọi Endpoint quan trọng trước khi bàn giao sản phẩm.

### Xác thực và Phân quyền (Authentication & Authorization)
- [ ] Mọi API yêu cầu đăng nhập đều phải kiểm tra Token hợp lệ.
- [ ] Kiểm tra xem Token có được thu hồi sau khi người dùng đăng xuất (Logout) hay không.
- [ ] Xác minh rằng người dùng có quyền thấp không thể gọi được các API dành cho Admin.

### Kiểm soát dữ liệu (Data Control)
- [ ] Kiểm tra xem thông tin nhạy cảm (mật khẩu, số thẻ tín dụng) có bị trả về trong Response Body không.
- [ ] Đảm bảo dữ liệu đầu vào được kiểm tra (Validation) để tránh lỗi SQL Injection hoặc XSS.
- [ ] Kiểm tra xem hệ thống có trả về thông tin lỗi chi tiết (Stack Trace) quá mức cần thiết, gây lộ kiến trúc hệ thống không.

---

## 3. Các Best Practices để duy trì API an toàn
Việc bảo mật không chỉ dừng lại ở việc tìm lỗi mà còn nằm ở cách thiết kế và vận hành hệ thống. Luôn sử dụng giao thức **HTTPS** để mã hóa dữ liệu trên đường truyền. Triển khai cơ chế **CORS (Cross-Origin Resource Sharing)** một cách nghiêm ngặt để chỉ cho phép các domain tin cậy truy cập API.

Ngoài ra, hãy thường xuyên thực hiện **Security Audits** và sử dụng các công cụ quét lỗ hổng tự động như **OWASP ZAP** hoặc **Burp Suite** để phát hiện sớm các vấn đề tiềm ẩn. Việc giáo dục đội ngũ phát triển về các nguyên tắc bảo mật từ giai đoạn thiết kế (Security by Design) sẽ giúp giảm thiểu tối đa các rủi ro về sau.

---
> 💡 **AI Prompt Tip:** *"Giả lập một cuộc tấn công IDOR đơn giản trên một API lấy thông tin đơn hàng và đề xuất cách khắc phục phía backend."*
