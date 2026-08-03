---
description: Xây dựng và gửi HTTP requests trực tiếp từ trình duyệt. Hỗ trợ GET, POST, PUT, DELETE, headers, body. Xem response nhanh mà không cần Postman.
---

# 📡 HTTP Request Builder

Công cụ xây dựng và gửi HTTP requests trực tiếp từ trình duyệt. Hỗ trợ GET, POST, PUT, DELETE, PATCH — thêm headers, body, và xem response nhanh mà không cần mở Postman.

<div id="http-request-root">
<style>
.http-request-container {
  font-family: var(--font-body), system-ui, -apple-system, sans-serif;
  color: var(--dark);
  margin-top: 2rem;
}
.http-url-bar {
  display: flex;
  gap: 0.5rem;
  margin-bottom: 1rem;
  align-items: center;
}
.http-url-bar select {
  padding: 0.6rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-weight: 600;
  font-size: 0.9rem;
}
.http-url-bar input {
  flex: 1;
  padding: 0.6rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: monospace;
  font-size: 0.9rem;
}
.http-url-bar button {
  padding: 0.6rem 1.5rem;
  background: var(--secondary);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 600;
  font-size: 0.9rem;
  transition: opacity 0.2s;
}
.http-url-bar button:hover { opacity: 0.9; }
.http-section {
  margin-bottom: 1rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  overflow: hidden;
}
.http-section-header {
  padding: 0.5rem 1rem;
  background: rgba(0,0,0,0.05);
  cursor: pointer;
  font-weight: 600;
  font-size: 0.9rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  user-select: none;
}
.http-section-content {
  padding: 0.75rem;
}
.http-section-content textarea {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: monospace;
  font-size: 0.85rem;
  min-height: 80px;
}
.http-headers-table {
  width: 100%;
  border-collapse: collapse;
}
.http-headers-table td {
  padding: 0.25rem;
}
.http-headers-table input {
  width: 100%;
  padding: 0.4rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  background: var(--light);
  color: var(--dark);
  font-family: monospace;
  font-size: 0.85rem;
}
.http-response {
  margin-top: 1rem;
  border: 1px solid var(--gray);
  border-radius: 4px;
  padding: 1rem;
  background: var(--light);
  min-height: 100px;
  max-height: 500px;
  overflow-y: auto;
}
.http-response-status {
  display: flex;
  gap: 1rem;
  margin-bottom: 0.75rem;
  padding-bottom: 0.75rem;
  border-bottom: 1px solid var(--lightgray);
  flex-wrap: wrap;
}
.http-status-badge {
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: 600;
}
.http-status-2xx { background: #d4edda; color: #155724; }
.http-status-3xx { background: #cce5ff; color: #004085; }
.http-status-4xx { background: #fff3cd; color: #856404; }
.http-status-5xx { background: #f8d7da; color: #721c24; }
.http-response-body {
  font-family: monospace;
  font-size: 0.85rem;
  white-space: pre-wrap;
  word-break: break-all;
  background: rgba(0,0,0,0.03);
  padding: 0.75rem;
  border-radius: 4px;
}
.http-response-headers {
  font-family: monospace;
  font-size: 0.8rem;
  margin-top: 0.5rem;
}
.http-response-headers div {
  padding: 2px 0;
}
.http-response-headers .header-name {
  color: #881391;
  font-weight: bold;
}
.http-add-header-btn {
  margin-top: 0.5rem;
  padding: 0.3rem 0.6rem;
  background: #28a745;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.8rem;
}
.http-presets {
  margin-bottom: 1rem;
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}
.http-preset-btn {
  padding: 0.3rem 0.6rem;
  background: rgba(0,0,0,0.05);
  border: 1px solid var(--gray);
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.8rem;
}
.http-preset-btn:hover { background: var(--secondary); color: white; }
</style>

<div class="http-request-container">
  <div class="http-presets">
    <strong>Presets:</strong>
    <button class="http-preset-btn" onclick="setPreset('https://jsonplaceholder.typicode.com/posts/1','GET')">GET Post</button>
    <button class="http-preset-btn" onclick="setPreset('https://jsonplaceholder.typicode.com/posts','POST')">POST Post</button>
    <button class="http-preset-btn" onclick="setPreset('https://api.github.com','GET')">GitHub API</button>
    <button class="http-preset-btn" onclick="setPreset('https://httpbin.org/get','GET')">HTTPBin GET</button>
    <button class="http-preset-btn" onclick="setPreset('https://httpbin.org/post','POST')">HTTPBin POST</button>
  </div>

  <div class="http-url-bar">
    <select id="http-method">
      <option value="GET">GET</option>
      <option value="POST">POST</option>
      <option value="PUT">PUT</option>
      <option value="PATCH">PATCH</option>
      <option value="DELETE">DELETE</option>
    </select>
    <input type="text" id="http-url" placeholder="https://api.example.com/endpoint" value="https://jsonplaceholder.typicode.com/posts/1">
    <button onclick="sendRequest()">📡 Send</button>
  </div>

  <div class="http-section">
    <div class="http-section-header" onclick="toggleSection('headers-content')">
      📋 Headers <span>▼</span>
    </div>
    <div class="http-section-content" id="headers-content">
      <table class="http-headers-table" id="headers-table">
        <tr>
          <td><input type="text" placeholder="Key" value="Content-Type"></td>
          <td><input type="text" placeholder="Value" value="application/json"></td>
          <td><button onclick="this.parentElement.parentElement.remove()" style="padding:0.2rem 0.4rem;background:#dc3545;color:white;border:none;border-radius:3px;cursor:pointer;">✕</button></td>
        </tr>
      </table>
      <button class="http-add-header-btn" onclick="addHeaderRow()">+ Add Header</button>
    </div>
  </div>

  <div class="http-section">
    <div class="http-section-header" onclick="toggleSection('body-content')">
      📦 Request Body (JSON) <span>▼</span>
    </div>
    <div class="http-section-content" id="body-content">
      <textarea id="http-body" placeholder='{"key": "value"}'>{"title": "test", "body": "test body", "userId": 1}</textarea>
    </div>
  </div>

  <div class="http-response" id="http-response">
    <p style="color:#999;">Response sẽ hiển thị ở đây sau khi gửi request...</p>
  </div>
</div>

<script>
function toggleSection(id) {
  const el = document.getElementById(id);
  el.style.display = el.style.display === 'none' ? 'block' : 'none';
}

function addHeaderRow() {
  const table = document.getElementById("headers-table");
  const tr = document.createElement("tr");
  tr.innerHTML = `
    <td><input type="text" placeholder="Key"></td>
    <td><input type="text" placeholder="Value"></td>
    <td><button onclick="this.parentElement.parentElement.remove()" style="padding:0.2rem 0.4rem;background:#dc3545;color:white;border:none;border-radius:3px;cursor:pointer;">✕</button></td>
  `;
  table.appendChild(tr);
}

function setPreset(url, method) {
  document.getElementById("http-url").value = url;
  document.getElementById("http-method").value = method;
}

async function sendRequest() {
  const method = document.getElementById("http-method").value;
  const url = document.getElementById("http-url").value;
  const body = document.getElementById("http-body").value;
  const responseDiv = document.getElementById("http-response");

  if (!url.trim()) {
    responseDiv.innerHTML = '<p style="color:#dc3545;">Vui lòng nhập URL!</p>';
    return;
  }

  // Collect headers
  const headers = {};
  const headerRows = document.querySelectorAll("#headers-table tr");
  headerRows.forEach(row => {
    const inputs = row.querySelectorAll("input");
    if (inputs[0].value.trim()) {
      headers[inputs[0].value.trim()] = inputs[1].value.trim();
    }
  });

  const options = { method, headers };
  if (method !== 'GET' && method !== 'HEAD' && body.trim()) {
    options.body = body;
  }

  responseDiv.innerHTML = '<p>⏳ Đang gửi request...</p>';

  try {
    const startTime = performance.now();
    const response = await fetch(url, options);
    const endTime = performance.now();
    const duration = (endTime - startTime).toFixed(0);

    const status = response.status;
    const statusClass = status < 300 ? 'http-status-2xx' : status < 400 ? 'http-status-3xx' : status < 500 ? 'http-status-4xx' : 'http-status-5xx';
    const contentType = response.headers.get('content-type') || 'unknown';

    let responseBody = await response.text();

    // Try to format JSON
    try {
      const json = JSON.parse(responseBody);
      responseBody = JSON.stringify(json, null, 2);
    } catch (e) { /* not JSON, keep as is */ }

    // Build response headers
    let responseHeadersHtml = '';
    response.headers.forEach((value, key) => {
      responseHeadersHtml += `<div><span class="header-name">${escapeHtml(key)}:</span> ${escapeHtml(value)}</div>`;
    });

    responseDiv.innerHTML = `
      <div class="http-response-status">
        <span class="http-status-badge ${statusClass}">${status} ${response.statusText}</span>
        <span>⏱️ ${duration}ms</span>
        <span>📄 ${escapeHtml(contentType)}</span>
        <span>📏 ${responseBody.length} bytes</span>
      </div>
      <div><strong>Response Body:</strong></div>
      <div class="http-response-body">${escapeHtml(responseBody)}</div>
      <div style="margin-top:1rem;"><strong>Response Headers:</strong></div>
      <div class="http-response-headers">${responseHeadersHtml}</div>
    `;
  } catch (error) {
    responseDiv.innerHTML = `
      <div class="http-response-status">
        <span class="http-status-badge http-status-5xx">ERROR</span>
      </div>
      <div class="http-response-body" style="color:#dc3545;">${escapeHtml(error.message)}\n\n💡 Lưu ý: Một số APIs có thể bị chặn bởi CORS policy của trình duyệt. Thử dùng API public hoặc disable CORS extension.</div>
    `;
  }
}

function escapeHtml(text) {
  return String(text).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}
</script>
</div>

---

## 🚀 Hướng dẫn sử dụng
1. **Chọn Method** (GET, POST, PUT, DELETE, PATCH).
2. **Nhập URL** endpoint cần test.
3. **Thêm Headers** nếu cần (Content-Type, Authorization...).
4. **Nhập Body** (JSON) cho POST/PUT/PATCH requests.
5. Nhấn **Send** để gửi request và xem response.
6. Response hiển thị: Status code, thời gian phản hồi, content-type, body (auto-format JSON), và headers.

> 💡 **Mẹo:** Dùng công cụ này cho quick API testing mà không cần mở Postman. Perfect cho việc verify endpoint nhanh trong quá trình test. Lưu ý CORS có thể chặn một số requests — dùng các API public hoặc endpoint trên cùng domain.
