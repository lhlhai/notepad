---
title: "🍀 Automation Theory"
description: "Kiến thức chiến lược để xây dựng hệ thống tự động hóa hiệu quả."
---

# 📖 Automation Testing: Strategic Theory

Kiến thức chiến lược để xây dựng hệ thống tự động hóa hiệu quả.

## 1. Test Automation Pyramid
Mô hình kim tự tháp giúp tối ưu chi phí và thời gian:
- **Unit Tests (Base):** Nhiều nhất, nhanh nhất, rẻ nhất.
- **API/Service Tests (Middle):** Kiểm tra logic nghiệp vụ mà không cần UI.
- **UI Tests (Top):** Ít nhất, chậm nhất, dễ hỏng (brittle) nhất.

## 2. Khi nào nên Automate?
Áp dụng quy tắc **ROI (Return on Investment)**:
- Test case chạy lặp lại nhiều lần (Regression).
- Các luồng nghiệp vụ quan trọng (Critical Paths).
- Các case yêu cầu dữ liệu lớn hoặc tính toán phức tạp.
- Test trên nhiều trình duyệt/thiết bị đồng thời.

## 3. Các loại Framework phổ biến
- **Data-Driven:** Tách data ra khỏi code (Excel, JSON).
- **Keyword-Driven:** Dùng từ khóa (click, input) để viết test.
- **BDD (Behavior Driven Development):** Viết test bằng ngôn ngữ tự nhiên (Given-When-Then).
- **Hybrid:** Kết hợp các loại trên.

---
> 💡 **AI Prompt Tip:** *"Giải thích tại sao chúng ta nên tập trung nhiều vào API Testing hơn là UI Testing trong một dự án CI/CD."*
