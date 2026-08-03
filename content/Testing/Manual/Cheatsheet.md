---
title: "🚀 Manual Cheatsheet"
description: "Bộ quy tắc nhanh để áp dụng khi brainstorm test case."
---

# ⚡ Manual Testing: Quick Cheatsheet

Bộ quy tắc nhanh để áp dụng khi brainstorm test case.

## 1. Test Design Techniques
| Kỹ thuật | Cách áp dụng | Ví dụ |
| :--- | :--- | :--- |
| **BVA (Boundary)** | Test giá trị biên: `Min-1, Min, Min+1, Max-1, Max, Max+1` | Input 1-100: Test 0, 1, 2, 99, 100, 101 |
| **EP (Equivalence)** | Chia nhóm dữ liệu tương đương, chỉ test 1 giá trị đại diện | Tuổi 1-18: Test số 10 |
| **Decision Table** | Dùng cho logic có nhiều điều kiện kết hợp (AND/OR) | Login: User đúng + Pass sai -> Fail |
| **State Transition** | Vẽ luồng thay đổi trạng thái của Object | Draft -> Pending -> Approved -> Published |

## 2. Common Test Data (Edge Cases)
Luôn thử các giá trị này để "phá" hệ thống:
- **Strings:** Rỗng (`""`), chỉ có khoảng trắng (`"  "`), cực dài (1000+ ký tự), ký tự đặc biệt (`!@#$%^&*()`), Script (`<script>alert(1)</script>`).
- **Numbers:** Số 0, số âm, số cực lớn, số thập phân (nếu chỉ cho phép nguyên).
- **Files:** File rỗng, file quá dung lượng, file sai định dạng (vd: .exe thay vì .png).

## 3. Browser & Mobile Tips
- **Inspect Element (F12):** Check Network tab để xem lỗi API (4xx, 5xx).
- **Clear Cache:** `Ctrl + F5` để đảm bảo đang chạy code mới nhất.
- **Responsive:** Dùng Toggle Device Toolbar để test trên các kích thước màn hình khác nhau.

---
> 💡 **AI Prompt Tip:** *"Liệt kê 10 edge cases cho tính năng upload ảnh đại diện, bao gồm cả các lỗi bảo mật cơ bản."*
