# 🤖 Automation Testing Hub

Mục này tập trung vào việc sử dụng công cụ và mã nguồn để tự động hóa quá trình kiểm thử, giúp tăng tốc độ và độ tin cậy của việc đảm bảo chất lượng phần mềm.

## 📂 Nội dung chi tiết

| Tài liệu | Mô tả | Điểm nhấn |
| :--- | :--- | :--- |
| **[Automation Theory](Theory.md)** | Nền tảng về tự động hóa. | Kim tự tháp kiểm thử, ROI, tiêu chí chọn test case để auto. |
| **[Frameworks Comparison](Frameworks.md)** | So sánh các công cụ phổ biến. | Playwright vs Selenium vs Cypress. |
| **[Automation Cheatsheet](Cheatsheet.md)** | Thư viện code snippets thực chiến. | Python, Playwright, Pytest commands. |

## 📅 Công việc hàng ngày của Automation Engineer

Việc duy trì hệ thống tự động hóa đòi hỏi sự tỉ mỉ và quy trình chặt chẽ. Dưới đây là các đầu việc quan trọng:

1.  **Kiểm tra báo cáo (Report Review):** Xem kết quả chạy tự động từ đêm qua hoặc từ CI/CD pipeline. Phân tích các case bị Fail để xác định đó là Bug thật hay là "Flaky Test" (test chạy không ổn định).
2.  **Bảo trì Script (Script Maintenance):** Cập nhật các đoạn mã kiểm thử khi giao diện (UI) hoặc logic ứng dụng thay đổi. Đặc biệt chú trọng vào việc tối ưu hóa các bộ chọn (Selectors/Locators).
3.  **Phát triển kịch bản mới (New Script Development):** Chuyển đổi các manual test case quan trọng thành script tự động sau khi tính năng đã ổn định.
4.  **Tối ưu hóa Pipeline:** Đảm bảo việc thực thi test trong CI/CD diễn ra nhanh chóng và cung cấp phản hồi kịp thời cho đội ngũ phát triển.

---
> 💡 **Mẹo:** Luôn áp dụng nguyên lý **[Advanced Patterns](../Advanced-Automation/Patterns-Visual.md)** như POM hoặc Screenplay để code dễ bảo trì hơn.
