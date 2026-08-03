---
title: 🛠️ Tools & Resources
description: Tổng hợp các công cụ, tiện ích và tài nguyên hữu ích dành cho QA/Tester để tối ưu hóa quy trình làm việc.
---

# 🛠️ Tools & Resources

Chào mừng bạn đến với kho lưu trữ công cụ và tài nguyên dành cho QA. Mục này được thiết kế để giúp bạn tìm kiếm nhanh các công cụ hỗ trợ kiểm thử, từ các tiện ích mở rộng trình duyệt đến các bộ công cụ tương tác trực tiếp.

> 🔒 **Lưu ý quan trọng:** Tất cả công cụ tương tác bên dưới đều chạy **100% local trên trình duyệt** — không gửi dữ liệu ra server bên ngoài, đảm bảo an toàn cho thông tin nhạy cảm như JWT, API keys, logs.

## 📂 Danh mục chính

### 1. [✨ Interactive Toolbox](./Interactive-Toolbox.md)
Bộ công cụ chạy trực tiếp trên trình duyệt. Không cần cài đặt, không cần chuyển tab. Hỗ trợ các tác vụ nhanh như:
*   Tạo UUID, Mật khẩu ngẫu nhiên.
*   Mã hóa/Giải mã Base64, URL.
*   Giải mã JWT Payload.
*   Định dạng JSON, Kiểm tra Regex.

### 2. [🧰 The Ultimate Toolbox](./Toolbox.md)
Danh sách chọn lọc các công cụ "phải có" trong túi đồ của một Tester chuyên nghiệp:
*   **Browser Extensions**: SelectorHub, Fake Filler, JSON Viewer...
*   **Desktop Apps**: Charles Proxy, DBeaver, Postman...
*   **Online Resources**: Các trang web học tập và cộng đồng QA lớn trên thế giới.

### 3. Công cụ tương tác nâng cao — Xử lý dữ liệu & Log
Các công cụ mạnh mẽ, giúp xử lý dữ liệu và log phức tạp trực tiếp trên trình duyệt.

| Công cụ | Mô tả | Khi nào dùng? |
| :--- | :--- | :--- |
| **[📊 CSV Viewer & Editor](./CSV-Viewer.md)** | Xem, phân tích và chỉnh sửa dữ liệu CSV một cách trực quan. | Khi cần xem nhanh dữ liệu CSV từ export database hoặc test data. |
| **[↔️ CSV Compare](./CSV-Compare.md)** | So sánh hai bộ dữ liệu CSV để tìm ra sự khác biệt. | Khi verify data migration, so sánh trước/sau deploy. |
| **[📜 Log Tracer](./Log-Tracer.md)** | Phân tích log, highlight lỗi và lọc theo từ khóa để debug hiệu quả. | Khi cần tìm nhanh error trong log files dài. |

### 4. Công cụ tương tác — Phân tích & So sánh Code
Các công cụ chuyên sâu cho việc phân tích API response, so sánh code, và format SQL.

| Công cụ | Mô tả | Khi nào dùng? |
| :--- | :--- | :--- |
| **[🔀 JSON Diff](./JSON-Diff.md)** | So sánh hai JSON object, highlight sự khác biệt về cấu trúc và giá trị. | Khi compare API response trước/sau deploy, hoặc verify data changes. |
| **[🔍 API Response Inspector](./API-Response-Inspector.md)** | Phân tích cấu trúc JSON response — đếm fields, kiểm tra kiểu dữ liệu, tìm null values. | Khi debug API testing, kiểm tra response structure có đúng spec không. |
| **[💾 SQL Formatter](./SQL-Formatter.md)** | Format và beautify SQL queries rối thành code sạch, dễ đọc. | Khi nhận SQL từ logs, developer gửi cho, hoặc cần review queries. |
| **[📝 Text Diff Compare](./Text-Diff.md)** | So sánh hai đoạn văn bản, highlight những dòng thêm, xóa, thay đổi. | Khi compare config files, output logs, hoặc nội dung trang web. |

