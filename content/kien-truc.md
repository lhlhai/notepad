# 🏗️ Kiến trúc Hệ thống

Ứng dụng được thiết kế theo mô hình Client-side Rendering đơn giản.

## Sơ đồ luồng dữ liệu

```mermaid
graph TD
    A[Người dùng] -->|Mở trang| B(index.html)
    B -->|Fetch API| C(notes.json)
    C -->|Hiển thị| D[Danh sách Cards]
    D -->|Click vào Card| E[Note Detail View]
    E -->|Fetch API| F(notes/*.md)
    F -->|Render| G[Marked.js + Mermaid.js]
    
    style A fill:#f9f,stroke:#333,stroke-width:2px
    style G fill:#bbf,stroke:#333,stroke-width:2px
