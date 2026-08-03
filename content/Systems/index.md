---
title: "🎨 Systems Infrastructure"
description: "Kiến thức về hệ điều hành, mạng và hạ tầng công nghệ thông tin - nền tảng để vận hành mọi ứng dụng phần mềm."
---

# 💻 Systems & Infrastructure Hub

Kiến thức về hệ điều hành, mạng và hạ tầng công nghệ thông tin - nền tảng để vận hành mọi ứng dụng phần mềm.

## 📂 Danh mục tài liệu

| Lĩnh vực | Tài liệu chi tiết |
| :--- | :--- |
| **Linux & Terminal** | **[Linux & Bash](Linux-Bash.md)**: Các lệnh shell cơ bản, quản lý file, quyền truy cập và lập trình bash script. |
| **Windows Admin** | **[Windows PowerShell](Windows-PowerShell.md)**: Tự động hóa trên Windows, quản lý dịch vụ và hệ thống qua dòng lệnh. |
| **Networking** | **[Networking & SSL](Networking-SSL.md)**: Hiểu về IP, Port, DNS và cách quản lý chứng chỉ bảo mật SSL/TLS. |

## 📅 Ứng dụng hàng ngày trong Kiểm thử

Hiểu biết về hệ thống giúp Tester điều tra lỗi (troubleshooting) sâu hơn:

*   **Đọc Log Hệ thống:** Sử dụng các lệnh như `tail -f`, `grep` trên Linux để theo dõi log server thời gian thực khi thực hiện test.
*   **Kiểm tra Kết nối:** Sử dụng `ping`, `telnet`, `curl` để xác định lỗi là do ứng dụng hay do hạ tầng mạng bị chặn (Firewall).
*   **Quản lý File & Quyền:** Xử lý các vấn đề liên quan đến upload/download file, phân quyền thư mục trên server chứa ứng dụng.

---
> 💡 **Mẹo:** Sử dụng **[Docker](../Testing/Infrastructure-Docker/Docker-for-Testers.md)** để nhanh chóng có một môi trường Linux sạch để thử nghiệm các lệnh shell.
