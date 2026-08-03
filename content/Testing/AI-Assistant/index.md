---
title: "🤖 AI Assistant"
description: "Tổng hợp các prompts và hướng dẫn sử dụng AI Assistant hiệu quả cho QA/Testing."
---

# 🤖 AI Assistant for Testing

Chào mừng bạn đến với thư mục AI Assistant - nơi chứa các tài nguyên và prompts giúp bạn tận dụng sức mạnh của AI trong công việc kiểm thử phần mềm.

## 📂 Nội dung chính

### [📝 Prompts Collection](./Prompts.md)
Bộ sưu tập các prompts được tối ưu hóa cho các tác vụ QA/Testing:
*   **Test Case Generation**: Tạo test cases từ user stories, requirements
*   **Bug Analysis**: Phân tích root cause, viết bug reports
*   **Code Review**: Review automation code, test scripts
*   **Test Data Generation**: Tạo dữ liệu test đa dạng
*   **API Testing**: Tạo test scenarios cho API testing
*   **Documentation**: Viết documentation, test plans

## 💡 Cách sử dụng AI hiệu quả

### 1. Viết Prompt rõ ràng
```
❌ Không tốt: "Viết test case cho login"
✅ Tốt hơn: "Viết 5 test cases cho chức năng login với valid/invalid credentials, bao gồm edge cases như SQL injection, empty fields, max length validation"
```

### 2. Cung cấp ngữ cảnh
```
❌ Không tốt: "Tìm bug trong code này"
✅ Tốt hơn: "Đây là function validateEmail() trong React app. Hãy phân tích các edge cases có thể bị miss và gợi ý test scenarios"
```

### 3. Yêu cầu format cụ thể
```
"Hãy output dưới dạng bảng với columns: Test ID, Description, Steps, Expected Result, Priority"
```

## 🎯 Use Cases phổ biến

| Task | Prompt Template | Kết quả mong đợi |
|------|----------------|------------------|
| **Tạo Test Cases** | "Từ requirement sau, tạo test cases: [dán requirement]" | Danh sách test cases đầy đủ |
| **Phân tích Bug** | "Phân tích root cause cho bug: [mô tả bug]" | Các possible causes & solutions |
| **Review Code** | "Review automation script sau: [dán code]" | Feedback về best practices, bugs tiềm ẩn |
| **Tạo Data** | "Tạo 10 test data records với fields: name, email, phone" | Dataset sẵn sàng sử dụng |

## ⚠️ Lưu ý quan trọng

1. **Verify kết quả**: AI có thể hallucinate - luôn verify lại output
2. **Bảo mật**: Không paste sensitive data (passwords, API keys, customer info)
3. **Context matters**: Càng cung cấp nhiều context, kết quả càng chính xác
4. **Iterate**: Nếu kết quả chưa tốt, refine prompt và try again

## 🔗 Tài nguyên bổ sung

*   [Interactive Toolbox](../Tools-Resources/Interactive-Toolbox.md) - Công cụ tạo UUID, Password, Base64...
*   [Data Faker](../Tools-Resources/Data-Faker.md) - Tạo fake data hàng loạt
*   [Bug Report Generator](../Tools-Resources/Bug-Report-Generator.md) - Form tạo bug report chuẩn

---

> 🚀 **Pro Tip**: Sử dụng AI như một "pair tester" - hãy yêu cầu nó challenge assumptions của bạn và suggest edge cases mà bạn có thể đã bỏ qua!
