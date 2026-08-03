---
title: "🚀 API Theory"
description: "Kiểm thử giao diện lập trình ứng dụng (API) tập trung vào việc xác minh tính chính xác, hiệu suất và bảo mật của các tầng logic nghiệp vụ."
---

# 📖 API Testing: Technical Foundation

Kiểm thử giao diện lập trình ứng dụng (API) tập trung vào việc xác minh tính chính xác, hiệu suất và bảo mật của các tầng logic nghiệp vụ mà không cần thông qua giao diện người dùng.

## 1. Các phương thức HTTP phổ biến
Trong kiến trúc RESTful, mỗi phương thức HTTP đại diện cho một hành động cụ thể trên tài nguyên. Việc hiểu rõ ý nghĩa của từng phương thức là điều kiện tiên quyết để thực hiện kiểm thử API hiệu quả.

| Phương thức | Hành động tương ứng | Tính chất quan trọng |
| :--- | :--- | :--- |
| **GET** | Truy xuất dữ liệu từ server. | Không làm thay đổi trạng thái dữ liệu (Idempotent). |
| **POST** | Tạo mới một tài nguyên. | Thường trả về mã `201 Created` khi thành công. |
| **PUT** | Cập nhật toàn bộ tài nguyên. | Thay thế tài nguyên cũ bằng dữ liệu mới hoàn toàn. |
| **PATCH** | Cập nhật một phần tài nguyên. | Chỉ thay đổi các trường dữ liệu được gửi lên. |
| **DELETE** | Xóa bỏ tài nguyên. | Thường trả về mã `204 No Content` hoặc `200 OK`. |

---

## 2. Cấu trúc của một API Request và Response
Mỗi giao dịch API bao gồm hai thành phần chính là yêu cầu (Request) từ phía khách hàng và phản hồi (Response) từ phía máy chủ. Tester cần kiểm tra kỹ lưỡng các thành phần này để đảm bảo sự đồng bộ giữa các hệ thống.

### Thành phần của Request
Một yêu cầu API tiêu chuẩn thường bao gồm **Endpoint URL**, các **Headers** (như Content-Type, Authorization), và **Body** chứa dữ liệu định dạng JSON hoặc XML. Ngoài ra, các tham số **Query Parameters** trong URL cũng đóng vai trò quan trọng trong việc lọc hoặc sắp xếp dữ liệu.

### Thành phần của Response
Phản hồi từ máy chủ bao gồm **Status Code** để thông báo kết quả, **Response Headers** chứa thông tin về server và định dạng dữ liệu, cùng với **Response Body** mang giá trị thực tế mà khách hàng yêu cầu. Tester phải xác minh rằng định dạng của body khớp với tài liệu đặc tả kỹ thuật.

---

## 3. Lợi ích của việc kiểm thử API sớm
Việc thực hiện kiểm thử ở tầng API mang lại nhiều giá trị chiến lược cho dự án. Đầu tiên, kiểm thử API cho phép phát hiện các lỗi logic nghiệp vụ ngay cả khi giao diện người dùng (UI) chưa hoàn thiện, giúp rút ngắn chu kỳ phản hồi. 

Thứ hai, các bài kiểm tra API có tốc độ thực thi nhanh hơn đáng kể so với UI Test và ít bị ảnh hưởng bởi những thay đổi nhỏ về giao diện. Điều này giúp hệ thống tự động hóa hoạt động ổn định hơn và cung cấp độ bao phủ kiểm thử cao hơn cho các tình huống khó giả lập trên giao diện người dùng.

---
> 💡 **AI Prompt Tip:** *"Giải thích sự khác biệt giữa kiến trúc REST và GraphQL từ góc độ của một kiểm thử viên phần mềm."*
