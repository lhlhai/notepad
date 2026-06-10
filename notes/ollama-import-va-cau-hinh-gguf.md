# Install GGUF Model vào Ollama

## Bước 1: Chuẩn bị file GGUF

Ví dụ:

```text
D:\models\qwen3-8b.gguf
```

Kiểm tra file tồn tại:

```bash
dir D:\models\qwen3-8b.gguf
```

---

## Bước 2: Tạo Modelfile cơ bản

Tạo file tên:

```text
Modelfile
```

Nội dung:

```text
FROM D:\models\qwen3-8b.gguf
```

---

## Bước 3: Import model vào Ollama

```bash
ollama create qwen3-8b-local -f Modelfile
```

---

## Bước 4: Kiểm tra model

```bash
ollama list
```

---

## Bước 5: Chạy model

```bash
ollama run qwen3-8b-local
```

---

# Cấu hình nâng cao bằng Modelfile

Bạn có thể chỉnh các tham số mặc định của model ngay trong `Modelfile`.

Ví dụ:

```text
FROM D:\models\qwen3-8b.gguf

PARAMETER num_ctx 32768
PARAMETER temperature 0.7
PARAMETER top_p 0.9
PARAMETER top_k 40
PARAMETER repeat_penalty 1.1
PARAMETER num_predict 2048

SYSTEM """
You are a helpful AI assistant.
"""
```

Sau đó import lại:

```bash
ollama create qwen3-8b-custom -f Modelfile
```

---

## Các tham số thường dùng

### Context Window

Số token model nhớ được trong cuộc hội thoại.

```text
PARAMETER num_ctx 8192
```

Hoặc:

```text
PARAMETER num_ctx 16384
```

Hoặc:

```text
PARAMETER num_ctx 32768
```

Lưu ý:

- Giá trị càng lớn càng tốn RAM.
- Không phải GGUF nào cũng hỗ trợ context lớn.

---

### Temperature

Điều chỉnh độ sáng tạo.

```text
PARAMETER temperature 0
```

Kết quả ổn định, phù hợp code.

```text
PARAMETER temperature 0.3
```

Ít sáng tạo.

```text
PARAMETER temperature 0.7
```

Cân bằng.

```text
PARAMETER temperature 1.0
```

Sáng tạo hơn.

---

### Top P

Giới hạn phạm vi token được chọn.

```text
PARAMETER top_p 0.9
```

Thông dụng nhất.

```text
PARAMETER top_p 0.95
```

Sáng tạo hơn.

---

### Top K

Giới hạn số token ứng viên.

```text
PARAMETER top_k 40
```

Giá trị phổ biến.

```text
PARAMETER top_k 20
```

Ổn định hơn.

```text
PARAMETER top_k 100
```

Đa dạng hơn.

---

### Repeat Penalty

Giảm lặp từ.

```text
PARAMETER repeat_penalty 1.1
```

Khuyến nghị.

```text
PARAMETER repeat_penalty 1.2
```

Giảm lặp mạnh hơn.

---

### Num Predict

Giới hạn số token sinh ra.

```text
PARAMETER num_predict 1024
```

Hoặc:

```text
PARAMETER num_predict 2048
```

Không giới hạn:

```text
PARAMETER num_predict -1
```

---

## Stop Sequences

Dừng sinh khi gặp chuỗi chỉ định.

```text
PARAMETER stop "<|im_end|>"
```

Hoặc nhiều chuỗi:

```text
PARAMETER stop "<|im_end|>"
PARAMETER stop "<|eot_id|>"
```

---

## Template Chat

Một số model cần template riêng.

Ví dụ:

```text
FROM D:\models\qwen3-8b.gguf

TEMPLATE """
{{ .System }}

User: {{ .Prompt }}
Assistant:
"""
```

Thông thường không cần nếu GGUF đã chứa chat template.

---

## System Prompt mặc định

```text
FROM D:\models\qwen3-8b.gguf

SYSTEM """
You are an expert software engineer.
Answer in Vietnamese.
"""
```

Mọi cuộc chat sẽ tự động dùng prompt này.

---

# Chạy với tham số tạm thời

Không cần sửa Modelfile.

Ví dụ:

```bash
ollama run qwen3-8b-local
```

Trong chat:

```text
/set parameter temperature 0.2
```

Hoặc gọi API:

```json
{
  "model": "qwen3-8b-local",
  "options": {
    "temperature": 0.2,
    "num_ctx": 16384
  }
}
```

---

# Xem thông tin model

```bash
ollama show qwen3-8b-local
```

Hiển thị:

- Template
- Parameters
- Context length
- License
- System prompt

---

# Ví dụ tối ưu cho Coding

```text
FROM D:\models\qwen3-coder.gguf

PARAMETER num_ctx 32768
PARAMETER temperature 0.1
PARAMETER top_p 0.9
PARAMETER top_k 20
PARAMETER repeat_penalty 1.05

SYSTEM """
You are a senior software engineer.
Provide concise and correct code.
"""
```

---

# Ví dụ tối ưu cho RAG

```text
FROM D:\models\qwen3-8b.gguf

PARAMETER num_ctx 65536
PARAMETER temperature 0.2
PARAMETER top_p 0.9
PARAMETER repeat_penalty 1.1

SYSTEM """
Answer only from the provided context.
If the answer is not in the context, say you do not know.
"""
```

---

# Xóa model

```bash
ollama rm qwen3-8b-local
```
