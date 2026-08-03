# 🏗️ Advanced Automation: Patterns & Visual Testing

Khi dự án automation lớn dần, Page Object Model (POM) có thể trở nên cồng kềnh. Đây là lúc bạn cần áp dụng các kiến trúc nâng cao để giữ cho mã nguồn luôn sạch và dễ bảo trì.

## 1. Nguyên lý SOLID trong Automation
Áp dụng các nguyên lý lập trình hướng đối tượng vào việc viết script:
- **Single Responsibility:** Mỗi class Page chỉ nên quản lý các element và action của đúng trang đó.
- **Open/Closed:** Các hàm tiện ích nên được thiết kế để có thể mở rộng tính năng mà không cần sửa đổi mã nguồn cũ.
- **Dependency Inversion:** Sử dụng Interfaces hoặc Base Classes để giảm sự phụ thuộc cứng giữa các thành phần.

---

## 2. Screenplay Pattern: Sự thay thế cho POM
Screenplay tập trung vào **Actors** (Người dùng), **Tasks** (Hành động) và **Questions** (Xác minh). Nó giúp code đọc giống như ngôn ngữ tự nhiên và cực kỳ dễ tái sử dụng.

| Thành phần | Ý nghĩa | Ví dụ |
| :--- | :--- | :--- |
| **Actor** | Ai đang thực hiện test? | `User`, `Admin`, `Guest` |
| **Task** | Họ làm gì? | `Login`, `Checkout`, `SearchProduct` |
| **Ability** | Họ có khả năng gì? | `BrowseTheWeb`, `CallAPI` |
| **Question** | Họ kiểm tra điều gì? | `TheTitleOfThePage`, `TheStatusOfOrder` |

---

## 3. Automated Visual Testing (Pixel-Perfect)
UI Test thông thường chỉ kiểm tra chức năng (Functional). Visual Testing kiểm tra xem giao diện có bị "lệch" hay sai màu sắc không bằng cách so sánh ảnh chụp màn hình (Snapshot).

**Các công cụ hàng đầu:**
- **Applitools:** Sử dụng AI để so sánh ảnh, bỏ qua các thay đổi nhỏ không đáng kể.
- **Percy (by BrowserStack):** Tích hợp mượt mà vào CI/CD để review các thay đổi giao diện.
- **Playwright Screenshots:** Hỗ trợ so sánh ảnh cơ bản bằng lệnh `expect(page).toHaveScreenshot()`.

```python
def test_visual_comparison(page):
    page.goto("https://example.com")
    # So sánh ảnh hiện tại với ảnh mẫu (Baseline)
    expect(page).to_have_screenshot("homepage.png")
```

---

## 4. Custom Pytest Plugins & Decorators
Hãy tự tạo các **Decorators** để tự động log lỗi, chụp ảnh màn hình khi fail hoặc đo thời gian thực thi của từng hàm test. Việc làm chủ **conftest.py** và các **Hooks** của Pytest (như `pytest_runtest_makereport`) sẽ giúp bạn xây dựng được một framework "độc bản" và vô cùng mạnh mẽ.

---
> 💡 **AI Prompt Tip:** *"Giải thích sự khác biệt giữa Page Object Model và Screenplay Pattern thông qua một ví dụ cụ thể về luồng đặt hàng."*
