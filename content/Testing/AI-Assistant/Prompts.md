---
title: "✨ AI for"
description: "Sử dụng AI (ChatGPT, Claude, Manus) không chỉ để chat, mà để biến nó thành một \"Senior Tester\" trợ lý đắc lực cho côn..."
---

# 🤖 AI for Testing: The Ultimate Prompt Engineering Guide

Sử dụng AI (ChatGPT, Claude, Manus) không chỉ để chat, mà để biến nó thành một "Senior Tester" trợ lý đắc lực cho công việc hàng ngày.

## 1. Prompt tạo Test Case từ User Story
Thay vì ngồi viết từng dòng, hãy cung cấp ngữ cảnh cho AI để nó generate bộ test case bao phủ cả các case hiếm (edge cases).

**Prompt mẫu:**
> "Bạn là một Senior QA Engineer. Hãy dựa trên User Story sau: [Dán User Story]. Hãy viết bộ Test Case chi tiết theo định dạng bảng (ID, Title, Steps, Expected Result). Hãy đảm bảo bao gồm:
> 1. Positive cases (Luồng đúng).
> 2. Negative cases (Dữ liệu sai, lỗi hệ thống).
> 3. Boundary cases (Giá trị biên).
> 4. Security cases (XSS, SQL Injection cơ bản)."

---

## 2. Prompt Review Code Automation
Khi bạn viết script nhưng không chắc nó đã tối ưu hay chưa, hãy dùng AI để review.

**Prompt mẫu:**
> "Tôi có đoạn code Automation dùng [Playwright/Selenium] sau: [Dán Code]. Hãy review đoạn code này dựa trên các tiêu chí:
> 1. Đã áp dụng Page Object Model chưa?
> 2. Có bị hard-coded selector hay time.sleep không?
> 3. Cách xử lý ngoại lệ (Exception handling) đã ổn chưa?
> 4. Hãy đề xuất phiên bản code đã tối ưu."

---

## 3. Prompt Phân tích Log và Bug
Khi gặp một lỗi phức tạp với đống log dài dằng dặc, hãy để AI giúp bạn tìm ra nguyên nhân gốc rễ (Root Cause).

**Prompt mẫu:**
> "Tôi gặp lỗi [Mô tả lỗi] khi thực hiện [Hành động]. Đây là Console Log và API Response: [Dán Log]. Hãy phân tích:
> 1. Nguyên nhân gây lỗi là gì? (Phía Client hay Server?)
> 2. Lỗi này nằm ở đoạn code/logic nào?
> 3. Gợi ý các bước để Dev có thể sửa nhanh nhất."

---

## 4. Prompt Tạo dữ liệu kiểm thử (Test Data)
AI cực mạnh trong việc tạo ra các bộ dữ liệu giả lập có cấu trúc phức tạp.

**Prompt mẫu:**
> "Hãy tạo cho tôi danh sách 20 người dùng dưới dạng JSON. Mỗi đối tượng gồm: `id` (UUID), `name` (tiếng Việt), `email` (định dạng chuẩn), `age` (ngẫu nhiên 18-60), và `bio` (một câu trích dẫn ngắn). Hãy đảm bảo có 2 bản ghi bị trùng email để tôi test case validation."

---
> 🚀 **Elite Tip:** Hãy luôn bắt đầu bằng việc "Gán vai" cho AI (Vd: "Bạn là một chuyên gia bảo mật API...") để nhận được câu trả lời chuyên sâu nhất.
