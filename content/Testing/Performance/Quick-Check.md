---
title: "🌈 Performance Testing"
description: "Không cần phải là chuyên gia Performance, bạn vẫn có thể thực hiện các bài kiểm tra nhanh để đảm bảo hệ thống không b..."
---

# ⚡ Performance Testing: Quick Checks for Daily Tasks

Không cần phải là chuyên gia Performance, bạn vẫn có thể thực hiện các bài kiểm tra nhanh để đảm bảo hệ thống không bị "treo" khi có nhiều người dùng.

## 1. Kiểm tra tốc độ tải trang (Frontend Performance)
Sử dụng công cụ có sẵn trong trình duyệt để đánh giá trải nghiệm người dùng.

- **Lighthouse (Chrome DevTools):** Nhấn F12 -> Lighthouse -> Analyze page load. Tập trung vào chỉ số **LCP (Largest Contentful Paint)** - nên dưới 2.5s.
- **Network Tab:** Kiểm tra dung lượng các file ảnh, script. Nếu có file nào > 1MB, đó là một điểm cần tối ưu.

---

## 2. Load Testing đơn giản với k6 (JavaScript)
k6 là công cụ hiện đại, nhẹ nhàng và cực kỳ mạnh mẽ để test API tải.

### Script mẫu: Kiểm tra 10 người dùng ảo (VUs) trong 30 giây
```javascript
import http from 'k6/http';
import { sleep, check } from 'k6';

export const options = {
  vus: 10,
  duration: '30s',
};

export default function () {
  const res = http.get('https://api.example.com/health');
  check(res, {
    'status is 200': (r) => r.status === 200,
    'response time < 500ms': (r) => r.timings.duration < 500,
  });
  sleep(1);
}
```
**Cách chạy:** `k6 run script.js`

---

## 3. Các chỉ số cần quan tâm (Key Metrics)
Khi thực hiện test tải, hãy chú ý đến các "ngưỡng" sau để đánh giá chất lượng hệ thống:

| Chỉ số | Ngưỡng kỳ vọng | Ý nghĩa |
| :--- | :--- | :--- |
| **Response Time** | < 2s | Thời gian phản hồi trung bình cho người dùng. |
| **Throughput** | Càng cao càng tốt | Số lượng yêu cầu hệ thống xử lý được mỗi giây (RPS). |
| **Error Rate** | < 1% | Tỷ lệ yêu cầu bị lỗi khi hệ thống đang chịu tải. |
| **CPU/RAM Usage** | < 80% | Tài nguyên server tiêu thụ (cần phối hợp với Dev/DevOps để xem). |

---

## 4. Mẹo thực chiến cho Tester
Đừng bao giờ chạy Performance Test trên môi trường Production mà không có sự đồng ý của cả đội ngũ. Hãy bắt đầu với mức tải thấp và tăng dần (Ramp-up) để tìm ra "điểm gãy" (Breaking Point) của hệ thống thay vì dồn dập ngay từ đầu. Cuối cùng, luôn ghi lại cấu hình môi trường (CPU, RAM của Server) khi báo cáo kết quả để có cơ sở so sánh sau này.

---
> 💡 **AI Prompt Tip:** *"Viết một script k6 để thực hiện Stress Test cho endpoint POST /api/login với 50 người dùng ảo tăng dần trong vòng 2 phút."*
