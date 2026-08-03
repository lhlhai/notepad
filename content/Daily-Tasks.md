# 📅 Daily Tasks: Lộ trình làm việc hiệu quả cho Tester

Trang này tổng hợp các quy trình và công việc quan trọng nhất mà một Tester/QA cần thực hiện hàng ngày để đảm bảo chất lượng dự án và tối ưu hóa năng suất.

## 🌅 Quy trình bắt đầu ngày mới (Morning Routine)
- [ ] **Kiểm tra thông báo:** Xem Email, Slack/Teams, Jira để nắm bắt các thay đổi mới nhất về yêu cầu hoặc các bug được gán lại.
- [ ] **Kiểm tra Build mới:** Xác nhận xem có version mới nào được deploy lên môi trường Test (Staging/UAT) hay không.
- [ ] **Họp Daily Standup:** Chuẩn bị báo cáo 3 câu hỏi:
    - Hôm qua tôi đã làm gì?
    - Hôm nay tôi sẽ làm gì?
    - Tôi có gặp khó khăn (blocker) gì không?

## 🚀 Thực thi kiểm thử (Execution Flow)

### 1. Kiểm tra nhanh (Smoke/Sanity Test)
Dành 15-30 phút đầu tiên sau khi có build mới để kiểm tra các tính năng cốt lõi. Nếu Smoke Test fail, hãy trả lại build ngay lập tức để tiết kiệm thời gian.
> 🔗 Xem thêm: [Smoke Test Checklist](Testing/Manual/Cheatsheet.md#smoke-test)

### 2. Kiểm thử tính năng mới (New Feature Testing)
Dựa trên Sprint backlog, thực hiện test các User Story đã hoàn thiện.
- Đọc kỹ Requirement/Acceptance Criteria.
- Thực hiện các Test Case đã viết.
- Thực hiện Exploratory Testing để tìm các case ngoại lệ.

### 3. Kiểm thử hồi quy (Regression Testing)
Đảm bảo các thay đổi mới không làm hỏng các tính năng cũ.
- Ưu tiên chạy các script **Automation** đã có.
- Chạy manual các phần nhạy cảm mà automation chưa phủ tới.

## 🐛 Quản lý lỗi (Bug Management)
- **Log Bug:** Khi phát hiện lỗi, log ngay vào hệ thống (Jira/GitHub) với đầy đủ bằng chứng.
    - 🔗 Mẫu chuẩn: [Bug Report Template](Testing/Manual/Templates.md#2-bug-report-template)
- **Verify Bug:** Kiểm tra lại các bug mà Developer đã đánh dấu là "Fixed".
- **Bug Triage:** Tham gia họp xem xét độ ưu tiên của các bug mới phát hiện.

## 📊 Báo cáo & Kết thúc ngày (End of Day)
- **Cập nhật trạng thái:** Đảm bảo tất cả Test Case trên công cụ quản lý (TestRail/Zephyr) đã được cập nhật kết quả.
- **Báo cáo tiến độ:** Gửi tóm tắt công việc cho Lead hoặc Team.
    - 🔗 Mẫu báo cáo: [Test Summary Report](Testing/Manual/Templates.md#3-test-summary-report-tsr)
- **Chuẩn bị cho ngày mai:** Ghi chú lại các phần đang làm dở để bắt nhịp nhanh vào sáng hôm sau.

---

## 🛠️ Công cụ hỗ trợ nhanh (Quick Snippets)

| Tình huống | Hành động nhanh |
| :--- | :--- |
| **Cần Fake Data** | Sử dụng [Mockaroo](https://www.mockaroo.com/) hoặc script [Python Faker](Development/Python-Testing.md) |
| **Check API nhanh** | Mở DevTools (F12) -> Network tab hoặc dùng [Postman/Insomnia](Testing/API/Cheatsheet.md) |
| **Chụp màn hình/Quay video** | Dùng **ShareX** (Windows) hoặc **CleanShot X** (Mac) |
| **Regex cho Search** | Tham khảo [VSCode Regex Cheatsheet](DevOps/VSCode-Regex.md) |

---
> 💡 **AI Prompt cho Daily Task:** *"Hôm nay tôi cần test tính năng [Tên tính năng]. Dựa trên yêu cầu sau [Dán yêu cầu], hãy liệt kê 5 trường hợp kiểm thử (test cases) quan trọng nhất và 3 trường hợp biên (edge cases) tôi không nên bỏ qua."*
