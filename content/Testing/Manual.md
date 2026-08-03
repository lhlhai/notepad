# 🧪 Manual Testing: Kiến thức từ Cơ bản đến Nâng cao

Manual Testing (Kiểm thử thủ công) là quá trình kiểm tra phần mềm bằng tay để tìm lỗi mà không sử dụng các công cụ tự động hóa. Đây là bước nền tảng và cực kỳ quan trọng trong mọi dự án phần mềm.

## 1. Tổng quan về Manual Testing
Manual Testing cho phép kiểm thử viên (Tester) đóng vai trò là người dùng cuối để đánh giá trải nghiệm, giao diện và tính logic của ứng dụng.

### Tại sao Manual Testing vẫn quan trọng?
- **Khám phá (Exploratory Testing):** Con người có khả năng phát hiện các lỗi bất ngờ mà script tự động không thể bao quát.
- **Trải nghiệm người dùng (UX):** Đánh giá sự thân thiện, màu sắc, bố cục - điều mà máy móc chưa làm tốt.
- **Chi phí thấp cho dự án nhỏ:** Không mất thời gian và chi phí đầu tư vào framework tự động hóa ban đầu.
- **Tính linh hoạt:** Có thể thực hiện ngay khi có thay đổi nhỏ mà không cần cập nhật code kiểm thử.

---

## 2. Quy trình kiểm thử phần mềm (STLC - Software Testing Life Cycle)
Một quy trình Manual Testing chuẩn bao gồm các giai đoạn:

1. **Phân tích yêu cầu (Requirement Analysis):** Hiểu rõ spec, xác định những gì cần kiểm thử.
2. **Lập kế hoạch (Test Planning):** Xác định mục tiêu, phạm vi, nguồn lực và lịch trình.
3. **Thiết kế kịch bản (Test Case Development):** Viết các bước thực hiện, dữ liệu đầu vào và kết quả mong đợi.
4. **Thiết lập môi trường (Environment Setup):** Chuẩn bị phần cứng, phần mềm và dữ liệu giả lập.
5. **Thực thi kiểm thử (Test Execution):** Chạy các test case và ghi nhận kết quả.
6. **Đóng chu trình (Test Cycle Closure):** Tổng kết, báo cáo và đánh giá chất lượng.

---

## 3. Các loại kiểm thử thủ công phổ biến
| Loại kiểm thử | Mục tiêu |
| :--- | :--- |
| **Unit Testing** | Kiểm tra từng đơn vị mã nguồn nhỏ nhất (thường do Dev làm). |
| **Integration Testing** | Kiểm tra sự tương tác giữa các module với nhau. |
| **System Testing** | Kiểm tra toàn bộ hệ thống sau khi tích hợp đầy đủ. |
| **Acceptance Testing (UAT)** | Kiểm tra xem hệ thống có đáp ứng yêu cầu của khách hàng không. |
| **Smoke Testing** | Kiểm tra nhanh các tính năng quan trọng nhất để đảm bảo build ổn định. |
| **Regression Testing** | Kiểm tra lại các tính năng cũ sau khi có sự thay đổi code mới. |

---

## 4. Kỹ thuật thiết kế Test Case (Test Design Techniques)
Để tối ưu số lượng test case mà vẫn đảm bảo độ bao phủ, cần áp dụng các kỹ thuật:
- **Phân vùng tương đương (Equivalence Partitioning):** Chia dữ liệu vào thành các nhóm tương đương.
- **Phân tích giá trị biên (Boundary Value Analysis):** Tập trung vào các giá trị tại biên (min, max, cận biên).
- **Bảng quyết định (Decision Table):** Dùng cho các logic phức tạp với nhiều điều kiện kết hợp.
- **Đoán lỗi (Error Guessing):** Dựa trên kinh nghiệm để dự đoán các lỗi hay xảy ra.

---

## 5. Quy trình quản lý lỗi (Bug Life Cycle)
Khi phát hiện lỗi, Tester cần báo cáo theo quy trình:
1. **New:** Lỗi mới được phát hiện.
2. **Assigned:** Giao cho Developer xử lý.
3. **Open:** Developer đang nghiên cứu và sửa lỗi.
4. **Fixed:** Lỗi đã được sửa.
5. **Pending Retest:** Chờ Tester kiểm tra lại.
6. **Verified/Closed:** Lỗi đã được xác nhận là đã sửa xong.
7. **Reopen:** Nếu lỗi vẫn còn sau khi sửa.

---

## 6. Kỹ năng cần thiết của một Manual Tester
- **Tư duy phân tích:** Khả năng nhìn nhận vấn đề từ nhiều góc độ.
- **Sự tỉ mỉ:** Không bỏ sót các chi tiết nhỏ nhất.
- **Giao tiếp:** Truyền đạt lỗi một cách khéo léo và chính xác cho Team Dev.
- **Quản lý thời gian:** Sắp xếp ưu tiên các tính năng quan trọng trước.

> 💡 **Mẹo:** Luôn đặt câu hỏi "Nếu tôi làm thế này thì điều gì sẽ xảy ra?" để tìm ra những case hiếm (edge cases).
