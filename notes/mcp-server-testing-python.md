# 🧪 Hướng dẫn Test MCP Server bằng Python (FastMCP & StdioTransport)

Template code sử dụng thư viện `fastmcp` để kết nối, liệt kê tools và gọi thử MCP server qua `StdioTransport`. Rất hữu ích để debug và kiểm tra MCP server trước khi implement vào ứng dụng chính (ví dụ: Claude Desktop, Cursor, hoặc custom app).

## 1. Cài đặt Dependencies
```bash
# Cài đặt bằng pip
pip install fastmcp python-dotenv

# Hoặc nếu dùng uv (khuyến nghị)
uv pip install fastmcp python-dotenv
```

## 2. Cấu hình Environment (`.env`)
Tạo file `.env` ở cùng thư mục với script để quản lý biến môi trường an toàn:
```env
CONFLUENCE_URL=https://your-domain.atlassian.net/wiki
CONFLUENCE_PERSONAL_TOKEN=your_personal_token_here
CONFLUENCE_SSL_VERIFY=false
JIRA_URL=https://your-domain.atlassian.net
JIRA_PERSONAL_TOKEN=your_jira_token_here
JIRA_SSL_VERIFY=false
```

## 3. Script Test Boilerplate (`test_mcp.py`)
```python
import asyncio
import os
import sys
import logging
from dotenv import load_dotenv
from fastmcp import Client
from fastmcp.client.transports import StdioTransport

# Bật debug log để xem luồng giao tiếp stdio giữa client và server
logging.basicConfig(level=logging.DEBUG)
load_dotenv()

# 1. Chuẩn bị Environment Variables cho MCP Server
ENV = {
    **os.environ,
    "CONFLUENCE_URL": os.getenv("CONFLUENCE_URL", ""),
    "CONFLUENCE_PERSONAL_TOKEN": os.getenv("CONFLUENCE_PERSONAL_TOKEN", ""),
    "CONFLUENCE_SSL_VERIFY": os.getenv("CONFLUENCE_SSL_VERIFY", "false"),
    "JIRA_URL": os.getenv("JIRA_URL", ""),
    "JIRA_PERSONAL_TOKEN": os.getenv("JIRA_PERSONAL_TOKEN", ""),
    "JIRA_SSL_VERIFY": os.getenv("JIRA_SSL_VERIFY", "false"),
}

async def main():
    print("🔄 Connecting to MCP server...")
    
    # 2. Cấu hình StdioTransport
    # Thay đổi command và args tùy theo MCP server bạn muốn test
    # Ví dụ: command="npx", args=["-y", "@modelcontextprotocol/server-filesystem", "/path/to/dir"]
    transport = StdioTransport(
        command="uvx", 
        args=["mcp-atlassian"], 
        env=ENV
    )
    
    # 3. Kết nối và sử dụng Client
    async with Client(transport) as client:
        print("✅ Connected to MCP Server!\n")
        
        # --- TEST 1: Liệt kê tất cả tools có sẵn ---
        print("🔄 Listing available tools...")
        tools = await client.list_tools()
        print(f"✅ Found {len(tools)} tools:")
        for t in tools:
            print(f"  - {t.name}: {t.description}")
        print("\n" + "="*50 + "\n")
        
        # --- TEST 2: Gọi một tool cụ thể ---
        try:
            print("🔄 Calling tool: confluence_get_page...")
            result = await client.call_tool(
                "confluence_get_page", 
                {"page_id": "3340237702", "include_metadata": True}
            )
            
            if result.is_error:
                print(f"❌ Tool returned error: {result.content}")
            else:
                print(f"✅ Tool executed successfully:\n{result.content[0].text[:500]}...") # In 500 ký tự đầu
                
        except Exception as e:
            print(f"❌ Exception while calling tool: {e}")

        print("\n🔒 Done testing.")
        
    # 4. Cleanup: Kill toàn bộ process kể cả subprocess còn sót của MCP server
    # (Rất quan trọng vì StdioTransport đôi khi không tự dọn dẹp process con)
    os._exit(0)

if __name__ == "__name__":
    asyncio.run(main())
```

## 4. Cách tùy biến cho các MCP Server khác

Chỉ cần thay đổi phần `StdioTransport` là có thể test server khác ngay lập tức:

### Ví dụ 1: Test MCP Filesystem
```python
transport = StdioTransport(
    command="npx", 
    args=["-y", "@modelcontextprotocol/server-filesystem", "/tmp/test-dir"],
    env=os.environ
)
# Sau đó gọi: await client.call_tool("read_file", {"path": "/tmp/test-dir/hello.txt"})
```

### Ví dụ 2: Test MCP GitHub
```python
ENV_GH = {**os.environ, "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token"}
transport = StdioTransport(
    command="npx", 
    args=["-y", "@modelcontextprotocol/server-github"],
    env=ENV_GH
)
```

## 5. Lưu ý quan trọng khi Debug
1. **Luôn bật `logging.basicConfig(level=logging.DEBUG)`**: Giúp bạn nhìn thấy chính xác JSON-RPC messages được gửi/nhận qua `stdin`/`stdout`, rất hữu ích khi tool bị lỗi silent.
2. **Dùng `os._exit(0)` ở cuối**: Các MCP server chạy qua `StdioTransport` thường tạo ra các child process. Nếu chỉ dùng `sys.exit()` hoặc để script kết thúc bình thường, child process có thể bị treo (zombie). `os._exit(0)` ép buộc tắt toàn bộ tree process.
3. **Kiểm tra Env**: Đảm bảo các biến môi trường được pass đúng vào `env=ENV` của `StdioTransport`, vì MCP server chạy độc lập và không tự động kế thừa `os.environ` của máy host nếu không được chỉ định rõ.