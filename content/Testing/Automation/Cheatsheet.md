---
title: "🎈 Automation Cheatsheet"
description: "Tài liệu này cung cấp các chỉ dẫn nhanh và các đoạn mã thực dụng cho công việc tự động hóa hàng ngày, tập trung vào hiệu suất và tính ổn định của mã nguồn."
---

# ⚡ Automation Testing: Quick Reference & Snippets

Tài liệu này cung cấp các chỉ dẫn nhanh và các đoạn mã thực dụng cho công việc tự động hóa hàng ngày, tập trung vào hiệu suất và tính ổn định của mã nguồn.

## 1. Lệnh thực thi Pytest thường dùng
Việc sử dụng các tham số dòng lệnh chính xác giúp Tester kiểm soát quá trình thực thi một cách linh hoạt. Bảng dưới đây tóm tắt các lệnh phổ biến nhất khi làm việc với Pytest.

| Mục tiêu thực thi | Lệnh chi tiết | Ghi chú thực chiến |
| :--- | :--- | :--- |
| **Chạy song song** | `pytest -n auto` | Tự động phát hiện số lượng CPU để tối ưu tốc độ. |
| **Dừng khi gặp lỗi** | `pytest -x` | Dừng ngay lập tức khi có test case đầu tiên bị fail. |
| **Chạy lại lỗi** | `pytest --lf` | Chỉ chạy lại những test case đã fail ở lần trước (Last Failed). |
| **Xuất báo cáo** | `pytest --alluredir=res` | Tạo dữ liệu cho Allure Report để xem biểu đồ trực quan. |

---

## 2. Playwright Python Snippets
Playwright là một công cụ mạnh mẽ hỗ trợ kiểm thử hiện đại. Dưới đây là các đoạn mã quan trọng thường được sử dụng trong các kịch bản kiểm thử giao diện người dùng (UI).

### Quản lý trạng thái trang và Trình duyệt
Việc khởi tạo trình duyệt đúng cách đảm bảo môi trường kiểm thử luôn sạch sẽ. Sử dụng `sync_playwright` giúp quản lý ngữ cảnh trình duyệt một cách an toàn và tự động đóng các tiến trình sau khi hoàn tất.

```python
from playwright.sync_api import sync_playwright

def test_login_flow():
    with sync_playwright() as p:
        # Khởi chạy trình duyệt ở chế độ có giao diện để quan sát
        browser = p.chromium.launch(headless=False)
        context = browser.new_context()
        page = context.new_page()
        
        # Điều hướng và kiểm tra tiêu đề
        page.goto("https://portal.example.com")
        assert "Login" in page.title()
        
        browser.close()
```

### Xử lý các phần tử giao diện (Locators & Actions)
Thay vì sử dụng các phương thức chờ đợi cứng (hard sleep), Playwright cung cấp cơ chế tự động chờ (auto-wait) giúp giảm thiểu tình trạng test case bị lỗi do mạng chậm hoặc giao diện chưa kịp tải.

| Hành động | Đoạn mã mẫu | Lưu ý |
| :--- | :--- | :--- |
| **Nhập liệu** | `page.fill("input#user", "admin")` | Xóa nội dung cũ và điền giá trị mới. |
| **Nhấn nút** | `page.click("button.submit")` | Tự động chờ nút hiển thị và có thể nhấn được. |
| **Chọn giá trị** | `page.select_option("select#role", "Manager")` | Hỗ trợ chọn theo value, label hoặc index. |
| **Chụp ảnh lỗi** | `page.screenshot(path="fail.png")` | Nên kết hợp trong phần xử lý ngoại lệ (Exception). |

---

## 3. Mẹo tối ưu hóa mã nguồn (Best Practices)
Để duy trì một hệ thống tự động hóa bền vững, Tester cần tuân thủ các nguyên tắc thiết kế phần mềm. Nguyên tắc **DRY (Don't Repeat Yourself)** khuyến khích việc tái sử dụng các hàm tiện ích thay vì sao chép mã nguồn ở nhiều nơi. 

Ngoài ra, việc áp dụng **Explicit Wait** thay vì `time.sleep()` là bắt buộc để đảm bảo script chạy ổn định trên các môi trường có tốc độ xử lý khác nhau. Cuối cùng, hãy luôn sử dụng **Environment Variables** để quản lý các thông tin nhạy cảm như mật khẩu hoặc URL hệ thống, nhằm bảo mật dữ liệu và dễ dàng thay đổi cấu hình mà không cần sửa code.

---
> 💡 **AI Prompt Tip:** *"Viết một hàm Python sử dụng Playwright để tự động hóa việc đăng nhập và lấy giá trị Cookie sau khi thành công."*
