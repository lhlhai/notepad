---
title: "🎯 Testing Infrastructure"
description: "Trong kỷ nguyên Cloud-native, một Tester \"Super\" phải biết cách làm chủ môi trường kiểm thử thông qua Docker để đảm b..."
---

# 🐳 Testing Infrastructure: Docker for QA Engineers

Trong kỷ nguyên Cloud-native, một Tester "Super" phải biết cách làm chủ môi trường kiểm thử thông qua Docker để đảm bảo tính nhất quán và khả năng mở rộng.

## 1. Tại sao Tester cần Docker?
Docker giải quyết bài toán "It works on my machine" bằng cách đóng gói toàn bộ ứng dụng và phụ thuộc vào trong một Container. Đối với Tester, Docker giúp:
- **Tạo môi trường sạch:** Mỗi lần chạy test là một môi trường hoàn toàn mới, không bị ảnh hưởng bởi dữ liệu cũ.
- **Chạy song song:** Dễ dàng nhân bản các trình duyệt (Selenium Grid) hoặc các Mock Service.
- **Tích hợp CI/CD:** Pipeline chạy mượt mà trên bất kỳ server nào có Docker.

---

## 2. Docker Compose cho Testing Environment
Dưới đây là file `docker-compose.yml` mẫu để dựng nhanh một môi trường gồm Web App, Database và Mock API.

```yaml
version: '3.8'
services:
  web-app:
    image: my-app:latest
    ports:
      - "8080:80"
    depends_on:
      - db
  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: password
  mock-api:
    image: stoplight/prism:4
    command: mock -h 0.0.0.0 /data/api-spec.yaml
    volumes:
      - ./specs:/data
    ports:
      - "4010:4010"
```

---

## 3. Sử dụng Mocking Services chuyên sâu
Khi API thật chưa xong hoặc tốn phí khi gọi (ví dụ: SMS Gateway, Payment), hãy dùng Mocking.
- **Prism:** Mock API cực nhanh từ file OpenAPI (Swagger).
- **WireMock:** Cho phép giả lập các kịch bản lỗi mạng, độ trễ cao hoặc trả về mã lỗi 5xx để test khả năng chịu lỗi của Client.

**Lệnh chạy Prism nhanh:**
```bash
docker run --init -it -p 4010:4010 -v $(pwd):/tmp stoplight/prism:4 mock -h 0.0.0.0 /tmp/api.oas3.yaml
```

---

## 4. Mẹo tối ưu hạ tầng kiểm thử
Luôn sử dụng **Docker Volumes** để lưu trữ log và kết quả test ra ngoài container, giúp bạn có thể phân tích sau khi container đã bị xóa. Ngoài ra, hãy tìm hiểu về **Multi-stage builds** để tạo ra các Docker Image siêu nhẹ chỉ chứa mã nguồn test và các thư viện cần thiết, giúp tăng tốc độ kéo image trong pipeline CI/CD.

---
> 💡 **AI Prompt Tip:** *"Viết một file docker-compose.yml để thiết lập Selenium Grid với 1 Hub, 2 Node Chrome và 2 Node Firefox."*
