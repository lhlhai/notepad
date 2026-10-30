---
title: "🧪 Generate Bruno API Tests from FastAPI with GitHub Copilot"
description: "Hướng dẫn cài đặt Bruno Agent Skills và dùng GitHub Copilot (Agent mode) để tự động sinh bộ sưu tập và test API cho ứng dụng FastAPI, sau đó chạy bằng Bruno CLI."
---

# 🧪 Generate Bruno API Tests from FastAPI Using GitHub Copilot

Kết hợp GitHub Copilot Agent mode với **Bruno Agent Skills** để tự động phân tích một ứng dụng FastAPI và sinh ra bộ sưu tập Bruno kèm các test API tự động, sau đó thực thi bằng Bruno CLI.

## 1. Prerequisites (Yêu cầu chuẩn bị)

- Một ứng dụng FastAPI đang chạy tại `http://localhost:8000`.
- GitHub Copilot đã được bật trong VS Code với **Agent mode**.
- Bruno Agent Skills:
  - `bruno-collection-generator`
  - `bruno-test-writer`
- Bruno CLI đã được cài đặt để thực thi API tests.

## 2. Install Agent Skills (Cài đặt Agent Skills)

Mở terminal tại thư mục gốc của project FastAPI và clone repository chứa skills:

```powershell
git clone https://github.com/bruno-collections/bruno-agent-skills.git .tmp-bruno-skills
```

Tạo thư mục skills và copy hai skill cần thiết:

```powershell
New-Item -ItemType Directory -Force .github/skills

Copy-Item -Recurse .tmp-bruno-skills/bruno-collection-generator .github/skills/

Copy-Item -Recurse .tmp-bruno-skills/bruno-test-writer .github/skills/
```

Kiểm tra rằng cả hai thư mục skill đều chứa file `SKILL.md`. Giữ lại các file hỗ trợ đi kèm với skills.

Sau khi kiểm tra xong, xóa bản clone tạm:

```powershell
Remove-Item -Recurse -Force .tmp-bruno-skills
```

Đảm bảo phiên bản VS Code của bạn hỗ trợ Agent Skills và nhận diện được các skill trong `.github/skills/`.

## 3. Generate Bruno API Tests (Sinh test Bruno)

Mở GitHub Copilot Chat ở chế độ Agent mode và gửi prompt sau:

---

I have a FastAPI application running at `http://localhost:8000`.

Use the following Agent Skills:
- `bruno-collection-generator`
- `bruno-test-writer`

Requirements:

1. Inspect the FastAPI source code and identify registered endpoints, HTTP methods, parameters, request bodies, response schemas, authentication requirements, and error responses.
2. Check `http://localhost:8000/openapi.json` if available and use it alongside the source code.
3. Generate a Bruno collection and automated API tests under `./bruno`.
4. Configure the base URL using an environment variable, defaulting to `http://localhost:8000`.
5. Create meaningful assertions for HTTP status codes, response fields, data types, successful responses, and relevant error cases.
6. Use realistic test data based on the actual API implementation. Do not invent endpoints or response fields.
7. Handle authentication and request chaining where necessary. Never hardcode real credentials or tokens.
8. Do not modify application source code or files outside `./bruno`.
9. Before creating files, present the discovered endpoints, proposed folder structure, planned test cases, and any assumptions or missing information.
10. Wait for my approval before creating or modifying files.
11. After approval, generate the collection and tests, validate the files, and provide commands to execute the tests.

Do not create or modify any files before receiving my approval.

---

## 4. Verify Skill Recognition (Xác minh Copilot nhận diện skill)

Trước khi sinh test, hãy hỏi Copilot:

```text
Inspect these files:
- .github/skills/bruno-collection-generator/SKILL.md
- .github/skills/bruno-test-writer/SKILL.md

Explain how you will use each skill to generate tests for my FastAPI application.

Do not create or modify any files.
```

Xác nhận rằng Copilot truy cập được cả hai skill trước khi tiếp tục.

## 5. Execute the Tests (Chạy test)

1. Kiểm tra FastAPI đang chạy bằng cách mở `http://localhost:8000/docs`.
2. Cài đặt Bruno CLI nếu chưa có.
3. Chạy bộ sưu tập Bruno đã được sinh ra bằng lệnh Bruno CLI phù hợp, ví dụ:

```powershell
bru run ./bruno
```

4. Xem kết quả test và yêu cầu Copilot sửa các test bị fail nếu cần.

> ⚠️ **Important:** Hãy đối chiếu định dạng collection và cú pháp CLI với phiên bản Bruno đã cài đặt. Đảm bảo base URL đã cấu hình có thể truy cập được từ môi trường chạy test.

---

## 💡 Tips & Lưu ý

- **Không tin tưởng mù quáng output của AI**: luôn đối chiếu endpoint/schema sinh ra với `openapi.json` thực tế của ứng dụng.
- **Chạy test trong CI**: sau khi collection ổn định, có thể đưa `bru run ./bruno` vào pipeline để regression test tự động.
- **Tách environment**: dùng biến môi trường cho base URL (`{{base_url}}`) để chạy cùng bộ test trên nhiều môi trường (dev/staging).
- Liên quan: xem thêm [Prompts Collection](Prompts.md) và [API Cheatsheet](../API/Cheatsheet.md).
