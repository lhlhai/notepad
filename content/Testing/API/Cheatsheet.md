# ⚡ API Testing: Reference Cheatsheet

Tài liệu tra cứu nhanh các mã trạng thái, công cụ và đoạn mã mẫu để thực hiện kiểm thử API một cách hiệu quả và chuyên nghiệp.

## 1. Bảng tra cứu mã trạng thái HTTP (Status Codes)
Mã trạng thái là dấu hiệu đầu tiên để Tester xác định kết quả của một yêu cầu API. Việc nắm vững các nhóm mã giúp phân loại lỗi nhanh chóng.

| Nhóm mã | Ý nghĩa tổng quát | Ví dụ phổ biến |
| :--- | :--- | :--- |
| **2xx (Success)** | Yêu cầu đã được xử lý thành công. | `200 OK`, `201 Created`, `204 No Content` |
| **3xx (Redirection)** | Cần thực hiện thêm hành động để hoàn tất. | `301 Moved Permanently`, `304 Not Modified` |
| **4xx (Client Error)** | Lỗi từ phía người gửi yêu cầu. | `400 Bad Request`, `401 Unauthorized`, `404 Not Found` |
| **5xx (Server Error)** | Máy chủ gặp lỗi khi xử lý yêu cầu. | `500 Internal Server Error`, `503 Service Unavailable` |

---

## 2. Kiểm thử API với Python (Requests Library)
Thư viện `requests` là công cụ phổ biến nhất trong hệ sinh thái Python để tương tác với các dịch vụ web. Dưới đây là cách triển khai một kịch bản kiểm thử cơ bản nhưng đầy đủ.

```python
import requests

def test_user_api():
    base_url = "https://api.example.com/v1"
    headers = {"Authorization": "Bearer YOUR_TOKEN"}
    
    # Thực hiện yêu cầu GET
    response = requests.get(f"{base_url}/users/1", headers=headers)
    
    # Kiểm tra mã trạng thái
    assert response.status_code == 200
    
    # Kiểm tra dữ liệu phản hồi
    data = response.json()
    assert data["id"] == 1
    assert "email" in data
    
    # Kiểm tra thời gian phản hồi (Performance)
    assert response.elapsed.total_seconds() < 1.0
```

---

## 3. Postman Scripting Tips
Postman không chỉ là công cụ gửi yêu cầu mà còn hỗ trợ viết kịch bản kiểm thử tự động mạnh mẽ thông qua tab **Tests**.

### Các đoạn mã kiểm tra thông dụng
Việc sử dụng các đoạn mã kiểm tra giúp tự động hóa quá trình xác minh phản hồi ngay sau khi nhận được dữ liệu từ máy chủ.

- **Kiểm tra Status Code:** `pm.response.to.have.status(200);`
- **Kiểm tra giá trị JSON:** `pm.expect(pm.response.json().name).to.eql("John");`
- **Kiểm tra Header:** `pm.response.to.have.header("Content-Type");`
- **Lưu biến môi trường:** `pm.environment.set("user_id", pm.response.json().id);`

---

## 4. Công cụ hỗ trợ API Testing
Ngoài Postman và Python, Tester nên làm quen với các công cụ khác để phục vụ các mục đích chuyên biệt. **Insomnia** là một lựa chọn thay thế gọn nhẹ cho Postman. **JMeter** hoặc **K6** được ưu tiên khi cần kiểm thử hiệu năng và khả năng chịu tải của API. Đối với các dự án sử dụng GraphQL, **Apollo Studio** cung cấp môi trường khám phá schema và truy vấn mạnh mẽ.

---
> 💡 **AI Prompt Tip:** *"Viết một đoạn script Postman để kiểm tra xem tất cả các phần tử trong một mảng phản hồi có chứa trường 'id' và 'status' hay không."*
