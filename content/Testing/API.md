# 🌐 API Testing Pro Max: REST & GraphQL Mastery

Tài liệu chuyên sâu về kiểm thử API, từ lý thuyết đến thực thi với Postman và Python.

## 1. 📂 API Documentation Template
Dùng để ghi chú hoặc yêu cầu Dev cung cấp thông tin.

| Field | Description |
| :--- | :--- |
| **Endpoint** | `POST /api/v1/login` |
| **Auth** | Bearer Token |
| **Headers** | `Content-Type: application/json` |
| **Request Body** | `{"user": "...", "pass": "..."}` |
| **Success Response** | `200 OK` + `{"token": "..."}` |
| **Error Response** | `401 Unauthorized` + `{"error": "Invalid credentials"}` |

---

## 2. ⚡ HTTP Status Codes Cheatsheet
| Code | Meaning | Tester Note |
| :--- | :--- | :--- |
| **200** | OK | Success. |
| **201** | Created | Dùng cho POST khi tạo mới thành công. |
| **204** | No Content | Thường dùng cho DELETE/PUT thành công nhưng không trả về data. |
| **400** | Bad Request | Lỗi Client (thiếu field, sai định dạng). |
| **401** | Unauthorized | Thiếu hoặc sai Token/Auth. |
| **403** | Forbidden | Có Auth nhưng không có quyền truy cập tài nguyên này. |
| **404** | Not Found | Sai Endpoint hoặc ID không tồn tại. |
| **500** | Internal Server Error | Lỗi Code phía Server (Check log ngay!). |

---

## 3. 🐍 Python API Testing (Requests + Pytest)
Cách chuyên nghiệp nhất để automate API.

```python
import requests
import pytest

BASE_URL = "https://api.example.com"

@pytest.fixture
def auth_token():
    payload = {"username": "admin", "password": "123"}
    response = requests.post(f"{BASE_URL}/login", json=payload)
    return response.json()["token"]

def test_get_user_profile(auth_token):
    headers = {"Authorization": f"Bearer {auth_token}"}
    response = requests.get(f"{BASE_URL}/profile", headers=headers)
    
    assert response.status_code == 200
    assert "email" in response.json()
    assert response.elapsed.total_seconds() < 2.0  # Performance check
```

---

## 4. 🚀 Postman Pro Tips
- **Variables:** Sử dụng `{{base_url}}` cho các môi trường khác nhau (Dev, Staging, Prod).
- **Tests Tab:** Viết script kiểm tra tự động ngay trong Postman.
  ```javascript
  pm.test("Status code is 200", function () {
      pm.response.to.have.status(200);
  });
  pm.test("Response time is less than 500ms", function () {
      pm.expect(pm.response.responseTime).to.be.below(500);
  });
  ```
- **Pre-request Script:** Dùng để tạo data giả hoặc lấy token trước khi gọi API chính.
- **Collection Runner:** Chạy toàn bộ API trong folder để test luồng (E2E).

---

## 5. 🔍 API Security Testing Checklist
Đừng chỉ test chức năng, hãy test bảo mật:
- [ ] **IDOR:** Thay đổi ID trong URL (vd: `/user/123` -> `/user/124`) xem có xem được profile người khác không.
- [ ] **Rate Limiting:** Gọi API liên tục 100 lần xem có bị chặn (`429 Too Many Requests`) không.
- [ ] **SQL Injection:** Truyền `' OR 1=1` vào params.
- [ ] **Sensitive Data:** Kiểm tra xem response có trả về Password, Credit Card info không.
- [ ] **Method Not Allowed:** Thử dùng `GET` cho endpoint chỉ cho phép `POST`.

---
> 💡 **AI Prompt Tip:** *"Hãy đóng vai một API Tester chuyên nghiệp, viết các kịch bản kiểm thử API (gồm Positive và Negative cases) cho tài liệu sau: [Dán API Doc]"*
