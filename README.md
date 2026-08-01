# Notepad

Dự án này đã được chuyển đổi sang **Quartz v5**.

## 🚀 Tính năng
- **Quartz v5 Engine**: Tốc độ cực nhanh, hỗ trợ đầy đủ Markdown Obsidian.
- **Tự động Deploy**: Tự động build và deploy lên GitHub Pages thông qua GitHub Actions.
- **Giao diện tùy chỉnh**: Cấu hình tối ưu cho việc ghi chú cá nhân.

## 🛠 Cài đặt local
1. Clone repo này.
2. Cài đặt dependencies: `npm install`
3. Chạy preview: `npx quartz build --serve`

## 📂 Cấu trúc thư mục
- `content/`: Chứa toàn bộ các file `.md` ghi chú của bạn.
- `quartz.config.yaml`: Cấu hình chính của Quartz.
- `.github/workflows/deploy.yml`: Cấu hình CI/CD.

---
Được xây dựng với [Quartz](https://quartz.jzhao.xyz/).
