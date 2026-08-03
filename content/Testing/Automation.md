# 🤖 Automation Testing Pro Max: Framework & Snippets

Tập trung vào các đoạn code thực dụng (Snippets) và cấu trúc Framework hiện đại để tích hợp vào workflow hàng ngày.

## 1. 🏗️ Standard Framework Structure (Python/Pytest)
Cấu trúc thư mục chuẩn cho dự án Automation bền vững:

```text
project-root/
├── tests/                # Chứa các file test case
│   ├── conftest.py       # Fixtures dùng chung
│   └── test_login.py
├── pages/                # Page Object Model (POM)
│   ├── base_page.py
│   └── login_page.py
├── data/                 # Test data (JSON, CSV, Excel)
│   └── users.json
├── utils/                # Helper functions (DB, Log, Report)
├── reports/              # Allure/HTML reports
├── pytest.ini            # Cấu hình pytest
└── requirements.txt
```

---

## 2. 🚀 Playwright Python Snippets (Modern & Fast)
Playwright đang dần thay thế Selenium nhờ tốc độ và tính ổn định.

### Khởi tạo cơ bản
```python
from playwright.sync_api import sync_playwright

def test_example():
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=False)
        page = browser.new_page()
        page.goto("https://example.com")
        print(page.title())
        browser.close()
```

### Xử lý Wait & Selectors
```python
# Chờ element hiển thị và click
page.locator("button#submit").click()

# Lấy text và verify
assert page.locator(".welcome-msg").inner_text() == "Welcome!"

# Xử lý Dropdown
page.select_option("select#country", label="Vietnam")

# Screenshot khi fail
page.screenshot(path="screenshot.png", full_page=True)
```

---

## 3. 🐍 Pytest Cheatsheet
Các lệnh thường dùng để chạy test linh hoạt:

| Lệnh | Ý nghĩa |
| :--- | :--- |
| `pytest` | Chạy toàn bộ test. |
| `pytest tests/test_login.py` | Chạy cụ thể 1 file. |
| `pytest -k "login"` | Chạy các test có tên chứa "login". |
| `pytest -m "smoke"` | Chạy các test được mark là @pytest.mark.smoke. |
| `pytest -n 4` | Chạy song song trên 4 CPU (cần pytest-xdist). |
| `pytest --html=report.html` | Xuất báo cáo HTML đơn giản. |

---

## 4. 🛠️ Automation Tips & Tricks
- **Page Object Model (POM):** Tuyệt đối không hard-code selector trong file test. Hãy để chúng ở file Page.
- **Environment Variables:** Sử dụng thư viện `python-dotenv` để quản lý `BASE_URL`, `USERNAME`, `PASSWORD`. Tránh đẩy pass lên GitHub.
- **Auto-wait:** Playwright/Cypress có cơ chế tự động chờ element sẵn sàng. Hạn chế dùng `time.sleep()`.
- **CI/CD Integration:** Luôn chạy automation trong pipeline (GitHub Actions, Jenkins) để phát hiện lỗi sớm.

---

## 5. 🧩 GitHub Actions Workflow Template
Tự động chạy test khi push code:
```yaml
name: UI Automation Tests
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      - name: Install dependencies
        run: pip install -r requirements.txt
      - name: Install Playwright Browsers
        run: playwright install --with-deps
      - name: Run Tests
        run: pytest --alluredir=allure-results
```