### 5. Công cụ tương tác — Viết Test Cases & Bug Reports
Công cụ giúp tạo nhanh Bug Reports và Test Cases chuẩn template, tiết kiệm thời gian viết documentation.

| Công cụ | Mô tả | Khi nào dùng? |
| :--- | :--- | :--- |
| **[🐛 Bug Report Generator](./Bug-Report-Generator.md)** | Form tạo Bug Report chuẩn template (Standard, Jira, GitHub Issues, Minimal). | Khi cần log bug nhanh với format chuẩn, copy-paste vào Jira/GitHub. |
| **[✅ Test Case Generator](./Test-Case-Generator.md)** | Form tạo Test Case chuẩn, auto-generate ID, hỗ trợ batch export. | Khi cần tạo nhanh nhiều test cases liên tiếp cho sprint. |

### 6. Công cụ tương tác — Data & Accessibility Testing
Công cụ tạo test data và kiểm tra accessibility trực tiếp trên trình duyệt.

| Công cụ | Mô tả | Khi nào dùng? |
| :--- | :--- | :--- |
| **[🎲 Data Faker](./Data-Faker.md)** | Tạo dữ liệu giả (names, emails, phones, UUIDs...) với nhiều loại field, export CSV/JSON. | Khi cần prepare test data cho form filling, database seeding. |
| **[🎨 Contrast Checker](./Contrast-Checker.md)** | Kiểm tra độ tương phản màu sắc, đảm bảo đạt chuẩn WCAG AA/AAA. | Khi review UI/UX, verify accessibility compliance. |
| **[📡 HTTP Request Builder](./HTTP-Request-Builder.md)** | Gửi HTTP requests (GET/POST/PUT/DELETE) trực tiếp từ browser, xem response nhanh. | Khi cần quick API testing mà không cần mở Postman. |
| **[🎯 Regex Builder](./Regex-Builder.md)** | Test regex với 12+ templates sẵn có (Email, Phone, Password, URL...). | Khi test validation fields hoặc viết regex cho automation. |

---

## 🗺️ Sơ đồ lựa chọn công cụ

Chọn công cụ phù hợp dựa trên tình huống làm việc hàng ngày:

```
🌅 Bắt đầu ngày
├── Cần fake data cho testing? ──────────→ 🎲 Data Faker
├── Cần viết test cases? ────────────────→ ✅ Test Case Generator
└── Cần log bug? ────────────────────────→ 🐛 Bug Report Generator

🚀 Trong quá trình test
├── Cần gửi API request nhanh? ──────────→ 📡 HTTP Request Builder
├── Cần check accessibility? ────────────→ 🎨 Contrast Checker
├── Cần test validation regex? ──────────→ 🎯 Regex Builder
└── Cần format SQL từ log? ──────────────→ 💾 SQL Formatter

🔍 Phân tích & Debug
├── Cần phân tích API response? ─────────→ 🔍 API Response Inspector
├── Cần compare 2 JSON? ─────────────────→ 🔀 JSON Diff
├── Cần compare 2 text files? ───────────→ 📝 Text Diff Compare
├── Cần compare 2 CSV files? ────────────→ ↔️ CSV Compare
├── Cần xem CSV data? ───────────────────→ 📊 CSV Viewer
└── Cần tìm lỗi trong log? ──────────────→ 📜 Log Tracer
```

---

> 💡 **Mẹo:** Bạn có thể sử dụng thanh tìm kiếm (Ctrl+K) để truy cập nhanh vào bất kỳ công cụ nào trong danh sách này.

> 🚀 **Pro Tip:** Bookmark trang này làm trang chủ hàng ngày — tất cả công cụ bạn cần đều ở đây, chạy 100% offline, không cần cài đặt thêm gì cả.
